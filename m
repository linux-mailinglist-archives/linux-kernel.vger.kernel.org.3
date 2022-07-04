Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355E65651F5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbiGDKRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbiGDKQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:16:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91B2ADF1F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:16:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB9D214BF;
        Mon,  4 Jul 2022 03:16:42 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7B65B3F792;
        Mon,  4 Jul 2022 03:16:40 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, conor.dooley@microchip.com,
        valentina.fernandezalanis@microchip.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Gavin Shan <gshan@redhat.com>
Subject: [PATCH v6 13/21] arch_topology: Set thread sibling cpumask only within the cluster
Date:   Mon,  4 Jul 2022 11:15:57 +0100
Message-Id: <20220704101605.1318280-14-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220704101605.1318280-1-sudeep.holla@arm.com>
References: <20220704101605.1318280-1-sudeep.holla@arm.com>
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

Currently the cluster identifier is not set on the DT based platforms.
The reset or default value is -1 for all the CPUs. Once we assign the
cluster identifier values correctly that may result in getting the thread
siblings wrong as the core identifiers can be same for 2 different CPUs
belonging to 2 different cluster.

So, in order to get the thread sibling cpumasks correct, we need to
update them only if the cores they belong are in the same cluster within
the socket. Let us skip updation of the thread sibling cpumaks if the
cluster identifier doesn't match.

This change won't affect even if the cluster identifiers are not set
currently but will avoid any breakage once we set the same correctly.

Tested-by: Gavin Shan <gshan@redhat.com>
Tested-by: Ionela Voinescu <ionela.voinescu@arm.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/arch_topology.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 8206990c679f..6ab173caf1dc 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -708,15 +708,17 @@ void update_siblings_masks(unsigned int cpuid)
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
2.37.0

