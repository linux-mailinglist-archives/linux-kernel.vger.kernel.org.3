Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44482525F15
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379063AbiEMJes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 05:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378578AbiEMJen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 05:34:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A093527B30B
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 02:34:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10419143D;
        Fri, 13 May 2022 02:34:41 -0700 (PDT)
Received: from e125579.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AC8B53F73D;
        Fri, 13 May 2022 02:34:39 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] topology: Remove unused cpu_cluster_mask()
Date:   Fri, 13 May 2022 11:34:33 +0200
Message-Id: <20220513093433.425163-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.25.1
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

default_topology[] uses cpu_clustergroup_mask() for the CLS level
(guarded by CONFIG_SCHED_CLUSTER) which is currently provided by x86
(arch/x86/kernel/smpboot.c) and arm64 (drivers/base/arch_topology.c).

Fixes: 778c558f49a2c ("sched: Add cluster scheduler level in core and
related Kconfig for ARM64")

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 include/linux/topology.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/topology.h b/include/linux/topology.h
index f19bc3626297..4564faafd0e1 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -240,13 +240,6 @@ static inline const struct cpumask *cpu_smt_mask(int cpu)
 }
 #endif
 
-#if defined(CONFIG_SCHED_CLUSTER) && !defined(cpu_cluster_mask)
-static inline const struct cpumask *cpu_cluster_mask(int cpu)
-{
-	return topology_cluster_cpumask(cpu);
-}
-#endif
-
 static inline const struct cpumask *cpu_cpu_mask(int cpu)
 {
 	return cpumask_of_node(cpu_to_node(cpu));
-- 
2.25.1

