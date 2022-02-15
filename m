Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9A14B60E1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 03:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbiBOCRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 21:17:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbiBOCRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 21:17:41 -0500
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 7B2B564F0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:17:31 -0800 (PST)
Received: from jleng.ambarella.net (unknown [116.246.37.178])
        by mail-app3 (Coremail) with SMTP id cC_KCgCXD1MWDQti9F1EDQ--.983S2;
        Tue, 15 Feb 2022 10:17:01 +0800 (CST)
From:   3090101217@zju.edu.cn
To:     gregkh@linuxfoundation.org
Cc:     balbi@kernel.org, jleng@ambarella.com,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v2] usb: gadget: f_uvc: fix superspeedplus transfer
Date:   Tue, 15 Feb 2022 10:16:47 +0800
Message-Id: <20220215021647.4316-1-3090101217@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <Ygow+EB1P84VflBb@kroah.com>
References: <Ygow+EB1P84VflBb@kroah.com>
X-CM-TRANSID: cC_KCgCXD1MWDQti9F1EDQ--.983S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFykGFyfZF1xJr4xWr48WFg_yoW5AFyDpa
        15A3WrAr45JFs5Xw48Aan5ury3Xa1fZa1DKrZ2q345ur43t3s5Ar90yryFg347XF45Zr48
        CFsrJw4Skw1jkr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9vb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2vYz4IE4I80cI0F6IAv
        xc0EwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
        Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
        6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr
        0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8GsjUUUUUU==
X-CM-SenderInfo: qtqziiyqrsilo62m3hxhgxhubq/1tbiAwQRBVNG3FHYyQAUsO
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Leng <jleng@ambarella.com>

UVC driver doesn't set ssp_descriptors in struct usb_function,
If UVC uses superspeedplus UDC (e.g. cdnsp), when
config_ep_by_speed_and_alt is called, the g->speed is
USB_SPEED_SUPER_PLUS, and f->ssp_descriptors is NULL,
So kernel will access NULL pointer of speed_desc.

Call trace:
 config_ep_by_speed_and_alt+0x3c/0x2a0 [libcomposite]
 uvc_function_set_alt+0xd4/0x2e8 [usb_f_uvc]
 set_config.constprop.0+0x154/0x3a0 [libcomposite]
 composite_setup+0x314/0xb44 [libcomposite]
 configfs_composite_setup+0x84/0xb0 [libcomposite]
 cdnsp_ep0_std_request+0x25c/0x470 [cdns3]
 cdnsp_setup_analyze+0x94/0x25c [cdns3]
 cdnsp_handle_event+0xe8/0x23c [cdns3]
 cdnsp_thread_irq_handler+0x58/0xe8 [cdns3]
 irq_thread_fn+0x2c/0xa0
 irq_thread+0x164/0x280
 kthread+0x128/0x134
 ret_from_fork+0x10/0x40

Signed-off-by: Jing Leng <jleng@ambarella.com>
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

