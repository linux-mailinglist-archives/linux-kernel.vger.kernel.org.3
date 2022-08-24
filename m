Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B2659F0E0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 03:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbiHXB0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 21:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbiHXB0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 21:26:30 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC076E2C3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 18:26:28 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id p5so10320954qvz.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 18:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Oigqp5pJzLdjQPAyXKhULe34ZLTEqQfezSKQBfA2gB4=;
        b=Tb4ncvv3AUDaXk/d+L576llEF4J0s2Pso9FOYK3FeXEwqJ2o926kzbiv69HSEzuDuE
         KFG8KX/lf67x1XFobrXhONgAdnXv5zbJOSOjtzLFb5Kv3Siw3MKj2oeaIJ0wNynYxLRO
         ljZAlv5OkaBNAI9EIAzgIlpWRSnaAJqZt74scjY+HS5sERtXhVwu55KbFuYCfSZbAobY
         8pcY6H4ciX/s4/h6JeZTmSJAqHfd1z3KldEHkVLcHLVrJJiCTT/m+qXXVz1lQUJzBJcb
         2uNUaTXkvzUtfV3i6JFuABoWzSSgyx5JCHDWQ0UnTcFZJFtyyrfQ9W3K6MzHb3VwGDYE
         1oyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Oigqp5pJzLdjQPAyXKhULe34ZLTEqQfezSKQBfA2gB4=;
        b=L3qpFWNN44k0Bm4MRjCiqXUWeGqsZ0ugPRVdhES/C3nkEvOnrFP5KRLRykd2suV3oK
         uSVLJ1wCTmJqX2lpnovypvAK/u9AUjmfSfGioIVpRvonl1UkYh/GPZs+RuKl+WnEUZZx
         yk+Aoz6/0czu5xafI9EcizCbCHokSxU/vfF4ovVedUSYYdygfjQAp1vRH3Kj/UlSMMyB
         w7gXGblkOmCzp2pCrtncldAwDIMM6xu75HZQ7W1z+UiMyXoFaUaSIzcYhrH3TEUzR5ce
         sscciyM5atGSI3iHGFwaiYPDX+d/MJ45xr0LYcFytvTjfzewNB55ekbIKYKUuib7LPUj
         kfbw==
X-Gm-Message-State: ACgBeo0wSlwSITVWmhb0mFA3KIdGUpvE5B8qqEI2LAXrtV8QsIL8VltP
        hD0KzZsz06ewVfySZehf5v4=
X-Google-Smtp-Source: AA6agR4ikmJBmwnkWbKJOC0JwG8Tj/bnce1Bi2xMrYxpcseGH6JAZt6f1LelhCHRztI9N+4QfD7AAA==
X-Received: by 2002:a0c:fbd1:0:b0:496:df38:d010 with SMTP id n17-20020a0cfbd1000000b00496df38d010mr11485413qvp.75.1661304387857;
        Tue, 23 Aug 2022 18:26:27 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:9de8:f9bd:9f64:5017])
        by smtp.gmail.com with ESMTPSA id v16-20020a05620a0f1000b006bbd2c4cccfsm12491246qkl.53.2022.08.23.18.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 18:26:27 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Dennis Zhou <dennis@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexey Klimov <aklimov@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Whitcroft <apw@canonical.com>
Subject: [PATCH v2 1/3] lib/find_bit: introduce FIND_FIRST_BIT() macro
Date:   Tue, 23 Aug 2022 18:26:22 -0700
Message-Id: <20220824012624.2826445-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220824012624.2826445-1-yury.norov@gmail.com>
References: <20220824012624.2826445-1-yury.norov@gmail.com>
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

Now that we have many flavors of find_first_bit(), and expect even more,
it's better to have one macro that generates optimal code for all and makes
maintaining of slightly different functions simpler.

The logic common to all versions is moved to the new macro, and all the
flavors are generated by providing an EXPRESSION macro-parameter, like
in this example:

  #define FIND_FIRST_BIT(EXPRESSION, size) ...
  
  find_first_ornot_and_bit(addr1, addr2, addr3, size)
  {
  	return FIND_NEXT_BIT(addr1[idx] | ~addr2[idx] & addr3[idx], size);
  }

The EXPRESSION may be of any complexity, as soon as it only refers
the bitmap(s) and an iterator idx.

The 'word_op' is here to allow the macro to generate code for _le
versions on big-endian machines; used in the following patches.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 MAINTAINERS    |  1 +
 lib/find_bit.c | 30 +++++-------------------------
 lib/find_bit.h | 24 ++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 25 deletions(-)
 create mode 100644 lib/find_bit.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 96f47a7865d6..02e11f2dbafe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3612,6 +3612,7 @@ F:	include/linux/find.h
 F:	include/linux/nodemask.h
 F:	lib/bitmap.c
 F:	lib/cpumask.c
+F:	lib/find_bit.h
 F:	lib/find_bit.c
 F:	lib/find_bit_benchmark.c
 F:	lib/test_bitmap.c
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 1b8e4b2a9cba..ccc4fb1dfc71 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -19,6 +19,8 @@
 #include <linux/minmax.h>
 #include <linux/swab.h>
 
+#include "find_bit.h"
+
 #if !defined(find_next_bit) || !defined(find_next_zero_bit) ||			\
 	!defined(find_next_bit_le) || !defined(find_next_zero_bit_le) ||	\
 	!defined(find_next_and_bit)
@@ -77,14 +79,7 @@ EXPORT_SYMBOL(_find_next_bit);
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
+	return FIND_FIRST_BIT(addr[idx], size);
 }
 EXPORT_SYMBOL(_find_first_bit);
 #endif
@@ -97,15 +92,7 @@ unsigned long _find_first_and_bit(const unsigned long *addr1,
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
+	return FIND_FIRST_BIT(addr1[idx] & addr2[idx], size);
 }
 EXPORT_SYMBOL(_find_first_and_bit);
 #endif
@@ -116,14 +103,7 @@ EXPORT_SYMBOL(_find_first_and_bit);
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
+	return FIND_FIRST_BIT(~addr[idx], size);
 }
 EXPORT_SYMBOL(_find_first_zero_bit);
 #endif
diff --git a/lib/find_bit.h b/lib/find_bit.h
new file mode 100644
index 000000000000..b4b6245ddbf6
--- /dev/null
+++ b/lib/find_bit.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _LIB_FIND_BIT_H
+#define _LIB_FIND_BIT_H
+
+#ifndef word_op
+#define word_op
+#endif
+
+#define FIND_FIRST_BIT(EXPRESSION, size)					\
+({										\
+	unsigned long idx, val, sz = (size);					\
+										\
+	for (idx = 0; idx * BITS_PER_LONG < sz; idx++) {			\
+		val = (EXPRESSION);						\
+		if (val) {							\
+			sz = min(idx * BITS_PER_LONG + __ffs(word_op(val)), sz);\
+			break;							\
+		}								\
+	}									\
+										\
+	sz;									\
+})
+
+#endif /* _LIB_FIND_BIT_H */
-- 
2.34.1

