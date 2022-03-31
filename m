Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B62D4ED4C6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 09:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiCaH3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 03:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbiCaH3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 03:29:39 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0402E1F1D1A
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 00:27:53 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KTZXz0YyyzBrs2;
        Thu, 31 Mar 2022 15:23:47 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 31 Mar 2022 15:27:49 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 31 Mar 2022 15:27:49 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <vijayb@linux.microsoft.com>, <f.fainelli@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 resend 0/3] arm64: mm: Do not defer reserve_crashkernel()
Date:   Thu, 31 Mar 2022 15:40:52 +0800
Message-ID: <20220331074055.125824-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 031495635b46 ("arm64: Do not defer reserve_crashkernel() for
platforms with no DMA memory zones"), this lets the kernel benifit
due to BLOCK_MAPPINGS, we could do more if ZONE_DMA and ZONE_DMA32
enabled.

1) Don't defer reserve_crashkernel() if only ZONE_DMA32
2) Don't defer reserve_crashkernel() if ZONE_DMA with dma_force_32bit
   kernel parameter(newly added)

Unixbench benchmark result shows between the block mapping and page mapping.
----------------+------------------+-------------------
        	| block mapping    |   page mapping    
----------------+------------------+-------------------
Process Creation|  5,030.7         |    4,711.8       
(in unixbench)  |                  |                   
----------------+------------------+-------------------

note: RODATA_FULL_DEFAULT_ENABLED is not enabled

v2 resend:
- fix build error reported-by lkp
v2:
- update patch1 according to Vijay and Florian, and RB of Vijay
- add new patch2

Kefeng Wang (3):
  arm64: mm: Do not defer reserve_crashkernel() if only ZONE_DMA32
  arm64: mm: Don't defer reserve_crashkernel() with dma_force_32bit
  arm64: mm: Cleanup useless parameters in zone_sizes_init()

 arch/arm64/include/asm/kexec.h |  1 +
 arch/arm64/mm/init.c           | 59 +++++++++++++++++++++++++---------
 arch/arm64/mm/mmu.c            |  6 ++--
 3 files changed, 46 insertions(+), 20 deletions(-)

-- 
2.26.2

