Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF7F483B68
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 06:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiADFD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 00:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiADFD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 00:03:57 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACDAC061761;
        Mon,  3 Jan 2022 21:03:57 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id a203-20020a1c7fd4000000b003457874263aso22050541wmd.2;
        Mon, 03 Jan 2022 21:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bX3txH8dDchVX0wVCbxbqybQRQkhYo9my0ZLDA1n4oE=;
        b=CV0S3MjYHGNdJsMzCoW1Ofj5SlNfSsTCDaf7bKHX39q0opZrkeY/o3vFxPMVMGJrC6
         58kP6NQZgwJgT48g23rGuyMIqc+LCdBkf10tqUPF6vMFpznQMEShveWdQOrEIV407jUY
         EFfbhZuTYPTA3hUZevN/RLpWsEL+C4zKvRHrP07XK9zaHFeW2Gg2Y9ADLqaZHa04SByu
         8iXeKosc+sR+qiFyr6nzgQqfNkUBoMGSp7F9ayslzRlixUFFo2Tlqye9WSup/DeFyAoE
         piFo58n++X07Nek1/zU90AR1KzdyA27r02GqTxFgqGd6tAjBBt234Z8YrCYxosF1RAD4
         Ztig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bX3txH8dDchVX0wVCbxbqybQRQkhYo9my0ZLDA1n4oE=;
        b=vipufBkx5HDoEgtSQ3R25FQoP7nrcbqVKozz67PPUVmyIkPfXFyTQiDJoVepkQ2YDX
         TlnWtW1fxNVFIzN1E0NJOG6SkE0ZeTETtew7FKso6OQ1JsDO1CWSyfdR9F3xJZit88Pj
         SsokTZraGo6nAjCSmd0fsulvuqak8yCyyGCyXtyqp67P2N+qRdtYA9kkM/HJyW1A6TkU
         uZ8JjKC2d4+ZoSFVWqaQyEaa6T9dTud+rb+3+chB6+dY8YCXk1Xz6mq0XaCAiRE1/tPp
         OZSataPB+tAtEeTPFebY1L2NhKawTSxIF5oqjGXWtBKL3++bcBARnAYMbbaR4p1g9NTQ
         IsYQ==
X-Gm-Message-State: AOAM531JuJMLgLM7rJ71YgJ6KFL5bXXXJh/hpT01hb1+Yp11bF1cly/P
        8KQdtGkDlFGVhpPpL320dP+cnrRKylqwNuNpNpaqUK3/6wo=
X-Google-Smtp-Source: ABdhPJwNB3Qvdq7axxA4E5eUQlzMMRCT1l0vcXYnVkl/wKpNoxh1CDFHqrOWJnDr7bZ2w3fKP43UxlRbq/S+YklMZ+M=
X-Received: by 2002:a7b:c087:: with SMTP id r7mr41264307wmh.17.1641272635864;
 Mon, 03 Jan 2022 21:03:55 -0800 (PST)
MIME-Version: 1.0
References: <Yc56ey6QKwaYg0yi@mit.edu> <20211231114903.60882-1-Jason@zx2c4.com>
 <Yc86TIah3w4waDEc@mit.edu>
In-Reply-To: <Yc86TIah3w4waDEc@mit.edu>
From:   Sandy Harris <sandyinchina@gmail.com>
Date:   Tue, 4 Jan 2022 13:03:43 +0800
Message-ID: <CACXcFmm2nKLHdqN27Ced2nLg=h2mSX_fKWFf-OkgArVRDi3xTw@mail.gmail.com>
Subject: Re: [PATCH v2] random: avoid superfluous call to RDRAND in CRNG extraction
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we are removing RDRAND, what about adding some
cheaper mixing? Something along these lines?

The current code's mixing is triggered only once in 2^32
iterations, depends only on crng->state[], always changes
the same state word, and introduces no new entropy.

Make it happen more often, depend on a randomly initialised
counter as well as state[], make a data-dependent choice of
word to change, and use random_get_entropy().
---
 drivers/char/random.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 605969ed0f96..d2be079f004d 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -985,6 +985,10 @@ static void crng_reseed(struct crng_state *crng,
struct entropy_store *r)
     }
 }

+#define CC_SHIFT 8
+#define CC_MASK ((1<<CC_SHIFT)-1)
+static u32 cc_count = 0 ;
+
 static void _extract_crng(struct crng_state *crng,
               __u8 out[CHACHA_BLOCK_SIZE])
 {
@@ -998,8 +1002,22 @@ static void _extract_crng(struct crng_state *crng,
     if (arch_get_random_long(&v))
         crng->state[14] ^= v;
     chacha20_block(&crng->state[0], out);
-    if (crng->state[12] == 0)
-        crng->state[13]++;
+        if (cc_count == 0)
+                cc_count = crng->state[9] ^ random_get_entropy() ;
+    switch ((crng->state[12] ^ cc_count) & CC_MASK)        {
+                case 0:
+                        cc_count = crng->state[10] ^ (cc_count>>CC_SHIFT);
+                        break ;
+                case 31: case 97: case 253:
+                        crng->state[crng->state[13]&7]++;
+                        break ;
+                case 61: case 127:
+                        crng->state[crng->state[11]&7] += random_get_entropy();
+                        break ;
+                default:
+                        break ;
+        }
+        cc_count++ ;
     spin_unlock_irqrestore(&crng->lock, flags);
 }

-- 
Signed-off-by: Sandy Harris <sandyinchina@gmail.com>
