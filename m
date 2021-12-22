Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F54747D2C6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245384AbhLVNMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:12:38 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16851 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245305AbhLVNMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:12:24 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JJtxw0zbpz91s6;
        Wed, 22 Dec 2021 21:11:32 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 21:12:22 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 21:12:21 +0800
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
Subject: [PATCH v18 04/17] x86/setup: Add helper parse_crashkernel_in_order()
Date:   Wed, 22 Dec 2021 21:08:07 +0800
Message-ID: <20211222130820.1754-5-thunder.leizhen@huawei.com>
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

Currently, there are two possible combinations of configurations.
(1) crashkernel=X[@offset]
(2) crashkernel=X,high, with or without crashkernel=X,low

(1) has the highest priority, if it is configured correctly, (2) will be
ignored. Similarly, in combination (2), crashkernel=X,low is valid only
when crashkernel=X,high is valid.

Putting the operations of parsing all "crashkernel=" configurations in one
function helps to sort out the strong dependency.

So add helper parse_crashkernel_in_order(). The "__maybe_unused" will be
removed in the next patch.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/x86/kernel/setup.c | 51 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d9080bfa131a654..f997074d36f2484 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -439,6 +439,57 @@ static int __init reserve_crashkernel_low(void)
 }
 #endif
 
+#define CRASHKERNEL_MEM_NONE		0x0	/* crashkernel= is not exist or invalid */
+#define CRASHKERNEL_MEM_CLASSIC		0x1	/* crashkernel=X[@offset] is valid */
+#define CRASHKERNEL_MEM_HIGH		0x2	/* crashkernel=X,high is valid */
+#define CRASHKERNEL_MEM_LOW		0x4	/* crashkernel=X,low is valid */
+
+/**
+ * parse_crashkernel_in_order - Parse all "crashkernel=" configurations in
+ *				priority order until a valid combination is found.
+ * @cmdline:	The bootup command line.
+ * @system_ram: Total system memory size.
+ * @crash_size: Save the memory size specified by "crashkernel=X[@offset]" or
+ *		"crashkernel=X,high".
+ * @crash_base: Save the base address specified by "crashkernel=X@offset"
+ * @low_size:	Save the memory size specified by "crashkernel=X,low"
+ *
+ * Returns the status flag of the parsing result of "crashkernel=", such as
+ * CRASHKERNEL_MEM_NONE, CRASHKERNEL_MEM_HIGH.
+ */
+__maybe_unused
+static int __init parse_crashkernel_in_order(char *cmdline,
+					     unsigned long long system_ram,
+					     unsigned long long *crash_size,
+					     unsigned long long *crash_base,
+					     unsigned long long *low_size)
+{
+	int ret, flag = CRASHKERNEL_MEM_NONE;
+
+	BUG_ON(!crash_size || !crash_base || !low_size);
+
+	/* crashkernel=X[@offset] */
+	ret = parse_crashkernel(cmdline, system_ram, crash_size, crash_base);
+	if (!ret && crash_size > 0)
+		return CRASHKERNEL_MEM_CLASSIC;
+
+#ifdef CONFIG_X86_64
+	/* crashkernel=X,high */
+	ret = parse_crashkernel_high(cmdline, system_ram, crash_size, crash_base);
+	if (ret || crash_size <= 0)
+		return CRASHKERNEL_MEM_NONE;
+
+	flag = CRASHKERNEL_MEM_HIGH;
+
+	/* crashkernel=Y,low */
+	ret = parse_crashkernel_low(cmdline, system_ram, low_size, crash_base);
+	if (!ret)
+		flag |= CRASHKERNEL_MEM_LOW;
+#endif
+
+	return flag;
+}
+
 static void __init reserve_crashkernel(void)
 {
 	unsigned long long crash_size, crash_base, total_mem;
-- 
2.25.1

