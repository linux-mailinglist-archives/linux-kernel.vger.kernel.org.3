Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216EF5A2C2E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 18:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344532AbiHZQVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 12:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245347AbiHZQV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 12:21:29 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543ACDD77F
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 09:21:28 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id io24so2002463plb.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 09:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3YS87apsAp4Y8ljTYzQ8qPu+YHJ1Qj3bERhNEEJVHos=;
        b=ITT4B7jasJMljb2ZZCJ2mYxIX9VOgUtMM7xym8gR2YY17zvIj17RoXZsUrh5QPiLfR
         r5RJAaWklQKWvJTi9KZIsdjD9g5V9GluUOply8k85jnjy+z7zset9bKVtgmArYv8TBE1
         ZfEyjqhUcfSZjOYowJ+ctKMG9ZgRgjmyUXUsb8SoboBYlmOshEuwwxGTC0pzwljqtQSQ
         zs4+tkFGyK7E2rLLomETbPqYGdvFTWU2GTnkMe3O0HOnCbSB75Y1VYCLUjr9AaN8Xx6u
         dLASgZuy2Ru5ZhA/9+b5zJ8Ib8uYzRCwWC0w2ODBRrEcRmXd0H1BJF4XdVoZm3HXMLNr
         yaXw==
X-Gm-Message-State: ACgBeo2QAqCbWKKTfNHvr3r3V6HpsCy2VCclDCWThO3CCZLuHMLP/Uit
        AbZCetGlLUl8n+ZXWpuCjYI=
X-Google-Smtp-Source: AA6agR6CuwTBZT+7zVX1i5llqvpThok7e1DrFg4PvSjXrDy+GwEs1wAcX2EuWNyESt9ChuXZvvywow==
X-Received: by 2002:a17:90b:4b4e:b0:1fb:3c38:28ea with SMTP id mi14-20020a17090b4b4e00b001fb3c3828eamr5265977pjb.131.1661530887732;
        Fri, 26 Aug 2022 09:21:27 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:a12:b4b9:f1b3:ec63])
        by smtp.gmail.com with ESMTPSA id cp7-20020a170902e78700b0016ee328fd61sm1790077plb.198.2022.08.26.09.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 09:21:26 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Isabella Basso <isabbasso@riseup.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sander Vanheule <sander@svanheule.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 1/2] testing/selftests: Add tests for the is_signed_type() macro
Date:   Fri, 26 Aug 2022 09:21:15 -0700
Message-Id: <20220826162116.1050972-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
In-Reply-To: <20220826162116.1050972-1-bvanassche@acm.org>
References: <20220826162116.1050972-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although not documented, is_signed_type() must support the 'bool' and
pointer types next to scalar and enumeration types. Add a selftest that
verifies that this macro handles all supported types correctly.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Isabella Basso <isabbasso@riseup.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Sander Vanheule <sander@svanheule.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 lib/Kconfig.debug         | 12 ++++++++++
 lib/Makefile              |  1 +
 lib/is_signed_type_test.c | 48 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)
 create mode 100644 lib/is_signed_type_test.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 072e4b289c13..36455953d306 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2506,6 +2506,18 @@ config MEMCPY_KUNIT_TEST
 
 	  If unsure, say N.
 
+config IS_SIGNED_TYPE_KUNIT_TEST
+	tristate "Test is_signed_type() macro" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Builds unit tests for the is_signed_type() macro.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config OVERFLOW_KUNIT_TEST
 	tristate "Test check_*_overflow() functions at runtime" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/Makefile b/lib/Makefile
index 5927d7fa0806..70176ff17023 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -377,6 +377,7 @@ obj-$(CONFIG_BITS_TEST) += test_bits.o
 obj-$(CONFIG_CMDLINE_KUNIT_TEST) += cmdline_kunit.o
 obj-$(CONFIG_SLUB_KUNIT_TEST) += slub_kunit.o
 obj-$(CONFIG_MEMCPY_KUNIT_TEST) += memcpy_kunit.o
+obj-$(CONFIG_IS_SIGNED_TYPE_KUNIT_TEST) += is_signed_type_test.o
 obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
 CFLAGS_stackinit_kunit.o += $(call cc-disable-warning, switch-unreachable)
 obj-$(CONFIG_STACKINIT_KUNIT_TEST) += stackinit_kunit.o
diff --git a/lib/is_signed_type_test.c b/lib/is_signed_type_test.c
new file mode 100644
index 000000000000..f2eedb1f0935
--- /dev/null
+++ b/lib/is_signed_type_test.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ *	./tools/testing/kunit/kunit.py run is_signed_type [--raw_output]
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <kunit/test.h>
+#include <linux/overflow.h>
+
+enum unsigned_enum {
+	constant_a = 3,
+};
+
+enum signed_enum {
+	constant_b = -1,
+	constant_c = 2,
+};
+
+static void is_signed_type_test(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, is_signed_type(bool), false);
+	KUNIT_EXPECT_EQ(test, is_signed_type(signed char), true);
+	KUNIT_EXPECT_EQ(test, is_signed_type(unsigned char), false);
+	KUNIT_EXPECT_EQ(test, is_signed_type(int), true);
+	KUNIT_EXPECT_EQ(test, is_signed_type(unsigned int), false);
+	KUNIT_EXPECT_EQ(test, is_signed_type(long), true);
+	KUNIT_EXPECT_EQ(test, is_signed_type(unsigned long), false);
+	KUNIT_EXPECT_EQ(test, is_signed_type(long long), true);
+	KUNIT_EXPECT_EQ(test, is_signed_type(unsigned long long), false);
+	KUNIT_EXPECT_EQ(test, is_signed_type(enum unsigned_enum), false);
+	KUNIT_EXPECT_EQ(test, is_signed_type(enum signed_enum), true);
+	KUNIT_EXPECT_EQ(test, is_signed_type(void *), false);
+	KUNIT_EXPECT_EQ(test, is_signed_type(const char *), false);
+}
+
+static struct kunit_case is_signed_type_test_cases[] = {
+	KUNIT_CASE(is_signed_type_test),
+	{}
+};
+
+static struct kunit_suite is_signed_type_test_suite = {
+	.name = "is_signed_type",
+	.test_cases = is_signed_type_test_cases,
+};
+
+kunit_test_suite(is_signed_type_test_suite);
+
+MODULE_LICENSE("Dual MIT/GPL");
