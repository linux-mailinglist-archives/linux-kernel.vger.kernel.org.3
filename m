Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6545633C8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbiGAMyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235436AbiGAMyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:54:39 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927863A720;
        Fri,  1 Jul 2022 05:54:38 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id z1so3980703qvp.9;
        Fri, 01 Jul 2022 05:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uv5+jKOQ8RUlLeEtR603JL5t9bPUgBYvDDCEsdLilng=;
        b=DgrFX41S4QAnDhT+O9vofHz+UIzBaHWOfvdam2kbZOA/1GRVDNK5IkINeLwZn4Qwyo
         i5lxfRi5K04xatGBzVFP6eULZBSSuLdIm+hnD8UbTVvvNg33Trn0cE+gjphOs/JMEAnP
         MvJGmPsNt7jsEca163rXibGFlry4EFCQ7js++wTpT6cJLtKjCx6NhhOvErjtu3kYYsoI
         YhoWfiXbPT9JyQOxW2t006onbU3EJfL5zDRDzzSQ3s+oPCRCEOgyUn5ueAiO3JOoNEWa
         NfzURxmFovE91+1o/yk2iVGrVb0XRcoK/YNio84yQ0rPOgpr3FZNuraqzSCDpx0dyNQ0
         LAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uv5+jKOQ8RUlLeEtR603JL5t9bPUgBYvDDCEsdLilng=;
        b=oJj88T/87DVo1URetj0NxKmxPWKjRyF9gD0vWe6/phbNsVPfaGOKGgNHm6PVcYMQd9
         gi9PQBmgBzsm9w2U4rUkwkZQOO4rhtlTA071HWt67i3a0RW1+Y13HEARPGQHziykbFSa
         bpVO5rhHQTEcald3kHfDhxkEFdoEhBP+OkNDUBzMy09uD1khIDFExNJyKKSL+N3fgb2m
         N3rY5SrpkS8SVgCTEJGKi0TmKuqsmyW7hNzLZXH3bShrpQrb997l2QuKGa28TrMfqcIN
         yjmj7I3CHikcBGWwFF0DOS1s/2joFMJO356kfPXHkcsjGqyhJPiJOMIItUuHrCGPBreY
         VW8g==
X-Gm-Message-State: AJIora/y5EKWtvkDJw0PtKrwngAgIugdPb95tOOaybJ0TVFSdJaPaLIm
        QCKMOju+q7Rd7Nn23qfT1Wk11KYo3Es=
X-Google-Smtp-Source: AGRyM1u+eUVgVfIOLTb/JNzScesZqkE4s8uOoTxS28xuW8AF0r5ZqYbr8PsjBESSvR+hO6k9B4oRhg==
X-Received: by 2002:a0c:e1c6:0:b0:472:d7d0:8e2 with SMTP id v6-20020a0ce1c6000000b00472d7d008e2mr508550qvl.39.1656680077510;
        Fri, 01 Jul 2022 05:54:37 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:f902:9816:653f:2f66])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a254a00b006a6d74f8fc9sm19217194qko.127.2022.07.01.05.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 05:54:37 -0700 (PDT)
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
Subject: [PATCH 3/8] lib/bitmap: change type of bitmap_weight to unsigned int
Date:   Fri,  1 Jul 2022 05:54:25 -0700
Message-Id: <20220701125430.2907638-4-yury.norov@gmail.com>
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

bitmap_weight() doesn't return negative values, so change it's type
to unsigned int. It may help compiler to generate better code and
catch bugs.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitmap.h       | 2 +-
 lib/bitmap.c                 | 5 ++---
 tools/include/linux/bitmap.h | 4 ++--
 tools/lib/bitmap.c           | 4 ++--
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index e1a438bdda52..812835d3149a 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -163,7 +163,7 @@ bool __bitmap_intersects(const unsigned long *bitmap1,
 			 const unsigned long *bitmap2, unsigned int nbits);
 bool __bitmap_subset(const unsigned long *bitmap1,
 		     const unsigned long *bitmap2, unsigned int nbits);
-int __bitmap_weight(const unsigned long *bitmap, unsigned int nbits);
+unsigned long __bitmap_weight(const unsigned long *bitmap, unsigned int nbits);
 void __bitmap_set(unsigned long *map, unsigned int start, int len);
 void __bitmap_clear(unsigned long *map, unsigned int start, int len);
 
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 098fd9db2363..b580b381eca1 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -333,10 +333,9 @@ bool __bitmap_subset(const unsigned long *bitmap1,
 }
 EXPORT_SYMBOL(__bitmap_subset);
 
-int __bitmap_weight(const unsigned long *bitmap, unsigned int bits)
+unsigned long __bitmap_weight(const unsigned long *bitmap, unsigned int bits)
 {
-	unsigned int k, lim = bits/BITS_PER_LONG;
-	int w = 0;
+	unsigned long k, w = 0, lim = bits/BITS_PER_LONG;
 
 	for (k = 0; k < lim; k++)
 		w += hweight_long(bitmap[k]);
diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index 2ae7ab8ed7d1..c9c24dfe0443 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -11,7 +11,7 @@
 #define DECLARE_BITMAP(name,bits) \
 	unsigned long name[BITS_TO_LONGS(bits)]
 
-int __bitmap_weight(const unsigned long *bitmap, int bits);
+unsigned int __bitmap_weight(const unsigned long *bitmap, unsigned int bits);
 void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
 		 const unsigned long *bitmap2, int bits);
 bool __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
@@ -61,7 +61,7 @@ static inline bool bitmap_full(const unsigned long *src, unsigned int nbits)
 	return find_first_zero_bit(src, nbits) == nbits;
 }
 
-static inline int bitmap_weight(const unsigned long *src, unsigned int nbits)
+static inline unsigned int bitmap_weight(const unsigned long *src, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		return hweight_long(*src & BITMAP_LAST_WORD_MASK(nbits));
diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
index 2e351d63fdba..974e51809f57 100644
--- a/tools/lib/bitmap.c
+++ b/tools/lib/bitmap.c
@@ -5,9 +5,9 @@
  */
 #include <linux/bitmap.h>
 
-int __bitmap_weight(const unsigned long *bitmap, int bits)
+unsigned int __bitmap_weight(const unsigned long *bitmap, unsigned int bits)
 {
-	int k, w = 0, lim = bits/BITS_PER_LONG;
+	unsigned int k, w = 0, lim = bits/BITS_PER_LONG;
 
 	for (k = 0; k < lim; k++)
 		w += hweight_long(bitmap[k]);
-- 
2.34.1

