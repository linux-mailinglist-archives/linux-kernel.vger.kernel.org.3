Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACECC54F991
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382928AbiFQOrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382908AbiFQOr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:47:28 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4225356B0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:47:23 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id k12-20020a17090a404c00b001eaabc1fe5dso4795772pjg.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=74dvXW85Si8OyW8s78GAB2ahyN6rAZk9avQp33MNw68=;
        b=FnBYwws+9XD6kl3MvtDiIyoDoC5Ez+CtWjrY8hZAVTEzdzz+DN9MUTuZMh1clKkKH3
         3drA7qu9zwU5Pe09dCysp4+KNjl1At6R95TW5Cll7XeRSYtkl7uWtLFgUtA2zzSqqwtv
         E/kUOMuVGWSLKH+035PeZlYkkf88JItZnKFfWii+3H++cz9MsSYFgOfXB8p/xxkz7DXP
         3/T+GktMzDnPO/VBxlkhyYY1AlWQScQ/cB3V53tHBQB/cby3JL1YZCl3xUy3401BQgf4
         67Wmt52l1EQM1HoWCLXGIgeGJWuTTnD7jtG1c7xEhIPie6Feug9KFrOkWK9EoBa/PSsw
         Bm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=74dvXW85Si8OyW8s78GAB2ahyN6rAZk9avQp33MNw68=;
        b=2OEPBtjy1W7oWfYxVzLheVvmo8G6loMAqNVpwthlXoYa609ZZOBbiQNP3dz2a1hjM6
         t+wDvhS2nSn7ybXY5/9m0dV64zvvzTOzZ7bB43Rn9g7neXPzzbi+uuBH+GtLgVxIPMQe
         m+mpcVvTmCp0DCW761SiDKykCperU0WLW3DFEdGaFPY8hweDixaJELvERw0lZhOuq8sN
         AlCMkIhedsrejIMKlIQfA4Plz4WS+WI1ix44uXuevWY1fHIOGaikAemTqnV1D+M/CPeF
         wBmNSb19xwADIUoDci9OJe+I/6Ak3k+oz9BmRPWusyY1/o66tSOMw9fhAfBXxjoNWhfq
         4alw==
X-Gm-Message-State: AJIora/Iz/tv2QG5uLunhUoeGSdUdVgTwWUAQUP2vJD2NuDf9gB3yxyT
        hb2JXANEx21IP/lgDkjyGE4bF+Rn+JjoXg==
X-Google-Smtp-Source: AGRyM1u+P2Y9EVcxgs85/JiQtD2bYVfrRxttO/agAeTUMFfJsb1YJ23qh+GGUz+jJQoZUBMNv2VwMQ==
X-Received: by 2002:a17:902:e84b:b0:164:8ba3:9cd9 with SMTP id t11-20020a170902e84b00b001648ba39cd9mr9948546plg.49.1655477242580;
        Fri, 17 Jun 2022 07:47:22 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id o12-20020a63a80c000000b003db822e2170sm3832453pgf.23.2022.06.17.07.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 07:47:21 -0700 (PDT)
From:   Zhang Boyang <zhangboyang.id@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Ivan Djelic <ivan.djelic@parrot.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [PATCH v2 4/5] rslib: Improve the performance of encode_rs.c
Date:   Fri, 17 Jun 2022 22:46:23 +0800
Message-Id: <20220617144624.158973-5-zhangboyang.id@gmail.com>
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
 include/linux/rslib.h        | 14 +++++++++++++-
 lib/reed_solomon/encode_rs.c | 21 ++++++++++-----------
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/include/linux/rslib.h b/include/linux/rslib.h
index cd0b5a7a5698..44ec7c6f24b2 100644
--- a/include/linux/rslib.h
+++ b/include/linux/rslib.h
@@ -110,7 +110,7 @@ void free_rs(struct rs_control *rs);
 /** modulo replacement for galois field arithmetics
  *
  *  @rs:	Pointer to the RS codec
- *  @x:		the value to reduce
+ *  @x:		x >= 0 ; the value to reduce
  *
  *  where
  *  rs->mm = number of bits per symbol
@@ -127,4 +127,16 @@ static inline int rs_modnn(struct rs_codec *rs, int x)
 	return x;
 }
 
+/** modulo replacement for galois field arithmetics
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

