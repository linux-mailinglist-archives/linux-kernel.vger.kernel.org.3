Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088554641C3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345063AbhK3Wsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:48:54 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:41861 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344991AbhK3Wsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:48:43 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 11BBE1C0002;
        Tue, 30 Nov 2021 22:45:19 +0000 (UTC)
Date:   Tue, 30 Nov 2021 23:45:18 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        rw-r-r-0644 <r.r.qwertyuiop.r.r@gmail.com>,
        Ash Logan <ash@heyquark.com>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.ne@posteo.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/5] rtc: gamecube: Report low battery as invalid data
Message-ID: <YaapfmykL0BOHHhF@piout.net>
References: <20211014220524.9988-1-linkmauve@linkmauve.fr>
 <20211027223516.2031-1-linkmauve@linkmauve.fr>
 <20211027223516.2031-3-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211027223516.2031-3-linkmauve@linkmauve.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 28/10/2021 00:35:12+0200, Emmanuel Gil Peyrot wrote:
> I haven’t been able to test this patch as all of my consoles have a
> working RTC battery, but according to the documentation it should work
> like that.
> 
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> ---
>  drivers/rtc/rtc-gamecube.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-gamecube.c b/drivers/rtc/rtc-gamecube.c
> index e8260c82c07d..1932c6fe1301 100644
> --- a/drivers/rtc/rtc-gamecube.c
> +++ b/drivers/rtc/rtc-gamecube.c
> @@ -83,6 +83,10 @@
>  #define RTC_CONTROL0	0x21000c
>  #define RTC_CONTROL1	0x21000d
>  
> +/* RTC flags */
> +#define RTC_CONTROL0_UNSTABLE_POWER	0x00000800
> +#define RTC_CONTROL0_LOW_BATTERY	0x00000200
> +
>  struct priv {
>  	struct regmap *regmap;
>  	void __iomem *iob;
> @@ -182,9 +186,35 @@ static int gamecube_rtc_set_time(struct device *dev, struct rtc_time *t)
>  	return regmap_write(d->regmap, RTC_COUNTER, timestamp - d->rtc_bias);
>  }
>  
> +static int gamecube_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
> +{
> +	struct priv *d = dev_get_drvdata(dev);
> +	int value;
> +	int control0;
> +	int ret;
> +
> +	switch (cmd) {
> +	case RTC_VL_READ:
> +		ret = regmap_read(d->regmap, RTC_CONTROL0, &control0);
> +		if (ret)
> +			return ret;
> +
> +		value = 0;
> +		if (control0 & RTC_CONTROL0_UNSTABLE_POWER)
> +			value |= RTC_VL_DATA_INVALID;
> +		if (control0 & RTC_CONTROL0_LOW_BATTERY)
> +			value |= RTC_VL_DATA_INVALID;

Shouldn't that one be RTC_VL_BACKUP_LOW?

Else, the driver is great, I'm ready to apply it.

> +		return put_user(value, (unsigned int __user *)arg);
> +
> +	default:
> +		return -ENOIOCTLCMD;
> +	}
> +}
> +
>  static const struct rtc_class_ops gamecube_rtc_ops = {
>  	.read_time	= gamecube_rtc_read_time,
>  	.set_time	= gamecube_rtc_set_time,
> +	.ioctl		= gamecube_rtc_ioctl,
>  };
>  
>  static int gamecube_rtc_read_offset_from_sram(struct priv *d)
> -- 
> 2.33.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
