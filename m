Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7E05843DF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 18:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbiG1QMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 12:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbiG1QM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 12:12:26 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449C56E2F1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:12:25 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id mh14so1751235qvb.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b+TtgBs1YBfFDFS7bvjbrZrbqBFKrT/paxnRG4cTTIw=;
        b=h9plRpRDHdI6/W4nREA3xIO8VueRMyfCUC/StFjcjgblj4Dbw8pn8VrKhaLc7ftOY8
         C2/Nr91meOZ6tUbL2yWZ0QM+rvHRcdZxh9KdmJrMMmu3TQA2q1N/6actR8uV2MHpJJWn
         A7o+2HY90z/ifiFZnPrSK3GfcjfFbApL55hURWPRmAe8gp0dPRR76PqeJFVpsKf8r7/a
         5D1r/NLR5zV0mOytEaZUv5h42wOY9k5eChzV96kJjVq9vYr+Nz6XeIOkGcNgEk7XE3bI
         bzXUPnTOIWxHTNUGceziDxyce8JXzc0aESUBctVMbGBO5HhqqZJ1Kc3erM8vga8Bgz6Y
         PlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b+TtgBs1YBfFDFS7bvjbrZrbqBFKrT/paxnRG4cTTIw=;
        b=Imk5libakqWYQ3TxwXY9n8Xxf1sTMJ7A7ju7xP8iB7eGPZber1mZqvCNjo4SlPghUH
         TxeP3C2sL+2Ww7SoIcThLAw919dhoWc1h/hcnkWQHb+gesxYyiEXQ4pWTetxhD3eOQmS
         hya9xXzLxEj9ieZ+RWj/X4zGBUhSYh8utbZQFvsCy+pvpnjeJAA8OxYu7Oqwok+qV1LV
         s1yJmPg1Orgp3Ni7zY+Loi2/nWFL70RXp1OZHqwYCEyXzKiqrExaROwWARQquWeL8SLI
         wlKxhghZWG11Cu35MAfjvxUp01sY3x+e1QpNULReT2YjbGraUElkIqSkQxMOyuh5RlpA
         SuQw==
X-Gm-Message-State: AJIora8dPXD03IACfkwYc65wAzrEfJSY4eZcyMVpwv18rYzSB8eCIwvR
        IBFNfpqnt47DZ8EJ94mr4AQ=
X-Google-Smtp-Source: AGRyM1u6rjSHc/bB6TKyTEE3f0wd9yAr9Vz667bpYhueaYGkf3KF6+gGCTynZRpzIWxIHDJfK/Rwdg==
X-Received: by 2002:a0c:b319:0:b0:473:82bd:327b with SMTP id s25-20020a0cb319000000b0047382bd327bmr23785874qve.43.1659024744239;
        Thu, 28 Jul 2022 09:12:24 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:b984:ba52:c3cf:cb5e])
        by smtp.gmail.com with ESMTPSA id w16-20020ac857d0000000b0031f0b43629dsm686287qta.23.2022.07.28.09.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:12:23 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dennis Zhou <dennis@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexey Klimov <aklimov@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [RFC PATCH 5/5] lib/find_bit: re-use __find_first_bit() in __find_next_bit()
Date:   Thu, 28 Jul 2022 09:12:08 -0700
Message-Id: <20220728161208.865420-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220728161208.865420-1-yury.norov@gmail.com>
References: <20220728161208.865420-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to m68k, switch __find_first_bit() to use __find_next_bit().
The only difference between them is that 'next' should skip #start bits.
So do it in prologue, and then just call 'first' version if needed.

Signed-off-by: Yury Norov <yury.norov@gmail.com>

---

This patch is just to see how m68k approach would work in general
(x86_64) case. It almost doubles the size of find_next() functions,
and adds nothing to performance.

I would prefer not taking it upstream.

add/remove: 0/0 grow/shrink: 4/0 up/down: 332/0 (332)
Function                                     old     new   delta
_find_next_zero_bit                          103     191     +88
find_next_clump8                             133     219     +86
_find_next_and_bit                           120     203     +83
_find_next_bit                                99     174     +75

                     v5.19-rc8    Optimized   Difference (more - better)
Random dense bitmap	    ns	         ns             %       sigmas
find_next_bit:          721209       742050            -3        -0.09
find_next_zero_bit:     738138       920508           -25        -0.51
find_last_bit:          802393       839157            -5        -0.08
find_first_bit:        3560900      3747795            -5        -0.30
find_first_and_bit:   38601442     37423751             3         1.28
find_next_and_bit:      335574       322220             4         1.07

Random sparse bitmap                                   
find_next_bit:           15868        13969            12         2.21
find_next_zero_bit:    1311843      1290946             2         0.18
find_last_bit:           13633        13856            -2        -0.37
find_first_bit:        1273625      1233955             3         1.01
find_first_and_bit:       8548        14974           -75        -0.43
find_next_and_bit:        8828         7766            12         1.37


 lib/find_bit.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/lib/find_bit.c b/lib/find_bit.c
index a56872611a59..137e606a05a1 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -61,12 +61,15 @@ static inline unsigned long __find_next_bit(const unsigned long *addr1,
 	if (unlikely(start >= nbits))
 		return nbits;
 
+	if (IS_ALIGNED(start, BITS_PER_LONG))
+		goto aligned;
+
+	/* Handle 1st word. */
 	tmp = addr1[start / BITS_PER_LONG];
 	if (addr2)
 		tmp &= addr2[start / BITS_PER_LONG];
 	tmp ^= invert;
 
-	/* Handle 1st word. */
 	mask = BITMAP_FIRST_WORD_MASK(start);
 	if (need_swab)
 		mask = swab(mask);
@@ -74,22 +77,20 @@ static inline unsigned long __find_next_bit(const unsigned long *addr1,
 	tmp &= mask;
 
 	start = round_down(start, BITS_PER_LONG);
-
-	while (!tmp) {
-		start += BITS_PER_LONG;
-		if (start >= nbits)
-			return nbits;
-
-		tmp = addr1[start / BITS_PER_LONG];
-		if (addr2)
-			tmp &= addr2[start / BITS_PER_LONG];
-		tmp ^= invert;
+	if (tmp) {
+		if (need_swab)
+			tmp = swab(tmp);
+		return min(start + __ffs(tmp), nbits);
 	}
 
-	if (need_swab)
-		tmp = swab(tmp);
+	start += BITS_PER_LONG;
+	if (start >= nbits)
+		return nbits;
 
-	return min(start + __ffs(tmp), nbits);
+aligned:
+	return start + __find_first_bit(addr1 + start/BITS_PER_LONG,
+					addr2 ? addr2 + start/BITS_PER_LONG : NULL,
+					nbits - start, invert, need_swab);
 }
 
 #ifndef find_next_bit
-- 
2.34.1

