Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088C247F5DB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 09:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhLZI3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 03:29:51 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15976 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbhLZI3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 03:29:50 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JMDRG17z7zZdj1;
        Sun, 26 Dec 2021 16:26:34 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 26 Dec 2021 16:29:48 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 26 Dec 2021 16:29:47 +0800
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
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 0/3] mm: support huge vmalloc mapping on arm64/x86
Date:   Sun, 26 Dec 2021 16:39:09 +0800
Message-ID: <20211226083912.166512-1-wangkefeng.wang@huawei.com>
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

huge vmalloc mappings is supported on PPC[1], but this feature should
be not only used on PPC, it could be used on arch support HAVE_ARCH_HUGE_VMAP
and PMD sized vmap mappings. this patchset is to enable this feature
on arm64/x86.

The first patch is to let user to control huge vmalloc mapping default
behavior and then enable this feature on arm64/x86.

The PPC is enabled by default(it selects HUGE_VMALLOC_DEFAULT_ENABLED),
but arm64/x86 should use hugevmalloc=on to enable this feature.

NOTE:
1) nohugevmalloc parameter is still supported, the first patch is in
   case of archs don't want to this feature enabled by default.
2) if people don't like this, we could drop the first patch.

[1] https://lore.kernel.org/linux-mm/20210317062402.533919-1-npiggin@gmail.com/

Kefeng Wang (3):
  mm: vmalloc: Let user to control huge vmalloc default behavior
  arm64: Support huge vmalloc mappings
  x86: Support huge vmalloc mappings

 .../admin-guide/kernel-parameters.txt          | 14 +++++++++++++-
 arch/arm64/Kconfig                             |  1 +
 arch/powerpc/Kconfig                           |  1 +
 arch/x86/Kconfig                               |  1 +
 mm/Kconfig                                     |  7 +++++++
 mm/vmalloc.c                                   | 18 +++++++++++++++++-
 6 files changed, 40 insertions(+), 2 deletions(-)

-- 
2.26.2

