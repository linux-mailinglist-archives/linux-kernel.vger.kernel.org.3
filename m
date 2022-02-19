Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355404BC789
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 11:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241983AbiBSKCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 05:02:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241923AbiBSKCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 05:02:37 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C291AD95;
        Sat, 19 Feb 2022 02:02:18 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d3so2825093wrf.1;
        Sat, 19 Feb 2022 02:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wACpoUOdIfkulcSBEmf1xUmhCY+xDLX/Udau/68Q6oU=;
        b=ZIJ1xsVh9YvCQZtEiuDvTmldCSMdPckqDK0QrkRFKepecqiHHC0jkkW0oVh2CsSoLC
         Wp32biet5V94cHFCdIz1NcsZEv8JA16uoe8oa43+2YdXGhqTvZs89vkkzurCR1iIxc+x
         fUGrOOz8QGM/Xtul5bf8Sa05HZiP1iKM0xhpIV0Aj59tviPZ6bNLnTYFq7ImQm7+TPv+
         84+ECrHhF9jfiK2ip4uJh0V3qTQ+N/6XvBcUieMhMegF+LVI5cbRJlPs2IgS9vNLLrOZ
         fDhQzfbA72zz6CypicYtLBGo2MuOwy2nBhDujD5zPQFKIuNuGoUDAgFbifcFYpwhPmo6
         9Mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wACpoUOdIfkulcSBEmf1xUmhCY+xDLX/Udau/68Q6oU=;
        b=uML5MsSrXcM9T0kIFZjDEPXf5q9OhQrPYju3Oj/SYYl1PJdiQGLg6S6+VJgFCxj5hT
         vH3V0yC+gyRQcQjMfPOfpGF9nrRBk17jvolhsTYEq7CfJXMVit+7/zKabMDWo6A8W0rW
         lvpZBUhQeDMd0DhJKbT6SRQVjB+auIhLLGeoW5WAkkXnO7EV+rj9L4sPWIXJgwJQmnPi
         mhmhSGyJZohJsDiH5H4g/L7Adx5sMGT5KN+ai3vFXRPXk63jd+MEsTud/gj8loKFizBR
         5JOaQW2kpDKP0vafW+e1QfEnXMAbjxywuPJlqLI8ufa8EZqIHtv/kF+0voKGLqG80T/Z
         eZ3A==
X-Gm-Message-State: AOAM531WQmJaeH6IjpF0TfAOSqj7Akub0zbuuPl7cqI3/jSB0UVAZYLw
        acqlgxJKIqupJ9OSSS10pGw=
X-Google-Smtp-Source: ABdhPJwF8NJTGs6NqCCOKggD6X0NRBw2fEZBBlwo6X7nZQwCsSg+djE+QSzk8pkZKQX9xGZzGDl3Kw==
X-Received: by 2002:a5d:4242:0:b0:1e3:3130:5088 with SMTP id s2-20020a5d4242000000b001e331305088mr8629607wrr.540.1645264937052;
        Sat, 19 Feb 2022 02:02:17 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id az13sm24417244wrb.39.2022.02.19.02.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 02:02:16 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.18/uclogic 9/9] HID: uclogic: Support multiple frame input devices
Date:   Sat, 19 Feb 2022 11:01:57 +0100
Message-Id: <20220219100157.41920-10-jose.exposito89@gmail.com>
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

Add support for multiple frame input devices and their parameters to
the UC-Logic driver. This prepares for creating a separate input device
for Huion HS610 virtual touch ring reports.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-core.c   |  19 ++++--
 drivers/hid/hid-uclogic-params.c | 100 +++++++++++++++----------------
 drivers/hid/hid-uclogic-params.h |  26 ++++----
 3 files changed, 74 insertions(+), 71 deletions(-)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index a02edeb30a35..05147f2d7564 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -296,17 +296,18 @@ static int uclogic_raw_event_pen(struct uclogic_drvdata *drvdata,
  * uclogic_raw_event_frame - handle raw frame events (frame HID reports).
  *
  * @drvdata:	Driver data.
+ * @frame:	The parameters of the frame controls to handle.
  * @data:	Report data buffer, can be modified.
  * @size:	Report data size, bytes.
  *
  * Returns:
  *	Negative value on error (stops event delivery), zero for success.
  */
-static int uclogic_raw_event_frame(struct uclogic_drvdata *drvdata,
-					u8 *data, int size)
+static int uclogic_raw_event_frame(
+		struct uclogic_drvdata *drvdata,
+		const struct uclogic_params_frame *frame,
+		u8 *data, int size)
 {
-	struct uclogic_params_frame *frame = &drvdata->params.frame;
-
 	WARN_ON(drvdata == NULL);
 	WARN_ON(data == NULL && size != 0);
 
@@ -352,6 +353,7 @@ static int uclogic_raw_event(struct hid_device *hdev,
 	struct uclogic_params *params = &drvdata->params;
 	struct uclogic_params_pen_subreport *subreport;
 	struct uclogic_params_pen_subreport *subreport_list_end;
+	size_t i;
 
 	/* Do not handle anything but input reports */
 	if (report->type != HID_INPUT_REPORT)
@@ -382,8 +384,13 @@ static int uclogic_raw_event(struct hid_device *hdev,
 		}
 
 		/* Tweak frame control reports, if necessary */
-		if (report_id == params->frame.id)
-			return uclogic_raw_event_frame(drvdata, data, size);
+		for (i = 0; i < ARRAY_SIZE(params->frame_list); i++) {
+			if (report_id == params->frame_list[i].id) {
+				return uclogic_raw_event_frame(
+					drvdata, &params->frame_list[i],
+					data, size);
+			}
+		}
 
 		break;
 	}
diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index f667347ad0df..5f50ceb875d6 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -512,9 +512,12 @@ static int uclogic_params_frame_init_v1(struct uclogic_params_frame *frame,
 void uclogic_params_cleanup(struct uclogic_params *params)
 {
 	if (!params->invalid) {
+		size_t i;
 		kfree(params->desc_ptr);
 		uclogic_params_pen_cleanup(&params->pen);
-		uclogic_params_frame_cleanup(&params->frame);
+		for (i = 0; i < ARRAY_SIZE(params->frame_list); i++)
+			uclogic_params_frame_cleanup(&params->frame_list[i]);
+
 		memset(params, 0, sizeof(*params));
 	}
 }
@@ -542,60 +545,53 @@ int uclogic_params_get_desc(const struct uclogic_params *params,
 				__u8 **pdesc,
 				unsigned int *psize)
 {
-	bool common_present;
-	bool pen_present;
-	bool frame_present;
-	unsigned int size;
+	int rc = -ENOMEM;
+	bool present = false;
+	unsigned int size = 0;
 	__u8 *desc = NULL;
+	size_t i;
 
 	/* Check arguments */
 	if (params == NULL || pdesc == NULL || psize == NULL)
 		return -EINVAL;
 
-	size = 0;
-
-	common_present = (params->desc_ptr != NULL);
-	pen_present = (params->pen.desc_ptr != NULL);
-	frame_present = (params->frame.desc_ptr != NULL);
-
-	if (common_present)
-		size += params->desc_size;
-	if (pen_present)
-		size += params->pen.desc_size;
-	if (frame_present)
-		size += params->frame.desc_size;
-
-	if (common_present || pen_present || frame_present) {
-		__u8 *p;
-
-		desc = kmalloc(size, GFP_KERNEL);
-		if (desc == NULL)
-			return -ENOMEM;
-		p = desc;
-
-		if (common_present) {
-			memcpy(p, params->desc_ptr,
-				params->desc_size);
-			p += params->desc_size;
-		}
-		if (pen_present) {
-			memcpy(p, params->pen.desc_ptr,
-				params->pen.desc_size);
-			p += params->pen.desc_size;
-		}
-		if (frame_present) {
-			memcpy(p, params->frame.desc_ptr,
-				params->frame.desc_size);
-			p += params->frame.desc_size;
-		}
+	/* Concatenate descriptors */
+#define ADD_DESC(_desc_ptr, _desc_size) \
+	do {                                                        \
+		unsigned int new_size;                              \
+		__u8 *new_desc;                                     \
+		if ((_desc_ptr) == NULL) {                          \
+			break;                                      \
+		}                                                   \
+		new_size = size + (_desc_size);                     \
+		new_desc = krealloc(desc, new_size, GFP_KERNEL);    \
+		if (new_desc == NULL) {                             \
+			goto cleanup;                               \
+		}                                                   \
+		memcpy(new_desc + size, (_desc_ptr), (_desc_size)); \
+		desc = new_desc;                                    \
+		size = new_size;                                    \
+		present = true;                                     \
+	} while (0)
+
+	ADD_DESC(params->desc_ptr, params->desc_size);
+	ADD_DESC(params->pen.desc_ptr, params->pen.desc_size);
+	for (i = 0; i < ARRAY_SIZE(params->frame_list); i++) {
+		ADD_DESC(params->frame_list[i].desc_ptr,
+				params->frame_list[i].desc_size);
+	}
 
-		WARN_ON(p != desc + size);
+#undef ADD_DESC
 
+	if (present) {
+		*pdesc = desc;
 		*psize = size;
+		desc = NULL;
 	}
-
-	*pdesc = desc;
-	return 0;
+	rc = 0;
+cleanup:
+	kfree(desc);
+	return rc;
 }
 
 /**
@@ -751,7 +747,7 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 			hid_dbg(hdev, "pen v2 parameters found\n");
 			/* Create v2 frame parameters */
 			rc = uclogic_params_frame_init_with_desc(
-					&p.frame,
+					&p.frame_list[0],
 					uclogic_rdesc_v2_frame_arr,
 					uclogic_rdesc_v2_frame_size,
 					UCLOGIC_RDESC_V2_FRAME_ID);
@@ -779,7 +775,7 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 	} else if (found) {
 		hid_dbg(hdev, "pen v1 parameters found\n");
 		/* Try to probe v1 frame */
-		rc = uclogic_params_frame_init_v1(&p.frame,
+		rc = uclogic_params_frame_init_v1(&p.frame_list[0],
 						  &found, hdev);
 		if (rc != 0) {
 			hid_err(hdev, "v1 frame probing failed: %d\n", rc);
@@ -1033,7 +1029,7 @@ int uclogic_params_init(struct uclogic_params *params,
 			}
 			/* Initialize frame parameters */
 			rc = uclogic_params_frame_init_with_desc(
-				&p.frame,
+				&p.frame_list[0],
 				uclogic_rdesc_xppen_deco01_frame_arr,
 				uclogic_rdesc_xppen_deco01_frame_size,
 				0);
@@ -1059,7 +1055,7 @@ int uclogic_params_init(struct uclogic_params *params,
 			goto cleanup;
 		} else if (found) {
 			rc = uclogic_params_frame_init_with_desc(
-				&p.frame,
+				&p.frame_list[0],
 				uclogic_rdesc_ugee_g5_frame_arr,
 				uclogic_rdesc_ugee_g5_frame_size,
 				UCLOGIC_RDESC_UGEE_G5_FRAME_ID);
@@ -1069,9 +1065,9 @@ int uclogic_params_init(struct uclogic_params *params,
 					rc);
 				goto cleanup;
 			}
-			p.frame.re_lsb =
+			p.frame_list[0].re_lsb =
 				UCLOGIC_RDESC_UGEE_G5_FRAME_RE_LSB;
-			p.frame.dev_id_byte =
+			p.frame_list[0].dev_id_byte =
 				UCLOGIC_RDESC_UGEE_G5_FRAME_DEV_ID_BYTE;
 		} else {
 			hid_warn(hdev, "pen parameters not found");
@@ -1093,7 +1089,7 @@ int uclogic_params_init(struct uclogic_params *params,
 			goto cleanup;
 		} else if (found) {
 			rc = uclogic_params_frame_init_with_desc(
-				&p.frame,
+				&p.frame_list[0],
 				uclogic_rdesc_ugee_ex07_frame_arr,
 				uclogic_rdesc_ugee_ex07_frame_size,
 				0);
diff --git a/drivers/hid/hid-uclogic-params.h b/drivers/hid/hid-uclogic-params.h
index c18569591b75..86f616dfbb53 100644
--- a/drivers/hid/hid-uclogic-params.h
+++ b/drivers/hid/hid-uclogic-params.h
@@ -165,10 +165,10 @@ struct uclogic_params {
 	 */
 	struct uclogic_params_pen pen;
 	/*
-	 * Frame control parameters and optional report descriptor part.
-	 * Only valid, if "invalid" is false.
+	 * The list of frame control parameters and optional report descriptor
+	 * parts. Only valid, if "invalid" is false.
 	 */
-	struct uclogic_params_frame frame;
+	struct uclogic_params_frame frame_list[1];
 };
 
 /* Initialize a tablet interface and discover its parameters */
@@ -187,11 +187,11 @@ extern int uclogic_params_init(struct uclogic_params *params,
 		".pen.inrange = %s\n"                           \
 		".pen.fragmented_hires = %s\n"                  \
 		".pen.tilt_y_flipped = %s\n"                    \
-		".frame.desc_ptr = %p\n"                        \
-		".frame.desc_size = %u\n"                       \
-		".frame.id = %u\n"                              \
-		".frame.re_lsb = %u\n"                          \
-		".frame.dev_id_byte = %u\n"
+		".frame_list[0].desc_ptr = %p\n"                \
+		".frame_list[0].desc_size = %u\n"               \
+		".frame_list[0].id = %u\n"                      \
+		".frame_list[0].re_lsb = %u\n"                  \
+		".frame_list[0].dev_id_byte = %u\n"
 
 /* Tablet interface parameters *printf format arguments */
 #define UCLOGIC_PARAMS_FMT_ARGS(_params) \
@@ -206,11 +206,11 @@ extern int uclogic_params_init(struct uclogic_params *params,
 		uclogic_params_pen_inrange_to_str((_params)->pen.inrange),  \
 		((_params)->pen.fragmented_hires ? "true" : "false"),       \
 		((_params)->pen.tilt_y_flipped ? "true" : "false"),         \
-		(_params)->frame.desc_ptr,                                  \
-		(_params)->frame.desc_size,                                 \
-		(_params)->frame.id,                                        \
-		(_params)->frame.re_lsb,                                    \
-		(_params)->frame.dev_id_byte
+		(_params)->frame_list[0].desc_ptr,                          \
+		(_params)->frame_list[0].desc_size,                         \
+		(_params)->frame_list[0].id,                                \
+		(_params)->frame_list[0].re_lsb,                            \
+		(_params)->frame_list[0].dev_id_byte
 
 /* Get a replacement report descriptor for a tablet's interface. */
 extern int uclogic_params_get_desc(const struct uclogic_params *params,
-- 
2.25.1

