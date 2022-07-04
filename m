Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17745651F7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbiGDKR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbiGDKQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:16:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C75C7D10F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:16:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E25C723A;
        Mon,  4 Jul 2022 03:16:44 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 945C43F792;
        Mon,  4 Jul 2022 03:16:42 -0700 (PDT)
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
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gavin Shan <gshan@redhat.com>
Subject: [PATCH v6 14/21] arch_topology: Check for non-negative value rather than -1 for IDs validity
Date:   Mon,  4 Jul 2022 11:15:58 +0100
Message-Id: <20220704101605.1318280-15-sudeep.holla@arm.com>
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

Instead of just comparing the cpu topology IDs with -1 to check their
validity, improve that by checking for a valid non-negative value.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Tested-by: Ionela Voinescu <ionela.voinescu@arm.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/arch_topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 6ab173caf1dc..c0b0ee64a79d 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -642,7 +642,7 @@ static int __init parse_dt_topology(void)
 	 * only mark cores described in the DT as possible.
 	 */
 	for_each_possible_cpu(cpu)
-		if (cpu_topology[cpu].package_id == -1)
+		if (cpu_topology[cpu].package_id < 0)
 			ret = -EINVAL;
 
 out_map:
@@ -714,7 +714,7 @@ void update_siblings_masks(unsigned int cpuid)
 		if (cpuid_topo->cluster_id != cpu_topo->cluster_id)
 			continue;
 
-		if (cpuid_topo->cluster_id != -1) {
+		if (cpuid_topo->cluster_id >= 0) {
 			cpumask_set_cpu(cpu, &cpuid_topo->cluster_sibling);
 			cpumask_set_cpu(cpuid, &cpu_topo->cluster_sibling);
 		}
-- 
2.37.0

