Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981CD47D2E6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245543AbhLVNNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:13:23 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:30165 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245357AbhLVNMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:12:32 -0500
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JJtwK2yMTz8w1g;
        Wed, 22 Dec 2021 21:10:09 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 21:12:29 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 21:12:28 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        "John Donnelly" <John.p.donnelly@oracle.com>
Subject: [PATCH v18 11/17] kdump: Make parse_crashkernel_{high|low} static
Date:   Wed, 22 Dec 2021 21:08:14 +0800
Message-ID: <20211222130820.1754-12-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20211222130820.1754-1-thunder.leizhen@huawei.com>
References: <20211222130820.1754-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, parse_crashkernel_{high|low} is only referenced by
parse_crashkernel_in_order(), and they are in the same file. So make it
static, and move it into "#ifdef CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL".

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 include/linux/crash_core.h |  4 ----
 kernel/crash_core.c        | 19 ++++++++++---------
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index de62a722431e7db..529a0a783190bfe 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -79,9 +79,5 @@ void final_note(Elf_Word *buf);
 
 int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
-int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
-		unsigned long long *crash_size, unsigned long long *crash_base);
-int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
-		unsigned long long *crash_size, unsigned long long *crash_base);
 
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 496dae2718cf026..a037076b89a9bb2 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -279,7 +279,15 @@ int __init parse_crashkernel(char *cmdline,
 	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base, SUFFIX_NULL);
 }
 
-int __init parse_crashkernel_high(char *cmdline,
+
+/*
+ * --------- Crashkernel reservation ------------------------------
+ */
+
+#ifdef CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL
+
+#ifdef CONFIG_64BIT
+static int __init parse_crashkernel_high(char *cmdline,
 			     unsigned long long system_ram,
 			     unsigned long long *crash_size,
 			     unsigned long long *crash_base)
@@ -287,7 +295,7 @@ int __init parse_crashkernel_high(char *cmdline,
 	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base, SUFFIX_HIGH);
 }
 
-int __init parse_crashkernel_low(char *cmdline,
+static int __init parse_crashkernel_low(char *cmdline,
 			     unsigned long long system_ram,
 			     unsigned long long *crash_size,
 			     unsigned long long *crash_base)
@@ -295,13 +303,6 @@ int __init parse_crashkernel_low(char *cmdline,
 	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base, SUFFIX_LOW);
 }
 
-/*
- * --------- Crashkernel reservation ------------------------------
- */
-
-#ifdef CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL
-
-#ifdef CONFIG_64BIT
 static int __init reserve_crashkernel_low(unsigned long long low_size)
 {
 	unsigned long long low_base = 0;
-- 
2.25.1

