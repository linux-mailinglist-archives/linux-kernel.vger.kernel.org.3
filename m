Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB36455C726
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbiF0NFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbiF0NFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:05:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EB4101ED;
        Mon, 27 Jun 2022 06:04:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C92EB6126B;
        Mon, 27 Jun 2022 13:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F78C3411D;
        Mon, 27 Jun 2022 13:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656335093;
        bh=9hPmVDzRXce2mhWDKn9CKz6CUuOZsres9Q/MjXeVLGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zgDw9A+9XddNQsts3liA1eUyiECs/FuVa+eO75400eVOVwBGezE0ntSuJoLs8JRXi
         s+lm3bpliTqyRlWQgw1IGmbCPPZcMYdainpj7Ab4I32TJ+wJiIHXX54mQ927NZGXk4
         PjhX0ZGxxcrWuxvhE6Ov1NYhDZWhZ61z+GbZklE4=
Date:   Mon, 27 Jun 2022 15:04:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v11 3/3] usb: typec: anx7411: Add Analogix PD ANX7411
 support
Message-ID: <Yrmq8qMbTevl/aJR@kroah.com>
References: <20220627044331.2180641-1-xji@analogixsemi.com>
 <20220627044331.2180641-3-xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627044331.2180641-3-xji@analogixsemi.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 12:43:31PM +0800, Xin Ji wrote:
> Add driver for analogix ANX7411 USB Type-C DRP port controller.
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
> V10 -> V11 : Fix Heikki's comment, code clean up
> V9  -> V10 : Rebase on the latest code
> V6  -> V7  : Fix Heikki's comment
>     Rebase on Greg's latest usb-next branch
>     Move tcpci.h to include/linux/usb/
>     Remove double definition
> V5  -> V6  : Fix Heikki's comment
> V4  -> V5  : Fix Greg h-k comment, remove DEBUG define
> V3  -> V4  : Fix compiling waring
> V2  -> V3  : Add changelog history
> V1  -> V2  : Fix compiling warning issue
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  drivers/usb/typec/Kconfig   |   11 +
>  drivers/usb/typec/Makefile  |    1 +
>  drivers/usb/typec/anx7411.c | 1296 +++++++++++++++++++++++++++++++++++
>  drivers/usb/typec/anx7411.h |  265 +++++++

Why do you need a .h file for a tiny .c file?  Please put them all
together, that makes things easier to modify over time, and review
today.

>  4 files changed, 1573 insertions(+)
>  create mode 100644 drivers/usb/typec/anx7411.c
>  create mode 100644 drivers/usb/typec/anx7411.h
> 
> diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
> index ba24847fb245..5defdfead653 100644
> --- a/drivers/usb/typec/Kconfig
> +++ b/drivers/usb/typec/Kconfig
> @@ -52,6 +52,17 @@ source "drivers/usb/typec/ucsi/Kconfig"
>  
>  source "drivers/usb/typec/tipd/Kconfig"
>  
> +config TYPEC_ANX7411
> +	tristate "Analogix ANX7411 Type-C DRP Port controller driver"
> +	depends on I2C
> +	depends on USB_ROLE_SWITCH
> +	help
> +	  Say Y or M here if your system has Analogix ANX7411 Type-C DRP Port
> +	  controller driver.
> +
> +	  If you choose to build this driver as a dynamically linked module, the
> +	  module will be called anx7411.ko.
> +
>  config TYPEC_RT1719
>  	tristate "Richtek RT1719 Sink Only Type-C controller driver"
>  	depends on USB_ROLE_SWITCH || !USB_ROLE_SWITCH
> diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
> index 2f174cd3e5df..dac5c11a3234 100644
> --- a/drivers/usb/typec/Makefile
> +++ b/drivers/usb/typec/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_TYPEC)		+= altmodes/
>  obj-$(CONFIG_TYPEC_TCPM)	+= tcpm/
>  obj-$(CONFIG_TYPEC_UCSI)	+= ucsi/
>  obj-$(CONFIG_TYPEC_TPS6598X)	+= tipd/
> +obj-$(CONFIG_TYPEC_ANX7411)	+= anx7411.o
>  obj-$(CONFIG_TYPEC_HD3SS3220)	+= hd3ss3220.o
>  obj-$(CONFIG_TYPEC_QCOM_PMIC)	+= qcom-pmic-typec.o
>  obj-$(CONFIG_TYPEC_STUSB160X) 	+= stusb160x.o
> diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
> new file mode 100644
> index 000000000000..3bf62cc26995
> --- /dev/null
> +++ b/drivers/usb/typec/anx7411.c
> @@ -0,0 +1,1296 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright(c) 2022, Analogix Semiconductor. All rights reserved.
> + *
> + */
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of_graph.h>
> +#include <linux/of_platform.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <linux/usb/pd.h>
> +#include <linux/usb/role.h>
> +#include <linux/usb/tcpci.h>
> +#include <linux/usb/typec.h>
> +#include <linux/usb/typec_dp.h>
> +#include <linux/usb/typec_mux.h>
> +#include <linux/workqueue.h>
> +#include <linux/power_supply.h>
> +
> +#include "anx7411.h"
> +
> +static u8 snk_identity[] = {
> +	LOBYTE(VID_ANALOGIX), HIBYTE(VID_ANALOGIX), 0x00, 0x82, /* snk_id_hdr */
> +	0x00, 0x00, 0x00, 0x00,                                 /* snk_cert */
> +	0x00, 0x00, LOBYTE(PID_ANALOGIX), HIBYTE(PID_ANALOGIX), /* 5snk_ama */
> +};
> +
> +static u8 dp_caps[4] = {0xC6, 0x00, 0x00, 0x00};
> +
> +static int anx7411_reg_read(struct i2c_client *client,
> +			    u8 reg_addr)
> +{
> +	return i2c_smbus_read_byte_data(client, reg_addr);
> +}
> +
> +static int anx7411_reg_block_read(struct i2c_client *client,
> +				  u8 reg_addr, u8 len, u8 *buf)
> +{
> +	return i2c_smbus_read_i2c_block_data(client, reg_addr, len, buf);
> +}
> +
> +static int anx7411_reg_write(struct i2c_client *client,
> +			     u8 reg_addr, u8 reg_val)
> +{
> +	return i2c_smbus_write_byte_data(client, reg_addr, reg_val);
> +}
> +
> +static int anx7411_reg_block_write(struct i2c_client *client,
> +				   u8 reg_addr, u8 len, u8 *buf)
> +{
> +	return i2c_smbus_write_i2c_block_data(client, reg_addr, len, buf);
> +}
> +
> +static struct anx7411_i2c_select anx7411_i2c_addr[] = {
> +	{TCPC_ADDRESS1, SPI_ADDRESS1},
> +	{TCPC_ADDRESS2, SPI_ADDRESS2},
> +	{TCPC_ADDRESS3, SPI_ADDRESS3},
> +	{TCPC_ADDRESS4, SPI_ADDRESS4},
> +};
> +
> +static int anx7411_detect_power_mode(struct anx7411_data *ctx)
> +{
> +	int ret;
> +	int mode;
> +
> +	ret = anx7411_reg_read(ctx->spi_client, REQUEST_CURRENT);
> +	if (ret < 0)
> +		return ret;
> +
> +	ctx->typec.request_current = ret * CURRENT_UNIT; /* 50ma per unit */
> +
> +	ret = anx7411_reg_read(ctx->spi_client, REQUEST_VOLTAGE);
> +	if (ret < 0)
> +		return ret;
> +
> +	ctx->typec.request_voltage = ret * VOLTAGE_UNIT; /* 100mv per unit */
> +
> +	if (ctx->psy_online == ANX7411_PSY_OFFLINE) {
> +		ctx->psy_online = ANX7411_PSY_FIXED_ONLINE;
> +		ctx->usb_type = POWER_SUPPLY_USB_TYPE_PD;
> +		power_supply_changed(ctx->psy);
> +	}
> +
> +	if (!ctx->typec.cc_orientation_valid)
> +		return 0;
> +
> +	if (ctx->typec.cc_connect == CC1_CONNECTED)
> +		mode = CC1_RP(ctx->typec.cc_status);
> +	else
> +		mode = CC2_RP(ctx->typec.cc_status);
> +	if (mode) {
> +		typec_set_pwr_opmode(ctx->typec.port, mode - 1);
> +		return 0;
> +	}
> +
> +	typec_set_pwr_opmode(ctx->typec.port, TYPEC_PWR_MODE_PD);
> +
> +	return 0;
> +}
> +
> +static int anx7411_register_partner(struct anx7411_data *ctx,
> +				    int pd, int accessory)
> +{
> +	struct typec_partner_desc desc;
> +
> +	if (ctx->typec.partner)
> +		return 0;
> +
> +	desc.usb_pd = pd;
> +	desc.accessory = accessory;
> +	desc.identity = NULL;
> +	ctx->typec.partner = typec_register_partner(ctx->typec.port, &desc);
> +	if (IS_ERR(ctx->typec.partner)) {
> +		ctx->typec.partner = NULL;
> +		return PTR_ERR(ctx->typec.partner);
> +	}
> +
> +	return 0;
> +}
> +
> +static int anx7411_detect_cc_orientation(struct anx7411_data *ctx)
> +{
> +	int ret;
> +	int cc1_rd, cc2_rd;
> +	int cc1_ra, cc2_ra;
> +	int cc1_rp, cc2_rp;
> +
> +	ret = anx7411_reg_read(ctx->spi_client, CC_STATUS);
> +	if (ret < 0)
> +		return ret;
> +
> +	ctx->typec.cc_status = ret;
> +
> +	cc1_rd = ret & CC1_RD ? 1 : 0;
> +	cc2_rd = ret & CC2_RD ? 1 : 0;
> +	cc1_ra = ret & CC1_RA ? 1 : 0;
> +	cc2_ra = ret & CC2_RA ? 1 : 0;
> +	cc1_rp = CC1_RP(ret);
> +	cc2_rp = CC2_RP(ret);
> +
> +	/* Debug cable, nothing to do */
> +	if (cc1_rd && cc2_rd) {
> +		ctx->typec.cc_orientation_valid = 0;
> +		anx7411_register_partner(ctx, 0, TYPEC_ACCESSORY_DEBUG);
> +		return 0;
> +	}
> +
> +	if (cc1_ra && cc2_ra) {
> +		ctx->typec.cc_orientation_valid = 0;
> +		anx7411_register_partner(ctx, 0, TYPEC_ACCESSORY_AUDIO);
> +		return 0;
> +	}
> +
> +	ctx->typec.cc_orientation_valid = 1;
> +
> +	anx7411_register_partner(ctx, 1, TYPEC_ACCESSORY_NONE);
> +
> +	if (cc1_rd || cc1_rp) {
> +		typec_set_orientation(ctx->typec.port, TYPEC_ORIENTATION_NORMAL);
> +		ctx->typec.cc_connect = CC1_CONNECTED;
> +	}
> +
> +	if (cc2_rd || cc2_rp) {
> +		typec_set_orientation(ctx->typec.port, TYPEC_ORIENTATION_REVERSE);
> +		ctx->typec.cc_connect = CC2_CONNECTED;
> +	}
> +
> +	return 0;
> +}
> +
> +static int anx7411_set_mux(struct anx7411_data *ctx, int pin_assignment)
> +{
> +	int mode = TYPEC_STATE_SAFE;
> +
> +	switch (pin_assignment) {
> +	case SELECT_PIN_ASSIGMENT_U:
> +		/* default 4 line USB 3.1 */
> +		mode = TYPEC_STATE_MODAL;
> +		break;
> +	case SELECT_PIN_ASSIGMENT_C:
> +	case SELECT_PIN_ASSIGMENT_E:
> +		/* 4 line DP */
> +		mode = TYPEC_STATE_SAFE;
> +		break;
> +	case SELECT_PIN_ASSIGMENT_D:
> +		/* 2 line DP, 2 line USB */
> +		mode = TYPEC_MODE_USB3;
> +		break;
> +	default:
> +		mode = TYPEC_STATE_SAFE;
> +		break;
> +	}
> +
> +	ctx->typec.pin_assignment = pin_assignment;
> +
> +	return typec_set_mode(ctx->typec.port, mode);
> +}
> +
> +static void anx7411_set_usb_role(struct anx7411_data *ctx, enum usb_role role)
> +{
> +	if (!ctx->typec.role_sw)
> +		return;
> +
> +	usb_role_switch_set_role(ctx->typec.role_sw, role);
> +}
> +
> +static int anx7411_data_role_detect(struct anx7411_data *ctx)
> +{
> +	int ret;
> +
> +	ret = anx7411_reg_read(ctx->spi_client, SYSTEM_STSTUS);
> +	if (ret < 0)
> +		return ret;
> +
> +	ctx->typec.data_role = (ret & DATA_ROLE) ? TYPEC_HOST : TYPEC_DEVICE;
> +	ctx->typec.vconn_role = (ret & VCONN_STATUS) ? TYPEC_SOURCE : TYPEC_SINK;
> +
> +	typec_set_data_role(ctx->typec.port, ctx->typec.data_role);
> +	typec_set_vconn_role(ctx->typec.port, ctx->typec.vconn_role);
> +
> +	if (ctx->typec.data_role == TYPEC_HOST)
> +		anx7411_set_usb_role(ctx, USB_ROLE_HOST);
> +	else
> +		anx7411_set_usb_role(ctx, USB_ROLE_DEVICE);
> +
> +	return 0;
> +}
> +
> +static int anx7411_power_role_detect(struct anx7411_data *ctx)
> +{
> +	int ret;
> +
> +	ret = anx7411_reg_read(ctx->spi_client, SYSTEM_STSTUS);
> +	if (ret < 0)
> +		return ret;
> +
> +	ctx->typec.power_role = (ret & SINK_STATUS) ? TYPEC_SINK : TYPEC_SOURCE;
> +
> +	if (ctx->typec.power_role == TYPEC_SOURCE) {
> +		ctx->typec.request_current = DEF_1_5A;
> +		ctx->typec.request_voltage = DEF_5V;
> +	}
> +
> +	typec_set_pwr_role(ctx->typec.port, ctx->typec.power_role);
> +
> +	return 0;
> +}
> +
> +static int anx7411_cc_status_detect(struct anx7411_data *ctx)
> +{
> +	anx7411_detect_cc_orientation(ctx);
> +	anx7411_detect_power_mode(ctx);
> +
> +	return 0;
> +}
> +
> +static int anx7411_partner_unregister_altmode(struct anx7411_data *ctx)
> +{
> +	int i;
> +
> +	ctx->typec.dp_altmode_enter = 0;
> +	ctx->typec.cust_altmode_enter = 0;
> +
> +	for (i = 0; i < MAX_ALTMODE; i++)
> +		if (ctx->typec.amode[i]) {
> +			typec_unregister_altmode(ctx->typec.amode[i]);
> +			ctx->typec.amode[i] = NULL;
> +		}
> +
> +	ctx->typec.pin_assignment = 0;
> +	return 0;
> +}
> +
> +static int anx7411_typec_register_altmode(struct anx7411_data *ctx,
> +					  int svid, int vdo)
> +{
> +	struct device *dev = &ctx->spi_client->dev;
> +	struct typec_altmode_desc desc;
> +	int i;
> +
> +	desc.svid = svid;
> +	desc.vdo = vdo;
> +
> +	for (i = 0; i < MAX_ALTMODE; i++)
> +		if (!ctx->typec.amode[i])
> +			break;
> +
> +	desc.mode = i + 1; /* start with 1 */
> +
> +	if (i >= MAX_ALTMODE) {
> +		dev_err(dev, "no altmode space for registering\n");
> +		return -ENOMEM;
> +	}
> +
> +	ctx->typec.amode[i] = typec_partner_register_altmode(ctx->typec.partner,
> +							     &desc);
> +	if (IS_ERR(ctx->typec.amode[i])) {
> +		dev_err(dev, "failed to register altmode\n");
> +		ctx->typec.amode[i] = NULL;
> +		return PTR_ERR(ctx->typec.amode);
> +	}
> +
> +	return 0;
> +}
> +
> +static int anx7411_unregister_partner(struct anx7411_data *ctx)
> +{
> +	if (ctx->typec.partner) {
> +		typec_unregister_partner(ctx->typec.partner);
> +		ctx->typec.partner = NULL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int anx7411_update_altmode(struct anx7411_data *ctx, int svid)
> +{
> +	int i;
> +
> +	if (svid == DP_SVID)
> +		ctx->typec.dp_altmode_enter = 1;
> +	else
> +		ctx->typec.cust_altmode_enter = 1;
> +
> +	for (i = 0; i < MAX_ALTMODE; i++) {
> +		if (!ctx->typec.amode[i])
> +			continue;
> +
> +		if (ctx->typec.amode[i]->svid == svid) {
> +			typec_altmode_update_active(ctx->typec.amode[i], true);
> +			typec_altmode_notify(ctx->typec.amode[i],
> +					     ctx->typec.pin_assignment,
> +					     &ctx->typec.data);
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int anx7411_register_altmode(struct anx7411_data *ctx,
> +				    bool dp_altmode, u8 *buf)
> +{
> +	int ret;
> +	int svid;
> +	int mid;
> +
> +	if (!ctx->typec.partner)
> +		return 0;
> +
> +	svid = DP_SVID;
> +	if (dp_altmode) {
> +		mid = buf[0] | (buf[1] << 8) | (buf[2] << 16) | (buf[3] << 24);
> +
> +		return anx7411_typec_register_altmode(ctx, svid, mid);
> +	}
> +
> +	svid = (buf[3] << 8) | buf[2];
> +	if ((buf[0] & VDM_CMD_AND_ACK_MASK) != (VDM_ACK | VDM_CMD_ENTER_MODE))
> +		return anx7411_update_altmode(ctx, svid);
> +
> +	if ((buf[0] & VDM_CMD_AND_ACK_MASK) != (VDM_ACK | VDM_CMD_DIS_MOD))
> +		return 0;
> +
> +	mid = buf[4] | (buf[5] << 8) | (buf[6] << 16) | (buf[7] << 24);
> +
> +	ret = anx7411_typec_register_altmode(ctx, svid, mid);
> +	if (ctx->typec.cust_altmode_enter)
> +		ret |= anx7411_update_altmode(ctx, svid);
> +
> +	return ret;
> +}
> +
> +static int anx7411_parse_cmd(struct anx7411_data *ctx, u8 type, u8 *buf, u8 len)
> +{
> +	struct device *dev = &ctx->spi_client->dev;
> +	u8 cur_50ma, vol_100mv;
> +
> +	switch (type) {
> +	case TYPE_SRC_CAP:
> +		cur_50ma = anx7411_reg_read(ctx->spi_client, REQUEST_CURRENT);
> +		vol_100mv = anx7411_reg_read(ctx->spi_client, REQUEST_VOLTAGE);
> +
> +		ctx->typec.request_voltage = vol_100mv * VOLTAGE_UNIT;
> +		ctx->typec.request_current = cur_50ma * CURRENT_UNIT;
> +
> +		ctx->psy_online = ANX7411_PSY_FIXED_ONLINE;
> +		ctx->usb_type = POWER_SUPPLY_USB_TYPE_PD;
> +		power_supply_changed(ctx->psy);
> +		break;
> +	case TYPE_SNK_CAP:
> +		break;
> +	case TYPE_SVID:
> +		break;
> +	case TYPE_SNK_IDENTITY:
> +		break;
> +	case TYPE_GET_DP_ALT_ENTER:
> +		/* DP alt mode enter success */
> +		if (buf[0])
> +			anx7411_update_altmode(ctx, DP_SVID);
> +		break;
> +	case TYPE_DP_ALT_ENTER:
> +		/* Update DP altmode */
> +		anx7411_update_altmode(ctx, DP_SVID);
> +		break;
> +	case TYPE_OBJ_REQ:
> +		anx7411_detect_power_mode(ctx);
> +		break;
> +	case TYPE_DP_CONFIGURE:
> +		anx7411_set_mux(ctx, buf[1]);
> +		break;
> +	case TYPE_DP_DISCOVER_MODES_INFO:
> +		/* Make sure discover modes valid */
> +		if (buf[0] | buf[1])
> +			/* Register DP Altmode */
> +			anx7411_register_altmode(ctx, 1, buf);
> +		break;
> +	case TYPE_VDM:
> +		/* Register other altmode */
> +		anx7411_register_altmode(ctx, 0, buf);
> +		break;
> +	default:
> +		dev_err(dev, "ignore message(0x%.02x).\n", type);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static u8 checksum(struct device *dev, u8 *buf, u8 len)
> +{
> +	u8 ret = 0;
> +	u8 i;
> +
> +	for (i = 0; i < len; i++)
> +		ret += buf[i];
> +
> +	return ret;
> +}
> +
> +static int anx7411_read_msg_ctrl_status(struct i2c_client *client)
> +{
> +	return anx7411_reg_read(client, CMD_SEND_BUF);
> +}
> +
> +static int anx7411_wait_msg_empty(struct i2c_client *client)
> +{
> +	int val;
> +
> +	return readx_poll_timeout(anx7411_read_msg_ctrl_status,
> +				  client, val, (val < 0) || (val == 0),
> +				  2000, 2000 * 150);
> +}
> +
> +static int anx7411_send_msg(struct anx7411_data *ctx, u8 type, u8 *buf, u8 size)
> +{
> +	struct device *dev = &ctx->spi_client->dev;
> +	u8 msg[MSG_LEN];

Why is this on the stack?

> +	u8 crc;
> +	int ret;
> +
> +	if (size)
> +		memcpy(&msg[MSG_RAWDATA], buf, size);

Why not just use a real structure instead of random offsets into an
array?

> +	msg[MSG_TYPE] = type;
> +	msg[MSG_HEADER] = size + 1;

Why +1?

> +
> +	crc = checksum(dev, msg, size + HEADER_LEN);
> +	msg[size + HEADER_LEN] = 0 - crc;

No error checking on the overflow of a message size?

> +
> +	ret = anx7411_wait_msg_empty(ctx->spi_client);
> +	if (ret)
> +		return ret;
> +
> +	anx7411_reg_block_write(ctx->spi_client,
> +				CMD_SEND_BUF + 1, size + HEADER_LEN,
> +				&msg[MSG_TYPE]);

You can write data on this device that comes from the stack and not
DMA-able memory?  Are you sure?

And no checking for any errors here at all?

> +	return anx7411_reg_write(ctx->spi_client, CMD_SEND_BUF,
> +				 msg[MSG_HEADER]);

If this fails, what about the previous message that succeeded?  Should
that be rolled back somehow?

> +}
> +
> +static int anx7411_process_cmd(struct anx7411_data *ctx)
> +{
> +	struct device *dev = &ctx->spi_client->dev;
> +	u8 msg[MSG_LEN];

Again off of the stack and not the heap?  Are you sure that is ok?

> +	u8 len;
> +	u8 crc;
> +
> +	/* Read message from firmware */
> +	anx7411_reg_block_read(ctx->spi_client, CMD_RECV_BUF, MSG_LEN, msg);
> +	anx7411_reg_write(ctx->spi_client, CMD_RECV_BUF, 0);

No error checking at all?

Same goes for all calls to these functions, you don't seem to ever check
that anything went wrong.  You must have reliable hardware :)

thanks,

greg k-h
