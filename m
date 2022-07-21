Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A100457C1F0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 03:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiGUBsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 21:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiGUBs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 21:48:29 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3648C15A14;
        Wed, 20 Jul 2022 18:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658368108; x=1689904108;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iXMHw5Asl7oU6fyDe5ffouo+oBUrAhNmZtBQxZRHC/I=;
  b=BLtGR5rjjCIxVX0Nz7V7djzURA1HCqPBGnQv0/twq2DmpdqDnwSJVSb7
   xcatyx5VTrBCDWgl/WbBF1NRSe4QKfAlFYpiq9o75rmaG+4YtRMxohGOi
   AIxULJBrEggXyrHTg3rE0rlzptI9xf4AcXdsi+BQiemYbMnMD6zmDIPTM
   U=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 Jul 2022 18:48:27 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 18:48:27 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 18:48:27 -0700
Received: from jackp-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 18:48:26 -0700
From:   Jack Pham <quic_jackp@quicinc.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <3090101217@zju.edu.cn>, <balbi@kernel.org>,
        <colin.king@intel.com>, <jbrunet@baylibre.com>,
        <jleng@ambarella.com>, <pavel.hofman@ivitera.com>,
        <pawell@cadence.com>, <ruslan.bilovol@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Jack Pham <quic_jackp@quicinc.com>
Subject: [PATCH v5] usb: gadget: f_uac2: fix superspeed transfer
Date:   Wed, 20 Jul 2022 18:48:15 -0700
Message-ID: <20220721014815.14453-1-quic_jackp@quicinc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Leng <jleng@ambarella.com>

On page 362 of the USB3.2 specification (
https://usb.org/sites/default/files/usb_32_20210125.zip),
The 'SuperSpeed Endpoint Companion Descriptor' shall only be returned
by Enhanced SuperSpeed devices that are operating at Gen X speed.
Each endpoint described in an interface is followed by a 'SuperSpeed
Endpoint Companion Descriptor'.

If users use SuperSpeed UDC, host can't recognize the device if endpoint
doesn't have 'SuperSpeed Endpoint Companion Descriptor' followed.

Currently in the uac2 driver code:
1. ss_epout_desc_comp follows ss_epout_desc;
2. ss_epin_fback_desc_comp follows ss_epin_fback_desc;
3. ss_epin_desc_comp follows ss_epin_desc;
4. Only ss_ep_int_desc endpoint doesn't have 'SuperSpeed Endpoint
Companion Descriptor' followed, so we should add it.

Fixes: eaf6cbe09920 ("usb: gadget: f_uac2: add volume and mute support")
Signed-off-by: Jing Leng <jleng@ambarella.com>
Signed-off-by: Jack Pham <quic_jackp@quicinc.com>
---
v5: Revived from https://lore.kernel.org/linux-usb/20220218095948.4077-1-3090101217@zju.edu.cn/
    and rebased on Greg's usb-linus

ChangeLog v3->v4:
- Add "Fixes:" tag in the changelog area
ChangeLog v2->v3:
- Remove static variables which are explicitly initialized to 0
- Remove redundant modification "case USB_SPEED_SUPER_PLUS:"
ChangeLog v1->v2:
- Update more detailed description of the PATCH

 drivers/usb/gadget/function/f_uac2.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index 1905a8d8e0c9..08726e4c68a5 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -291,6 +291,12 @@ static struct usb_endpoint_descriptor ss_ep_int_desc = {
 	.bInterval = 4,
 };
 
+static struct usb_ss_ep_comp_descriptor ss_ep_int_desc_comp = {
+	.bLength = sizeof(ss_ep_int_desc_comp),
+	.bDescriptorType = USB_DT_SS_ENDPOINT_COMP,
+	.wBytesPerInterval = cpu_to_le16(6),
+};
+
 /* Audio Streaming OUT Interface - Alt0 */
 static struct usb_interface_descriptor std_as_out_if0_desc = {
 	.bLength = sizeof std_as_out_if0_desc,
@@ -604,7 +610,8 @@ static struct usb_descriptor_header *ss_audio_desc[] = {
 	(struct usb_descriptor_header *)&in_feature_unit_desc,
 	(struct usb_descriptor_header *)&io_out_ot_desc,
 
-  (struct usb_descriptor_header *)&ss_ep_int_desc,
+	(struct usb_descriptor_header *)&ss_ep_int_desc,
+	(struct usb_descriptor_header *)&ss_ep_int_desc_comp,
 
 	(struct usb_descriptor_header *)&std_as_out_if0_desc,
 	(struct usb_descriptor_header *)&std_as_out_if1_desc,
@@ -800,6 +807,7 @@ static void setup_headers(struct f_uac2_opts *opts,
 	struct usb_ss_ep_comp_descriptor *epout_desc_comp = NULL;
 	struct usb_ss_ep_comp_descriptor *epin_desc_comp = NULL;
 	struct usb_ss_ep_comp_descriptor *epin_fback_desc_comp = NULL;
+	struct usb_ss_ep_comp_descriptor *ep_int_desc_comp = NULL;
 	struct usb_endpoint_descriptor *epout_desc;
 	struct usb_endpoint_descriptor *epin_desc;
 	struct usb_endpoint_descriptor *epin_fback_desc;
@@ -827,6 +835,7 @@ static void setup_headers(struct f_uac2_opts *opts,
 		epin_fback_desc = &ss_epin_fback_desc;
 		epin_fback_desc_comp = &ss_epin_fback_desc_comp;
 		ep_int_desc = &ss_ep_int_desc;
+		ep_int_desc_comp = &ss_ep_int_desc_comp;
 	}
 
 	i = 0;
@@ -855,8 +864,11 @@ static void setup_headers(struct f_uac2_opts *opts,
 	if (EPOUT_EN(opts))
 		headers[i++] = USBDHDR(&io_out_ot_desc);
 
-	if (FUOUT_EN(opts) || FUIN_EN(opts))
+	if (FUOUT_EN(opts) || FUIN_EN(opts)) {
 		headers[i++] = USBDHDR(ep_int_desc);
+		if (ep_int_desc_comp)
+			headers[i++] = USBDHDR(ep_int_desc_comp);
+	}
 
 	if (EPOUT_EN(opts)) {
 		headers[i++] = USBDHDR(&std_as_out_if0_desc);
-- 
2.24.0

