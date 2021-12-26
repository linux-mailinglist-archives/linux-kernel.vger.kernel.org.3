Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0036E47F5E1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 09:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbhLZI34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 03:29:56 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:30112 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbhLZI3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 03:29:52 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JMDRK0VR6z1DK7y;
        Sun, 26 Dec 2021 16:26:37 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 26 Dec 2021 16:29:50 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 26 Dec 2021 16:29:50 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     Nicholas Piggin <npiggin@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 3/3] x86: Support huge vmalloc mappings
Date:   Sun, 26 Dec 2021 16:39:12 +0800
Message-ID: <20211226083912.166512-4-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211226083912.166512-1-wangkefeng.wang@huawei.com>
References: <20211226083912.166512-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch select HAVE_ARCH_HUGE_VMALLOC to let X86_64 and X86_PAE
support huge vmalloc mappings, it is disabled by default, use
hugevmalloc=on to enable it.

Cc: Thomas Gleixner <tglx@linutronix.de> 
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: Borislav Petkov <bp@alien8.de> 
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++--
 arch/x86/Kconfig                                | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 235a23b08809..5c8780e66be2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1630,7 +1630,7 @@
 			precedence over memory_hotplug.memmap_on_memory.
 
 
-	hugevmalloc=	[KNL,PPC,ARM64] Reguires CONFIG_HAVE_ARCH_HUGE_VMALLOC
+	hugevmalloc=	[KNL,PPC,ARM64,X86] Reguires CONFIG_HAVE_ARCH_HUGE_VMALLOC
 			Format: { on | off }
 			Default set by CONFIG_HUGE_VMALLOC_DEFAULT_ENABLED.
 
@@ -3415,7 +3415,7 @@
 
 	nohugeiomap	[KNL,X86,PPC,ARM64] Disable kernel huge I/O mappings.
 
-	nohugevmalloc	[KNL,PPC,ARM64] Disable kernel huge vmalloc mappings.
+	nohugevmalloc	[KNL,PPC,ARM64,X86] Disable kernel huge vmalloc mappings.
 
 	nosmt		[KNL,S390] Disable symmetric multithreading (SMT).
 			Equivalent to smt=1.
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5c2ccb85f2ef..31e465fecd01 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -157,6 +157,7 @@ config X86
 	select HAVE_ACPI_APEI_NMI		if ACPI
 	select HAVE_ALIGNED_STRUCT_PAGE		if SLUB
 	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_HUGE_VMALLOC		if HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_HUGE_VMAP		if X86_64 || X86_PAE
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
-- 
2.26.2

