Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2384B4044
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 04:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239974AbiBND1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 22:27:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbiBND1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 22:27:00 -0500
Received: from tkylinode-sdnproxy-1.icoremail.net (tkylinode-sdnproxy-1.icoremail.net [139.162.70.28])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id A4B02546B0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 19:26:52 -0800 (PST)
Received: from jleng.ambarella.net (unknown [116.246.37.178])
        by mail-app3 (Coremail) with SMTP id cC_KCgBnv6XQywliDz43DQ--.64695S2;
        Mon, 14 Feb 2022 11:26:13 +0800 (CST)
From:   3090101217@zju.edu.cn
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        ruslan.bilovol@gmail.com, pavel.hofman@ivitera.com,
        jbrunet@baylibre.com, jackp@codeaurora.org, colin.king@intel.com,
        pawell@cadence.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jing Leng <jleng@ambarella.com>
Subject: [PATCH] usb: gadget: f_uac2: fix superspeed transfer
Date:   Mon, 14 Feb 2022 11:26:06 +0800
Message-Id: <20220214032606.17227-1-3090101217@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgBnv6XQywliDz43DQ--.64695S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw48Jr1DWryfArW3Ar1UZFb_yoW5AFyfpw
        n8C39rtr45Ar4Yga1rAr4kAr43AFWIyayYkrWIv34avFsaq34ktF1Iyr1YkFyUAFyYyw10
        vF4Ykw47u3W7ur7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBEb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2vYz4IE4I80cI0F6IAv
        xc0EwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
        Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
        6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7M4kE6xkIj40Ew7
        xC0wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jeBT5UUUUU
        =
X-CM-SenderInfo: qtqziiyqrsilo62m3hxhgxhubq/1tbiAwQRBVNG3FHYyQAIsS
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Leng <jleng@ambarella.com>

ss_ep_int_desc endpoint doesn't have 'SuperSpeed Endpoint
Companion Descriptor', so we should add it.

Signed-off-by: Jing Leng <jleng@ambarella.com>
---
 drivers/usb/gadget/function/f_uac2.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index 097a709549d6..a6fc492f9148 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -282,6 +282,14 @@ static struct usb_endpoint_descriptor ss_ep_int_desc = {
 	.bInterval = 4,
 };
 
+static struct usb_ss_ep_comp_descriptor ss_ep_int_desc_comp = {
+	.bLength = sizeof(ss_ep_int_desc_comp),
+	.bDescriptorType = USB_DT_SS_ENDPOINT_COMP,
+	.bMaxBurst = 0,
+	.bmAttributes = 0,
+	.wBytesPerInterval = cpu_to_le16(6),
+};
+
 /* Audio Streaming OUT Interface - Alt0 */
 static struct usb_interface_descriptor std_as_out_if0_desc = {
 	.bLength = sizeof std_as_out_if0_desc,
@@ -595,7 +603,8 @@ static struct usb_descriptor_header *ss_audio_desc[] = {
 	(struct usb_descriptor_header *)&in_feature_unit_desc,
 	(struct usb_descriptor_header *)&io_out_ot_desc,
 
-  (struct usb_descriptor_header *)&ss_ep_int_desc,
+	(struct usb_descriptor_header *)&ss_ep_int_desc,
+	(struct usb_descriptor_header *)&ss_ep_int_desc_comp,
 
 	(struct usb_descriptor_header *)&std_as_out_if0_desc,
 	(struct usb_descriptor_header *)&std_as_out_if1_desc,
@@ -657,6 +666,7 @@ static int set_ep_max_packet_size(const struct f_uac2_opts *uac2_opts,
 
 	case USB_SPEED_HIGH:
 	case USB_SPEED_SUPER:
+	case USB_SPEED_SUPER_PLUS:
 		max_size_ep = 1024;
 		factor = 8000;
 		break;
@@ -723,6 +733,7 @@ static void setup_headers(struct f_uac2_opts *opts,
 	struct usb_ss_ep_comp_descriptor *epout_desc_comp = NULL;
 	struct usb_ss_ep_comp_descriptor *epin_desc_comp = NULL;
 	struct usb_ss_ep_comp_descriptor *epin_fback_desc_comp = NULL;
+	struct usb_ss_ep_comp_descriptor *ep_int_desc_comp = NULL;
 	struct usb_endpoint_descriptor *epout_desc;
 	struct usb_endpoint_descriptor *epin_desc;
 	struct usb_endpoint_descriptor *epin_fback_desc;
@@ -750,6 +761,7 @@ static void setup_headers(struct f_uac2_opts *opts,
 		epin_fback_desc = &ss_epin_fback_desc;
 		epin_fback_desc_comp = &ss_epin_fback_desc_comp;
 		ep_int_desc = &ss_ep_int_desc;
+		ep_int_desc_comp = &ss_ep_int_desc_comp;
 	}
 
 	i = 0;
@@ -778,8 +790,11 @@ static void setup_headers(struct f_uac2_opts *opts,
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
2.17.1

