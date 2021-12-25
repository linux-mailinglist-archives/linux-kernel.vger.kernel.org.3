Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40D847F324
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 12:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhLYL5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 06:57:06 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:33914 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhLYL5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 06:57:04 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JLj845hQYzcc1r;
        Sat, 25 Dec 2021 19:56:36 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 25 Dec 2021 19:57:02 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 25 Dec 2021 19:57:01 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        "Mark Rutland" <mark.rutland@arm.com>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Paul Mackerras" <paulus@samba.org>,
        <linuxppc-dev@lists.ozlabs.org>
CC:     Nicholas Piggin <npiggin@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 1/2] powerpc: Fix virt_addr_valid() check
Date:   Sat, 25 Dec 2021 20:06:20 +0800
Message-ID: <20211225120621.13908-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211225120621.13908-1-wangkefeng.wang@huawei.com>
References: <20211225120621.13908-1-wangkefeng.wang@huawei.com>
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

When run ethtool eth0, the BUG occurred,

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
the virt_addr_valid().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/powerpc/include/asm/page.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 254687258f42..300d4c105a3a 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -132,7 +132,10 @@ static inline bool pfn_valid(unsigned long pfn)
 #define virt_to_page(kaddr)	pfn_to_page(virt_to_pfn(kaddr))
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
 
-#define virt_addr_valid(kaddr)	pfn_valid(virt_to_pfn(kaddr))
+#define virt_addr_valid(vaddr)	({						\
+	unsigned long _addr = (unsigned long)vaddr;				\
+	(unsigned long)(_addr) >= PAGE_OFFSET && pfn_valid(virt_to_pfn(_addr));	\
+})
 
 /*
  * On Book-E parts we need __va to parse the device tree and we can't
-- 
2.26.2

