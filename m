Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5EC49C62B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238997AbiAZJVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:21:08 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:17814 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiAZJVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:21:07 -0500
Received: from kwepemi100017.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JkJ8K3QC7z920X;
        Wed, 26 Jan 2022 17:19:45 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 kwepemi100017.china.huawei.com (7.221.188.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 26 Jan 2022 17:21:05 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600010.china.huawei.com
 (7.193.23.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 26 Jan
 2022 17:21:04 +0800
From:   Chao Liu <liuchao173@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <hewenliang4@huawei.com>,
        <zhoukang7@huawei.com>
Subject: [PATCH] add cpu frequency to cpuinfo in arm64
Date:   Wed, 26 Jan 2022 09:18:53 +0000
Message-ID: <20220126091853.280826-1-liuchao173@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is cpu frequency in /proc/cpuinfo in x86 but not in arm64

Signed-off-by: Chao Liu <liuchao173@huawei.com>
---
 arch/arm64/kernel/cpuinfo.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 591c18a889a5..a5af899bebc9 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -24,6 +24,7 @@
 #include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/delay.h>
+#include <linux/cpufreq.h>
 
 /*
  * In case the boot CPU is hotpluggable, we record its initial state and
@@ -144,6 +145,7 @@ static int c_show(struct seq_file *m, void *v)
 	for_each_online_cpu(i) {
 		struct cpuinfo_arm64 *cpuinfo = &per_cpu(cpu_data, i);
 		u32 midr = cpuinfo->reg_midr;
+		unsigned int freq = cpufreq_quick_get(i);
 
 		/*
 		 * glibc reads /proc/cpuinfo to determine the number of
@@ -159,6 +161,11 @@ static int c_show(struct seq_file *m, void *v)
 			   loops_per_jiffy / (500000UL/HZ),
 			   loops_per_jiffy / (5000UL/HZ) % 100);
 
+
+		if (cpu_freq)
+			seq_printf(m, "cpu MHz\t\t: %u.%03u\n",
+				   freq / 1000, (freq % 1000));
+
 		/*
 		 * Dump out the common processor features in a single line.
 		 * Userspace should read the hwcaps with getauxval(AT_HWCAP)
-- 
2.23.0

