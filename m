Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114CD4CB51D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 03:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiCCCs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 21:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbiCCCsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 21:48:55 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2111.outbound.protection.outlook.com [40.107.244.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC62915879B;
        Wed,  2 Mar 2022 18:48:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dO22fG4K+kCAQ5aJsp5HCwd0xRHfzMmGVKf95uy+8+xUUQ8SYa8ICI0J0E0dRhcEW6O1PlaZmGkba2bzNvYb++Jicgau4Qy/Z6FgqRInsmc+8Co7OAdh3fJVQl24LHrE0n9oVdPe50vTbN5KaeswSfAD6l5fYB3Cv9FAbnRF/mnWUCIpmgBZM1920Uv1lxDSFw25YzAqjNpjFifhUgn6NJ5+XHdS8fUck4XRzf1jrXj7UWs2xQyPOR9fhdG8WTAD/d0rVR7J2Wd0XKM1Noo3BwCHemNKcuyEqcblWe0Qs6HKzkBZkry3axgZbayglX7rYXq2F7NG6AOpLu8O83O23g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzxDZIh2hpZvR4tfI0kPS5f1L2FQjLPmCDXO4pKt3Bo=;
 b=WZeuL74kNUp6wuLuFfEONmv/DBC08fxT/dJ9iY6+LL0t4X38yYD5FNXoKomwzmbo4IrHyZjAQZqQp4i6/1hIyQp0elMMVK1l4uvjdi6MHm/QEFOlCKvlOpfvJjNRLtb92a/G15mO11EPCctK5adZdnjNE18P5MypdkFIL5rQVRLNTgMp3N3VJETr+2gxNAzfCCoRwI0NzqQv5ZJalSES+rR9n9WuIfgrn8t8sxNxa/I6o7mhKtaMyk7+EgfCudc0sWuC9JuSJdZM0FJE1tRvwhVLPF1XfHtJHT0qpv+53RYnfD4Gjauf3jL12z6L271Z913XUFME+m3RIzvbt98dqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzxDZIh2hpZvR4tfI0kPS5f1L2FQjLPmCDXO4pKt3Bo=;
 b=w0MTAvn8ZzllCfHYYxp6q1JA6SaEnOaMrfQFzAUlOqXVdyDVo3O4k488LBLxmiqTKidWfUU6Fwn7g4xFUdPoHvsMacXeYnSG5NH4h52E6ZUJziJa736EP2irFe/D2th8kXSwOmLNd3nyxdoUOxaSR7EVNSEeOuymvsr0pBEA4RY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by BL0PR04MB4947.namprd04.prod.outlook.com (2603:10b6:208:5f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 02:48:06 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::a865:6d10:c4a9:1142]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::a865:6d10:c4a9:1142%9]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 02:48:06 +0000
Date:   Thu, 3 Mar 2022 10:47:57 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v6 2/2] usb: typec: anx7411: Add Analogix PD ANX7411
 support
Message-ID: <20220303024757.GA4159259@anxtwsw-Precision-3640-Tower>
References: <20220223102353.3833578-1-xji@analogixsemi.com>
 <20220223102353.3833578-2-xji@analogixsemi.com>
 <Yh9dBlrWm3OicQWa@kuha.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh9dBlrWm3OicQWa@kuha.fi.intel.com>
X-ClientProxiedBy: SG2PR06CA0215.apcprd06.prod.outlook.com
 (2603:1096:4:68::23) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 290c4e83-98f8-47a2-7caa-08d9fcc03e3b
X-MS-TrafficTypeDiagnostic: BL0PR04MB4947:EE_
X-Microsoft-Antispam-PRVS: <BL0PR04MB49474BB849D21213AC403B38C7049@BL0PR04MB4947.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FbyByg/ih+hlYsQ0iZEMxtHZZMOPrGX9d3OcBQ0r8lBRLUFO0WVMPWWAN9iIWKRPp3kwewmuCru145rdn7iS1NQfUG5D7sJ48K6Msv5Q10GADSZPhwntwtayM6B6GTl+wpRyyZs+Wp7Tl8O5Zh0ZnejDKvMf0QUbolItu7LEqDGyd7alF6v1cH9EaOlEE+946WhFVvfq61lbO654Wn84jLRbxOJ4EhIrVGLI7Xa+r0F823mutXREbybrC+RaJpRWessH91Axe0+9+QKemAfJvlM0gJj3xyvjWFZYBfw9Eqx6DqUwI9LNdFfYWxL/13f40uxGxEBZ+QVuvQiToCaTe/1LXivbJNTkYoDXA+gc7Z88Puey4vg8+aOpGv9BYV3OdxBknBotUNVRuT6UxRbYLRT+kkgtbAdfrkUWMZygUNMnq0bckbv8+XIWld9Lv+qxtIwOGxZIOAVWcPzsvV0M4Jk3ozCkdVETRgFNsIHHkzeQiA0AamVF5GxOLCeBb1awcjDNPkFYCRp4knpzDwiWX5WcKEw91gCqWHPemFsGzIjwsQE9GSY9kz6pq8DmsWweJuvHE96pn0NOQl43v4pWkEYwZaIPoK3WNsq5G4QLivHmZSDiCfoR+rEqP6WKq+mbCutNU22fR9jyzZcYkzectBPig2nHhIDPwbM3OvMDMZraeszgi1vjo2PTsgsexqDHXVLowYM7g5ByneWyy+0bWqAB75B9wVjfQ4fNI46lP5GMHukyMSPiE52A9V6Cll7wWiyIlf6Rua0r3DRvq9YCsK0cn07Ue05ufrNi1Ir8ABI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6486002)(966005)(66946007)(508600001)(83380400001)(8936002)(38350700002)(38100700002)(86362001)(9686003)(52116002)(33656002)(6506007)(55236004)(8676002)(4326008)(5660300002)(6512007)(6916009)(186003)(26005)(33716001)(1076003)(2906002)(6666004)(316002)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2HCN8Ai+nlAa1AWRn4lX6hvn9PDN0xIrZ2aW7rz4JSXh7KamVt0KYolH6x6t?=
 =?us-ascii?Q?8H5zGS1BU8BOQF1gOLHXhTf1W9Saz1lyv8Hbby67U33/eN4HFwsZWE2Zm5v0?=
 =?us-ascii?Q?2Rd/4I6Zf3AAgod8FI0OSO6GznLujEnWY/VAoCog/iOJgpiyBaMs+sFpAnlg?=
 =?us-ascii?Q?+Mpx6EApuguHFrWqiTDm2hldqDfs4CARTEasgQRpGq9pGDffora/7t/a3mGr?=
 =?us-ascii?Q?xyPmAKxQwcsvVdUxm/1gpo0G3cEeWv1EpmUcCj9JTlZt0auDdvnTnAd+5NKx?=
 =?us-ascii?Q?MDoC2e2HhkiGAn3KnhlMrr2fIarzs5wTosnEiJrgHYFvMu28MMn+qy0GpiIu?=
 =?us-ascii?Q?vGqE0jUySEyBE6IdPhcfwuT58woJQbs2mgth7SpaJw4SIiFFxq9Yn3XbHzCo?=
 =?us-ascii?Q?Rnlo+o2M86+/9RjZr0Ihn3IXLVQgKypwucEru2q6R73rlLCgqnFZHFdTJQ2o?=
 =?us-ascii?Q?7wqZ6sJtRYg26r1xPBctS3c0c7J1BqNirIx6JIbkwWy/VuqRi+66HqXLcHw2?=
 =?us-ascii?Q?BpWF+3gwuDPpPTCLZI7/OUl/V+seos3uyw+jyJDAFDe/sn78TzEnqMOrCvsq?=
 =?us-ascii?Q?ZUY8j2JB4TF/aKi9u17FTqvcuVzyzXn1vBaLJxA0JGIh0Mxu/bNvsBopE7fh?=
 =?us-ascii?Q?e2B+X2v/KeT3e0duuHJuQwisaarBse8NQUYYwhvWcnwjBbmcECJaUouCqQsE?=
 =?us-ascii?Q?3MoyUWVvdI0IQfqsTNuVftuwDQkJyXBjbmVb53uSd4XW9iLS1P27Eaz/D/m/?=
 =?us-ascii?Q?RX9YXny1AvxAYvNCw+p6nr1Q8/5h2qv2HEIypsONbko7SkTZYMTgsgbHjNLc?=
 =?us-ascii?Q?rMACwEaKwl0buh05OiHyxAhOhQWv5kbozVOCwayD9XGLnbnp0gpqtV3Oxjw8?=
 =?us-ascii?Q?9BTiz3YZiYQa4z2iA7boBqfiWwsa5a2PUjtLMmlg4BpmLI6Y9DkgYvQSPWIc?=
 =?us-ascii?Q?c1TwbMhqUIeL+bVFOw33QjvNsUiUCtdm7SjYb2tZWWabnlRmdZYE+OniB60u?=
 =?us-ascii?Q?500istCOWEckiuOMoTCbqBumLsv2tXSXk0jIKuL+gzIHGRGszKG6GJnSQWhq?=
 =?us-ascii?Q?bzB1SJ0a9tlWCcR+QFQ5Y7793Ymbr2AjTHOfxokIm8xY5nIZnprgmHEH5nef?=
 =?us-ascii?Q?3+ad4f4c4ZDz+9+PBUGuWGBxKL5b7+PAM9ACtvBaUDXcbn9ap/Y6Ewbx0qH4?=
 =?us-ascii?Q?IZ+Nv7b5+ZqkO45jldJbdl38ccXVcnknWWGcoTvLnQvmMmVfVGBatcCRHW4X?=
 =?us-ascii?Q?O+4BkDtfcq5OWVADM3DyTG0EinXEl89qnbNNH8tCKb8zWTb+JNFAPtHu3e0I?=
 =?us-ascii?Q?8DKjMDJ75R/eQicZbyK45l42EbcUCCCZI45A5H3mJ6UBp5O7dEBUQNZsYPvZ?=
 =?us-ascii?Q?Cs13UZrn/mTCQQhIaDiRyUvDaI54DCvJUMvP5Hsg3RKFcBg04YHo5aXoC00w?=
 =?us-ascii?Q?/8FpuCFCSVcxhfbG0J/AYlCxDDVBLVaui4s4RqkQFOis+GIMNleFHfwgOBXO?=
 =?us-ascii?Q?x5N6D3ILfZhEX3RgPfjqsBCacWnZYXeZP1ZUY2E0XsbpUztGKSkPZR5bG2n9?=
 =?us-ascii?Q?71D4iu8Ihe5zsQ4VdrCU6+L4sCKFQ1jXSwK3dHnEdxkAXoK8a/8p04ijX6oH?=
 =?us-ascii?Q?qawEYjOXRdUUZ9cf9LcKT7A=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 290c4e83-98f8-47a2-7caa-08d9fcc03e3b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 02:48:06.2641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kM56d3utmmGcpB4fbnueymITLwizy2+XuiqbyyrzBBHS8/slwUg+qPgY+etoM/XxYlqLleESQ4Tb1IVPTLeYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4947
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 02:03:18PM +0200, Heikki Krogerus wrote:
> Hi,
> 
> This does not apply on top of Greg's latest usb-next branch. You need
> to rebase this. There are also a few more nitpicks below.

Hi, I didn't found tcpci.h in include/linux/usb/
I download the latest usb-next branch from Greg's usb.git repo, but
cannot found tcpci.h in "include/linux/usb", please check my command log
below:

$git clone git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
$git checkout -b usb-next origin/usb-next
$git log --pretty=oneline --abbrev-commit 
ca9400ef7f67 (HEAD -> usb-next, origin/usb-testing, origin/usb-next) Merge 5.17-rc6 into usb-next
7e57714cd0ad (tag: v5.17-rc6, origin/usb-linus, origin/main) Linux 5.17-rc6
52a025546731 Merge tag 'irq-urgent-2022-02-27' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
$ls include/linux/usb/tcpci.h
ls: cannot access 'include/linux/usb/tcpci.h': No such file or directory

URL: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/tree/include/linux/usb?h=usb-next

If I didn't correctly clone the repository, please let me known, thanks
for you support.

Thanks,
Xin

> 
> On Wed, Feb 23, 2022 at 06:23:52PM +0800, Xin Ji wrote:
> > diff --git a/drivers/usb/typec/anx7411.h b/drivers/usb/typec/anx7411.h
> > new file mode 100644
> > index 000000000000..cc0b7a570438
> > --- /dev/null
> > +++ b/drivers/usb/typec/anx7411.h
> > @@ -0,0 +1,273 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +/*
> > + * Copyright(c) 2022, Analogix Semiconductor. All rights reserved.
> > + *
> > + */
> > +
> > +#ifndef __ANX7411_H__
> > +#define __ANX7411_H__
> > +
> > +#define TCPC_ADDRESS1		0x58
> > +#define TCPC_ADDRESS2		0x56
> > +#define TCPC_ADDRESS3		0x54
> > +#define TCPC_ADDRESS4		0x52
> > +#define SPI_ADDRESS1		0x7e
> > +#define SPI_ADDRESS2		0x6e
> > +#define SPI_ADDRESS3		0x64
> > +#define SPI_ADDRESS4		0x62
> > +
> > +struct anx7411_i2c_select {
> > +	u8 tcpc_address;
> > +	u8 spi_address;
> > +};
> > +
> > +#define VENDOR_ID		0x1F29
> > +#define PRODUCT_ID		0x7411
> 
> Please make that VENDOR_ID_<vendor name>, and the same with the
> product ID.
> 
> > +/* TCPC register define */
> > +
> > +#define TCPC_ROLE_CONTROL	0x1A
> > +
> > +#define TCPC_COMMAND		0x23
> > +#define TCPC_CMD_I2C_IDLE	0xFF
> > +#define TCPC_CMD_LOOK4CONN	0x99
> > +#define SINK_CTRL_EN		0x55
> > +#define SINK_CTRL_DIS		0x44
> > +
> > +#define ANALOG_CTRL_10		0xAA
> 
> Those are TCPC commands and registers. I though I already asked that
> you move the register and command definitions from
> drivers/usb/typec/tcpm/tcpci.h to include/linux/usb/tcpci.h?
> 
> You need to do that in a separate patch, but I really think it would
> be worth doing, even though there are only a few shared definitions
> here.
> 
> > +#define STATUS_LEN		2
> > +#define ALERT_0			0xCB
> > +#define RECEIVED_MSG		BIT(7)
> > +#define SOFTWARE_INT		BIT(6)
> > +#define MSG_LEN			32
> > +#define HEADER_LEN		2
> > +#define MSG_HEADER		0x00
> > +#define MSG_TYPE		0x01
> > +#define MSG_RAWDATA		0x02
> > +#define MSG_LEN_MASK		0x1F
> > +
> > +#define ALERT_1			0xCC
> > +#define INTP_POW_ON		BIT(7)
> > +#define INTP_POW_OFF		BIT(6)
> > +
> > +#define VBUS_THRESHOLD_H	0xDD
> > +#define VBUS_THRESHOLD_L	0xDE
> > +
> > +#define FW_CTRL_0		0xF0
> > +#define UNSTRUCT_VDM_EN		BIT(0)
> > +#define DELAY_200MS		BIT(1)
> > +#define VSAFE0			0
> > +#define VSAFE1			BIT(2)
> > +#define VSAFE2			BIT(3)
> > +#define VSAFE3			(BIT(2) | BIT(3))
> > +#define FRS_EN			BIT(7)
> > +
> > +#define FW_PARAM		0xF1
> > +#define DONGLE_IOP		BIT(0)
> > +
> > +#define FW_CTRL_2		0xF7
> > +#define SINK_CTRL_DIS_FLAG	BIT(5)
> > +
> > +/* SPI register define */
> > +#define OCM_CTRL_0		0x6E
> > +#define OCM_RESET		BIT(6)
> > +
> > +#define MAX_VOLTAGE		0xAC
> > +#define MAX_POWER		0xAD
> > +#define MIN_POWER		0xAE
> > +
> > +#define REQUEST_VOLTAGE		0xAF
> > +#define VOLTAGE_UNIT		100 /* mV per unit */
> > +
> > +#define REQUEST_CURRENT		0xB1
> > +#define CURRENT_UNIT		50 /* mA per unit */
> > +
> > +#define CMD_SEND_BUF		0xC0
> > +#define CMD_RECV_BUF		0xE0
> > +
> > +#define REQ_VOL_20V_IN_100MV	0xC8
> > +#define REQ_CUR_2_25A_IN_50MA	0x2D
> > +#define REQ_CUR_3_25A_IN_50MA	0x41
> > +
> > +#define DEF_5V			5000
> > +#define DEF_1_5A		1500
> > +
> > +enum anx7411_typec_message_type {
> > +	TYPE_SRC_CAP = 0x00,
> > +	TYPE_SNK_CAP = 0x01,
> > +	TYPE_SNK_IDENTITY = 0x02,
> > +	TYPE_SVID = 0x03,
> > +	TYPE_SET_SNK_DP_CAP = 0x08,
> > +	TYPE_PSWAP_REQ = 0x10,
> > +	TYPE_DSWAP_REQ = 0x11,
> > +	TYPE_VDM = 0x14,
> > +	TYPE_OBJ_REQ = 0x16,
> > +	TYPE_DP_ALT_ENTER = 0x19,
> > +	TYPE_DP_DISCOVER_MODES_INFO = 0x27,
> > +	TYPE_GET_DP_CONFIG = 0x29,
> > +	TYPE_DP_CONFIGURE = 0x2A,
> > +	TYPE_GET_DP_DISCOVER_MODES_INFO = 0x2E,
> > +	TYPE_GET_DP_ALT_ENTER = 0x2F,
> > +};
> > +
> > +#define REQUEST_CURRENT		0xB1
> > +#define REQUEST_VOLTAGE		0xAF
> 
> Double definition - you already defined those two in this same file
> above.
> 
> > +#define FW_CTRL_1		0xB2
> > +#define AUTO_PD_EN		BIT(1)
> > +#define TRYSRC_EN		BIT(2)
> > +#define TRYSNK_EN		BIT(3)
> > +#define FORCE_SEND_RDO		BIT(6)
> > +
> > +#define FW_VER			0xB4
> > +#define FW_SUBVER		0xB5
> > +
> > +#define INT_MASK		0xB6
> > +#define INT_STS			0xB7
> > +#define OCM_BOOT_UP		BIT(0)
> > +#define OC_OV_EVENT		BIT(1)
> > +#define VCONN_CHANGE		BIT(2)
> > +#define VBUS_CHANGE		BIT(3)
> > +#define CC_STATUS_CHANGE	BIT(4)
> > +#define DATA_ROLE_CHANGE	BIT(5)
> > +#define PR_CONSUMER_GOT_POWER	BIT(6)
> > +#define HPD_STATUS_CHANGE	BIT(7)
> > +
> > +#define SYSTEM_STSTUS		0xB8
> > +/* 0: SINK off; 1: SINK on */
> > +#define SINK_STATUS		BIT(1)
> > +/* 0: VCONN off; 1: VCONN on*/
> > +#define VCONN_STATUS		BIT(2)
> > +/* 0: vbus off; 1: vbus on*/
> > +#define VBUS_STATUS		BIT(3)
> > +/* 1: host; 0:device*/
> > +#define DATA_ROLE		BIT(5)
> > +/* 0: Chunking; 1: Unchunked*/
> > +#define SUPPORT_UNCHUNKING	BIT(6)
> > +/* 0: HPD low; 1: HPD high*/
> > +#define HPD_STATUS		BIT(7)
> > +
> > +#define DATA_DFP		1
> > +#define DATA_UFP		2
> > +#define POWER_SOURCE		1
> > +#define POWER_SINK		2
> > +
> > +#define CC_STATUS		0xB9
> > +#define CC1_RD			BIT(0)
> > +#define CC2_RD			BIT(4)
> > +#define CC1_RA			BIT(1)
> > +#define CC2_RA			BIT(5)
> > +#define CC1_RD			BIT(0)
> > +#define CC1_RP(cc)		(((cc) >> 2) & 0x03)
> > +#define CC2_RP(cc)		(((cc) >> 6) & 0x03)
> > +
> > +#define PD_REV_INIT		0xBA
> > +
> > +#define PD_EXT_MSG_CTRL		0xBB
> > +#define SRC_CAP_EXT_REPLY	BIT(0)
> > +#define MANUFACTURER_INFO_REPLY	BIT(1)
> > +#define BATTERY_STS_REPLY	BIT(2)
> > +#define BATTERY_CAP_REPLY	BIT(3)
> > +#define ALERT_REPLY		BIT(4)
> > +#define STATUS_REPLY		BIT(5)
> > +#define PPS_STATUS_REPLY	BIT(6)
> > +#define SNK_CAP_EXT_REPLY	BIT(7)
> > +
> > +#define NO_CONNECT		0x00
> > +#define USB3_1_CONNECTED	0x01
> > +#define DP_ALT_4LANES		0x02
> > +#define USB3_1_DP_2LANES	0x03
> > +#define CC1_CONNECTED		0x01
> > +#define CC2_CONNECTED		0x02
> > +#define SELECT_PIN_ASSIGMENT_C	0x04
> > +#define SELECT_PIN_ASSIGMENT_D	0x08
> > +#define SELECT_PIN_ASSIGMENT_E	0x10
> > +#define SELECT_PIN_ASSIGMENT_U	0x00
> > +#define REDRIVER_ADDRESS	0x20
> > +#define REDRIVER_OFFSET		0x00
> > +
> > +#define DP_SVID			0xFF01
> > +#define VDM_ACK			0x40
> > +#define VDM_CMD_RES		0x00
> > +#define VDM_CMD_DIS_ID		0x01
> > +#define VDM_CMD_DIS_SVID	0x02
> > +#define VDM_CMD_DIS_MOD		0x03
> > +#define VDM_CMD_ENTER_MODE	0x04
> > +#define VDM_CMD_EXIT_MODE	0x05
> > +#define VDM_CMD_ATTENTION	0x06
> > +#define VDM_CMD_GET_STS		0x10
> > +#define VDM_CMD_AND_ACK_MASK	0x5F
> > +
> > +#define MAX_ALTMODE		2
> > +
> > +#define HAS_SOURCE_CAP		BIT(0)
> > +#define HAS_SINK_CAP		BIT(1)
> > +#define HAS_SINK_WATT		BIT(2)
> > +
> > +enum anx7411_psy_state {
> > +	/* copy from drivers/usb/typec/tcpm */
> > +	ANX7411_PSY_OFFLINE = 0,
> > +	ANX7411_PSY_FIXED_ONLINE,
> > +
> > +	/* private */
> > +	/* PD keep in, but disconnct power to bq25700,
> > +	 * this state can be active when higher capacity adapter plug in,
> > +	 * and change to ONLINE state when higher capacity adapter plug out
> > +	 */
> > +	ANX7411_PSY_HANG = 0xff,
> > +};
> > +
> > +struct typec_params {
> > +	int request_current; /* ma */
> > +	int request_voltage; /* mv */
> > +	int cc_connect;
> > +	int cc_orientation_valid;
> > +	int cc_status;
> > +	int data_role;
> > +	int power_role;
> > +	int vconn_role;
> > +	int dp_altmode_enter;
> > +	int cust_altmode_enter;
> > +	struct usb_role_switch *role_sw;
> > +	struct typec_port *port;
> > +	struct typec_partner *partner;
> > +	struct typec_mux *typec_mux;
> > +	struct typec_switch *typec_switch;
> > +	struct typec_altmode *amode[MAX_ALTMODE];
> > +	struct typec_altmode *port_amode[MAX_ALTMODE];
> > +	struct typec_displayport_data data;
> > +	int pin_assignment;
> > +	struct typec_capability caps;
> > +	u32 src_pdo[PDO_MAX_OBJECTS];
> > +	u32 sink_pdo[PDO_MAX_OBJECTS];
> > +	u8 caps_flags;
> > +	u8 src_pdo_nr;
> > +	u8 sink_pdo_nr;
> > +	u8 sink_watt;
> > +	u8 sink_voltage;
> > +};
> > +
> > +struct anx7411_data {
> > +	int fw_version;
> > +	int fw_subversion;
> > +	struct i2c_client *tcpc_client;
> > +	struct i2c_client *spi_client;
> > +	struct gpio_desc *intp_gpiod;
> > +	struct fwnode_handle *connector_fwnode;
> > +	struct typec_params typec;
> > +	int intp_irq;
> > +	struct work_struct work;
> > +	struct workqueue_struct *workqueue;
> > +	/* Lock for interrupt work queue */
> > +	struct mutex lock;
> > +
> > +	enum anx7411_psy_state psy_online;
> > +	enum power_supply_usb_type usb_type;
> > +	struct power_supply *psy;
> > +	struct power_supply_desc psy_desc;
> > +	struct device *dev;
> > +};
> > +
> > +#endif /* __ANX7411_H__ */
> 
> thanks,
> 
> -- 
> heikki
