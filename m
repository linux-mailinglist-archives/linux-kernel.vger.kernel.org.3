Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1784BB5EF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbiBRJuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 04:50:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbiBRJur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:50:47 -0500
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id CED8926A2C1;
        Fri, 18 Feb 2022 01:50:27 -0800 (PST)
Received: from jleng.ambarella.net (unknown [116.246.37.178])
        by mail-app2 (Coremail) with SMTP id by_KCgCnrYW8aw9ink_8AQ--.55562S2;
        Fri, 18 Feb 2022 17:49:55 +0800 (CST)
From:   3090101217@zju.edu.cn
To:     gregkh@linuxfoundation.org
Cc:     balbi@kernel.org, jleng@ambarella.com, pavel.hofman@ivitera.com,
        ruslan.bilovol@gmail.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v2] usb: gadget: f_uac1: add set requests support
Date:   Fri, 18 Feb 2022 17:49:47 +0800
Message-Id: <20220218094947.3835-1-3090101217@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <Yg5psAzBNrVvOpGc@kroah.com>
References: <Yg5psAzBNrVvOpGc@kroah.com>
X-CM-TRANSID: by_KCgCnrYW8aw9ink_8AQ--.55562S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr4UKF4kKry5Zw1fZFWfAFb_yoW5KF1DpF
        4UCayayrs8J34qqr17Jr4rZFW3C3yxA39xKr1Dt343Wrn3Jwn0yF4jyF9a9Fy3Aas5Cr4x
        XF45Wr1rZw1j9rDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9vb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
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
        0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8La93UUUUU==
X-CM-SenderInfo: qtqziiyqrsilo62m3hxhgxhubq/1tbiAwMFBVNG3FklugAAsP
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Leng <jleng@ambarella.com>

Currently the f_uac1 driver only supports UAC_SET_CUR request.

But when uac1 device is plugged to Ubuntu 20.04 PC, at the stage
of setup, the PC will send UAC_SET_RES request, If the device
doesn't respond to the request, the PC will abort the setup process
and uac1 device can't be recognized on Ubuntu 20.04 PC.

So f_uac1 driver should handle other set requests.

Fixes: 0356e6283c71 ("usb: gadget: f_uac1: add volume and mute support")
Signed-off-by: Jing Leng <jleng@ambarella.com>
---
ChangeLog v1->v2:
- Add "Fixes:" tag in the changelog area
---
 drivers/usb/gadget/function/f_uac1.c | 44 +++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/function/f_uac1.c
index 03f50643fbba..c9d8ec4fdf22 100644
--- a/drivers/usb/gadget/function/f_uac1.c
+++ b/drivers/usb/gadget/function/f_uac1.c
@@ -589,7 +589,7 @@ in_rq_res(struct usb_function *fn, const struct usb_ctrlrequest *cr)
 }
 
 static void
-out_rq_cur_complete(struct usb_ep *ep, struct usb_request *req)
+out_rq_complete(struct usb_ep *ep, struct usb_request *req)
 {
 	struct g_audio *audio = req->context;
 	struct usb_composite_dev *cdev = audio->func.config->cdev;
@@ -614,9 +614,11 @@ out_rq_cur_complete(struct usb_ep *ep, struct usb_request *req)
 			is_playback = 1;
 
 		if (control_selector == UAC_FU_MUTE) {
-			u8 mute = *(u8 *)req->buf;
+			if (cr->bRequest == UAC_SET_CUR) {
+				u8 mute = *(u8 *)req->buf;
 
-			u_audio_set_mute(audio, is_playback, mute);
+				u_audio_set_mute(audio, is_playback, mute);
+			}
 
 			return;
 		} else if (control_selector == UAC_FU_VOLUME) {
@@ -624,7 +626,34 @@ out_rq_cur_complete(struct usb_ep *ep, struct usb_request *req)
 			s16 volume;
 
 			volume = le16_to_cpu(*c);
-			u_audio_set_volume(audio, is_playback, volume);
+
+			switch (cr->bRequest) {
+			case UAC_SET_CUR:
+				u_audio_set_volume(audio, is_playback, volume);
+				break;
+			case UAC_SET_MIN:
+				if (is_playback)
+					opts->p_volume_min = volume;
+				else
+					opts->c_volume_min = volume;
+				break;
+			case UAC_SET_MAX:
+				if (is_playback)
+					opts->p_volume_max = volume;
+				else
+					opts->c_volume_max = volume;
+				break;
+			case UAC_SET_RES:
+				if (is_playback)
+					opts->p_volume_res = volume;
+				else
+					opts->c_volume_res = volume;
+				break;
+			case UAC_SET_MEM:
+				break;
+			default:
+				break;
+			}
 
 			return;
 		} else {
@@ -643,7 +672,7 @@ out_rq_cur_complete(struct usb_ep *ep, struct usb_request *req)
 }
 
 static int
-out_rq_cur(struct usb_function *fn, const struct usb_ctrlrequest *cr)
+ac_rq_out(struct usb_function *fn, const struct usb_ctrlrequest *cr)
 {
 	struct usb_request *req = fn->config->cdev->req;
 	struct g_audio *audio = func_to_g_audio(fn);
@@ -659,7 +688,7 @@ out_rq_cur(struct usb_function *fn, const struct usb_ctrlrequest *cr)
 			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID))) {
 		memcpy(&uac1->setup_cr, cr, sizeof(*cr));
 		req->context = audio;
-		req->complete = out_rq_cur_complete;
+		req->complete = out_rq_complete;
 
 		return w_length;
 	} else {
@@ -789,8 +818,7 @@ f_audio_setup(struct usb_function *f, const struct usb_ctrlrequest *ctrl)
 		value = audio_get_endpoint_req(f, ctrl);
 		break;
 	case USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE:
-		if (ctrl->bRequest == UAC_SET_CUR)
-			value = out_rq_cur(f, ctrl);
+		value = ac_rq_out(f, ctrl);
 		break;
 	case USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE:
 		value = ac_rq_in(f, ctrl);
-- 
2.17.1

