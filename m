Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC66536B2B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 08:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355851AbiE1G3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 02:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355637AbiE1G3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 02:29:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0013152C
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 23:29:35 -0700 (PDT)
Received: from kwepemi500003.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L9BZP2g1YzjWx4;
        Sat, 28 May 2022 14:28:29 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500003.china.huawei.com (7.221.188.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 28 May 2022 14:29:33 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 28 May 2022 14:29:31 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
CC:     <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Guohanjun <guohanjun@huawei.com>,
        Tong Tiangen <tongtiangen@huawei.com>
Subject: [PATCH -next v5 5/8] Add generic fallback version of copy_mc_to_user()
Date:   Sat, 28 May 2022 06:50:53 +0000
Message-ID: <20220528065056.1034168-6-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220528065056.1034168-1-tongtiangen@huawei.com>
References: <20220528065056.1034168-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86/powerpc has it's implementation of copy_mc_to_user(), we add generic
fallback in include/linux/uaccess.h prepare for other architechures to
enable CONFIG_ARCH_HAS_COPY_MC.

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/uaccess.h | 1 +
 arch/x86/include/asm/uaccess.h     | 1 +
 include/linux/uaccess.h            | 9 +++++++++
 3 files changed, 11 insertions(+)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 9b82b38ff867..58dbe8e2e318 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -358,6 +358,7 @@ copy_mc_to_user(void __user *to, const void *from, unsigned long n)
 
 	return n;
 }
+#define copy_mc_to_user copy_mc_to_user
 #endif
 
 extern long __copy_from_user_flushcache(void *dst, const void __user *src,
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 35f222aa66bf..b7b1aca5d6cd 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -512,6 +512,7 @@ copy_mc_to_kernel(void *to, const void *from, unsigned len);
 
 unsigned long __must_check
 copy_mc_to_user(void *to, const void *from, unsigned len);
+#define copy_mc_to_user copy_mc_to_user
 #endif
 
 /*
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 5a328cf02b75..07e9faeb14b5 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -174,6 +174,15 @@ copy_mc_to_kernel(void *dst, const void *src, size_t cnt)
 }
 #endif
 
+#ifndef copy_mc_to_user
+static inline unsigned long __must_check
+copy_mc_to_user(void *dst, const void *src, size_t cnt)
+{
+	check_object_size(src, cnt, true);
+	return raw_copy_to_user(dst, src, cnt);
+}
+#endif
+
 static __always_inline void pagefault_disabled_inc(void)
 {
 	current->pagefault_disabled++;
-- 
2.25.1

