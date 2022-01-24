Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D658F498410
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243340AbiAXQBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243276AbiAXQBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:01:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9396C06173D;
        Mon, 24 Jan 2022 08:01:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6553D614D4;
        Mon, 24 Jan 2022 16:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F3EC340EA;
        Mon, 24 Jan 2022 16:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643040073;
        bh=sS9Rm7Z5b9L8FU4QcAY05N2W4x4A7A3U2xE4Ud2uv0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pAhc0rhCEWxOub6v5yQ1xEmH6lAye0myM0X5uWJHXwUAfSRxtGvYF5+yIuUHkv8ju
         ZCsf8wNwnZE90LmpONZCaX6B65HwBbogndqU0EWvuajLjUwa+QPyaBRnJbzKniYjm1
         x/T9gBIGL1xC49DuICpoF5F1Nrak5vhPFw80yr/BSHdUZ/g1ZLz4xz4PFNjcmMe83V
         CPsvxTAtva6ikQIcW0A7DV0ly9hh3YaO+Os5izJqq95x2uQ9xIKe4Oy0uSQsYy5u9+
         8VTr5vssQF4joJYkYSO2UstNSaJjtmcyLeq83hJQ9volscCypHE5J+EWmEyfcjpJbG
         QRhOiq2CpJDYQ==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        colyli@suse.de, arnd@arndb.de, Keith Busch <kbusch@kernel.org>
Subject: [RFC 4/7] lib: add crc64 tests
Date:   Mon, 24 Jan 2022 08:01:04 -0800
Message-Id: <20220124160107.1683901-5-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220124160107.1683901-1-kbusch@kernel.org>
References: <20220124160107.1683901-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a module to test the rocksoft crc64 calculations with well known
inputs and exepected values.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 lib/Kconfig.debug |  3 +++
 lib/Makefile      |  1 +
 lib/test_crc64.c  | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)
 create mode 100644 lib/test_crc64.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c77fe36bb3d8..97711884b270 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2212,6 +2212,9 @@ config TEST_UUID
 config TEST_XARRAY
 	tristate "Test the XArray code at runtime"
 
+config TEST_CRC64
+	tristate "Test the crc64 code at runtime"
+
 config TEST_OVERFLOW
 	tristate "Test check_*_overflow() functions at runtime"
 
diff --git a/lib/Makefile b/lib/Makefile
index b213a7bbf3fd..423ef5ac3427 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -102,6 +102,7 @@ obj-$(CONFIG_TEST_HMM) += test_hmm.o
 obj-$(CONFIG_TEST_FREE_PAGES) += test_free_pages.o
 obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
 obj-$(CONFIG_TEST_REF_TRACKER) += test_ref_tracker.o
+obj-$(CONFIG_TEST_CRC64) += test_crc64.o
 #
 # CFLAGS for compiling floating point code inside the kernel. x86/Makefile turns
 # off the generation of FPU/SSE* instructions for kernel proper but FPU_FLAGS
diff --git a/lib/test_crc64.c b/lib/test_crc64.c
new file mode 100644
index 000000000000..283fef8f110e
--- /dev/null
+++ b/lib/test_crc64.c
@@ -0,0 +1,68 @@
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
+
+static int crc_tests(void)
+{
+	__u64 crc;
+	int i;
+
+	memset(buffer, 0, sizeof(buffer));
+	crc = crc64_rocksoft(~0ULL, buffer, 4096);
+	CRC_CHECK(crc, ALL_ZEROS);
+
+	memset(buffer, 0xff, sizeof(buffer));
+	crc = crc64_rocksoft(~0ULL, buffer, 4096);
+	CRC_CHECK(crc, ALL_FFS);
+
+	for (i = 0; i < 4096; i++)
+		buffer[i] = i & 0xff;
+	crc = crc64_rocksoft(~0ULL, buffer, 4096);
+	CRC_CHECK(crc, INC);
+
+	for (i = 0; i < 4096; i++)
+		buffer[i] = 0xff - (i & 0xff);
+	crc = crc64_rocksoft(~0ULL, buffer, 4096);
+	CRC_CHECK(crc, DEC);
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

