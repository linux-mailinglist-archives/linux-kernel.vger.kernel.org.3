Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E30254F97F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382878AbiFQOrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382881AbiFQOrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:47:20 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3213F562E3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:47:19 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id f8so4063263plo.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QwOgz8AXr1w6XRcaYrmoN403wvhJobDQeRFmfFEMgXc=;
        b=EUg+zaz0qog+WnK03DWiqIcLDr6sFTqUalTjRcdJWbpX2BdrkjIRH8EPzaBkSR8k5r
         a7hmBQLvRTuUoqaJTtfnyJg1HrTXtOnY1yfv7KRzwmoW2QKe+S/WsbVlZM5gD91Ewe6M
         aq6EtVETYvSz1+VBENixLUSxBKEsfCIckoxCGAFp//FxKv7O8K5R2m7cZ3LagY6Jl+TQ
         kixEjp6kxyy4+ARFYmOQ6YD7OfWJJW+BsJtZoHVQU6fYFj8OADBIW8XsruKURgd4vUH4
         +H3kkYkWIRuFh8p8CHMZOd9RAQru2AXF6r1VCzL5gdBaZtXxv7KZk4R90wznE4KZ/JCZ
         Zu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QwOgz8AXr1w6XRcaYrmoN403wvhJobDQeRFmfFEMgXc=;
        b=Cfk/yCV7sPt5hBnyc6sDQJR3fJnXC5lAZa9Lwhnmm5YhPWeGLoq4XbcdZ87WrwBQqe
         h0wFXdRko4JEV57YIhk80W2FcdXliIAs1jqtOXm6PLsHO9NFa4cUpcbhM6QNtCObq26r
         PU7zeaTisR3U+Mk+eEkqqsn9OR617BPq3t8RBfIC3/JW6P/jLymNdLDpcQFLg3235oaa
         znrlFSYv/a6iM0iB4gZ/MOEbe7EO2A5gh3j8ezEWicoQsw+t78PS8QEoeQ9BJJOWSQV9
         tTcdfYcS9MPYi5baVMxrXUpeCrbB6nOq+f9r4vFOHDtVwMO7X6gsNctecbjcOnZLtwkM
         pAsA==
X-Gm-Message-State: AJIora8F6xoS1GrGNLUQ3yZVTrCj9TXsx7iPr2gbqWZjfcyun9qpKXsX
        16yIIxdeKQTZW5ydKMnrU3gadBaJb2OYlQ==
X-Google-Smtp-Source: AGRyM1td4CTWQLndv9VsVSchQflWEfAy58fLNiXtGGAGLnHYiTLkVUW2Plw9zVJjgGI7pvB+B0MU9g==
X-Received: by 2002:a17:902:a50a:b0:162:3488:27c4 with SMTP id s10-20020a170902a50a00b00162348827c4mr9591097plq.109.1655477238736;
        Fri, 17 Jun 2022 07:47:18 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id o12-20020a63a80c000000b003db822e2170sm3832453pgf.23.2022.06.17.07.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 07:47:18 -0700 (PDT)
From:   Zhang Boyang <zhangboyang.id@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Ivan Djelic <ivan.djelic@parrot.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [PATCH v2 3/5] rslib: Replace hard-coded 1 with alpha_to[0]
Date:   Fri, 17 Jun 2022 22:46:22 +0800
Message-Id: <20220617144624.158973-4-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220617144624.158973-1-zhangboyang.id@gmail.com>
References: <20220617144624.158973-1-zhangboyang.id@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the rslib allows customizing the finite field by the `gffunc'
parameter of init_rs_non_canonical(). However, there are several places
in rslib use hard-coded 1 instead of alpha_to[0], leading to errors if
gffunc(0) != 1. This patch fixes the problem. One of such `gffunc' might
be gffunc'(x) = swab16(gffunc(swab16(x))), as gffunc'(0) = swab16(1).
This special gffunc'(x) is useful when implementing RS coder for
16 bit foreign-endian symbols.

Signed-off-by: Zhang Boyang <zhangboyang.id@gmail.com>
---
 lib/reed_solomon/decode_rs.c    | 4 ++--
 lib/reed_solomon/reed_solomon.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/reed_solomon/decode_rs.c b/lib/reed_solomon/decode_rs.c
index 805de84ae83d..6c1d53d1b702 100644
--- a/lib/reed_solomon/decode_rs.c
+++ b/lib/reed_solomon/decode_rs.c
@@ -104,7 +104,7 @@
 
  decode:
 	memset(&lambda[1], 0, nroots * sizeof(lambda[0]));
-	lambda[0] = 1;
+	lambda[0] = alpha_to[0];
 
 	if (no_eras > 0) {
 		/* Init lambda to be the erasure locator polynomial */
@@ -198,7 +198,7 @@
 	memcpy(&reg[1], &lambda[1], nroots * sizeof(reg[0]));
 	count = 0;		/* Number of roots of lambda(x) */
 	for (i = 1, k = iprim - 1; i <= nn; i++, k = rs_modnn(rs, k + iprim)) {
-		q = 1;		/* lambda[0] is always 0 */
+		q = alpha_to[0];	/* lambda[0] is always 0 */
 		for (j = deg_lambda; j > 0; j--) {
 			if (reg[j] != nn) {
 				reg[j] = rs_modnn(rs, reg[j] + j);
diff --git a/lib/reed_solomon/reed_solomon.c b/lib/reed_solomon/reed_solomon.c
index 9415899bf27c..da46026a60b8 100644
--- a/lib/reed_solomon/reed_solomon.c
+++ b/lib/reed_solomon/reed_solomon.c
@@ -131,9 +131,9 @@ static struct rs_codec *codec_init(int symsize, int gfpoly, int (*gffunc)(int),
 	rs->iprim = iprim / prim;
 
 	/* Form RS code generator polynomial from its roots */
-	rs->genpoly[0] = 1;
+	rs->genpoly[0] = rs->alpha_to[0];
 	for (i = 0, root = fcr * prim; i < nroots; i++, root += prim) {
-		rs->genpoly[i + 1] = 1;
+		rs->genpoly[i + 1] = rs->alpha_to[0];
 		/* Multiply rs->genpoly[] by  @**(root + x) */
 		for (j = i; j > 0; j--) {
 			if (rs->genpoly[j] != 0) {
-- 
2.30.2

