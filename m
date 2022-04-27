Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE9E511739
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbiD0MFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbiD0MFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:05:32 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6BE3B295
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:02:20 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KpHNr6hSFzGpNK;
        Wed, 27 Apr 2022 19:59:40 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 20:02:17 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 20:02:17 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 0/4] arm64: Cleanup ioremap() and support ioremap_prot()
Date:   Wed, 27 Apr 2022 20:14:09 +0800
Message-ID: <20220427121413.168468-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's arm64 use GENERIC_IOREMAP to cleanup code, and
support ioremap_prot()/HAVE_IOREMAP_PROT, which could
enable generic_access_phys().

Kefeng Wang (4):
  mm: ioremap: Setup phys_addr of struct vm_struct
  mm: ioremap: Add arch_ioremap/iounmap_check()
  arm64: mm: Convert to GENERIC_IOREMAP
  arm64: Add HAVE_IOREMAP_PROT support

 .../features/vm/ioremap_prot/arch-support.txt |  2 +-
 arch/arm64/Kconfig                            |  2 +
 arch/arm64/include/asm/io.h                   | 14 +--
 arch/arm64/include/asm/pgtable.h              | 10 +++
 arch/arm64/kernel/acpi.c                      |  2 +-
 arch/arm64/mm/hugetlbpage.c                   | 10 ---
 arch/arm64/mm/ioremap.c                       | 86 +++----------------
 include/asm-generic/io.h                      |  3 +
 mm/ioremap.c                                  | 21 ++++-
 9 files changed, 56 insertions(+), 94 deletions(-)

-- 
2.26.2

