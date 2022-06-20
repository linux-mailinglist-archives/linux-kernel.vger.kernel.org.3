Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8A4551033
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 08:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238653AbiFTGUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 02:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238629AbiFTGUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:20:46 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C07DEE4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 23:20:45 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id p3-20020a17090a428300b001ec865eb4a2so4689852pjg.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 23:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4akhw7wybTZyWH6tXqtxZK6m2uwvnVK6i/fg5yqCKis=;
        b=nZjK6Z3dkiCL8RDUtx45P7cytoOgg04WwGlnL7/ir4zePbpXaCQpq+CK5hJwgN5wsV
         H86gTnL7jYbIprIKbFpfkSuGuabiSwBnfZSTY+MxPsxwTmQy8OYMEkJRfsBZ+wns4IiJ
         7S2/rj40dmB12CIUx7TpQBylEsIouq+vIv5rp6z83/fJtrJqEFko2MnCAt81CpdU6MYd
         8lmchfVfx/YkhLTrORGIY/GZ/4kofeaeKYsIFAsyzEIjcZlSGAkjGCxO2h0azB7tbuoV
         IYaznzG9OnevYFsYf90PlBe7XjPcpqUFkYjoVBUo4d4NkkgjoYpG3uJK8qIJG/dAmWsS
         Fs6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4akhw7wybTZyWH6tXqtxZK6m2uwvnVK6i/fg5yqCKis=;
        b=L7DkZSdab+HTWROFOUOWgpV472x4AufiHuTvtJC6yASYCQBnOonEQlPHnehOtOd2XJ
         5OoWjRa97bGn1f3fODKt9NHDuAZA3zMMmbqCYxbQsQ4B0BhLjCPvRtCLvKl0O5ofAIOV
         GuWayAVvIRXVKTIj5qeBhh7oz6w+rGkZUriLRo3MzmITB0fh0xEyp3h0AbJJQiYpdB3e
         y8JdmuKbm74fyJ9ZmzLQlsajZFrQptQ17kPYqVlzg2BfLDE4l/VaIRq7OGNxzcs4afyJ
         dx/7cS+kgrTXgswibkA0nkHr8unS1dEkZuY/cMOqhPYj1Ckp0LWfy4u31YQ/syTqxiO7
         oisg==
X-Gm-Message-State: AJIora9MZ3zl/rkUHNbVSuPQHXgeDRWZ+nIS09v9kmTKgBCFAlfGUR6T
        ZBMsZRoKcgBEaH5qJgwPNAkPVDi/Ch4=
X-Google-Smtp-Source: AGRyM1tj7SdBE3ZmIfnhv7ZSr2d6GiJGZnQ80c2HRLDwcKlMZv9QI1bF5d4NvhEVYt6Cw4xtfgu3Ww==
X-Received: by 2002:a17:90b:1a86:b0:1e8:2b80:5e07 with SMTP id ng6-20020a17090b1a8600b001e82b805e07mr25146959pjb.31.1655706044613;
        Sun, 19 Jun 2022 23:20:44 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id p13-20020a63950d000000b003fd9e4911f9sm8010469pgd.31.2022.06.19.23.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 23:20:44 -0700 (PDT)
From:   Zhang Boyang <zhangboyang.id@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [PATCH v3 2/6] rslib: Replace hard-coded 1 with alpha_to[0]
Date:   Mon, 20 Jun 2022 14:20:11 +0800
Message-Id: <20220620062015.15612-3-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220620062015.15612-1-zhangboyang.id@gmail.com>
References: <20220620062015.15612-1-zhangboyang.id@gmail.com>
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
index bbc01bad3053..bb4f44c8edba 100644
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

