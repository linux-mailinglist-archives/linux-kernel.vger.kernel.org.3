Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11D95843DA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 18:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiG1QMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 12:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbiG1QMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 12:12:22 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52936E2EF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:12:20 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id j11so1723658qvt.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m9VCKSONvhrO3g3DCwfmUIlgvFSHhyje+UErLAquBos=;
        b=l57PGFmgeekTFiJHUE9YC4JG7YJQk4hI38s2znWPIBsxolCh6K2OIfqllro+e04aS2
         M0MwRCANUKCJGQsQAKbTuzTuswm1nNrD/gtknK/32uABFp4D+RRqfgWndO71pH2Bq14s
         2X78Cwc77B5LkU0lzCwyitpF/aFFP6puFRyLQO1G9xkwRsnD383TOFBMtKlS9eacYIIs
         99JVMrNYiQTnJTlVocpExO7uvTOeZgd41E/spIO8WzNB81F2/0vlrmsa9fGXPZ11K3Wy
         3VytRzffJPp2lKOOnsdFDbyOz9DyXDPCny67844rzoWcm/f7AHQ/e7i4IwAHqd6qkBfj
         KuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m9VCKSONvhrO3g3DCwfmUIlgvFSHhyje+UErLAquBos=;
        b=Uek0z29JuhC6+MBM2zYJpEzrFQQl0pogU4cGY/d6q09ivS7uMKAPtYECJuWWIvxMH5
         4a/nFmsbbA7mSy3YcXd/jj2Su+2/2mQW1xZdBe/gnW76VIhcFk+Vk0wH7i2Ksd4+NayU
         fVVZ6/Eh7XVO1K/zMovGfcYcDkCe8ZCx93IiFHGYwheAuPPhm6x4s1XfUzSHJqZTAB9j
         ukv2eiouBCEsoKTldTKzbaa9Yker3KN0c95k3B0NnQxQ0DJFZ2uMC4H1T0/h+rdGGpfR
         N1OU0jTRuKftVH0X28A7gt8+vNf5Cw+iC1BLfBxvYXinIRkKbPIuM00J0Jr9uGtsvLAC
         c1nA==
X-Gm-Message-State: AJIora+g8M3cjBUmyYjKdWKHHC1YokgpWfwjdc/kF9a1RYKYiUQoh1Cj
        WpYzKpKEMEb42G3jZYC12JI=
X-Google-Smtp-Source: AGRyM1v50KTeGtTYCDNdNLmmHNSaoQwrv7kuOZxnx8ebs38KHkwkssrlbmbg+5AkWJkD/lsklATDdg==
X-Received: by 2002:ad4:5dcc:0:b0:473:9d1d:a1e with SMTP id m12-20020ad45dcc000000b004739d1d0a1emr24402524qvh.54.1659024739649;
        Thu, 28 Jul 2022 09:12:19 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:b984:ba52:c3cf:cb5e])
        by smtp.gmail.com with ESMTPSA id w18-20020a05620a425200b006b60c965024sm803133qko.113.2022.07.28.09.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:12:19 -0700 (PDT)
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
Subject: [PATCH 2/5] lib/find_bit: optimize find_next_bit() functions
Date:   Thu, 28 Jul 2022 09:12:05 -0700
Message-Id: <20220728161208.865420-3-yury.norov@gmail.com>
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

The function _find_next_bit() takes parameters that modify its behavior to
implement and- zero- and le- flavors. The parameters are passed at compile
time, but current design prevents the compiled from optimizing them out.

This patch adds wrappers around _find_next_bit(), and turns it into
internal inline helper, so that the optimization becomes possible.

I ran find_bit_benchmark 5 times on top of 5.19-rc8 and 5 times on top
of this patch. The results for kvm/x86_64 are:
                     v5.19-rc8    Optimized   Difference (more - better)
Random dense bitmap	    ns	         ns           %        sigmas*
find_next_bit:          721209       692337           4          0.73
find_next_zero_bit:     738138       701094           5          0.52
find_last_bit:          802393       698133          13          0.49
find_first_bit:	       3560900      3574644           0         -0.07
find_first_and_bit:   38601442     37945046           2          0.71
find_next_and_bit:      335574       306184           9          2.36
                                                      
Random sparse bitmap                                  
find_next_bit:           15868        13856          13          0.82
find_next_zero_bit:    1311843      1227418           4          0.72
find_last_bit:           13633        14080          -3         -0.74
find_first_bit:        1273625      1253343           1          0.52
find_first_and_bit:       8548         8157           7          0.32
find_next_and_bit:        8828         8437           6          0.52

* Calculated as:
	(mean(before) - mean(after)) / max(std(before), std(after))

All at all, optimized code is generally faster, but the difference
never reaches solid 3 sigmas. find_next_and_bit almost touches the
limit in dence bitmap test, but no...

However, bloat-o-meter shows significant ~2.5K decrease of image size
So, the optimization has total positive impact.

Bloat-o-meter:
add/remove: 4/2 grow/shrink: 18/193 up/down: 627/-3108 (-2481)

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/find.h | 25 ++++++++++++++--------
 lib/find_bit.c       | 49 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 62 insertions(+), 12 deletions(-)

diff --git a/include/linux/find.h b/include/linux/find.h
index 424ef67d4a42..3ace995d7079 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -8,9 +8,18 @@
 
 #include <linux/bitops.h>
 
-extern unsigned long _find_next_bit(const unsigned long *addr1,
-		const unsigned long *addr2, unsigned long nbits,
-		unsigned long start, unsigned long invert, unsigned long le);
+unsigned long _find_next_bit(const unsigned long *addr1, unsigned long nbits,
+				unsigned long start);
+unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long *addr2,
+					unsigned long nbits, unsigned long start);
+unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
+					 unsigned long start);
+#ifdef __BIG_ENDIAN
+unsigned long _find_next_zero_bit_le(const void *addr, unsigned
+					long size, unsigned long offset);
+unsigned long _find_next_bit_le(const void *addr, unsigned
+				long size, unsigned long offset);
+#endif
 extern unsigned long _find_first_bit(const unsigned long *addr, unsigned long size);
 extern unsigned long _find_first_and_bit(const unsigned long *addr1,
 					 const unsigned long *addr2, unsigned long size);
@@ -41,7 +50,7 @@ unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
 		return val ? __ffs(val) : size;
 	}
 
-	return _find_next_bit(addr, NULL, size, offset, 0UL, 0);
+	return _find_next_bit(addr, size, offset);
 }
 #endif
 
@@ -71,7 +80,7 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 		return val ? __ffs(val) : size;
 	}
 
-	return _find_next_bit(addr1, addr2, size, offset, 0UL, 0);
+	return _find_next_and_bit(addr1, addr2, size, offset);
 }
 #endif
 
@@ -99,7 +108,7 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 		return val == ~0UL ? size : ffz(val);
 	}
 
-	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0);
+	return _find_next_zero_bit(addr, size, offset);
 }
 #endif
 
@@ -247,7 +256,7 @@ unsigned long find_next_zero_bit_le(const void *addr, unsigned
 		return val == ~0UL ? size : ffz(val);
 	}
 
-	return _find_next_bit(addr, NULL, size, offset, ~0UL, 1);
+	return _find_next_zero_bit_le(addr, size, offset);
 }
 #endif
 
@@ -266,7 +275,7 @@ unsigned long find_next_bit_le(const void *addr, unsigned
 		return val ? __ffs(val) : size;
 	}
 
-	return _find_next_bit(addr, NULL, size, offset, 0UL, 1);
+	return _find_next_bit_le(addr, size, offset);
 }
 #endif
 
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 04c142acfc40..4ef3151b3109 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -19,9 +19,6 @@
 #include <linux/minmax.h>
 #include <linux/swab.h>
 
-#if !defined(find_next_bit) || !defined(find_next_zero_bit) ||			\
-	!defined(find_next_bit_le) || !defined(find_next_zero_bit_le) ||	\
-	!defined(find_next_and_bit)
 /*
  * This is a common helper function for find_next_bit, find_next_zero_bit, and
  * find_next_and_bit. The differences are:
@@ -29,7 +26,7 @@
  *    searching it for one bits.
  *  - The optional "addr2", which is anded with "addr1" if present.
  */
-unsigned long _find_next_bit(const unsigned long *addr1,
+static inline unsigned long __find_next_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long nbits,
 		unsigned long start, unsigned long invert, bool need_swab)
 {
@@ -68,9 +65,53 @@ unsigned long _find_next_bit(const unsigned long *addr1,
 
 	return min(start + __ffs(tmp), nbits);
 }
+
+#ifndef find_next_bit
+unsigned long _find_next_bit(const unsigned long *addr, unsigned long nbits, unsigned long start)
+{
+	return __find_next_bit(addr, NULL, nbits, start, 0UL, 0);
+}
 EXPORT_SYMBOL(_find_next_bit);
 #endif
 
+#ifndef find_next_and_bit
+unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long *addr2,
+					unsigned long nbits, unsigned long start)
+{
+	return __find_next_bit(addr1, addr2, nbits, start, 0UL, 0);
+}
+EXPORT_SYMBOL(_find_next_and_bit);
+#endif
+
+#ifndef find_next_zero_bit
+unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
+					 unsigned long start)
+{
+	return __find_next_bit(addr, NULL, nbits, start, ~0UL, 0);
+}
+EXPORT_SYMBOL(_find_next_zero_bit);
+#endif
+
+#ifdef __BIG_ENDIAN
+#ifndef find_next_zero_bit_le
+unsigned long _find_next_zero_bit_le(const void *addr, unsigned
+		long size, unsigned long offset)
+{
+	return __find_next_bit(addr, NULL, size, offset, ~0UL, 1);
+}
+EXPORT_SYMBOL(_find_next_zero_bit_le);
+#endif
+
+#ifndef find_next_bit_le
+unsigned long _find_next_bit_le(const void *addr, unsigned
+		long size, unsigned long offset)
+{
+	return __find_next_bit(addr, NULL, size, offset, 0UL, 1);
+}
+EXPORT_SYMBOL(_find_next_bit_le);
+#endif
+#endif /* __BIG_ENDIAN */
+
 #ifndef find_first_bit
 /*
  * Find the first set bit in a memory region.
-- 
2.34.1

