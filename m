Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE9947F323
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 12:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhLYL5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 06:57:04 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:29287 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhLYL5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 06:57:03 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JLj834bjHzbjRx;
        Sat, 25 Dec 2021 19:56:35 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 25 Dec 2021 19:57:01 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 25 Dec 2021 19:57:00 +0800
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
Subject: [PATCH v2 0/2] mm: Fix kernel BUG in __check_heap_object() on PowerPC64
Date:   Sat, 25 Dec 2021 20:06:19 +0800
Message-ID: <20211225120621.13908-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
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

v2:
- Fix powerpc virt_addr_valid() instead of workaround in
  check_heap_object(), suggested by Christophe and Nicholas
- Add WARN_ON in check_heap_object() incase of virt_addr_valid is
  insufficient on some archs

Kefeng Wang (2):
  powerpc: Fix virt_addr_valid() check
  mm: usercopy: Warn vmalloc/module address in check_heap_object()

 arch/powerpc/include/asm/page.h | 5 ++++-
 mm/usercopy.c                   | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.26.2

