Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7BE52CE0E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbiESISY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbiESIRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:17:08 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8296473D
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:17:05 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L3jP732SdzhZ5n;
        Thu, 19 May 2022 16:16:27 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 16:17:04 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 16:17:03 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <hch@infradead.org>, <arnd@arndb.de>,
        <anshuman.khandual@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 0/6] arm64: Cleanup ioremap() and support ioremap_prot()
Date:   Thu, 19 May 2022 16:25:46 +0800
Message-ID: <20220519082552.117736-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Enhance generic ioremap to make it more useful.
2. Let's arm64 use GENERIC_IOREMAP to cleanup code.
3. Support HAVE_IOREMAP_PROT on arm64, which enable generic_access_phys(),
   it is useful when debug(eg, gdb) via access_process_vm device memory
   infrastructure.

v3:
- add cleanup patch to kill ARM's unused arch_iounmap(the naming will be
  used in GENERIC_IOREMAP) and add comments for arch_ioremap/arch_iounmap
  hooks, per Anshuman Khandual
- collect ack/review 

v2:
- s/addr/phys_addr in ioremap_prot, suggested by Andrew Morton 
- rename arch_ioremap/iounmap_check to arch_ioremap/iounmad
  and change return value, per Christoph Hellwig and Andrew Morton
- and use 'ifndef arch_ioremap' instead of weak function, per Arnd Bergmann
- collect ack/review

Kefeng Wang (6):
  ARM: mm: kill unused runtime hook arch_iounmap()
  mm: ioremap: Use more sensibly name in ioremap_prot()
  mm: ioremap: Setup phys_addr of struct vm_struct
  mm: ioremap: Add arch_ioremap/iounmap()
  arm64: mm: Convert to GENERIC_IOREMAP
  arm64: Add HAVE_IOREMAP_PROT support

 .../features/vm/ioremap_prot/arch-support.txt |  2 +-
 arch/arm/include/asm/io.h                     |  4 +-
 arch/arm/mm/ioremap.c                         |  9 +-
 arch/arm/mm/nommu.c                           |  9 +-
 arch/arm64/Kconfig                            |  2 +
 arch/arm64/include/asm/io.h                   | 20 +++--
 arch/arm64/include/asm/pgtable.h              | 10 +++
 arch/arm64/kernel/acpi.c                      |  2 +-
 arch/arm64/mm/hugetlbpage.c                   | 10 ---
 arch/arm64/mm/ioremap.c                       | 85 +++----------------
 include/asm-generic/io.h                      | 26 +++++-
 mm/ioremap.c                                  | 30 +++++--
 12 files changed, 88 insertions(+), 121 deletions(-)

-- 
2.35.3

