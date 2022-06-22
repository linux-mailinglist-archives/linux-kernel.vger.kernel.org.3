Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CE8554657
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349115AbiFVI6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiFVI6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:58:16 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEB8E34;
        Wed, 22 Jun 2022 01:58:07 -0700 (PDT)
X-UUID: b768fae71ca547b7b5dd424f82c0d88c-20220622
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:c7be37e6-56a1-4dcb-953c-d51da3c76ffd,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:100
X-CID-INFO: VERSION:1.1.6,REQID:c7be37e6-56a1-4dcb-953c-d51da3c76ffd,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:100
X-CID-META: VersionHash:b14ad71,CLOUDID:190135ea-f7af-4e69-92ee-0fd74a0c286c,C
        OID:47c063911d5b,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: b768fae71ca547b7b5dd424f82c0d88c-20220622
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1474948226; Wed, 22 Jun 2022 16:58:01 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 22 Jun 2022 16:58:00 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 22 Jun 2022 16:57:59 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Pavel Hofman <pavel.hofman@ivitera.com>,
        Julian Scheel <julian@jusst.de>,
        xin lin <xin.lin@mediatek.com>,
        Yunhao Tian <t123yh.xyz@gmail.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [PATCH] usb: gadget: f_uac1: add IAD descriptor
Date:   Wed, 22 Jun 2022 16:57:57 +0800
Message-ID: <20220622085757.23437-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xin lin <xin.lin@mediatek.com>

Win10 can not enumerate composite device of UVC+UAC1+ADB without IAD descriptor
in uac1.0, so add it.

Signed-off-by: xin lin <xin.lin@mediatek.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/gadget/function/f_uac1.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/function/f_uac1.c
index 6f0e1d803dc2..8390207bc513 100644
--- a/drivers/usb/gadget/function/f_uac1.c
+++ b/drivers/usb/gadget/function/f_uac1.c
@@ -71,6 +71,17 @@ static inline struct f_uac1_opts *g_audio_to_uac1_opts(struct g_audio *audio)
  * ALSA_Playback -> IT_3 -> OT_4 -> USB-IN
  */
 
+static struct usb_interface_assoc_descriptor iad_desc = {
+	.bLength = sizeof(iad_desc),
+	.bDescriptorType = USB_DT_INTERFACE_ASSOCIATION,
+
+	.bFirstInterface = 0,
+	.bInterfaceCount = 3,
+	.bFunctionClass = USB_CLASS_AUDIO,
+	.bFunctionSubClass = 0,
+	.bFunctionProtocol = UAC_VERSION_1,
+};
+
 /* B.3.1  Standard AC Interface Descriptor */
 static struct usb_interface_descriptor ac_interface_desc = {
 	.bLength =		USB_DT_INTERFACE_SIZE,
@@ -259,6 +270,7 @@ static struct uac_iso_endpoint_descriptor as_iso_in_desc = {
 };
 
 static struct usb_descriptor_header *f_audio_desc[] = {
+	(struct usb_descriptor_header *)&iad_desc,
 	(struct usb_descriptor_header *)&ac_interface_desc,
 	(struct usb_descriptor_header *)&ac_header_desc,
 
@@ -293,6 +305,7 @@ static struct usb_descriptor_header *f_audio_desc[] = {
 };
 
 enum {
+	STR_ASSOC,
 	STR_AC_IF,
 	STR_USB_OUT_IT,
 	STR_USB_OUT_IT_CH_NAMES,
@@ -310,6 +323,7 @@ enum {
 
 static struct usb_string strings_uac1[] = {
 	/* [STR_AC_IF].s = DYNAMIC, */
+	[STR_ASSOC].s = "Source/Sink",
 	[STR_USB_OUT_IT].s = "Playback Input terminal",
 	[STR_USB_OUT_IT_CH_NAMES].s = "Playback Channels",
 	[STR_IO_OUT_OT].s = "Playback Output terminal",
@@ -1058,6 +1072,7 @@ static void setup_descriptor(struct f_uac1_opts *opts)
 	as_out_header_desc.bTerminalLink = usb_out_it_desc.bTerminalID;
 	as_in_header_desc.bTerminalLink = usb_in_ot_desc.bTerminalID;
 
+	iad_desc.bInterfaceCount = 1;
 	ac_header_desc->wTotalLength = cpu_to_le16(ac_header_desc->bLength);
 
 	if (EPIN_EN(opts)) {
@@ -1068,6 +1083,7 @@ static void setup_descriptor(struct f_uac1_opts *opts)
 		if (FUIN_EN(opts))
 			len += in_feature_unit_desc->bLength;
 		ac_header_desc->wTotalLength = cpu_to_le16(len);
+		iad_desc.bInterfaceCount++;
 	}
 	if (EPOUT_EN(opts)) {
 		u16 len = le16_to_cpu(ac_header_desc->wTotalLength);
@@ -1077,9 +1093,11 @@ static void setup_descriptor(struct f_uac1_opts *opts)
 		if (FUOUT_EN(opts))
 			len += out_feature_unit_desc->bLength;
 		ac_header_desc->wTotalLength = cpu_to_le16(len);
+		iad_desc.bInterfaceCount++;
 	}
 
 	i = 0;
+	f_audio_desc[i++] = USBDHDR(&iad_desc);
 	f_audio_desc[i++] = USBDHDR(&ac_interface_desc);
 	f_audio_desc[i++] = USBDHDR(ac_header_desc);
 
@@ -1217,6 +1235,7 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 		}
 	}
 
+	iad_desc.iFunction = us[STR_ASSOC].id;
 	ac_interface_desc.iInterface = us[STR_AC_IF].id;
 	usb_out_it_desc.iTerminal = us[STR_USB_OUT_IT].id;
 	usb_out_it_desc.iChannelNames = us[STR_USB_OUT_IT_CH_NAMES].id;
@@ -1302,6 +1321,8 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 	status = usb_interface_id(c, f);
 	if (status < 0)
 		goto err_free_fu;
+
+	iad_desc.bFirstInterface = status;
 	ac_interface_desc.bInterfaceNumber = status;
 	uac1->ac_intf = status;
 	uac1->ac_alt = 0;
-- 
2.18.0

