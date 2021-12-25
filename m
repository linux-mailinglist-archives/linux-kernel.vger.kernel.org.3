Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A8E47F325
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 12:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhLYL5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 06:57:09 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:30110 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhLYL5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 06:57:04 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JLj4t03dTz1DK73;
        Sat, 25 Dec 2021 19:53:50 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 25 Dec 2021 19:57:02 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 25 Dec 2021 19:57:02 +0800
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
Subject: [PATCH v2 2/2] mm: usercopy: Warn vmalloc/module address in check_heap_object()
Date:   Sat, 25 Dec 2021 20:06:21 +0800
Message-ID: <20211225120621.13908-3-wangkefeng.wang@huawei.com>
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

virt_addr_valid() could be insufficient to validate the virt addr
on some architecture, which could lead to potential BUG which has
been found on arm64/powerpc64.

Let's add WARN_ON to check if the virt addr is passed virt_addr_valid()
but is a vmalloc/module address.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/usercopy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/usercopy.c b/mm/usercopy.c
index b3de3c4eefba..ce83e0b137dd 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -228,6 +228,8 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
 	if (!virt_addr_valid(ptr))
 		return;
 
+	WARN_ON_ONCE(is_vmalloc_or_module_addr(ptr));
+
 	/*
 	 * When CONFIG_HIGHMEM=y, kmap_to_page() will give either the
 	 * highmem page or fallback to virt_to_page(). The following
-- 
2.26.2

