Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3E25690F5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbiGFRnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbiGFRnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:43:01 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4270828E1B;
        Wed,  6 Jul 2022 10:43:00 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id ay10so19264390qtb.1;
        Wed, 06 Jul 2022 10:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5abwFJX0caBzFF+Js6bgQ/JBYtg6GWcVuildYBtbAwo=;
        b=ltTH5T197YMI/ecIYBQHAB6Y/dPuvYwIG359XO4VA8V/0qN9c5mgWaKRYQ2MmSmZDV
         58xsW1LxjuQl3Zu+GUXlmHc0hwzEGylmN1ynMjYw23trwjNr0R6Ph+Busm4f3W+cNSEm
         PhUJiWuI4pwB1U3ssx15sznLuRDjMV/+1NXx0NbIYAOdU6VwF3ITUBUgB1/uwRpZxsXs
         RDm0uv0WUTrd8oN2MHI7gLYhS2N1ZsxZut/8zhvpBEyAuudMTMO0PAFOx/I0llYGy9mU
         myMU2e5SAShjorTLAsH2FnYClZRAXzWH4zYPub5rDUVy/DB80AjmgoOsPMGhMs5kmeZB
         rT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5abwFJX0caBzFF+Js6bgQ/JBYtg6GWcVuildYBtbAwo=;
        b=U9UNk6TuQTIKjxNjOeJTzgTpjK8SF/9nqf5J+2LdbaVhhuuFqUlAitOKjOl/FLiMu8
         DWnGW9hVLn+9JuYNWKrrIYPMOuUupZ/5OjCyawWPcqD6vRt4iveGF7/NNqV+BZF54MlT
         i1yD5xTXctfHWZCroFZ7xctpqo1cWEIpTvTl5TNtd0nV0vW8TR+fpf6hPLOAAMGxPcFv
         qFkMtFFcviiEtk57KV2u/vd6HEyCIUqPRSV0zTL409ease4NgBNR9su/0eBjcuP9S4oM
         UXY8SJv4M1iE7qFJbk/STES8DR7dMHnavr8fX7f2HXvWSvN2l3tnNxTch3tgiy79/rVI
         Uqug==
X-Gm-Message-State: AJIora9O/VnOnq1b9blY7bDVaReOBVXE+ScrVBeOz9sNd5BZX4/xYK26
        +kgAAup+tiqa4S7dGeKnl7JMwBYKNJCu3A==
X-Google-Smtp-Source: AGRyM1uiW459RTrDDsQ0Rz+OFcqJZKsphMfYnHKnl+HUE2gKmt6T0bnFwtG84dHyfM3e2aXVWguMFw==
X-Received: by 2002:ac8:5f51:0:b0:31d:2909:bf56 with SMTP id y17-20020ac85f51000000b0031d2909bf56mr32919215qta.73.1657129379169;
        Wed, 06 Jul 2022 10:42:59 -0700 (PDT)
Received: from localhost (c-69-254-185-160.hsd1.fl.comcast.net. [69.254.185.160])
        by smtp.gmail.com with ESMTPSA id w11-20020a05622a190b00b003162a22f8f4sm21195911qtc.49.2022.07.06.10.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 10:42:58 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
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
Subject: [PATCH 02/10] lib/bitmap: change return types to bool where appropriate
Date:   Wed,  6 Jul 2022 10:42:45 -0700
Message-Id: <20220706174253.4175492-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706174253.4175492-1-yury.norov@gmail.com>
References: <20220706174253.4175492-1-yury.norov@gmail.com>
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
index 2e6cd5681040..85aace699b2b 100644
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
@@ -303,7 +303,7 @@ void bitmap_to_arr64(u64 *buf, const unsigned long *bitmap, unsigned int nbits);
 	bitmap_copy_clear_tail((unsigned long *)(buf), (const unsigned long *)(bitmap), (nbits))
 #endif
 
-static inline int bitmap_and(unsigned long *dst, const unsigned long *src1,
+static inline bool bitmap_and(unsigned long *dst, const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
@@ -329,7 +329,7 @@ static inline void bitmap_xor(unsigned long *dst, const unsigned long *src1,
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

