Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2CF47F289
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 08:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhLYH0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 02:26:38 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16859 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbhLYH0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 02:26:36 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JLb7T1dqfz91nM;
        Sat, 25 Dec 2021 15:25:41 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 25 Dec 2021 15:26:34 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 25 Dec 2021 15:26:32 +0800
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
Subject: [PATCH 1/4] kdump: add helper parse_crashkernel_high_low()
Date:   Sat, 25 Dec 2021 15:23:24 +0800
Message-ID: <20211225072327.1807-2-thunder.leizhen@huawei.com>
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

The bootup command line option crashkernel=Y,low is valid only when
crashkernel=X,high is specified. Putting their parsing into a separate
function makes the code logic clearer and easier to understand the strong
dependencies between them.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 include/linux/crash_core.h |  3 +++
 kernel/crash_core.c        | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index de62a722431e7db..2d3a64761d18998 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -83,5 +83,8 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
+int __init parse_crashkernel_high_low(char *cmdline,
+				      unsigned long long *high_size,
+				      unsigned long long *low_size);
 
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index eb53f5ec62c900f..8ab59a0e04f178f 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -295,6 +295,41 @@ int __init parse_crashkernel_low(char *cmdline,
 				"crashkernel=", suffix_tbl[SUFFIX_LOW]);
 }
 
+/**
+ * parse_crashkernel_high_low - Parsing "crashkernel=X,high" and possible
+ *				"crashkernel=Y,low".
+ * @cmdline:	The bootup command line.
+ * @high_size:	Save the memory size specified by "crashkernel=X,high".
+ * @low_size:	Save the memory size specified by "crashkernel=Y,low" or "-1"
+		if it's not specified.
+ *
+ * Returns 0 on success, else a negative status code.
+ */
+int __init parse_crashkernel_high_low(char *cmdline,
+				      unsigned long long *high_size,
+				      unsigned long long *low_size)
+{
+	int ret;
+	unsigned long long base;
+
+	BUG_ON(!high_size || !low_size);
+
+	/* crashkernel=X,high */
+	ret = parse_crashkernel_high(cmdline, 0, high_size, &base);
+	if (ret)
+		return ret;
+
+	if (*high_size <= 0)
+		return -EINVAL;
+
+	/* crashkernel=Y,low */
+	ret = parse_crashkernel_low(cmdline, 0, low_size, &base);
+	if (ret)
+		*low_size = -1;
+
+	return 0;
+}
+
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
-- 
2.25.1

