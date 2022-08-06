Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7DA58B6CC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 18:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbiHFQ0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 12:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiHFQZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 12:25:41 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC131115A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 09:25:40 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id b133so4719107pfb.6
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 09:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=N1BCvou7NjHgyn5FaZtbtm6KuJ8J4dRe9ttSN/j/ctQ=;
        b=VJzvGIIL2+vKbZhL3bMehx1UkSKnh+x7IntHakUkAlrZV4c5h1YCr9iolr1AJJf9z1
         VHnmZ2rg0h6A/fGZ5Wg80jP4ZlkSWKaQ5Sv8DpDQ6/tDRKJuauTvDuA0VNZ/m7U2hKTd
         3UX0ZZfTi4QgrS81gulr4Dv6sihDZj+u9EZTnNYyIvWWLszi50sfmwUpqxwYPk8m4qBK
         bbJSMZzEqrOlsmWWpNvBm6hqSdYSg0htZH5XKWJrF/XIpjg3iWgP2v6UzI/JgSFyeJZy
         9Ce4nApaqLsR8wMDPKnxemX9X7BeoAZWXjlS1pPhMa/aRYB26ayWPZl4DmL/AkqTOE6A
         O9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=N1BCvou7NjHgyn5FaZtbtm6KuJ8J4dRe9ttSN/j/ctQ=;
        b=3lqWKijsHNxXuARgY/3HF/fwwPiF31VxDHL3BnQChSkXbMjAjRypF2eprVUTVmr7Nj
         zzdpSRN1ZzloNIVcKNAFcqAGVaCOQQMXsGqpquMeNmONH8auNYqJ87tG1zO+FHiUbz5o
         WLff4sezno6+eqkmzoKDmKJFlPHw2RGwS2IA+PHIBPKRusOATAnxJx/dcoC0PrxUQr03
         aGKVMFYPpDAOOKfoDOFZ+s25h3IEu625KfER0g2vUrTZcWiYYOEBojfmzJ6F0L8km+8l
         WwIgRzAwLeyH+IZUBJirnEV3Xq1U6/G4NAxiB1rEPYq17PrtI9xxKNwPMaiH9ALHwME+
         n8kg==
X-Gm-Message-State: ACgBeo3t57PslT7ZTiRWM7Mwk+Yj0k5mk5c45dkuXXzVMcvERt1FeZ+4
        pf0K1mbcM/5GCxIUQsQuzaY=
X-Google-Smtp-Source: AA6agR6DthDFW99OTxtafIz9oHu+1QpBzLnGT2aZvsj4qAzL5uzEmEYTwOTEyg+JBaEpcN5UCoSr0Q==
X-Received: by 2002:a05:6a00:813:b0:52e:c38f:f2cf with SMTP id m19-20020a056a00081300b0052ec38ff2cfmr7680611pfk.57.1659803139780;
        Sat, 06 Aug 2022 09:25:39 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id s1-20020a17090a2f0100b001f04479017fsm4990927pjd.29.2022.08.06.09.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 09:25:39 -0700 (PDT)
From:   Zhang Boyang <zhangboyang.id@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [PATCH RESEND V3 6/6] rslib: Fix integer overflow on large fcr or prim
Date:   Sun,  7 Aug 2022 00:25:10 +0800
Message-Id: <20220806162510.157196-7-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220806162510.157196-1-zhangboyang.id@gmail.com>
References: <20220806162510.157196-1-zhangboyang.id@gmail.com>
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

Current rslib support symsize up to 16, so the max value of rs->nn can
be 0xFFFF. Since fcr <= nn, prim <= nn, multiplications on them can
overflow easily, e.g. fcr*root[j], fcr*prim.

This patch fixes these problems by introducing rs_modnn_mul(a, b). This
function is same as rs_modnn(a*b) but it will avoid overflow when
calculating a*b. It requires 0 <= a <= nn && 0 <= b <= nn, because it
use uint32_t to do the multiplication internally, so there will be no
overflow as long as 0 <= a <= nn <= 0xFFFF && 0 <= b <= nn <= 0xFFFF. In
fact, if we use `unsigned int' everywhere, there is no need to have
rs_modnn_mul(). But the `unsigned int' approach has poor scalability and
it may bring us to the mess of signed and unsigned integers.

With rs_modnn(), the intermediate result is now restricted to [0, nn).
This enables us to use rs_modnn_fast(a+b) to replace rs_modnn(a+b), as
long as 0 <= a+b < 2*nn. The most common case is one addend in [0, nn]
and the other addend in [0, nn). The examples of values in [0, nn] are
fcr, prim, indexes taken from rs->index_of[0...nn], etc. The examples of
values in [0, nn) are results from rs_modnn(), indexes taken from
rs->index_of[1...nn], etc.

Since the roots of RS generator polynomial, i.e. (fcr+i)*prim%nn, is
often used. It's now precomputed into rs->genroot[], to avoid writing
rs_modnn_mul(rs, rs_modnn_fast(rs, fcr + i), prim) everywhere.

The algorithm of searching for rs->iprim is also changed. Instead of
searching for (1+what*nn)%prim == 0, then iprim = (1+what*nn)/prim, it
now searches for iprim*prim%nn == 1 directly.

A new test case is also added to test_rslib.c to ensure correctness.

Signed-off-by: Zhang Boyang <zhangboyang.id@gmail.com>
---
 include/linux/rslib.h           | 23 +++++++++++++
 lib/reed_solomon/decode_rs.c    | 60 +++++++++++++++++++--------------
 lib/reed_solomon/reed_solomon.c | 30 ++++++++++++-----
 lib/reed_solomon/test_rslib.c   |  8 ++---
 4 files changed, 83 insertions(+), 38 deletions(-)

diff --git a/include/linux/rslib.h b/include/linux/rslib.h
index a277a178157b..a11ea5e8eb14 100644
--- a/include/linux/rslib.h
+++ b/include/linux/rslib.h
@@ -22,6 +22,7 @@
  * @alpha_to:	exp() lookup table
  * @index_of:	log() lookup table
  * @genpoly:	Generator polynomial
+ * @genroot:	Roots of generator polynomial, index form
  * @nroots:	Number of generator roots = number of parity symbols
  * @fcr:	First consecutive root, index form
  * @prim:	Primitive element, index form
@@ -37,6 +38,7 @@ struct rs_codec {
 	uint16_t	*alpha_to;
 	uint16_t	*index_of;
 	uint16_t	*genpoly;
+	uint16_t	*genroot;
 	int		nroots;
 	int		fcr;
 	int		prim;
@@ -128,6 +130,27 @@ static inline int rs_modnn(struct rs_codec *rs, int x)
 	return x;
 }
 
+/**
+ * rs_modnn_mul() - Modulo replacement for galois field arithmetics
+ *
+ *  @rs:	Pointer to the RS codec
+ *  @a:		0 <= a <= nn ; a*b is the value to reduce
+ *  @b:		0 <= b <= nn ; a*b is the value to reduce
+ *
+ *  Same as rs_modnn(a*b), but avoid integer overflow when calculating a*b
+*/
+static inline int rs_modnn_mul(struct rs_codec *rs, int a, int b)
+{
+	/* nn <= 0xFFFF, so (a * b) will not overflow uint32_t */
+	uint32_t x = (uint32_t)a * (uint32_t)b;
+	uint32_t nn = (uint32_t)rs->nn;
+	while (x >= nn) {
+		x -= nn;
+		x = (x >> rs->mm) + (x & nn);
+	}
+	return (int)x;
+}
+
 /**
  * rs_modnn_fast() - Modulo replacement for galois field arithmetics
  *
diff --git a/lib/reed_solomon/decode_rs.c b/lib/reed_solomon/decode_rs.c
index 6c1d53d1b702..3387465ab429 100644
--- a/lib/reed_solomon/decode_rs.c
+++ b/lib/reed_solomon/decode_rs.c
@@ -20,6 +20,7 @@
 	int iprim = rs->iprim;
 	uint16_t *alpha_to = rs->alpha_to;
 	uint16_t *index_of = rs->index_of;
+	uint16_t *genroot = rs->genroot;
 	uint16_t u, q, tmp, num1, num2, den, discr_r, syn_error;
 	int count = 0;
 	int num_corrected;
@@ -69,8 +70,8 @@
 			} else {
 				syn[i] = ((((uint16_t) data[j]) ^
 					   invmsk) & msk) ^
-					alpha_to[rs_modnn(rs, index_of[syn[i]] +
-						       (fcr + i) * prim)];
+					alpha_to[rs_modnn_fast(rs,
+						index_of[syn[i]] + genroot[i])];
 			}
 		}
 	}
@@ -81,8 +82,8 @@
 				syn[i] = ((uint16_t) par[j]) & msk;
 			} else {
 				syn[i] = (((uint16_t) par[j]) & msk) ^
-					alpha_to[rs_modnn(rs, index_of[syn[i]] +
-						       (fcr+i)*prim)];
+					alpha_to[rs_modnn_fast(rs,
+						index_of[syn[i]] + genroot[i])];
 			}
 		}
 	}
@@ -108,15 +109,17 @@
 
 	if (no_eras > 0) {
 		/* Init lambda to be the erasure locator polynomial */
-		lambda[1] = alpha_to[rs_modnn(rs,
-					prim * (nn - 1 - (eras_pos[0] + pad)))];
+		lambda[1] = alpha_to[rs_modnn_mul(rs,
+					 prim, (nn - 1 - (eras_pos[0] + pad)))];
 		for (i = 1; i < no_eras; i++) {
-			u = rs_modnn(rs, prim * (nn - 1 - (eras_pos[i] + pad)));
+			u = rs_modnn_mul(rs,
+					 prim, (nn - 1 - (eras_pos[i] + pad)));
 			for (j = i + 1; j > 0; j--) {
 				tmp = index_of[lambda[j - 1]];
 				if (tmp != nn) {
 					lambda[j] ^=
-						alpha_to[rs_modnn(rs, u + tmp)];
+						alpha_to[rs_modnn_fast(rs,
+							 u + tmp)];
 				}
 			}
 		}
@@ -137,9 +140,9 @@
 		for (i = 0; i < r; i++) {
 			if ((lambda[i] != 0) && (s[r - i - 1] != nn)) {
 				discr_r ^=
-					alpha_to[rs_modnn(rs,
-							  index_of[lambda[i]] +
-							  s[r - i - 1])];
+					alpha_to[rs_modnn_fast(rs,
+						 index_of[lambda[i]] +
+						 s[r - i - 1])];
 			}
 		}
 		discr_r = index_of[discr_r];	/* Index form */
@@ -153,8 +156,8 @@
 			for (i = 0; i < nroots; i++) {
 				if (b[i] != nn) {
 					t[i + 1] = lambda[i + 1] ^
-						alpha_to[rs_modnn(rs, discr_r +
-								  b[i])];
+						alpha_to[rs_modnn_fast(rs,
+							 discr_r + b[i])];
 				} else
 					t[i + 1] = lambda[i + 1];
 			}
@@ -166,8 +169,9 @@
 				 */
 				for (i = 0; i <= nroots; i++) {
 					b[i] = (lambda[i] == 0) ? nn :
-						rs_modnn(rs, index_of[lambda[i]]
-							 - discr_r + nn);
+						rs_modnn_fast(rs,
+						        index_of[lambda[i]] +
+							nn - discr_r);
 				}
 			} else {
 				/* 2 lines below: B(x) <-- x*B(x) */
@@ -197,11 +201,11 @@
 	/* Find roots of error+erasure locator polynomial by Chien search */
 	memcpy(&reg[1], &lambda[1], nroots * sizeof(reg[0]));
 	count = 0;		/* Number of roots of lambda(x) */
-	for (i = 1, k = iprim - 1; i <= nn; i++, k = rs_modnn(rs, k + iprim)) {
+	for (i = 1, k = iprim-1; i <= nn; i++, k = rs_modnn_fast(rs, k+iprim)) {
 		q = alpha_to[0];	/* lambda[0] is always 0 */
 		for (j = deg_lambda; j > 0; j--) {
 			if (reg[j] != nn) {
-				reg[j] = rs_modnn(rs, reg[j] + j);
+				reg[j] = rs_modnn_fast(rs, reg[j] + j);
 				q ^= alpha_to[reg[j]];
 			}
 		}
@@ -238,8 +242,8 @@
 		tmp = 0;
 		for (j = i; j >= 0; j--) {
 			if ((s[i - j] != nn) && (lambda[j] != nn))
-				tmp ^=
-				    alpha_to[rs_modnn(rs, s[i - j] + lambda[j])];
+				tmp ^= alpha_to[rs_modnn_fast(rs,
+						s[i - j] + lambda[j])];
 		}
 		omega[i] = index_of[tmp];
 	}
@@ -254,8 +258,9 @@
 		num1 = 0;
 		for (i = deg_omega; i >= 0; i--) {
 			if (omega[i] != nn)
-				num1 ^= alpha_to[rs_modnn(rs, omega[i] +
-							i * root[j])];
+				num1 ^= alpha_to[rs_modnn_fast(rs,
+						 omega[i] +
+						 rs_modnn_mul(rs, i, root[j]))];
 		}
 
 		if (num1 == 0) {
@@ -264,15 +269,18 @@
 			continue;
 		}
 
-		num2 = alpha_to[rs_modnn(rs, root[j] * (fcr - 1) + nn)];
+		num2 = alpha_to[rs_modnn_fast(rs,
+				rs_modnn_mul(rs, root[j], fcr) +
+				nn - root[j])];
 		den = 0;
 
 		/* lambda[i+1] for i even is the formal derivative
 		 * lambda_pr of lambda[i] */
 		for (i = min(deg_lambda, nroots - 1) & ~1; i >= 0; i -= 2) {
 			if (lambda[i + 1] != nn) {
-				den ^= alpha_to[rs_modnn(rs, lambda[i + 1] +
-						       i * root[j])];
+				den ^= alpha_to[rs_modnn_fast(rs,
+						lambda[i + 1] +
+						rs_modnn_mul(rs, i, root[j]))];
 			}
 		}
 
@@ -292,8 +300,8 @@
 			if (b[j] == 0)
 				continue;
 
-			k = (fcr + i) * prim * (nn-loc[j]-1);
-			tmp ^= alpha_to[rs_modnn(rs, index_of[b[j]] + k)];
+			k = rs_modnn_mul(rs, genroot[i], nn - loc[j] - 1);
+			tmp ^= alpha_to[rs_modnn_fast(rs, index_of[b[j]] + k)];
 		}
 
 		if (tmp != alpha_to[s[i]])
diff --git a/lib/reed_solomon/reed_solomon.c b/lib/reed_solomon/reed_solomon.c
index da46026a60b8..2c86e4dfcbaa 100644
--- a/lib/reed_solomon/reed_solomon.c
+++ b/lib/reed_solomon/reed_solomon.c
@@ -100,6 +100,10 @@ static struct rs_codec *codec_init(int symsize, int gfpoly, int (*gffunc)(int),
 	if(rs->genpoly == NULL)
 		goto err;
 
+	rs->genroot = kmalloc_array(rs->nroots, sizeof(uint16_t), gfp);
+	if(rs->genroot == NULL)
+		goto err;
+
 	/* Generate Galois field lookup tables */
 	rs->index_of[0] = rs->nn;	/* log(zero) = -inf */
 	rs->alpha_to[rs->nn] = 0;	/* alpha**-inf = 0 */
@@ -126,26 +130,34 @@ static struct rs_codec *codec_init(int symsize, int gfpoly, int (*gffunc)(int),
 		goto err;
 
 	/* Find prim-th root of 1, used in decoding */
-	for(iprim = 1; (iprim % prim) != 0; iprim += rs->nn);
+	for (iprim = 1; rs_modnn_mul(rs, iprim, prim) != 1; iprim++);
 	/* prim-th root of 1, index form */
-	rs->iprim = iprim / prim;
+	rs->iprim = iprim;
+
+	/* Precompute generator polynomial roots */
+	root = rs_modnn_mul(rs, fcr, prim);
+	for (i = 0; i < nroots; i++) {
+		rs->genroot[i] = root; /*  = (fcr + i) * prim % nn  */
+		root = rs_modnn_fast(rs, root + prim);
+	}
 
 	/* Form RS code generator polynomial from its roots */
 	rs->genpoly[0] = rs->alpha_to[0];
-	for (i = 0, root = fcr * prim; i < nroots; i++, root += prim) {
+	for (i = 0; i < nroots; i++) {
+		root = rs->genroot[i];
 		rs->genpoly[i + 1] = rs->alpha_to[0];
 		/* Multiply rs->genpoly[] by  @**(root + x) */
 		for (j = i; j > 0; j--) {
 			if (rs->genpoly[j] != 0) {
-				rs->genpoly[j] = rs->genpoly[j -1] ^
-					rs->alpha_to[rs_modnn(rs,
+				rs->genpoly[j] = rs->genpoly[j - 1] ^
+					rs->alpha_to[rs_modnn_fast(rs,
 					rs->index_of[rs->genpoly[j]] + root)];
 			} else
 				rs->genpoly[j] = rs->genpoly[j - 1];
 		}
 		/* rs->genpoly[0] can never be zero */
 		rs->genpoly[0] =
-			rs->alpha_to[rs_modnn(rs,
+			rs->alpha_to[rs_modnn_fast(rs,
 				rs->index_of[rs->genpoly[0]] + root)];
 	}
 	/* convert rs->genpoly[] to index form for quicker encoding */
@@ -157,6 +169,7 @@ static struct rs_codec *codec_init(int symsize, int gfpoly, int (*gffunc)(int),
 	return rs;
 
 err:
+	kfree(rs->genroot);
 	kfree(rs->genpoly);
 	kfree(rs->index_of);
 	kfree(rs->alpha_to);
@@ -188,6 +201,7 @@ void free_rs(struct rs_control *rs)
 		kfree(cd->alpha_to);
 		kfree(cd->index_of);
 		kfree(cd->genpoly);
+		kfree(cd->genroot);
 		kfree(cd);
 	}
 	mutex_unlock(&rslistlock);
@@ -340,7 +354,7 @@ EXPORT_SYMBOL_GPL(encode_rs8);
  *  @data:	data field of a given type
  *  @par:	received parity data field
  *  @len:	data length
- *  @s: 	syndrome data field, must be in index form
+ *  @s: 	syndrome data field, must be in index form, 0 <= index <= nn
  *		(if NULL, syndrome is calculated)
  *  @no_eras:	number of erasures
  *  @eras_pos:	position of erasures, can be NULL
@@ -393,7 +407,7 @@ EXPORT_SYMBOL_GPL(encode_rs16);
  *  @data:	data field of a given type
  *  @par:	received parity data field
  *  @len:	data length
- *  @s: 	syndrome data field, must be in index form
+ *  @s: 	syndrome data field, must be in index form, 0 <= index <= nn
  *		(if NULL, syndrome is calculated)
  *  @no_eras:	number of erasures
  *  @eras_pos:	position of erasures, can be NULL
diff --git a/lib/reed_solomon/test_rslib.c b/lib/reed_solomon/test_rslib.c
index d9d1c33aebda..a03c7249f920 100644
--- a/lib/reed_solomon/test_rslib.c
+++ b/lib/reed_solomon/test_rslib.c
@@ -55,6 +55,7 @@ static struct etab Tab[] = {
 	{8,	0x11d,	1,	1,	30,	100	},
 	{8,	0x187,	112,	11,	32,	100	},
 	{9,	0x211,	1,	1,	33,	80	},
+	{16,  0x1ffed,	65534,	65534,	50,	5	},
 	{0, 0, 0, 0, 0, 0},
 };
 
@@ -232,9 +233,8 @@ static void compute_syndrome(struct rs_control *rsc, uint16_t *data,
 	struct rs_codec *rs = rsc->codec;
 	uint16_t *alpha_to = rs->alpha_to;
 	uint16_t *index_of = rs->index_of;
+	uint16_t *genroot = rs->genroot;
 	int nroots = rs->nroots;
-	int prim = rs->prim;
-	int fcr = rs->fcr;
 	int i, j;
 
 	/* Calculating syndrome */
@@ -245,8 +245,8 @@ static void compute_syndrome(struct rs_control *rsc, uint16_t *data,
 				syn[i] = data[j];
 			} else {
 				syn[i] = data[j] ^
-					alpha_to[rs_modnn(rs, index_of[syn[i]]
-						+ (fcr + i) * prim)];
+					alpha_to[rs_modnn_fast(rs,
+						index_of[syn[i]] + genroot[i])];
 			}
 		}
 	}
-- 
2.30.2

