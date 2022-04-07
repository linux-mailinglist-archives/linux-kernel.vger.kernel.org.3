Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545C04F796B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbiDGIWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiDGIWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:22:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBF72C12F;
        Thu,  7 Apr 2022 01:20:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F79CB826C8;
        Thu,  7 Apr 2022 08:20:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF33C385A4;
        Thu,  7 Apr 2022 08:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649319641;
        bh=CVCi739g5x/zPXywGSh1U5+F6QpuHM6InzCwDuQC01U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sqwmf8CknFYMhy/okNB2F2gT1ivXHjN5gyBeO4JuYcmu/ip3ju1vq0ewLKL1bX844
         p2QWBbQnG15VNjb9NOHvsnE0xARgoozDyx1ChltK3SqXyoFhgR8o42WhXzIwWglBX8
         IC69i45vgdRTOgY0U9dh5qkCrgs9UhCRKB24Cfzx21jVkEG1eyaj3FwoqpzDX6mtI0
         u1ZT/IdBhsQS1ML134FAt/ibxqxejldk58I93gL3tDMAzvhzQbx1G0JPgUT1DYPelO
         0rBMXpGzdGQQ94lYbQcVKTkFJU+8IUdghimAZTpS1xVtt7UkZozKpzGYsAPn5W9J0a
         dsg67+UFhck5Q==
Message-ID: <d41d51ff-1c61-6694-4598-d55034e8210d@kernel.org>
Date:   Thu, 7 Apr 2022 11:20:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 2/2] drivers: usb: dwc3: Add AM62 USB wrapper driver
Content-Language: en-US
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220406135214.6989-1-a-govindraju@ti.com>
 <20220406135214.6989-3-a-govindraju@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20220406135214.6989-3-a-govindraju@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aswath,

On 06/04/2022 16:52, Aswath Govindraju wrote:
> In AM62 SoC, the Designware Core USB3 IP is progammed to operate in USB2.0
> only mode. Add driver for AM62 USB DWC3 Wrapper.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
> 
> changes since v2:
> - Removed the implementation of detecting the role from the wrapper
>   driver and moved the implementation to using linux,extcon-usb-gpio
>   driver for role detection.

I'm a bit puzzled. So ID is managed by extcon-usb-gpio driver and
VBUS is managed by this driver.

So who decides the USB ports state based on the below truth table?

+	/*
+	 * ID | VBUS | STATE
+	 * -----------------
+	 * 0  | 0    | HOST
+	 * 0  | 1    | HOST
+	 * 1  | 0    | Disconnected (set mode valid to 0)
+	 * 1  | 1    | Device
+	 *
+	 */

If only ID signal is available to extcon-usb-gpio driver it cannot detect
the Disconnected state. We need to set mode valid to 0 for disconnected state.

cheers,
-roger


> - Updated the binding documentation and example to reflect the same.
> 
> 
>  drivers/usb/dwc3/Kconfig     |   9 +
>  drivers/usb/dwc3/Makefile    |   1 +
>  drivers/usb/dwc3/dwc3-am62.c | 446 +++++++++++++++++++++++++++++++++++
>  3 files changed, 456 insertions(+)
>  create mode 100644 drivers/usb/dwc3/dwc3-am62.c
> 
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index c483f28b695d..cd9a734522a7 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -159,4 +159,13 @@ config USB_DWC3_XILINX
>  	  This driver handles both ZynqMP and Versal SoC operations.
>  	  Say 'Y' or 'M' if you have one such device.
>  
> +config USB_DWC3_AM62
> +	tristate "Texas Instruments AM62 Platforms"
> +	depends on ARCH_K3 || COMPILE_TEST
> +	default USB_DWC3
> +	help
> +	  Support TI's AM62 platforms with DesignWare Core USB3 IP.
> +	  The Designware Core USB3 IP is progammed to operate in
> +	  in USB 2.0 mode only.
> +	  Say 'Y' or 'M' here if you have one such device
>  endif
> diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
> index 2d499de6f66a..9f66bd82b639 100644
> --- a/drivers/usb/dwc3/Makefile
> +++ b/drivers/usb/dwc3/Makefile
> @@ -42,6 +42,7 @@ endif
>  # and allyesconfig builds.
>  ##
>  
> +obj-$(CONFIG_USB_DWC3_AM62)		+= dwc3-am62.o
>  obj-$(CONFIG_USB_DWC3_OMAP)		+= dwc3-omap.o
>  obj-$(CONFIG_USB_DWC3_EXYNOS)		+= dwc3-exynos.o
>  obj-$(CONFIG_USB_DWC3_PCI)		+= dwc3-pci.o
> diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
> new file mode 100644
> index 000000000000..5700258c8deb
> --- /dev/null
> +++ b/drivers/usb/dwc3/dwc3-am62.c
> @@ -0,0 +1,446 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * dwc3-am62.c - TI specific Glue layer for AM62 DWC3 USB Controller
> + *
> + * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com
> + */
> +
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/workqueue.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/clk.h>
> +#include <linux/regmap.h>
> +#include <linux/devm-helpers.h>
> +#include <linux/pinctrl/consumer.h>
> +
> +/* USB WRAPPER register offsets */
> +#define USBSS_PID			0x0
> +#define USBSS_OVERCURRENT_CTRL		0x4
> +#define USBSS_PHY_CONFIG		0x8
> +#define USBSS_PHY_TEST			0xc
> +#define USBSS_CORE_STAT			0x14
> +#define USBSS_HOST_VBUS_CTRL		0x18
> +#define USBSS_MODE_CONTROL		0x1c
> +#define USBSS_WAKEUP_CONFIG		0x30
> +#define USBSS_WAKEUP_STAT		0x34
> +#define USBSS_OVERRIDE_CONFIG		0x38
> +#define USBSS_IRQ_MISC_STATUS_RAW	0x430
> +#define USBSS_IRQ_MISC_STATUS		0x434
> +#define USBSS_IRQ_MISC_ENABLE_SET	0x438
> +#define USBSS_IRQ_MISC_ENABLE_CLR	0x43c
> +#define USBSS_IRQ_MISC_EOI		0x440
> +#define USBSS_INTR_TEST			0x490
> +#define USBSS_VBUS_FILTER		0x614
> +#define USBSS_VBUS_STAT			0x618
> +#define USBSS_DEBUG_CFG			0x708
> +#define USBSS_DEBUG_DATA		0x70c
> +#define USBSS_HOST_HUB_CTRL		0x714
> +
> +/* PHY CONFIG register bits */
> +#define USBSS_PHY_VBUS_SEL_MASK		GENMASK(2, 1)
> +#define USBSS_PHY_VBUS_SEL_SHIFT	1
> +#define USBSS_PHY_LANE_REVERSE		BIT(0)
> +
> +/* MODE CONTROL register bits */
> +#define USBSS_MODE_VALID	BIT(0)
> +
> +/* WAKEUP CONFIG register bits */
> +#define USBSS_WAKEUP_CFG_OVERCURRENT_EN	BIT(3)
> +#define USBSS_WAKEUP_CFG_LINESTATE_EN	BIT(2)
> +#define USBSS_WAKEUP_CFG_SESSVALID_EN	BIT(1)
> +#define USBSS_WAKEUP_CFG_VBUSVALID_EN	BIT(0)
> +
> +/* WAKEUP STAT register bits */
> +#define USBSS_WAKEUP_STAT_OVERCURRENT	BIT(4)
> +#define USBSS_WAKEUP_STAT_LINESTATE	BIT(3)
> +#define USBSS_WAKEUP_STAT_SESSVALID	BIT(2)
> +#define USBSS_WAKEUP_STAT_VBUSVALID	BIT(1)
> +#define USBSS_WAKEUP_STAT_CLR		BIT(0)
> +
> +/* IRQ_MISC_STATUS_RAW register bits */
> +#define USBSS_IRQ_MISC_RAW_VBUSVALID	BIT(22)
> +#define USBSS_IRQ_MISC_RAW_SESSVALID	BIT(20)
> +
> +/* IRQ_MISC_STATUS register bits */
> +#define USBSS_IRQ_MISC_VBUSVALID	BIT(22)
> +#define USBSS_IRQ_MISC_SESSVALID	BIT(20)
> +
> +/* IRQ_MISC_ENABLE_SET register bits */
> +#define USBSS_IRQ_MISC_ENABLE_SET_VBUSVALID	BIT(22)
> +#define USBSS_IRQ_MISC_ENABLE_SET_SESSVALID	BIT(20)
> +
> +/* IRQ_MISC_ENABLE_CLR register bits */
> +#define USBSS_IRQ_MISC_ENABLE_CLR_VBUSVALID	BIT(22)
> +#define USBSS_IRQ_MISC_ENABLE_CLR_SESSVALID	BIT(20)
> +
> +/* IRQ_MISC_EOI register bits */
> +#define USBSS_IRQ_MISC_EOI_VECTOR	BIT(0)
> +
> +/* VBUS_STAT register bits */
> +#define USBSS_VBUS_STAT_SESSVALID	BIT(2)
> +#define USBSS_VBUS_STAT_VBUSVALID	BIT(0)
> +
> +/* Mask for PHY PLL REFCLK */
> +#define PHY_PLL_REFCLK_MASK	GENMASK(3, 0)
> +
> +#define DWC3_AM62_AUTOSUSPEND_DELAY	100
> +
> +struct dwc3_data {
> +	struct device *dev;
> +	void __iomem *usbss;
> +	struct clk *usb2_refclk;
> +	struct work_struct work;
> +	int vbus_irq;
> +	int rate_code;
> +	int connect;
> +	struct regmap *syscon;
> +	unsigned int offset;
> +	unsigned int vbus_divider;
> +};
> +
> +static const int dwc3_ti_rate_table[] = {	/* in KHZ */
> +	9600,
> +	10000,
> +	12000,
> +	19200,
> +	20000,
> +	24000,
> +	25000,
> +	26000,
> +	38400,
> +	40000,
> +	58000,
> +	50000,
> +	52000,
> +};
> +
> +static inline u32 dwc3_ti_readl(struct dwc3_data *data, u32 offset)
> +{
> +	return readl((data->usbss) + offset);
> +}
> +
> +static inline void dwc3_ti_writel(struct dwc3_data *data, u32 offset, u32 value)
> +{
> +	writel(value, (data->usbss) + offset);
> +}
> +
> +static void connect_detect_work(struct work_struct *work)
> +{
> +	struct dwc3_data *data =
> +		container_of(work, struct dwc3_data, work);
> +	u32 vbus_state, reg;
> +	int connect = 0;
> +
> +	/* Read the status for VBUS valid register */
> +	vbus_state = dwc3_ti_readl(data, USBSS_VBUS_STAT);
> +	vbus_state &= USBSS_VBUS_STAT_VBUSVALID;
> +
> +	if (vbus_state)
> +		connect = 1;
> +
> +	/* Set or clear mode valid bit based on connect or disconnect event */
> +	if (data->connect != connect) {
> +		reg = dwc3_ti_readl(data, USBSS_MODE_CONTROL);
> +		if (connect)
> +			reg |= USBSS_MODE_VALID;
> +		else
> +			reg &= ~USBSS_MODE_VALID;
> +
> +		dwc3_ti_writel(data, USBSS_MODE_CONTROL, reg);
> +		data->connect = connect;
> +	}
> +}
> +
> +static irqreturn_t connect_detect_irq_handler(int irq, void *dev_id)
> +{
> +	struct dwc3_data *data = dev_id;
> +	u32 reg;
> +
> +	/* Clear VBUS interrupt always to aviod queuing up redundant work items */
> +	reg = dwc3_ti_readl(data, USBSS_IRQ_MISC_STATUS);
> +	reg |= USBSS_IRQ_MISC_VBUSVALID;
> +	dwc3_ti_writel(data, USBSS_IRQ_MISC_STATUS, reg);
> +
> +	queue_work(system_power_efficient_wq, &data->work);
> +
> +	reg = dwc3_ti_readl(data, USBSS_IRQ_MISC_EOI);
> +	reg &= ~USBSS_IRQ_MISC_EOI_VECTOR;
> +	dwc3_ti_writel(data, USBSS_IRQ_MISC_EOI, reg);
> +	return IRQ_HANDLED;
> +}
> +
> +static int dwc3_ti_vbus_irq_setup(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct dwc3_data *data = platform_get_drvdata(pdev);
> +	int irq, ret;
> +
> +	/* Get the misc interrupt */
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_irq(dev, irq, connect_detect_irq_handler, IRQF_SHARED,
> +			       dev_name(dev), data);
> +	if (ret) {
> +		dev_err(dev, "failed to required IRQ #%d-->%d\n",
> +			irq, ret);
> +		return ret;
> +	}
> +
> +	data->vbus_irq = irq;
> +
> +	return 0;
> +}
> +
> +static int phy_syscon_pll_refclk(struct dwc3_data *data)
> +{
> +	struct device *dev = data->dev;
> +	struct device_node *node = dev->of_node;
> +	struct of_phandle_args args;
> +	struct regmap *syscon;
> +	int ret;
> +
> +	syscon = syscon_regmap_lookup_by_phandle(node, "ti,syscon-phy-pll-refclk");
> +	if (IS_ERR(syscon)) {
> +		dev_err(dev, "unable to get ti,syscon-phy-pll-refclk regmap\n");
> +		return PTR_ERR(syscon);
> +	}
> +
> +	data->syscon = syscon;
> +
> +	ret = of_parse_phandle_with_fixed_args(node, "ti,syscon-phy-pll-refclk", 1,
> +					       0, &args);
> +	if (ret)
> +		return ret;
> +
> +	data->offset = args.args[0];
> +
> +	ret = regmap_update_bits(data->syscon, data->offset, PHY_PLL_REFCLK_MASK, data->rate_code);
> +	if (ret) {
> +		dev_err(dev, "failed to set phy pll reference clock rate\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void dwc3_ti_enable_irqs(struct dwc3_data *data)
> +{
> +	u32 reg;
> +
> +	/* enable VBUSVALID interrupt */
> +	reg = dwc3_ti_readl(data, USBSS_IRQ_MISC_ENABLE_SET);
> +	reg |= USBSS_IRQ_MISC_ENABLE_SET_VBUSVALID;
> +	dwc3_ti_writel(data, USBSS_IRQ_MISC_ENABLE_SET, reg);
> +}
> +
> +static void dwc3_ti_disable_irqs(struct dwc3_data *data)
> +{
> +	u32 reg;
> +
> +	/* disable VBUSVALID interrupt */
> +	reg = dwc3_ti_readl(data, USBSS_IRQ_MISC_ENABLE_CLR);
> +	reg |= USBSS_IRQ_MISC_ENABLE_CLR_VBUSVALID;
> +	dwc3_ti_writel(data, USBSS_IRQ_MISC_ENABLE_CLR, reg);
> +}
> +
> +static int dwc3_ti_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = pdev->dev.of_node;
> +	struct dwc3_data *data;
> +	int i, ret;
> +	unsigned long rate;
> +	u32 reg;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->dev = dev;
> +	platform_set_drvdata(pdev, data);
> +
> +	data->usbss = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(data->usbss)) {
> +		dev_err(dev, "can't map IOMEM resource\n");
> +		return PTR_ERR(data->usbss);
> +	}
> +
> +	data->usb2_refclk = devm_clk_get(dev, "ref");
> +	if (IS_ERR(data->usb2_refclk)) {
> +		dev_err(dev, "can't get usb2_refclk\n");
> +		return PTR_ERR(data->usb2_refclk);
> +	}
> +
> +	/* Calculate the rate code */
> +	rate = clk_get_rate(data->usb2_refclk);
> +	rate /= 1000;	// To KHz
> +	for (i = 0; i < ARRAY_SIZE(dwc3_ti_rate_table); i++) {
> +		if (dwc3_ti_rate_table[i] == rate)
> +			break;
> +	}
> +
> +	if (i == ARRAY_SIZE(dwc3_ti_rate_table)) {
> +		dev_err(dev, "unsupported usb2_refclk rate: %lu KHz\n", rate);
> +		ret = -EINVAL;
> +		goto err_clk_disable;
> +	}
> +
> +	data->rate_code = i;
> +
> +	/* Read the syscon property and set the rate code */
> +	ret = phy_syscon_pll_refclk(data);
> +	if (ret)
> +		goto err_clk_disable;
> +
> +	/* VBUS divider select */
> +	data->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
> +	reg = dwc3_ti_readl(data, USBSS_PHY_CONFIG);
> +	if (data->vbus_divider)
> +		reg |= 1 << USBSS_PHY_VBUS_SEL_SHIFT;
> +
> +	dwc3_ti_writel(data, USBSS_PHY_CONFIG, reg);
> +
> +	/* Initialize a work queue */
> +	ret = devm_work_autocancel(dev, &data->work, connect_detect_work);
> +	if (ret)
> +		goto err_clk_disable;
> +
> +	/* Read and set VBUS IRQ */
> +	ret = dwc3_ti_vbus_irq_setup(pdev);
> +	if (ret)
> +		goto err_clk_disable;
> +
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +	/*
> +	 * Don't ignore its dependencies with its children
> +	 */
> +	pm_suspend_ignore_children(dev, false);
> +	clk_prepare_enable(data->usb2_refclk);
> +	pm_runtime_get_noresume(dev);
> +
> +	ret = of_platform_populate(node, NULL, NULL, dev);
> +	if (ret) {
> +		dev_err(dev, "failed to create dwc3 core: %d\n", ret);
> +		goto err_pm_disable;
> +	}
> +
> +	/* Enable vbus irq */
> +	dwc3_ti_enable_irqs(data);
> +
> +	connect_detect_work(&data->work);
> +
> +	/* Setting up autosuspend */
> +	pm_runtime_set_autosuspend_delay(dev, DWC3_AM62_AUTOSUSPEND_DELAY);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +	return 0;
> +
> +err_pm_disable:
> +	clk_disable_unprepare(data->usb2_refclk);
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_suspended(dev);
> +err_clk_disable:
> +	clk_put(data->usb2_refclk);
> +	return ret;
> +}
> +
> +static int dwc3_ti_remove_core(struct device *dev, void *c)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +
> +	platform_device_unregister(pdev);
> +	return 0;
> +}
> +
> +static int dwc3_ti_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct dwc3_data *data = platform_get_drvdata(pdev);
> +	u32 reg;
> +
> +	dwc3_ti_disable_irqs(data);
> +
> +	device_for_each_child(dev, NULL, dwc3_ti_remove_core);
> +
> +	/* Clear mode valid bit */
> +	reg = dwc3_ti_readl(data, USBSS_MODE_CONTROL);
> +	reg &= ~USBSS_MODE_VALID;
> +	dwc3_ti_writel(data, USBSS_MODE_CONTROL, reg);
> +
> +	pm_runtime_put_sync(dev);
> +	clk_disable_unprepare(data->usb2_refclk);
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_suspended(dev);
> +
> +	clk_put(data->usb2_refclk);
> +	platform_set_drvdata(pdev, NULL);
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int dwc3_ti_suspend_common(struct device *dev)
> +{
> +	struct dwc3_data *data = dev_get_drvdata(dev);
> +
> +	/* disable irqs */
> +	dwc3_ti_disable_irqs(data);
> +
> +	clk_disable_unprepare(data->usb2_refclk);
> +
> +	return 0;
> +}
> +
> +static int dwc3_ti_resume_common(struct device *dev)
> +{
> +	struct dwc3_data *data = dev_get_drvdata(dev);
> +
> +	clk_prepare_enable(data->usb2_refclk);
> +
> +	/* Enable irqs */
> +	dwc3_ti_enable_irqs(data);
> +
> +	return 0;
> +}
> +
> +static UNIVERSAL_DEV_PM_OPS(dwc3_ti_pm_ops, dwc3_ti_suspend_common,
> +			    dwc3_ti_resume_common, NULL);
> +
> +#define DEV_PM_OPS	(&dwc3_ti_pm_ops)
> +#else
> +#define DEV_PM_OPS	NULL
> +#endif /* CONFIG_PM */
> +
> +static const struct of_device_id dwc3_ti_of_match[] = {
> +	{ .compatible = "ti,am62-usb"},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, dwc3_ti_of_match);
> +
> +static struct platform_driver dwc3_ti_driver = {
> +	.probe		= dwc3_ti_probe,
> +	.remove		= dwc3_ti_remove,
> +	.driver		= {
> +		.name	= "dwc3-am62",
> +		.pm	= DEV_PM_OPS,
> +		.of_match_table = dwc3_ti_of_match,
> +	},
> +};
> +
> +module_platform_driver(dwc3_ti_driver);
> +
> +MODULE_ALIAS("platform:dwc3-am62");
> +MODULE_AUTHOR("Aswath Govindraju <a-govindraju@ti.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("DesignWare USB3 TI Glue Layer");
