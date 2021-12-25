Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD33D47F290
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 08:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhLYH0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 02:26:47 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16861 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhLYH0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 02:26:40 -0500
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JLb7Y2GlNz91t2;
        Sat, 25 Dec 2021 15:25:45 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 25 Dec 2021 15:26:37 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 25 Dec 2021 15:26:36 +0800
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
Subject: [PATCH 4/4] kdump: reduce unnecessary parameters of parse_crashkernel_{high|low}()
Date:   Sat, 25 Dec 2021 15:23:27 +0800
Message-ID: <20211225072327.1807-5-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20211225072327.1807-1-thunder.leizhen@huawei.com>
References: <20211225072327.1807-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete confusing parameters 'system_ram' and 'crash_base' of
parse_crashkernel_{high|low}(), they are only needed by the case of
"crashkernel=X@[offset]".

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/crash_core.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 97001820396295e..0ebf5efce3119c5 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -278,20 +278,20 @@ int __init parse_crashkernel(char *cmdline,
 }
 
 static int __init parse_crashkernel_high(char *cmdline,
-			     unsigned long long system_ram,
-			     unsigned long long *crash_size,
-			     unsigned long long *crash_base)
+					 unsigned long long *crash_size)
 {
-	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
+	unsigned long long base;
+
+	return __parse_crashkernel(cmdline, 0, crash_size, &base,
 				"crashkernel=", suffix_tbl[SUFFIX_HIGH]);
 }
 
 static int __init parse_crashkernel_low(char *cmdline,
-			     unsigned long long system_ram,
-			     unsigned long long *crash_size,
-			     unsigned long long *crash_base)
+					unsigned long long *crash_size)
 {
-	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
+	unsigned long long base;
+
+	return __parse_crashkernel(cmdline, 0, crash_size, &base,
 				"crashkernel=", suffix_tbl[SUFFIX_LOW]);
 }
 
@@ -310,12 +310,11 @@ int __init parse_crashkernel_high_low(char *cmdline,
 				      unsigned long long *low_size)
 {
 	int ret;
-	unsigned long long base;
 
 	BUG_ON(!high_size || !low_size);
 
 	/* crashkernel=X,high */
-	ret = parse_crashkernel_high(cmdline, 0, high_size, &base);
+	ret = parse_crashkernel_high(cmdline, high_size);
 	if (ret)
 		return ret;
 
@@ -323,7 +322,7 @@ int __init parse_crashkernel_high_low(char *cmdline,
 		return -EINVAL;
 
 	/* crashkernel=Y,low */
-	ret = parse_crashkernel_low(cmdline, 0, low_size, &base);
+	ret = parse_crashkernel_low(cmdline, low_size);
 	if (ret)
 		*low_size = -1;
 
-- 
2.25.1

