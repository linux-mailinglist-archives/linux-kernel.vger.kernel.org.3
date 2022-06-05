Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212CA53DAC2
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 09:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244546AbiFEHjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 03:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiFEHja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 03:39:30 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363B4326DD
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 00:39:28 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id h1so9873451plf.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 00:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NnfGFE9rpnGX+9bTrl6RV6r/wa/k5nkv7KOySK6aGIY=;
        b=JKoofcQhkLQxXMTyNH7LnNlZ03La1DQIiiLKLddgZ7SQH9+inM5d/iZT4Svvx3GKZC
         cUWkSAzEcymrKBCZHW/7v6GETE57SbmMXy1JwEu3F+icwZXVcGQxZ0bjxXfR9uTwWci5
         LPoqiE6fuPq8T4xK446YEfg590h99s7N5OiBHZjRJ1+PqkRh5EroWs9z1t3ot2JfKwbu
         H7MCVi98JleKoqjuhH5nmFguBSDjDTsq90G0EoLaPPksK8jPH87H2Z6vPl7NQzvrYOtl
         kyKDPMjPcS6+7EWGiWyPsbgxwYTPMV7ytBgi3VlrikGXUPlxkORFzd5eWg5+KeEucnn2
         puew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NnfGFE9rpnGX+9bTrl6RV6r/wa/k5nkv7KOySK6aGIY=;
        b=5xbFlNoHrXHNUIklhpcqGt8O0I1WFCZL2pDXoFABpuopY78+QiyxdZasy/JiuJv60H
         tpNVnZg2LNpTmmFJ6D4dPB1TBontdgMiAz3MS4x0kS4JEQVe7YirDT3JgRkNcxCcRrrW
         av8lwVBlJxgqdwVEEzFZ8fN3zxHJXU0c8g64PUENVxK078JCtlmQld0McHTNgdvxVeW6
         I3fIsLeSWx5qA1dEaYBo/TZibancJTy8EduGF3MiycOqeETJtEv2oK/9c8xDOtYCFxwr
         2m+izh/jueog3YAlALk4JKMOx07E8BDPc1f+w0XthlkMaeESoHmIVgiOqkyWFRsoU4lw
         ffUQ==
X-Gm-Message-State: AOAM532LSFyo+/U5PBMiNrgMgp2TpEvAp6T5/ZKnKutnlc4QfZ8qz9py
        BtOyWzOiUNX8E9hy60jMQlIplGYuRqoaGA==
X-Google-Smtp-Source: ABdhPJyT+L9tdcS22hufoq2u0cIkZxHnW6s2MCMp+X+hB9zKAybbyqX/cSk/Kt/5qfCTw2EGpgIGIA==
X-Received: by 2002:a17:90b:4b48:b0:1e8:7df8:1e25 with SMTP id mi8-20020a17090b4b4800b001e87df81e25mr49159pjb.186.1654414767585;
        Sun, 05 Jun 2022 00:39:27 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id v9-20020a17090a0e0900b001e2ebcce5d5sm7787367pje.37.2022.06.05.00.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 00:39:27 -0700 (PDT)
From:   Zhang Boyang <zhangboyang.id@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ferdinand.blomqvist@gmail.com, tglx@linutronix.de,
        Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [RFC PATCH] rslib: Replace hard-coded 1 with alpha_to[0]
Date:   Sun,  5 Jun 2022 15:38:57 +0800
Message-Id: <20220605073857.126497-1-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
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

Comments for RFC:

Hello,

I found problems in rslib when I specify `gffunc' as myfunc(x) =
bswap_16(gffunc(x)). This patch fixes these problems, please refer to
commit message below for details. Since I'm not experienced with GF
fields, so I would like to invite people to review my patch.

If not using init_rs_non_canonical(), the change is trivial because
alpha_to[0] is always 1. So this patch should introduce no regression
and safe to merge.

The modifications to `test_rslib.c' are not intended to commit, just for
showing the idea and a small self-test. It will be removed if this patch
is going to be merged.

The reason I want to use this `gffunc' is because I'm going to implement
Reed-Solomon for BTRFS filesystem. As on-disk-format is little endian,
the code of file system must deal with little-endian reed solomon
symbols on big-endian machines. One possible approach is to do bswap_16
on every symbol when encoding/decoding, which is not very good. Another
approach is to bswap_16 the GF field, so no additional bswap_16 when
encoding/decoding is required. This will expose the above problem
because gffunc(0) is 0x0100 instead of 0x0001 in that field.

Thanks!

Best Regards,
Zhang Boyang

===

Currently the rslib allows customizing the finite field by the `gffunc'
parameter of init_rs_non_canonical(). However, there are several places
in rslib use hard-coded 1 instead of alpha_to[0], leading errors if
gffunc(0) != 1. This patch fixes the problem. One of such `gffunc` might
be gffunc'(x) = bswap_16(gffunc(x)). This is useful to implement
foreign-endian RS coder for 16 bit symbols.

Signed-off-by: Zhang Boyang <zhangboyang.id@gmail.com>
---
 lib/reed_solomon/decode_rs.c    |  4 ++--
 lib/reed_solomon/reed_solomon.c |  4 ++--
 lib/reed_solomon/test_rslib.c   | 23 ++++++++++++++++++++---
 3 files changed, 24 insertions(+), 7 deletions(-)

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
diff --git a/lib/reed_solomon/test_rslib.c b/lib/reed_solomon/test_rslib.c
index d9d1c33aebda..1c7fefcc89f2 100644
--- a/lib/reed_solomon/test_rslib.c
+++ b/lib/reed_solomon/test_rslib.c
@@ -42,9 +42,11 @@ struct etab {
 	int	ntrials;
 };
 
+#define RS16_GFPOLY 0x1002d
+
 /* List of codes to test */
 static struct etab Tab[] = {
-	{2,	0x7,	1,	1,	1,	100000	},
+	/*{2,	0x7,	1,	1,	1,	100000	},
 	{3,	0xb,	1,	1,	2,	100000	},
 	{3,	0xb,	1,	1,	3,	100000	},
 	{3,	0xb,	2,	1,	4,	100000	},
@@ -54,7 +56,8 @@ static struct etab Tab[] = {
 	{7,	0x89,	1,	1,	14,	500	},
 	{8,	0x11d,	1,	1,	30,	100	},
 	{8,	0x187,	112,	11,	32,	100	},
-	{9,	0x211,	1,	1,	33,	80	},
+	{9,	0x211,	1,	1,	33,	80	},*/
+	{16,RS16_GFPOLY,1,	1,	33,	100	},
 	{0, 0, 0, 0, 0, 0},
 };
 
@@ -439,6 +442,19 @@ static int exercise_rs_bc(struct rs_control *rs, struct wspace *ws,
 	return stat.noncw;
 }
 
+
+static int gf_mul(int x)
+{
+	//printk("x=%04x\n", x);
+	x = be16_to_cpu(x);
+	if (x == 0)
+		return cpu_to_be16(1);
+	x <<= 1;
+	if (x & 0x10000)
+		x ^= RS16_GFPOLY;
+	x &= 0xFFFF;
+	return cpu_to_be16(x);
+}
 static int run_exercise(struct etab *e)
 {
 	int nn = (1 << e->symsize) - 1;
@@ -450,7 +466,8 @@ static int run_exercise(struct etab *e)
 	struct wspace *ws;
 	int i;
 
-	rsc = init_rs(e->symsize, e->genpoly, e->fcs, e->prim, e->nroots);
+	//rsc = init_rs(e->symsize, e->genpoly, e->fcs, e->prim, e->nroots);
+	rsc = init_rs_non_canonical(e->symsize, gf_mul, e->fcs, e->prim, e->nroots);
 	if (!rsc)
 		return retval;
 
-- 
2.30.2

