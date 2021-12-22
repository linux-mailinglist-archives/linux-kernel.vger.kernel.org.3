Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31D147D2E0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240808AbhLVNM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:12:58 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15963 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245359AbhLVNMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:12:33 -0500
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JJtvP5yZHzZdSQ;
        Wed, 22 Dec 2021 21:09:21 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 21:12:30 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 21:12:29 +0800
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
Subject: [PATCH v18 12/17] kdump: Reduce unused parameters of parse_crashkernel_{high|low}
Date:   Wed, 22 Dec 2021 21:08:15 +0800
Message-ID: <20211222130820.1754-13-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20211222130820.1754-1-thunder.leizhen@huawei.com>
References: <20211222130820.1754-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameters 'system_ram' and 'crash_base' is only needed by the case of
"crashkernel=X@[offset]". The argument list of parse_crashkernel_suffix()
can help prove this point.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/crash_core.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index a037076b89a9bb2..67f5065e3c3cfcc 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -288,19 +288,19 @@ int __init parse_crashkernel(char *cmdline,
 
 #ifdef CONFIG_64BIT
 static int __init parse_crashkernel_high(char *cmdline,
-			     unsigned long long system_ram,
-			     unsigned long long *crash_size,
-			     unsigned long long *crash_base)
+					 unsigned long long *crash_size)
 {
-	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base, SUFFIX_HIGH);
+	unsigned long long base;
+
+	return __parse_crashkernel(cmdline, 0, crash_size, &base, SUFFIX_HIGH);
 }
 
 static int __init parse_crashkernel_low(char *cmdline,
-			     unsigned long long system_ram,
-			     unsigned long long *crash_size,
-			     unsigned long long *crash_base)
+					unsigned long long *crash_size)
 {
-	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base, SUFFIX_LOW);
+	unsigned long long base;
+
+	return __parse_crashkernel(cmdline, 0, crash_size, &base, SUFFIX_LOW);
 }
 
 static int __init reserve_crashkernel_low(unsigned long long low_size)
@@ -368,14 +368,14 @@ static int __init parse_crashkernel_in_order(char *cmdline,
 
 #ifdef CONFIG_64BIT
 	/* crashkernel=X,high */
-	ret = parse_crashkernel_high(cmdline, system_ram, crash_size, crash_base);
+	ret = parse_crashkernel_high(cmdline, crash_size);
 	if (ret || crash_size <= 0)
 		return CRASHKERNEL_MEM_NONE;
 
 	flag = CRASHKERNEL_MEM_HIGH;
 
 	/* crashkernel=Y,low */
-	ret = parse_crashkernel_low(cmdline, system_ram, low_size, crash_base);
+	ret = parse_crashkernel_low(cmdline, low_size);
 	if (!ret)
 		flag |= CRASHKERNEL_MEM_LOW;
 #endif
-- 
2.25.1

