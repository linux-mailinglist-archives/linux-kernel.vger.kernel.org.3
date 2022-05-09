Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF8051FD84
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbiEINHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbiEINHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:07:36 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567272A3BF5;
        Mon,  9 May 2022 06:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652101421; x=1683637421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FbYLaIKP7g0FlMszDm+CahTMzUmE0kCgyZRfv+iusPw=;
  b=DTABlPkPDLLSJxXO+S2z6KzyLTNg5XEiiR46aiufBzrIMPNrcUkGsP5d
   ROtNWgezfbHpqdA7b6YJdidY87Up953TlmaSUgzEEG9YjRbCdS2uaz4aA
   NVdkyPsNlUA+kXea0lRMYkwTjF2W53N3gh3rg952LVm4l17Wy/cnYXXqp
   o3y41M2xK0E10ER3DJAqBLOA0dJZnnvPcWfatZTmjbLvwdHJvmbtjBhgp
   vh0hsKTRybZ4BPrkcUBvmmQR9rd2cTMTouep6+q5H/cSp75SS3dzpRm+C
   uJkH05zTEr/SV1Z7hX4hjQ6ymoEk9Rn24OBUlh+690oFf8IEw9v3by4LU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="355468918"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="355468918"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 06:03:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="710515079"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 09 May 2022 06:03:26 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 09 May 2022 16:03:26 +0300
Date:   Mon, 9 May 2022 16:03:26 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: typec: sprd: Support the SC27CC typec port
 controller
Message-ID: <YnkRHi692SJ6wlmZ@kuha.fi.intel.com>
References: <20220507092953.2273879-1-gengcixi@gmail.com>
 <20220507092953.2273879-3-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507092953.2273879-3-gengcixi@gmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, May 07, 2022 at 05:29:53PM +0800, Cixi Geng wrote:
> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> The Spreadtrum PMIC SC27xx integrated typec port controller.
> Add a typec class driver for it.
> 
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>  drivers/usb/typec/Kconfig        |  10 +
>  drivers/usb/typec/Makefile       |   1 +
>  drivers/usb/typec/sc27xx-typec.c | 554 +++++++++++++++++++++++++++++++
>  3 files changed, 565 insertions(+)
>  create mode 100644 drivers/usb/typec/sc27xx-typec.c
> 
> diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
> index ba24847fb245..3058e3a971ce 100644
> --- a/drivers/usb/typec/Kconfig
> +++ b/drivers/usb/typec/Kconfig
> @@ -111,6 +111,16 @@ config TYPEC_WUSB3801
>  	  If you choose to build this driver as a dynamically linked module, the
>  	  module will be called wusb3801.ko.
>  
> +config TYPEC_SC27XX
> +	tristate "Unisoc SC27XX Serials PMICs Type-C controller driver"
> +	depends on MFD_SC27XX_PMIC || COMPILE_TEST
> +	help
> +	  Say Y or M here if system has the Type-C port controller of PMIC
> +	  SC27XX serials.
> +
> +	  If you choose to build this driver as a dynamically linked module, the
> +	  module will be called sx27xx-typec.ko.
> +
>  source "drivers/usb/typec/mux/Kconfig"
>  
>  source "drivers/usb/typec/altmodes/Kconfig"
> diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
> index 43626acc0aaf..1df88570e10a 100644
> --- a/drivers/usb/typec/Makefile
> +++ b/drivers/usb/typec/Makefile
> @@ -11,4 +11,5 @@ obj-$(CONFIG_TYPEC_QCOM_PMIC)	+= qcom-pmic-typec.o
>  obj-$(CONFIG_TYPEC_STUSB160X) 	+= stusb160x.o
>  obj-$(CONFIG_TYPEC_RT1719)	+= rt1719.o
>  obj-$(CONFIG_TYPEC_WUSB3801)	+= wusb3801.o
> +obj-$(CONFIG_TYPEC_SC27XX)	+= sc27xx-typec.o
>  obj-$(CONFIG_TYPEC)		+= mux/
> diff --git a/drivers/usb/typec/sc27xx-typec.c b/drivers/usb/typec/sc27xx-typec.c
> new file mode 100644
> index 000000000000..6305dd9fed18
> --- /dev/null
> +++ b/drivers/usb/typec/sc27xx-typec.c
> @@ -0,0 +1,554 @@
> +// SPDX-License-Identifier: GPL
> +/*
> + * Driver for Spreadtrum SC27XX USB Type-C
> + *
> + * Copyright (C) 2022 Unisoc Inc.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/usb/typec.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/extcon.h>
> +#include <linux/kernel.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/slab.h>
> +#include <linux/extcon-provider.h>
> +
> +/* registers definitions for controller REGS_TYPEC */
> +#define SC27XX_EN			0x00
> +#define SC27XX_MODE			0x04
> +#define SC27XX_INT_EN			0x0c
> +#define SC27XX_INT_CLR			0x10
> +#define SC27XX_INT_RAW			0x14
> +#define SC27XX_INT_MASK			0x18
> +#define SC27XX_STATUS			0x1c
> +#define SC27XX_TCCDE_CNT		0x20
> +#define SC27XX_RTRIM			0x3c
> +
> +/* SC27XX_TYPEC_EN */
> +#define SC27XX_TYPEC_USB20_ONLY		BIT(4)
> +
> +/* SC27XX_TYPEC MODE */
> +#define SC27XX_MODE_SNK			0
> +#define SC27XX_MODE_SRC			1
> +#define SC27XX_MODE_DRP			2
> +#define SC27XX_MODE_MASK		3
> +
> +/* SC27XX_INT_EN */
> +#define SC27XX_ATTACH_INT_EN		BIT(0)
> +#define SC27XX_DETACH_INT_EN		BIT(1)
> +
> +/* SC27XX_INT_CLR */
> +#define SC27XX_ATTACH_INT_CLR		BIT(0)
> +#define SC27XX_DETACH_INT_CLR		BIT(1)
> +
> +/* SC27XX_INT_MASK */
> +#define SC27XX_ATTACH_INT		BIT(0)
> +#define SC27XX_DETACH_INT		BIT(1)
> +
> +#define SC27XX_STATE_MASK		GENMASK(4, 0)
> +#define SC27XX_EVENT_MASK		GENMASK(9, 0)
> +
> +#define SC2730_EFUSE_CC1_SHIFT		5
> +#define SC2730_EFUSE_CC2_SHIFT		0
> +#define SC2721_EFUSE_CC1_SHIFT		11
> +#define SC2721_EFUSE_CC2_SHIFT		6
> +#define UMP9620_EFUSE_CC1_SHIFT		1
> +#define UMP9620_EFUSE_CC2_SHIFT		11
> +
> +#define SC27XX_CC1_MASK(n)		GENMASK((n) + 9, (n) + 5)
> +#define SC27XX_CC2_MASK(n)		GENMASK((n) + 4, (n))
> +#define SC27XX_CC_SHIFT(n)		(n)
> +
> +/* sc2721 registers definitions for controller REGS_TYPEC */
> +#define SC2721_EN			0x00
> +#define SC2721_CLR			0x04
> +#define SC2721_MODE			0x08
> +
> +/* SC2721_INT_EN */
> +#define SC2721_ATTACH_INT_EN		BIT(5)
> +#define SC2721_DETACH_INT_EN		BIT(6)
> +
> +#define SC2721_STATE_MASK		GENMASK(3, 0)
> +#define SC2721_EVENT_MASK		GENMASK(6, 0)
> +
> +/* modify sc2730 tcc debunce */
> +#define SC27XX_TCC_DEBOUNCE_CNT		0xc7f
> +
> +/* sc2730 registers definitions for controller REGS_TYPEC */
> +#define SC2730_TYPEC_PD_CFG		0x08
> +/* SC2730_TYPEC_PD_CFG */
> +#define SC27XX_VCONN_LDO_EN		BIT(13)
> +#define SC27XX_VCONN_LDO_RDY		BIT(12)
> +
> +enum sc27xx_typec_connection_state {
> +	SC27XX_DETACHED_SNK,
> +	SC27XX_ATTACHWAIT_SNK,
> +	SC27XX_ATTACHED_SNK,
> +	SC27XX_DETACHED_SRC,
> +	SC27XX_ATTACHWAIT_SRC,
> +	SC27XX_ATTACHED_SRC,
> +	SC27XX_POWERED_CABLE,
> +	SC27XX_AUDIO_CABLE,
> +	SC27XX_DEBUG_CABLE,
> +	SC27XX_TOGGLE_SLEEP,
> +	SC27XX_ERR_RECOV,
> +	SC27XX_DISABLED,
> +	SC27XX_TRY_SNK,
> +	SC27XX_TRY_WAIT_SRC,
> +	SC27XX_TRY_SRC,
> +	SC27XX_TRY_WAIT_SNK,
> +	SC27XX_UNSUPOORT_ACC,
> +	SC27XX_ORIENTED_DEBUG,
> +};
> +
> +struct sprd_typec_variant_data {
> +	u32 efuse_cc1_shift;
> +	u32 efuse_cc2_shift;
> +	u32 int_en;
> +	u32 int_clr;
> +	u32 mode;
> +	u32 attach_en;
> +	u32 detach_en;
> +	u32 state_mask;
> +	u32 event_mask;
> +};
> +
> +static const struct sprd_typec_variant_data sc2730_data = {
> +	.efuse_cc1_shift = SC2730_EFUSE_CC1_SHIFT,
> +	.efuse_cc2_shift = SC2730_EFUSE_CC2_SHIFT,
> +	.int_en = SC27XX_INT_EN,
> +	.int_clr = SC27XX_INT_CLR,
> +	.mode = SC27XX_MODE,
> +	.attach_en = SC27XX_ATTACH_INT_EN,
> +	.detach_en = SC27XX_DETACH_INT_EN,
> +	.state_mask = SC27XX_STATE_MASK,
> +	.event_mask = SC27XX_EVENT_MASK,
> +};
> +
> +static const struct sprd_typec_variant_data sc2721_data = {
> +	.efuse_cc1_shift = SC2721_EFUSE_CC1_SHIFT,
> +	.efuse_cc2_shift = SC2721_EFUSE_CC2_SHIFT,
> +	.int_en = SC2721_EN,
> +	.int_clr = SC2721_CLR,
> +	.mode = SC2721_MODE,
> +	.attach_en = SC2721_ATTACH_INT_EN,
> +	.detach_en = SC2721_DETACH_INT_EN,
> +	.state_mask = SC2721_STATE_MASK,
> +	.event_mask = SC2721_EVENT_MASK,
> +};
> +
> +static const struct sprd_typec_variant_data ump9620_data = {
> +	.efuse_cc1_shift = UMP9620_EFUSE_CC1_SHIFT,
> +	.efuse_cc2_shift = UMP9620_EFUSE_CC2_SHIFT,
> +	.int_en = SC27XX_INT_EN,
> +	.int_clr = SC27XX_INT_CLR,
> +	.mode = SC27XX_MODE,
> +	.attach_en = SC27XX_ATTACH_INT_EN,
> +	.detach_en = SC27XX_DETACH_INT_EN,
> +	.state_mask = SC27XX_STATE_MASK,
> +	.event_mask = SC27XX_EVENT_MASK,
> +};
> +
> +struct sc27xx_typec {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	u32 base;
> +	int irq;
> +	struct extcon_dev *edev;
> +	bool usb20_only;
> +
> +	enum sc27xx_typec_connection_state state;
> +	enum sc27xx_typec_connection_state pre_state;
> +	struct typec_port *port;
> +	struct typec_partner *partner;
> +	struct typec_capability typec_cap;
> +	const struct sprd_typec_variant_data *var_data;
> +};
> +
> +static int sc27xx_typec_connect(struct sc27xx_typec *sc, u32 status)
> +{
> +	enum typec_data_role data_role = TYPEC_DEVICE;
> +	enum typec_role power_role = TYPEC_SOURCE;
> +	enum typec_role vconn_role = TYPEC_SOURCE;
> +	struct typec_partner_desc desc;
> +
> +	if (sc->partner)
> +		return 0;
> +
> +	switch (sc->state) {
> +	case SC27XX_ATTACHED_SNK:
> +	case SC27XX_DEBUG_CABLE:
> +		power_role = TYPEC_SINK;
> +		data_role = TYPEC_DEVICE;
> +		vconn_role = TYPEC_SINK;
> +		break;
> +	case SC27XX_ATTACHED_SRC:
> +	case SC27XX_AUDIO_CABLE:
> +		power_role = TYPEC_SOURCE;
> +		data_role = TYPEC_HOST;
> +		vconn_role = TYPEC_SOURCE;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	desc.usb_pd = 0;
> +	desc.accessory = TYPEC_ACCESSORY_NONE;
> +	desc.identity = NULL;
> +
> +	sc->partner = typec_register_partner(sc->port, &desc);
> +	if (!sc->partner)
> +		return -ENODEV;
> +
> +	typec_set_pwr_opmode(sc->port, TYPEC_PWR_MODE_USB);
> +	typec_set_pwr_role(sc->port, power_role);
> +	typec_set_data_role(sc->port, data_role);
> +	typec_set_vconn_role(sc->port, vconn_role);
> +
> +	switch (sc->state) {
> +	case SC27XX_ATTACHED_SNK:
> +	case SC27XX_DEBUG_CABLE:

You need to inform the connector class that the partner is a Debug
Accessory:

        desc.accessory = TYPEC_ACCESSORY_DEBUG;

Is there some reason why are you doing all this only after you have
registered the partner?

> +		sc->pre_state = SC27XX_ATTACHED_SNK;
> +		extcon_set_state_sync(sc->edev, EXTCON_USB, true);
> +		break;
> +	case SC27XX_ATTACHED_SRC:
> +		sc->pre_state = SC27XX_ATTACHED_SRC;
> +		extcon_set_state_sync(sc->edev, EXTCON_USB_HOST, true);
> +		break;
> +	case SC27XX_AUDIO_CABLE:

And here it's Audio Accessory:

        desc.accessory = TYPEC_ACCESSORY_AUDIO;

> +		sc->pre_state = SC27XX_AUDIO_CABLE;
> +		extcon_set_state_sync(sc->edev, EXTCON_JACK_HEADPHONE, true);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static void sc27xx_typec_disconnect(struct sc27xx_typec *sc, u32 status)
> +{
> +	typec_unregister_partner(sc->partner);
> +	sc->partner = NULL;
> +	typec_set_pwr_opmode(sc->port, TYPEC_PWR_MODE_USB);
> +	typec_set_pwr_role(sc->port, TYPEC_SINK);
> +	typec_set_data_role(sc->port, TYPEC_DEVICE);
> +	typec_set_vconn_role(sc->port, TYPEC_SINK);
> +
> +	switch (sc->pre_state) {
> +	case SC27XX_ATTACHED_SNK:
> +	case SC27XX_DEBUG_CABLE:
> +		extcon_set_state_sync(sc->edev, EXTCON_USB, false);
> +		break;
> +	case SC27XX_ATTACHED_SRC:
> +		extcon_set_state_sync(sc->edev, EXTCON_USB_HOST, false);
> +		break;
> +	case SC27XX_AUDIO_CABLE:
> +		extcon_set_state_sync(sc->edev, EXTCON_JACK_HEADPHONE, false);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +static irqreturn_t sc27xx_typec_interrupt(int irq, void *data)
> +{
> +	struct sc27xx_typec *sc = data;
> +	u32 event;
> +	int ret;
> +
> +	ret = regmap_read(sc->regmap, sc->base + SC27XX_INT_MASK, &event);
> +	if (ret)
> +		return ret;
> +
> +	event &= sc->var_data->event_mask;
> +
> +	ret = regmap_read(sc->regmap, sc->base + SC27XX_STATUS, &sc->state);
> +	if (ret)
> +		goto clear_ints;
> +
> +	sc->state &= sc->var_data->state_mask;
> +
> +	if (event & SC27XX_ATTACH_INT) {
> +		ret = sc27xx_typec_connect(sc, sc->state);
> +		if (ret)
> +			dev_warn(sc->dev, "failed to register partner\n");
> +	} else if (event & SC27XX_DETACH_INT) {
> +		sc27xx_typec_disconnect(sc, sc->state);
> +	}
> +
> +clear_ints:
> +	regmap_write(sc->regmap, sc->base + sc->var_data->int_clr, event);
> +
> +	dev_info(sc->dev, "now works as DRP and is in %d state, event %d\n",
> +		sc->state, event);
> +	return IRQ_HANDLED;
> +}
> +
> +static int sc27xx_typec_enable(struct sc27xx_typec *sc)
> +{
> +	int ret;
> +	u32 val;
> +
> +	/* Set typec mode */
> +	ret = regmap_read(sc->regmap, sc->base + sc->var_data->mode, &val);
> +	if (ret)
> +		return ret;
> +
> +	val &= ~SC27XX_MODE_MASK;
> +	switch (sc->typec_cap.type) {
> +	case TYPEC_PORT_DFP:
> +		val |= SC27XX_MODE_SRC;
> +		break;
> +	case TYPEC_PORT_UFP:
> +		val |= SC27XX_MODE_SNK;
> +		break;
> +	case TYPEC_PORT_DRP:
> +		val |= SC27XX_MODE_DRP;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_write(sc->regmap, sc->base + sc->var_data->mode, val);
> +	if (ret)
> +		return ret;
> +
> +	/* typec USB20 only flag, only work in snk mode */
> +	if (sc->typec_cap.data == TYPEC_PORT_UFP && sc->usb20_only) {
> +		ret = regmap_update_bits(sc->regmap, sc->base + SC27XX_EN,
> +					 SC27XX_TYPEC_USB20_ONLY,
> +					 SC27XX_TYPEC_USB20_ONLY);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* modify sc2730 tcc debounce to 100ms while PD signal occur at 150ms
> +	 * and effect tccde reginize.Reason is hardware signal and clk not
> +	 * accurate.
> +	 */
> +	if (sc->var_data->efuse_cc2_shift == SC2730_EFUSE_CC2_SHIFT) {
> +		ret = regmap_write(sc->regmap, sc->base + SC27XX_TCCDE_CNT,
> +				SC27XX_TCC_DEBOUNCE_CNT);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Enable typec interrupt and enable typec */
> +	ret = regmap_read(sc->regmap, sc->base + sc->var_data->int_en, &val);
> +	if (ret)
> +		return ret;
> +
> +	val |= sc->var_data->attach_en | sc->var_data->detach_en;
> +	return regmap_write(sc->regmap, sc->base + sc->var_data->int_en, val);
> +}
> +
> +static const u32 sc27xx_typec_cable[] = {
> +	EXTCON_USB,
> +	EXTCON_USB_HOST,
> +	EXTCON_JACK_HEADPHONE,
> +	EXTCON_NONE,
> +};

Please note that USB role you will need to handle with a dedicated USB
role switch (USB role device class) - I'll show you below.

The reason why that is, is because we can not use extcon with the USB
role on every type of platform that there is (the extcon component for
the role may be the "provider" but it may also be the "consumer"
depending on the platform, and that was not acceptable), but we still
need to have a single way of handling it. That is why we had to
introduce the USB Role Class in the first place.

So you can only use extcon to expose information to the user space,
and only for legacy purposes. All the information will be exposed to
the user space in any case. There is a dedicated "accessory" sysfs
attribute file for every USB Type-C partner device, and the role you
can read from the port's "data_role" sysfs attribute file.

So I'm wondering, do you need the extcon device at all?

> +static int sc27xx_typec_get_cc1_efuse(struct sc27xx_typec *sc)
> +{
> +	struct nvmem_cell *cell;
> +	u32 calib_data = 0;
> +	void *buf;
> +	size_t len;
> +
> +	cell = nvmem_cell_get(sc->dev, "typec_cc1_cal");
> +	if (IS_ERR(cell))
> +		return PTR_ERR(cell);
> +
> +	buf = nvmem_cell_read(cell, &len);
> +	nvmem_cell_put(cell);
> +
> +	if (IS_ERR(buf))
> +		return PTR_ERR(buf);
> +
> +	memcpy(&calib_data, buf, min(len, sizeof(u32)));
> +	calib_data = (calib_data & SC27XX_CC1_MASK(sc->var_data->efuse_cc1_shift))
> +			>> SC27XX_CC_SHIFT(sc->var_data->efuse_cc1_shift);
> +	kfree(buf);
> +
> +	return calib_data;
> +}
> +
> +static int sc27xx_typec_get_cc2_efuse(struct sc27xx_typec *sc)
> +{
> +	struct nvmem_cell *cell;
> +	u32 calib_data = 0;
> +	void *buf;
> +	size_t len = 0;
> +
> +	cell = nvmem_cell_get(sc->dev, "typec_cc2_cal");
> +	if (IS_ERR(cell))
> +		return PTR_ERR(cell);
> +
> +	buf = nvmem_cell_read(cell, &len);
> +	nvmem_cell_put(cell);
> +
> +	if (IS_ERR(buf))
> +		return PTR_ERR(buf);
> +
> +	memcpy(&calib_data, buf, min(len, sizeof(u32)));
> +	calib_data = (calib_data & SC27XX_CC2_MASK(sc->var_data->efuse_cc2_shift))
> +			>> SC27XX_CC_SHIFT(sc->var_data->efuse_cc2_shift);
> +	kfree(buf);
> +
> +	return calib_data;
> +}
> +
> +static int typec_set_rtrim(struct sc27xx_typec *sc)
> +{
> +	int calib_cc1;
> +	int calib_cc2;
> +	u32 rtrim;
> +
> +	calib_cc1 = sc27xx_typec_get_cc1_efuse(sc);
> +	if (calib_cc1 < 0)
> +		return calib_cc1;
> +	calib_cc2 = sc27xx_typec_get_cc2_efuse(sc);
> +	if (calib_cc2 < 0)
> +		return calib_cc2;
> +
> +	rtrim = calib_cc1 | calib_cc2<<5;
> +
> +	return regmap_write(sc->regmap, sc->base + SC27XX_RTRIM, rtrim);
> +}
> +
> +static int sc27xx_typec_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = pdev->dev.of_node;
> +	struct sc27xx_typec *sc;
> +	const struct sprd_typec_variant_data *pdata;
> +	int mode, ret;
> +
> +	pdata = of_device_get_match_data(dev);
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "No matching driver data found\n");
> +		return -EINVAL;
> +	}
> +
> +	sc = devm_kzalloc(&pdev->dev, sizeof(*sc), GFP_KERNEL);
> +	if (!sc)
> +		return -ENOMEM;
> +
> +	sc->edev = devm_extcon_dev_allocate(&pdev->dev, sc27xx_typec_cable);
> +	if (IS_ERR(sc->edev)) {
> +		dev_err(&pdev->dev, "failed to allocate extcon device\n");
> +		return PTR_ERR(sc->edev);
> +	}
> +
> +	ret = devm_extcon_dev_register(&pdev->dev, sc->edev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "can't register extcon device: %d\n", ret);
> +		return ret;
> +	}

For the USB role switch you'll need to add struct usb_role_switch
pointer to struct sc27xx_typec. After that:

        sc->sw = usb_role_switch_get(&pdev->dev);
        if (IS_ERR(sc->sw)) {
                ...
        }

Then when you detect the role (in sc27xx_typec_connect() I guess),
you can set it to the switch with usb_role_switch_set_role().

The bindings for the usb-role-switch I believe are described here:
Documentation/devicetree/bindings/usb/usb-drd.yaml

> +	sc->dev = &pdev->dev;
> +	sc->irq = platform_get_irq(pdev, 0);
> +	if (sc->irq < 0) {
> +		dev_err(sc->dev, "failed to get typec interrupt.\n");
> +		return sc->irq;
> +	}
> +
> +	sc->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!sc->regmap) {
> +		dev_err(sc->dev, "failed to get regmap.\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = of_property_read_u32(node, "reg", &sc->base);
> +	if (ret) {
> +		dev_err(dev, "failed to get reg offset!\n");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(node, "sprd,mode", &mode);
> +	if (ret) {
> +		dev_err(dev, "failed to get typec port mode type\n");
> +		return ret;
> +	}
> +
> +	if (mode < TYPEC_PORT_DFP || mode > TYPEC_PORT_DRP
> +	    || mode == TYPEC_PORT_UFP) {
> +		mode = TYPEC_PORT_UFP;
> +		sc->usb20_only = true;
> +		dev_info(dev, "usb 2.0 only is enabled\n");
> +	}
> +
> +	sc->var_data = pdata;
> +	sc->typec_cap.type = mode;
> +	sc->typec_cap.data = TYPEC_PORT_DRD;
> +	sc->typec_cap.revision = USB_TYPEC_REV_1_2;
> +	sc->typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
> +	sc->port = typec_register_port(&pdev->dev, &sc->typec_cap);
> +	if (!sc->port) {
> +		dev_err(sc->dev, "failed to register port!\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = typec_set_rtrim(sc);
> +	if (ret < 0) {
> +		dev_err(sc->dev, "failed to set typec rtrim %d\n", ret);
> +		goto error;
> +	}
> +
> +	ret = devm_request_threaded_irq(sc->dev, sc->irq, NULL,
> +					sc27xx_typec_interrupt,
> +					IRQF_EARLY_RESUME | IRQF_ONESHOT,
> +					dev_name(sc->dev), sc);
> +	if (ret) {
> +		dev_err(sc->dev, "failed to request irq %d\n", ret);
> +		goto error;
> +	}
> +
> +	ret = sc27xx_typec_enable(sc);
> +	if (ret)
> +		goto error;
> +
> +	platform_set_drvdata(pdev, sc);
> +	return 0;
> +
> +error:
> +	typec_unregister_port(sc->port);
> +	return ret;
> +}
> +
> +static int sc27xx_typec_remove(struct platform_device *pdev)
> +{
> +	struct sc27xx_typec *sc = platform_get_drvdata(pdev);
> +
> +	sc27xx_typec_disconnect(sc, 0);
> +	typec_unregister_port(sc->port);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id typec_sprd_match[] = {
> +	{.compatible = "sprd,sc2730-typec", .data = &sc2730_data},
> +	{.compatible = "sprd,sc2721-typec", .data = &sc2721_data},
> +	{.compatible = "sprd,ump96xx-typec", .data = &ump9620_data},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, typec_sprd_match);
> +
> +static struct platform_driver sc27xx_typec_driver = {
> +	.probe = sc27xx_typec_probe,
> +	.remove = sc27xx_typec_remove,
> +	.driver = {
> +		.name = "sc27xx-typec",
> +		.of_match_table = typec_sprd_match,
> +	},
> +};
> +module_platform_driver(sc27xx_typec_driver);
> +MODULE_LICENSE("GPL");
> +
> -- 
> 2.25.1

-- 
heikki
