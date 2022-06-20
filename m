Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A00551034
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 08:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbiFTGVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 02:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238669AbiFTGU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:20:58 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AE2DEE4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 23:20:52 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 68so3978313pgb.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 23:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FEKEneG+vJbEcnlCaC2oiLWn9YgUu5T0FQV2Cn/dZ9U=;
        b=S9RLhwpe5H98x8NOYMOFGYbclKiO1XLjX2Mh81/vc6HJTPuiMpr0jJzV87V6ObH4wU
         LhxCttQh7il4XPyvpOkgEi6l1+69jl02ynY3QtEHdRQSsHUleFJRyUraVHSftAsR1pjY
         rbKHpHphMtarAquQvU+6WV+rteh0/SvYS5KrTyRiwHNBVvC2/vEWJzi0TKZddgo5TKgl
         PNRyh92Petwqgr097tRFa51nWHIcQGUjF5zX4Jb4lvkpu8UBK5sVpaODUN4FmhJPYzPr
         s64VELliCORRvffsvxOaBL5KSqXKvqDzTMsEi45UbfWBLhLY23MGic9/PBiuXrWaglux
         1ZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FEKEneG+vJbEcnlCaC2oiLWn9YgUu5T0FQV2Cn/dZ9U=;
        b=wqC41hVFp3r12PdYW7a8/t3cnL/ID6XJrWc7fgGfCLfJWkUEAqBYXtN8+2KsEWEmeq
         FEXp0ZgQkJuzsn8dBYYldJIXxwKngoBJUhj5ngYMiQEagTxgbmfh2FqPDrZ+ttxSWFC3
         JNWwSduSeT99Cf9jclfblSOWI+GHR01DpjHiw11w4ISXPIcgcoFCkV0nRQsa5jzBodWi
         lf9mZaIWsOxPPJsILYoyO0USOAxlb9zatgAO0OSIy0CtLHqmkh5jGJZScK4xWU59poIL
         qr1hZmD3GU74YzARm3NGxiyxAlf9wdoR4eThZ3h3+kGdM5hssqfX1TgPgqdz9fOBko25
         xaOg==
X-Gm-Message-State: AJIora9vp619YpZkN4+Gt9tLEMCsO6WUmo8LxmXl87HftLpOcG6JJnXI
        zSxVJaIsD5ikcjAaSrVvSmjwoKCyvio=
X-Google-Smtp-Source: AGRyM1vOhjUZ0EUomXsBhViW6Znps9PRSlk3Z5i4SJUYGqbnpHmOC1w5AboCS8uj3Fp4eLFd7cR3Eg==
X-Received: by 2002:a05:6a00:c88:b0:51c:1001:65f9 with SMTP id a8-20020a056a000c8800b0051c100165f9mr22685637pfv.66.1655706052099;
        Sun, 19 Jun 2022 23:20:52 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id p13-20020a63950d000000b003fd9e4911f9sm8010469pgd.31.2022.06.19.23.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 23:20:51 -0700 (PDT)
From:   Zhang Boyang <zhangboyang.id@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [PATCH v3 5/6] rslib: Improve the performance of encode_rs.c
Date:   Mon, 20 Jun 2022 14:20:14 +0800
Message-Id: <20220620062015.15612-6-zhangboyang.id@gmail.com>
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

This patch enhances the performance of RS encoder by following points:

1) Avoid memmove(). The shifting operation done by memmove() can be
   merged into the calculation loop above.

2) Introduce rs_modnn_fast(). The original rs_modnn() contains a loop
   which may be slow. Since (fb + genpoly[...]) is always strictly less
   than (2 * rs->nn), we can use a ternary operator to do the same
   calculation. The new faster function is named rs_modnn_fast(). The
   new rs_modnn_fast(x) requires 0 <= x < 2*nn, in contrast, original
   rs_modnn(x) only requires x >= 0. To make things clear, the
   documentation of original rs_modnn() is also updated.

Signed-off-by: Zhang Boyang <zhangboyang.id@gmail.com>
---
 include/linux/rslib.h        | 15 ++++++++++++++-
 lib/reed_solomon/encode_rs.c | 21 ++++++++++-----------
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/include/linux/rslib.h b/include/linux/rslib.h
index e92923fff3bc..a277a178157b 100644
--- a/include/linux/rslib.h
+++ b/include/linux/rslib.h
@@ -111,7 +111,7 @@ void free_rs(struct rs_control *rs);
  * rs_modnn() - Modulo replacement for galois field arithmetics
  *
  *  @rs:	Pointer to the RS codec
- *  @x:		the value to reduce
+ *  @x:		x >= 0 ; the value to reduce
  *
  *  where
  *  rs->mm = number of bits per symbol
@@ -128,4 +128,17 @@ static inline int rs_modnn(struct rs_codec *rs, int x)
 	return x;
 }
 
+/**
+ * rs_modnn_fast() - Modulo replacement for galois field arithmetics
+ *
+ *  @rs:	Pointer to the RS codec
+ *  @x:		0 <= x < 2*nn ; the value to reduce
+ *
+ *  Same as rs_modnn(x), but faster, at the cost of limited value range of @x
+*/
+static inline int rs_modnn_fast(struct rs_codec *rs, int x)
+{
+	return x - rs->nn < 0 ? x : x - rs->nn;
+}
+
 #endif
diff --git a/lib/reed_solomon/encode_rs.c b/lib/reed_solomon/encode_rs.c
index 9112d46e869e..6e3847b17ad4 100644
--- a/lib/reed_solomon/encode_rs.c
+++ b/lib/reed_solomon/encode_rs.c
@@ -27,19 +27,18 @@
 
 	for (i = 0; i < len; i++) {
 		fb = index_of[((((uint16_t) data[i])^invmsk) & msk) ^ par[0]];
-		/* feedback term is non-zero */
 		if (fb != nn) {
-			for (j = 1; j < nroots; j++) {
-				par[j] ^= alpha_to[rs_modnn(rs, fb +
-							 genpoly[nroots - j])];
-			}
-		}
-		/* Shift */
-		memmove(&par[0], &par[1], sizeof(uint16_t) * (nroots - 1));
-		if (fb != nn) {
-			par[nroots - 1] = alpha_to[rs_modnn(rs,
-							    fb + genpoly[0])];
+			/* feedback term is non-zero */
+			for (j = 1; j < nroots; j++)
+				par[j - 1] = par[j] ^ alpha_to[rs_modnn_fast(rs,
+						      fb +
+						      genpoly[nroots - j])];
+			par[nroots - 1] = alpha_to[rs_modnn_fast(rs,
+					  fb +
+					  genpoly[0])];
 		} else {
+			for (j = 1; j < nroots; j++)
+				par[j - 1] = par[j];
 			par[nroots - 1] = 0;
 		}
 	}
-- 
2.30.2

