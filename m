Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB5A47D2D9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240787AbhLVNMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:12:50 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15962 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245346AbhLVNMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:12:30 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JJtvM4003zZdj9;
        Wed, 22 Dec 2021 21:09:19 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 21:12:28 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 21:12:27 +0800
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
Subject: [PATCH v18 10/17] kdump: Simplify the parameters of __parse_crashkernel()
Date:   Wed, 22 Dec 2021 21:08:13 +0800
Message-ID: <20211222130820.1754-11-thunder.leizhen@huawei.com>
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

After commit adbc742bf786 ("x86, kdump: Change crashkernel_high/low= to
crashkernel=,high/low"), all kdump bootup parameters start with
"crashkernel=". Therefore, it is better for __parse_crashkernel() to use
it directly than for the caller to pass it. So the parameter 'name' can
be omitted.

Similarly, we can pass the suffix type instead of the suffix name to avoid
the global variable 'suffix_tbl' appearing in multiple places.

There is no change in functionality, but it makes the code look a little
more concise.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/crash_core.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 64ed082382f3f18..496dae2718cf026 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -233,11 +233,12 @@ static int __init __parse_crashkernel(char *cmdline,
 			     unsigned long long system_ram,
 			     unsigned long long *crash_size,
 			     unsigned long long *crash_base,
-			     const char *name,
-			     const char *suffix)
+			     int suffix_type)
 {
 	char	*first_colon, *first_space;
 	char	*ck_cmdline;
+	const char *name = "crashkernel=";
+	const char *suffix = suffix_tbl[suffix_type];
 
 	BUG_ON(!crash_size || !crash_base);
 	*crash_size = 0;
@@ -275,8 +276,7 @@ int __init parse_crashkernel(char *cmdline,
 			     unsigned long long *crash_size,
 			     unsigned long long *crash_base)
 {
-	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
-					"crashkernel=", NULL);
+	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base, SUFFIX_NULL);
 }
 
 int __init parse_crashkernel_high(char *cmdline,
@@ -284,8 +284,7 @@ int __init parse_crashkernel_high(char *cmdline,
 			     unsigned long long *crash_size,
 			     unsigned long long *crash_base)
 {
-	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
-				"crashkernel=", suffix_tbl[SUFFIX_HIGH]);
+	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base, SUFFIX_HIGH);
 }
 
 int __init parse_crashkernel_low(char *cmdline,
@@ -293,8 +292,7 @@ int __init parse_crashkernel_low(char *cmdline,
 			     unsigned long long *crash_size,
 			     unsigned long long *crash_base)
 {
-	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
-				"crashkernel=", suffix_tbl[SUFFIX_LOW]);
+	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base, SUFFIX_LOW);
 }
 
 /*
-- 
2.25.1

