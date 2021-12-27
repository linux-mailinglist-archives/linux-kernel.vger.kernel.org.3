Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABBF47FDDC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 15:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237178AbhL0Oto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 09:49:44 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:30116 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbhL0Otn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 09:49:43 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JN0q60Bskz1DK7x;
        Mon, 27 Dec 2021 22:46:26 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 27 Dec 2021 22:49:41 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 27 Dec 2021 22:49:40 +0800
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
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Matthew Wilcox <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 0/3] mm: support huge vmalloc mapping on arm64/x86
Date:   Mon, 27 Dec 2021 22:59:00 +0800
Message-ID: <20211227145903.187152-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huge vmalloc mappings is supported on PPC[1], but this feature should
be not only used on PPC, it could be used on arch support HAVE_ARCH_HUGE_VMAP
and PMD sized vmap mappings. this patchset is to enable this feature
on arm64/x86.

There are some disadvantages about this feature[2], one of the main
concerns is the possible memory fragmentation/waste in some scenarios,
also archs must ensure that any arch specific vmalloc allocations that
require PAGE_SIZE mappings(eg, module alloc with STRICT_MODULE_RWX)
use the VM_NO_HUGE_VMAP flag to inhibit larger mappings.

Based on the above considerations, we add the first patch is to let
user to control huge vmalloc mapping default behavior.  Meanwhile,
add new kernel parameter hugevmalloc=on/off to enable/disable this
feature at boot time, nohugevmalloc parameter is still supported.

The later two patches to enable this feature on arm64/x86, select
HAVE_ARCH_HUGE_VMALLOC and mark VM_NO_HUGE_VMAP in arch's module_alloc().

This patchset based on next-20211224.

v2:
- Default y for HUGE_VMALLOC_DEFAULT_ENABLED, not only select it on PPC
- Fix copy/type error
- Mark VM_NO_HUGE_VMAP in module_alloc() on arm64/x86

[1] https://lore.kernel.org/linux-mm/20210317062402.533919-1-npiggin@gmail.com/
[2] https://lore.kernel.org/linux-mm/1616036421.amjz2efujj.astroid@bobo.none/

Kefeng Wang (3):
  mm: vmalloc: Let user to control huge vmalloc default behavior
  arm64: Support huge vmalloc mappings
  x86: Support huge vmalloc mappings

 .../admin-guide/kernel-parameters.txt          | 14 +++++++++++++-
 arch/arm64/Kconfig                             |  1 +
 arch/arm64/kernel/module.c                     |  5 +++--
 arch/x86/Kconfig                               |  1 +
 arch/x86/kernel/module.c                       |  4 ++--
 mm/Kconfig                                     |  8 ++++++++
 mm/vmalloc.c                                   | 18 +++++++++++++++++-
 7 files changed, 45 insertions(+), 6 deletions(-)

-- 
2.26.2

