Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6782B46FB70
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 08:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237596AbhLJHdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 02:33:18 -0500
Received: from mail-m974.mail.163.com ([123.126.97.4]:16974 "EHLO
        mail-m974.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237562AbhLJHdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:33:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=8Y9qB
        xZHdV969AvXdKfGOYRlIcUpg6gF/jWC9ccmJzY=; b=Ag6/PlPIUXY5qZLRqv2Bx
        hu5fDdvUaEks0/UkVY9Xo94TsptAaC6MkdLhDmc1vkDw8C8rW8Ox2N0g/Rzek22z
        kZDS5o8/KQDPP+fFKxpfcd5OcyVTX7EOXAfve4e1ABNdxNp5s1s8hi+L5VR1X3Xu
        zzCpW4J/bwBsIvsvfH4g4g=
Received: from localhost.localdomain (unknown [36.112.214.113])
        by smtp4 (Coremail) with SMTP id HNxpCgCn16u7AbNhasGzAw--.58303S4;
        Fri, 10 Dec 2021 15:29:20 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     daniel.lezcano@kernel.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] powercap: DTPM: Fix reference leak in cpuhp_dtpm_cpu_offline()
Date:   Fri, 10 Dec 2021 15:28:58 +0800
Message-Id: <20211210072858.20471-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgCn16u7AbNhasGzAw--.58303S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFyDXr1xWFy8Cw4Dtw48Crg_yoW8Cr4fpr
        s8K34Yv348tFWDG397J3WkXFyav3sFva9Ykry3Gr1rZa43JF1Fgw4DKryjqF1rCr1kCw13
        try5Xay8Gay5JFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jqLvtUUUUU=
X-Originating-IP: [36.112.214.113]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiWxBljFSIsgJsFAAAs2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In line 153 (#1), cpufreq_cpu_get() increments the kobject reference
counter of the policy it returned on success. According to the
document, the policy returned by cpufreq_cpu_get() has to be
released with the help of cpufreq_cpu_put() to balance its kobject
reference counter properly. Forgetting the cpufreq_cpu_put()
operation will result in reference leak.This bug influences all
stable versions from v5.15 to v5.15.7.

We can fix it by calling cpufreq_cpu_put() before the function
returns (#2, #3 and #4).

147 static int cpuhp_dtpm_cpu_offline(unsigned int cpu)
148 {
153     policy = cpufreq_cpu_get(cpu);
        // #1: reference increment

155     if (!policy)
156         return 0;

158     pd = em_cpu_get(cpu);
159     if (!pd)
160         return -EINVAL; // #2: missing reference decrement

166     if (cpumask_weight(policy->cpus) != 1)
167         return 0; // #3: missing reference decrement

174     return 0; // #4: missing reference decrement
175 }

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 drivers/powercap/dtpm_cpu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 51c366938acd..6c94515b21ef 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -156,21 +156,25 @@ static int cpuhp_dtpm_cpu_offline(unsigned int cpu)
 		return 0;
 
 	pd = em_cpu_get(cpu);
-	if (!pd)
+	if (!pd) {
+		cpufreq_cpu_put(policy);
 		return -EINVAL;
+	}
 
 	dtpm = per_cpu(dtpm_per_cpu, cpu);
 
 	power_sub(dtpm, pd);
 
-	if (cpumask_weight(policy->cpus) != 1)
+	if (cpumask_weight(policy->cpus) != 1) {
+		cpufreq_cpu_put(policy);
 		return 0;
+	}
 
 	for_each_cpu(cpu, policy->related_cpus)
 		per_cpu(dtpm_per_cpu, cpu) = NULL;
 
 	dtpm_unregister(dtpm);
-
+	cpufreq_cpu_put(policy);
 	return 0;
 }
 
-- 
2.25.1

