Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13855690F4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbiGFRnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbiGFRnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:43:00 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044D624094;
        Wed,  6 Jul 2022 10:42:59 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id q16so19272896qtn.5;
        Wed, 06 Jul 2022 10:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TG2FjICzQ0xh3fVBpczYaWRTL00g/5rABwtqlLaAaqg=;
        b=GzcRM/QHMNCvt0LiOl4IDf7yACBLxgINtoKLQMKFSlpnzBvvXSjPGVi6Gs2POapvas
         ek5tLwY266CkygyASovGpUmsZd1oIDJi/QmUCCRDWiCpa9rqKv9c1Bx3xKK9++7eUYVz
         WDWUE02JCTwd5VAkaX7ytRJuxE4/sjKIk0eRpzWP4NzK8DMdzqip26NkDVIdPe6mkDR9
         QFB3WKM5zjBKgFiqkBKyAwOYhmseQHvV45qnEH4CDtevw68bG+MfUBPe9Y9q9QSgn7cL
         WYFhcJWvTEOQrHFGw8ziWB8EW18fWH8eblOzrb6Yx9CaPBQlzYM7amG8B2PkT17F/w+J
         jB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TG2FjICzQ0xh3fVBpczYaWRTL00g/5rABwtqlLaAaqg=;
        b=yHHY/g6lhJ5Q+NGhCREMpjv7dyTSSJ0WVjgB7vNBojbQcLiTibTHdYetjBp0EFG5s8
         Pzxx5s3tELEt8XqrS/qpIXTfMqkOH1JkQztk4ej6uMFBtmFl8wCiabN+jsZTisAMXsVV
         QthakMjNJwxM6A/hU4sr87hsoBUdd4Cwg0/zVw00Ts1fLFR3OEMml+JvgeQUbrNXlOJU
         FNsDjYvz8fn2JhBS7Mn/M76pnDfLx/YfOfepTwNpwOsQc2XJX53O2RvKKgYSSAulYDrx
         UjhZWop/LPbf5M4Aaxej2AALTygGgS7WCpz+HYRs6DYcWootAhIkoEBR5n8YbUZEpGbk
         yqzQ==
X-Gm-Message-State: AJIora+rcJ+P3jEKV0/tvgl9mkK6ozOauQwsUvkQ0fkZro1ZM4//EDh5
        rlYCii/azsvJfDgx9Jsjs+URiNQOopznzg==
X-Google-Smtp-Source: AGRyM1s333Xv6gpTJXmluiXObWwMdV2ybLffCIbKwNaD2x7UvScSwWF1yaI3o5Vabou8zRCSQJDVvA==
X-Received: by 2002:ac8:5956:0:b0:31d:28dc:17c with SMTP id 22-20020ac85956000000b0031d28dc017cmr31947503qtz.295.1657129377974;
        Wed, 06 Jul 2022 10:42:57 -0700 (PDT)
Received: from localhost (c-69-254-185-160.hsd1.ar.comcast.net. [69.254.185.160])
        by smtp.gmail.com with ESMTPSA id bq30-20020a05620a469e00b006a785ba0c25sm20860422qkb.77.2022.07.06.10.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 10:42:57 -0700 (PDT)
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
Subject: [PATCH 01/10] arm: align find_bit declarations with generic kernel
Date:   Wed,  6 Jul 2022 10:42:44 -0700
Message-Id: <20220706174253.4175492-2-yury.norov@gmail.com>
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

ARM has their own implementation for find_bit functions, and function
declarations are different with those in generic headers. Fix it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/arm/include/asm/bitops.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bitops.h
index 8e94fe7ab5eb..714440fa2fc6 100644
--- a/arch/arm/include/asm/bitops.h
+++ b/arch/arm/include/asm/bitops.h
@@ -160,18 +160,20 @@ extern int _test_and_change_bit(int nr, volatile unsigned long * p);
 /*
  * Little endian assembly bitops.  nr = 0 -> byte 0 bit 0.
  */
-extern int _find_first_zero_bit_le(const unsigned long *p, unsigned size);
-extern int _find_next_zero_bit_le(const unsigned long *p, int size, int offset);
-extern int _find_first_bit_le(const unsigned long *p, unsigned size);
-extern int _find_next_bit_le(const unsigned long *p, int size, int offset);
+unsigned long _find_first_zero_bit_le(const unsigned long *p, unsigned long size);
+unsigned long _find_next_zero_bit_le(const unsigned long *p,
+				     unsigned long size, unsigned long offset);
+unsigned long _find_first_bit_le(const unsigned long *p, unsigned long size);
+unsigned long _find_next_bit_le(const unsigned long *p, unsigned long size, unsigned long offset);
 
 /*
  * Big endian assembly bitops.  nr = 0 -> byte 3 bit 0.
  */
-extern int _find_first_zero_bit_be(const unsigned long *p, unsigned size);
-extern int _find_next_zero_bit_be(const unsigned long *p, int size, int offset);
-extern int _find_first_bit_be(const unsigned long *p, unsigned size);
-extern int _find_next_bit_be(const unsigned long *p, int size, int offset);
+unsigned long _find_first_zero_bit_be(const unsigned long *p, unsigned long size);
+unsigned long _find_next_zero_bit_be(const unsigned long *p,
+				     unsigned long size, unsigned long offset);
+unsigned long _find_first_bit_be(const unsigned long *p, unsigned long size);
+unsigned long _find_next_bit_be(const unsigned long *p, unsigned long size, unsigned long offset);
 
 #ifndef CONFIG_SMP
 /*
-- 
2.34.1

