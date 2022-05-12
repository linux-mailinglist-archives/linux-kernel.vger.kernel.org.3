Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680BE524FC5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355182AbiELOSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354853AbiELOSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:18:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8C047356C
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:17:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C4CE106F;
        Thu, 12 May 2022 07:17:58 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AF5F3F73D;
        Thu, 12 May 2022 07:17:57 -0700 (PDT)
Date:   Thu, 12 May 2022 15:17:55 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com
Subject: Re: [PATCH V2] arch_topology: support parsing cluster_id from DT
Message-ID: <Yn0XE3szFk9f2VyL@bogus>
References: <1652262776-3056-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652262776-3056-1-git-send-email-wangqing@vivo.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 02:52:56AM -0700, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> Use nested cluster structures in DT to support describing multi-level
> cluster topologies and increase the parsing of nested cluster.
> 
> Notice: the clusters describing in DT currently are not physical
> boundaries, since changing "cluster" to "socket" is too involved and error
> prone, this patch will not have any effect on one-level cluster topo, but
> can support the mutil-level cluster topo to support CLUSTER_SCHED.

Sorry the socket/package_id is broken. If we are playing with cluster_id
which is now wrongly presented as package_id, you are forced to fix that
too. We don't want to break that in a different way or leave that as is
since the cluster_id and package ids now show up as same now. Earlier the
cluster_id was -1.

I had a look when I started reviewing your patch. Assuming we don't need
nested cluster support yet, I have some patches(not built or tested
unfortunately yet). Let me know your thoughts. If you think you still
need support for some kind of nested cluster, build that on top of this.
Also I haven't bothered about sched domains as this purely relates to
topology and how this is mapped to sched domain is orthogonal.

If anything is broken, that needs to be fixed separately there. I see the
idea here is correct and would like to push the patches once I build/test
and get some review/more testing.

Regards,
Sudeep

---->8

From 73de6524249287159a5c9fab9493d84bc5efc6e6 Mon Sep 17 00:00:00 2001
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Thu, 12 May 2022 14:12:20 +0100
Subject: [PATCH 1/3] arch_topology: Don't set cluster identifier as physical
 package identifier

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


From 33a5184fbb3020a59f27347051fde1af6356b559 Mon Sep 17 00:00:00 2001
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Thu, 12 May 2022 14:13:43 +0100
Subject: [PATCH 2/3] arch_topology: Set cluster identifier in each core/thread

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/arch_topology.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 44f733b365cc..87150b90ede4 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -491,7 +491,7 @@ static int __init get_cpu_for_node(struct device_node *node)
 }
 
 static int __init parse_core(struct device_node *core, int package_id,
-			     int core_id)
+			     int cluster_id, int core_id)
 {
 	char name[20];
 	bool leaf = true;
@@ -507,6 +507,7 @@ static int __init parse_core(struct device_node *core, int package_id,
 			cpu = get_cpu_for_node(t);
 			if (cpu >= 0) {
 				cpu_topology[cpu].package_id = package_id;
+				cpu_topology[cpu].cluster_id = cluster_id;
 				cpu_topology[cpu].core_id = core_id;
 				cpu_topology[cpu].thread_id = i;
 			} else if (cpu != -ENODEV) {
@@ -528,6 +529,7 @@ static int __init parse_core(struct device_node *core, int package_id,
 		}
 
 		cpu_topology[cpu].package_id = package_id;
+		cpu_topology[cpu].cluster_id = cluster_id;
 		cpu_topology[cpu].core_id = core_id;
 	} else if (leaf && cpu != -ENODEV) {
 		pr_err("%pOF: Can't get CPU for leaf core\n", core);
@@ -537,7 +539,8 @@ static int __init parse_core(struct device_node *core, int package_id,
 	return 0;
 }
 
-static int __init parse_cluster(struct device_node *cluster, int depth)
+static int __init
+parse_cluster(struct device_node *cluster, int cluster_id, int depth)
 {
 	char name[20];
 	bool leaf = true;
@@ -557,7 +560,7 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
 		c = of_get_child_by_name(cluster, name);
 		if (c) {
 			leaf = false;
-			ret = parse_cluster(c, depth + 1);
+			ret = parse_cluster(c, i, depth + 1);
 			of_node_put(c);
 			if (ret != 0)
 				return ret;
@@ -581,7 +584,7 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
 			}
 
 			if (leaf) {
-				ret = parse_core(c, 0, core_id++);
+				ret = parse_core(c, 0, cluster_id, core_id++);
 			} else {
 				pr_err("%pOF: Non-leaf cluster with core %s\n",
 				       cluster, name);
@@ -621,7 +624,7 @@ static int __init parse_dt_topology(void)
 	if (!map)
 		goto out;
 
-	ret = parse_cluster(map, 0);
+	ret = parse_cluster(map, -1, 0);
 	if (ret != 0)
 		goto out_map;
 
-- 
2.36.1


From 82def1dbe2ffd0d03c3b5d995dfa163b312c4b6b Mon Sep 17 00:00:00 2001
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Thu, 12 May 2022 14:33:05 +0100
Subject: [PATCH 3/3] arch_topology: Add support for parsing sockets in
 /cpu-map

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/arch_topology.c | 37 +++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 87150b90ede4..0ec461bb5d63 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -539,8 +539,8 @@ static int __init parse_core(struct device_node *core, int package_id,
 	return 0;
 }
 
-static int __init
-parse_cluster(struct device_node *cluster, int cluster_id, int depth)
+static int __init parse_cluster(struct device_node *cluster, int package_id,
+				int cluster_id, int depth)
 {
 	char name[20];
 	bool leaf = true;
@@ -560,7 +560,7 @@ parse_cluster(struct device_node *cluster, int cluster_id, int depth)
 		c = of_get_child_by_name(cluster, name);
 		if (c) {
 			leaf = false;
-			ret = parse_cluster(c, i, depth + 1);
+			ret = parse_cluster(c, package_id, i, depth + 1);
 			of_node_put(c);
 			if (ret != 0)
 				return ret;
@@ -584,7 +584,8 @@ parse_cluster(struct device_node *cluster, int cluster_id, int depth)
 			}
 
 			if (leaf) {
-				ret = parse_core(c, 0, cluster_id, core_id++);
+				ret = parse_core(c, package_id, cluster_id,
+						 core_id++);
 			} else {
 				pr_err("%pOF: Non-leaf cluster with core %s\n",
 				       cluster, name);
@@ -604,6 +605,32 @@ parse_cluster(struct device_node *cluster, int cluster_id, int depth)
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
+	} while(c);
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

