Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859CE5633C6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbiGAMyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbiGAMyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:54:38 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFEA3AA6E;
        Fri,  1 Jul 2022 05:54:37 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 2so4111499qvc.0;
        Fri, 01 Jul 2022 05:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vcZ9IMTaOqkxdyfCjqfZoc5pipVgnj1uZgmjXpXjxXo=;
        b=MIbxf/AkrtszEsa9jwgJ+FBpjjCJTNrkkTmzCctS6xyBkwm4Q2KzOuzkbfogs1W+Y8
         XDcm4XeaDC9IgPImDcHWCvrwPj9rTY7Li8xzNp4FewM129x6Pe8vo1O50vqFJ/8nQqgJ
         JfxtRVty/NNzUWMtkRPLAysbJSnkeNSLTEwldAe0v2+/RoDPliZzIbGo5tz+HMg/os+U
         9/UdT8ZWWGq6acs0grD8wcuIIn+JPgmfSuPW9yoku90hsq43TH1kzly72U/vRpXEKfjF
         CN2Afq2X/CZv6lFmBDhB8XZfnuyNeRs8TCXkq1xAPDuIlldq8qZ5BIKBQP17/0G9wnUw
         Kxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vcZ9IMTaOqkxdyfCjqfZoc5pipVgnj1uZgmjXpXjxXo=;
        b=WwpmzsjGbdssnMRD7E8tgT+5yG7ND/2MpT+qca0cbnwhVpTi1uV90GGJmocaHcGMjm
         NXGcDqewdym5rVB2RC1MVZytnai++IrWfoICG2jLCHaPzi+oF+1WE64M/Kvko0yBBX5h
         zDxv+btg250tM94QQmBQDWEaswtFPQRT+DvkFPBM3jgk+4t6cfvOgCPuOZ5RUNF8raQ4
         j6q68K1czcOm3aq3bbtc23NJ55mop2fqf6ToXBCSOsJtOg8qHSgmEDvJLyTbxBA1ZtW9
         roSW2ZYR9Q71a0vmb8g8J+4Whi2r5VLl3Xp5UIrphxYCZ+rb7Mn9sHWyv+12eH6kNt3r
         a9rA==
X-Gm-Message-State: AJIora+oKnYh/FsP22jHXjKq2RsNSUprqabBP3OhNJEUPJs8HA/ITH9f
        5bF7u+5zh03/+nB6IwJ4mrTl8Tf3PQQ=
X-Google-Smtp-Source: AGRyM1tUpJPl6Ofj1q7B41Pz9FBj1f2+HMj07APgkUwGw7tsC0f7aZQK0JOtfdaIa2epzKhH51jp4w==
X-Received: by 2002:ad4:5be8:0:b0:472:91e6:a36c with SMTP id k8-20020ad45be8000000b0047291e6a36cmr14554359qvc.106.1656680076445;
        Fri, 01 Jul 2022 05:54:36 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:f902:9816:653f:2f66])
        by smtp.gmail.com with ESMTPSA id a20-20020a05620a16d400b0069fe1dfbeffsm17518253qkn.92.2022.07.01.05.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 05:54:36 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 2/8] lib/bitmap: change return types to bool where appropriate
Date:   Fri,  1 Jul 2022 05:54:24 -0700
Message-Id: <20220701125430.2907638-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220701125430.2907638-1-yury.norov@gmail.com>
References: <20220701125430.2907638-1-yury.norov@gmail.com>
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

Some bitmap functions return boolean results in int variables. Fix it
by changing return types to bool.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitmap.h       | 8 ++++----
 lib/bitmap.c                 | 4 ++--
 tools/include/linux/bitmap.h | 8 ++++----
 tools/lib/bitmap.c           | 2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index c91638e507f2..e1a438bdda52 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -148,13 +148,13 @@ void __bitmap_shift_left(unsigned long *dst, const unsigned long *src,
 			 unsigned int shift, unsigned int nbits);
 void bitmap_cut(unsigned long *dst, const unsigned long *src,
 		unsigned int first, unsigned int cut, unsigned int nbits);
-int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
+bool __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 		 const unsigned long *bitmap2, unsigned int nbits);
 void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
 		 const unsigned long *bitmap2, unsigned int nbits);
 void __bitmap_xor(unsigned long *dst, const unsigned long *bitmap1,
 		  const unsigned long *bitmap2, unsigned int nbits);
-int __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
+bool __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
 		    const unsigned long *bitmap2, unsigned int nbits);
 void __bitmap_replace(unsigned long *dst,
 		      const unsigned long *old, const unsigned long *new,
@@ -315,7 +315,7 @@ void bitmap_to_arr64(u64 *buf, const unsigned long *bitmap, unsigned int nbits);
 	bitmap_copy_clear_tail((unsigned long *)(buf), (const unsigned long *)(bitmap), (nbits))
 #endif
 
-static inline int bitmap_and(unsigned long *dst, const unsigned long *src1,
+static inline bool bitmap_and(unsigned long *dst, const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
@@ -341,7 +341,7 @@ static inline void bitmap_xor(unsigned long *dst, const unsigned long *src1,
 		__bitmap_xor(dst, src1, src2, nbits);
 }
 
-static inline int bitmap_andnot(unsigned long *dst, const unsigned long *src1,
+static inline bool bitmap_andnot(unsigned long *dst, const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
diff --git a/lib/bitmap.c b/lib/bitmap.c
index b18e31ea6e66..098fd9db2363 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -237,7 +237,7 @@ void bitmap_cut(unsigned long *dst, const unsigned long *src,
 }
 EXPORT_SYMBOL(bitmap_cut);
 
-int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
+bool __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 				const unsigned long *bitmap2, unsigned int bits)
 {
 	unsigned int k;
@@ -275,7 +275,7 @@ void __bitmap_xor(unsigned long *dst, const unsigned long *bitmap1,
 }
 EXPORT_SYMBOL(__bitmap_xor);
 
-int __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
+bool __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
 				const unsigned long *bitmap2, unsigned int bits)
 {
 	unsigned int k;
diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index afdf93bebaaf..2ae7ab8ed7d1 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -14,7 +14,7 @@
 int __bitmap_weight(const unsigned long *bitmap, int bits);
 void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
 		 const unsigned long *bitmap2, int bits);
-int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
+bool __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 		 const unsigned long *bitmap2, unsigned int bits);
 bool __bitmap_equal(const unsigned long *bitmap1,
 		    const unsigned long *bitmap2, unsigned int bits);
@@ -45,7 +45,7 @@ static inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
 	dst[nlongs - 1] = BITMAP_LAST_WORD_MASK(nbits);
 }
 
-static inline int bitmap_empty(const unsigned long *src, unsigned nbits)
+static inline bool bitmap_empty(const unsigned long *src, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		return ! (*src & BITMAP_LAST_WORD_MASK(nbits));
@@ -53,7 +53,7 @@ static inline int bitmap_empty(const unsigned long *src, unsigned nbits)
 	return find_first_bit(src, nbits) == nbits;
 }
 
-static inline int bitmap_full(const unsigned long *src, unsigned int nbits)
+static inline bool bitmap_full(const unsigned long *src, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		return ! (~(*src) & BITMAP_LAST_WORD_MASK(nbits));
@@ -146,7 +146,7 @@ size_t bitmap_scnprintf(unsigned long *bitmap, unsigned int nbits,
  * @src2: operand 2
  * @nbits: size of bitmap
  */
-static inline int bitmap_and(unsigned long *dst, const unsigned long *src1,
+static inline bool bitmap_and(unsigned long *dst, const unsigned long *src1,
 			     const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
index 354f8cdc0880..2e351d63fdba 100644
--- a/tools/lib/bitmap.c
+++ b/tools/lib/bitmap.c
@@ -57,7 +57,7 @@ size_t bitmap_scnprintf(unsigned long *bitmap, unsigned int nbits,
 	return ret;
 }
 
-int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
+bool __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 		 const unsigned long *bitmap2, unsigned int bits)
 {
 	unsigned int k;
-- 
2.34.1

