Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D984BC77C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 11:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241930AbiBSKCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 05:02:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiBSKCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 05:02:31 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF3DAE7B;
        Sat, 19 Feb 2022 02:02:12 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i14so18441455wrc.10;
        Sat, 19 Feb 2022 02:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eZnDakesUb8DL99t2x67PNyfBeVgWB/usemeFj0ye8k=;
        b=O6ilGTc+ZVUwhMubYEC3t4Mlcvr71BhR3Pfngdst2gchWRaWxZF8w5WebfjqzNeSqX
         rI/G/XiocXFzhnLeXM2XiBrteFyrzXj6N3ZJedvkvegLYmyGc+oXmlAO9NTipe+Tspbt
         zZWy1I1lM7MOBvyrgkRBTS6G2oc2V/Y2vN9E9y02qg8GDolqob92dMHLGN8srRg+LQV/
         o/UOC+nJ4xld89XCnT6YV60tgbh6RjaqhsnSYFM4XzZOVm3PH6etnyld5KKwriDJcXew
         97gHtDHRG10zuqHwikkvOlpEqPVLUTjB3DFJQOJEzqPQ4g+7Z77NXcFW5LJt4krJ2J7I
         u+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eZnDakesUb8DL99t2x67PNyfBeVgWB/usemeFj0ye8k=;
        b=wo9hn/bIJFFZycP/P90jfhLGXXwBYLNxIgpCb5APaZPUoHT5oFmACv7b5Xd5j2RQVz
         drOCGdSLieZc7A6OmaNfCokYRbzdzqjZijMWjnD9gHR3Pl6NE6fKo3Py9ChxKZt2IKmI
         8Q8y132pUHrFtBW+/BiHaDIvNMtzskONTGYv1JcZ8A1MywF/yyULMlONOwLR6h+syDhm
         tyeIJcfuoTDW4zU2f4QAqR5D/2o2yg0/WlpwIbVNv94rvdlpjlfryPiy+BcBOQzYiEgD
         MAkHJhPv4ZCfpjWjQfisQvrziT03mW4koyoQaYkZyATai2pGCxZHGABom94DQ5XZtc6F
         clHQ==
X-Gm-Message-State: AOAM531SPN9r+Xa8hx1SCVwF591BT3AZupvuxZHop4DDaB6IvQ19h4jw
        fegJK1e17vG67teJ61zBLsUkFhWhjR4=
X-Google-Smtp-Source: ABdhPJzY0Vs/TI+8/NF5WjoQbajJJzXLpm9rXVSRzWKPjS3shj8dN+//RwbWz/ypuLvz5IP9UzIFsQ==
X-Received: by 2002:a5d:522a:0:b0:1e3:36c0:6e76 with SMTP id i10-20020a5d522a000000b001e336c06e76mr9188987wra.11.1645264931090;
        Sat, 19 Feb 2022 02:02:11 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id az13sm24417244wrb.39.2022.02.19.02.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 02:02:10 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.18/uclogic 2/9] HID: uclogic: Replace pen_frame_flag with subreport_list
Date:   Sat, 19 Feb 2022 11:01:50 +0100
Message-Id: <20220219100157.41920-3-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220219100157.41920-1-jose.exposito89@gmail.com>
References: <20220219100157.41920-1-jose.exposito89@gmail.com>
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

Replace a single pen_frame_flag in struct uclogic_params with
subreport_list in struct uclogic_params_pen to prepare for handling more
subreports in Huion HS610.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-core.c   | 40 ++++++++++++++-------
 drivers/hid/hid-uclogic-params.c | 12 ++++---
 drivers/hid/hid-uclogic-params.h | 62 +++++++++++++++++++-------------
 3 files changed, 73 insertions(+), 41 deletions(-)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index 26849f1f5459..7092f86517a5 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -350,26 +350,40 @@ static int uclogic_raw_event(struct hid_device *hdev,
 	unsigned int report_id = report->id;
 	struct uclogic_drvdata *drvdata = hid_get_drvdata(hdev);
 	struct uclogic_params *params = &drvdata->params;
+	struct uclogic_params_pen_subreport *subreport;
+	struct uclogic_params_pen_subreport *subreport_list_end;
 
 	/* Do not handle anything but input reports */
 	if (report->type != HID_INPUT_REPORT)
 		return 0;
 
-	/* Tweak pen reports, if necessary */
-	if ((report_id == params->pen.id) && (size >= 2)) {
-		/* If it's the "virtual" frame controls report */
-		if (params->frame.id != 0 &&
-		    data[1] & params->pen_frame_flag) {
-			/* Change to virtual frame controls report ID */
-			report_id = data[0] = params->frame.id;
-		} else {
-			return uclogic_raw_event_pen(drvdata, data, size);
+	while (true) {
+		/* Tweak pen reports, if necessary */
+		if ((report_id == params->pen.id) && (size >= 2)) {
+			subreport_list_end =
+				params->pen.subreport_list +
+				ARRAY_SIZE(params->pen.subreport_list);
+			/* Try to match a subreport */
+			for (subreport = params->pen.subreport_list;
+			     subreport < subreport_list_end &&
+				(data[1] & subreport->mask) != subreport->mask;
+			     subreport++);
+			/* If a subreport matched */
+			if (subreport < subreport_list_end) {
+				/* Change to subreport ID, and restart */
+				report_id = data[0] = subreport->id;
+				continue;
+			} else {
+				return uclogic_raw_event_pen(drvdata, data, size);
+			}
 		}
-	}
 
-	/* Tweak frame control reports, if necessary */
-	if (report_id == params->frame.id)
-		return uclogic_raw_event_frame(drvdata, data, size);
+		/* Tweak frame control reports, if necessary */
+		if (report_id == params->frame.id)
+			return uclogic_raw_event_frame(drvdata, data, size);
+
+		break;
+	}
 
 	return 0;
 }
diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 71496735cbf0..138dd8b0a360 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -762,8 +762,10 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 					rc);
 				goto cleanup;
 			}
-			/* Set bitmask marking frame reports in pen reports */
-			p.pen_frame_flag = 0x20;
+			/* Link frame button subreports from pen reports */
+			p.pen.subreport_list[0].mask = 0x20;
+			p.pen.subreport_list[0].id =
+				UCLOGIC_RDESC_BUTTONPAD_V2_ID;
 			goto output;
 		}
 		hid_dbg(hdev, "pen v2 parameters not found\n");
@@ -788,8 +790,10 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 		hid_dbg(hdev, "buttonpad v1 parameters%s found\n",
 			(found ? "" : " not"));
 		if (found) {
-			/* Set bitmask marking frame reports */
-			p.pen_frame_flag = 0x20;
+			/* Link frame button subreports from pen reports */
+			p.pen.subreport_list[0].mask = 0x20;
+			p.pen.subreport_list[0].id =
+				UCLOGIC_RDESC_BUTTONPAD_V1_ID;
 		}
 		goto output;
 	}
diff --git a/drivers/hid/hid-uclogic-params.h b/drivers/hid/hid-uclogic-params.h
index 48b974943bb9..82db8ab36fec 100644
--- a/drivers/hid/hid-uclogic-params.h
+++ b/drivers/hid/hid-uclogic-params.h
@@ -33,6 +33,24 @@ enum uclogic_params_pen_inrange {
 extern const char *uclogic_params_pen_inrange_to_str(
 			enum uclogic_params_pen_inrange inrange);
 
+
+/*
+ * Pen report's subreport data.
+ */
+struct uclogic_params_pen_subreport {
+	/*
+	 * The subreport's bitmask matching the second byte of the pen report.
+	 * If zero, the subreport is considered invalid, and won't match.
+	 */
+	__u8 mask;
+
+	/*
+	 * The ID to be assigned to the report, if the "mask" matches.
+	 * Only valid if "mask" is not zero.
+	 */
+	__u8 id;
+};
+
 /*
  * Tablet interface's pen input parameters.
  *
@@ -54,6 +72,8 @@ struct uclogic_params_pen {
 	unsigned int desc_size;
 	/* Report ID, if reports should be tweaked, zero if not */
 	unsigned int id;
+	/* The list of subreports */
+	struct uclogic_params_pen_subreport subreport_list[1];
 	/* Type of in-range reporting, only valid if "id" is not zero */
 	enum uclogic_params_pen_inrange inrange;
 	/*
@@ -148,13 +168,6 @@ struct uclogic_params {
 	 * Only valid, if "invalid" is false.
 	 */
 	struct uclogic_params_frame frame;
-	/*
-	 * Bitmask matching frame controls "sub-report" flag in the second
-	 * byte of the pen report, or zero if it's not expected.
-	 * Only valid if both "pen" and "frame" are valid, and "frame.id" is
-	 * not zero.
-	 */
-	__u8 pen_frame_flag;
 };
 
 /* Initialize a tablet interface and discover its parameters */
@@ -163,21 +176,21 @@ extern int uclogic_params_init(struct uclogic_params *params,
 
 /* Tablet interface parameters *printf format string */
 #define UCLOGIC_PARAMS_FMT_STR \
-		".invalid = %s\n"                   \
-		".desc_ptr = %p\n"                  \
-		".desc_size = %u\n"                 \
-		".pen.desc_ptr = %p\n"              \
-		".pen.desc_size = %u\n"             \
-		".pen.id = %u\n"                    \
-		".pen.inrange = %s\n"               \
-		".pen.fragmented_hires = %s\n"      \
-		".pen.tilt_y_flipped = %s\n"        \
-		".frame.desc_ptr = %p\n"            \
-		".frame.desc_size = %u\n"           \
-		".frame.id = %u\n"                  \
-		".frame.re_lsb = %u\n"              \
-		".frame.dev_id_byte = %u\n"         \
-		".pen_frame_flag = 0x%02x\n"
+		".invalid = %s\n"                               \
+		".desc_ptr = %p\n"                              \
+		".desc_size = %u\n"                             \
+		".pen.desc_ptr = %p\n"                          \
+		".pen.desc_size = %u\n"                         \
+		".pen.id = %u\n"                                \
+		".pen.subreport_list[0] = {0x%02hhx, %hhu}\n"   \
+		".pen.inrange = %s\n"                           \
+		".pen.fragmented_hires = %s\n"                  \
+		".pen.tilt_y_flipped = %s\n"                    \
+		".frame.desc_ptr = %p\n"                        \
+		".frame.desc_size = %u\n"                       \
+		".frame.id = %u\n"                              \
+		".frame.re_lsb = %u\n"                          \
+		".frame.dev_id_byte = %u\n"
 
 /* Tablet interface parameters *printf format arguments */
 #define UCLOGIC_PARAMS_FMT_ARGS(_params) \
@@ -187,6 +200,8 @@ extern int uclogic_params_init(struct uclogic_params *params,
 		(_params)->pen.desc_ptr,                                    \
 		(_params)->pen.desc_size,                                   \
 		(_params)->pen.id,                                          \
+		(_params)->pen.subreport_list[0].mask,                      \
+		(_params)->pen.subreport_list[0].id,                        \
 		uclogic_params_pen_inrange_to_str((_params)->pen.inrange),  \
 		((_params)->pen.fragmented_hires ? "true" : "false"),       \
 		((_params)->pen.tilt_y_flipped ? "true" : "false"),         \
@@ -194,8 +209,7 @@ extern int uclogic_params_init(struct uclogic_params *params,
 		(_params)->frame.desc_size,                                 \
 		(_params)->frame.id,                                        \
 		(_params)->frame.re_lsb,                                    \
-		(_params)->frame.dev_id_byte,                               \
-		(_params)->pen_frame_flag
+		(_params)->frame.dev_id_byte
 
 /* Get a replacement report descriptor for a tablet's interface. */
 extern int uclogic_params_get_desc(const struct uclogic_params *params,
-- 
2.25.1

