Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B504159F0E2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 03:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbiHXB0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 21:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiHXB0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 21:26:32 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC0449B7A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 18:26:29 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id r6so2672129qtx.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 18:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=8TpItKaNGiv+p/ZpPVKOso+teMlIgl0VnPlpR/Jug0c=;
        b=g+y1a/5LicaFiP/CjdOi/SNaNDf0Q6cQnqKfZHVtfqMyjiXa9OdRYvwjIbwqJkcCQn
         DtEjlJ+a/Y9eWClsxIDJUHJjR3vSFbE2MyhAh2mgdvVdupBXV4Kc23tCPRzqpgy9E+EN
         GvmjBc67vvS2ztE13aMdc+S7G4ChMJNIWGF+eF9nTTJirl2f7zPPcdcSjevZKy7Zqou0
         U2xqMigXI24QvB9Tte8so/3a4QiyQ8do5ErwPx7coZwc1GqnsRpt1tjH0ctY0jtdHKWD
         lY11VJSg2of2uuu1YrQjGVEcBV1yzeQkOKQztq6x1s+LDdsMDilC5G9owcz12FhHctDQ
         cxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=8TpItKaNGiv+p/ZpPVKOso+teMlIgl0VnPlpR/Jug0c=;
        b=pUXndbd+qN2UEjos7AJRLrZN5ZpAKnW2185kSk3Y2P1TDZSN/ciCyRNLO/7BNS5Cl6
         Z3RlMTm6AREVb7wY4DAZkt9SGXiZsRd20ZFZm90aMsQk4/44CfhRXIBs+Oc1UQrd5Rkh
         XQW0/qle5K5J6BlYtwkZBYX2NnM72zevV9AXBK9M2Up9wdbVa1svSiEI6Hy/k5JXbx4v
         u+kHj1gCOJVmTKg/1lfQpS9DE+Pb9k5by7GC4mwyq+SJ9WOWLGqkrCVb61Psse+uekFT
         hj7m4P503z/yfddWvFEIlpkzrT3eRFnwwH+wBKL4uY/+yyOyp3WT1RsVZ0qeMUEuY2hI
         i48A==
X-Gm-Message-State: ACgBeo0SIgllE18utlwKH3HNF3QsLCGAwmNkjilSN1VDGXpS0WIHarB4
        kMxkVPzyyJXfZXhBzdqH79wuNok2Wv0=
X-Google-Smtp-Source: AA6agR7+7pItw8JEFNNFa/PvA7NliockfohTBIgKRKhWL3ybYgV2POlyLU47rY/X6rAW/WZu2oB0pA==
X-Received: by 2002:a05:622a:e:b0:344:9c6a:3616 with SMTP id x14-20020a05622a000e00b003449c6a3616mr18897335qtw.362.1661304388833;
        Tue, 23 Aug 2022 18:26:28 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:9de8:f9bd:9f64:5017])
        by smtp.gmail.com with ESMTPSA id cj20-20020a05622a259400b0034035e73be0sm12020291qtb.4.2022.08.23.18.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 18:26:28 -0700 (PDT)
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
Subject: [PATCH v2 2/3] lib/find_bit: create find_first_zero_bit_le()
Date:   Tue, 23 Aug 2022 18:26:23 -0700
Message-Id: <20220824012624.2826445-3-yury.norov@gmail.com>
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

find_first_zero_bit_le() is an alias to find_next_zero_bit_le(),
despite that 'next' is known to be slower than the 'first' version.

Now that we have a common FIND_FIRST_BIT() macro helper, it's trivial
to implement find_first_zero_bit_le() as a real function.

Moving find_*_le() to a separate file helps to fit the FIND_FIRST_BIT()
to the _le needs by wiring word_op to swab.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
Like other find_*_le() functions, the new one takes void *addr, instead
of unsigned long *. This should be fixed for all in a separate series.

 MAINTAINERS          |  1 +
 include/linux/find.h | 23 ++++++++++++++++++-----
 lib/Makefile         |  1 +
 lib/find_bit_be.c    | 23 +++++++++++++++++++++++
 4 files changed, 43 insertions(+), 5 deletions(-)
 create mode 100644 lib/find_bit_be.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 02e11f2dbafe..fd1d1625b053 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3614,6 +3614,7 @@ F:	lib/bitmap.c
 F:	lib/cpumask.c
 F:	lib/find_bit.h
 F:	lib/find_bit.c
+F:	lib/find_bit_le.c
 F:	lib/find_bit_benchmark.c
 F:	lib/test_bitmap.c
 F:	tools/include/linux/bitmap.h
diff --git a/include/linux/find.h b/include/linux/find.h
index 424ef67d4a42..2464bff5de04 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -17,6 +17,10 @@ extern unsigned long _find_first_and_bit(const unsigned long *addr1,
 extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
 extern unsigned long _find_last_bit(const unsigned long *addr, unsigned long size);
 
+#ifdef __BIG_ENDIAN
+unsigned long _find_first_zero_bit_le(const unsigned long *addr, unsigned long size);
+#endif
+
 #ifndef find_next_bit
 /**
  * find_next_bit - find the next set bit in a memory region
@@ -251,6 +255,20 @@ unsigned long find_next_zero_bit_le(const void *addr, unsigned
 }
 #endif
 
+#ifndef find_first_zero_bit_le
+static inline
+unsigned long find_first_zero_bit_le(const void *addr, unsigned long size)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val = swab(*(const unsigned long *)addr) | ~GENMASK(size - 1, 0);
+
+		return val == ~0UL ? size : ffz(val);
+	}
+
+	return _find_first_zero_bit_le(addr, size);
+}
+#endif
+
 #ifndef find_next_bit_le
 static inline
 unsigned long find_next_bit_le(const void *addr, unsigned
@@ -270,11 +288,6 @@ unsigned long find_next_bit_le(const void *addr, unsigned
 }
 #endif
 
-#ifndef find_first_zero_bit_le
-#define find_first_zero_bit_le(addr, size) \
-	find_next_zero_bit_le((addr), (size), 0)
-#endif
-
 #else
 #error "Please fix <asm/byteorder.h>"
 #endif
diff --git a/lib/Makefile b/lib/Makefile
index 5927d7fa0806..0f41b76a277e 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -49,6 +49,7 @@ obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
 	 percpu-refcount.o rhashtable.o base64.o \
 	 once.o refcount.o usercopy.o errseq.o bucket_locks.o \
 	 generic-radix-tree.o
+obj-$(CONFIG_CPU_BIG_ENDIAN) += find_bit_be.o
 obj-$(CONFIG_STRING_SELFTEST) += test_string.o
 obj-y += string_helpers.o
 obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
diff --git a/lib/find_bit_be.c b/lib/find_bit_be.c
new file mode 100644
index 000000000000..36173cb7e012
--- /dev/null
+++ b/lib/find_bit_be.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Big-endian routines for bit search */
+
+#include <linux/bitops.h>
+#include <linux/bitmap.h>
+#include <linux/export.h>
+#include <linux/math.h>
+#include <linux/minmax.h>
+#include <linux/swab.h>
+
+#define word_op swab
+#include "find_bit.h"
+
+#ifndef find_first_zero_bit_le
+/*
+ * Find the first cleared bit in an LE memory region.
+ */
+unsigned long _find_first_zero_bit_le(const unsigned long *addr, unsigned long size)
+{
+	return FIND_FIRST_BIT(~addr[idx], size);
+}
+EXPORT_SYMBOL(_find_first_zero_bit_le);
+#endif
-- 
2.34.1

