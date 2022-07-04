Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F108E5651FF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbiGDKSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbiGDKQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:16:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0482ADFCC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:16:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EF1C23A;
        Mon,  4 Jul 2022 03:16:51 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E61003F792;
        Mon,  4 Jul 2022 03:16:48 -0700 (PDT)
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
        linux-riscv@lists.infradead.org,
        Darren Hart <darren@os.amperecomputing.com>
Subject: [PATCH v6 17/21] arch_topology: Limit span of cpu_clustergroup_mask()
Date:   Mon,  4 Jul 2022 11:16:01 +0100
Message-Id: <20220704101605.1318280-18-sudeep.holla@arm.com>
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

From: Ionela Voinescu <ionela.voinescu@arm.com>

Currently the cluster identifier is not set on DT based platforms.
The reset or default value is -1 for all the CPUs. Once we assign the
cluster identifier values correctly, the cluster_sibling mask will be
populated and returned by cpu_clustergroup_mask() to contribute in the
creation of the CLS scheduling domain level, if SCHED_CLUSTER is
enabled.

To avoid topologies that will result in questionable or incorrect
scheduling domains, impose restrictions regarding the span of clusters,
as presented to scheduling domains building code: cluster_sibling should
not span more or the same CPUs as cpu_coregroup_mask().

This is needed in order to obtain a strict separation between the MC and
CLS levels, and maintain the same domains for existing platforms in
the presence of CONFIG_SCHED_CLUSTER, where the new cluster information
is redundant and irrelevant for the scheduler.

While previously the scheduling domain builder code would have removed MC
as redundant and kept CLS if SCHED_CLUSTER was enabled and the
cpu_coregroup_mask() and cpu_clustergroup_mask() spanned the same CPUs,
now CLS will be removed and MC kept.

Cc: Darren Hart <darren@os.amperecomputing.com>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/arch_topology.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index e384afb6cac7..591c1f8e15e2 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -686,6 +686,14 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
 
 const struct cpumask *cpu_clustergroup_mask(int cpu)
 {
+	/*
+	 * Forbid cpu_clustergroup_mask() to span more or the same CPUs as
+	 * cpu_coregroup_mask().
+	 */
+	if (cpumask_subset(cpu_coregroup_mask(cpu),
+			   &cpu_topology[cpu].cluster_sibling))
+		return get_cpu_mask(cpu);
+
 	return &cpu_topology[cpu].cluster_sibling;
 }
 
-- 
2.37.0

