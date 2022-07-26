Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C2C581794
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 18:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239553AbiGZQjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 12:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239505AbiGZQjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:39:37 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A3C1E3F2;
        Tue, 26 Jul 2022 09:39:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m17so20652723wrw.7;
        Tue, 26 Jul 2022 09:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OMwhz1M1zPryVflcNS8Rn/GSnUJtV+dvUFo/LQneMlo=;
        b=IlZNAjhtAalJciM2XrKCWaeHGfYKDtIK42bbfzZ1VtDHwGzovPpd89vwoVudP9DlXI
         l0sClWS/H34bwlHxp71l7Nb37gtrhE2iOfvtWKFTodkEsP/0zMDxzrzCfcqgSgjqv1DC
         7omEF8HEeu1MnsOa4L6Z234/T2eE//mmSD0QQlYN7XB+XG+LGlc5347MDloQhrOFN3jt
         j1mZohU/YLmeyYiTfKnmTdJ1uqLDEDNWgCHSPRZ97gAVQ+IiDrKzFewdIt8afbJm0aZk
         Sv6yec8uo64GLAoacrLjO+WTvbkmexceTDCU7SNc7jrSXbgt1Vd7uVzsYvIoqro6xdbG
         2I0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OMwhz1M1zPryVflcNS8Rn/GSnUJtV+dvUFo/LQneMlo=;
        b=Ys71qMHizP6+QdbfwK04vcyf6BtP6alFf8uuTRUCrtztvOBWtgojBaAJxWpfhCZ/cd
         sBA2m3M/LIBWN58A0Ue5OeqJ4SJQElQptv2KhBY2Rifadbgjc0trITOorqsES6GHXoSW
         M5JeMlG7yy5J/WufvHe5PxXZbfxsgFRGvzBt4qvw38rlEngU8eNz3FJWrCB0pduZTqEb
         0tB+nCRpwXDYKSkH+XgJc3QsUWPUJH5gGtKBcsZIXooiUft2+OP/JBAeiOc6nKmJggy3
         6svQJDcLBHuOjkVxS6RPINAkDYiad+70yLq3Pnv8YPS8kKNjeiar7lFgMU1u2V48NtFB
         OoVg==
X-Gm-Message-State: AJIora/IjeqxAIlAFnUGgEhl1RIrgeshKeFnN5Hd73tkYWb3WM5NpH4C
        3LgrBDco3YQyJEnhyzJGgUA=
X-Google-Smtp-Source: AGRyM1u0Y4JfBEZw2lFxMxsRghHXIUlHNxWzBwWF0C1DKTShElaYeWP0Jc0UNeDSO5Ny8/qkycfTkw==
X-Received: by 2002:adf:ded0:0:b0:21e:5555:6f16 with SMTP id i16-20020adfded0000000b0021e55556f16mr12364430wrn.30.1658853575174;
        Tue, 26 Jul 2022 09:39:35 -0700 (PDT)
Received: from localhost.localdomain ([94.73.33.57])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c058900b0039c54bb28f2sm19514710wmd.36.2022.07.26.09.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 09:39:34 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        j.witteveen@gmail.com, stefanberzl@gmail.com, nathan@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v3 5/7] HID: uclogic: Add support for UGEE v2 dial frames
Date:   Tue, 26 Jul 2022 18:39:24 +0200
Message-Id: <20220726163926.10549-6-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220726163926.10549-1-jose.exposito89@gmail.com>
References: <20220726163926.10549-1-jose.exposito89@gmail.com>
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
UGEE v2 frames with a bitmap dial.

Tested-by: Jouke Witteveen <j.witteveen@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params.c | 44 ++++++++++++++++++++++++++++++++
 drivers/hid/hid-uclogic-rdesc.c  | 40 +++++++++++++++++++++++++++++
 drivers/hid/hid-uclogic-rdesc.h  |  4 +++
 3 files changed, 88 insertions(+)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index b232125f6972..8ac7caeda535 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -1149,6 +1149,45 @@ static int uclogic_params_ugee_v2_init_frame_buttons(struct uclogic_params *p,
 	return 0;
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
@@ -1248,6 +1287,11 @@ static int uclogic_params_ugee_v2_init(struct uclogic_params *params,
 
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

