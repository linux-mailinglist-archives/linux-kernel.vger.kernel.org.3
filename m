Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DD05754F6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240666AbiGNS2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240665AbiGNS2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:28:38 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1418EDEC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:28:35 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w12so3474651edd.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xJ2AUNFNB80WWdT50P/7IdU+X0ACPCIJDlt+b//8fYY=;
        b=WRlWIiUkK8ix+c+Ycog1wxs1dRSPzbSp+7maDrC9ESMRa073tPZXjTSzWz57YN921p
         5kuX9H42GYUU1Hyx2k/vf/cF7QV/8ZVfzNRMzr0d442YEhGjmhRFjac4mZrmrYPHdfAM
         nXMUxzlf0JnxgCLKYrorE7ALHy01xt90m9wCv9jSXMxK3dWNIFFqdDm15uY16mLJedrR
         ApXYZ9qaQtdA2gGUY/8+5CuPgJKWFkVGH4Ur7h4zbS8b8tULf4p8sboVT0CMk+OHjeqJ
         3jQ0sWnxuxFjKY88PJBfzSaAqOcBuaTj/9dXxCOItznv3oWXjGVFkpdG8L8lntT9rwIH
         OThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xJ2AUNFNB80WWdT50P/7IdU+X0ACPCIJDlt+b//8fYY=;
        b=L3r/VsT/DruCZR81xJLB/uyLrhYqshFSASJ32STH+Wgk93/5EJRlGBpEmqZWgSv8ZV
         QFD7KSnVIZbdFQ3KAink2IwOlWJvHajtt0RkEBE6IyRCzE3E7f6xgP+PMWNwb9KrVPKD
         0deg5D9biZKtPRKxyqXVrINTJA6djGv0K0q2rH2DFUQ0uVqL/3ZdyIyfrJRPrFTvQJBx
         MO7pb7XAUdYcCkDlVH1wMcCPjBdF2FOgee6cSsutHVF+L6FN2w016MDssL0bbthxLUzr
         UGddnzayPNtyfNa2V2lDjHYardmsEnCR0IljDGZqL/3nTi+R694fCGBM4WdqADpSRoJJ
         Vx6Q==
X-Gm-Message-State: AJIora+IziLZZ05USRgWgWhowrks+A78dkz1yIWsZQrWz3O+knr76GlK
        mmM6Xv3rEwYvNUimjMs3hRZIfQO8/aE=
X-Google-Smtp-Source: AGRyM1sKgUj9oHiswxGdwNYZmLWmPRKcZQehdRk6Bw/1asSDIUGmWR6+kjGOeRMgr/5S3IyQQHWQ8w==
X-Received: by 2002:a05:6402:50d2:b0:43a:8487:8a09 with SMTP id h18-20020a05640250d200b0043a84878a09mr14054473edb.232.1657823313392;
        Thu, 14 Jul 2022 11:28:33 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id f24-20020a056402005800b0043a7404314csm1495045edu.8.2022.07.14.11.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:28:33 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, "Theodore Ts'o" <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] random: Use try_cmpxchg in _credit_init_bits
Date:   Thu, 14 Jul 2022 20:28:22 +0200
Message-Id: <20220714182822.25142-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.35.3
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

Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
_credit_init_bits. x86 CMPXCHG instruction returns success in ZF flag,
so this change saves a compare after cmpxchg (and related move
instruction in front of cmpxchg).

Also, try_cmpxchg implicitly assigns old *ptr value to "old"
when cmpxchg fails, enabling further code simplifications.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
---
 drivers/char/random.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index e3dd1dd3dd22..78e690f0f9f6 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -643,10 +643,10 @@ static void __cold _credit_init_bits(size_t bits)
 
 	add = min_t(size_t, bits, POOL_BITS);
 
+	orig = READ_ONCE(input_pool.init_bits);
 	do {
-		orig = READ_ONCE(input_pool.init_bits);
 		new = min_t(unsigned int, POOL_BITS, orig + add);
-	} while (cmpxchg(&input_pool.init_bits, orig, new) != orig);
+	} while (!try_cmpxchg(&input_pool.init_bits, &orig, new));
 
 	if (orig < POOL_READY_BITS && new >= POOL_READY_BITS) {
 		crng_reseed(); /* Sets crng_init to CRNG_READY under base_crng.lock. */
-- 
2.35.3

