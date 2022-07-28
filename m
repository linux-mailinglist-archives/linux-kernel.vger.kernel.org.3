Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C2A5843DB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 18:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbiG1QMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 12:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiG1QMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 12:12:23 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5606D9D6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:12:22 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r21so1440391qtn.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nVqHrflF9vmMmd/588tMUx02l5nIAJz+TrX/yH1UWPg=;
        b=SO5jDgoaWFhsn4dVMMRHUCOpRhHElt3Ciii5idJEiO0hFJfn6fgecNVmt4KHry/Cij
         NYabiutcmn4DRx7NeUg43FHV009+73aJRlMudRel8p0B/DDT1mtb6JQzT0fCrSCotTrb
         e0AkLa7xkL9CMXzk94FNpizgTEUt7JilClDPE+izqb3tfD7f8X3gdNt/Se+12mn23wyw
         Rz5QkMo25z2yBn6LDd6O5SwsTdNXg0cB+M2G1QEvhGKzvoZ0F/WVCR+QgfDm9FouFXi6
         nL2y5AQFsVXQw5RqYwKOb9FcLMxUcADGH8p7115xi2aLzPBaPoW7pPYlxpeEtNNkct3L
         0vvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nVqHrflF9vmMmd/588tMUx02l5nIAJz+TrX/yH1UWPg=;
        b=DfWZCL5B+WtwFBBhR4Ct/XiKsvXDD2MdSOz3kx2JNjpLc+eGawdALZWx8nYGrxbaWa
         YfSG0o/82i6GquNwUr55a80nL74LZU2chrSQ4CcX+J6BN+llovTCz499qo5Nj9ckP5fX
         42e8q1EUxRuyYh/9LgXyT69pZaM3ugPF9OOu9ZuH8Dk0x3cU0a6EW0LtkMmwvZyDa5LW
         JNF25pdiuwhwYTbaStuoL7iI0HeqUHH3ZZX/xKDUG7UdUzrUdszKCwbLZGD86sRL/V0A
         2nOEz05++HzvipEobv/4Yy9RJN/mlvVT/4b6ookjkStPm90jOn0O+LxsVy2eqt/2JYIa
         4caQ==
X-Gm-Message-State: AJIora+P8tcEmewWCj3D5pWPr8a8Kio0CLYhHKZTQr+sTJ3TL0SpxaYQ
        KXtJWRzXvjChI0cZm1rTkZ8=
X-Google-Smtp-Source: AGRyM1vi7CbQZpdu2lkjfaSDGPtna5N5h6kizl6LAgeyElZzackUdou5wj/NukL9DPzowSKlEGJ5Jg==
X-Received: by 2002:a05:622a:53:b0:31f:1fb6:8d3a with SMTP id y19-20020a05622a005300b0031f1fb68d3amr23883580qtw.386.1659024741054;
        Thu, 28 Jul 2022 09:12:21 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:b984:ba52:c3cf:cb5e])
        by smtp.gmail.com with ESMTPSA id l21-20020ac87255000000b0031ef21aec36sm633174qtp.32.2022.07.28.09.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:12:20 -0700 (PDT)
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
Subject: [PATCH 3/5] lib/find_bit: unify _find_first_{,and,zero}_bit implementations
Date:   Thu, 28 Jul 2022 09:12:06 -0700
Message-Id: <20220728161208.865420-4-yury.norov@gmail.com>
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

The functions are almost identical, so create a common helper for them so
that compiler will be able to either inline the helper and optimize-out
parameters known at compile-time, or save some space by keeping it as a
real function.

On kvm/x86_64, bloat-o-meter reports +9 bytes. Find_bit_benchmark 5 times
before and after doesn't show significant (i.e. delta is greater than 3
sigma) difference, except find_next_bit, which is most likely an outlier
(although, lucky for the patch):
                     v5.19-rc8    Optimized   Difference (more - better)
Random dense bitmap	    ns	         ns             %       sigmas
find_next_bit:          721209       594936            18         3.19
find_next_zero_bit:     738138       638182            14         1.40
find_last_bit:          802393       940846           -17        -0.31
find_first_bit:        3560900      3379983             5         0.65
find_first_and_bit:   38601442     37683449             2         1.00
find_next_and_bit:      335574       300373            10         2.82
                                                       
Random sparse bitmap                                   
find_next_bit:           15868        13856            13         0.82
find_next_zero_bit:    1311843      1227418             6         0.72
find_last_bit:           13633        14080            -3        -0.74
find_first_bit:        1273625      1253343             2         0.52
find_first_and_bit:       8548         8157             5         0.32
find_next_and_bit:        8828         8437             4         0.52

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/find_bit.c | 62 +++++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/lib/find_bit.c b/lib/find_bit.c
index 4ef3151b3109..d207d1699834 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -20,12 +20,38 @@
 #include <linux/swab.h>
 
 /*
- * This is a common helper function for find_next_bit, find_next_zero_bit, and
- * find_next_and_bit. The differences are:
+ * This is a common helper functions for find_{first,next}_bit{,_le}.
+ * Internal parameters are:
  *  - The "invert" argument, which is XORed with each fetched word before
- *    searching it for one bits.
- *  - The optional "addr2", which is anded with "addr1" if present.
+ *    searching it for set bits; to implement find_*_zero_bit().
+ *  - The optional "addr2", which is ANDed with "addr1" if present; to
+ *    implement find_*_and_bit().
+ *  - The "need_swab" that converts words to BE format; to implement
+ *    find_*_le() on big-endian machines.
  */
+static inline
+unsigned long __find_first_bit(const unsigned long *addr1, const unsigned long *addr2,
+				unsigned long size, unsigned long invert, bool need_swab)
+{
+	unsigned long idx, val;
+
+	for (idx = 0; idx * BITS_PER_LONG < size; idx++) {
+		val = addr1[idx];
+		if (addr2)
+			val &= addr2[idx];
+
+		val ^= invert;
+
+		if (val) {
+			if (need_swab)
+				val = swab(val);
+			return min(idx * BITS_PER_LONG + __ffs(val), size);
+		}
+	}
+
+	return size;
+}
+
 static inline unsigned long __find_next_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long nbits,
 		unsigned long start, unsigned long invert, bool need_swab)
@@ -118,14 +144,7 @@ EXPORT_SYMBOL(_find_next_bit_le);
  */
 unsigned long _find_first_bit(const unsigned long *addr, unsigned long size)
 {
-	unsigned long idx;
-
-	for (idx = 0; idx * BITS_PER_LONG < size; idx++) {
-		if (addr[idx])
-			return min(idx * BITS_PER_LONG + __ffs(addr[idx]), size);
-	}
-
-	return size;
+	return __find_first_bit(addr, NULL, size, 0UL, false);
 }
 EXPORT_SYMBOL(_find_first_bit);
 #endif
@@ -138,15 +157,7 @@ unsigned long _find_first_and_bit(const unsigned long *addr1,
 				  const unsigned long *addr2,
 				  unsigned long size)
 {
-	unsigned long idx, val;
-
-	for (idx = 0; idx * BITS_PER_LONG < size; idx++) {
-		val = addr1[idx] & addr2[idx];
-		if (val)
-			return min(idx * BITS_PER_LONG + __ffs(val), size);
-	}
-
-	return size;
+	return __find_first_bit(addr1, addr2, size, 0UL, false);
 }
 EXPORT_SYMBOL(_find_first_and_bit);
 #endif
@@ -157,14 +168,7 @@ EXPORT_SYMBOL(_find_first_and_bit);
  */
 unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size)
 {
-	unsigned long idx;
-
-	for (idx = 0; idx * BITS_PER_LONG < size; idx++) {
-		if (addr[idx] != ~0UL)
-			return min(idx * BITS_PER_LONG + ffz(addr[idx]), size);
-	}
-
-	return size;
+	return __find_first_bit(addr, NULL, size, ~0UL, false);
 }
 EXPORT_SYMBOL(_find_first_zero_bit);
 #endif
-- 
2.34.1

