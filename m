Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2390B58B6CB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 18:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbiHFQZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 12:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbiHFQZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 12:25:39 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9885E11838
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 09:25:37 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id k14so2700370pfh.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 09:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FEKEneG+vJbEcnlCaC2oiLWn9YgUu5T0FQV2Cn/dZ9U=;
        b=gbSqz1N2qexfCCS3+eMv4LMN2uAn8OTwBgUKZwyrBVcaMcZ+VPs0IBPIo6p6Jt82tV
         qRtVtsb3+EkTw2NDSwSWIUKgLcmn21KCZzi0U5cHpgqIlLHOG4RNDkoFY6525uzRKgWU
         G35Ou+yBu4oHnzbYRGjY+6X80iUo3w1GnKDwY6pS7XHvM3eeHFSwDpkMf661EduDaFIN
         rvU0lqQjgXdO9FHSLlAFf8s/QmJmUs3mp02OoPDg2zSEpfYU+kyvb2FwOEUMgIO1n4Pq
         GtvozFYvtHqUOveC9KSnXq9Z9FQXBe/arVb1BW9LqIu26adz8OGO7K2NctpBT3Pqxw+R
         9WbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FEKEneG+vJbEcnlCaC2oiLWn9YgUu5T0FQV2Cn/dZ9U=;
        b=Tkdrvvrim+7ssopRJCH1abNC71a7q+QGgMG2nrpMP7FQ5n221OlVV1phTZh/E4TPIE
         WbTlt/P2uHRY1JdPBFi/kQ9FjB6OhSUBXC7ReYGBZWZb1My/EdJYWhgN6g5Lc92fBPwx
         N+YKsueraCL0kZ/+GOULR7OEz2A0hFFO7QIBPQO5sXYuhyMdgVdJHFwklpQOp37DEVXB
         KBfWF35NVNoMMJgryFYG1yTTpYHKr5+VWlEdVo42rI5qrnpu/E3U1na0uY6sgmPV5eWl
         tYk5aC/gh48VuzINrYFKXfKY0EnbmfOJOesiRLceufQ3wUf6PGUusV3gUHVO3LUyBgjk
         dMLg==
X-Gm-Message-State: ACgBeo3FVxMSTCRgOsk16EtCH9EPhiMIXsb/1ei1DxO7FeW/9SG/+BiW
        bzRajiO0DQsNzvyc5zy5das=
X-Google-Smtp-Source: AA6agR6LFPxz8BS70jbuTfYeD4jvPL4TLGfjvEgiSzTwP+lyRKOiJjkLnPhJDTFpC3QKmEukRT9xNA==
X-Received: by 2002:a65:57c8:0:b0:41c:fa29:ae1d with SMTP id q8-20020a6557c8000000b0041cfa29ae1dmr8213118pgr.136.1659803136890;
        Sat, 06 Aug 2022 09:25:36 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id s1-20020a17090a2f0100b001f04479017fsm4990927pjd.29.2022.08.06.09.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 09:25:36 -0700 (PDT)
From:   Zhang Boyang <zhangboyang.id@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [PATCH RESEND V3 5/6] rslib: Improve the performance of encode_rs.c
Date:   Sun,  7 Aug 2022 00:25:09 +0800
Message-Id: <20220806162510.157196-6-zhangboyang.id@gmail.com>
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

