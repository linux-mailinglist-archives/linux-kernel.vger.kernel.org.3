Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144674A5C1E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 13:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237955AbiBAMWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 07:22:20 -0500
Received: from foss.arm.com ([217.140.110.172]:36126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229892AbiBAMWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 07:22:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F814113E;
        Tue,  1 Feb 2022 04:22:19 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CCDC53F73B;
        Tue,  1 Feb 2022 04:22:17 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        coresight@lists.linaro.org
Subject: [PATCH] coresight: trbe: Move check for kernelspace unmapped at EL0 to probe
Date:   Tue,  1 Feb 2022 12:22:12 +0000
Message-Id: <20220201122212.3009461-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently with the check present in the module initialisation, it shouts
on all the systems irrespective of presence of coresight trace buffer
extensions.

Similar to Arm SPE perf driver, move the check for kernelspace unmapping
when running at EL0 to the device probe instead of module initialisation.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: coresight@lists.linaro.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 276862c07e32..3fe2ce1ba5bf 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -1423,6 +1423,11 @@ static int arm_trbe_device_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int ret;
 
+	if (arm64_kernel_unmapped_at_el0()) {
+		pr_err("TRBE wouldn't work if kernel gets unmapped at EL0\n");
+		return -EOPNOTSUPP;
+	}
+
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
@@ -1484,11 +1489,6 @@ static int __init arm_trbe_init(void)
 {
 	int ret;
 
-	if (arm64_kernel_unmapped_at_el0()) {
-		pr_err("TRBE wouldn't work if kernel gets unmapped at EL0\n");
-		return -EOPNOTSUPP;
-	}
-
 	ret = platform_driver_register(&arm_trbe_driver);
 	if (!ret)
 		return 0;
-- 
2.25.1

