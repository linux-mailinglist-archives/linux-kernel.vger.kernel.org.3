Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824374BC77B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 11:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241967AbiBSKCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 05:02:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241926AbiBSKCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 05:02:35 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32E2AE7B;
        Sat, 19 Feb 2022 02:02:16 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d3so2824991wrf.1;
        Sat, 19 Feb 2022 02:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wTpxhm6UflDP1An7oaHPIEtXwTE7w+WpkFnMNKaToYA=;
        b=h3MgdrmOL9aBtMCokAZW2klpoG18P7NOuITVNWdjBmFL2Txn94nSx7cFBJEL3To2s7
         9Y44InbMb70uffbZw9SXI9ImU3zgCYyTLuxSwnEZmqZUD2lk7HKhGB94Xt37yCpiyM6z
         tysGzOTAXo2JjjrXn/ibmO5grpTPzSAD6u7AWHrkroOhgoMt1deKP4bLkZTq2mqQ8LkN
         tDd6YYM29g94epe2Sw9+8pN2G7CVCPOmgvmE+rUH/HeheA/+qNbwPCpkil1g4JkBjwlu
         qc07FwNrZ17Qd9MomJh6sQ9ND2Z89jTWzA9jjaEJYTKvxIEffmjWc2Sa3FzhrX8RGvad
         W3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wTpxhm6UflDP1An7oaHPIEtXwTE7w+WpkFnMNKaToYA=;
        b=koRWE0wcdp8l3NdVEb7TEE0thzKJ948XpUnfnVUN33BZ8r7CzAiX1Ke72rxxjpN5Dp
         m1bZFfIJH7DFfZRWA7v1A8nZZUMVbBRx83hleSwgBOZoVl8AZ6HFj0xiGEqBaQh/B7L+
         iPG7zitHoDaLQvt1u0wxjKmR/TXO3GbIDCAf9ICmoTLh+OJETwsp46eN8kM2s3tpqcSa
         +yLN99XDinkJTZ/6+gSvM4+a9tkv1hZXOoOvlTMmSq6mpOWeOEsD6YUDErgtQpSjVEac
         XwnCVgnPZKCzRUSTpafNlLy157g2WfGsgqlb+Bg/PdnxF3UEyuab/YO9f1PpuaA5qoOX
         8h0w==
X-Gm-Message-State: AOAM533YA2kSbvunGFcxDkwzpe3faud4Qd44wFkAqU+GDAroWVtpebcF
        u7n++6kNNFIzOWZaFIY6niREwli1rs4=
X-Google-Smtp-Source: ABdhPJxg1ZmFBsu4u5jbkdmNiGM1w3JPAE9yVaUSJgUvIDjJd2oJTQeyfXQy/ZrEmlxdUEEhmFFosg==
X-Received: by 2002:a5d:420b:0:b0:1e5:eb98:25f5 with SMTP id n11-20020a5d420b000000b001e5eb9825f5mr8807122wrq.102.1645264935262;
        Sat, 19 Feb 2022 02:02:15 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id az13sm24417244wrb.39.2022.02.19.02.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 02:02:15 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.18/uclogic 7/9] HID: uclogic: Put version first in rdesc namespace
Date:   Sat, 19 Feb 2022 11:01:55 +0100
Message-Id: <20220219100157.41920-8-jose.exposito89@gmail.com>
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

Put general hardware version before everything else in uclogic_rdesc_
namespace.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params.c | 32 ++++++++++++++++----------------
 drivers/hid/hid-uclogic-rdesc.c  | 28 ++++++++++++++--------------
 drivers/hid/hid-uclogic-rdesc.h  | 24 ++++++++++++------------
 3 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 168749d9a112..f667347ad0df 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -207,8 +207,8 @@ static int uclogic_params_pen_init_v1(struct uclogic_params_pen *pen,
 	 * Generate pen report descriptor
 	 */
 	desc_ptr = uclogic_rdesc_template_apply(
-				uclogic_rdesc_pen_v1_template_arr,
-				uclogic_rdesc_pen_v1_template_size,
+				uclogic_rdesc_v1_pen_template_arr,
+				uclogic_rdesc_v1_pen_template_size,
 				desc_params, ARRAY_SIZE(desc_params));
 	if (desc_ptr == NULL) {
 		rc = -ENOMEM;
@@ -221,8 +221,8 @@ static int uclogic_params_pen_init_v1(struct uclogic_params_pen *pen,
 	memset(pen, 0, sizeof(*pen));
 	pen->desc_ptr = desc_ptr;
 	desc_ptr = NULL;
-	pen->desc_size = uclogic_rdesc_pen_v1_template_size;
-	pen->id = UCLOGIC_RDESC_PEN_V1_ID;
+	pen->desc_size = uclogic_rdesc_v1_pen_template_size;
+	pen->id = UCLOGIC_RDESC_V1_PEN_ID;
 	pen->inrange = UCLOGIC_PARAMS_PEN_INRANGE_INVERTED;
 	found = true;
 finish:
@@ -351,8 +351,8 @@ static int uclogic_params_pen_init_v2(struct uclogic_params_pen *pen,
 	 * Generate pen report descriptor
 	 */
 	desc_ptr = uclogic_rdesc_template_apply(
-				uclogic_rdesc_pen_v2_template_arr,
-				uclogic_rdesc_pen_v2_template_size,
+				uclogic_rdesc_v2_pen_template_arr,
+				uclogic_rdesc_v2_pen_template_size,
 				desc_params, ARRAY_SIZE(desc_params));
 	if (desc_ptr == NULL) {
 		rc = -ENOMEM;
@@ -365,8 +365,8 @@ static int uclogic_params_pen_init_v2(struct uclogic_params_pen *pen,
 	memset(pen, 0, sizeof(*pen));
 	pen->desc_ptr = desc_ptr;
 	desc_ptr = NULL;
-	pen->desc_size = uclogic_rdesc_pen_v2_template_size;
-	pen->id = UCLOGIC_RDESC_PEN_V2_ID;
+	pen->desc_size = uclogic_rdesc_v2_pen_template_size;
+	pen->id = UCLOGIC_RDESC_V2_PEN_ID;
 	pen->inrange = UCLOGIC_PARAMS_PEN_INRANGE_NONE;
 	pen->fragmented_hires = true;
 	pen->tilt_y_flipped = true;
@@ -487,9 +487,9 @@ static int uclogic_params_frame_init_v1(struct uclogic_params_frame *frame,
 		hid_dbg(hdev, "generic buttons enabled\n");
 		rc = uclogic_params_frame_init_with_desc(
 				frame,
-				uclogic_rdesc_frame_v1_arr,
-				uclogic_rdesc_frame_v1_size,
-				UCLOGIC_RDESC_FRAME_V1_ID);
+				uclogic_rdesc_v1_frame_arr,
+				uclogic_rdesc_v1_frame_size,
+				UCLOGIC_RDESC_V1_FRAME_ID);
 		if (rc != 0)
 			goto cleanup;
 		found = true;
@@ -752,9 +752,9 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 			/* Create v2 frame parameters */
 			rc = uclogic_params_frame_init_with_desc(
 					&p.frame,
-					uclogic_rdesc_frame_v2_arr,
-					uclogic_rdesc_frame_v2_size,
-					UCLOGIC_RDESC_FRAME_V2_ID);
+					uclogic_rdesc_v2_frame_arr,
+					uclogic_rdesc_v2_frame_size,
+					UCLOGIC_RDESC_V2_FRAME_ID);
 			if (rc != 0) {
 				hid_err(hdev,
 					"failed creating v2 frame parameters: %d\n",
@@ -764,7 +764,7 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 			/* Link frame button subreports from pen reports */
 			p.pen.subreport_list[0].value = 0xe0;
 			p.pen.subreport_list[0].id =
-				UCLOGIC_RDESC_FRAME_V2_ID;
+				UCLOGIC_RDESC_V2_FRAME_ID;
 			goto output;
 		}
 		hid_dbg(hdev, "pen v2 parameters not found\n");
@@ -791,7 +791,7 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 			/* Link frame button subreports from pen reports */
 			p.pen.subreport_list[0].value = 0xe0;
 			p.pen.subreport_list[0].id =
-				UCLOGIC_RDESC_FRAME_V1_ID;
+				UCLOGIC_RDESC_V1_FRAME_ID;
 		}
 		goto output;
 	}
diff --git a/drivers/hid/hid-uclogic-rdesc.c b/drivers/hid/hid-uclogic-rdesc.c
index e8dedede3395..04644d93bd11 100644
--- a/drivers/hid/hid-uclogic-rdesc.c
+++ b/drivers/hid/hid-uclogic-rdesc.c
@@ -532,7 +532,7 @@ const size_t uclogic_rdesc_twha60_fixed1_size =
 			sizeof(uclogic_rdesc_twha60_fixed1_arr);
 
 /* Fixed report descriptor template for (tweaked) v1 pen reports */
-const __u8 uclogic_rdesc_pen_v1_template_arr[] = {
+const __u8 uclogic_rdesc_v1_pen_template_arr[] = {
 	0x05, 0x0D,             /*  Usage Page (Digitizer),                 */
 	0x09, 0x02,             /*  Usage (Pen),                            */
 	0xA1, 0x01,             /*  Collection (Application),               */
@@ -582,11 +582,11 @@ const __u8 uclogic_rdesc_pen_v1_template_arr[] = {
 	0xC0                    /*  End Collection                          */
 };
 
-const size_t uclogic_rdesc_pen_v1_template_size =
-			sizeof(uclogic_rdesc_pen_v1_template_arr);
+const size_t uclogic_rdesc_v1_pen_template_size =
+			sizeof(uclogic_rdesc_v1_pen_template_arr);
 
 /* Fixed report descriptor template for (tweaked) v2 pen reports */
-const __u8 uclogic_rdesc_pen_v2_template_arr[] = {
+const __u8 uclogic_rdesc_v2_pen_template_arr[] = {
 	0x05, 0x0D,             /*  Usage Page (Digitizer),                 */
 	0x09, 0x02,             /*  Usage (Pen),                            */
 	0xA1, 0x01,             /*  Collection (Application),               */
@@ -648,8 +648,8 @@ const __u8 uclogic_rdesc_pen_v2_template_arr[] = {
 	0xC0                    /*  End Collection                          */
 };
 
-const size_t uclogic_rdesc_pen_v2_template_size =
-			sizeof(uclogic_rdesc_pen_v2_template_arr);
+const size_t uclogic_rdesc_v2_pen_template_size =
+			sizeof(uclogic_rdesc_v2_pen_template_arr);
 
 /*
  * Expand to the contents of a generic frame report descriptor.
@@ -699,18 +699,18 @@ const size_t uclogic_rdesc_pen_v2_template_size =
 	0xC0            /*  End Collection                      */
 
 /* Fixed report descriptor for (tweaked) v1 frame reports */
-const __u8 uclogic_rdesc_frame_v1_arr[] = {
-	UCLOGIC_RDESC_FRAME_BYTES(UCLOGIC_RDESC_FRAME_V1_ID, 8)
+const __u8 uclogic_rdesc_v1_frame_arr[] = {
+	UCLOGIC_RDESC_FRAME_BYTES(UCLOGIC_RDESC_V1_FRAME_ID, 8)
 };
-const size_t uclogic_rdesc_frame_v1_size =
-			sizeof(uclogic_rdesc_frame_v1_arr);
+const size_t uclogic_rdesc_v1_frame_size =
+			sizeof(uclogic_rdesc_v1_frame_arr);
 
 /* Fixed report descriptor for (tweaked) v2 frame reports */
-const __u8 uclogic_rdesc_frame_v2_arr[] = {
-	UCLOGIC_RDESC_FRAME_BYTES(UCLOGIC_RDESC_FRAME_V2_ID, 12)
+const __u8 uclogic_rdesc_v2_frame_arr[] = {
+	UCLOGIC_RDESC_FRAME_BYTES(UCLOGIC_RDESC_V2_FRAME_ID, 12)
 };
-const size_t uclogic_rdesc_frame_v2_size =
-			sizeof(uclogic_rdesc_frame_v2_arr);
+const size_t uclogic_rdesc_v2_frame_size =
+			sizeof(uclogic_rdesc_v2_frame_arr);
 
 /* Fixed report descriptor for Ugee EX07 frame */
 const __u8 uclogic_rdesc_ugee_ex07_frame_arr[] = {
diff --git a/drivers/hid/hid-uclogic-rdesc.h b/drivers/hid/hid-uclogic-rdesc.h
index 40c6f02c6bab..d1ab1f346f22 100644
--- a/drivers/hid/hid-uclogic-rdesc.h
+++ b/drivers/hid/hid-uclogic-rdesc.h
@@ -104,32 +104,32 @@ enum uclogic_rdesc_pen_ph_id {
 	UCLOGIC_RDESC_PH_HEAD, UCLOGIC_RDESC_PEN_PH_ID_##_ID
 
 /* Report ID for v1 pen reports */
-#define UCLOGIC_RDESC_PEN_V1_ID	0x07
+#define UCLOGIC_RDESC_V1_PEN_ID	0x07
 
 /* Fixed report descriptor template for (tweaked) v1 pen reports */
-extern const __u8 uclogic_rdesc_pen_v1_template_arr[];
-extern const size_t uclogic_rdesc_pen_v1_template_size;
+extern const __u8 uclogic_rdesc_v1_pen_template_arr[];
+extern const size_t uclogic_rdesc_v1_pen_template_size;
 
 /* Report ID for v2 pen reports */
-#define UCLOGIC_RDESC_PEN_V2_ID	0x08
+#define UCLOGIC_RDESC_V2_PEN_ID	0x08
 
 /* Fixed report descriptor template for (tweaked) v2 pen reports */
-extern const __u8 uclogic_rdesc_pen_v2_template_arr[];
-extern const size_t uclogic_rdesc_pen_v2_template_size;
+extern const __u8 uclogic_rdesc_v2_pen_template_arr[];
+extern const size_t uclogic_rdesc_v2_pen_template_size;
 
 /* Fixed report descriptor for (tweaked) v1 frame reports */
-extern const __u8 uclogic_rdesc_frame_v1_arr[];
-extern const size_t uclogic_rdesc_frame_v1_size;
+extern const __u8 uclogic_rdesc_v1_frame_arr[];
+extern const size_t uclogic_rdesc_v1_frame_size;
 
 /* Report ID for tweaked v1 frame reports */
-#define UCLOGIC_RDESC_FRAME_V1_ID 0xf7
+#define UCLOGIC_RDESC_V1_FRAME_ID 0xf7
 
 /* Fixed report descriptor for (tweaked) v2 frame reports */
-extern const __u8 uclogic_rdesc_frame_v2_arr[];
-extern const size_t uclogic_rdesc_frame_v2_size;
+extern const __u8 uclogic_rdesc_v2_frame_arr[];
+extern const size_t uclogic_rdesc_v2_frame_size;
 
 /* Report ID for tweaked v2 frame reports */
-#define UCLOGIC_RDESC_FRAME_V2_ID 0xf7
+#define UCLOGIC_RDESC_V2_FRAME_ID 0xf7
 
 /* Fixed report descriptor for Ugee EX07 frame */
 extern const __u8 uclogic_rdesc_ugee_ex07_frame_arr[];
-- 
2.25.1

