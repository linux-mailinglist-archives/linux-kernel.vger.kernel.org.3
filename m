Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826714B9661
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiBQDLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:11:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiBQDLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:11:14 -0500
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 35AAE23D5D9;
        Wed, 16 Feb 2022 19:10:58 -0800 (PST)
Received: from jleng.ambarella.net (unknown [180.169.129.130])
        by mail-app2 (Coremail) with SMTP id by_KCgBHTISsvA1itbXyAQ--.43101S2;
        Thu, 17 Feb 2022 11:10:42 +0800 (CST)
From:   3090101217@zju.edu.cn
To:     gregkh@linuxfoundation.org, balbi@kernel.org,
        laurent.pinchart@ideasonboard.com
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Jing Leng <jleng@ambarella.com>
Subject: [PATCH v3] usb: gadget: f_uvc: add superspeed plus transfer support
Date:   Thu, 17 Feb 2022 11:10:35 +0800
Message-Id: <20220217031035.6150-1-3090101217@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <e3311c8.a65f5.17f059d63df.Coremail.3090101217@zju.edu.cn>
References: <e3311c8.a65f5.17f059d63df.Coremail.3090101217@zju.edu.cn>
X-CM-TRANSID: by_KCgBHTISsvA1itbXyAQ--.43101S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFyftw4DZw17ZF45GFyUJrb_yoW5Xw4Upa
        15A3Z5Ary5JFn5J34UJan5Cry3XF4SvayDKFZFq3yY9rW3tas5Ar9Fyr1rKa47XFsxZr40
        yFnrA3yIkw10krJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBSb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2vYz4IE4I80cI0F6IAv
        xc0EwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
        Av7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
        6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCY02Avz4vE14v_Gr4l42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
        Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxeHqDUUUU
X-CM-SenderInfo: qtqziiyqrsilo62m3hxhgxhubq/1tbiAwIEBVNG3FjlrQABsY
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Leng <jleng@ambarella.com>

UVC driver doesn't set ssp_descriptors in struct usb_function,
it doesn't support USB_SPEED_SUPER_PLUS transfer. So we can
refer to USB_SPEED_SUPER to realize the support of
USB_SPEED_SUPER_PLUS.

If users use a USB device controller that speed can be up to
USB_SPEED_SUPER_PLUS (10 Gbps), downgrading to USB_SPEED_SUPER
(5 Gbps) is not a good performance. In addition, it triggers a
warning "configfs-gadget gadget: uvc doesn't hold the descriptors
for current speed".

Signed-off-by: Jing Leng <jleng@ambarella.com>
---
ChangeLog v2->v3:
- Modify the title and description of the PATCH
- It is a feature but not a bug
ChangeLog v1->v2:
- Update more detailed description of the PATCH
---
 drivers/usb/gadget/function/f_uvc.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 71bb5e477dba..8fc9b035481e 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -478,6 +478,7 @@ uvc_copy_descriptors(struct uvc_device *uvc, enum usb_device_speed speed)
 	void *mem;
 
 	switch (speed) {
+	case USB_SPEED_SUPER_PLUS:
 	case USB_SPEED_SUPER:
 		uvc_control_desc = uvc->desc.ss_control;
 		uvc_streaming_cls = uvc->desc.ss_streaming;
@@ -521,7 +522,7 @@ uvc_copy_descriptors(struct uvc_device *uvc, enum usb_device_speed speed)
 	      + uvc_control_ep.bLength + uvc_control_cs_ep.bLength
 	      + uvc_streaming_intf_alt0.bLength;
 
-	if (speed == USB_SPEED_SUPER) {
+	if (speed == USB_SPEED_SUPER || speed == USB_SPEED_SUPER_PLUS) {
 		bytes += uvc_ss_control_comp.bLength;
 		n_desc = 6;
 	} else {
@@ -565,7 +566,7 @@ uvc_copy_descriptors(struct uvc_device *uvc, enum usb_device_speed speed)
 	uvc_control_header->baInterfaceNr[0] = uvc->streaming_intf;
 
 	UVC_COPY_DESCRIPTOR(mem, dst, &uvc_control_ep);
-	if (speed == USB_SPEED_SUPER)
+	if (speed == USB_SPEED_SUPER || speed == USB_SPEED_SUPER_PLUS)
 		UVC_COPY_DESCRIPTOR(mem, dst, &uvc_ss_control_comp);
 
 	UVC_COPY_DESCRIPTOR(mem, dst, &uvc_control_cs_ep);
@@ -727,6 +728,15 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 		}
 	}
 
+	if (gadget_is_superspeed_plus(c->cdev->gadget)) {
+		f->ssp_descriptors = uvc_copy_descriptors(uvc, USB_SPEED_SUPER_PLUS);
+		if (IS_ERR(f->ssp_descriptors)) {
+			ret = PTR_ERR(f->ssp_descriptors);
+			f->ssp_descriptors = NULL;
+			goto error;
+		}
+	}
+
 	/* Preallocate control endpoint request. */
 	uvc->control_req = usb_ep_alloc_request(cdev->gadget->ep0, GFP_KERNEL);
 	uvc->control_buf = kmalloc(UVC_MAX_REQUEST_SIZE, GFP_KERNEL);
-- 
2.17.1

