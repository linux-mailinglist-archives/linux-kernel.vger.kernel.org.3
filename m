Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0264650C222
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbiDVWJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbiDVWIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:08:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B928C2727DA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:55:29 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MHAVOn019099;
        Fri, 22 Apr 2022 19:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=I+X9oa4wBtGt3ENNnP+MXjrcgbDt5U7J2EH0Hbr6Yp4=;
 b=P6rWvK1tRbg/aH2vTgsx8czaXf+u2nKGh9C/qax8VILyucevdXYlMByvnGOQxTyqo9Lp
 OewIMTHRnx7LXubi0TXOLKuhPqGsS7AI7U+S/4Tou21yIcg0JRPMqqqjFVJdbPw0wJTv
 PpZnRohcds3hDEg/BM5X5T+eewFiWkRlrlJB+I6knVs8m0YTOXoRqByBaSJo7CY7uXJq
 Anylyf/dZCt5cAvlKdtcZSM7HDBNcxI6cXK4+Q+nRNUwvlvjdcyJAsj3FKv3rW0p2IMI
 r1dA7L/UJ+gEvtOyHlZyorvt5IsBQr5Dld9TESA5dnmwe2bbSsEv63M60ntcbajFslI/ Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fkvdv8cx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 19:55:36 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23MJtZFC013936;
        Fri, 22 Apr 2022 19:55:35 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fkvdv8cwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 19:55:35 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23MJhXiq005349;
        Fri, 22 Apr 2022 19:55:33 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 3fgu6u68jj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 19:55:33 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23MJtUIc56033626
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 19:55:30 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7133811C054;
        Fri, 22 Apr 2022 19:55:30 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3573411C04A;
        Fri, 22 Apr 2022 19:55:27 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com.com (unknown [9.43.112.230])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 22 Apr 2022 19:55:26 +0000 (GMT)
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com,
        ying.huang@intel.com, aneesh.kumar@linux.ibm.com,
        shy828301@gmail.com, weixugc@google.com, gthelen@google.com,
        dan.j.williams@intel.com, Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: [PATCH v3 1/7] mm: demotion: Fix demotion targets sharing among sources
Date:   Sat, 23 Apr 2022 01:25:10 +0530
Message-Id: <20220422195516.10769-2-jvgediya@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422195516.10769-1-jvgediya@linux.ibm.com>
References: <20220422195516.10769-1-jvgediya@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JTs40v1XVo3FaJ9_tA9o9Cl_vjs4rxdj
X-Proofpoint-ORIG-GUID: mhTJzr8VhHL4_WdJQD2OmeAdrz16qQ9x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_06,2022-04-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204220083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sharing used_targets between multiple nodes in a single
pass limits some of the opportunities for demotion target
sharing.

Don't share the used targets between multiple nodes in a
single pass, instead accumulate all the used targets in
source nodes shared by all pass, and reset 'used_targets'
to source nodes while finding demotion targets for any new
node.

This results into some more opportunities to share demotion
targets between multiple source nodes, e.g. with below NUMA
topology, where node 0 & 1 are cpu + dram nodes, node 2 & 3
are equally slower memory only nodes, and node 4 is slowest
memory only node,

available: 5 nodes (0-4)
node 0 cpus: 0 1
node 0 size: n MB
node 0 free: n MB
node 1 cpus: 2 3
node 1 size: n MB
node 1 free: n MB
node 2 cpus:
node 2 size: n MB
node 2 free: n MB
node 3 cpus:
node 3 size: n MB
node 3 free: n MB
node 4 cpus:
node 4 size: n MB
node 4 free: n MB
node distances:
node   0   1   2   3   4
  0:  10  20  40  40  80
  1:  20  10  40  40  80
  2:  40  40  10  40  80
  3:  40  40  40  10  80
  4:  80  80  80  80  10

The existing implementation gives below demotion targets,

node    demotion_target
 0              3, 2
 1              4
 2              X
 3              X
 4              X

With this patch applied, below are the demotion targets,

node    demotion_target
 0              3, 2
 1              3, 2
 2              4
 3              4
 4              X

e.g. with below NUMA topology, where node 0, 1 & 2 are
cpu + dram nodes and node 3 is slow memory node,

available: 4 nodes (0-3)
node 0 cpus: 0 1
node 0 size: n MB
node 0 free: n MB
node 1 cpus: 2 3
node 1 size: n MB
node 1 free: n MB
node 2 cpus: 4 5
node 2 size: n MB
node 2 free: n MB
node 3 cpus:
node 3 size: n MB
node 3 free: n MB
node distances:
node   0   1   2   3
  0:  10  20  20  40
  1:  20  10  20  40
  2:  20  20  10  40
  3:  40  40  40  10

The existing implementation gives below demotion targets,

node    demotion_target
 0              3
 1              X
 2              X
 3              X

With this patch applied, below are the demotion targets,

node    demotion_target
 0              3
 1              3
 2              3
 3              X

Fixes: 79c28a416722 ("mm/numa: automatically generate node migration order")
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: "Huang, Ying" <ying.huang@intel.com>
---
 mm/migrate.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 6c31ee1e1c9b..8bbe1e478122 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2355,7 +2355,7 @@ static void __set_migration_target_nodes(void)
 {
 	nodemask_t next_pass	= NODE_MASK_NONE;
 	nodemask_t this_pass	= NODE_MASK_NONE;
-	nodemask_t used_targets = NODE_MASK_NONE;
+	nodemask_t source_nodes = NODE_MASK_NONE;
 	int node, best_distance;
 
 	/*
@@ -2373,20 +2373,23 @@ static void __set_migration_target_nodes(void)
 again:
 	this_pass = next_pass;
 	next_pass = NODE_MASK_NONE;
+
 	/*
-	 * To avoid cycles in the migration "graph", ensure
-	 * that migration sources are not future targets by
-	 * setting them in 'used_targets'.  Do this only
-	 * once per pass so that multiple source nodes can
-	 * share a target node.
-	 *
-	 * 'used_targets' will become unavailable in future
-	 * passes.  This limits some opportunities for
-	 * multiple source nodes to share a destination.
+	 * Accumulate source nodes to avoid the cycle in migration
+	 * list.
 	 */
-	nodes_or(used_targets, used_targets, this_pass);
+	nodes_or(source_nodes, source_nodes, this_pass);
 
 	for_each_node_mask(node, this_pass) {
+		/*
+		 * To avoid cycles in the migration "graph", ensure
+		 * that migration sources are not future targets by
+		 * setting them in 'used_targets'. Reset used_targets
+		 * to source nodes for each node in this pass so that
+		 * multiple source nodes can share a target node.
+		 */
+		nodemask_t used_targets = source_nodes;
+
 		best_distance = -1;
 
 		/*
-- 
2.35.1

