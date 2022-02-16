Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BB14B83AD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbiBPJIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:08:17 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbiBPJIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:08:14 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0211A819;
        Wed, 16 Feb 2022 01:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645002482; x=1676538482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GMpbo4PDX1kLrFAMv3qqa8N7EA1Df1/SGluyKXPvkE0=;
  b=VzCiA9LfmvBuBiEATWN4vm0zsQVbJAGz7ZSgdnf39nMwGOMrwwYxxQN3
   7c6FD7f+6QeiQ6bFHGtToDryTlRRD98kl1hak1MCKgqR0iaXuWruVUWw7
   ENLDNeQShbIwztestgwp9an9dOg3w8iVYVAYXCGQtUg0WzEVf67ky3z2L
   FGihP3wqt2TxGi5X+fNezmXKoq1UnuLtiHrKJr7Z4BnYwHlf6xDz0JKlv
   /lwbiJZirGoz4Q87N3uKHCSsNddWV5D0/3wPc6h7lGCpyftxvBauc3u25
   9yyVOopmDYQE4UrQ6dXpqD+cQdKaMtK+5J/42khU1tMWEFAKxwt1UfP8o
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="275137996"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="275137996"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 01:08:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="681421546"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 16 Feb 2022 01:08:00 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 16 Feb 2022 11:07:59 +0200
Date:   Wed, 16 Feb 2022 11:07:59 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 4/4] usb: typec: Support the WUSB3801 port controller
Message-ID: <Ygy+73ql4gw6Mq2u@kuha.fi.intel.com>
References: <20220214050118.61015-1-samuel@sholland.org>
 <20220214050118.61015-5-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214050118.61015-5-samuel@sholland.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 11:01:17PM -0600, Samuel Holland wrote:
> WUSB3801 features a configurable port type, accessory detection, and
> plug orientation detection. It provides a hardware "ID" pin output for
> compatibility with USB 2.0 OTG PHYs. Add a typec class driver for it.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v3:
>  - Remove version info printout
> 
> Changes in v2:
>  - License the driver as GPL 2 only; probably best anyway as I used a
>    lot of other drivers/usb/typec code as inspiration
>  - Don't try to be clever; use `default` instead of `unreachable`
>  - Free the IRQ before unregistering the partner/port
> 
>  drivers/usb/typec/Kconfig    |  10 +
>  drivers/usb/typec/Makefile   |   1 +
>  drivers/usb/typec/wusb3801.c | 437 +++++++++++++++++++++++++++++++++++
>  3 files changed, 448 insertions(+)
>  create mode 100644 drivers/usb/typec/wusb3801.c
> 
> diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
> index ab480f38523a..74acde9fc09f 100644
> --- a/drivers/usb/typec/Kconfig
> +++ b/drivers/usb/typec/Kconfig
> @@ -88,6 +88,16 @@ config TYPEC_QCOM_PMIC
>  	  It will also enable the VBUS output to connected devices when a
>  	  DFP connection is made.
>  
> +config TYPEC_WUSB3801
> +	tristate "Willsemi WUSB3801 Type-C port controller driver"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Say Y or M here if your system has a WUSB3801 Type-C port controller.
> +
> +	  If you choose to build this driver as a dynamically linked module, the
> +	  module will be called wusb3801.ko.
> +
>  source "drivers/usb/typec/mux/Kconfig"
>  
>  source "drivers/usb/typec/altmodes/Kconfig"
> diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
> index 57870a2bd787..3b722ec28d99 100644
> --- a/drivers/usb/typec/Makefile
> +++ b/drivers/usb/typec/Makefile
> @@ -9,4 +9,5 @@ obj-$(CONFIG_TYPEC_TPS6598X)	+= tipd/
>  obj-$(CONFIG_TYPEC_HD3SS3220)	+= hd3ss3220.o
>  obj-$(CONFIG_TYPEC_QCOM_PMIC)	+= qcom-pmic-typec.o
>  obj-$(CONFIG_TYPEC_STUSB160X) 	+= stusb160x.o
> +obj-$(CONFIG_TYPEC_WUSB3801)	+= wusb3801.o
>  obj-$(CONFIG_TYPEC)		+= mux/
> diff --git a/drivers/usb/typec/wusb3801.c b/drivers/usb/typec/wusb3801.c
> new file mode 100644
> index 000000000000..e63509f8b01e
> --- /dev/null
> +++ b/drivers/usb/typec/wusb3801.c
> @@ -0,0 +1,437 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Willsemi WUSB3801 Type-C port controller driver
> + *
> + * Copyright (C) 2022 Samuel Holland <samuel@sholland.org>
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/usb/typec.h>
> +
> +#define WUSB3801_REG_DEVICE_ID		0x01
> +#define WUSB3801_REG_CTRL0		0x02
> +#define WUSB3801_REG_INT		0x03
> +#define WUSB3801_REG_STAT		0x04
> +#define WUSB3801_REG_CTRL1		0x05
> +#define WUSB3801_REG_TEST00		0x06
> +#define WUSB3801_REG_TEST01		0x07
> +#define WUSB3801_REG_TEST02		0x08
> +#define WUSB3801_REG_TEST03		0x09
> +#define WUSB3801_REG_TEST04		0x0a
> +#define WUSB3801_REG_TEST05		0x0b
> +#define WUSB3801_REG_TEST06		0x0c
> +#define WUSB3801_REG_TEST07		0x0d
> +#define WUSB3801_REG_TEST08		0x0e
> +#define WUSB3801_REG_TEST09		0x0f
> +#define WUSB3801_REG_TEST0A		0x10
> +#define WUSB3801_REG_TEST0B		0x11
> +#define WUSB3801_REG_TEST0C		0x12
> +#define WUSB3801_REG_TEST0D		0x13
> +#define WUSB3801_REG_TEST0E		0x14
> +#define WUSB3801_REG_TEST0F		0x15
> +#define WUSB3801_REG_TEST10		0x16
> +#define WUSB3801_REG_TEST11		0x17
> +#define WUSB3801_REG_TEST12		0x18
> +
> +#define WUSB3801_DEVICE_ID_VERSION_ID	GENMASK(7, 3)
> +#define WUSB3801_DEVICE_ID_VENDOR_ID	GENMASK(2, 0)
> +
> +#define WUSB3801_CTRL0_DIS_ACC_SUPPORT	BIT(7)
> +#define WUSB3801_CTRL0_TRY		GENMASK(6, 5)
> +#define WUSB3801_CTRL0_TRY_NONE		(0x0 << 5)
> +#define WUSB3801_CTRL0_TRY_SNK		(0x1 << 5)
> +#define WUSB3801_CTRL0_TRY_SRC		(0x2 << 5)
> +#define WUSB3801_CTRL0_CURRENT		GENMASK(4, 3) /* SRC */
> +#define WUSB3801_CTRL0_CURRENT_DEFAULT	(0x0 << 3)
> +#define WUSB3801_CTRL0_CURRENT_1_5A	(0x1 << 3)
> +#define WUSB3801_CTRL0_CURRENT_3_0A	(0x2 << 3)
> +#define WUSB3801_CTRL0_ROLE		GENMASK(2, 1)
> +#define WUSB3801_CTRL0_ROLE_SNK		(0x0 << 1)
> +#define WUSB3801_CTRL0_ROLE_SRC		(0x1 << 1)
> +#define WUSB3801_CTRL0_ROLE_DRP		(0x2 << 1)
> +#define WUSB3801_CTRL0_INT_MASK		BIT(0)
> +
> +#define WUSB3801_INT_ATTACHED		BIT(0)
> +#define WUSB3801_INT_DETACHED		BIT(1)
> +
> +#define WUSB3801_STAT_VBUS_DETECTED	BIT(7)
> +#define WUSB3801_STAT_CURRENT		GENMASK(6, 5) /* SNK */
> +#define WUSB3801_STAT_CURRENT_STANDBY	(0x0 << 5)
> +#define WUSB3801_STAT_CURRENT_DEFAULT	(0x1 << 5)
> +#define WUSB3801_STAT_CURRENT_1_5A	(0x2 << 5)
> +#define WUSB3801_STAT_CURRENT_3_0A	(0x3 << 5)
> +#define WUSB3801_STAT_PARTNER		GENMASK(4, 2)
> +#define WUSB3801_STAT_PARTNER_STANDBY	(0x0 << 2)
> +#define WUSB3801_STAT_PARTNER_SNK	(0x1 << 2)
> +#define WUSB3801_STAT_PARTNER_SRC	(0x2 << 2)
> +#define WUSB3801_STAT_PARTNER_AUDIO	(0x3 << 2)
> +#define WUSB3801_STAT_PARTNER_DEBUG	(0x4 << 2)
> +#define WUSB3801_STAT_ORIENTATION	GENMASK(1, 0)
> +#define WUSB3801_STAT_ORIENTATION_NONE	(0x0 << 0)
> +#define WUSB3801_STAT_ORIENTATION_CC1	(0x1 << 0)
> +#define WUSB3801_STAT_ORIENTATION_CC2	(0x2 << 0)
> +#define WUSB3801_STAT_ORIENTATION_BOTH	(0x3 << 0)
> +
> +#define WUSB3801_CTRL1_SM_RESET		BIT(0)
> +
> +#define WUSB3801_TEST01_VENDOR_SUB_ID	(BIT(8) | BIT(6))
> +
> +#define WUSB3801_TEST02_FORCE_ERR_RCY	BIT(8)
> +
> +#define WUSB3801_TEST0A_WAIT_VBUS	BIT(5)
> +
> +struct wusb3801 {
> +	struct typec_capability	cap;
> +	struct device		*dev;
> +	struct typec_partner	*partner;
> +	struct typec_port	*port;
> +	struct regmap		*regmap;
> +	struct regulator	*vbus_supply;
> +	unsigned int		partner_type;
> +	enum typec_port_type	port_type;
> +	enum typec_pwr_opmode	pwr_opmode;
> +	bool			vbus_on;
> +};
> +
> +static enum typec_role wusb3801_get_default_role(struct wusb3801 *wusb3801)
> +{
> +	switch (wusb3801->port_type) {
> +	case TYPEC_PORT_SRC:
> +		return TYPEC_SOURCE;
> +	case TYPEC_PORT_SNK:
> +		return TYPEC_SINK;
> +	case TYPEC_PORT_DRP:
> +	default:
> +		if (wusb3801->cap.prefer_role == TYPEC_SOURCE)
> +			return TYPEC_SOURCE;
> +		return TYPEC_SINK;
> +	}
> +}
> +
> +static int wusb3801_map_port_type(enum typec_port_type type)
> +{
> +	switch (type) {
> +	case TYPEC_PORT_SRC:
> +		return WUSB3801_CTRL0_ROLE_SRC;
> +	case TYPEC_PORT_SNK:
> +		return WUSB3801_CTRL0_ROLE_SNK;
> +	case TYPEC_PORT_DRP:
> +	default:
> +		return WUSB3801_CTRL0_ROLE_DRP;
> +	}
> +}
> +
> +static int wusb3801_map_pwr_opmode(enum typec_pwr_opmode mode)
> +{
> +	switch (mode) {
> +	case TYPEC_PWR_MODE_USB:
> +	default:
> +		return WUSB3801_CTRL0_CURRENT_DEFAULT;
> +	case TYPEC_PWR_MODE_1_5A:
> +		return WUSB3801_CTRL0_CURRENT_1_5A;
> +	case TYPEC_PWR_MODE_3_0A:
> +		return WUSB3801_CTRL0_CURRENT_3_0A;
> +	}
> +}
> +
> +static unsigned int wusb3801_map_try_role(int role)
> +{
> +	switch (role) {
> +	case TYPEC_NO_PREFERRED_ROLE:
> +	default:
> +		return WUSB3801_CTRL0_TRY_NONE;
> +	case TYPEC_SINK:
> +		return WUSB3801_CTRL0_TRY_SNK;
> +	case TYPEC_SOURCE:
> +		return WUSB3801_CTRL0_TRY_SRC;
> +	}
> +}
> +
> +static enum typec_orientation wusb3801_unmap_orientation(unsigned int status)
> +{
> +	switch (status & WUSB3801_STAT_ORIENTATION) {
> +	case WUSB3801_STAT_ORIENTATION_NONE:
> +	case WUSB3801_STAT_ORIENTATION_BOTH:
> +	default:
> +		return TYPEC_ORIENTATION_NONE;
> +	case WUSB3801_STAT_ORIENTATION_CC1:
> +		return TYPEC_ORIENTATION_NORMAL;
> +	case WUSB3801_STAT_ORIENTATION_CC2:
> +		return TYPEC_ORIENTATION_REVERSE;
> +	}
> +}
> +
> +static enum typec_pwr_opmode wusb3801_unmap_pwr_opmode(unsigned int status)
> +{
> +	switch (status & WUSB3801_STAT_CURRENT) {
> +	case WUSB3801_STAT_CURRENT_STANDBY:
> +	case WUSB3801_STAT_CURRENT_DEFAULT:
> +	default:
> +		return TYPEC_PWR_MODE_USB;
> +	case WUSB3801_STAT_CURRENT_1_5A:
> +		return TYPEC_PWR_MODE_1_5A;
> +	case WUSB3801_STAT_CURRENT_3_0A:
> +		return TYPEC_PWR_MODE_3_0A;
> +	}
> +}
> +
> +static int wusb3801_try_role(struct typec_port *port, int role)
> +{
> +	struct wusb3801 *wusb3801 = typec_get_drvdata(port);
> +
> +	return regmap_update_bits(wusb3801->regmap, WUSB3801_REG_CTRL0,
> +				  WUSB3801_CTRL0_TRY,
> +				  wusb3801_map_try_role(role));
> +}
> +
> +static int wusb3801_port_type_set(struct typec_port *port,
> +				  enum typec_port_type type)
> +{
> +	struct wusb3801 *wusb3801 = typec_get_drvdata(port);
> +	int ret;
> +
> +	ret = regmap_update_bits(wusb3801->regmap, WUSB3801_REG_CTRL0,
> +				 WUSB3801_CTRL0_ROLE,
> +				 wusb3801_map_port_type(type));
> +	if (ret)
> +		return ret;
> +
> +	wusb3801->port_type = type;
> +
> +	return 0;
> +}
> +
> +static const struct typec_operations wusb3801_typec_ops = {
> +	.try_role	= wusb3801_try_role,
> +	.port_type_set	= wusb3801_port_type_set,
> +};
> +
> +static int wusb3801_hw_init(struct wusb3801 *wusb3801)
> +{
> +	return regmap_write(wusb3801->regmap, WUSB3801_REG_CTRL0,
> +			    wusb3801_map_try_role(wusb3801->cap.prefer_role) |
> +			    wusb3801_map_pwr_opmode(wusb3801->pwr_opmode) |
> +			    wusb3801_map_port_type(wusb3801->port_type));
> +}
> +
> +static void wusb3801_hw_update(struct wusb3801 *wusb3801)
> +{
> +	struct typec_port *port = wusb3801->port;
> +	struct device *dev = wusb3801->dev;
> +	unsigned int partner_type, status;
> +	int ret;
> +
> +	ret = regmap_read(wusb3801->regmap, WUSB3801_REG_STAT, &status);
> +	if (ret) {
> +		dev_warn(dev, "Failed to read port status: %d\n", ret);
> +		status = 0;
> +	}
> +	dev_dbg(dev, "status = 0x%02x\n", status);
> +
> +	partner_type = status & WUSB3801_STAT_PARTNER;
> +
> +	if (partner_type == WUSB3801_STAT_PARTNER_SNK) {
> +		if (!wusb3801->vbus_on) {
> +			ret = regulator_enable(wusb3801->vbus_supply);
> +			if (ret)
> +				dev_warn(dev, "Failed to enable VBUS: %d\n", ret);
> +			wusb3801->vbus_on = true;
> +		}
> +	} else {
> +		if (wusb3801->vbus_on) {
> +			regulator_disable(wusb3801->vbus_supply);
> +			wusb3801->vbus_on = false;
> +		}
> +	}
> +
> +	if (partner_type != wusb3801->partner_type) {
> +		struct typec_partner_desc desc = {};
> +		enum typec_data_role data_role;
> +		enum typec_role pwr_role = wusb3801_get_default_role(wusb3801);
> +
> +		switch (partner_type) {
> +		case WUSB3801_STAT_PARTNER_STANDBY:
> +			break;
> +		case WUSB3801_STAT_PARTNER_SNK:
> +			pwr_role = TYPEC_SOURCE;
> +			break;
> +		case WUSB3801_STAT_PARTNER_SRC:
> +			pwr_role = TYPEC_SINK;
> +			break;
> +		case WUSB3801_STAT_PARTNER_AUDIO:
> +			desc.accessory = TYPEC_ACCESSORY_AUDIO;
> +			break;
> +		case WUSB3801_STAT_PARTNER_DEBUG:
> +			desc.accessory = TYPEC_ACCESSORY_DEBUG;
> +			break;
> +		}
> +
> +		if (wusb3801->partner) {
> +			typec_unregister_partner(wusb3801->partner);
> +			wusb3801->partner = NULL;
> +		}
> +
> +		if (partner_type != WUSB3801_STAT_PARTNER_STANDBY) {
> +			wusb3801->partner = typec_register_partner(port, &desc);
> +			if (IS_ERR(wusb3801->partner))
> +				dev_err(dev, "Failed to register partner: %ld\n",
> +					PTR_ERR(wusb3801->partner));
> +		}
> +
> +		data_role = pwr_role == TYPEC_SOURCE ? TYPEC_HOST : TYPEC_DEVICE;
> +		typec_set_data_role(port, data_role);
> +		typec_set_pwr_role(port, pwr_role);
> +		typec_set_vconn_role(port, pwr_role);
> +	}
> +
> +	typec_set_pwr_opmode(wusb3801->port,
> +			     partner_type == WUSB3801_STAT_PARTNER_SRC
> +				? wusb3801_unmap_pwr_opmode(status)
> +				: wusb3801->pwr_opmode);
> +	typec_set_orientation(wusb3801->port,
> +			      wusb3801_unmap_orientation(status));
> +
> +	wusb3801->partner_type = partner_type;
> +}
> +
> +static irqreturn_t wusb3801_irq(int irq, void *data)
> +{
> +	struct wusb3801 *wusb3801 = data;
> +	unsigned int dummy;
> +
> +	/*
> +	 * The interrupt register must be read in order to clear the IRQ,
> +	 * but all of the useful information is in the status register.
> +	 */
> +	regmap_read(wusb3801->regmap, WUSB3801_REG_INT, &dummy);
> +
> +	wusb3801_hw_update(wusb3801);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct regmap_config config = {
> +	.reg_bits	= 8,
> +	.val_bits	= 8,
> +	.max_register	= WUSB3801_REG_TEST12,
> +};
> +
> +static int wusb3801_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct fwnode_handle *connector;
> +	struct wusb3801 *wusb3801;
> +	const char *cap_str;
> +	int ret;
> +
> +	wusb3801 = devm_kzalloc(dev, sizeof(*wusb3801), GFP_KERNEL);
> +	if (!wusb3801)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, wusb3801);
> +
> +	wusb3801->dev = dev;
> +
> +	wusb3801->regmap = devm_regmap_init_i2c(client, &config);
> +	if (IS_ERR(wusb3801->regmap))
> +		return PTR_ERR(wusb3801->regmap);
> +
> +	wusb3801->vbus_supply = devm_regulator_get(dev, "vbus");
> +	if (IS_ERR(wusb3801->vbus_supply))
> +		return PTR_ERR(wusb3801->vbus_supply);
> +
> +	connector = device_get_named_child_node(dev, "connector");
> +	if (!connector)
> +		return -ENODEV;
> +
> +	ret = typec_get_fw_cap(&wusb3801->cap, connector);
> +	if (ret)
> +		goto err_put_connector;
> +	wusb3801->port_type = wusb3801->cap.type;
> +
> +	ret = fwnode_property_read_string(connector, "typec-power-opmode", &cap_str);
> +	if (ret)
> +		goto err_put_connector;
> +
> +	ret = typec_find_pwr_opmode(cap_str);
> +	if (ret < 0 || ret == TYPEC_PWR_MODE_PD)
> +		goto err_put_connector;
> +	wusb3801->pwr_opmode = ret;
> +
> +	/* Initialize the hardware with the devicetree settings. */
> +	ret = wusb3801_hw_init(wusb3801);
> +	if (ret)
> +		return ret;
> +
> +	wusb3801->cap.revision		= USB_TYPEC_REV_1_2;
> +	wusb3801->cap.accessory[0]	= TYPEC_ACCESSORY_AUDIO;
> +	wusb3801->cap.accessory[1]	= TYPEC_ACCESSORY_DEBUG;
> +	wusb3801->cap.orientation_aware	= true;
> +	wusb3801->cap.driver_data	= wusb3801;
> +	wusb3801->cap.ops		= &wusb3801_typec_ops;
> +
> +	wusb3801->port = typec_register_port(dev, &wusb3801->cap);
> +	if (IS_ERR(wusb3801->port)) {
> +		ret = PTR_ERR(wusb3801->port);
> +		goto err_put_connector;
> +	}
> +
> +	/* Initialize the port attributes from the hardware state. */
> +	wusb3801_hw_update(wusb3801);
> +
> +	ret = request_threaded_irq(client->irq, NULL, wusb3801_irq,
> +				   IRQF_ONESHOT, dev_name(dev), wusb3801);
> +	if (ret)
> +		goto err_unregister_port;
> +
> +	fwnode_handle_put(connector);
> +
> +	return 0;
> +
> +err_unregister_port:
> +	typec_unregister_port(wusb3801->port);
> +err_put_connector:
> +	fwnode_handle_put(connector);
> +
> +	return ret;
> +}
> +
> +static int wusb3801_remove(struct i2c_client *client)
> +{
> +	struct wusb3801 *wusb3801 = i2c_get_clientdata(client);
> +
> +	free_irq(client->irq, wusb3801);
> +
> +	if (wusb3801->partner)
> +		typec_unregister_partner(wusb3801->partner);
> +	typec_unregister_port(wusb3801->port);
> +
> +	if (wusb3801->vbus_on)
> +		regulator_disable(wusb3801->vbus_supply);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id wusb3801_of_match[] = {
> +	{ .compatible = "willsemi,wusb3801" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, wusb3801_of_match);
> +
> +static struct i2c_driver wusb3801_driver = {
> +	.probe_new	= wusb3801_probe,
> +	.remove		= wusb3801_remove,
> +	.driver		= {
> +		.name		= "wusb3801",
> +		.of_match_table	= wusb3801_of_match,
> +	},
> +};
> +
> +module_i2c_driver(wusb3801_driver);
> +
> +MODULE_AUTHOR("Samuel Holland <samuel@sholland.org>");
> +MODULE_DESCRIPTION("Willsemi WUSB3801 Type-C port controller driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.33.1

thanks,

-- 
heikki
