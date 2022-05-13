Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E93526798
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 18:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382620AbiEMQvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 12:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382695AbiEMQvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 12:51:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E67C55253A
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:50:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65C6F113E;
        Fri, 13 May 2022 09:50:53 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1E9E33F73D;
        Fri, 13 May 2022 09:50:52 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>
Subject: [UPDATED] [PATCH 2/4] arch_topology: Set thread sibling cpumask only within the cluster
Date:   Fri, 13 May 2022 17:50:41 +0100
Message-Id: <20220513165041.1163308-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220513095559.1034633-3-sudeep.holla@arm.com>
References: <20220513095559.1034633-3-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the cluster identifier is not set on the DT based platforms.
The reset or default value is -1 for all the CPUs. Once we assign the
cluster identifier values correctly that imay result in getting the thread
siblings wrongs as the core identifiers can be same for 2 different CPUs
belonging to 2 different cluster.

So, in order to get the thread sibling cpumasks correct, we need to
update them only if the cores they belong are in the same cluster within
the socket. Let us skip updation of the thread sibling cpumaks if the
cluster identifier doesn't match.

This change won't affect even if the cluster identifiers are not set
currently but will avoid any breakage once we set the same correctly.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/arch_topology.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

I seem to have not included the fix I did after testing the patches. This
version is updated to fix the issue with the original 2/4

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 44f733b365cc..7f5aa655c1f4 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -697,15 +697,17 @@ void update_siblings_masks(unsigned int cpuid)
 		if (cpuid_topo->package_id != cpu_topo->package_id)
 			continue;
 
-		if (cpuid_topo->cluster_id == cpu_topo->cluster_id &&
-		    cpuid_topo->cluster_id != -1) {
+		cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
+		cpumask_set_cpu(cpu, &cpuid_topo->core_sibling);
+
+		if (cpuid_topo->cluster_id != cpu_topo->cluster_id)
+			continue;
+
+		if (cpuid_topo->cluster_id != -1) {
 			cpumask_set_cpu(cpu, &cpuid_topo->cluster_sibling);
 			cpumask_set_cpu(cpuid, &cpu_topo->cluster_sibling);
 		}
 
-		cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
-		cpumask_set_cpu(cpu, &cpuid_topo->core_sibling);
-
 		if (cpuid_topo->core_id != cpu_topo->core_id)
 			continue;
 
-- 
2.36.1

