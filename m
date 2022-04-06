Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF594F5EA8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiDFMwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiDFMuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:50:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299FC12AB0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:54:25 -0700 (PDT)
Received: from kwepemi500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KYJGD3StlzdZY5;
        Wed,  6 Apr 2022 16:53:56 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500002.china.huawei.com (7.221.188.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Apr 2022 16:54:23 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 6 Apr 2022 16:54:22 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Tong Tiangen <tongtiangen@huawei.com>
Subject: [RFC PATCH -next V2 0/7]arm64: add machine check safe support
Date:   Wed, 6 Apr 2022 09:13:04 +0000
Message-ID: <20220406091311.3354723-1-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is based on[1].

With the increase of memory capacity and density, the probability of
memory error increases. The increasing size and density of server RAM
in the data center and cloud have shown increased uncorrectable memory
errors.

Currently, the kernel has a mechanism to recover from hardware memory
errors. This patchset provides an new recovery mechanism.

For ARM64, the hardware error handling is do_sea() which divided into
two cases:
1. The user state consumed the memory errors, the solution is kill th
     user process and isolate the error page.
2. The kernel state consumed the memory errors, the solution is panic.

For kernelspace, Undifferentiated panic maybe not the optimal choice,
it can be handled better.

This patchset deals with four sscenarios of hardware memory error consumed
in kernelspace:
1. copy_from_user.
2. get_user.
3. cow(copy on write).
4. pagecache reading.

These four scenarios have similarities. Although the error is consumed in
the kernel state, but the consumed data belongs to the user state.

The processing scheme is based on CONFIG_ARCH_HAS_COPY_MC and uses the
process killing plus isolate error page to replace kernel panic.

[1]https://lore.kernel.org/lkml/20220323033705.3966643-1-tongtiangen@huawei.com/

Since V2:
 1.Consistent with PPC/x86, Using CONFIG_ARCH_HAS_COPY_MC instead of
   ARM64_UCE_KERNEL_RECOVERY.
 2.Add two new scenarios, cow and pagecache reading.
 3.Fix two small bug(the first two patch).

Tong Tiangen (7):
  x86: fix copy_mc_to_user compile error
  arm64: fix page_address return value in copy_highpage
  arm64: add support for machine check error safe
  arm64: add copy_from_user to machine check safe
  arm64: add get_user to machine check safe
  arm64: add cow to machine check safe
  arm64: add pagecache reading to machine check safe

 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/asm-extable.h | 25 +++++++
 arch/arm64/include/asm/asm-uaccess.h | 16 +++++
 arch/arm64/include/asm/esr.h         |  5 ++
 arch/arm64/include/asm/extable.h     |  2 +-
 arch/arm64/include/asm/page.h        | 10 +++
 arch/arm64/include/asm/uaccess.h     | 17 ++++-
 arch/arm64/kernel/probes/kprobes.c   |  2 +-
 arch/arm64/lib/Makefile              |  2 +
 arch/arm64/lib/copy_from_user.S      | 11 ++--
 arch/arm64/lib/copy_page_mc.S        | 98 ++++++++++++++++++++++++++++
 arch/arm64/lib/copy_to_user_mc.S     | 78 ++++++++++++++++++++++
 arch/arm64/mm/copypage.c             | 36 ++++++++--
 arch/arm64/mm/extable.c              | 21 +++++-
 arch/arm64/mm/fault.c                | 30 ++++++++-
 arch/x86/include/asm/uaccess.h       |  1 +
 include/linux/highmem.h              |  8 +++
 include/linux/uaccess.h              |  8 +++
 include/linux/uio.h                  |  9 ++-
 lib/iov_iter.c                       | 85 +++++++++++++++++++-----
 mm/memory.c                          |  2 +-
 21 files changed, 432 insertions(+), 35 deletions(-)
 create mode 100644 arch/arm64/lib/copy_page_mc.S
 create mode 100644 arch/arm64/lib/copy_to_user_mc.S

-- 
2.18.0.huawei.25

