Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE0A52B752
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbiERJeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbiERJd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:33:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A6B5AFB36
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:33:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8A471063;
        Wed, 18 May 2022 02:33:54 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5378B3F66F;
        Wed, 18 May 2022 02:33:53 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Atish Patra <atishp@atishpatra.org>, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Atish Patra <atishp@rivosinc.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 1/8] arch_topology: Don't set cluster identifier as physical package identifier
Date:   Wed, 18 May 2022 10:33:18 +0100
Message-Id: <20220518093325.2070336-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220518093325.2070336-1-sudeep.holla@arm.com>
References: <20220518093325.2070336-1-sudeep.holla@arm.com>
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

Currently as we parse the CPU topology from /cpu-map node from the
device tree, we assign generated cluster count as the physical package
identifier for each CPU which is wrong.

The device tree bindings for CPU topology supports sockets to infer
the socket or physical package identifier for a given CPU. Since it is
fairly new and not support on most of the old and existing systems, we
can assume all such systems have single socket/physical package.

Fix the physical package identifier to 0 by removing the assignment of
cluster identifier to the same.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/arch_topology.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index f73b836047cf..44f733b365cc 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -543,7 +543,6 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
 	bool leaf = true;
 	bool has_cores = false;
 	struct device_node *c;
-	static int package_id __initdata;
 	int core_id = 0;
 	int i, ret;
 
@@ -582,7 +581,7 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
 			}
 
 			if (leaf) {
-				ret = parse_core(c, package_id, core_id++);
+				ret = parse_core(c, 0, core_id++);
 			} else {
 				pr_err("%pOF: Non-leaf cluster with core %s\n",
 				       cluster, name);
@@ -599,9 +598,6 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
 	if (leaf && !has_cores)
 		pr_warn("%pOF: empty cluster\n", cluster);
 
-	if (leaf)
-		package_id++;
-
 	return 0;
 }
 
-- 
2.36.1

