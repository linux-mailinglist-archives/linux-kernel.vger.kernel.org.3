Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5AC4FF356
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiDMJYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiDMJYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:24:48 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F7152E55
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:22:27 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23D96jM8032739;
        Wed, 13 Apr 2022 09:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=AFIrjYTPtgDFJnTaB8TkYq5z5kBSeR6Y2BP+mRO/+bY=;
 b=Zxg8xviyaF5e60QiV/M6qFdToXWqE0Mw0ixg9wwBDkETryjBgC1ZAHhFm2fUukzfC7ZA
 w6nYCR8b5ufjEKWGe+TZRvyZforWmKDcEZZBifOW5t4nVAyN5VsXyERYIZKM/KL8UkR5
 BsvWOPxB+xnslnrrN1ZSSAQVEGVOpgpikinnZwPxIYk1IAkgfGmVf+5j1YMzH1+5TVTK
 aQkEV8cUNniRc25zmll58jK1YfCiPUU9yWw2TBLB9WeuyRbWZIW4LxgzL9nOk5AaK7cm
 U+q7jehvJOBKfpXOX4id2eda1AnY5+s2CsISg90nctXHCehbh742dJoybJkyyCoDYkRE Rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fdpjhe8hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Apr 2022 09:22:22 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23D9MMCB008762;
        Wed, 13 Apr 2022 09:22:22 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fdpjhe8gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Apr 2022 09:22:22 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23D9Kklu005529;
        Wed, 13 Apr 2022 09:22:20 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3fb1s8w9m4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Apr 2022 09:22:20 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23D9MHaR40108496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 09:22:17 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB3254C046;
        Wed, 13 Apr 2022 09:22:16 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 552E94C059;
        Wed, 13 Apr 2022 09:22:14 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com.com (unknown [9.43.51.146])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Apr 2022 09:22:14 +0000 (GMT)
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com,
        ying.huang@intel.com, Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: [PATCH v2 1/5] mm: demotion: Set demotion list differently
Date:   Wed, 13 Apr 2022 14:52:02 +0530
Message-Id: <20220413092206.73974-2-jvgediya@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413092206.73974-1-jvgediya@linux.ibm.com>
References: <20220413092206.73974-1-jvgediya@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UFkx_5t7kMHNG8JQm-lGG2Xnt_94zgjG
X-Proofpoint-ORIG-GUID: epmHWqL7LcSG4nMSsVSJbRzL9t-i0PZq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-13_01,2022-04-12_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 clxscore=1011 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204130051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
---
 mm/migrate.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index de175e2fdba5..516f4e1348c1 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2383,7 +2383,7 @@ static void __set_migration_target_nodes(void)
 {
 	nodemask_t next_pass	= NODE_MASK_NONE;
 	nodemask_t this_pass	= NODE_MASK_NONE;
-	nodemask_t used_targets = NODE_MASK_NONE;
+	nodemask_t source_nodes = NODE_MASK_NONE;
 	int node, best_distance;
 
 	/*
@@ -2401,20 +2401,23 @@ static void __set_migration_target_nodes(void)
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

