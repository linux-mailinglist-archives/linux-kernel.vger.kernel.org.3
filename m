Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3B9497AAD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242346AbiAXIt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:49:26 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:16733 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242326AbiAXItF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:49:05 -0500
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jj3TM6ZrLzZfJg;
        Mon, 24 Jan 2022 16:45:11 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 16:49:03 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 16:49:02 +0800
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
        "John Donnelly" <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: [PATCH v20 5/5] kdump: update Documentation about crashkernel
Date:   Mon, 24 Jan 2022 16:47:08 +0800
Message-ID: <20220124084708.683-6-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20220124084708.683-1-thunder.leizhen@huawei.com>
References: <20220124084708.683-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Zhou <chenzhou10@huawei.com>

For arm64, the behavior of crashkernel=X has been changed, which
tries low allocation in DMA zone and fall back to high allocation
if it fails.

We can also use "crashkernel=X,high" to select a high region above
DMA zone, which also tries to allocate at least 256M low memory in
DMA zone automatically and "crashkernel=Y,low" can be used to allocate
specified size low memory.

So update the Documentation.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/admin-guide/kdump/kdump.rst       | 11 +++++++++--
 Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index cb30ca3df27c9b2..d4c287044be0c70 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -361,8 +361,15 @@ Boot into System Kernel
    kernel will automatically locate the crash kernel image within the
    first 512MB of RAM if X is not given.
 
-   On arm64, use "crashkernel=Y[@X]".  Note that the start address of
-   the kernel, X if explicitly specified, must be aligned to 2MiB (0x200000).
+   On arm64, use "crashkernel=X" to try low allocation in DMA zone and
+   fall back to high allocation if it fails.
+   We can also use "crashkernel=X,high" to select a high region above
+   DMA zone, which also tries to allocate at least 256M low memory in
+   DMA zone automatically.
+   "crashkernel=Y,low" can be used to allocate specified size low memory.
+   Use "crashkernel=Y@X" if you really have to reserve memory from
+   specified start address X. Note that the start address of the kernel,
+   X if explicitly specified, must be aligned to 2MiB (0x200000).
 
 Load the Dump-capture Kernel
 ============================
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f5a27f067db9ed9..65780c2ca830be0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -792,6 +792,9 @@
 			[KNL, X86-64] Select a region under 4G first, and
 			fall back to reserve region above 4G when '@offset'
 			hasn't been specified.
+			[KNL, ARM64] Try low allocation in DMA zone and fall back
+			to high allocation if it fails when '@offset' hasn't been
+			specified.
 			See Documentation/admin-guide/kdump/kdump.rst for further details.
 
 	crashkernel=range1:size1[,range2:size2,...][@offset]
@@ -808,6 +811,8 @@
 			Otherwise memory region will be allocated below 4G, if
 			available.
 			It will be ignored if crashkernel=X is specified.
+			[KNL, ARM64] range in high memory.
+			Allow kernel to allocate physical memory region from top.
 	crashkernel=size[KMG],low
 			[KNL, X86-64] range under 4G. When crashkernel=X,high
 			is passed, kernel could allocate physical memory region
@@ -816,13 +821,15 @@
 			requires at least 64M+32K low memory, also enough extra
 			low memory is needed to make sure DMA buffers for 32-bit
 			devices won't run out. Kernel would try to allocate at
-			at least 256M below 4G automatically.
+			least 256M below 4G automatically.
 			This one let user to specify own low range under 4G
 			for second kernel instead.
 			0: to disable low allocation.
 			It will be ignored when crashkernel=X,high is not used
 			or memory reserved is below 4G.
-
+			[KNL, ARM64] range in low memory.
+			This one let user to specify a low range in DMA zone for
+			crash dump kernel.
 	cryptomgr.notests
 			[KNL] Disable crypto self-tests
 
-- 
2.25.1

