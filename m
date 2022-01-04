Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DCE484B53
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 00:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbiADXsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 18:48:13 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:37027 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiADXsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 18:48:12 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 17E1E1BF208;
        Tue,  4 Jan 2022 23:48:09 +0000 (UTC)
Date:   Wed, 5 Jan 2022 00:48:09 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     a.zummo@towertech.it, michal.simek@xilinx.com, sgoud@xilinx.com,
        shubhraj@xilinx.com, radheys@xilinx.com, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com
Subject: Re: [PATCH V3 2/2] rtc: zynqmp: Add calibration set and get support
Message-ID: <YdTcuX9q+m+GRLdk@piout.net>
References: <20211130055541.2789-1-srinivas.neeli@xilinx.com>
 <20211130055541.2789-2-srinivas.neeli@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130055541.2789-2-srinivas.neeli@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2021 11:25:41+0530, Srinivas Neeli wrote:
> Zynqmp RTC controller has a calibration feature to compensate
> time deviation due to input clock inaccuracy.
> Set and get calibration API's are used for setting and getting
> calibration value from the controller calibration register.
> 
> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
> ---
> Changes in V3:
>  -Calculated tick_mult using crystal frequency.
>  -Calibration register updating based on crystal frequency in probe.
>  -Supressed MIN an MAX calibration values,Will send separate patch in future.

I believe this should go in with this patch and it shouldn't be too
complicated to know whether the calculated value overflows the register.

> Changes in V2:
>  -Removed unused macro.
>  -Updated code with review comments.
> ---
>  drivers/rtc/rtc-zynqmp.c | 104 +++++++++++++++++++++++++++++++--------
>  1 file changed, 84 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
> index f440bb52be92..eb6ee55ca725 100644
> --- a/drivers/rtc/rtc-zynqmp.c
> +++ b/drivers/rtc/rtc-zynqmp.c
> @@ -6,6 +6,7 @@
>   *
>   */
>  
> +#include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> @@ -36,17 +37,21 @@
>  #define RTC_OSC_EN		BIT(24)
>  #define RTC_BATT_EN		BIT(31)
>  
> -#define RTC_CALIB_DEF		0x198233
> +#define RTC_CALIB_DEF		0x8000
>  #define RTC_CALIB_MASK		0x1FFFFF
>  #define RTC_ALRM_MASK          BIT(1)
>  #define RTC_MSEC               1000
> +#define RTC_FR_MASK		0xF0000
> +#define RTC_FR_MAX_TICKS	16
> +#define RTC_PPB			1000000000LL
>  
>  struct xlnx_rtc_dev {
>  	struct rtc_device	*rtc;
>  	void __iomem		*reg_base;
>  	int			alarm_irq;
>  	int			sec_irq;
> -	unsigned int		calibval;
> +	struct clk		*rtc_clk;
> +	unsigned int		freq;
>  };
>  
>  static int xlnx_rtc_set_time(struct device *dev, struct rtc_time *tm)
> @@ -61,13 +66,6 @@ static int xlnx_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  	 */
>  	new_time = rtc_tm_to_time64(tm) + 1;
>  
> -	/*
> -	 * Writing into calibration register will clear the Tick Counter and
> -	 * force the next second to be signaled exactly in 1 second period
> -	 */
> -	xrtcdev->calibval &= RTC_CALIB_MASK;
> -	writel(xrtcdev->calibval, (xrtcdev->reg_base + RTC_CALIB_WR));
> -
>  	writel(new_time, xrtcdev->reg_base + RTC_SET_TM_WR);
>  
>  	/*
> @@ -173,15 +171,71 @@ static void xlnx_init_rtc(struct xlnx_rtc_dev *xrtcdev)
>  	rtc_ctrl = readl(xrtcdev->reg_base + RTC_CTRL);
>  	rtc_ctrl |= RTC_BATT_EN;
>  	writel(rtc_ctrl, xrtcdev->reg_base + RTC_CTRL);
> +}
>  
> -	/*
> -	 * Based on crystal freq of 33.330 KHz
> -	 * set the seconds counter and enable, set fractions counter
> -	 * to default value suggested as per design spec
> -	 * to correct RTC delay in frequency over period of time.
> +static int xlnx_rtc_read_offset(struct device *dev, long *offset)
> +{
> +	struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev);
> +	long offset_val = 0;
> +	unsigned int tick_mult = RTC_PPB / xrtcdev->freq;
> +	unsigned int calibval;
> +
> +	calibval = readl(xrtcdev->reg_base + RTC_CALIB_RD);
> +	/* Offset with seconds ticks */
> +	offset_val = calibval & RTC_TICK_MASK;
> +	offset_val = offset_val - RTC_CALIB_DEF;
> +	offset_val = offset_val * tick_mult;
> +
> +	/* Offset with fractional ticks */
> +	if (calibval & RTC_FR_EN)
> +		offset_val += ((calibval & RTC_FR_MASK) >> RTC_FR_DATSHIFT)
> +			* (tick_mult / RTC_FR_MAX_TICKS);
> +	*offset = offset_val;
> +
> +	return 0;
> +}
> +
> +static int xlnx_rtc_set_offset(struct device *dev, long offset)
> +{
> +	struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev);
> +	short int  max_tick;
> +	unsigned char fract_tick = 0;
> +	unsigned int calibval;
> +	int fract_offset;
> +	unsigned int tick_mult = RTC_PPB / xrtcdev->freq;
> +
> +	/* Number ticks for given offset */
> +	max_tick = div_s64_rem(offset, tick_mult, &fract_offset);
> +
> +	/* Number fractional ticks for given offset */
> +	if (fract_offset) {
> +		if (fract_offset < 0) {
> +			fract_offset = fract_offset + tick_mult;
> +			max_tick--;
> +		}
> +		if (fract_offset > (tick_mult / RTC_FR_MAX_TICKS)) {
> +			for (fract_tick = 1; fract_tick < 16; fract_tick++) {
> +				if (fract_offset <=
> +				    (fract_tick *
> +				     (tick_mult / RTC_FR_MAX_TICKS)))
> +					break;
> +			}
> +		}
> +	}
> +
> +	/* Zynqmp RTC uses second and fractional tick
> +	 * counters for compensation
>  	 */
> -	xrtcdev->calibval &= RTC_CALIB_MASK;
> -	writel(xrtcdev->calibval, (xrtcdev->reg_base + RTC_CALIB_WR));
> +	calibval = max_tick + RTC_CALIB_DEF;
> +
> +	if (fract_tick)
> +		calibval |= RTC_FR_EN;
> +
> +	calibval |= (fract_tick << RTC_FR_DATSHIFT);
> +
> +	writel(calibval, (xrtcdev->reg_base + RTC_CALIB_WR));
> +
> +	return 0;
>  }
>  
>  static const struct rtc_class_ops xlnx_rtc_ops = {
> @@ -190,6 +244,8 @@ static const struct rtc_class_ops xlnx_rtc_ops = {
>  	.read_alarm	  = xlnx_rtc_read_alarm,
>  	.set_alarm	  = xlnx_rtc_set_alarm,
>  	.alarm_irq_enable = xlnx_rtc_alarm_irq_enable,
> +	.read_offset	  = xlnx_rtc_read_offset,
> +	.set_offset	  = xlnx_rtc_set_offset,
>  };
>  
>  static irqreturn_t xlnx_rtc_interrupt(int irq, void *id)
> @@ -255,10 +311,18 @@ static int xlnx_rtc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	ret = of_property_read_u32(pdev->dev.of_node, "calibration",
> -				   &xrtcdev->calibval);
> -	if (ret)
> -		xrtcdev->calibval = RTC_CALIB_DEF;
> +	/* Getting the rtc_clk info */
> +	xrtcdev->rtc_clk = devm_clk_get_optional(&pdev->dev, "rtc_clk");
> +	if (IS_ERR(xrtcdev->rtc_clk)) {
> +		if (PTR_ERR(xrtcdev->rtc_clk) != -EPROBE_DEFER)
> +			dev_warn(&pdev->dev, "Device clock not found.\n");
> +	}
> +	xrtcdev->freq = clk_get_rate(xrtcdev->rtc_clk);
> +	if (!xrtcdev->freq)
> +		xrtcdev->freq = RTC_CALIB_DEF;

Because you changed the value of RTC_CALIB_DEF, I think this breaks
existing DTs.

> +	ret = readl(xrtcdev->reg_base + RTC_CALIB_RD);
> +	if (!ret)
> +		writel(xrtcdev->freq, (xrtcdev->reg_base + RTC_CALIB_WR));
>  
>  	xlnx_init_rtc(xrtcdev);
>  
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
