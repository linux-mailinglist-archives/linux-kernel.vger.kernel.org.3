Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FA553E796
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbiFFKTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbiFFKTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:19:31 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A4111800D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 03:19:29 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j7so12447993pjn.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 03:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ilzd49u5Imb25kMo4f7TpcHavmNS8qqVbBDilPGPMKM=;
        b=OkmPT0gFGDuG2TtHSxv1ZOZYfGp7a/XIVferp9yIZviREDCsjiEWjA8Tft8RElF7GO
         jCI+CnIHGJD8tmaJsOS5DyuEXg+CheWXTIYvDpiTKcK6jKMntNPcWIGhps3q3oq0OKrV
         ufoVvQ6BhynBK1WdvsG2fJ1yQVCoJudg4dglVAB3nIg4ojx2NHlyNq9hAxu7cRRMf6dm
         R5ZbwW1zKLe5TMBdrrPmjECzG4vt0TOr2iqIdV1oA9WRQgRSeeBaOgV0FCPHIGOmQZ5y
         KtLFlVgRNX3bpl9XQUGm3FFxJb2U61rYNbBcvLj1HkfP131PEFa6WPwQthMpG98r1iF2
         fIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ilzd49u5Imb25kMo4f7TpcHavmNS8qqVbBDilPGPMKM=;
        b=UyP4EIH8VyfAafIeZYQLGjwFBhxj7zvomkqueGIDkPU22L52lyktUT0hDgTMdS+d6G
         uQdB9oDU1NlfDC1M9J5B7EYG49VS+9AxckgwiKQRp5KW4inqlBZBAStARdSOMXcz+HH8
         1z6lcfmXDAjaCPfnrEgMALvB4zltBvxhLK9IkehdXujc0XqQsXP6cB6oO80o0+0X+SA/
         H6/sjUcMLGJ/yoVflKPczpzMNDelFbvWK46beD7R2RlCTjiruRXmVoMmcMl2u+vhlos0
         iTFAT1lZULdtgEAkp8CSNI67P5gqR+2HJqqsWv/tjFVT5LAuH4FDWqitTOlRlURkaU+U
         mMtg==
X-Gm-Message-State: AOAM532dQg1th/NiUF+F3+D5iyc6BUE0K2Ad04tx7vFVMKW0IM2MlthH
        jQFXebW5860iEKO0tTmi2XToL6nCQd1ftA==
X-Google-Smtp-Source: ABdhPJxqbyrdN4zJbJHMwU0ISizKFPTck6XMTtpRwPBbvJWfxvW/iI0BnIUK8OBE1toE/v+jqbqirg==
X-Received: by 2002:a17:90a:1911:b0:1df:b08a:e252 with SMTP id 17-20020a17090a191100b001dfb08ae252mr60685864pjg.215.1654510769344;
        Mon, 06 Jun 2022 03:19:29 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id o13-20020a170902d4cd00b0015e8d4eb2aesm10234887plg.248.2022.06.06.03.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 03:19:29 -0700 (PDT)
From:   Zhang Boyang <zhangboyang.id@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ferdinand.blomqvist@gmail.com, tglx@linutronix.de,
        Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [PATCH 2/2] rslib: Introduce init_rs16()
Date:   Mon,  6 Jun 2022 18:19:01 +0800
Message-Id: <20220606101901.83538-2-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220606101901.83538-1-zhangboyang.id@gmail.com>
References: <20220605073857.126497-1-zhangboyang.id@gmail.com>
 <20220606101901.83538-1-zhangboyang.id@gmail.com>
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

This patch introduces init_rs16(). This function creates a RS coder for
exactly 16 bit symbols and it provides a special parameter `bool gfswab'
which indicates whether to treat symbols as foreign endian. If `gfswab'
is true, the coder will act as if all reads/writes to symbols is
byte-swapped. This is useful, for example, when a big-endian machine
want to decode symbols generated on a little-endian machine.

Signed-off-by: Zhang Boyang <zhangboyang.id@gmail.com>
---
 include/linux/rslib.h           | 24 +++++++++++++++++
 lib/reed_solomon/reed_solomon.c | 48 ++++++++++++++++++++++++++++-----
 lib/reed_solomon/test_rslib.c   | 31 ++++++++++++---------
 3 files changed, 84 insertions(+), 19 deletions(-)

diff --git a/include/linux/rslib.h b/include/linux/rslib.h
index 238bb85243d3..bd38e1285997 100644
--- a/include/linux/rslib.h
+++ b/include/linux/rslib.h
@@ -28,6 +28,7 @@
  * @iprim:	prim-th root of 1, index form
  * @gfpoly:	The primitive generator polynominal
  * @gffunc:	Function to generate the field, if non-canonical representation
+ * @gfswab:	Treat symbols as foreign endian, may be true only if mm = 16
  * @users:	Users of this structure
  * @list:	List entry for the rs codec list
 */
@@ -43,6 +44,7 @@ struct rs_codec {
 	int		iprim;
 	int		gfpoly;
 	int		(*gffunc)(int);
+	bool		gfswab;
 	int		users;
 	struct list_head list;
 };
@@ -101,6 +103,28 @@ static inline struct rs_control *init_rs(int symsize, int gfpoly, int fcr,
 	return init_rs_gfp(symsize, gfpoly, fcr, prim, nroots, GFP_KERNEL);
 }
 
+struct rs_control *init_rs16_gfp(int gfpoly, bool gfswab, int fcr, int prim,
+				 int nroots, gfp_t gfp);
+
+/**
+ * init_rs16 - Allocate rs control struct for 16 bit symbols
+ *  @gfpoly:	the extended Galois field generator polynomial coefficients,
+ *		with the 0th coefficient in the low order bit. The polynomial
+ *		must be primitive;
+ *  @gfswab:	Treat symbols as foreign endian
+ *  @fcr:	the first consecutive root of the rs code generator polynomial
+ *		in index form
+ *  @prim:	primitive element to generate polynomial roots
+ *  @nroots:	RS code generator polynomial degree (number of roots)
+ *
+ * Allocations use GFP_KERNEL.
+ */
+static inline struct rs_control *init_rs16(int gfpoly, bool gfswab, int fcr,
+					   int prim, int nroots)
+{
+	return init_rs16_gfp(gfpoly, gfswab, fcr, prim, nroots, GFP_KERNEL);
+}
+
 struct rs_control *init_rs_non_canonical(int symsize, int (*func)(int),
 					 int fcr, int prim, int nroots);
 
diff --git a/lib/reed_solomon/reed_solomon.c b/lib/reed_solomon/reed_solomon.c
index bb4f44c8edba..8f25b539e3a5 100644
--- a/lib/reed_solomon/reed_solomon.c
+++ b/lib/reed_solomon/reed_solomon.c
@@ -56,9 +56,10 @@ static DEFINE_MUTEX(rslistlock);
 
 /**
  * codec_init - Initialize a Reed-Solomon codec
- * @symsize:	symbol size, bits (1-8)
+ * @symsize:	the symbol size (number of bits)
  * @gfpoly:	Field generator polynomial coefficients
  * @gffunc:	Field generator function
+ * @gfswab:	Treat symbols as foreign endian, may be true only if symsize=16
  * @fcr:	first root of RS code generator polynomial, index form
  * @prim:	primitive element to generate polynomial roots
  * @nroots:	RS code generator polynomial degree (number of roots)
@@ -67,7 +68,8 @@ static DEFINE_MUTEX(rslistlock);
  * Allocate a codec structure and the polynom arrays for faster
  * en/decoding. Fill the arrays according to the given parameters.
  */
-static struct rs_codec *codec_init(int symsize, int gfpoly, int (*gffunc)(int),
+static struct rs_codec *codec_init(int symsize,
+				   int gfpoly, int (*gffunc)(int), bool gfswab,
 				   int fcr, int prim, int nroots, gfp_t gfp)
 {
 	int i, j, sr, root, iprim;
@@ -86,6 +88,7 @@ static struct rs_codec *codec_init(int symsize, int gfpoly, int (*gffunc)(int),
 	rs->nroots = nroots;
 	rs->gfpoly = gfpoly;
 	rs->gffunc = gffunc;
+	rs->gfswab = gfswab;
 
 	/* Allocate the arrays */
 	rs->alpha_to = kmalloc_array(rs->nn + 1, sizeof(uint16_t), gfp);
@@ -105,13 +108,16 @@ static struct rs_codec *codec_init(int symsize, int gfpoly, int (*gffunc)(int),
 	rs->alpha_to[rs->nn] = 0;	/* alpha**-inf = 0 */
 	if (gfpoly) {
 		sr = 1;
+		sr = gfswab ? swab16(sr) : sr;
 		for (i = 0; i < rs->nn; i++) {
 			rs->index_of[sr] = i;
 			rs->alpha_to[i] = sr;
+			sr = gfswab ? swab16(sr) : sr;
 			sr <<= 1;
 			if (sr & (1 << symsize))
 				sr ^= gfpoly;
 			sr &= rs->nn;
+			sr = gfswab ? swab16(sr) : sr;
 		}
 	} else {
 		sr = gffunc(0);
@@ -204,6 +210,7 @@ EXPORT_SYMBOL_GPL(free_rs);
  *  @gffunc:	pointer to function to generate the next field element,
  *		or the multiplicative identity element if given 0.  Used
  *		instead of gfpoly if gfpoly is 0
+ *  @gfswab:	Treat symbols as foreign endian, may be true only if symsize=16
  *  @fcr:	the first consecutive root of the rs code generator polynomial
  *		in index form
  *  @prim:	primitive element to generate polynomial roots
@@ -211,8 +218,9 @@ EXPORT_SYMBOL_GPL(free_rs);
  *  @gfp:	GFP_ flags for allocations
  */
 static struct rs_control *init_rs_internal(int symsize, int gfpoly,
-					   int (*gffunc)(int), int fcr,
-					   int prim, int nroots, gfp_t gfp)
+					   int (*gffunc)(int), bool gfswab,
+					   int fcr, int prim, int nroots,
+					   gfp_t gfp)
 {
 	struct list_head *tmp;
 	struct rs_control *rs;
@@ -227,6 +235,8 @@ static struct rs_control *init_rs_internal(int symsize, int gfpoly,
 		return NULL;
 	if (nroots < 0 || nroots >= (1<<symsize))
 		return NULL;
+	if (gfswab && symsize != 16)
+		return NULL;
 
 	/*
 	 * The decoder needs buffers in each control struct instance to
@@ -250,6 +260,8 @@ static struct rs_control *init_rs_internal(int symsize, int gfpoly,
 			continue;
 		if (gffunc != cd->gffunc)
 			continue;
+		if (gfswab != cd->gfswab)
+			continue;
 		if (fcr != cd->fcr)
 			continue;
 		if (prim != cd->prim)
@@ -263,7 +275,8 @@ static struct rs_control *init_rs_internal(int symsize, int gfpoly,
 	}
 
 	/* Create a new one */
-	rs->codec = codec_init(symsize, gfpoly, gffunc, fcr, prim, nroots, gfp);
+	rs->codec = codec_init(symsize, gfpoly, gffunc, gfswab,
+			       fcr, prim, nroots, gfp);
 	if (!rs->codec) {
 		kfree(rs);
 		rs = NULL;
@@ -288,10 +301,31 @@ static struct rs_control *init_rs_internal(int symsize, int gfpoly,
 struct rs_control *init_rs_gfp(int symsize, int gfpoly, int fcr, int prim,
 			       int nroots, gfp_t gfp)
 {
-	return init_rs_internal(symsize, gfpoly, NULL, fcr, prim, nroots, gfp);
+	return init_rs_internal(symsize, gfpoly, NULL, false,
+				fcr, prim, nroots, gfp);
 }
 EXPORT_SYMBOL_GPL(init_rs_gfp);
 
+/**
+ * init_rs16_gfp - Allocate rs control struct for 16 bit symbols
+ *  @gfpoly:	the extended Galois field generator polynomial coefficients,
+ *		with the 0th coefficient in the low order bit. The polynomial
+ *		must be primitive;
+ *  @gfswab:	Treat symbols as foreign endian
+ *  @fcr:	the first consecutive root of the rs code generator polynomial
+ *		in index form
+ *  @prim:	primitive element to generate polynomial roots
+ *  @nroots:	RS code generator polynomial degree (number of roots)
+ *  @gfp:	Memory allocation flags.
+ */
+struct rs_control *init_rs16_gfp(int gfpoly, bool gfswab, int fcr, int prim,
+				 int nroots, gfp_t gfp)
+{
+	return init_rs_internal(16, gfpoly, NULL, gfswab,
+				fcr, prim, nroots, gfp);
+}
+EXPORT_SYMBOL_GPL(init_rs16_gfp);
+
 /**
  * init_rs_non_canonical - Allocate rs control struct for fields with
  *                         non-canonical representation
@@ -307,7 +341,7 @@ EXPORT_SYMBOL_GPL(init_rs_gfp);
 struct rs_control *init_rs_non_canonical(int symsize, int (*gffunc)(int),
 					 int fcr, int prim, int nroots)
 {
-	return init_rs_internal(symsize, 0, gffunc, fcr, prim, nroots,
+	return init_rs_internal(symsize, 0, gffunc, false, fcr, prim, nroots,
 				GFP_KERNEL);
 }
 EXPORT_SYMBOL_GPL(init_rs_non_canonical);
diff --git a/lib/reed_solomon/test_rslib.c b/lib/reed_solomon/test_rslib.c
index d9d1c33aebda..f1eba21ed6d8 100644
--- a/lib/reed_solomon/test_rslib.c
+++ b/lib/reed_solomon/test_rslib.c
@@ -36,6 +36,7 @@ __param(int, bc, 1, "Test for correct behaviour beyond error correction capacity
 struct etab {
 	int	symsize;
 	int	genpoly;
+	bool	byteswap;
 	int	fcs;
 	int	prim;
 	int	nroots;
@@ -44,17 +45,18 @@ struct etab {
 
 /* List of codes to test */
 static struct etab Tab[] = {
-	{2,	0x7,	1,	1,	1,	100000	},
-	{3,	0xb,	1,	1,	2,	100000	},
-	{3,	0xb,	1,	1,	3,	100000	},
-	{3,	0xb,	2,	1,	4,	100000	},
-	{4,	0x13,	1,	1,	4,	10000	},
-	{5,	0x25,	1,	1,	6,	1000	},
-	{6,	0x43,	3,	1,	8,	1000	},
-	{7,	0x89,	1,	1,	14,	500	},
-	{8,	0x11d,	1,	1,	30,	100	},
-	{8,	0x187,	112,	11,	32,	100	},
-	{9,	0x211,	1,	1,	33,	80	},
+	{2,	0x7,	false,	1,	1,	1,	100000	},
+	{3,	0xb,	false,	1,	1,	2,	100000	},
+	{3,	0xb,	false,	1,	1,	3,	100000	},
+	{3,	0xb,	false,	2,	1,	4,	100000	},
+	{4,	0x13,	false,	1,	1,	4,	10000	},
+	{5,	0x25,	false,	1,	1,	6,	1000	},
+	{6,	0x43,	false,	3,	1,	8,	1000	},
+	{7,	0x89,	false,	1,	1,	14,	500	},
+	{8,	0x11d,	false,	1,	1,	30,	100	},
+	{8,	0x187,	false,	112,	11,	32,	100	},
+	{9,	0x211,	false,	1,	1,	33,	80	},
+	{16,  0x1002d,	true,	1,	1,	33,	5	},
 	{0, 0, 0, 0, 0, 0},
 };
 
@@ -450,7 +452,12 @@ static int run_exercise(struct etab *e)
 	struct wspace *ws;
 	int i;
 
-	rsc = init_rs(e->symsize, e->genpoly, e->fcs, e->prim, e->nroots);
+	if (e->symsize != 16)
+		rsc = init_rs(e->symsize, e->genpoly,
+			      e->fcs, e->prim, e->nroots);
+	else
+		rsc = init_rs16(e->genpoly, e->byteswap,
+				e->fcs, e->prim, e->nroots);
 	if (!rsc)
 		return retval;
 
-- 
2.30.2

