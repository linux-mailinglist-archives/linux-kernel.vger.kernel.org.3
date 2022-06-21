Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029FA553A65
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 21:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353665AbiFUTWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 15:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353472AbiFUTVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 15:21:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0F651163
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 12:21:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C371E1688;
        Tue, 21 Jun 2022 12:21:19 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CCC8B3F792;
        Tue, 21 Jun 2022 12:21:17 -0700 (PDT)
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
        linux-riscv@lists.infradead.org
Subject: [PATCH v4 16/20] arch_topology: Drop unnecessary check for uninitialised package_id
Date:   Tue, 21 Jun 2022 20:20:30 +0100
Message-Id: <20220621192034.3332546-17-sudeep.holla@arm.com>
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

With the support of socket node parsing from the device tree and
assigning 0 as package_id in absence of socket nodes, there is no need
to check for invalid package_id. It is always initialised to 0 or values
from the device tree socket nodes.

Just drop that now redundant check for uninitialised package_id.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/arch_topology.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 46fa1b70b02b..42448a5a9412 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -611,7 +611,6 @@ static int __init parse_dt_topology(void)
 {
 	struct device_node *cn, *map;
 	int ret = 0;
-	int cpu;
 
 	cn = of_find_node_by_path("/cpus");
 	if (!cn) {
@@ -633,16 +632,6 @@ static int __init parse_dt_topology(void)
 
 	topology_normalize_cpu_scale();
 
-	/*
-	 * Check that all cores are in the topology; the SMP code will
-	 * only mark cores described in the DT as possible.
-	 */
-	for_each_possible_cpu(cpu)
-		if (cpu_topology[cpu].package_id < 0) {
-			ret = -EINVAL;
-			break;
-		}
-
 out_map:
 	of_node_put(map);
 out:
-- 
2.36.1

