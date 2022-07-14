Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B095741CA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 05:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiGNDSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 23:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbiGNDSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 23:18:01 -0400
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com [IPv6:2001:4860:4864:20::41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5673A25C7A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 20:17:44 -0700 (PDT)
Received: by mail-oa1-x41.google.com with SMTP id 586e51a60fabf-10c0052da61so944550fac.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 20:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eBM0WXJ+GgNxVQg6ZdsN14nxrV6tKpZUKkvsS9po9uk=;
        b=SfuBaOUHJo1YTYitIqTkgxosxnQFJ3Sr5clkO8THngRd+UKJ5N+13sGLRk84USdd23
         ZBqe9Llb8rYjWbFffUZ2p/syvMvUJpKtZOb/QqXmFyBAEreQBqYrbZO9U951poUWRsU+
         x/Fl/ZyjPzeEEf6gZudsX9ZIuQD8TYT9rtxT9FtQG86A3RTuK09C+oEgy8R6XGzlz10H
         a+jL8ZGmU61hB0a8O4CcgK9FjRztisg/OsIvnBX47JaR64KRKibo4c7eDszuHBikSMvX
         sAU3o6yogYnu2+UvIWOZJQQUjyu1/tfe2EiskYgV4HQoVrCUAH+vJW9KTbsniMHUHTiJ
         t0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eBM0WXJ+GgNxVQg6ZdsN14nxrV6tKpZUKkvsS9po9uk=;
        b=rLJBOVE7Gemsx8gnOVrRQ6C/mX3/d2d8QM9oOBCTFqj5UPHGuZOTGUL9ZqDyuhQRJe
         CeCw2BRMdyr+zZuSHzeZg7KGEhCzTUjQS3u+neKhgqEheWpnC/1Z6WeX3+VvHSgZ+bu3
         60RrtsToeHefmnY2wjbiJRrkRcpkwEUGrVjhn5b2qJ2oAcuDGEac4Dw80uVnWa88MJ5a
         LpA6osA1xVzdeGiEW3jEU6hs+OYjoKB7PWrrq4ziL1bMzm3zm0vpz//yc+J92gImEI7F
         wed2AmjwbB9lQvluD8PJNXSV+IZr7+E9TQJBImpFsZDwmaxzVDKsrz7c3OJ5/Husewat
         CejQ==
X-Gm-Message-State: AJIora9Cm9CYjfAacBbcam3mLRadg/e3aSNDEm1erpSc5fsw8uKXSU35
        1j/mQkiUewE3BliTigqGD8w=
X-Google-Smtp-Source: AGRyM1u0e/wyG2o85Dmsu1qJZ+yp7QTwQAHn6q2TS89Ip8yZRNTT/nz/zs22kmNiiOC2e+/tICCSAg==
X-Received: by 2002:a05:6870:2053:b0:e9:3c2f:23d9 with SMTP id l19-20020a056870205300b000e93c2f23d9mr6798992oad.158.1657768663646;
        Wed, 13 Jul 2022 20:17:43 -0700 (PDT)
Received: from bertie (072-190-140-095.res.spectrum.com. [72.190.140.95])
        by smtp.gmail.com with ESMTPSA id b11-20020a4aac8b000000b00434ace74464sm160162oon.16.2022.07.13.20.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 20:17:43 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH] memblock tests: change build options to run-time options
Date:   Wed, 13 Jul 2022 22:17:17 -0500
Message-Id: <20220714031717.12258-1-remckee0@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change verbose and movable node build options to run-time options.

Movable node usage:
    $ ./main -m

    Or:
    $ ./main --movable-node

Verbose usage:
    $ ./main -v

    Or:
    $ ./main --verbose

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/Makefile               |  5 --
 tools/testing/memblock/linux/memory_hotplug.h |  8 +-
 tools/testing/memblock/main.c                 |  2 +
 .../testing/memblock/scripts/Makefile.include | 10 ---
 tools/testing/memblock/tests/common.c         | 86 ++++++++++++++++---
 tools/testing/memblock/tests/common.h         | 10 +--
 6 files changed, 79 insertions(+), 42 deletions(-)

diff --git a/tools/testing/memblock/Makefile b/tools/testing/memblock/Makefile
index 9fde49ad73bd..246f7ac8489b 100644
--- a/tools/testing/memblock/Makefile
+++ b/tools/testing/memblock/Makefile
@@ -45,13 +45,8 @@ help:
 	@echo  '  clean		  - Remove generated files and symlinks in the directory'
 	@echo  ''
 	@echo  'Configuration:'
-	@echo  '  make VERBOSE=1            - enable verbose output, which includes the'
-	@echo  '                              names of functions being tested and the'
-	@echo  '                              number of test cases passing'
 	@echo  '  make MEMBLOCK_DEBUG=1     - enable memblock_dbg() messages'
 	@echo  '  make NUMA=1               - simulate enabled NUMA'
-	@echo  '  make MOVABLE_NODE=1       - override `movable_node_is_enabled`'
-	@echo  '                              definition to simulate movable NUMA nodes'
 	@echo  '  make 32BIT_PHYS_ADDR_T=1  - Use 32 bit physical addresses'
 
 vpath %.c ../../lib
diff --git a/tools/testing/memblock/linux/memory_hotplug.h b/tools/testing/memblock/linux/memory_hotplug.h
index 47988765a219..dabe2c556858 100644
--- a/tools/testing/memblock/linux/memory_hotplug.h
+++ b/tools/testing/memblock/linux/memory_hotplug.h
@@ -7,13 +7,11 @@
 #include <linux/cache.h>
 #include <linux/types.h>
 
+extern bool movable_node_enabled;
+
 static inline bool movable_node_is_enabled(void)
 {
-#ifdef MOVABLE_NODE
-	return true;
-#else
-	return false;
-#endif
+	return movable_node_enabled;
 }
 
 #endif
diff --git a/tools/testing/memblock/main.c b/tools/testing/memblock/main.c
index fb183c9e76d1..4ca1024342b1 100644
--- a/tools/testing/memblock/main.c
+++ b/tools/testing/memblock/main.c
@@ -3,9 +3,11 @@
 #include "tests/alloc_api.h"
 #include "tests/alloc_helpers_api.h"
 #include "tests/alloc_nid_api.h"
+#include "tests/common.h"
 
 int main(int argc, char **argv)
 {
+	parse_args(argc, argv);
 	memblock_basic_checks();
 	memblock_alloc_checks();
 	memblock_alloc_helpers_checks();
diff --git a/tools/testing/memblock/scripts/Makefile.include b/tools/testing/memblock/scripts/Makefile.include
index 4401f79bed4c..aa6d82d56a23 100644
--- a/tools/testing/memblock/scripts/Makefile.include
+++ b/tools/testing/memblock/scripts/Makefile.include
@@ -6,11 +6,6 @@ ifeq ($(NUMA), 1)
 	CFLAGS += -D CONFIG_NUMA
 endif
 
-# Simulate movable NUMA memory regions
-ifeq ($(MOVABLE_NODE), 1)
-	CFLAGS += -D MOVABLE_NODE
-endif
-
 # Use 32 bit physical addresses.
 # Remember to install 32-bit version of dependencies.
 ifeq ($(32BIT_PHYS_ADDR_T), 1)
@@ -18,11 +13,6 @@ ifeq ($(32BIT_PHYS_ADDR_T), 1)
 	LDFLAGS += -m32
 endif
 
-# Enable verbose testing output
-ifeq ($(VERBOSE), 1)
-	CFLAGS += -D VERBOSE
-endif
-
 # Enable memblock_dbg() messages
 ifeq ($(MEMBLOCK_DEBUG), 1)
 	CFLAGS += -D MEMBLOCK_DEBUG
diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
index ebc06b4c3255..24ce4135a83d 100644
--- a/tools/testing/memblock/tests/common.c
+++ b/tools/testing/memblock/tests/common.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 #include "tests/common.h"
 #include <string.h>
+#include <getopt.h>
+#include <linux/memory_hotplug.h>
+#include <linux/build_bug.h>
 
 #define INIT_MEMBLOCK_REGIONS			128
 #define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
@@ -11,6 +14,27 @@ static struct test_memory memory_block;
 static const char __maybe_unused *prefixes[PREFIXES_MAX];
 static int __maybe_unused nr_prefixes;
 
+static const char *short_opts = "mv";
+static const struct option long_opts[] = {
+	{"movable-node", 0, NULL, 'm'},
+	{"verbose", 0, NULL, 'v'},
+	{NULL, 0, NULL, 0}
+};
+
+static const char * const help_opts[] = {
+	"disallow allocations from regions marked as hotplugged\n\t\t\t"
+		"by simulating enabling the \"movable_node\" kernel\n\t\t\t"
+		"parameter",
+	"enable verbose output, which includes the name of the\n\t\t\t"
+		"memblock function being tested, the name of the test,\n\t\t\t"
+		"and whether the test passed or failed."
+};
+
+static int verbose;
+
+/* sets global variable returned by movable_node_is_enabled() stub */
+bool movable_node_enabled;
+
 void reset_memblock_regions(void)
 {
 	memset(memblock.memory.regions, 0,
@@ -51,7 +75,38 @@ void dummy_physical_memory_cleanup(void)
 	free(memory_block.base);
 }
 
-#ifdef VERBOSE
+static void usage(const char *prog)
+{
+	printf("Usage: %s [-%s]\n", prog, short_opts);
+
+	BUILD_BUG_ON(ARRAY_SIZE(help_opts) != ARRAY_SIZE(long_opts) - 1);
+	for (int i = 0; long_opts[i].name; i++) {
+		printf("  -%c, --%-12s\t%s\n", long_opts[i].val,
+		       long_opts[i].name, help_opts[i]);
+	}
+
+	exit(1);
+}
+
+void parse_args(int argc, char **argv)
+{
+	int c;
+
+	while ((c = getopt_long_only(argc, argv, short_opts, long_opts,
+				     NULL)) != -1) {
+		switch (c) {
+		case 'm':
+			movable_node_enabled = true;
+			break;
+		case 'v':
+			verbose = 1;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+}
+
 void print_prefixes(const char *postfix)
 {
 	for (int i = 0; i < nr_prefixes; i++)
@@ -61,25 +116,31 @@ void print_prefixes(const char *postfix)
 
 void test_fail(void)
 {
-	ksft_test_result_fail(": ");
-	print_prefixes("failed\n");
+	if (verbose) {
+		ksft_test_result_fail(": ");
+		print_prefixes("failed\n");
+	}
 }
 
 void test_pass(void)
 {
-	ksft_test_result_pass(": ");
-	print_prefixes("passed\n");
+	if (verbose) {
+		ksft_test_result_pass(": ");
+		print_prefixes("passed\n");
+	}
 }
 
 void test_print(const char *fmt, ...)
 {
-	int saved_errno = errno;
-	va_list args;
-
-	va_start(args, fmt);
-	errno = saved_errno;
-	vprintf(fmt, args);
-	va_end(args);
+	if (verbose) {
+		int saved_errno = errno;
+		va_list args;
+
+		va_start(args, fmt);
+		errno = saved_errno;
+		vprintf(fmt, args);
+		va_end(args);
+	}
 }
 
 void prefix_reset(void)
@@ -102,4 +163,3 @@ void prefix_pop(void)
 		nr_prefixes--;
 	}
 }
-#endif /* VERBOSE */
diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
index 46de86a755f3..3e7f23d341d7 100644
--- a/tools/testing/memblock/tests/common.h
+++ b/tools/testing/memblock/tests/common.h
@@ -70,22 +70,14 @@ void reset_memblock_attributes(void);
 void setup_memblock(void);
 void dummy_physical_memory_init(void);
 void dummy_physical_memory_cleanup(void);
+void parse_args(int argc, char **argv);
 
-#ifdef VERBOSE
 void test_fail(void);
 void test_pass(void);
 void test_print(const char *fmt, ...);
 void prefix_reset(void);
 void prefix_push(const char *prefix);
 void prefix_pop(void);
-#else
-static inline void test_fail(void) {}
-static inline void test_pass(void) {}
-static inline void test_print(const char *fmt, ...) {}
-static inline void prefix_reset(void) {}
-static inline void prefix_push(const char *prefix) {}
-static inline void prefix_pop(void) {}
-#endif /* VERBOSE */
 
 static inline void test_pass_pop(void)
 {
-- 
2.34.1

