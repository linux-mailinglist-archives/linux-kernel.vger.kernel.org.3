Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29374C0A38
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237884AbiBWDaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiBWDaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:30:06 -0500
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id C242738DB9;
        Tue, 22 Feb 2022 19:29:36 -0800 (PST)
Received: from jleng.ambarella.net (unknown [180.169.129.130])
        by mail-app3 (Coremail) with SMTP id cC_KCgBnv2n1qRViIae6DQ--.54040S2;
        Wed, 23 Feb 2022 11:28:58 +0800 (CST)
From:   3090101217@zju.edu.cn
To:     laurent.pinchart@ideasonboard.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, peter.chen@kernel.org,
        pawell@cadence.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jing Leng <jleng@ambarella.com>
Subject: [PATCH] usb: gadget: uvc: add different uvc versions support
Date:   Wed, 23 Feb 2022 11:28:52 +0800
Message-Id: <20220223032852.24304-1-3090101217@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgBnv2n1qRViIae6DQ--.54040S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XF4fCw1xury3ur43KF1rWFg_yoW3Zw1Upr
        Z8C3yYkF15Jw43uw1fJ3ykur43Ga93JF9rCay2g3yFgryaka4UXF9rtryFkFyrAa15ArWF
        vF4kJw129ws7ZrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWlnxkEFVCFx7IYxxCEVcI2
        5VAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxkIecxEwVAFwVW8GwCF04k20x
        vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
        3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIx
        AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07bw9a9UUUUU=
X-CM-SenderInfo: qtqziiyqrsilo62m3hxhgxhubq/1tbiAwIKBVNG3FoMdQAAsk
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Leng <jleng@ambarella.com>

Currently UVC specification has three different versions
(1.0 1.1 and 1.5), they are a little different:

1. UVC 1.5 adds three new selectors in "Camera Terminal Control".
2. UVC 1.5 adds one new selector in "Processing Unit Control".
3. In the "Processing Unit Descriptor", bControlSize is fixed to be 3 in
   UVC 1.5 and is configurable in UVC 1.0/1.1. In addition, UVC 1.1 adds
   an extra member "bmVideoStandards".
4. In the "Video Probe and Commit Controls", the number of the members
   is different in different UVC versions. The length of the structure
   is 26/34/48 in UVC 1.0/1.1/1.5.

Currently, even we can configure the uvc version via bcdUVC, there is no
different processings for UVC 1.0/1.1, and it doesn't have new definitions
of UVC 1.5.
we can simply modify the driver according to the UVC 1.0/1.1/1.5
specifications to support different version UVCs.

Here is an example how to configure the UVC version:
 VERSION=$(( 0x0150 )) # 0x0100 or 0x0110 or 0x0150
 mkdir functions/uvc.usb0/control/header/h
 cd functions/uvc.usb0/control/
 echo $VERSION > header/h/bcdUVC # change the version
 ln -s header/h class/fs
 ln -s header/h class/ss

Signed-off-by: Jing Leng <jleng@ambarella.com>
---
 drivers/usb/gadget/function/f_uvc.c        | 17 ++++++++++++--
 drivers/usb/gadget/function/uvc_configfs.c |  2 +-
 drivers/usb/gadget/legacy/webcam.c         |  7 +++---
 include/uapi/linux/usb/video.h             | 27 ++++++++++++++++++++--
 4 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 71bb5e477dba..a39f20b952ce 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -589,6 +589,9 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 	struct usb_composite_dev *cdev = c->cdev;
 	struct uvc_device *uvc = to_uvc(f);
 	struct usb_string *us;
+	struct uvc_processing_unit_descriptor *pd;
+	struct uvc_descriptor_header **ctl_cls;
+	struct uvc_header_descriptor *desc;
 	unsigned int max_packet_mult;
 	unsigned int max_packet_size;
 	struct usb_ep *ep;
@@ -598,6 +601,15 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 	uvcg_info(f, "%s()\n", __func__);
 
 	opts = fi_to_f_uvc_opts(f->fi);
+
+	/* Handle the length of Processing Unit for different UVC versions */
+	ctl_cls = opts->uvc_ss_control_cls;
+	desc = (struct uvc_header_descriptor *)ctl_cls[0];
+	if (desc) {
+		pd = &opts->uvc_processing;
+		pd->bLength = UVC_DT_PROCESSING_UNIT_SIZE(desc->bcdUVC, 3);
+	}
+
 	/* Sanity check the streaming endpoint module parameters.
 	 */
 	opts->streaming_interval = clamp(opts->streaming_interval, 1U, 16U);
@@ -814,15 +826,16 @@ static struct usb_function_instance *uvc_alloc_inst(void)
 	cd->bmControls[2]		= 0;
 
 	pd = &opts->uvc_processing;
-	pd->bLength			= UVC_DT_PROCESSING_UNIT_SIZE(2);
+	pd->bLength			= UVC_DT_PROCESSING_UNIT_SIZE(UVC_VERSION_DEFAULT, 3);
 	pd->bDescriptorType		= USB_DT_CS_INTERFACE;
 	pd->bDescriptorSubType		= UVC_VC_PROCESSING_UNIT;
 	pd->bUnitID			= 2;
 	pd->bSourceID			= 1;
 	pd->wMaxMultiplier		= cpu_to_le16(16*1024);
-	pd->bControlSize		= 2;
+	pd->bControlSize		= 3;
 	pd->bmControls[0]		= 1;
 	pd->bmControls[1]		= 0;
+	pd->bmControls[2]		= 0;
 	pd->iProcessing			= 0;
 	pd->bmVideoStandards		= 0;
 
diff --git a/drivers/usb/gadget/function/uvc_configfs.c b/drivers/usb/gadget/function/uvc_configfs.c
index 77d64031aa9c..f4cee41b66f0 100644
--- a/drivers/usb/gadget/function/uvc_configfs.c
+++ b/drivers/usb/gadget/function/uvc_configfs.c
@@ -231,7 +231,7 @@ static struct config_item *uvcg_control_header_make(struct config_group *group,
 	h->desc.bLength			= UVC_DT_HEADER_SIZE(1);
 	h->desc.bDescriptorType		= USB_DT_CS_INTERFACE;
 	h->desc.bDescriptorSubType	= UVC_VC_HEADER;
-	h->desc.bcdUVC			= cpu_to_le16(0x0110);
+	h->desc.bcdUVC			= cpu_to_le16(UVC_VERSION_DEFAULT);
 	h->desc.dwClockFrequency	= cpu_to_le32(48000000);
 
 	config_item_init_type_name(&h->item, name, &uvcg_control_header_type);
diff --git a/drivers/usb/gadget/legacy/webcam.c b/drivers/usb/gadget/legacy/webcam.c
index 94e22867da1d..f5f13d39e770 100644
--- a/drivers/usb/gadget/legacy/webcam.c
+++ b/drivers/usb/gadget/legacy/webcam.c
@@ -90,7 +90,7 @@ static const struct UVC_HEADER_DESCRIPTOR(1) uvc_control_header = {
 	.bLength		= UVC_DT_HEADER_SIZE(1),
 	.bDescriptorType	= USB_DT_CS_INTERFACE,
 	.bDescriptorSubType	= UVC_VC_HEADER,
-	.bcdUVC			= cpu_to_le16(0x0110),
+	.bcdUVC			= cpu_to_le16(UVC_VERSION_DEFAULT),
 	.wTotalLength		= 0, /* dynamic */
 	.dwClockFrequency	= cpu_to_le32(48000000),
 	.bInCollection		= 0, /* dynamic */
@@ -115,15 +115,16 @@ static const struct uvc_camera_terminal_descriptor uvc_camera_terminal = {
 };
 
 static const struct uvc_processing_unit_descriptor uvc_processing = {
-	.bLength		= UVC_DT_PROCESSING_UNIT_SIZE(2),
+	.bLength		= UVC_DT_PROCESSING_UNIT_SIZE(UVC_VERSION_DEFAULT, 3),
 	.bDescriptorType	= USB_DT_CS_INTERFACE,
 	.bDescriptorSubType	= UVC_VC_PROCESSING_UNIT,
 	.bUnitID		= 2,
 	.bSourceID		= 1,
 	.wMaxMultiplier		= cpu_to_le16(16*1024),
-	.bControlSize		= 2,
+	.bControlSize		= 3,
 	.bmControls[0]		= 1,
 	.bmControls[1]		= 0,
+	.bmControls[2]		= 0,
 	.iProcessing		= 0,
 	.bmVideoStandards	= 0,
 };
diff --git a/include/uapi/linux/usb/video.h b/include/uapi/linux/usb/video.h
index bfdae12cdacf..edd1bbde2290 100644
--- a/include/uapi/linux/usb/video.h
+++ b/include/uapi/linux/usb/video.h
@@ -21,6 +21,12 @@
  * UVC constants
  */
 
+/* UVC Protocol Version */
+#define UVC_VERSION_1_0					0x0100
+#define UVC_VERSION_1_1					0x0110
+#define UVC_VERSION_1_5					0x0150
+#define UVC_VERSION_DEFAULT				UVC_VERSION_1_1
+
 /* A.2. Video Interface Subclass Codes */
 #define UVC_SC_UNDEFINED				0x00
 #define UVC_SC_VIDEOCONTROL				0x01
@@ -104,6 +110,9 @@
 #define UVC_CT_ROLL_ABSOLUTE_CONTROL			0x0f
 #define UVC_CT_ROLL_RELATIVE_CONTROL			0x10
 #define UVC_CT_PRIVACY_CONTROL				0x11
+#define UVC_CT_FOCUS_SIMPLE_CONTROL			0x12
+#define UVC_CT_WINDOW_CONTROL				0x13
+#define UVC_CT_REGION_OF_INTEREST_CONTROL		0x14
 
 /* A.9.5. Processing Unit Control Selectors */
 #define UVC_PU_CONTROL_UNDEFINED			0x00
@@ -125,6 +134,7 @@
 #define UVC_PU_HUE_AUTO_CONTROL				0x10
 #define UVC_PU_ANALOG_VIDEO_STANDARD_CONTROL		0x11
 #define UVC_PU_ANALOG_LOCK_STATUS_CONTROL		0x12
+#define UVC_PU_CONTRAST_AUTO_CONTROL			0x13
 
 /* A.9.7. VideoStreaming Interface Control Selectors */
 #define UVC_VS_CONTROL_UNDEFINED			0x00
@@ -300,12 +310,14 @@ struct uvc_processing_unit_descriptor {
 	__u8   bSourceID;
 	__le16 wMaxMultiplier;
 	__u8   bControlSize;
-	__u8   bmControls[2];
+	__u8   bmControls[3];
 	__u8   iProcessing;
+	/* UVC 1.1 adds the following member */
 	__u8   bmVideoStandards;
 } __attribute__((__packed__));
 
-#define UVC_DT_PROCESSING_UNIT_SIZE(n)			(10+(n))
+#define UVC_DT_PROCESSING_UNIT_SIZE(v, n)		((__u8) \
+	(((v) == UVC_VERSION_1_0) ? (9+(n)) : ((10+(n)))))
 
 /* 3.7.2.6. Extension Unit Descriptor */
 struct uvc_extension_unit_descriptor {
@@ -447,13 +459,24 @@ struct uvc_streaming_control {
 	__u16 wDelay;
 	__u32 dwMaxVideoFrameSize;
 	__u32 dwMaxPayloadTransferSize;
+	/* UVC 1.1 adds the following members */
 	__u32 dwClockFrequency;
 	__u8  bmFramingInfo;
 	__u8  bPreferedVersion;
 	__u8  bMinVersion;
 	__u8  bMaxVersion;
+	/* UVC 1.5 adds the following members */
+	__u8  bUsage;
+	__u8  bBitDepthLuma;
+	__u8  bmSettings;
+	__u8  bMaxNumberOfRefFramesPlus1;
+	__u16 bmRateControlModes;
+	__u16 bmLayoutPerStream[4];
 } __attribute__((__packed__));
 
+#define UVC_STREAMING_CONTROL_SIZE(v)			\
+	(((v) == UVC_VERSION_1_0) ? 26 : (((v) == UVC_VERSION_1_1) ? 34 : 48))
+
 /* Uncompressed Payload - 3.1.1. Uncompressed Video Format Descriptor */
 struct uvc_format_uncompressed {
 	__u8  bLength;
-- 
2.17.1

