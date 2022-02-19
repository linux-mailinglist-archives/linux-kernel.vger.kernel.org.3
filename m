Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DF34BC78B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 11:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241916AbiBSKCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 05:02:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241907AbiBSKCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 05:02:30 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFE5AE70;
        Sat, 19 Feb 2022 02:02:11 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id k1so18480293wrd.8;
        Sat, 19 Feb 2022 02:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F5g1OGQu7KmLrerQIkf+CdpmHMxgsPe6tJUKuh6F0rw=;
        b=fQRDA7oDDA8uAclitux24krqqn/PC0T/OF1c+T5U1h76uDcDJdHdnAg1SSRCw32wHR
         Y+QdLahvh96+81rrOG4Zq58I18qcOEV+6VEp1kdBco8oi8BJMaxhmYTq4eZ5HQPmszpu
         U+SbeRxi89r0taQsMEgFM8vLDq6SEe+fUmteTAg1dp3rVopj/5akdmAxDumH30s5mEmD
         TpsQT6dcnNnZWx8h3IkcECnLecdb72cEvtXQYAXTOCf3Wkn68XO2wLjYZqPFrmUE+aa9
         NNeoaQawfzIXs0nZdKNuv5ODVUzlTffDr/kiGg0EJHxTo60/Yn9SJKE+NnbQUvE9jxRh
         HsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F5g1OGQu7KmLrerQIkf+CdpmHMxgsPe6tJUKuh6F0rw=;
        b=yZ6g15dNax9OGLxPdWontOCSOfWlyevjTUcdzoNoLS7C/SJi5z0t7G+DGL3wPfV6cA
         0THveOArJi42O0C3ACtQ/nH1Vk+vxErnrhkqv7M1JfDb0SSpilJeAIfCM8Hsv8nMDYiy
         On26QDtx1nKhLerCGzJr5G/6WWtIQCK7fZiLF7rw1P04wVeUEGy9MyFGvLSKhzjsJ/JP
         a54SNNsJ5tW5SItroXOpORRgNb+RJviWc1TEK508TP4rMcykL3JGYefn+Zhk/iXYUw0r
         QjiiQCx7Tcm1VMjwqNi+mAA7WOAnlI5fcs2wGPXTtc2slWyrY5rGw5svzptZaZZbCVaQ
         My3Q==
X-Gm-Message-State: AOAM531f5F9bJWsrzo3FoSK3udSH5a0/IVLvYkE2hnRAnRDfUb3h3waJ
        JSfUzklYlLTmTjXVeCjCokI=
X-Google-Smtp-Source: ABdhPJwE7t1gHbAv/4AKt41EE0fAFsGsb4jWLty/E+RltTuIOKA7XJElsnl4u6NPC9yUxo3sO2BK3A==
X-Received: by 2002:a5d:6a0f:0:b0:1e5:53db:4ddd with SMTP id m15-20020a5d6a0f000000b001e553db4dddmr8885834wru.614.1645264930353;
        Sat, 19 Feb 2022 02:02:10 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id az13sm24417244wrb.39.2022.02.19.02.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 02:02:10 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.18/uclogic 1/9] HID: uclogic: Remove pen usage masking
Date:   Sat, 19 Feb 2022 11:01:49 +0100
Message-Id: <20220219100157.41920-2-jose.exposito89@gmail.com>
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

Remove support for pen usage masking from hid-uclogic. Disable whole
interfaces instead. Most of those interfaces are useless, and if there
is one which has an unused pen usage, but also has useful reports, its
report descriptor should be rewritten instead.

This simplifies the code and the data structures.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-core.c   | 23 +----------------------
 drivers/hid/hid-uclogic-params.c | 29 +++++------------------------
 drivers/hid/hid-uclogic-params.h |  9 +--------
 3 files changed, 7 insertions(+), 54 deletions(-)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index 73d79d149869..26849f1f5459 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -81,24 +81,6 @@ static __u8 *uclogic_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	return rdesc;
 }
 
-static int uclogic_input_mapping(struct hid_device *hdev,
-				 struct hid_input *hi,
-				 struct hid_field *field,
-				 struct hid_usage *usage,
-				 unsigned long **bit,
-				 int *max)
-{
-	struct uclogic_drvdata *drvdata = hid_get_drvdata(hdev);
-	struct uclogic_params *params = &drvdata->params;
-
-	/* discard the unused pen interface */
-	if (params->pen_unused && (field->application == HID_DG_PEN))
-		return -1;
-
-	/* let hid-core decide what to do */
-	return 0;
-}
-
 static int uclogic_input_configured(struct hid_device *hdev,
 		struct hid_input *hi)
 {
@@ -374,9 +356,7 @@ static int uclogic_raw_event(struct hid_device *hdev,
 		return 0;
 
 	/* Tweak pen reports, if necessary */
-	if (!params->pen_unused &&
-	    (report_id == params->pen.id) &&
-	    (size >= 2)) {
+	if ((report_id == params->pen.id) && (size >= 2)) {
 		/* If it's the "virtual" frame controls report */
 		if (params->frame.id != 0 &&
 		    data[1] & params->pen_frame_flag) {
@@ -464,7 +444,6 @@ static struct hid_driver uclogic_driver = {
 	.remove = uclogic_remove,
 	.report_fixup = uclogic_report_fixup,
 	.raw_event = uclogic_raw_event,
-	.input_mapping = uclogic_input_mapping,
 	.input_configured = uclogic_input_configured,
 #ifdef CONFIG_PM
 	.resume	          = uclogic_resume,
diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 98910d8dae92..71496735cbf0 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -514,8 +514,7 @@ void uclogic_params_cleanup(struct uclogic_params *params)
 {
 	if (!params->invalid) {
 		kfree(params->desc_ptr);
-		if (!params->pen_unused)
-			uclogic_params_pen_cleanup(&params->pen);
+		uclogic_params_pen_cleanup(&params->pen);
 		uclogic_params_frame_cleanup(&params->frame);
 		memset(params, 0, sizeof(*params));
 	}
@@ -557,7 +556,7 @@ int uclogic_params_get_desc(const struct uclogic_params *params,
 	size = 0;
 
 	common_present = (params->desc_ptr != NULL);
-	pen_present = (!params->pen_unused && params->pen.desc_ptr != NULL);
+	pen_present = (params->pen.desc_ptr != NULL);
 	frame_present = (params->frame.desc_ptr != NULL);
 
 	if (common_present)
@@ -680,21 +679,6 @@ static int uclogic_params_init_with_opt_desc(struct uclogic_params *params,
 	return rc;
 }
 
-/**
- * uclogic_params_init_with_pen_unused() - initialize tablet interface
- * parameters preserving original reports and generic HID processing, but
- * disabling pen usage.
- *
- * @params:		Parameters to initialize (to be cleaned with
- *			uclogic_params_cleanup()). Not modified in case of
- *			error. Cannot be NULL.
- */
-static void uclogic_params_init_with_pen_unused(struct uclogic_params *params)
-{
-	memset(params, 0, sizeof(*params));
-	params->pen_unused = true;
-}
-
 /**
  * uclogic_params_huion_init() - initialize a Huion tablet interface and discover
  * its parameters.
@@ -734,8 +718,7 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 
 	/* If it's not a pen interface */
 	if (bInterfaceNumber != 0) {
-		/* TODO: Consider marking the interface invalid */
-		uclogic_params_init_with_pen_unused(&p);
+		uclogic_params_init_invalid(&p);
 		goto output;
 	}
 
@@ -1033,8 +1016,7 @@ int uclogic_params_init(struct uclogic_params *params,
 				uclogic_params_init_invalid(&p);
 			}
 		} else {
-			/* TODO: Consider marking the interface invalid */
-			uclogic_params_init_with_pen_unused(&p);
+			uclogic_params_init_invalid(&p);
 		}
 		break;
 	case VID_PID(USB_VENDOR_ID_UGEE,
@@ -1056,8 +1038,7 @@ int uclogic_params_init(struct uclogic_params *params,
 			if (rc != 0)
 				goto cleanup;
 		} else {
-			/* TODO: Consider marking the interface invalid */
-			uclogic_params_init_with_pen_unused(&p);
+			uclogic_params_init_invalid(&p);
 		}
 		break;
 	case VID_PID(USB_VENDOR_ID_TRUST,
diff --git a/drivers/hid/hid-uclogic-params.h b/drivers/hid/hid-uclogic-params.h
index e8381bb77bd0..48b974943bb9 100644
--- a/drivers/hid/hid-uclogic-params.h
+++ b/drivers/hid/hid-uclogic-params.h
@@ -138,14 +138,9 @@ struct uclogic_params {
 	 * Only valid, if "desc_ptr" is not NULL.
 	 */
 	unsigned int desc_size;
-	/*
-	 * True, if pen usage in report descriptor is invalid, when present.
-	 * Only valid, if "invalid" is false.
-	 */
-	bool pen_unused;
 	/*
 	 * Pen parameters and optional report descriptor part.
-	 * Only valid if "pen_unused" is valid and false.
+	 * Only valid, if "invalid" is false.
 	 */
 	struct uclogic_params_pen pen;
 	/*
@@ -171,7 +166,6 @@ extern int uclogic_params_init(struct uclogic_params *params,
 		".invalid = %s\n"                   \
 		".desc_ptr = %p\n"                  \
 		".desc_size = %u\n"                 \
-		".pen_unused = %s\n"                \
 		".pen.desc_ptr = %p\n"              \
 		".pen.desc_size = %u\n"             \
 		".pen.id = %u\n"                    \
@@ -190,7 +184,6 @@ extern int uclogic_params_init(struct uclogic_params *params,
 		((_params)->invalid ? "true" : "false"),                    \
 		(_params)->desc_ptr,                                        \
 		(_params)->desc_size,                                       \
-		((_params)->pen_unused ? "true" : "false"),                 \
 		(_params)->pen.desc_ptr,                                    \
 		(_params)->pen.desc_size,                                   \
 		(_params)->pen.id,                                          \
-- 
2.25.1

