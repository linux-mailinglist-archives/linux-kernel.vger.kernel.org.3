Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBCD047E122
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 11:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347631AbhLWKMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 05:12:06 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:30097 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242964AbhLWKMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 05:12:05 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JKQrg6bjFz1DKFD;
        Thu, 23 Dec 2021 18:08:51 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 23 Dec 2021 18:12:01 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 23 Dec 2021 18:12:01 +0800
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
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] Revert "mm/usercopy: Drop extra is_vmalloc_or_module() check"
Date:   Thu, 23 Dec 2021 18:21:26 +0800
Message-ID: <20211223102126.161848-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 517e1fbeb65f5eade8d14f46ac365db6c75aea9b.

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

When run ethtool eth0, the BUG occurred, the code shows below,

  data = vzalloc(array_size(gstrings.len, ETH_GSTRING_LEN));
  copy_to_user(useraddr, data, gstrings.len * ETH_GSTRING_LEN))

The data is alloced by vmalloc(),  virt_addr_valid(ptr) will return true
on PowerPC64, which leads to the panic, add back the is_vmalloc_or_module()
check to fix it.

Fixes: 517e1fbeb65f (mm/usercopy: Drop extra is_vmalloc_or_module() check)
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/usercopy.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/usercopy.c b/mm/usercopy.c
index b3de3c4eefba..cfc845403017 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -225,6 +225,17 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
 {
 	struct page *page;
 
+	/*
+	 * Some architectures (PowerPC64) return true for virt_addr_valid() on
+	 * vmalloced addresses. Work around this by checking for vmalloc
+	 * first.
+	 *
+	 * We also need to check for module addresses explicitly since we
+	 * may copy static data from modules to userspace
+	 */
+	if (is_vmalloc_or_module_addr(ptr))
+		return;
+
 	if (!virt_addr_valid(ptr))
 		return;
 
-- 
2.26.2

