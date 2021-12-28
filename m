Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A6A4809A3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 14:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbhL1N3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 08:29:14 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:30187 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbhL1N3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 08:29:00 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JNb0R003Nz8w8Z;
        Tue, 28 Dec 2021 21:26:30 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 21:28:57 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 21:28:56 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        "John Donnelly" <John.p.donnelly@oracle.com>
Subject: [PATCH v19 03/13] kdump: make parse_crashkernel_{high|low}() static
Date:   Tue, 28 Dec 2021 21:26:02 +0800
Message-ID: <20211228132612.1860-4-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20211228132612.1860-1-thunder.leizhen@huawei.com>
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make parse_crashkernel_{high|low}() static, they are only referenced by
parse_crashkernel_high_low() in the same file. The latter is recommended.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 include/linux/crash_core.h | 4 ----
 kernel/crash_core.c        | 4 ++--
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 2d3a64761d18998..598fd55d83c169e 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -79,10 +79,6 @@ void final_note(Elf_Word *buf);
 
 int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
-int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
-		unsigned long long *crash_size, unsigned long long *crash_base);
-int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
-		unsigned long long *crash_size, unsigned long long *crash_base);
 int __init parse_crashkernel_high_low(char *cmdline,
 				      unsigned long long *high_size,
 				      unsigned long long *low_size);
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 8966beaf7c4fd52..3b9e01fc450b2a4 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -277,7 +277,7 @@ int __init parse_crashkernel(char *cmdline,
 					"crashkernel=", NULL);
 }
 
-int __init parse_crashkernel_high(char *cmdline,
+static int __init parse_crashkernel_high(char *cmdline,
 			     unsigned long long system_ram,
 			     unsigned long long *crash_size,
 			     unsigned long long *crash_base)
@@ -286,7 +286,7 @@ int __init parse_crashkernel_high(char *cmdline,
 				"crashkernel=", suffix_tbl[SUFFIX_HIGH]);
 }
 
-int __init parse_crashkernel_low(char *cmdline,
+static int __init parse_crashkernel_low(char *cmdline,
 			     unsigned long long system_ram,
 			     unsigned long long *crash_size,
 			     unsigned long long *crash_base)
-- 
2.25.1

