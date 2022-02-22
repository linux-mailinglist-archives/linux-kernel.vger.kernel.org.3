Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0126F4BFECF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbiBVQdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbiBVQcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:32:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92D9AA2FC;
        Tue, 22 Feb 2022 08:32:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85EF760A2B;
        Tue, 22 Feb 2022 16:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409E3C340F7;
        Tue, 22 Feb 2022 16:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645547546;
        bh=K6Y7PoEX/ei0aWx5jBUIAMLJ24UZ5DFTNrAOH1STYEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u9njbRhtam4tj7EVawuiEHrQK/nvvMc1jbYszicWb68JbDLKKiZBRuK69/HrTdhYc
         h08qvcJoobCsKto8s1Y/9yUVkuqMZlqdE0u3qY31ALVTM1bWbKVS37YrfO7HFh36Ig
         I+1nEV2P4pH7YWFwfmUWx5Qrks60mddWWGEwexufBzWoMapCpKLv4FiZrs+Qq/mgF3
         dyQ01Ax3ziLdSxeKN7gv7YcPWYJbb8PSkTR/+DIUpYAMrhHHOgQAIRJDx0S841hSYh
         iQ1l5MHVRFFZZRj2F9CBwEOSHIYIobaMC/1XjexedLGcnPPteETqHPX+L81vaQVOSI
         JLrke3jmgBwCg==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        colyli@suse.de, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 07/10] lib: add crc64 tests
Date:   Tue, 22 Feb 2022 08:31:41 -0800
Message-Id: <20220222163144.1782447-8-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220222163144.1782447-1-kbusch@kernel.org>
References: <20220222163144.1782447-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a module to test the rocksoft crc64 calculations with well known
inputs and exepected values. Check the generic table implementation and
whatever module is registered from the crypto library, and compare their
speeds.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 lib/Kconfig.debug |   4 ++
 lib/Makefile      |   1 +
 lib/test_crc64.c  | 133 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+)
 create mode 100644 lib/test_crc64.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 14b89aa37c5c..149de11ae903 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2214,6 +2214,10 @@ config TEST_UUID
 config TEST_XARRAY
 	tristate "Test the XArray code at runtime"
 
+config TEST_CRC64
+	depends on CRC64
+	tristate "Test the crc64 code at runtime"
+
 config TEST_OVERFLOW
 	tristate "Test check_*_overflow() functions at runtime"
 
diff --git a/lib/Makefile b/lib/Makefile
index 130bed83cdf2..0895a3fc3f5a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -103,6 +103,7 @@ obj-$(CONFIG_TEST_HMM) += test_hmm.o
 obj-$(CONFIG_TEST_FREE_PAGES) += test_free_pages.o
 obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
 obj-$(CONFIG_TEST_REF_TRACKER) += test_ref_tracker.o
+obj-$(CONFIG_TEST_CRC64) += test_crc64.o
 #
 # CFLAGS for compiling floating point code inside the kernel. x86/Makefile turns
 # off the generation of FPU/SSE* instructions for kernel proper but FPU_FLAGS
diff --git a/lib/test_crc64.c b/lib/test_crc64.c
new file mode 100644
index 000000000000..281aacd20f0a
--- /dev/null
+++ b/lib/test_crc64.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests were selected from NVM Express NVM Command Set Specification 1.0a,
+ * section 5.2.1.3.5 "64b CRC Test Cases" available here:
+ *
+ *   https://nvmexpress.org/wp-content/uploads/NVMe-NVM-Command-Set-Specification-1.0a-2021.07.26-Ratified.pdf
+ *
+ * Copyright 2022 Keith Busch <kbusch@kernel.org>
+ */
+
+#include <linux/crc64.h>
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include <linux/random.h>
+
+static unsigned int tests_passed;
+static unsigned int tests_run;
+
+#define ALL_ZEROS 0x6482D367EB22B64EULL
+#define ALL_FFS 0xC0DDBA7302ECA3ACULL
+#define INC 0x3E729F5F6750449CULL
+#define DEC 0x9A2DF64B8E9E517EULL
+
+static u8 buffer[4096];
+
+#define CRC_CHECK(c, v) do {					\
+	tests_run++;						\
+	if (c != v)						\
+		printk("BUG at %s:%d expected:%llx got:%llx\n", \
+			__func__, __LINE__, v, c);		\
+	else							\
+		tests_passed++;					\
+} while (0)
+
+static void randomize(u64 *b, int size)
+{
+	int i;
+
+	for (i = 0; i < size / 8; i++)
+		b[i] = get_random_u64();
+}
+
+static void crc_speed_tests(void)
+{
+	unsigned long size = 1 << 20;
+	unsigned test_size;
+	void *b;
+
+	b = vmalloc(size);
+	if (!b)
+		return;
+
+	test_size = 512;
+	while (test_size <= size) {
+		ktime_t start_time, end_time;
+		u64 crc1, crc2;
+		s64 t1, t2;
+		int i;
+
+		randomize(b, test_size);
+		crc1 = crc2 = ~0ULL;
+
+		start_time = ktime_get();
+		for (i = 0; i < 1024; i++)
+			crc1 = crc64_rocksoft_generic(crc1, b, test_size);
+		end_time = ktime_get();
+		t1 = ktime_us_delta(end_time, start_time);
+
+		start_time = ktime_get();
+		for (i = 0; i < 1024; i++)
+			crc2 = crc64_rocksoft_update(crc2, b, test_size);
+		end_time = ktime_get();
+		t2 = ktime_us_delta(end_time, start_time);
+
+		printk("Size:%-7u Generic:%-7lld Library:%lld\n", test_size,
+			t1, t2);
+		CRC_CHECK(crc1, crc2);
+
+		test_size <<= 1;
+	}
+
+        vfree(b);
+}
+
+static int crc_tests(void)
+{
+	__u64 crc;
+	int i;
+
+	memset(buffer, 0, sizeof(buffer));
+	crc = crc64_rocksoft_generic(~0ULL, buffer, 4096);
+	CRC_CHECK(crc, ALL_ZEROS);
+
+	crc = crc64_rocksoft(buffer, 4096);
+	CRC_CHECK(crc, ALL_ZEROS);
+
+	memset(buffer, 0xff, sizeof(buffer));
+	crc = crc64_rocksoft_generic(~0ULL, buffer, 4096);
+	CRC_CHECK(crc, ALL_FFS);
+
+	crc = crc64_rocksoft(buffer, 4096);
+	CRC_CHECK(crc, ALL_FFS);
+
+	for (i = 0; i < 4096; i++)
+		buffer[i] = i & 0xff;
+	crc = crc64_rocksoft_generic(~0ULL, buffer, 4096);
+	CRC_CHECK(crc, INC);
+
+	crc = crc64_rocksoft(buffer, 4096);
+	CRC_CHECK(crc, INC);
+
+	for (i = 0; i < 4096; i++)
+		buffer[i] = 0xff - (i & 0xff);
+	crc = crc64_rocksoft_generic(~0ULL, buffer, 4096);
+	CRC_CHECK(crc, DEC);
+
+	crc = crc64_rocksoft(buffer, 4096);
+	CRC_CHECK(crc, DEC);
+
+	crc_speed_tests();
+
+	printk("CRC64: %u of %u tests passed\n", tests_passed, tests_run);
+	return (tests_run == tests_passed) ? 0 : -EINVAL;
+}
+
+static void crc_exit(void)
+{
+}
+
+module_init(crc_tests);
+module_exit(crc_exit);
+MODULE_AUTHOR("Keith Busch <kbusch@kernel.org>");
+MODULE_LICENSE("GPL");
-- 
2.25.4

