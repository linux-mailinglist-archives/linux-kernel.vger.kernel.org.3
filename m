Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1696E528CA6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344591AbiEPSNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343646AbiEPSNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:13:48 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DE03D4A9;
        Mon, 16 May 2022 11:13:46 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v191-20020a1cacc8000000b00397001398c0so42005wme.5;
        Mon, 16 May 2022 11:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3PjQuKMkTY1kyPsdXkRWcy11RqWiSJraBoDtsiZIFcs=;
        b=BFr3UDVLs/jpoMqqMUc27+GdLU35A6OwEzssE5AbHTTZuSE8bmOjFVDMdRCzpWHNXP
         Vx8QkGMkG4RvkBQm0W85234VOele7Y0ADkCfxG5rHBEzLPetfaiavIBYQD2nEBs03Pe0
         9isd05eMQ9ERqlo2bNgj53VBknnYFzQOOTdsrl7KkMkg0Jl0NljwHgI0H5JBMwA3p4NW
         Ky7F2hdOtYex0tfQZ2XFUVVXCZSu2L/w6N7z0YwdcIBPVUUZ55+g4GgpjO0hBMCsgZZu
         AE9sbPaCtsimKUQOrAxVo+i7d9MTbfe/WDn8rlxIIWudrnTWypk/7/m2P3Fwx6EVFigS
         kvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3PjQuKMkTY1kyPsdXkRWcy11RqWiSJraBoDtsiZIFcs=;
        b=YV+hfZdn20pd1ZP2Z80xLzWz10O2We8GNtvG9AUnBob7sTOz4GXW34sSb0WAoM/Pk1
         HH9Grn9wg24txdWit1HSGa+QfZOp+U01MGHIdYXJKP3hG29argueWOucwTRRQDTHc+6e
         1hNCAmOxTU4osr2ZM6nyHq64wFp+viB7qjV0rQQ2MlmOmXdcmo5iD9wLStOsa/Ufrybx
         b0VMNpH6qvty7UJotYFf6dVAdWtU3jkd1qyl1rgUV/GuCmcnKjHI8hpBoRzV5FM8TK/A
         5SEkn8jnXgH5kust7j9331wxpPJtTxYs/2yCgYCj801e/TlthieRrL9MGAfDvvNfms0Z
         HiRQ==
X-Gm-Message-State: AOAM5320NxxU18f54Mwi/Kld2hJwXyKH9PYTRFTsFm5aA5vdWo94uFKK
        ByepZhm5PvRsb6lN73fivkI=
X-Google-Smtp-Source: ABdhPJzn3+reGAyef4lagNn/zaWpws9w8xwvWfBKTH8ovuGyApy/Silnzbt8GW5h9AcBbCwUGfpTTw==
X-Received: by 2002:a05:600c:35ce:b0:394:8621:a1e7 with SMTP id r14-20020a05600c35ce00b003948621a1e7mr17952141wmq.127.1652724825304;
        Mon, 16 May 2022 11:13:45 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id o15-20020a05600002cf00b0020d0c9c95d3sm3276382wry.77.2022.05.16.11.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 11:13:44 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanberzl@gmail.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.19/uclogic 1/4] HID: uclogic: Make template placeholder IDs generic
Date:   Mon, 16 May 2022 20:13:20 +0200
Message-Id: <20220516181323.59554-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516181323.59554-1-jose.exposito89@gmail.com>
References: <20220516181323.59554-1-jose.exposito89@gmail.com>
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

Up until now, the report descriptor template parameter IDs were only
used with pen report descriptors and they were named accordingly.

Rename the enum and the total number of IDs to make them interface
agnostic.

Refactor, no functional changes.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params.c |  4 ++--
 drivers/hid/hid-uclogic-rdesc.c  | 14 +++++++-------
 drivers/hid/hid-uclogic-rdesc.h  | 10 +++++-----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index db838f16282d..b43142f98a8b 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -234,7 +234,7 @@ static int uclogic_params_pen_init_v1(struct uclogic_params_pen *pen,
 	const int len = 12;
 	s32 resolution;
 	/* Pen report descriptor template parameters */
-	s32 desc_params[UCLOGIC_RDESC_PEN_PH_ID_NUM];
+	s32 desc_params[UCLOGIC_RDESC_PH_ID_NUM];
 	__u8 *desc_ptr = NULL;
 
 	/* Check arguments */
@@ -379,7 +379,7 @@ static int uclogic_params_pen_init_v2(struct uclogic_params_pen *pen,
 	size_t i;
 	s32 resolution;
 	/* Pen report descriptor template parameters */
-	s32 desc_params[UCLOGIC_RDESC_PEN_PH_ID_NUM];
+	s32 desc_params[UCLOGIC_RDESC_PH_ID_NUM];
 	__u8 *desc_ptr = NULL;
 
 	/* Check arguments */
diff --git a/drivers/hid/hid-uclogic-rdesc.c b/drivers/hid/hid-uclogic-rdesc.c
index 13f9ce73f1b1..7126fba80968 100644
--- a/drivers/hid/hid-uclogic-rdesc.c
+++ b/drivers/hid/hid-uclogic-rdesc.c
@@ -979,7 +979,7 @@ const size_t uclogic_rdesc_xppen_deco01_frame_size =
  * uclogic_rdesc_template_apply() - apply report descriptor parameters to a
  * report descriptor template, creating a report descriptor. Copies the
  * template over to the new report descriptor and replaces every occurrence of
- * UCLOGIC_RDESC_PH_HEAD, followed by an index byte, with the value from the
+ * UCLOGIC_RDESC_PEN_PH_HEAD, followed by an index byte, with the value from the
  * parameter list at that index.
  *
  * @template_ptr:	Pointer to the template buffer.
@@ -996,7 +996,7 @@ __u8 *uclogic_rdesc_template_apply(const __u8 *template_ptr,
 				   const s32 *param_list,
 				   size_t param_num)
 {
-	static const __u8 head[] = {UCLOGIC_RDESC_PH_HEAD};
+	static const __u8 pen_head[] = {UCLOGIC_RDESC_PEN_PH_HEAD};
 	__u8 *rdesc_ptr;
 	__u8 *p;
 	s32 v;
@@ -1005,12 +1005,12 @@ __u8 *uclogic_rdesc_template_apply(const __u8 *template_ptr,
 	if (rdesc_ptr == NULL)
 		return NULL;
 
-	for (p = rdesc_ptr; p + sizeof(head) < rdesc_ptr + template_size;) {
-		if (memcmp(p, head, sizeof(head)) == 0 &&
-		    p[sizeof(head)] < param_num) {
-			v = param_list[p[sizeof(head)]];
+	for (p = rdesc_ptr; p + sizeof(pen_head) < rdesc_ptr + template_size;) {
+		if (memcmp(p, pen_head, sizeof(pen_head)) == 0 &&
+		    p[sizeof(pen_head)] < param_num) {
+			v = param_list[p[sizeof(pen_head)]];
 			put_unaligned(cpu_to_le32(v), (s32 *)p);
-			p += sizeof(head) + 1;
+			p += sizeof(pen_head) + 1;
 		} else {
 			p++;
 		}
diff --git a/drivers/hid/hid-uclogic-rdesc.h b/drivers/hid/hid-uclogic-rdesc.h
index 0c6e95e8bde7..9d37090c39d1 100644
--- a/drivers/hid/hid-uclogic-rdesc.h
+++ b/drivers/hid/hid-uclogic-rdesc.h
@@ -81,7 +81,7 @@ extern __u8 uclogic_rdesc_twha60_fixed1_arr[];
 extern const size_t uclogic_rdesc_twha60_fixed1_size;
 
 /* Report descriptor template placeholder head */
-#define UCLOGIC_RDESC_PH_HEAD	0xFE, 0xED, 0x1D
+#define UCLOGIC_RDESC_PEN_PH_HEAD	0xFE, 0xED, 0x1D
 
 /* Apply report descriptor parameters to a report descriptor template */
 extern __u8 *uclogic_rdesc_template_apply(const __u8 *template_ptr,
@@ -89,19 +89,19 @@ extern __u8 *uclogic_rdesc_template_apply(const __u8 *template_ptr,
 					  const s32 *param_list,
 					  size_t param_num);
 
-/* Pen report descriptor template placeholder IDs */
-enum uclogic_rdesc_pen_ph_id {
+/* Report descriptor template placeholder IDs */
+enum uclogic_rdesc_ph_id {
 	UCLOGIC_RDESC_PEN_PH_ID_X_LM,
 	UCLOGIC_RDESC_PEN_PH_ID_X_PM,
 	UCLOGIC_RDESC_PEN_PH_ID_Y_LM,
 	UCLOGIC_RDESC_PEN_PH_ID_Y_PM,
 	UCLOGIC_RDESC_PEN_PH_ID_PRESSURE_LM,
-	UCLOGIC_RDESC_PEN_PH_ID_NUM
+	UCLOGIC_RDESC_PH_ID_NUM
 };
 
 /* Report descriptor pen template placeholder */
 #define UCLOGIC_RDESC_PEN_PH(_ID) \
-	UCLOGIC_RDESC_PH_HEAD, UCLOGIC_RDESC_PEN_PH_ID_##_ID
+	UCLOGIC_RDESC_PEN_PH_HEAD, UCLOGIC_RDESC_PEN_PH_ID_##_ID
 
 /* Report ID for v1 pen reports */
 #define UCLOGIC_RDESC_V1_PEN_ID	0x07
-- 
2.25.1

