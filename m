Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A8552AD76
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 23:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbiEQVWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 17:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiEQVWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 17:22:38 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565F63EB93
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:22:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o13-20020a17090a9f8d00b001df3fc52ea7so3704598pjp.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uepQWFj4p9vvzxFu0J6TcubCn573rdrWQyzAe1PX5G0=;
        b=Dy8WRIdSNRo8VedfCaJuzfBJKdEveNueIl6h1m5H7A7GpqO1VFIRFp3xhZUt4FRFO2
         W3chIK/93Xpm3hii/SpKvczGW2Df+zSEX9NG0JxKOF5ehz9I6/07cUIMW8Itr/trzr0M
         cwelbmHTgyV63Lvehq8qPp3YvsYj2q4YKkG94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uepQWFj4p9vvzxFu0J6TcubCn573rdrWQyzAe1PX5G0=;
        b=q/50pK2fIwM0UghRy/eTB/StQq+OtfKs+hKyfgukrAdqRU/qJ45J0RYIPRIsc6lYVY
         5g5+1m474D4Sczf29mpGQwIewX++yrrvbfZyZB5QghEQE6lLFa0InGk/w3zuuBZ9gmov
         EF2OlWqb0O2SGBQdvVBfXwatm//YU4VDOb8FE0tGogHJEliEMcc3mCqvYFz9rnylhlfu
         Q8G5kveoyKWUKNcb1HGJ11L1tXBrBnV2e04C+Am62hovnL/PlbFAtXa/6WoJmlv5ei8y
         q8wyZiNJu6CcfNAjGk3Ti7c/G19iil9w30PgLUQmT8qH+B7L8pbpeiUVaQ1Xj6gye9ZQ
         clzQ==
X-Gm-Message-State: AOAM533Htn/0JNwICsurgPqWEE4LQmj7XpOpfizfzsp5MC1n+pP6V9p8
        9k8Feg76sNSqWEWmIsXfp7F0nfctji1RRw==
X-Google-Smtp-Source: ABdhPJweAH8JloCK5hClRf6c3ajBQArCtatGzkr3y/VhlYkSwTwIXhf6BZTUnYx7czoMf94YW2ba7w==
X-Received: by 2002:a17:902:e88b:b0:161:79f6:42a8 with SMTP id w11-20020a170902e88b00b0016179f642a8mr12134677plg.131.1652822556812;
        Tue, 17 May 2022 14:22:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c18-20020aa78c12000000b0051815121e2csm173244pfd.164.2022.05.17.14.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 14:22:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 1/2] bitmap: Fix return values to be unsigned
Date:   Tue, 17 May 2022 14:22:33 -0700
Message-Id: <20220517212234.868181-2-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220517212234.868181-1-keescook@chromium.org>
References: <20220517212234.868181-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4867; h=from:subject; bh=t1Ia3Wci2ZC0qKVzbH7/1fuiBHOoRUGjZ00k0amlW8s=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBihBIZqREFg+WTcBpL6MUHMvjMCQvDFYx6X+rk1V+U Gfh0dBCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYoQSGQAKCRCJcvTf3G3AJjViD/ 9f1ik1XrhV2v/KFyUIvCtGUo+ArmKp4K2jNlNf35LGXiM+8iSIjhSs1EN7JhqLROfHWaHn2dNq4cXt 8w94o/An4USxo2OoLLjf9mzQugXU5qTu8ydNHBa1LMsMHrMu0RAY3GvX0uSFXMIUsEJwnpCNG2U96/ KRDJ8AWORRxQ04h16NO1eoy9kkC11cSvlUu2/VpJ4VKNsaFRoFj5vQ9oGwkgAe1hpI5xh4NIGEX+/F MnvebF4T7rMmbVwCqytI3XZ1EPNdXTDgUASc171ttgbDa2c3LndKkScU7lMXUPMrfn7XD5ZrsoBXjZ n1spwQS2Hyx5VpayIt4Ic+xVZ824koHfdV4iis7NcL1LvIzfLM3QUl0or6OErw/OSnc3eHtgDeAhts jcbPOY4EQugpZZU6kRiLBAzscPqFgtXAVa91NFnJdn2mis/nzq2Cy0cMUHWSh+fABrhyseOzIocoFB /153hvmLGdAvqBC3ff6nimVTs5zsD+HjMD+z5+ZqTqkCKBIgSTs5nMgkM1x2jR4YIhc5io2fNmLBiD RTA95RLJOFULKni+cWDE8WBUWbI+mqKqUWBLUfopuf5nljGHYCx9mNiyzP+Qy9qlz1swYv+uRLIa7G Lj6M/LMxDxM4/BsptiJruOlV0VNsu1PgR6ZlkESQCSikTl56D57gVdLGFyoQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both nodemask and bitmap routines had mixed return values that provided
potentially signed return values that could never happen. This was
leading to the compiler getting confusing about the range of possible
return values (it was thinking things could be negative where they could
not be). In preparation for fixing nodemask, fix all the bitmap routines
that should be returning unsigned (or bool) values.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Christophe de Dinechin <dinechin@redhat.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/bitmap.h | 14 +++++++-------
 lib/bitmap.c           | 28 ++++++++++++++--------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 7dba0847510c..381735c2f2f1 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -132,8 +132,8 @@ unsigned long *devm_bitmap_zalloc(struct device *dev,
  * lib/bitmap.c provides these functions:
  */
 
-int __bitmap_equal(const unsigned long *bitmap1,
-		   const unsigned long *bitmap2, unsigned int nbits);
+bool __bitmap_equal(const unsigned long *bitmap1,
+		    const unsigned long *bitmap2, unsigned int nbits);
 bool __pure __bitmap_or_equal(const unsigned long *src1,
 			      const unsigned long *src2,
 			      const unsigned long *src3,
@@ -157,10 +157,10 @@ int __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
 void __bitmap_replace(unsigned long *dst,
 		      const unsigned long *old, const unsigned long *new,
 		      const unsigned long *mask, unsigned int nbits);
-int __bitmap_intersects(const unsigned long *bitmap1,
-			const unsigned long *bitmap2, unsigned int nbits);
-int __bitmap_subset(const unsigned long *bitmap1,
-		    const unsigned long *bitmap2, unsigned int nbits);
+bool __bitmap_intersects(const unsigned long *bitmap1,
+			 const unsigned long *bitmap2, unsigned int nbits);
+bool __bitmap_subset(const unsigned long *bitmap1,
+		     const unsigned long *bitmap2, unsigned int nbits);
 int __bitmap_weight(const unsigned long *bitmap, unsigned int nbits);
 void __bitmap_set(unsigned long *map, unsigned int start, int len);
 void __bitmap_clear(unsigned long *map, unsigned int start, int len);
@@ -331,7 +331,7 @@ static inline void bitmap_complement(unsigned long *dst, const unsigned long *sr
 #endif
 #define BITMAP_MEM_MASK (BITMAP_MEM_ALIGNMENT - 1)
 
-static inline int bitmap_equal(const unsigned long *src1,
+static inline bool bitmap_equal(const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 0d5c2ece0bcb..b57dafe13eec 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -45,19 +45,19 @@
  * for the best explanations of this ordering.
  */
 
-int __bitmap_equal(const unsigned long *bitmap1,
+bool __bitmap_equal(const unsigned long *bitmap1,
 		const unsigned long *bitmap2, unsigned int bits)
 {
 	unsigned int k, lim = bits/BITS_PER_LONG;
 	for (k = 0; k < lim; ++k)
 		if (bitmap1[k] != bitmap2[k])
-			return 0;
+			return false;
 
 	if (bits % BITS_PER_LONG)
 		if ((bitmap1[k] ^ bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
-			return 0;
+			return false;
 
-	return 1;
+	return true;
 }
 EXPORT_SYMBOL(__bitmap_equal);
 
@@ -303,33 +303,33 @@ void __bitmap_replace(unsigned long *dst,
 }
 EXPORT_SYMBOL(__bitmap_replace);
 
-int __bitmap_intersects(const unsigned long *bitmap1,
-			const unsigned long *bitmap2, unsigned int bits)
+bool __bitmap_intersects(const unsigned long *bitmap1,
+			 const unsigned long *bitmap2, unsigned int bits)
 {
 	unsigned int k, lim = bits/BITS_PER_LONG;
 	for (k = 0; k < lim; ++k)
 		if (bitmap1[k] & bitmap2[k])
-			return 1;
+			return true;
 
 	if (bits % BITS_PER_LONG)
 		if ((bitmap1[k] & bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
-			return 1;
-	return 0;
+			return true;
+	return false;
 }
 EXPORT_SYMBOL(__bitmap_intersects);
 
-int __bitmap_subset(const unsigned long *bitmap1,
-		    const unsigned long *bitmap2, unsigned int bits)
+bool __bitmap_subset(const unsigned long *bitmap1,
+		     const unsigned long *bitmap2, unsigned int bits)
 {
 	unsigned int k, lim = bits/BITS_PER_LONG;
 	for (k = 0; k < lim; ++k)
 		if (bitmap1[k] & ~bitmap2[k])
-			return 0;
+			return false;
 
 	if (bits % BITS_PER_LONG)
 		if ((bitmap1[k] & ~bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
-			return 0;
-	return 1;
+			return false;
+	return true;
 }
 EXPORT_SYMBOL(__bitmap_subset);
 
-- 
2.32.0

