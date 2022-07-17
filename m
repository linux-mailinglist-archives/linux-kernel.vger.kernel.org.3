Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CC65776C2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 16:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbiGQOoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 10:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbiGQOnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 10:43:45 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8215F68;
        Sun, 17 Jul 2022 07:43:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n12so691887wrc.8;
        Sun, 17 Jul 2022 07:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PQ1NQYAY40VdIfaKD7aTOcgtuEul8hn8SxDvqqcPU2M=;
        b=ikvvcQRqGWvJ/WJZVtSdtagXjZ5UVt03LXCmCXnoP7UIGyf5J3LiJZy39cN9rHvfxI
         oc1UTMHxxsd3hHU/K2vLpNVRPBTc4uxEGsUVGjjSsVT0U7uT3zlc8EYfZW6uybfkD7Wh
         J6i6ILslh0EbqxI1PEBJrpxnR0zgqhvQAGIIMVl2pYUFOTvjnlDRjkl0OqhQdjxIPovQ
         eqaBkqsVA3OyPwdjFZV+9OPwM6/CXzQIHMbXPbZJ3iOh1ZgIJamZb6vWhl2OnnN6uUH/
         dBoVHnGoCnOa4CPBjS90Fu4KKiVWE0ynNdS5svDFplq+LzsWjx86XIYfx1GlVzl2lk7W
         Eikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PQ1NQYAY40VdIfaKD7aTOcgtuEul8hn8SxDvqqcPU2M=;
        b=w/nL2i0rw241p9lvUHnh0sDeUixCDT5zJXS+IdWrsUrGjvzs7lyE5W0rPClcz2i5eG
         aDpzXsFUuzs5YLC6Lx1KlIVDPr3JgyhLbgg6jYbO4GExuutQzheqxAFJCd4M5sr3IEBj
         m0Y7+zyObCokL5NpmN2xk4X/u9K+ox3HtrSyytIT7APMC7vyNiOguIJoUbSc4ACpqJdV
         Hxe5S2Lr8ItEoNGfr97cH/L59wPwJecKsJfszkW338iU0WKUq36R5zHxDOslA8QBwfdE
         S+/diYgI9MOMzYGNc+X3bTK2Gz5S9R6zVxlwKXCQkuXdmXKZwqCMVl0UEhzuZmuy7Dc9
         Wk4Q==
X-Gm-Message-State: AJIora8msBGJ/klBPaY2qwtpSl4wNUwiKDMS/Hn4+Y7AOMeyS7cLOdZb
        AMnbB1Bv0GCbsBuKIwfDpjE=
X-Google-Smtp-Source: AGRyM1sJWV+5Fv+yrbtT0yaWM1aV3e3j3qs2ieRT/En8K3w2nce7D2xDTMFvOqGf9BoudFPwrx4ZwQ==
X-Received: by 2002:adf:f847:0:b0:21d:6c3b:ecbf with SMTP id d7-20020adff847000000b0021d6c3becbfmr19584148wrq.423.1658069022140;
        Sun, 17 Jul 2022 07:43:42 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.185])
        by smtp.gmail.com with ESMTPSA id h8-20020adff4c8000000b0021d887f9468sm8432001wrp.25.2022.07.17.07.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 07:43:41 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        j.witteveen@gmail.com, stefanberzl@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 6/7] HID: uclogic: Add support for UGEE v2 mouse frames
Date:   Sun, 17 Jul 2022 16:43:32 +0200
Message-Id: <20220717144333.251190-7-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220717144333.251190-1-jose.exposito89@gmail.com>
References: <20220717144333.251190-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the required HID descriptors and the initialization function for
UGEE v2 frames with a mouse in the frame.

Tested-by: Jouke Witteveen <j.witteveen@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params.c | 31 +++++++++++++++++++++++++++++
 drivers/hid/hid-uclogic-rdesc.c  | 34 ++++++++++++++++++++++++++++++++
 drivers/hid/hid-uclogic-rdesc.h  |  4 ++++
 3 files changed, 69 insertions(+)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 8ac7caeda535..f25c483b794b 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -1188,6 +1188,31 @@ static int uclogic_params_ugee_v2_init_frame_dial(struct uclogic_params *p,
 	return 0;
 }
 
+/**
+ * uclogic_params_ugee_v2_init_frame_mouse() - initialize a UGEE v2 frame with a
+ * mouse.
+ * @p:			Parameters to fill in, cannot be NULL.
+ *
+ * Returns:
+ *	Zero, if successful. A negative errno code on error.
+ */
+static int uclogic_params_ugee_v2_init_frame_mouse(struct uclogic_params *p)
+{
+	int rc = 0;
+
+	if (!p)
+		return -EINVAL;
+
+	rc = uclogic_params_frame_init_with_desc(&p->frame_list[1],
+						 uclogic_rdesc_ugee_v2_frame_mouse_template_arr,
+						 uclogic_rdesc_ugee_v2_frame_dial_template_size,
+						 UCLOGIC_RDESC_V1_FRAME_ID);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
 /**
  * uclogic_params_ugee_v2_init() - initialize a UGEE graphics tablets by
  * discovering their parameters.
@@ -1231,6 +1256,12 @@ static int uclogic_params_ugee_v2_init(struct uclogic_params *params,
 
 	iface = to_usb_interface(hdev->dev.parent);
 	bInterfaceNumber = iface->cur_altsetting->desc.bInterfaceNumber;
+
+	if (bInterfaceNumber == 0) {
+		uclogic_params_ugee_v2_init_frame_mouse(&p);
+		goto output;
+	}
+
 	if (bInterfaceNumber != 2) {
 		uclogic_params_init_invalid(&p);
 		goto output;
diff --git a/drivers/hid/hid-uclogic-rdesc.c b/drivers/hid/hid-uclogic-rdesc.c
index 22429df693fc..fb9ca69f72c2 100644
--- a/drivers/hid/hid-uclogic-rdesc.c
+++ b/drivers/hid/hid-uclogic-rdesc.c
@@ -1001,6 +1001,40 @@ const __u8 uclogic_rdesc_ugee_v2_frame_dial_template_arr[] = {
 const size_t uclogic_rdesc_ugee_v2_frame_dial_template_size =
 			sizeof(uclogic_rdesc_ugee_v2_frame_dial_template_arr);
 
+/* Fixed report descriptor template for UGEE v2 frame reports (mouse) */
+const __u8 uclogic_rdesc_ugee_v2_frame_mouse_template_arr[] = {
+	0x05, 0x01,         /*  Usage Page (Desktop),                   */
+	0x09, 0x02,         /*  Usage (Mouse),                          */
+	0xA1, 0x01,         /*  Collection (Application),               */
+	0x85, 0x01,         /*      Report ID (1),                      */
+	0x05, 0x01,         /*      Usage Page (Pointer),               */
+	0xA0,               /*      Collection (Physical),              */
+	0x75, 0x01,         /*          Report Size (1),                */
+	0x95, 0x02,         /*          Report Count (2),               */
+	0x05, 0x09,         /*          Usage Page (Button),            */
+	0x19, 0x01,         /*          Usage Minimum (01h),            */
+	0x29, 0x02,         /*          Usage Maximum (02h),            */
+	0x14,               /*          Logical Minimum (0),            */
+	0x25, 0x01,         /*          Logical Maximum (1),            */
+	0x81, 0x02,         /*          Input (Variable),               */
+	0x95, 0x06,         /*          Report Count (6),               */
+	0x81, 0x01,         /*          Input (Constant),               */
+	0x05, 0x01,         /*          Usage Page (Generic Desktop),   */
+	0x09, 0x30,         /*          Usage (X),                      */
+	0x09, 0x31,         /*          Usage (Y),                      */
+	0x75, 0x10,         /*          Report Size (16),               */
+	0x95, 0x02,         /*          Report Count (2),               */
+	0x16, 0x00, 0x80,   /*          Logical Minimum (-32768),       */
+	0x26, 0xFF, 0x7F,   /*          Logical Maximum (32767),        */
+	0x81, 0x06,         /*          Input (Variable, Relative),     */
+	0x95, 0x01,         /*          Report Count (1),               */
+	0x81, 0x01,         /*          Input (Constant),               */
+	0xC0,               /*      End Collection,                     */
+	0xC0                /*  End Collection                          */
+};
+const size_t uclogic_rdesc_ugee_v2_frame_mouse_template_size =
+			sizeof(uclogic_rdesc_ugee_v2_frame_mouse_template_arr);
+
 /* Fixed report descriptor for Ugee EX07 frame */
 const __u8 uclogic_rdesc_ugee_ex07_frame_arr[] = {
 	0x05, 0x01,             /*  Usage Page (Desktop),                   */
diff --git a/drivers/hid/hid-uclogic-rdesc.h b/drivers/hid/hid-uclogic-rdesc.h
index 1a2d658bad3a..0502a0656496 100644
--- a/drivers/hid/hid-uclogic-rdesc.h
+++ b/drivers/hid/hid-uclogic-rdesc.h
@@ -173,6 +173,10 @@ extern const size_t uclogic_rdesc_ugee_v2_frame_btn_template_size;
 extern const __u8 uclogic_rdesc_ugee_v2_frame_dial_template_arr[];
 extern const size_t uclogic_rdesc_ugee_v2_frame_dial_template_size;
 
+/* Fixed report descriptor template for UGEE v2 frame reports (mouse) */
+extern const __u8 uclogic_rdesc_ugee_v2_frame_mouse_template_arr[];
+extern const size_t uclogic_rdesc_ugee_v2_frame_mouse_template_size;
+
 /* Fixed report descriptor for Ugee EX07 frame */
 extern const __u8 uclogic_rdesc_ugee_ex07_frame_arr[];
 extern const size_t uclogic_rdesc_ugee_ex07_frame_size;
-- 
2.25.1

