Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA01049C641
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239087AbiAZJ0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:26:03 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:32060 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiAZJ0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:26:02 -0500
Received: from kwepemi100012.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JkJC20RGtz1FD1X;
        Wed, 26 Jan 2022 17:22:06 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 kwepemi100012.china.huawei.com (7.221.188.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 26 Jan 2022 17:26:00 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600010.china.huawei.com
 (7.193.23.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 26 Jan
 2022 17:25:59 +0800
From:   Chao Liu <liuchao173@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <hewenliang4@huawei.com>,
        <zhoukang7@huawei.com>
Subject: [PATCH v2] add cpu frequency to cpuinfo in arm64
Date:   Wed, 26 Jan 2022 09:23:49 +0000
Message-ID: <20220126092349.285642-1-liuchao173@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is cpu frequency in /proc/cpuinfo in x86 but not in arm64

Signed-off-by: Chao Liu <liuchao173@huawei.com>
---
Change in v2:
- fix spelling errors and remove remove redundant blank line

 arch/arm64/kernel/cpuinfo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 591c18a889a5..39a36e6e8079 100644
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
@@ -159,6 +161,10 @@ static int c_show(struct seq_file *m, void *v)
 			   loops_per_jiffy / (500000UL/HZ),
 			   loops_per_jiffy / (5000UL/HZ) % 100);
 
+		if (freq)
+			seq_printf(m, "cpu MHz\t\t: %u.%03u\n",
+				   freq / 1000, (freq % 1000));
+
 		/*
 		 * Dump out the common processor features in a single line.
 		 * Userspace should read the hwcaps with getauxval(AT_HWCAP)
-- 
2.23.0

