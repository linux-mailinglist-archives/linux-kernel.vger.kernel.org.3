Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F5B460FA4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 08:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241110AbhK2H5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 02:57:12 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:31919 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241805AbhK2HzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 02:55:12 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J2cxb5sT0zcbbD;
        Mon, 29 Nov 2021 15:51:47 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 15:51:53 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 15:51:52 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <guohanjun@huawei.com>, <wangxiongfeng2@huawei.com>
Subject: [PATCH] cpufreq: Fix get_cpu_device() failed in add_cpu_dev_symlink()
Date:   Mon, 29 Nov 2021 16:02:48 +0800
Message-ID: <20211129080248.46240-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I hot added a CPU, I found 'cpufreq' directory is not created below
/sys/devices/system/cpu/cpuX/. It is because get_cpu_device() failed in
add_cpu_dev_symlink().

cpufreq_add_dev() is the .add_dev callback of a CPU subsys interface. It
will be called when the CPU device registered into the system. The stack
is as follows.
  register_cpu()
  ->device_register()
   ->device_add()
    ->bus_probe_device()
     ->cpufreq_add_dev()

But only after the CPU device has been registered, we can get the CPU
device by get_cpu_device(), otherwise it will return NULL. Since we
already have the CPU device in cpufreq_add_dev(), pass it to
add_cpu_dev_symlink(). I noticed that the 'kobj' of the cpu device has
been added into the system before cpufreq_add_dev().

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e338d2f010fe..22aa2793e4d2 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1004,10 +1004,9 @@ static struct kobj_type ktype_cpufreq = {
 	.release	= cpufreq_sysfs_release,
 };
 
-static void add_cpu_dev_symlink(struct cpufreq_policy *policy, unsigned int cpu)
+static void add_cpu_dev_symlink(struct cpufreq_policy *policy, unsigned int cpu,
+				struct device *dev)
 {
-	struct device *dev = get_cpu_device(cpu);
-
 	if (unlikely(!dev))
 		return;
 
@@ -1391,7 +1390,7 @@ static int cpufreq_online(unsigned int cpu)
 	if (new_policy) {
 		for_each_cpu(j, policy->related_cpus) {
 			per_cpu(cpufreq_cpu_data, j) = policy;
-			add_cpu_dev_symlink(policy, j);
+			add_cpu_dev_symlink(policy, j, get_cpu_device(j));
 		}
 
 		policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
@@ -1565,7 +1564,7 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	/* Create sysfs link on CPU registration */
 	policy = per_cpu(cpufreq_cpu_data, cpu);
 	if (policy)
-		add_cpu_dev_symlink(policy, cpu);
+		add_cpu_dev_symlink(policy, cpu, dev);
 
 	return 0;
 }
-- 
2.20.1

