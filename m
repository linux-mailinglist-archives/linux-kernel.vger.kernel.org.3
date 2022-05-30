Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C74537A67
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 14:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbiE3MKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 08:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236060AbiE3MKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 08:10:06 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2A460DB0;
        Mon, 30 May 2022 05:10:04 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LBZ3P164czDqfB;
        Mon, 30 May 2022 20:09:53 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 30 May 2022 20:10:01 +0800
From:   Yuanzheng Song <songyuanzheng@huawei.com>
To:     <alexs@kernel.org>, <siyanteng@loongson.cn>, <corbet@lwn.net>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <nathan@kernel.org>,
        <ndesaulniers@google.com>, <trix@redhat.com>, <maskray@google.com>,
        <wanjiabing@vivo.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <llvm@lists.linux.dev>,
        Yuanzheng Song <songyuanzheng@huawei.com>
Subject: [PATCH] docs/zh_CN: update the kasan.rst documentation
Date:   Mon, 30 May 2022 12:31:23 +0000
Message-ID: <20220530123123.3994731-1-songyuanzheng@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the kasan.rst documentation according to
c2ec0c8f6877 ("kasan: update documentation") and
ca89f2a2e66d ("kasan: move boot parameters section in documentation").

Signed-off-by: Yuanzheng Song <songyuanzheng@huawei.com>
---
 .../translations/zh_CN/dev-tools/kasan.rst    | 143 +++++++++++-------
 1 file changed, 88 insertions(+), 55 deletions(-)

diff --git a/Documentation/translations/zh_CN/dev-tools/kasan.rst b/Documentation/translations/zh_CN/dev-tools/kasan.rst
index 23db9d419047..6f3e8c4b24b4 100644
--- a/Documentation/translations/zh_CN/dev-tools/kasan.rst
+++ b/Documentation/translations/zh_CN/dev-tools/kasan.rst
@@ -11,34 +11,64 @@
 概述
 ----
 
-KernelAddressSANitizer(KASAN)是一种动态内存安全错误检测工具，主要功能是
-检查内存越界访问和使用已释放内存的问题。KASAN有三种模式:
+Kernel Address Sanitizer (KASAN)是一种动态内存安全错误检测工具，主要功能是
+检查内存越界访问和使用已释放内存的问题。
 
-1. 通用KASAN（与用户空间的ASan类似）
-2. 基于软件标签的KASAN（与用户空间的HWASan类似）
-3. 基于硬件标签的KASAN（基于硬件内存标签）
+KASAN有三种模式:
 
-由于通用KASAN的内存开销较大，通用KASAN主要用于调试。基于软件标签的KASAN
-可用于dogfood测试，因为它具有较低的内存开销，并允许将其用于实际工作量。
-基于硬件标签的KASAN具有较低的内存和性能开销，因此可用于生产。同时可用于
-检测现场内存问题或作为安全缓解措施。
+1. 通用KASAN
+2. 基于软件标签的KASAN
+3. 基于硬件标签的KASAN
 
-软件KASAN模式（#1和#2）使用编译时工具在每次内存访问之前插入有效性检查，
-因此需要一个支持它的编译器版本。
+通用KASAN，由CONFIG_KASAN_GENERIC配置开启，属于调试模式，类似于用户空间的ASan。
+在很多CPU架构上都支持这种模式，但它具有较大的性能和内存开销。
 
-通用KASAN在GCC和Clang受支持。GCC需要8.3.0或更高版本。任何受支持的Clang
-版本都是兼容的，但从Clang 11才开始支持检测全局变量的越界访问。
+基于软件标签的KASAN或SW_TAGS KASAN，由CONFIG_KASAN_SW_TAGS配置开启，
+该模式被用来调试和dogfood测试，类似于用户空间的HWASan。这种模式仅在arm64上支持，
+由于它具有中等的内存开销，因此允许在具有实际工作负载的内存受限设备上使用。
 
-基于软件标签的KASAN模式仅在Clang中受支持。
+基于硬件标签的KASAN或HW_TAGS KASAN，由CONFIG_KASAN_HW_TAGS配置开启，
+这种模式可用于检测现场内存问题或作为安全缓解措施。这种模式仅在支持
+MTE（Memory Tagging Extension）的ARM64上支持，但是这种模式具有较低的内存和
+性能的开销，因此可以在生产中使用。
 
-硬件KASAN模式（#3）依赖硬件来执行检查，但仍需要支持内存标签指令的编译器
-版本。GCC 10+和Clang 11+支持此模式。
+有关每种KASAN模式对内存和性能的影响细节，请参考相应Kconfig选项的说明。
 
-两种软件KASAN模式都适用于SLUB和SLAB内存分配器，而基于硬件标签的KASAN目前
-仅支持SLUB。
+通用模式和基于软件标签的模式通常称为软件模式。基于软件标签和基于硬件标签的模式
+称为基于标签的模式。
 
-目前x86_64、arm、arm64、xtensa、s390、riscv架构支持通用KASAN模式，仅
-arm64架构支持基于标签的KASAN模式。
+支持
+----
+
+架构
+~~~~
+
+x86_64、arm、arm64、powerpc、riscv、s390、xtensa架构支持通用KASAN模式，
+仅arm64架构支持基于标签模式的KASAN模式。
+
+编译器
+~~~~~~
+
+软件KASAN模式使用编译时检测在每次内存访问之前插入有效性检查，因此需要提供支持的
+编译器版本。基于硬件标签的模式依赖于硬件来执行这些检查，但仍然需要支持内存标记
+指令的编译器版本。
+
+通用KASAN需要GCC 8.3.0版本或更高版本或内核支持的任何Clang版本。
+
+基于软件标签的KASAN需要GCC 11+或内核支持的任何Clang版本。
+
+基于硬件标签的KASAN需要GCC 10+或Clang 12+。
+
+内存类型
+~~~~~~~~
+
+通用KASAN支持在所有slab、page_alloc、vmap、vmalloc、stack和全局内存中查找错误。
+
+基于软件标签的KASAN支持slab、page_alloc、vmalloc和栈内存。
+
+基于硬件标签的KASAN支持slab、page_alloc和不可执行的vmalloc内存。
+
+对于slab，两种软件KASAN模式都支持SLUB和SLAB分配器，而基于硬件标记的KASAN仅支持SLUB。
 
 用法
 ----
@@ -48,17 +78,49 @@ arm64架构支持基于标签的KASAN模式。
 	  CONFIG_KASAN=y
 
 同时在 ``CONFIG_KASAN_GENERIC`` (启用通用KASAN模式)， ``CONFIG_KASAN_SW_TAGS``
-(启用基于硬件标签的KASAN模式)，和 ``CONFIG_KASAN_HW_TAGS`` (启用基于硬件标签
+(启用基于软件标签的KASAN模式)，和 ``CONFIG_KASAN_HW_TAGS`` (启用基于硬件标签
 的KASAN模式)之间进行选择。
 
 对于软件模式，还可以在 ``CONFIG_KASAN_OUTLINE`` 和 ``CONFIG_KASAN_INLINE``
 之间进行选择。outline和inline是编译器插桩类型。前者产生较小的二进制文件，
-而后者快1.1-2倍。
+而后者快2倍。
 
 要将受影响的slab对象的alloc和free堆栈跟踪包含到报告中，请启用
 ``CONFIG_STACKTRACE`` 。要包括受影响物理页面的分配和释放堆栈跟踪的话，
 请启用 ``CONFIG_PAGE_OWNER`` 并使用 ``page_owner=on`` 进行引导。
 
+启动参数
+~~~~~~~~
+
+KASAN受通用 ``panic_on_warn`` 命令行参数的影响。启用该功能后，KASAN在打印错误
+报告后会引起内核恐慌。
+
+默认情况下，KASAN只为第一次无效内存访问打印错误报告。使用 ``kasan_multi_shot`` ，
+KASAN会针对每个无效访问打印报告。这有效地禁用了KASAN报告的 ``panic_on_warn`` 。
+
+或者，独立于 ``panic_on_warn``，``kasan.fault=`` 启动参数可用于控制恐慌和报告
+的行为。
+
+- ``kasan.fault=report`` 或 ``=panic`` 控制是只打印KASAN报告还是同时使内核恐慌
+  (默认: ``report`` )。即使启用了 ``kasan_multi_shot`` ，也会发生内核恐慌。
+
+基于硬件标签的KASAN模式（请参阅下面有关各种模式的部分）旨在在生产中用作安全缓解
+措施。因此，它支持允许禁用KASAN或控制其功能的引导参数。
+
+- ``kasan=off`` 或 ``=on`` 控制KASAN是否启用 (默认: ``on`` )。
+
+- ``kasan.mode=sync`` 或 ``=async`` 或 ``=asymm`` 控制KASAN是否配置为同步，
+  异步执行或非对称模式(默认:``sync`` )。
+  同步模式：当标签检查错误发生时，立即检测到错误访问。
+  异步模式：延迟错误访问检测。当标签检查错误发生时，信息存储在硬件中（在arm64的
+  TFSR_EL1寄存器中）。内核会定期检查硬件，并且仅在这些检查期间报告标签错误。
+  非对称模式：读取时同步检测错误访问，写入时异步检测错误访问。
+
+- ``kasan.vmalloc=off`` 或 ``=on`` 禁用或启用vmalloc分配的标记 (默认: ``on``)。
+
+- ``kasan.stacktrace=off`` 或 ``=on`` 禁用或启用alloc和free堆栈跟踪收集
+  (默认: ``on`` )。
+
 错误报告
 ~~~~~~~~
 
@@ -163,31 +225,6 @@ slab对象的描述以及关于访问的内存页的信息。
 通用KASAN还报告两个辅助调用堆栈跟踪。这些堆栈跟踪指向代码中与对象交互但不直接
 出现在错误访问堆栈跟踪中的位置。目前，这包括 call_rcu() 和排队的工作队列。
 
-启动参数
-~~~~~~~~
-
-KASAN受通用 ``panic_on_warn`` 命令行参数的影响。启用该功能后，KASAN在打印错误
-报告后会引起内核恐慌。
-
-默认情况下，KASAN只为第一次无效内存访问打印错误报告。使用 ``kasan_multi_shot`` ，
-KASAN会针对每个无效访问打印报告。这有效地禁用了KASAN报告的 ``panic_on_warn`` 。
-
-基于硬件标签的KASAN模式（请参阅下面有关各种模式的部分）旨在在生产中用作安全缓解
-措施。因此，它支持允许禁用KASAN或控制其功能的引导参数。
-
-- ``kasan=off`` 或 ``=on`` 控制KASAN是否启用 (默认: ``on`` )。
-
-- ``kasan.mode=sync`` 或 ``=async`` 控制KASAN是否配置为同步或异步执行模式(默认:
-  ``sync`` )。同步模式：当标签检查错误发生时，立即检测到错误访问。异步模式：
-  延迟错误访问检测。当标签检查错误发生时，信息存储在硬件中（在arm64的
-  TFSR_EL1寄存器中）。内核会定期检查硬件，并且仅在这些检查期间报告标签错误。
-
-- ``kasan.stacktrace=off`` 或 ``=on`` 禁用或启用alloc和free堆栈跟踪收集
-  (默认: ``on`` )。
-
-- ``kasan.fault=report`` 或 ``=panic`` 控制是只打印KASAN报告还是同时使内核恐慌
-  (默认: ``report`` )。即使启用了 ``kasan_multi_shot`` ，也会发生内核恐慌。
-
 实施细则
 --------
 
@@ -244,8 +281,6 @@ KASAN会针对每个无效访问打印报告。这有效地禁用了KASAN报告
 基于软件标签的KASAN使用0xFF作为匹配所有指针标签（不检查通过带有0xFF指针标签
 的指针进行的访问）。值0xFE当前保留用于标记已释放的内存区域。
 
-基于软件标签的KASAN目前仅支持对Slab和page_alloc内存进行标记。
-
 基于硬件标签的KASAN模式
 ~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -262,8 +297,6 @@ KASAN会针对每个无效访问打印报告。这有效地禁用了KASAN报告
 基于硬件标签的KASAN使用0xFF作为匹配所有指针标签（不检查通过带有0xFF指针标签的
 指针进行的访问）。值0xFE当前保留用于标记已释放的内存区域。
 
-基于硬件标签的KASAN目前仅支持对Slab和page_alloc内存进行标记。
-
 如果硬件不支持MTE（ARMv8.5之前），则不会启用基于硬件标签的KASAN。在这种情况下，
 所有KASAN引导参数都将被忽略。
 
@@ -349,10 +382,10 @@ KASAN连接到vmap基础架构以懒清理未使用的影子内存。
 ``kasan_disable_current()``/``kasan_enable_current()`` 部分注释这部分代码。
 这也会禁用通过函数调用发生的间接访问的报告。
 
-对于基于标签的KASAN模式（包括硬件模式），要禁用访问检查，请使用
-``kasan_reset_tag()`` 或 ``page_kasan_tag_reset()`` 。请注意，通过
-``page_kasan_tag_reset()`` 临时禁用访问检查需要通过 ``page_kasan_tag``
-/ ``page_kasan_tag_set`` 保存和恢复每页KASAN标签。
+对于基于标签的KASAN模式，要禁用访问检查，请使用 ``kasan_reset_tag()``
+或 ``page_kasan_tag_reset()`` 。请注意，通过 ``page_kasan_tag_reset()``
+临时禁用访问检查需要通过 ``page_kasan_tag`` / ``page_kasan_tag_set``
+保存和恢复每页KASAN标签。
 
 测试
 ~~~~
-- 
2.25.1

