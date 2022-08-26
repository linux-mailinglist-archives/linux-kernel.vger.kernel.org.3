Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A695A1EBF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 04:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244260AbiHZCWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 22:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiHZCWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:22:01 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B20DC9244;
        Thu, 25 Aug 2022 19:21:59 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MDNmJ6TPSzkWch;
        Fri, 26 Aug 2022 10:18:24 +0800 (CST)
Received: from huawei.com (10.67.174.96) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 26 Aug
 2022 10:21:57 +0800
From:   Zhang Jianhua <chris.zjh@huawei.com>
To:     <mmayer@broadcom.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>
CC:     <chris.zjh@huawei.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: bmips-cpufreq: Use module_init and add module_exit
Date:   Fri, 26 Aug 2022 10:18:45 +0800
Message-ID: <20220826021845.2283648-1-chris.zjh@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.96]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Use module_init instead of device_initcall.
- Add a function for module_exit to unregister driver.

Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>
---
 drivers/cpufreq/bmips-cpufreq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/bmips-cpufreq.c b/drivers/cpufreq/bmips-cpufreq.c
index f7c23fa468f0..21c0417c95e1 100644
--- a/drivers/cpufreq/bmips-cpufreq.c
+++ b/drivers/cpufreq/bmips-cpufreq.c
@@ -156,7 +156,7 @@ static struct cpufreq_driver bmips_cpufreq_driver = {
 	.name		= BMIPS_CPUFREQ_PREFIX,
 };
 
-static int __init bmips_cpufreq_probe(void)
+static int __init bmips_cpufreq_driver_init(void)
 {
 	struct cpufreq_compat *cc;
 	struct device_node *np;
@@ -176,7 +176,13 @@ static int __init bmips_cpufreq_probe(void)
 
 	return cpufreq_register_driver(&bmips_cpufreq_driver);
 }
-device_initcall(bmips_cpufreq_probe);
+module_init(bmips_cpufreq_driver_init);
+
+static void __exit bmips_cpufreq_driver_exit(void)
+{
+	cpufreq_unregister_driver(&bmips_cpufreq_driver);
+}
+module_exit(bmips_cpufreq_driver_exit)
 
 MODULE_AUTHOR("Markus Mayer <mmayer@broadcom.com>");
 MODULE_DESCRIPTION("CPUfreq driver for Broadcom BMIPS SoCs");
-- 
2.31.0

