Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F2651EEC6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 18:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbiEHQGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 12:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbiEHQGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 12:06:00 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EEBE0AB;
        Sun,  8 May 2022 09:02:09 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso9536874wma.0;
        Sun, 08 May 2022 09:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iQ5H4sLozkU3O3cWJmRiI8k+gjfx6qXpAt/d+asdCMs=;
        b=YPgN+yyyvt1aDQ1rBRo8bbtTkrLPifdqNe0K7GrPwL7SJCGAvRrZj2M4Ho6QBIX0rV
         3gDqBoAozDvenRULyVyHgf6ZtM1yWyO3fnY+57Xv/JL+Y55xfDkFHmVOSt2sWh4vLj6Y
         9NL6XukvGtJj6QrL2uPVkqY5MeO8MxHuneZCxtcWSHMgJPDo3kgzagomNqiqcoh3dtkB
         LjgzX0zv2ry0f+1uubt/NLyJGr54Mowc8EayRsKHhkY3U5zOjiw3h/o06lPMU0jGmZHs
         uOaT0v4iocZYJpKB2dmkw2aJX8OAnr7r12SY2ZCEdgrQI4uJvgUEOWyFdJsZ87ynnLyf
         0QXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iQ5H4sLozkU3O3cWJmRiI8k+gjfx6qXpAt/d+asdCMs=;
        b=oQEObEHQgz+cZOObmH9xE6CO1UhdYLxHNMm1BaIznqd4042RWNogySsWd2HDd6OQjJ
         mDY3XTYmww8iTdjYjNMSgEzZoFKaS8h1JpviId8zTdxPSNms3FAp1N/ClI55Rdvanp/G
         m3H41Uc9cWhB9B63KrsiYbrwr0mLrYn5svVuTFGPrDQlYsWuihyZ14aK5CiGY+iUlKss
         +4r1XRLRJ8TpIodgM5K/ABJ28QpQ7GowP9o4KcyFZlq6IBbuoAS2tw/xttOiidRK0Wv1
         PtXBp9e9rchBBdBReFtnju2IQ6YasnFHUoC5SmQN5k3l0tHlzkUDIwZ3TfXaw6PL+ZPR
         JSxQ==
X-Gm-Message-State: AOAM531pSqMTrPV1S71lF5evi6iKmKKtsGbsspizLa9W3ssHtQax8+Jm
        l7SFaHbNmKQvrapyewPSGCA=
X-Google-Smtp-Source: ABdhPJzuqn9ii1MAMBpKEFEj/vlmMQ3yDK7Ft6DM+GF5L697J/QP1LKolxvbUMq2wPDl3m802VddPg==
X-Received: by 2002:a05:600c:3490:b0:394:5616:ac78 with SMTP id a16-20020a05600c349000b003945616ac78mr12426181wmq.80.1652025727841;
        Sun, 08 May 2022 09:02:07 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id b15-20020a7bc24f000000b003942a244ecfsm10101925wmj.20.2022.05.08.09.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 09:02:07 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanberzl@gmail.com, albertofanjul@gmail.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.19/uclogic 2/7] HID: uclogic: Return raw parameters from v2 pen init
Date:   Sun,  8 May 2022 18:01:41 +0200
Message-Id: <20220508160146.13004-3-jose.exposito89@gmail.com>
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

Return the raw parameters buffer from uclogic_params_pen_init_v2(), if
requested, as a way to identify the tablet.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params.c | 92 ++++++++++++++++++++------------
 1 file changed, 58 insertions(+), 34 deletions(-)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 1d9168cc7dc0..91379d7cd33e 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -338,28 +338,45 @@ static s32 uclogic_params_get_le24(const void *p)
  * uclogic_params_pen_init_v2() - initialize tablet interface pen
  * input and retrieve its parameters from the device, using v2 protocol.
  *
- * @pen:	Pointer to the pen parameters to initialize (to be
- *		cleaned up with uclogic_params_pen_cleanup()). Not modified in
- *		case of error, or if parameters are not found. Cannot be NULL.
- * @pfound:	Location for a flag which is set to true if the parameters
- *		were found, and to false if not (e.g. device was
- *		incompatible). Not modified in case of error. Cannot be NULL.
- * @hdev:	The HID device of the tablet interface to initialize and get
- *		parameters from. Cannot be NULL.
+ * @pen:		Pointer to the pen parameters to initialize (to be
+ *			cleaned up with uclogic_params_pen_cleanup()). Not
+ *			modified in case of error, or if parameters are not
+ *			found. Cannot be NULL.
+ * @pfound:		Location for a flag which is set to true if the
+ *			parameters were found, and to false if not (e.g.
+ *			device was incompatible). Not modified in case of
+ *			error. Cannot be NULL.
+ * @pparams_ptr:	Location for a kmalloc'ed pointer to the retrieved raw
+ *			parameters, which could be used to identify the tablet
+ *			to some extent. Should be freed with kfree after use.
+ *			NULL, if not needed. Not modified in case of error.
+ *			Only set if *pfound is set to true.
+ * @pparams_len:	Location for the length of the retrieved raw
+ *			parameters. NULL, if not needed. Not modified in case
+ *			of error. Only set if *pfound is set to true.
+ * @hdev:		The HID device of the tablet interface to initialize
+ *			and get parameters from. Cannot be NULL.
  *
  * Returns:
  *	Zero, if successful. A negative errno code on error.
  */
 static int uclogic_params_pen_init_v2(struct uclogic_params_pen *pen,
 					bool *pfound,
+					__u8 **pparams_ptr,
+					size_t *pparams_len,
 					struct hid_device *hdev)
 {
 	int rc;
 	bool found = false;
-	/* Buffer for (part of) the string descriptor */
+	/* Buffer for (part of) the parameter string descriptor */
 	__u8 *buf = NULL;
-	/* Descriptor length required */
-	const int len = 18;
+	/* Parameter string descriptor required length */
+	const int params_len_min = 18;
+	/* Parameter string descriptor accepted length */
+	const int params_len_max = 32;
+	/* Parameter string descriptor received length */
+	int params_len;
+	size_t i;
 	s32 resolution;
 	/* Pen report descriptor template parameters */
 	s32 desc_params[UCLOGIC_RDESC_PEN_PH_ID_NUM];
@@ -377,7 +394,7 @@ static int uclogic_params_pen_init_v2(struct uclogic_params_pen *pen,
 	 * the Windows driver traffic.
 	 * NOTE: This enables fully-functional tablet mode.
 	 */
-	rc = uclogic_params_get_str_desc(&buf, hdev, 200, len);
+	rc = uclogic_params_get_str_desc(&buf, hdev, 200, params_len_max);
 	if (rc == -EPIPE) {
 		hid_dbg(hdev,
 			"string descriptor with pen parameters not found, assuming not compatible\n");
@@ -385,27 +402,28 @@ static int uclogic_params_pen_init_v2(struct uclogic_params_pen *pen,
 	} else if (rc < 0) {
 		hid_err(hdev, "failed retrieving pen parameters: %d\n", rc);
 		goto cleanup;
-	} else if (rc != len) {
+	} else if (rc < params_len_min) {
 		hid_dbg(hdev,
-			"string descriptor with pen parameters has invalid length (got %d, expected %d), assuming not compatible\n",
-			rc, len);
+			"string descriptor with pen parameters is too short (got %d, expected at least %d), assuming not compatible\n",
+			rc, params_len_min);
+		goto finish;
+	}
+
+	params_len = rc;
+
+	/*
+	 * Check it's not just a catch-all UTF-16LE-encoded ASCII
+	 * string (such as the model name) some tablets put into all
+	 * unknown string descriptors.
+	 */
+	for (i = 2;
+	     i < params_len &&
+		(buf[i] >= 0x20 && buf[i] < 0x7f && buf[i + 1] == 0);
+	     i += 2);
+	if (i >= params_len) {
+		hid_dbg(hdev,
+			"string descriptor with pen parameters seems to contain only text, assuming not compatible\n");
 		goto finish;
-	} else {
-		size_t i;
-		/*
-		 * Check it's not just a catch-all UTF-16LE-encoded ASCII
-		 * string (such as the model name) some tablets put into all
-		 * unknown string descriptors.
-		 */
-		for (i = 2;
-		     i < len &&
-			(buf[i] >= 0x20 && buf[i] < 0x7f && buf[i + 1] == 0);
-		     i += 2);
-		if (i >= len) {
-			hid_dbg(hdev,
-				"string descriptor with pen parameters seems to contain only text, assuming not compatible\n");
-			goto finish;
-		}
 	}
 
 	/*
@@ -429,8 +447,6 @@ static int uclogic_params_pen_init_v2(struct uclogic_params_pen *pen,
 			desc_params[UCLOGIC_RDESC_PEN_PH_ID_Y_LM] * 1000 /
 			resolution;
 	}
-	kfree(buf);
-	buf = NULL;
 
 	/*
 	 * Generate pen report descriptor
@@ -456,6 +472,13 @@ static int uclogic_params_pen_init_v2(struct uclogic_params_pen *pen,
 	pen->fragmented_hires = true;
 	pen->tilt_y_flipped = true;
 	found = true;
+	if (pparams_ptr != NULL) {
+		*pparams_ptr = buf;
+		buf = NULL;
+	}
+	if (pparams_len != NULL)
+		*pparams_len = params_len;
+
 finish:
 	*pfound = found;
 	rc = 0;
@@ -828,7 +851,8 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 			"transition firmware detected, not probing pen v2 parameters\n");
 	} else {
 		/* Try to probe v2 pen parameters */
-		rc = uclogic_params_pen_init_v2(&p.pen, &found, hdev);
+		rc = uclogic_params_pen_init_v2(&p.pen, &found,
+						NULL, NULL, hdev);
 		if (rc != 0) {
 			hid_err(hdev,
 				"failed probing pen v2 parameters: %d\n", rc);
-- 
2.25.1

