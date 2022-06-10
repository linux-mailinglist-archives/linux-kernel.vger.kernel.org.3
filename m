Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372FC5467EB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 16:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349570AbiFJN5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349494AbiFJN5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:57:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293BD19D605
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 06:56:09 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25ADoGHn016506;
        Fri, 10 Jun 2022 13:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=n8T98L+a+X/tcAsJS6uEHxWawMoJAPBeztGnL9oF2oE=;
 b=mIaxfN/JRkBdPEFjqnnk/tfnWCAoiMJvmcySLXjIF0LV7Q+8NLHZtPlbnlYDOphFAAX6
 YgNRF63G1qymg/Rfs+Va3qOjgI6AOlM68dsKqsVuhOmTtNQK75ioku8bU7V6f9SAW+P6
 dEC1APNpnQc7buFFgLPfyIpYEpeSvAUFnCGd4Kvqkr1TIcecSx0sKXgo0icFzAo7AuQe
 99gD4YDHeuzX5/0Kf48KStMynGgs3pX+f/s6A9HsZWf+svB0mI0hUVWNBquXuuZRLIDC
 hIfrHIzMMzm1hvBSDp4e56SQR0y/ThKOdMYnLA4rQ/zvgPW39FfVS6C6QvF3eNxov+1p tQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gm6q9gjjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 13:54:32 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25ADpn5p023398;
        Fri, 10 Jun 2022 13:54:31 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gm6q9gjjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 13:54:31 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25ADaaaS001826;
        Fri, 10 Jun 2022 13:54:30 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03wdc.us.ibm.com with ESMTP id 3gfy1a935k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 13:54:30 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25ADsTZ37340482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jun 2022 13:54:29 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A81C16A054;
        Fri, 10 Jun 2022 13:54:29 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCB666A04D;
        Fri, 10 Jun 2022 13:54:21 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.90.151])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 10 Jun 2022 13:54:21 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v6 11/13] mm/demotion: Update node_is_toptier to work with memory tiers
Date:   Fri, 10 Jun 2022 19:22:27 +0530
Message-Id: <20220610135229.182859-12-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610135229.182859-1-aneesh.kumar@linux.ibm.com>
References: <20220610135229.182859-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IfJBOki0lthPdqTpnEtpfbx5SEZ4TnTF
X-Proofpoint-GUID: 0RXvcVzRo6lHsOe6QLXM6lpJ-Z_kEAP6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_06,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206100056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With memory tiers support we can have memory only NUMA nodes
in the top tier from which we want to avoid promotion tracking NUMA
faults. Update node_is_toptier to work with memory tiers.
All NUMA nodes are by default top tier nodes. With lower memory
tiers added we consider all memory tiers above a memory tier having
CPU NUMA nodes as top memory tier

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/linux/memory-tiers.h |  6 +++++
 include/linux/node.h         |  5 ----
 mm/huge_memory.c             |  1 +
 mm/memory-tiers.c            | 44 ++++++++++++++++++++++++++++++++++--
 mm/migrate.c                 |  1 +
 mm/mprotect.c                |  1 +
 6 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 47841379553c..de4098f6d5d5 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -39,6 +39,7 @@ int node_reset_memory_tier(int node, int tier);
 struct memory_tier *node_get_memory_tier(int node);
 void node_put_memory_tier(struct memory_tier *memtier);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
+bool node_is_toptier(int node);
 
 #else
 
@@ -52,6 +53,11 @@ static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *target
 {
 	*targets = NODE_MASK_NONE;
 }
+
+static inline bool node_is_toptier(int node)
+{
+	return true;
+}
 #endif	/* CONFIG_TIERED_MEMORY */
 
 #endif
diff --git a/include/linux/node.h b/include/linux/node.h
index 40d641a8bfb0..9ec680dd607f 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -185,9 +185,4 @@ static inline void register_hugetlbfs_with_node(node_registration_func_t reg,
 
 #define to_node(device) container_of(device, struct node, dev)
 
-static inline bool node_is_toptier(int node)
-{
-	return node_state(node, N_CPU);
-}
-
 #endif /* _LINUX_NODE_H_ */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a77c78a2b6b5..294873d4be2b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -35,6 +35,7 @@
 #include <linux/numa.h>
 #include <linux/page_owner.h>
 #include <linux/sched/sysctl.h>
+#include <linux/memory-tiers.h>
 
 #include <asm/tlb.h>
 #include <asm/pgalloc.h>
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index b2ed16dcfb03..0dae3114e22c 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -17,7 +17,7 @@ struct demotion_nodes {
 static void establish_migration_targets(void);
 static DEFINE_MUTEX(memory_tier_lock);
 static LIST_HEAD(memory_tiers);
-
+static int top_tier_rank;
 /*
  * node_demotion[] examples:
  *
@@ -126,7 +126,7 @@ static void memory_tier_device_release(struct device *dev)
 	if (tier->dev.id >= MAX_STATIC_MEMORY_TIERS)
 		ida_free(&memtier_dev_id, tier->dev.id);
 
-	kfree(tier);
+	kfree_rcu(tier);
 }
 
 /*
@@ -443,6 +443,31 @@ void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
 	rcu_read_unlock();
 }
 
+bool node_is_toptier(int node)
+{
+	bool toptier;
+	pg_data_t *pgdat;
+	struct memory_tier *memtier;
+
+	pgdat = NODE_DATA(node);
+	if (!pgdat)
+		return false;
+
+	rcu_read_lock();
+	memtier = rcu_dereference(pgdat->memtier);
+	if (!memtier) {
+		toptier = true;
+		goto out;
+	}
+	if (memtier->rank >= top_tier_rank)
+		toptier = true;
+	else
+		toptier = false;
+out:
+	rcu_read_unlock();
+	return toptier;
+}
+
 /**
  * next_demotion_node() - Get the next node in the demotion path
  * @node: The starting node to lookup the next node
@@ -592,6 +617,21 @@ static void establish_migration_targets(void)
 		} while (1);
 	}
 build_lower_tier_mask:
+	/*
+	 * Promotion is allowed from a memory tier to higher
+	 * memory tier only if the memory tier doesn't include
+	 * compute. We want to  skip promotion from a memory tier,
+	 * if any node that is  part of the memory tier have CPUs.
+	 * Once we detect such a memory tier, we consider that tier
+	 * as top tiper from which promotion is not allowed.
+	 */
+	list_for_each_entry_reverse(memtier, &memory_tiers, list) {
+		nodes_and(used, node_states[N_CPU], memtier->nodelist);
+		if (!nodes_empty(used)) {
+			top_tier_rank = memtier->rank;
+			break;
+		}
+	}
 	/*
 	 * Now build the lower_tier mask for each node collecting node mask from
 	 * all memory tier below it. This allows us to fallback demotion page
diff --git a/mm/migrate.c b/mm/migrate.c
index 0b554625a219..78615c48fc0f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -50,6 +50,7 @@
 #include <linux/memory.h>
 #include <linux/random.h>
 #include <linux/sched/sysctl.h>
+#include <linux/memory-tiers.h>
 
 #include <asm/tlbflush.h>
 
diff --git a/mm/mprotect.c b/mm/mprotect.c
index ba5592655ee3..92a2fc0fa88b 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -31,6 +31,7 @@
 #include <linux/pgtable.h>
 #include <linux/sched/sysctl.h>
 #include <linux/userfaultfd_k.h>
+#include <linux/memory-tiers.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
-- 
2.36.1

