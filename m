Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4174CA461
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241660AbiCBMES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241654AbiCBMEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:04:16 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE5251E67;
        Wed,  2 Mar 2022 04:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646222613; x=1677758613;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=68K16nujGDCTSNjCY8/TpmteZ29qZKod6wKiz0CeOmg=;
  b=el+5zE53osCLDu/dgvkOB+DrUHR5TjS5MkkSvn80VBanzGJmDPVW7aJ/
   /qpet0zRPGtB/3IXrTilgOjbInQzOgpQi66YELiTprwIEQEjC/+1Ulv09
   fWWLA20FgnVctuz+Auw2EOc8V7sWkmzYcpdIVxiWCqnZI21XKn3Zkiv97
   FRXiaqegE81+VybsI3o8xaLbpTHPQyaTTfgZo2fEYE4xmb6VcviyzRa4R
   2yxLVAlVbmfajgHDgwfsY36lswOlwdQe17k2w4BBOWJOE9Z1bxAh1ej5P
   jK5x6feYKBZjlDlz4fZ2kL2OJcT8m0qnDJliIHsgt9qnWxlb9Y4Cgbayz
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="253308475"
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="253308475"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 04:03:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="686115463"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 02 Mar 2022 04:03:19 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 02 Mar 2022 14:03:18 +0200
Date:   Wed, 2 Mar 2022 14:03:18 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v6 2/2] usb: typec: anx7411: Add Analogix PD ANX7411
 support
Message-ID: <Yh9dBlrWm3OicQWa@kuha.fi.intel.com>
References: <20220223102353.3833578-1-xji@analogixsemi.com>
 <20220223102353.3833578-2-xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223102353.3833578-2-xji@analogixsemi.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This does not apply on top of Greg's latest usb-next branch. You need
to rebase this. There are also a few more nitpicks below.

On Wed, Feb 23, 2022 at 06:23:52PM +0800, Xin Ji wrote:
> diff --git a/drivers/usb/typec/anx7411.h b/drivers/usb/typec/anx7411.h
> new file mode 100644
> index 000000000000..cc0b7a570438
> --- /dev/null
> +++ b/drivers/usb/typec/anx7411.h
> @@ -0,0 +1,273 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +/*
> + * Copyright(c) 2022, Analogix Semiconductor. All rights reserved.
> + *
> + */
> +
> +#ifndef __ANX7411_H__
> +#define __ANX7411_H__
> +
> +#define TCPC_ADDRESS1		0x58
> +#define TCPC_ADDRESS2		0x56
> +#define TCPC_ADDRESS3		0x54
> +#define TCPC_ADDRESS4		0x52
> +#define SPI_ADDRESS1		0x7e
> +#define SPI_ADDRESS2		0x6e
> +#define SPI_ADDRESS3		0x64
> +#define SPI_ADDRESS4		0x62
> +
> +struct anx7411_i2c_select {
> +	u8 tcpc_address;
> +	u8 spi_address;
> +};
> +
> +#define VENDOR_ID		0x1F29
> +#define PRODUCT_ID		0x7411

Please make that VENDOR_ID_<vendor name>, and the same with the
product ID.

> +/* TCPC register define */
> +
> +#define TCPC_ROLE_CONTROL	0x1A
> +
> +#define TCPC_COMMAND		0x23
> +#define TCPC_CMD_I2C_IDLE	0xFF
> +#define TCPC_CMD_LOOK4CONN	0x99
> +#define SINK_CTRL_EN		0x55
> +#define SINK_CTRL_DIS		0x44
> +
> +#define ANALOG_CTRL_10		0xAA

Those are TCPC commands and registers. I though I already asked that
you move the register and command definitions from
drivers/usb/typec/tcpm/tcpci.h to include/linux/usb/tcpci.h?

You need to do that in a separate patch, but I really think it would
be worth doing, even though there are only a few shared definitions
here.

> +#define STATUS_LEN		2
> +#define ALERT_0			0xCB
> +#define RECEIVED_MSG		BIT(7)
> +#define SOFTWARE_INT		BIT(6)
> +#define MSG_LEN			32
> +#define HEADER_LEN		2
> +#define MSG_HEADER		0x00
> +#define MSG_TYPE		0x01
> +#define MSG_RAWDATA		0x02
> +#define MSG_LEN_MASK		0x1F
> +
> +#define ALERT_1			0xCC
> +#define INTP_POW_ON		BIT(7)
> +#define INTP_POW_OFF		BIT(6)
> +
> +#define VBUS_THRESHOLD_H	0xDD
> +#define VBUS_THRESHOLD_L	0xDE
> +
> +#define FW_CTRL_0		0xF0
> +#define UNSTRUCT_VDM_EN		BIT(0)
> +#define DELAY_200MS		BIT(1)
> +#define VSAFE0			0
> +#define VSAFE1			BIT(2)
> +#define VSAFE2			BIT(3)
> +#define VSAFE3			(BIT(2) | BIT(3))
> +#define FRS_EN			BIT(7)
> +
> +#define FW_PARAM		0xF1
> +#define DONGLE_IOP		BIT(0)
> +
> +#define FW_CTRL_2		0xF7
> +#define SINK_CTRL_DIS_FLAG	BIT(5)
> +
> +/* SPI register define */
> +#define OCM_CTRL_0		0x6E
> +#define OCM_RESET		BIT(6)
> +
> +#define MAX_VOLTAGE		0xAC
> +#define MAX_POWER		0xAD
> +#define MIN_POWER		0xAE
> +
> +#define REQUEST_VOLTAGE		0xAF
> +#define VOLTAGE_UNIT		100 /* mV per unit */
> +
> +#define REQUEST_CURRENT		0xB1
> +#define CURRENT_UNIT		50 /* mA per unit */
> +
> +#define CMD_SEND_BUF		0xC0
> +#define CMD_RECV_BUF		0xE0
> +
> +#define REQ_VOL_20V_IN_100MV	0xC8
> +#define REQ_CUR_2_25A_IN_50MA	0x2D
> +#define REQ_CUR_3_25A_IN_50MA	0x41
> +
> +#define DEF_5V			5000
> +#define DEF_1_5A		1500
> +
> +enum anx7411_typec_message_type {
> +	TYPE_SRC_CAP = 0x00,
> +	TYPE_SNK_CAP = 0x01,
> +	TYPE_SNK_IDENTITY = 0x02,
> +	TYPE_SVID = 0x03,
> +	TYPE_SET_SNK_DP_CAP = 0x08,
> +	TYPE_PSWAP_REQ = 0x10,
> +	TYPE_DSWAP_REQ = 0x11,
> +	TYPE_VDM = 0x14,
> +	TYPE_OBJ_REQ = 0x16,
> +	TYPE_DP_ALT_ENTER = 0x19,
> +	TYPE_DP_DISCOVER_MODES_INFO = 0x27,
> +	TYPE_GET_DP_CONFIG = 0x29,
> +	TYPE_DP_CONFIGURE = 0x2A,
> +	TYPE_GET_DP_DISCOVER_MODES_INFO = 0x2E,
> +	TYPE_GET_DP_ALT_ENTER = 0x2F,
> +};
> +
> +#define REQUEST_CURRENT		0xB1
> +#define REQUEST_VOLTAGE		0xAF

Double definition - you already defined those two in this same file
above.

> +#define FW_CTRL_1		0xB2
> +#define AUTO_PD_EN		BIT(1)
> +#define TRYSRC_EN		BIT(2)
> +#define TRYSNK_EN		BIT(3)
> +#define FORCE_SEND_RDO		BIT(6)
> +
> +#define FW_VER			0xB4
> +#define FW_SUBVER		0xB5
> +
> +#define INT_MASK		0xB6
> +#define INT_STS			0xB7
> +#define OCM_BOOT_UP		BIT(0)
> +#define OC_OV_EVENT		BIT(1)
> +#define VCONN_CHANGE		BIT(2)
> +#define VBUS_CHANGE		BIT(3)
> +#define CC_STATUS_CHANGE	BIT(4)
> +#define DATA_ROLE_CHANGE	BIT(5)
> +#define PR_CONSUMER_GOT_POWER	BIT(6)
> +#define HPD_STATUS_CHANGE	BIT(7)
> +
> +#define SYSTEM_STSTUS		0xB8
> +/* 0: SINK off; 1: SINK on */
> +#define SINK_STATUS		BIT(1)
> +/* 0: VCONN off; 1: VCONN on*/
> +#define VCONN_STATUS		BIT(2)
> +/* 0: vbus off; 1: vbus on*/
> +#define VBUS_STATUS		BIT(3)
> +/* 1: host; 0:device*/
> +#define DATA_ROLE		BIT(5)
> +/* 0: Chunking; 1: Unchunked*/
> +#define SUPPORT_UNCHUNKING	BIT(6)
> +/* 0: HPD low; 1: HPD high*/
> +#define HPD_STATUS		BIT(7)
> +
> +#define DATA_DFP		1
> +#define DATA_UFP		2
> +#define POWER_SOURCE		1
> +#define POWER_SINK		2
> +
> +#define CC_STATUS		0xB9
> +#define CC1_RD			BIT(0)
> +#define CC2_RD			BIT(4)
> +#define CC1_RA			BIT(1)
> +#define CC2_RA			BIT(5)
> +#define CC1_RD			BIT(0)
> +#define CC1_RP(cc)		(((cc) >> 2) & 0x03)
> +#define CC2_RP(cc)		(((cc) >> 6) & 0x03)
> +
> +#define PD_REV_INIT		0xBA
> +
> +#define PD_EXT_MSG_CTRL		0xBB
> +#define SRC_CAP_EXT_REPLY	BIT(0)
> +#define MANUFACTURER_INFO_REPLY	BIT(1)
> +#define BATTERY_STS_REPLY	BIT(2)
> +#define BATTERY_CAP_REPLY	BIT(3)
> +#define ALERT_REPLY		BIT(4)
> +#define STATUS_REPLY		BIT(5)
> +#define PPS_STATUS_REPLY	BIT(6)
> +#define SNK_CAP_EXT_REPLY	BIT(7)
> +
> +#define NO_CONNECT		0x00
> +#define USB3_1_CONNECTED	0x01
> +#define DP_ALT_4LANES		0x02
> +#define USB3_1_DP_2LANES	0x03
> +#define CC1_CONNECTED		0x01
> +#define CC2_CONNECTED		0x02
> +#define SELECT_PIN_ASSIGMENT_C	0x04
> +#define SELECT_PIN_ASSIGMENT_D	0x08
> +#define SELECT_PIN_ASSIGMENT_E	0x10
> +#define SELECT_PIN_ASSIGMENT_U	0x00
> +#define REDRIVER_ADDRESS	0x20
> +#define REDRIVER_OFFSET		0x00
> +
> +#define DP_SVID			0xFF01
> +#define VDM_ACK			0x40
> +#define VDM_CMD_RES		0x00
> +#define VDM_CMD_DIS_ID		0x01
> +#define VDM_CMD_DIS_SVID	0x02
> +#define VDM_CMD_DIS_MOD		0x03
> +#define VDM_CMD_ENTER_MODE	0x04
> +#define VDM_CMD_EXIT_MODE	0x05
> +#define VDM_CMD_ATTENTION	0x06
> +#define VDM_CMD_GET_STS		0x10
> +#define VDM_CMD_AND_ACK_MASK	0x5F
> +
> +#define MAX_ALTMODE		2
> +
> +#define HAS_SOURCE_CAP		BIT(0)
> +#define HAS_SINK_CAP		BIT(1)
> +#define HAS_SINK_WATT		BIT(2)
> +
> +enum anx7411_psy_state {
> +	/* copy from drivers/usb/typec/tcpm */
> +	ANX7411_PSY_OFFLINE = 0,
> +	ANX7411_PSY_FIXED_ONLINE,
> +
> +	/* private */
> +	/* PD keep in, but disconnct power to bq25700,
> +	 * this state can be active when higher capacity adapter plug in,
> +	 * and change to ONLINE state when higher capacity adapter plug out
> +	 */
> +	ANX7411_PSY_HANG = 0xff,
> +};
> +
> +struct typec_params {
> +	int request_current; /* ma */
> +	int request_voltage; /* mv */
> +	int cc_connect;
> +	int cc_orientation_valid;
> +	int cc_status;
> +	int data_role;
> +	int power_role;
> +	int vconn_role;
> +	int dp_altmode_enter;
> +	int cust_altmode_enter;
> +	struct usb_role_switch *role_sw;
> +	struct typec_port *port;
> +	struct typec_partner *partner;
> +	struct typec_mux *typec_mux;
> +	struct typec_switch *typec_switch;
> +	struct typec_altmode *amode[MAX_ALTMODE];
> +	struct typec_altmode *port_amode[MAX_ALTMODE];
> +	struct typec_displayport_data data;
> +	int pin_assignment;
> +	struct typec_capability caps;
> +	u32 src_pdo[PDO_MAX_OBJECTS];
> +	u32 sink_pdo[PDO_MAX_OBJECTS];
> +	u8 caps_flags;
> +	u8 src_pdo_nr;
> +	u8 sink_pdo_nr;
> +	u8 sink_watt;
> +	u8 sink_voltage;
> +};
> +
> +struct anx7411_data {
> +	int fw_version;
> +	int fw_subversion;
> +	struct i2c_client *tcpc_client;
> +	struct i2c_client *spi_client;
> +	struct gpio_desc *intp_gpiod;
> +	struct fwnode_handle *connector_fwnode;
> +	struct typec_params typec;
> +	int intp_irq;
> +	struct work_struct work;
> +	struct workqueue_struct *workqueue;
> +	/* Lock for interrupt work queue */
> +	struct mutex lock;
> +
> +	enum anx7411_psy_state psy_online;
> +	enum power_supply_usb_type usb_type;
> +	struct power_supply *psy;
> +	struct power_supply_desc psy_desc;
> +	struct device *dev;
> +};
> +
> +#endif /* __ANX7411_H__ */

thanks,

-- 
heikki
