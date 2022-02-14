Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107294B5368
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355179AbiBNOdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:33:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiBNOdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:33:40 -0500
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 8204A4A3FC;
        Mon, 14 Feb 2022 06:33:30 -0800 (PST)
Received: from jleng.ambarella.net (unknown [116.246.37.178])
        by mail-app2 (Coremail) with SMTP id by_KCgDHzIQAaApizCzkAQ--.27842S2;
        Mon, 14 Feb 2022 22:32:53 +0800 (CST)
From:   3090101217@zju.edu.cn
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        ruslan.bilovol@gmail.com, pavel.hofman@ivitera.com,
        jbrunet@baylibre.com, jackp@codeaurora.org, colin.king@intel.com,
        pawell@cadence.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jing Leng <jleng@ambarella.com>
Subject: [PATCH v2] usb: gadget: f_uac2: fix superspeed transfer
Date:   Mon, 14 Feb 2022 22:32:23 +0800
Message-Id: <20220214143223.5658-1-3090101217@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220214032606.17227-1-3090101217@zju.edu.cn>
References: <20220214032606.17227-1-3090101217@zju.edu.cn>
X-CM-TRANSID: by_KCgDHzIQAaApizCzkAQ--.27842S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1UGFy5WF1ktw4xZF18Zrb_yoWrJF45pw
        n8C39rtrW5Ar4aga1rAr4UAr43AFWIyayYkFW2vw12vF4Sq34ktF1Iyr1YkFyUAFyYyw10
        vF4jkw47W3Zrur7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPjb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAac4AC6xC2jxv24VCS
        YI8q64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64
        k0F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
        xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
        kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
        6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
        CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2KZXUUUU
        U
X-CM-SenderInfo: qtqziiyqrsilo62m3hxhgxhubq/1tbiAwQRBVNG3FHYyQAPsV
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

If we use SuperSpeed UDC, host can't recognize the device if endpoint
doesn't have 'SuperSpeed Endpoint Companion Descriptor' followed.

Currently in the uac2 driver code:
1. ss_epout_desc_comp follows ss_epout_desc;
2. ss_epin_fback_desc_comp follows ss_epin_fback_desc;
3. ss_epin_desc_comp follows ss_epin_desc;
4. Only ss_ep_int_desc endpoint doesn't have 'SuperSpeed Endpoint
Companion Descriptor' followed, so we should add it.

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

