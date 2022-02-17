Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E373F4B981C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 06:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbiBQFUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 00:20:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbiBQFUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 00:20:36 -0500
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 4372E2A598B;
        Wed, 16 Feb 2022 21:20:18 -0800 (PST)
Received: from jleng.ambarella.net (unknown [180.169.129.130])
        by mail-app4 (Coremail) with SMTP id cS_KCgCXD4P52g1i4jM9CQ--.26372S2;
        Thu, 17 Feb 2022 13:19:59 +0800 (CST)
From:   3090101217@zju.edu.cn
To:     gregkh@linuxfoundation.org, balbi@kernel.org,
        pavel.hofman@ivitera.com, ruslan.bilovol@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Jing Leng <jleng@ambarella.com>
Subject: [PATCH v4] usb: gadget: f_uac1: add different speed transfers support
Date:   Thu, 17 Feb 2022 13:19:51 +0800
Message-Id: <20220217051951.7466-1-3090101217@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <649b6b8a.a6d4b.17f06169537.Coremail.3090101217@zju.edu.cn>
References: <649b6b8a.a6d4b.17f06169537.Coremail.3090101217@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cS_KCgCXD4P52g1i4jM9CQ--.26372S2
X-Coremail-Antispam: 1UD129KBjvAXoW3CrW7JF4fAw4fZF43Xr4fZrb_yoW8Ww15Zo
        WDJFsYy34FqF1UXry8GF18WF18ZF1xCFsxXry5Jr9xZ3yI934Y9asrC3WDWa13JF1fC3WD
        Wa4UWa1DZa97Gr48n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYt7k0a2IF6w4kM7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0
        x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj4
        1l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0
        I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWlnxkEFVCFx7IYxxCE
        VcI25VAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxkIecxEwVAFwVW8WwCF04
        k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
        MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr4
        1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
        IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
        A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07b5WrAUUUUU=
X-CM-SenderInfo: qtqziiyqrsilo62m3hxhgxhubq/1tbiAwIEBVNG3FjlrQADsa
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Leng <jleng@ambarella.com>

On page 61 of the UAC1 specification (
https://www.usb.org/sites/default/files/audio10.pdf),
bInterval is interval for polling endpoint for data transfers
expressed in milliseconds, must be set to 1.

On page 47 of the USB2.0 specification (
https://www.usb.org/sites/default/files/usb_20_20211008.zip),
An isochronous endpoint must specify its required bus access period.
Full-/high-speed endpoints must specify a desired period as
(2^(bInterval-1)) x F, where bInterval is in the range one to
(and including) 16 and F is 125 μs for high-speed and 1ms for full-speed.

On page 362 of the USB3.2 specification (
https://usb.org/sites/default/files/usb_32_20210125.zip),
The 'SuperSpeed Endpoint Companion Descriptor' shall only be
returned by Enhanced SuperSpeed devices that are operating at Gen X speed.
Each endpoint described in an interface is followed by a 'SuperSpeed
Endpoint Companion Descriptor'.

Currently uac1 driver doesn't set bInterval to 1 in full speed transfer
and doesn't have a 'SuperSpeed Endpoint Companion Descriptor' behind
'Standard Endpoint Descriptor'.

So we should set bInterval to 1 in full speed transfer and set it to 4
in other speed transfers, and we should add 'SuperSpeed Endpoint Companion
Descriptor' behind 'Standard Endpoint Descriptor' for superspeed transfer.

Signed-off-by: Jing Leng <jleng@ambarella.com>
---
ChangeLog v3->v4:
- Remove static variables which are explicitly initialized to 0
ChangeLog v2->v3:
- Add 'static' before 'struct usb_ss_ep_comp_descriptor ac_int_ep_desc_comp'.
ChangeLog v1->v2:
- Modify the title of the PATCH
- Update more detailed description of the PATCH
---
 drivers/usb/gadget/function/f_uac1.c | 269 ++++++++++++++++++++++-----
 1 file changed, 219 insertions(+), 50 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/function/f_uac1.c
index 03f50643fbba..d03d4ce048b6 100644
--- a/drivers/usb/gadget/function/f_uac1.c
+++ b/drivers/usb/gadget/function/f_uac1.c
@@ -123,6 +123,15 @@ static struct uac_feature_unit_descriptor *in_feature_unit_desc;
 static struct uac_feature_unit_descriptor *out_feature_unit_desc;
 
 /* AC IN Interrupt Endpoint */
+static struct usb_endpoint_descriptor fs_int_ep_desc = {
+	.bLength = USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType = USB_DT_ENDPOINT,
+	.bEndpointAddress = USB_DIR_IN,
+	.bmAttributes = USB_ENDPOINT_XFER_INT,
+	.wMaxPacketSize = cpu_to_le16(2),
+	.bInterval = 1,
+};
+
 static struct usb_endpoint_descriptor ac_int_ep_desc = {
 	.bLength = USB_DT_ENDPOINT_SIZE,
 	.bDescriptorType = USB_DT_ENDPOINT,
@@ -132,6 +141,12 @@ static struct usb_endpoint_descriptor ac_int_ep_desc = {
 	.bInterval = 4,
 };
 
+static struct usb_ss_ep_comp_descriptor ac_int_ep_desc_comp = {
+	.bLength = sizeof(ac_int_ep_desc_comp),
+	.bDescriptorType = USB_DT_SS_ENDPOINT_COMP,
+	.wBytesPerInterval = cpu_to_le16(2),
+};
+
 /* B.4.1  Standard AS Interface Descriptor */
 static struct usb_interface_descriptor as_out_interface_alt_0_desc = {
 	.bLength =		USB_DT_INTERFACE_SIZE,
@@ -201,6 +216,16 @@ static struct uac_format_type_i_discrete_descriptor_1 as_out_type_i_desc = {
 };
 
 /* Standard ISO OUT Endpoint Descriptor */
+static struct usb_endpoint_descriptor fs_out_ep_desc  = {
+	.bLength =		USB_DT_ENDPOINT_AUDIO_SIZE,
+	.bDescriptorType =	USB_DT_ENDPOINT,
+	.bEndpointAddress =	USB_DIR_OUT,
+	.bmAttributes =		USB_ENDPOINT_SYNC_ADAPTIVE
+				| USB_ENDPOINT_XFER_ISOC,
+	.wMaxPacketSize	=	cpu_to_le16(UAC1_OUT_EP_MAX_PACKET_SIZE),
+	.bInterval =		1,
+};
+
 static struct usb_endpoint_descriptor as_out_ep_desc  = {
 	.bLength =		USB_DT_ENDPOINT_AUDIO_SIZE,
 	.bDescriptorType =	USB_DT_ENDPOINT,
@@ -211,6 +236,12 @@ static struct usb_endpoint_descriptor as_out_ep_desc  = {
 	.bInterval =		4,
 };
 
+static struct usb_ss_ep_comp_descriptor as_out_ep_desc_comp = {
+	.bLength		= sizeof(as_out_ep_desc_comp),
+	.bDescriptorType	= USB_DT_SS_ENDPOINT_COMP,
+	.wBytesPerInterval	= cpu_to_le16(UAC1_OUT_EP_MAX_PACKET_SIZE),
+};
+
 /* Class-specific AS ISO OUT Endpoint Descriptor */
 static struct uac_iso_endpoint_descriptor as_iso_out_desc = {
 	.bLength =		UAC_ISO_ENDPOINT_DESC_SIZE,
@@ -231,7 +262,17 @@ static struct uac_format_type_i_discrete_descriptor_1 as_in_type_i_desc = {
 	.bSamFreqType =		1,
 };
 
-/* Standard ISO OUT Endpoint Descriptor */
+/* Standard ISO IN Endpoint Descriptor */
+static struct usb_endpoint_descriptor fs_in_ep_desc  = {
+	.bLength =		USB_DT_ENDPOINT_AUDIO_SIZE,
+	.bDescriptorType =	USB_DT_ENDPOINT,
+	.bEndpointAddress =	USB_DIR_IN,
+	.bmAttributes =		USB_ENDPOINT_SYNC_ASYNC
+				| USB_ENDPOINT_XFER_ISOC,
+	.wMaxPacketSize	=	cpu_to_le16(UAC1_OUT_EP_MAX_PACKET_SIZE),
+	.bInterval =		1,
+};
+
 static struct usb_endpoint_descriptor as_in_ep_desc  = {
 	.bLength =		USB_DT_ENDPOINT_AUDIO_SIZE,
 	.bDescriptorType =	USB_DT_ENDPOINT,
@@ -242,6 +283,12 @@ static struct usb_endpoint_descriptor as_in_ep_desc  = {
 	.bInterval =		4,
 };
 
+static struct usb_ss_ep_comp_descriptor as_in_ep_desc_comp = {
+	.bLength		= sizeof(as_in_ep_desc_comp),
+	.bDescriptorType	= USB_DT_SS_ENDPOINT_COMP,
+	.wBytesPerInterval	= cpu_to_le16(UAC1_OUT_EP_MAX_PACKET_SIZE),
+};
+
 /* Class-specific AS ISO OUT Endpoint Descriptor */
 static struct uac_iso_endpoint_descriptor as_iso_in_desc = {
 	.bLength =		UAC_ISO_ENDPOINT_DESC_SIZE,
@@ -252,7 +299,75 @@ static struct uac_iso_endpoint_descriptor as_iso_in_desc = {
 	.wLockDelay =		0,
 };
 
-static struct usb_descriptor_header *f_audio_desc[] = {
+static struct usb_descriptor_header *fs_audio_desc[] = {
+	(struct usb_descriptor_header *)&ac_interface_desc,
+	(struct usb_descriptor_header *)&ac_header_desc,
+
+	(struct usb_descriptor_header *)&usb_out_it_desc,
+	(struct usb_descriptor_header *)&io_out_ot_desc,
+	(struct usb_descriptor_header *)&out_feature_unit_desc,
+
+	(struct usb_descriptor_header *)&io_in_it_desc,
+	(struct usb_descriptor_header *)&usb_in_ot_desc,
+	(struct usb_descriptor_header *)&in_feature_unit_desc,
+
+	(struct usb_descriptor_header *)&fs_int_ep_desc,
+
+	(struct usb_descriptor_header *)&as_out_interface_alt_0_desc,
+	(struct usb_descriptor_header *)&as_out_interface_alt_1_desc,
+	(struct usb_descriptor_header *)&as_out_header_desc,
+
+	(struct usb_descriptor_header *)&as_out_type_i_desc,
+
+	(struct usb_descriptor_header *)&fs_out_ep_desc,
+	(struct usb_descriptor_header *)&as_iso_out_desc,
+
+	(struct usb_descriptor_header *)&as_in_interface_alt_0_desc,
+	(struct usb_descriptor_header *)&as_in_interface_alt_1_desc,
+	(struct usb_descriptor_header *)&as_in_header_desc,
+
+	(struct usb_descriptor_header *)&as_in_type_i_desc,
+
+	(struct usb_descriptor_header *)&fs_in_ep_desc,
+	(struct usb_descriptor_header *)&as_iso_in_desc,
+	NULL,
+};
+
+static struct usb_descriptor_header *hs_audio_desc[] = {
+	(struct usb_descriptor_header *)&ac_interface_desc,
+	(struct usb_descriptor_header *)&ac_header_desc,
+
+	(struct usb_descriptor_header *)&usb_out_it_desc,
+	(struct usb_descriptor_header *)&io_out_ot_desc,
+	(struct usb_descriptor_header *)&out_feature_unit_desc,
+
+	(struct usb_descriptor_header *)&io_in_it_desc,
+	(struct usb_descriptor_header *)&usb_in_ot_desc,
+	(struct usb_descriptor_header *)&in_feature_unit_desc,
+
+	(struct usb_descriptor_header *)&ac_int_ep_desc,
+
+	(struct usb_descriptor_header *)&as_out_interface_alt_0_desc,
+	(struct usb_descriptor_header *)&as_out_interface_alt_1_desc,
+	(struct usb_descriptor_header *)&as_out_header_desc,
+
+	(struct usb_descriptor_header *)&as_out_type_i_desc,
+
+	(struct usb_descriptor_header *)&as_out_ep_desc,
+	(struct usb_descriptor_header *)&as_iso_out_desc,
+
+	(struct usb_descriptor_header *)&as_in_interface_alt_0_desc,
+	(struct usb_descriptor_header *)&as_in_interface_alt_1_desc,
+	(struct usb_descriptor_header *)&as_in_header_desc,
+
+	(struct usb_descriptor_header *)&as_in_type_i_desc,
+
+	(struct usb_descriptor_header *)&as_in_ep_desc,
+	(struct usb_descriptor_header *)&as_iso_in_desc,
+	NULL,
+};
+
+static struct usb_descriptor_header *ss_audio_desc[] = {
 	(struct usb_descriptor_header *)&ac_interface_desc,
 	(struct usb_descriptor_header *)&ac_header_desc,
 
@@ -265,6 +380,7 @@ static struct usb_descriptor_header *f_audio_desc[] = {
 	(struct usb_descriptor_header *)&in_feature_unit_desc,
 
 	(struct usb_descriptor_header *)&ac_int_ep_desc,
+	(struct usb_descriptor_header *)&ac_int_ep_desc_comp,
 
 	(struct usb_descriptor_header *)&as_out_interface_alt_0_desc,
 	(struct usb_descriptor_header *)&as_out_interface_alt_1_desc,
@@ -273,6 +389,7 @@ static struct usb_descriptor_header *f_audio_desc[] = {
 	(struct usb_descriptor_header *)&as_out_type_i_desc,
 
 	(struct usb_descriptor_header *)&as_out_ep_desc,
+	(struct usb_descriptor_header *)&as_out_ep_desc_comp,
 	(struct usb_descriptor_header *)&as_iso_out_desc,
 
 	(struct usb_descriptor_header *)&as_in_interface_alt_0_desc,
@@ -282,6 +399,7 @@ static struct usb_descriptor_header *f_audio_desc[] = {
 	(struct usb_descriptor_header *)&as_in_type_i_desc,
 
 	(struct usb_descriptor_header *)&as_in_ep_desc,
+	(struct usb_descriptor_header *)&as_in_ep_desc_comp,
 	(struct usb_descriptor_header *)&as_iso_in_desc,
 	NULL,
 };
@@ -329,6 +447,89 @@ static struct usb_gadget_strings *uac1_strings[] = {
 	NULL,
 };
 
+/* Use macro to overcome line length limitation */
+#define USBDHDR(p) ((struct usb_descriptor_header *)(p))
+
+static void setup_headers(struct f_uac1_opts *opts,
+			  struct usb_descriptor_header **headers,
+			  enum usb_device_speed speed)
+{
+	struct usb_ss_ep_comp_descriptor *epout_desc_comp = NULL;
+	struct usb_ss_ep_comp_descriptor *epin_desc_comp = NULL;
+	struct usb_ss_ep_comp_descriptor *ep_int_desc_comp = NULL;
+	struct usb_endpoint_descriptor *epout_desc;
+	struct usb_endpoint_descriptor *epin_desc;
+	struct usb_endpoint_descriptor *ep_int_desc;
+	int i;
+
+	switch (speed) {
+	case USB_SPEED_FULL:
+		epout_desc = &fs_out_ep_desc;
+		epin_desc = &fs_in_ep_desc;
+		ep_int_desc = &fs_int_ep_desc;
+		break;
+	case USB_SPEED_HIGH:
+		epout_desc = &as_out_ep_desc;
+		epin_desc = &as_in_ep_desc;
+		ep_int_desc = &ac_int_ep_desc;
+		break;
+	default:
+		epout_desc = &as_out_ep_desc;
+		epout_desc_comp = &as_out_ep_desc_comp;
+		epin_desc = &as_in_ep_desc;
+		epin_desc_comp = &as_in_ep_desc_comp;
+		ep_int_desc = &ac_int_ep_desc;
+		ep_int_desc_comp = &ac_int_ep_desc_comp;
+		break;
+	}
+
+	i = 0;
+	headers[i++] = USBDHDR(&ac_interface_desc);
+	headers[i++] = USBDHDR(ac_header_desc);
+
+	if (EPOUT_EN(opts)) {
+		headers[i++] = USBDHDR(&usb_out_it_desc);
+		headers[i++] = USBDHDR(&io_out_ot_desc);
+		if (FUOUT_EN(opts))
+			headers[i++] = USBDHDR(out_feature_unit_desc);
+	}
+
+	if (EPIN_EN(opts)) {
+		headers[i++] = USBDHDR(&io_in_it_desc);
+		headers[i++] = USBDHDR(&usb_in_ot_desc);
+		if (FUIN_EN(opts))
+			headers[i++] = USBDHDR(in_feature_unit_desc);
+	}
+
+	if (FUOUT_EN(opts) || FUIN_EN(opts)) {
+		headers[i++] = USBDHDR(ep_int_desc);
+		if (ep_int_desc_comp)
+			headers[i++] = USBDHDR(ep_int_desc_comp);
+	}
+
+	if (EPOUT_EN(opts)) {
+		headers[i++] = USBDHDR(&as_out_interface_alt_0_desc);
+		headers[i++] = USBDHDR(&as_out_interface_alt_1_desc);
+		headers[i++] = USBDHDR(&as_out_header_desc);
+		headers[i++] = USBDHDR(&as_out_type_i_desc);
+		headers[i++] = USBDHDR(epout_desc);
+		if (epout_desc_comp)
+			headers[i++] = USBDHDR(epout_desc_comp);
+		headers[i++] = USBDHDR(&as_iso_out_desc);
+	}
+	if (EPIN_EN(opts)) {
+		headers[i++] = USBDHDR(&as_in_interface_alt_0_desc);
+		headers[i++] = USBDHDR(&as_in_interface_alt_1_desc);
+		headers[i++] = USBDHDR(&as_in_header_desc);
+		headers[i++] = USBDHDR(&as_in_type_i_desc);
+		headers[i++] = USBDHDR(epin_desc);
+		if (epin_desc_comp)
+			headers[i++] = USBDHDR(epin_desc_comp);
+		headers[i++] = USBDHDR(&as_iso_in_desc);
+	}
+	headers[i] = NULL;
+}
+
 /*
  * This function is an ALSA sound card following USB Audio Class Spec 1.0.
  */
@@ -957,9 +1158,6 @@ uac1_ac_header_descriptor *build_ac_header_desc(struct f_uac1_opts *opts)
 	return ac_desc;
 }
 
-/* Use macro to overcome line length limitation */
-#define USBDHDR(p) (struct usb_descriptor_header *)(p)
-
 static void setup_descriptor(struct f_uac1_opts *opts)
 {
 	/* patch descriptors */
@@ -1015,44 +1213,9 @@ static void setup_descriptor(struct f_uac1_opts *opts)
 		ac_header_desc->wTotalLength = cpu_to_le16(len);
 	}
 
-	i = 0;
-	f_audio_desc[i++] = USBDHDR(&ac_interface_desc);
-	f_audio_desc[i++] = USBDHDR(ac_header_desc);
-
-	if (EPOUT_EN(opts)) {
-		f_audio_desc[i++] = USBDHDR(&usb_out_it_desc);
-		f_audio_desc[i++] = USBDHDR(&io_out_ot_desc);
-		if (FUOUT_EN(opts))
-			f_audio_desc[i++] = USBDHDR(out_feature_unit_desc);
-	}
-
-	if (EPIN_EN(opts)) {
-		f_audio_desc[i++] = USBDHDR(&io_in_it_desc);
-		f_audio_desc[i++] = USBDHDR(&usb_in_ot_desc);
-		if (FUIN_EN(opts))
-			f_audio_desc[i++] = USBDHDR(in_feature_unit_desc);
-	}
-
-	if (FUOUT_EN(opts) || FUIN_EN(opts))
-		f_audio_desc[i++] = USBDHDR(&ac_int_ep_desc);
-
-	if (EPOUT_EN(opts)) {
-		f_audio_desc[i++] = USBDHDR(&as_out_interface_alt_0_desc);
-		f_audio_desc[i++] = USBDHDR(&as_out_interface_alt_1_desc);
-		f_audio_desc[i++] = USBDHDR(&as_out_header_desc);
-		f_audio_desc[i++] = USBDHDR(&as_out_type_i_desc);
-		f_audio_desc[i++] = USBDHDR(&as_out_ep_desc);
-		f_audio_desc[i++] = USBDHDR(&as_iso_out_desc);
-	}
-	if (EPIN_EN(opts)) {
-		f_audio_desc[i++] = USBDHDR(&as_in_interface_alt_0_desc);
-		f_audio_desc[i++] = USBDHDR(&as_in_interface_alt_1_desc);
-		f_audio_desc[i++] = USBDHDR(&as_in_header_desc);
-		f_audio_desc[i++] = USBDHDR(&as_in_type_i_desc);
-		f_audio_desc[i++] = USBDHDR(&as_in_ep_desc);
-		f_audio_desc[i++] = USBDHDR(&as_iso_in_desc);
-	}
-	f_audio_desc[i] = NULL;
+	setup_headers(opts, fs_audio_desc, USB_SPEED_FULL);
+	setup_headers(opts, hs_audio_desc, USB_SPEED_HIGH);
+	setup_headers(opts, ss_audio_desc, USB_SPEED_SUPER);
 }
 
 static int f_audio_validate_opts(struct g_audio *audio, struct device *dev)
@@ -1264,7 +1427,6 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 		if (!ep)
 			goto err_free_fu;
 		uac1->int_ep = ep;
-		uac1->int_ep->desc = &ac_int_ep_desc;
 
 		ac_interface_desc.bNumEndpoints = 1;
 	}
@@ -1275,7 +1437,6 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 		if (!ep)
 			goto err_free_fu;
 		audio->out_ep = ep;
-		audio->out_ep->desc = &as_out_ep_desc;
 	}
 
 	if (EPIN_EN(audio_opts)) {
@@ -1283,19 +1444,27 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 		if (!ep)
 			goto err_free_fu;
 		audio->in_ep = ep;
-		audio->in_ep->desc = &as_in_ep_desc;
 	}
 
+	/* FS endpoint addresses are copied from autoconfigured HS descriptors */
+	fs_int_ep_desc.bEndpointAddress = ac_int_ep_desc.bEndpointAddress;
+	fs_out_ep_desc.bEndpointAddress = as_out_ep_desc.bEndpointAddress;
+	fs_in_ep_desc.bEndpointAddress = as_in_ep_desc.bEndpointAddress;
+
 	setup_descriptor(audio_opts);
 
 	/* copy descriptors, and track endpoint copies */
-	status = usb_assign_descriptors(f, f_audio_desc, f_audio_desc, NULL,
-					NULL);
+	status = usb_assign_descriptors(f, fs_audio_desc, hs_audio_desc,
+					ss_audio_desc, ss_audio_desc);
 	if (status)
 		goto err_free_fu;
 
-	audio->out_ep_maxpsize = le16_to_cpu(as_out_ep_desc.wMaxPacketSize);
-	audio->in_ep_maxpsize = le16_to_cpu(as_in_ep_desc.wMaxPacketSize);
+	audio->out_ep_maxpsize = max_t(u16,
+				le16_to_cpu(fs_out_ep_desc.wMaxPacketSize),
+				le16_to_cpu(as_out_ep_desc.wMaxPacketSize));
+	audio->in_ep_maxpsize = max_t(u16,
+				le16_to_cpu(fs_in_ep_desc.wMaxPacketSize),
+				le16_to_cpu(as_in_ep_desc.wMaxPacketSize));
 	audio->params.c_chmask = audio_opts->c_chmask;
 	audio->params.c_srate = audio_opts->c_srate;
 	audio->params.c_ssize = audio_opts->c_ssize;
-- 
2.17.1

