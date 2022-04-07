Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE5D4F7E9A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243446AbiDGMFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239537AbiDGMEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:04:43 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C182C4E14
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 05:02:37 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KZ0Nr4kZWz1HBRr;
        Thu,  7 Apr 2022 20:02:04 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 20:02:32 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 20:02:32 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <jthierry@redhat.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>, <ardb@kernel.org>,
        <masahiroy@kernel.org>, <jpoimboe@redhat.com>,
        <peterz@infradead.org>, <ycote@redhat.com>
Subject: [RFC PATCH v3 01/13] tools: Add some generic functions and headers
Date:   Thu, 7 Apr 2022 20:01:29 +0800
Message-ID: <20220407120141.43801-2-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220407120141.43801-1-chenzhongjin@huawei.com>
References: <20220407120141.43801-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <jthierry@redhat.com>

These will be needed to be able to use arm64 instruction decoder in
userland tools.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/include/asm-generic/bitops/__ffs.h | 11 +++++++
 tools/include/linux/kernel.h             | 21 +++++++++++++
 tools/include/linux/printk.h             | 40 ++++++++++++++++++++++++
 3 files changed, 72 insertions(+)
 create mode 100644 tools/include/linux/printk.h

diff --git a/tools/include/asm-generic/bitops/__ffs.h b/tools/include/asm-generic/bitops/__ffs.h
index 9d1310519497..963f8a22212f 100644
--- a/tools/include/asm-generic/bitops/__ffs.h
+++ b/tools/include/asm-generic/bitops/__ffs.h
@@ -42,4 +42,15 @@ static __always_inline unsigned long __ffs(unsigned long word)
 	return num;
 }
 
+static inline unsigned long __ffs64(u64 word)
+{
+#if BITS_PER_LONG == 32
+	if (((u32)word) == 0UL)
+		return __ffs((u32)(word >> 32)) + 32;
+#elif BITS_PER_LONG != 64
+#error BITS_PER_LONG not 32 or 64
+#endif
+	return __ffs((unsigned long)word);
+}
+
 #endif /* _TOOLS_LINUX_ASM_GENERIC_BITOPS___FFS_H_ */
diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index 4b0673bf52c2..47f24f07e8f1 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -102,6 +102,27 @@ int scnprintf_pad(char * buf, size_t size, const char * fmt, ...);
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
 #endif
 
+/**
+ * upper_32_bits - return bits 32-63 of a number
+ * @n: the number we're accessing
+ *
+ * A basic shift-right of a 64- or 32-bit quantity.  Use this to suppress
+ * the "right shift count >= width of type" warning when that quantity is
+ * 32-bits.
+ */
+#define upper_32_bits(n) ((u32)(((n) >> 16) >> 16))
+
+/**
+ * lower_32_bits - return bits 0-31 of a number
+ * @n: the number we're accessing
+ */
+#define lower_32_bits(n) ((u32)(n))
+
+/* Inspired from ALIGN_*_KERNEL */
+#define __ALIGN_MASK(x, mask)	(((x) + (mask)) & ~(mask))
+#define __ALIGN(x, a)		__ALIGN_MASK(x, (typeof(x))(a) - 1)
+#define ALIGN_DOWN(x, a)	__ALIGN((x) - ((a) - 1), (a))
+
 #define current_gfp_context(k) 0
 #define synchronize_rcu()
 
diff --git a/tools/include/linux/printk.h b/tools/include/linux/printk.h
new file mode 100644
index 000000000000..515ebdc47e6e
--- /dev/null
+++ b/tools/include/linux/printk.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_LINUX_KERNEL_PRINTK_H_
+#define _TOOLS_LINUX_KERNEL_PRINTK_H_
+
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#define printk(fmt, ...) fprintf(stdout, fmt, ##__VA_ARGS__)
+#define pr_info printk
+#define pr_notice printk
+#define pr_cont printk
+
+#define pr_warn(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)
+#define pr_err pr_warn
+#define pr_alert pr_warn
+#define pr_emerg pr_warn
+#define pr_crit pr_warn
+
+/*
+ * Dummy printk for disabled debugging statements to use whilst maintaining
+ * gcc's format checking.
+ */
+#define no_printk(fmt, ...)				\
+({							\
+	if (0)						\
+		printk(fmt, ##__VA_ARGS__);		\
+	0;						\
+})
+
+/* pr_devel() should produce zero code unless DEBUG is defined */
+#ifdef DEBUG
+#define pr_devel(fmt, ...) printk
+#else
+#define pr_devel(fmt, ...) no_printk
+#endif
+
+#define pr_debug pr_devel
+
+#endif /* _TOOLS_LINUX_KERNEL_PRINTK_H_ */
-- 
2.17.1

