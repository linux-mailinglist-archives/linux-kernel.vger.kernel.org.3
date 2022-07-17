Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021855776BF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 16:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbiGQOoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 10:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbiGQOnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 10:43:45 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D722DD9B;
        Sun, 17 Jul 2022 07:43:42 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bu1so13522151wrb.9;
        Sun, 17 Jul 2022 07:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OMwhz1M1zPryVflcNS8Rn/GSnUJtV+dvUFo/LQneMlo=;
        b=EjKAWI2jcjHarcEnwNRhqN284M9RnO818R3l+pNYYRLS206P81sRlqpL2gNzOKlFB4
         fV2QQc/wtIO9IeHDWD/tqH1hirILcTqz+K4xrBdWWWIjzv5R+82fCOp8sAgJZJfVMWOR
         AUPelsuApa8AEDRqXjf0b4jFRl3i/hytVwnFRUaAvsfA7tb7+bFeVI+FtZDS/RmFMzMY
         QlpyQa6LDVJAs9s45bIYSSwWrjRxOyci3lxeNPLTN682QvWhgz50YVhpusbXaYa9BOkW
         tX6arJo1ML0mA8uTUWS3Uo6qrgr5vP9uoQDouUTyJ13AjaZSFmXOn4SQMnENiOTvvtnE
         rKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OMwhz1M1zPryVflcNS8Rn/GSnUJtV+dvUFo/LQneMlo=;
        b=3G4Ym4PUVzP0kIKGznwiQ6xE9i3rko94aG/SrnKJs4fMCoxYVI3tBX+Frv32Ku30h+
         caEV4E/1WQUPq1rT4gGRBzvqIGJf156u14kaXEGp5s2wKJ2tHLN+/QjsIRCT23hPxIiI
         hcyLRipIVLH5//nsRmjiAtOqeaqMvTPFZVx+5DhOseq/2IBNJ6okC0/XUnWjJi9pprCq
         WErT5B/5DwuVuEw4/0c5Xag+xpj5u9LlhehccbgaUoI8KqI1p48nxYwKyWSNAPqFHLhZ
         wRRN5WDiUquMJ6QakjNzY+FoLtsRi1aJp99I9AppoM7V63okbzjVZj6gRwSaZQpkqKsM
         X99Q==
X-Gm-Message-State: AJIora9a8AmaBYDyxm4MUd+cVLkdbDpSz6MOH7Ppeb3c9a66+zqTcHG7
        EewORAHtbVqpDATbrpVkJzA=
X-Google-Smtp-Source: AGRyM1ufGF/tZUJDe702VxyCMSYZ+wgLXDXaugkwo+5JSGnF+fORpm/ogyow8VvdChrVYJFrbx9raQ==
X-Received: by 2002:a5d:64a4:0:b0:21d:be80:de06 with SMTP id m4-20020a5d64a4000000b0021dbe80de06mr17245544wrp.107.1658069021326;
        Sun, 17 Jul 2022 07:43:41 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.185])
        by smtp.gmail.com with ESMTPSA id h8-20020adff4c8000000b0021d887f9468sm8432001wrp.25.2022.07.17.07.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 07:43:41 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        j.witteveen@gmail.com, stefanberzl@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 5/7] HID: uclogic: Add support for UGEE v2 dial frames
Date:   Sun, 17 Jul 2022 16:43:31 +0200
Message-Id: <20220717144333.251190-6-jose.exposito89@gmail.com>
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

