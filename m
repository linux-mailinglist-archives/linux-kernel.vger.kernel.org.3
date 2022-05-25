Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807A253382D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 10:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiEYIQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 04:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243055AbiEYIPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:15:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0239C82146
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:15:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95F1E23A;
        Wed, 25 May 2022 01:15:06 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 82BBD3F73D;
        Wed, 25 May 2022 01:15:04 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 16/16] arch_topology: Add support for parsing sockets in /cpu-map
Date:   Wed, 25 May 2022 09:14:16 +0100
Message-Id: <20220525081416.3306043-17-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220525081416.3306043-16-sudeep.holla@arm.com>
References: <20220525081416.3306043-1-sudeep.holla@arm.com>
 <20220525081416.3306043-2-sudeep.holla@arm.com>
 <20220525081416.3306043-3-sudeep.holla@arm.com>
 <20220525081416.3306043-4-sudeep.holla@arm.com>
 <20220525081416.3306043-5-sudeep.holla@arm.com>
 <20220525081416.3306043-6-sudeep.holla@arm.com>
 <20220525081416.3306043-7-sudeep.holla@arm.com>
 <20220525081416.3306043-8-sudeep.holla@arm.com>
 <20220525081416.3306043-9-sudeep.holla@arm.com>
 <20220525081416.3306043-10-sudeep.holla@arm.com>
 <20220525081416.3306043-11-sudeep.holla@arm.com>
 <20220525081416.3306043-12-sudeep.holla@arm.com>
 <20220525081416.3306043-13-sudeep.holla@arm.com>
 <20220525081416.3306043-14-sudeep.holla@arm.com>
 <20220525081416.3306043-15-sudeep.holla@arm.com>
 <20220525081416.3306043-16-sudeep.holla@arm.com>
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

Finally let us add support for socket nodes in /cpu-map in the device
tree. Since this may not be present in all the old platforms and even
most of the existing platforms, we need to assume absence of the socket
node indicates that it is a single socket system and handle appropriately.

Also it is likely that most single socket systems skip to as the node
since it is optional.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/arch_topology.c | 37 +++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 5f4f148a7769..676e0ed333b1 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -540,8 +540,8 @@ static int __init parse_core(struct device_node *core, int package_id,
 	return 0;
 }
 
-static int __init
-parse_cluster(struct device_node *cluster, int cluster_id, int depth)
+static int __init parse_cluster(struct device_node *cluster, int package_id,
+				int cluster_id, int depth)
 {
 	char name[20];
 	bool leaf = true;
@@ -561,7 +561,7 @@ parse_cluster(struct device_node *cluster, int cluster_id, int depth)
 		c = of_get_child_by_name(cluster, name);
 		if (c) {
 			leaf = false;
-			ret = parse_cluster(c, i, depth + 1);
+			ret = parse_cluster(c, package_id, i, depth + 1);
 			of_node_put(c);
 			if (ret != 0)
 				return ret;
@@ -585,7 +585,8 @@ parse_cluster(struct device_node *cluster, int cluster_id, int depth)
 			}
 
 			if (leaf) {
-				ret = parse_core(c, 0, cluster_id, core_id++);
+				ret = parse_core(c, package_id, cluster_id,
+						 core_id++);
 			} else {
 				pr_err("%pOF: Non-leaf cluster with core %s\n",
 				       cluster, name);
@@ -605,6 +606,32 @@ parse_cluster(struct device_node *cluster, int cluster_id, int depth)
 	return 0;
 }
 
+static int __init parse_socket(struct device_node *socket)
+{
+	char name[20];
+	struct device_node *c;
+	bool has_socket = false;
+	int package_id = 0, ret;
+
+	do {
+		snprintf(name, sizeof(name), "socket%d", package_id);
+		c = of_get_child_by_name(socket, name);
+		if (c) {
+			has_socket = true;
+			ret = parse_cluster(c, package_id, -1, 0);
+			of_node_put(c);
+			if (ret != 0)
+				return ret;
+		}
+		package_id++;
+	} while (c);
+
+	if (!has_socket)
+		ret = parse_cluster(socket, 0, -1, 0);
+
+	return ret;
+}
+
 static int __init parse_dt_topology(void)
 {
 	struct device_node *cn, *map;
@@ -624,7 +651,7 @@ static int __init parse_dt_topology(void)
 	if (!map)
 		goto out;
 
-	ret = parse_cluster(map, -1, 0);
+	ret = parse_socket(map);
 	if (ret != 0)
 		goto out_map;
 
-- 
2.36.1

