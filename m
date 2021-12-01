Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3C64647AD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347137AbhLAHQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:16:06 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:27326 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347108AbhLAHQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:16:04 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J3qzQ74hbzbj8r;
        Wed,  1 Dec 2021 15:12:34 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 15:12:42 +0800
Received: from huawei.com (10.175.100.227) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 1 Dec
 2021 15:12:41 +0800
From:   Tang Yizhou <tangyizhou@huawei.com>
To:     <viresh.kumar@linaro.org>, <rafael.j.wysocki@intel.com>,
        <rafael@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhengbin13@huawei.com>, Tang Yizhou <tangyizhou@huawei.com>
Subject: [PATCH v3 1/2] cpufreq: Fix a comment in cpufreq_policy_free
Date:   Wed, 1 Dec 2021 15:40:20 +0800
Message-ID: <20211201074021.18097-2-tangyizhou@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211201074021.18097-1-tangyizhou@huawei.com>
References: <20211201074021.18097-1-tangyizhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the comment of blocking_notifier_call_chain() easier to
understand.

Signed-off-by: Tang Yizhou <tangyizhou@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e338d2f010fe..db0b4b4258d5 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1296,8 +1296,9 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 
 	if (policy->max_freq_req) {
 		/*
-		 * CPUFREQ_CREATE_POLICY notification is sent only after
-		 * successfully adding max_freq_req request.
+		 * Remove max_freq_req after sending CPUFREQ_REMOVE_POLICY
+		 * notification, since CPUFREQ_CREATE_POLICY notification was
+		 * sent after adding max_freq_req earlier.
 		 */
 		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 					     CPUFREQ_REMOVE_POLICY, policy);
-- 
2.17.1

