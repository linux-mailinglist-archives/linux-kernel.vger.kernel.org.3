Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3C352F94A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 08:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354675AbiEUGhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 02:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349685AbiEUGhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 02:37:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77021DA5E;
        Fri, 20 May 2022 23:37:17 -0700 (PDT)
Received: from kwepemi100004.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L4v4j1VY5zjWx6;
        Sat, 21 May 2022 14:36:21 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 kwepemi100004.china.huawei.com (7.221.188.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 21 May 2022 14:37:14 +0800
Received: from ubuntu1804.huawei.com (10.67.175.28) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 21 May 2022 14:37:14 +0800
From:   Yi Yang <yiyang13@huawei.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yiyang13@huawei.com>
Subject: [PATCH -next] cpufreq: Fix reserved space in cpufreq_show_cpus()
Date:   Sat, 21 May 2022 14:35:34 +0800
Message-ID: <20220521063534.138930-1-yiyang13@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.28]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function scnprintf() would reserve space for the trailing '\0' and return 
value is the number of characters written into buf not including the 
trailing '\0'. internally meaning the next scnprintf() would write begin 
the trailing '\0'. The code specifying "PAGE_SIZE - i - 2" here is trying 
to reserve space for "\n\0" which would cause scnprintf() to reserve an 
additional byte making the tail of the buf looks like this: "\n\0\0". 
Thus. we should reserve only the space for one '\0'. passing in 
"PAGE_SIZE - i - 1".

Additionally, each iteration would replace the trailing '\0' from the last 
iteration with a space, and append 4 additional bytes to the string making 
it a total of 5 additional bytes. That means we should stop printing into 
the buffer if the remaining size is less than 7 bytes(1 for the ' ', 4 for 
the %u and 2 for the tailing "\n\0")

Signed-off-by: Yi Yang <yiyang13@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1f6667ce43bd..60c005c9961e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -844,9 +844,9 @@ ssize_t cpufreq_show_cpus(const struct cpumask *mask, char *buf)
 
 	for_each_cpu(cpu, mask) {
 		if (i)
-			i += scnprintf(&buf[i], (PAGE_SIZE - i - 2), " ");
-		i += scnprintf(&buf[i], (PAGE_SIZE - i - 2), "%u", cpu);
-		if (i >= (PAGE_SIZE - 5))
+			i += scnprintf(&buf[i], (PAGE_SIZE - i - 1), " ");
+		i += scnprintf(&buf[i], (PAGE_SIZE - i - 1), "%u", cpu);
+		if (i >= (PAGE_SIZE - 6))
 			break;
 	}
 	i += sprintf(&buf[i], "\n");
-- 
2.17.1

