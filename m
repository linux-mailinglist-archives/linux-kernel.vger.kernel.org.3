Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA75D553A5D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 21:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353182AbiFUTU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 15:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352447AbiFUTUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 15:20:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75BB427B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 12:20:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B4D9168F;
        Tue, 21 Jun 2022 12:20:50 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 62B853F792;
        Tue, 21 Jun 2022 12:20:48 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Gavin Shan <gshan@redhat.com>
Subject: [PATCH v4 02/20] cacheinfo: Use of_cpu_device_node_get instead cpu_dev->of_node
Date:   Tue, 21 Jun 2022 20:20:16 +0100
Message-Id: <20220621192034.3332546-3-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621192034.3332546-1-sudeep.holla@arm.com>
References: <20220621192034.3332546-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_cpu_device_node_get takes care of fetching the CPU'd device node
either from cached cpu_dev->of_node if cpu_dev is initialised or uses
of_get_cpu_node to parse and fetch node if cpu_dev isn't available yet.

Just use of_cpu_device_node_get instead of getting the cpu device first
and then using cpu_dev->of_node for two reasons:
1. There is no other use of cpu_dev and can be simplified
2. It enabled the use detect_cache_attributes and hence cache_setup_of_node
   much earlier before the CPUs are registered as devices.

Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/cacheinfo.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index dad296229161..b0bde272e2ae 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -14,7 +14,7 @@
 #include <linux/cpu.h>
 #include <linux/device.h>
 #include <linux/init.h>
-#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
@@ -157,7 +157,6 @@ static int cache_setup_of_node(unsigned int cpu)
 {
 	struct device_node *np;
 	struct cacheinfo *this_leaf;
-	struct device *cpu_dev = get_cpu_device(cpu);
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	unsigned int index = 0;
 
@@ -166,11 +165,7 @@ static int cache_setup_of_node(unsigned int cpu)
 		return 0;
 	}
 
-	if (!cpu_dev) {
-		pr_err("No cpu device for CPU %d\n", cpu);
-		return -ENODEV;
-	}
-	np = cpu_dev->of_node;
+	np = of_cpu_device_node_get(cpu);
 	if (!np) {
 		pr_err("Failed to find cpu%d device node\n", cpu);
 		return -ENOENT;
-- 
2.36.1

