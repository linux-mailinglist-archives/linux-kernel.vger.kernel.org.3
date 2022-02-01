Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A75D4A647F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 20:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242267AbiBATBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 14:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242240AbiBATBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:01:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25CBC061714;
        Tue,  1 Feb 2022 11:01:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69229B82F6E;
        Tue,  1 Feb 2022 19:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEEDC340EB;
        Tue,  1 Feb 2022 19:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643742096;
        bh=v/Q8ZZo7quyOd6plKn0NPo653Dll/VicuADDW6MUnw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TkQ63Gj6FV7VVaG9hwNnctBUpCi+9O5MuiKVANM2KUj682vyIg9LN0wyh3BKQ5zpB
         Bm6uF8lKJq1BEuSKeCPPTwX1ifJYnjsG0thJG2rldMCUsjL2XQevp09Fr0fZvxLKjN
         6Omg4I8Qe6do+WVg4i3e1iWDSTy1Sr9RcMgDUOZFFs3iVJ3kCRoxlTJcQIjveNwMdY
         D/CoHj1CgZrnDB/Ea91es8x2aPkAxts7vMgw0Zi0U45vxGxf+TxgNLjF7fRSGhI8ZC
         QnnCYGy/59XDLFjH2izw4NpIj4nWlUG8H5ODsFOPb0t/183wgqnQ//3hRt9AL4gnxv
         AKQyRL5ghu17g==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        colyli@suse.de, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 4/7] lib: add crc64 tests
Date:   Tue,  1 Feb 2022 11:01:25 -0800
Message-Id: <20220201190128.3075065-5-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220201190128.3075065-1-kbusch@kernel.org>
References: <20220201190128.3075065-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a module to test the rocksoft crc64 calculations with well known
inputs and exepected values.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

  Fixed Kconfig dependency

 lib/Kconfig.debug |  4 +++
 lib/Makefile      |  1 +
 lib/test_crc64.c  | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+)
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
index 300f569c626b..e100a4d6a950 100644
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

