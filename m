Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B704B872E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiBPL4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:56:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbiBPLzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:55:50 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04B326724C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:55:38 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JzGWQ3CbjzZfh2;
        Wed, 16 Feb 2022 19:51:14 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Feb 2022 19:55:36 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Feb 2022 19:55:35 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>,
        <benh@kernel.crashing.or>, <paulus@samba.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <songyuanzheng@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v4 2/2] powerpc: Fix virt_addr_valid() check
Date:   Wed, 16 Feb 2022 20:11:08 +0800
Message-ID: <20220216121109.157605-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220216121109.157605-1-wangkefeng.wang@huawei.com>
References: <20220216121109.157605-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

When run ethtool eth0 on PowerPC64, the BUG occurred,

  usercopy: Kernel memory exposure attempt detected from SLUB object not in SLUB page?! (offset 0, size 1048)!
  kernel BUG at mm/usercopy.c:99
  ...
  usercopy_abort+0x64/0xa0 (unreliable)
  __check_heap_object+0x168/0x190
  __check_object_size+0x1a0/0x200
  dev_ethtool+0x2494/0x2b20
  dev_ioctl+0x5d0/0x770
  sock_do_ioctl+0xf0/0x1d0
  sock_ioctl+0x3ec/0x5a0
  __se_sys_ioctl+0xf0/0x160
  system_call_exception+0xfc/0x1f0
  system_call_common+0xf8/0x200

The code shows below,

  data = vzalloc(array_size(gstrings.len, ETH_GSTRING_LEN));
  copy_to_user(useraddr, data, gstrings.len * ETH_GSTRING_LEN))

The data is alloced by vmalloc(), virt_addr_valid(ptr) will return true
on PowerPC64, which leads to the panic.

As commit 4dd7554a6456 ("powerpc/64: Add VIRTUAL_BUG_ON checks for __va
and __pa addresses") does, make sure the virt addr above PAGE_OFFSET in
the virt_addr_valid() for PowerPC64, also add upper limit check to make
sure the virt is below high_memory.

Meanwhile, for PowerPC32 PAGE_OFFSET is the virtual address of the start
of lowmem, high_memory is the upper low virtual address, the check is
suitable for PowerPC32, this will fix the issue mentioned in commit
602946ec2f90 ("powerpc: Set max_mapnr correctly") too.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v4:
- add upper limit check
v3:
- update changelog and remove a redundant cast
 arch/powerpc/include/asm/page.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 254687258f42..7a1ba27a7285 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -132,7 +132,11 @@ static inline bool pfn_valid(unsigned long pfn)
 #define virt_to_page(kaddr)	pfn_to_page(virt_to_pfn(kaddr))
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
 
-#define virt_addr_valid(kaddr)	pfn_valid(virt_to_pfn(kaddr))
+#define virt_addr_valid(vaddr)	({					\
+	unsigned long _addr = (unsigned long)vaddr;			\
+	_addr >= PAGE_OFFSET && _addr < (unsigned long)high_memory &&	\
+	pfn_valid(virt_to_pfn(_addr));					\
+})
 
 /*
  * On Book-E parts we need __va to parse the device tree and we can't
-- 
2.26.2

