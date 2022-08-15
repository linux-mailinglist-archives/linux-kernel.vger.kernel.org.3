Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433D45930C5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbiHOOa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243097AbiHOOaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:30:10 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8619F240A2;
        Mon, 15 Aug 2022 07:30:09 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id r83-20020a1c4456000000b003a5cb389944so3983508wma.4;
        Mon, 15 Aug 2022 07:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=xEMJW+M4kKzzNZdzcoZxv1ikwmN5FhOm+J6/SYL2VKI=;
        b=a/F4U9dT7FO+CCTv3KQCctKEv4s/yj6g3Ebk691blo3XqWfYbIKV7at85rGTggSO0w
         6oZb0Hap2a/ZTlCcQ5VouimwVYbSQhooCIS3tEcF8zuY+XY1NgitF7adue1ZXT1ckWi5
         ZeCWC8GWA7ot0aZZQGwrDsldhPNvOoa6wOMR3JuX5KYNMX4IOfhqd9v4XfT4ha1d5dW1
         bQaUFNQs3nn2gVYT840aoI7Pgoc59PCQE99pvX8J5sSjLCzfCgoXeNqLoHU+MwH/Ot3n
         cXUG/YuTAU9soS2wnZP/lArR/za+ra3BRKc68c8+SrokpzyovPSMmwTshCSXzOlquZZL
         Wijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xEMJW+M4kKzzNZdzcoZxv1ikwmN5FhOm+J6/SYL2VKI=;
        b=CU5dX83+t2RshAmmcnOYz2k/tNg3885CUq0NhCq47loTyvx89N4cl7ZlHoocxsF4N7
         8SJ+7uTj1jMtPOY870Zd+TufvyYvdq9uWiVRzkJo7KJ+2pajii1FsSEZKz6svpbjcPkT
         XO9MtCyMQavHZMLgsfw/WWB7tqMpSxcr2Uzksc2rjZ4veEg1E7AKEm989gtWkCnGW13p
         B1+FKqorPHinp2vGbNb35rES+0tZqeHGxRiyUERqewH+yeHUHNuyUyFSAyX9m1Z0MfNc
         Per/fJYhf7lerguLEmgyXXxzly+rl823VkRjuMutLYHV4xJLb89Z8FCwOdPxnt/pJEnA
         3Ipg==
X-Gm-Message-State: ACgBeo3bi+PsgB8z698tGMXzJrP20oEkF/2Hebe6vLJXpJ4uqqtT3xxF
        E/Qu2uXcBQHKADrDFaxcSD+xT6MfKHsipg==
X-Google-Smtp-Source: AA6agR6AfdeokKdyFrRyxrHca76D5uOPLLJCQ7jbVeM2DXyJh+5Xln7UvzMaQXTJpXfMu5j/0lzQYA==
X-Received: by 2002:a05:600c:3aca:b0:3a5:fd94:ed7e with SMTP id d10-20020a05600c3aca00b003a5fd94ed7emr1800057wms.58.1660573807796;
        Mon, 15 Aug 2022 07:30:07 -0700 (PDT)
Received: from localhost.localdomain ([94.73.32.249])
        by smtp.gmail.com with ESMTPSA id m7-20020a056000008700b00224f895d620sm5456894wrx.48.2022.08.15.07.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 07:30:07 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        j.witteveen@gmail.com, nathan@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v4 5/8] HID: uclogic: Add support for UGEE v2 dial frames
Date:   Mon, 15 Aug 2022 16:29:53 +0200
Message-Id: <20220815142956.19180-6-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220815142956.19180-1-jose.exposito89@gmail.com>
References: <20220815142956.19180-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the required HID descriptors and the initialization function for
UGEE v2 frames with a bitmap dial.

Tested-by: Jouke Witteveen <j.witteveen@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params.c | 44 ++++++++++++++++++++++++++++++++
 drivers/hid/hid-uclogic-rdesc.c  | 40 +++++++++++++++++++++++++++++
 drivers/hid/hid-uclogic-rdesc.h  |  4 +++
 3 files changed, 88 insertions(+)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 7845dd5fb4b1..950615f95abc 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -1150,6 +1150,45 @@ static int uclogic_params_ugee_v2_init_frame_buttons(struct uclogic_params *p,
 	return rc;
 }
 
+/**
+ * uclogic_params_ugee_v2_init_frame_dial() - initialize a UGEE v2 frame with a
+ * bitmap dial.
+ * @p:			Parameters to fill in, cannot be NULL.
+ * @desc_params:	Device description params list.
+ * @desc_params_size:	Size of the description params list.
+ *
+ * Returns:
+ *	Zero, if successful. A negative errno code on error.
+ */
+static int uclogic_params_ugee_v2_init_frame_dial(struct uclogic_params *p,
+						  const s32 *desc_params,
+						  size_t desc_params_size)
+{
+	__u8 *rdesc_frame = NULL;
+	int rc = 0;
+
+	if (!p || desc_params_size != UCLOGIC_RDESC_PH_ID_NUM)
+		return -EINVAL;
+
+	rdesc_frame = uclogic_rdesc_template_apply(
+				uclogic_rdesc_ugee_v2_frame_dial_template_arr,
+				uclogic_rdesc_ugee_v2_frame_dial_template_size,
+				desc_params, UCLOGIC_RDESC_PH_ID_NUM);
+	if (!rdesc_frame)
+		return -ENOMEM;
+
+	rc = uclogic_params_frame_init_with_desc(&p->frame_list[0],
+						 rdesc_frame,
+						 uclogic_rdesc_ugee_v2_frame_dial_template_size,
+						 UCLOGIC_RDESC_V1_FRAME_ID);
+	kfree(rdesc_frame);
+	if (rc)
+		return rc;
+
+	p->frame_list[0].bitmap_dial_byte = 7;
+	return 0;
+}
+
 /**
  * uclogic_params_ugee_v2_init() - initialize a UGEE graphics tablets by
  * discovering their parameters.
@@ -1249,6 +1288,11 @@ static int uclogic_params_ugee_v2_init(struct uclogic_params *params,
 
 	/* Initialize the frame interface */
 	switch (frame_type) {
+	case UCLOGIC_PARAMS_FRAME_DIAL:
+	case UCLOGIC_PARAMS_FRAME_MOUSE:
+		rc = uclogic_params_ugee_v2_init_frame_dial(&p, desc_params,
+							    ARRAY_SIZE(desc_params));
+		break;
 	case UCLOGIC_PARAMS_FRAME_BUTTONS:
 	default:
 		rc = uclogic_params_ugee_v2_init_frame_buttons(&p, desc_params,
diff --git a/drivers/hid/hid-uclogic-rdesc.c b/drivers/hid/hid-uclogic-rdesc.c
index 3d68e8b0784d..22429df693fc 100644
--- a/drivers/hid/hid-uclogic-rdesc.c
+++ b/drivers/hid/hid-uclogic-rdesc.c
@@ -961,6 +961,46 @@ const __u8 uclogic_rdesc_ugee_v2_frame_btn_template_arr[] = {
 const size_t uclogic_rdesc_ugee_v2_frame_btn_template_size =
 			sizeof(uclogic_rdesc_ugee_v2_frame_btn_template_arr);
 
+/* Fixed report descriptor template for UGEE v2 frame reports (dial) */
+const __u8 uclogic_rdesc_ugee_v2_frame_dial_template_arr[] = {
+	0x05, 0x01,         /*  Usage Page (Desktop),                   */
+	0x09, 0x07,         /*  Usage (Keypad),                         */
+	0xA1, 0x01,         /*  Collection (Application),               */
+	0x85, UCLOGIC_RDESC_V1_FRAME_ID,
+			    /*      Report ID,                          */
+	0x05, 0x0D,         /*      Usage Page (Digitizer),             */
+	0x09, 0x39,         /*      Usage (Tablet Function Keys),       */
+	0xA0,               /*      Collection (Physical),              */
+	0x75, 0x01,         /*          Report Size (1),                */
+	0x95, 0x08,         /*          Report Count (8),               */
+	0x81, 0x01,         /*          Input (Constant),               */
+	0x05, 0x09,         /*          Usage Page (Button),            */
+	0x19, 0x01,         /*          Usage Minimum (01h),            */
+	UCLOGIC_RDESC_FRAME_PH_BTN,
+			    /*          Usage Maximum (PLACEHOLDER),    */
+	0x95, 0x0A,         /*          Report Count (10),              */
+	0x14,               /*          Logical Minimum (0),            */
+	0x25, 0x01,         /*          Logical Maximum (1),            */
+	0x81, 0x02,         /*          Input (Variable),               */
+	0x95, 0x06,         /*          Report Count (6),               */
+	0x81, 0x01,         /*          Input (Constant),               */
+	0x75, 0x08,         /*          Report Size (8),                */
+	0x95, 0x03,         /*          Report Count (3),               */
+	0x81, 0x01,         /*          Input (Constant),               */
+	0x05, 0x01,         /*          Usage Page (Desktop),           */
+	0x09, 0x38,         /*          Usage (Wheel),                  */
+	0x95, 0x01,         /*          Report Count (1),               */
+	0x15, 0xFF,         /*          Logical Minimum (-1),           */
+	0x25, 0x01,         /*          Logical Maximum (1),            */
+	0x81, 0x06,         /*          Input (Variable, Relative),     */
+	0x95, 0x02,         /*          Report Count (2),               */
+	0x81, 0x01,         /*          Input (Constant),               */
+	0xC0,               /*      End Collection,                     */
+	0xC0                /*  End Collection                          */
+};
+const size_t uclogic_rdesc_ugee_v2_frame_dial_template_size =
+			sizeof(uclogic_rdesc_ugee_v2_frame_dial_template_arr);
+
 /* Fixed report descriptor for Ugee EX07 frame */
 const __u8 uclogic_rdesc_ugee_ex07_frame_arr[] = {
 	0x05, 0x01,             /*  Usage Page (Desktop),                   */
diff --git a/drivers/hid/hid-uclogic-rdesc.h b/drivers/hid/hid-uclogic-rdesc.h
index 86e64a9ee6bd..1a2d658bad3a 100644
--- a/drivers/hid/hid-uclogic-rdesc.h
+++ b/drivers/hid/hid-uclogic-rdesc.h
@@ -169,6 +169,10 @@ extern const size_t uclogic_rdesc_ugee_v2_pen_template_size;
 extern const __u8 uclogic_rdesc_ugee_v2_frame_btn_template_arr[];
 extern const size_t uclogic_rdesc_ugee_v2_frame_btn_template_size;
 
+/* Fixed report descriptor template for UGEE v2 frame reports (dial) */
+extern const __u8 uclogic_rdesc_ugee_v2_frame_dial_template_arr[];
+extern const size_t uclogic_rdesc_ugee_v2_frame_dial_template_size;
+
 /* Fixed report descriptor for Ugee EX07 frame */
 extern const __u8 uclogic_rdesc_ugee_ex07_frame_arr[];
 extern const size_t uclogic_rdesc_ugee_ex07_frame_size;
-- 
2.25.1

