Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D037051EEC4
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 18:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbiEHQF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 12:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbiEHQFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 12:05:53 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA83E0AB;
        Sun,  8 May 2022 09:02:02 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t6so16373049wra.4;
        Sun, 08 May 2022 09:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=obMuOVNFX3S99S3WxC9zwRJp/87FhNQ1mA/toWw3QGk=;
        b=Ki687qiWDjABIUssvbUHjJB+YIvM192T9ZnKgj9Hd6G5VhranaFPD+ewFeGb4p9G+0
         OuIxuakVtEFN8LrgVkhs+gxBUwK6pTtontmdb1JCXVEzRYlEeySHMfFB37/M5rBSfumh
         4blVJmwHN4U2mMamZXz8l1nFGCOLrS/YHzoz0xVzwLG3jR9k4oMQis6ALFMAEV7G+zb1
         PDV8r0Vl1IyCTVqXvCWnqcCSDpQxSZiJAS8LbAuA95cO/GC9C7jihODDhioNFNQQAo34
         GZDR51VEQ1fPQr50bfxe468eC6fyqHkBwL05h/TH1xeLiX9c7SQeWsB3PA8aDcskO3oH
         ilGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=obMuOVNFX3S99S3WxC9zwRJp/87FhNQ1mA/toWw3QGk=;
        b=xzbPF9Giy8uNaG0Z/LHD6KH60yXROJ/ztWOSW/Zivsq3nMuHBVQt/11/rsycVCTeCj
         uRC/jCZ4ysy3RiunjRZxazcqNUdmCmaBvbQNnaIT5EZQUhX+hEghTWGkL4DECGdGDDg5
         6m6xPGUgyeWiY4nROIho5gllCgzPI5MCrsnlo2dRqFC/tjQHWEQRzXn7/XdXXYPqqRA1
         vsxKtNwA5/SlANFaC27pfvm9KgyHyYn6KWPxyJ699CBhO04BgHuF31ngND3jv45yQqD9
         XijDolBMF+36rC3aQphD8mGgB8ChtjaYweXigxmwrLPAXTooXgA4G36PbGWcbfQQ8n8G
         GuEg==
X-Gm-Message-State: AOAM5311NZK8e/BjwXVqhgAnp3LHxA8bjUnlQprunqTiCfv9glnX9b0r
        PL8JMxH2t2XK5UoUN3gl1aA=
X-Google-Smtp-Source: ABdhPJxqf7DBXlp4e1T5RVxciKZO91ox2R3Rwc1Z7DOmm7v8Shs2YFJPVkNmWmxKtivs1AF7pSbZXw==
X-Received: by 2002:adf:f84b:0:b0:20a:ece0:905e with SMTP id d11-20020adff84b000000b0020aece0905emr10433971wrq.323.1652025721597;
        Sun, 08 May 2022 09:02:01 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id b15-20020a7bc24f000000b003942a244ecfsm10101925wmj.20.2022.05.08.09.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 09:02:01 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanberzl@gmail.com, albertofanjul@gmail.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.19/uclogic 1/7] HID: uclogic: Move param printing to a function
Date:   Sun,  8 May 2022 18:01:40 +0200
Message-Id: <20220508160146.13004-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508160146.13004-1-jose.exposito89@gmail.com>
References: <20220508160146.13004-1-jose.exposito89@gmail.com>
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

From: Nikolai Kondrashov <spbnick@gmail.com>

Move parameter printing from a format string/argument list to a function
to allow printing the full parameters, which now wouldn't fit into a
single print call.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-core.c   |   4 +-
 drivers/hid/hid-uclogic-params.c |  89 +++++++++++++++++++++++-
 drivers/hid/hid-uclogic-params.h | 116 ++-----------------------------
 3 files changed, 93 insertions(+), 116 deletions(-)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index 8ef3d1830052..8cac5944e63f 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -209,8 +209,8 @@ static int uclogic_probe(struct hid_device *hdev,
 		goto failure;
 	}
 	params_initialized = true;
-	hid_dbg(hdev, "parameters:\n" UCLOGIC_PARAMS_FMT_STR,
-		UCLOGIC_PARAMS_FMT_ARGS(&drvdata->params));
+	hid_dbg(hdev, "parameters:\n");
+	uclogic_params_hid_dbg(hdev, &drvdata->params);
 	if (drvdata->params.invalid) {
 		hid_info(hdev, "interface is invalid, ignoring\n");
 		rc = -ENODEV;
diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 22f9c4f9da8a..1d9168cc7dc0 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -29,8 +29,8 @@
  * Returns:
  *	The string representing the type, or NULL if the type is unknown.
  */
-const char *uclogic_params_pen_inrange_to_str(
-			enum uclogic_params_pen_inrange inrange)
+static const char *uclogic_params_pen_inrange_to_str(
+				enum uclogic_params_pen_inrange inrange)
 {
 	switch (inrange) {
 	case UCLOGIC_PARAMS_PEN_INRANGE_NORMAL:
@@ -44,6 +44,91 @@ const char *uclogic_params_pen_inrange_to_str(
 	}
 }
 
+/**
+ * Dump tablet interface pen parameters with hid_dbg(), indented with one tab.
+ *
+ * @hdev:	The HID device the pen parameters describe.
+ * @pen:	The pen parameters to dump.
+ */
+static void uclogic_params_pen_hid_dbg(const struct hid_device *hdev,
+					const struct uclogic_params_pen *pen)
+{
+	size_t i;
+
+	hid_dbg(hdev, "\t.usage_invalid = %s\n",
+		(pen->usage_invalid ? "true" : "false"));
+	hid_dbg(hdev, "\t.desc_ptr = %p\n", pen->desc_ptr);
+	hid_dbg(hdev, "\t.desc_size = %u\n", pen->desc_size);
+	hid_dbg(hdev, "\t.id = %u\n", pen->id);
+	hid_dbg(hdev, "\t.subreport_list = {\n");
+	for (i = 0; i < ARRAY_SIZE(pen->subreport_list); i++) {
+		hid_dbg(hdev, "\t\t{0x%02hhx, %hhu}%s\n",
+			pen->subreport_list[i].value,
+			pen->subreport_list[i].id,
+			i < (ARRAY_SIZE(pen->subreport_list) - 1) ? "," : "");
+	}
+	hid_dbg(hdev, "\t}\n");
+	hid_dbg(hdev, "\t.inrange = %s\n",
+		uclogic_params_pen_inrange_to_str(pen->inrange));
+	hid_dbg(hdev, "\t.fragmented_hires = %s\n",
+		(pen->fragmented_hires ? "true" : "false"));
+	hid_dbg(hdev, "\t.tilt_y_flipped = %s\n",
+		(pen->tilt_y_flipped ? "true" : "false"));
+}
+
+/**
+ * Dump tablet interface frame parameters with hid_dbg(), indented with two
+ * tabs.
+ *
+ * @hdev:	The HID device the pen parameters describe.
+ * @frame:	The frame parameters to dump.
+ */
+static void uclogic_params_frame_hid_dbg(
+				const struct hid_device *hdev,
+				const struct uclogic_params_frame *frame)
+{
+	hid_dbg(hdev, "\t\t.desc_ptr = %p\n", frame->desc_ptr);
+	hid_dbg(hdev, "\t\t.desc_size = %u\n", frame->desc_size);
+	hid_dbg(hdev, "\t\t.id = %u\n", frame->id);
+	hid_dbg(hdev, "\t\t.suffix = %s\n", frame->suffix);
+	hid_dbg(hdev, "\t\t.re_lsb = %u\n", frame->re_lsb);
+	hid_dbg(hdev, "\t\t.dev_id_byte = %u\n", frame->dev_id_byte);
+	hid_dbg(hdev, "\t\t.touch_ring_byte = %u\n", frame->touch_ring_byte);
+	hid_dbg(hdev, "\t\t.touch_ring_max = %hhd\n", frame->touch_ring_max);
+	hid_dbg(hdev, "\t\t.touch_ring_flip_at = %hhd\n",
+		frame->touch_ring_flip_at);
+	hid_dbg(hdev, "\t\t.bitmap_dial_byte = %u\n",
+		frame->bitmap_dial_byte);
+}
+
+/**
+ * Dump tablet interface parameters with hid_dbg().
+ *
+ * @hdev:	The HID device the parameters describe.
+ * @params:	The parameters to dump.
+ */
+void uclogic_params_hid_dbg(const struct hid_device *hdev,
+				const struct uclogic_params *params)
+{
+	size_t i;
+
+	hid_dbg(hdev, ".invalid = %s\n",
+		params->invalid ? "true" : "false");
+	hid_dbg(hdev, ".desc_ptr = %p\n", params->desc_ptr);
+	hid_dbg(hdev, ".desc_size = %u\n", params->desc_size);
+	hid_dbg(hdev, ".pen = {\n");
+	uclogic_params_pen_hid_dbg(hdev, &params->pen);
+	hid_dbg(hdev, "\t}\n");
+	hid_dbg(hdev, ".frame_list = {\n");
+	for (i = 0; i < ARRAY_SIZE(params->frame_list); i++) {
+		hid_dbg(hdev, "\t{\n");
+		uclogic_params_frame_hid_dbg(hdev, &params->frame_list[i]);
+		hid_dbg(hdev, "\t}%s\n",
+			i < (ARRAY_SIZE(params->frame_list) - 1) ? "," : "");
+	}
+	hid_dbg(hdev, "}\n");
+}
+
 /**
  * uclogic_params_get_str_desc - retrieve a string descriptor from a HID
  * device interface, putting it into a kmalloc-allocated buffer as is, without
diff --git a/drivers/hid/hid-uclogic-params.h b/drivers/hid/hid-uclogic-params.h
index fb2001018c46..c7573f70d35c 100644
--- a/drivers/hid/hid-uclogic-params.h
+++ b/drivers/hid/hid-uclogic-params.h
@@ -29,11 +29,6 @@ enum uclogic_params_pen_inrange {
 	UCLOGIC_PARAMS_PEN_INRANGE_NONE,
 };
 
-/* Convert a pen in-range reporting type to a string */
-extern const char *uclogic_params_pen_inrange_to_str(
-			enum uclogic_params_pen_inrange inrange);
-
-
 /*
  * Pen report's subreport data.
  */
@@ -213,113 +208,6 @@ struct uclogic_params {
 extern int uclogic_params_init(struct uclogic_params *params,
 				struct hid_device *hdev);
 
-/* Tablet interface parameters *printf format string */
-#define UCLOGIC_PARAMS_FMT_STR \
-	".invalid = %s\n"                   \
-	".desc_ptr = %p\n"                  \
-	".desc_size = %u\n"                 \
-	".pen = {\n"                        \
-	"\t.usage_invalid = %s\n"           \
-	"\t.desc_ptr = %p\n"                \
-	"\t.desc_size = %u\n"               \
-	"\t.id = %u\n"                      \
-	"\t.subreport_list = {\n"           \
-	"\t\t{0x%02hhx, %hhu},\n"           \
-	"\t\t{0x%02hhx, %hhu},\n"           \
-	"\t\t{0x%02hhx, %hhu},\n"           \
-	"\t}\n"                             \
-	"\t.inrange = %s\n"                 \
-	"\t.fragmented_hires = %s\n"        \
-	"\t.tilt_y_flipped = %s\n"          \
-	"}\n"                               \
-	".frame_list = {\n"                 \
-	"\t{\n"                             \
-	"\t\t.desc_ptr = %p\n"              \
-	"\t\t.desc_size = %u\n"             \
-	"\t\t.id = %u\n"                    \
-	"\t\t.suffix = %s\n"                \
-	"\t\t.re_lsb = %u\n"                \
-	"\t\t.dev_id_byte = %u\n"           \
-	"\t\t.touch_ring_byte = %u\n"       \
-	"\t\t.touch_ring_max = %hhd\n"      \
-	"\t\t.touch_ring_flip_at = %hhd\n"  \
-	"\t\t.bitmap_dial_byte = %u\n"      \
-	"\t},\n"                            \
-	"\t{\n"                             \
-	"\t\t.desc_ptr = %p\n"              \
-	"\t\t.desc_size = %u\n"             \
-	"\t\t.id = %u\n"                    \
-	"\t\t.suffix = %s\n"                \
-	"\t\t.re_lsb = %u\n"                \
-	"\t\t.dev_id_byte = %u\n"           \
-	"\t\t.touch_ring_byte = %u\n"       \
-	"\t\t.touch_ring_max = %hhd\n"      \
-	"\t\t.touch_ring_flip_at = %hhd\n"  \
-	"\t\t.bitmap_dial_byte = %u\n"      \
-	"\t},\n"                            \
-	"\t{\n"                             \
-	"\t\t.desc_ptr = %p\n"              \
-	"\t\t.desc_size = %u\n"             \
-	"\t\t.id = %u\n"                    \
-	"\t\t.suffix = %s\n"                \
-	"\t\t.re_lsb = %u\n"                \
-	"\t\t.dev_id_byte = %u\n"           \
-	"\t\t.touch_ring_byte = %u\n"       \
-	"\t\t.touch_ring_max = %hhd\n"      \
-	"\t\t.touch_ring_flip_at = %hhd\n"  \
-	"\t\t.bitmap_dial_byte = %u\n"      \
-	"\t},\n"                            \
-	"}\n"
-
-/* Tablet interface parameters *printf format arguments */
-#define UCLOGIC_PARAMS_FMT_ARGS(_params) \
-	((_params)->invalid ? "true" : "false"),                    \
-	(_params)->desc_ptr,                                        \
-	(_params)->desc_size,                                       \
-	((_params)->pen.usage_invalid ? "true" : "false"),          \
-	(_params)->pen.desc_ptr,                                    \
-	(_params)->pen.desc_size,                                   \
-	(_params)->pen.id,                                          \
-	(_params)->pen.subreport_list[0].value,                     \
-	(_params)->pen.subreport_list[0].id,                        \
-	(_params)->pen.subreport_list[1].value,                     \
-	(_params)->pen.subreport_list[1].id,                        \
-	(_params)->pen.subreport_list[2].value,                     \
-	(_params)->pen.subreport_list[2].id,                        \
-	uclogic_params_pen_inrange_to_str((_params)->pen.inrange),  \
-	((_params)->pen.fragmented_hires ? "true" : "false"),       \
-	((_params)->pen.tilt_y_flipped ? "true" : "false"),         \
-	(_params)->frame_list[0].desc_ptr,                          \
-	(_params)->frame_list[0].desc_size,                         \
-	(_params)->frame_list[0].id,                                \
-	(_params)->frame_list[0].suffix,                            \
-	(_params)->frame_list[0].re_lsb,                            \
-	(_params)->frame_list[0].dev_id_byte,                       \
-	(_params)->frame_list[0].touch_ring_byte,                   \
-	(_params)->frame_list[0].touch_ring_max,                    \
-	(_params)->frame_list[0].touch_ring_flip_at,                \
-	(_params)->frame_list[0].bitmap_dial_byte,                  \
-	(_params)->frame_list[1].desc_ptr,                          \
-	(_params)->frame_list[1].desc_size,                         \
-	(_params)->frame_list[1].id,                                \
-	(_params)->frame_list[1].suffix,                            \
-	(_params)->frame_list[1].re_lsb,                            \
-	(_params)->frame_list[1].dev_id_byte,                       \
-	(_params)->frame_list[1].touch_ring_byte,                   \
-	(_params)->frame_list[1].touch_ring_max,                    \
-	(_params)->frame_list[1].touch_ring_flip_at,                \
-	(_params)->frame_list[1].bitmap_dial_byte,                  \
-	(_params)->frame_list[2].desc_ptr,                          \
-	(_params)->frame_list[2].desc_size,                         \
-	(_params)->frame_list[2].id,                                \
-	(_params)->frame_list[2].suffix,                            \
-	(_params)->frame_list[2].re_lsb,                            \
-	(_params)->frame_list[2].dev_id_byte,                       \
-	(_params)->frame_list[2].touch_ring_byte,                   \
-	(_params)->frame_list[2].touch_ring_max,                    \
-	(_params)->frame_list[2].touch_ring_flip_at,                \
-	(_params)->frame_list[2].bitmap_dial_byte
-
 /* Get a replacement report descriptor for a tablet's interface. */
 extern int uclogic_params_get_desc(const struct uclogic_params *params,
 					__u8 **pdesc,
@@ -328,4 +216,8 @@ extern int uclogic_params_get_desc(const struct uclogic_params *params,
 /* Free resources used by tablet interface's parameters */
 extern void uclogic_params_cleanup(struct uclogic_params *params);
 
+/* Dump tablet interface parameters with hid_dbg() */
+extern void uclogic_params_hid_dbg(const struct hid_device *hdev,
+					const struct uclogic_params *params);
+
 #endif /* _HID_UCLOGIC_PARAMS_H */
-- 
2.25.1

