Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91D258A45A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 02:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbiHEA6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 20:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiHEA6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 20:58:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AEC1C92B
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 17:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659661121; x=1691197121;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ooi5mbefGvKfUWCk9RYSVk/n9UbKTohxT9gcx4F8dMI=;
  b=LnJHHbBwizuBo/zdQ0XinTLoTRR3vkATNLqv62tT8StWhMrLxaaAjWcH
   CrqV6F4b5m6yM3bXNH3AC9k+nuZdyO7A97JJIptG4XOLrTe3PAsaJYulI
   9BlooaStTH7bjXunCk0NkNWBLlDvKAWlCRz56wXPKLfvZb91EDb9BsJfB
   EiNag3sPGSR6LV/Xb+8RpgFjxuQH6FsAuQNwVrIR1cf5evtH9m4uw9PvU
   uOw0iIUOorOjiS9gkZc8cgEdRm1Al1mEWC6sm9n6Cxd1XruHtAS9m6AdE
   hfWg2xFr4vJSDtvPU749oNgJCFk3W0wA12z069gyxBeX2IMSHZerLXDY0
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="354090836"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="354090836"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 17:58:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="729821492"
Received: from shbuild999.sh.intel.com ([10.239.147.181])
  by orsmga004.jf.intel.com with ESMTP; 04 Aug 2022 17:58:34 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-founddation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>
Subject: [PATCH v2] mm/hugetlb: add dedicated func to get 'allowed' nodemask for current process
Date:   Fri,  5 Aug 2022 08:59:03 +0800
Message-Id: <20220805005903.95563-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Muchun Song found that after MPOL_PREFERRED_MANY policy was introduced
in commit b27abaccf8e8 ("mm/mempolicy: add MPOL_PREFERRED_MANY for multiple preferred nodes"),
the policy_nodemask_current()'s semantics for this new policy has been
changed, which returns 'preferred' nodes instead of 'allowed' nodes.

With the changed semantic of policy_nodemask_current, a task with
MPOL_PREFERRED_MANY policy could fail to get its reservation even though
it can fall back to other nodes (either defined by cpusets or all online
nodes) for that reservation failing mmap calles unnecessarily early.

The fix is to not consider MPOL_PREFERRED_MANY for reservations at all
because they, unlike MPOL_MBIND, do not pose any actual hard constrain.

Michal suggested the policy_nodemask_current() is only used by hugetlb,
and could be moved to hugetlb code with more explicit name to enforce
the 'allowed' semantics for which only MPOL_BIND policy matters.

apply_policy_zone() is made extern to be called in hugetlb code
and its return value is changed to bool.

[1]. https://lore.kernel.org/lkml/20220801084207.39086-1-songmuchun@bytedance.com/t/

Fixes: b27abaccf8e8 ("mm/mempolicy: add MPOL_PREFERRED_MANY for multiple preferred nodes")
Reported-by: Muchun Song <songmuchun@bytedance.com>
Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
Changelog:

  since v1:
  * add the missing user visible effect of the problem (Michal Hocko)
  * add Fix tag (Andrew/Michal)
  * add Acked-by tag

  since RFC:
  * make apply_policy_zone() extern instead of putting it to
    mempolicy.h (Michal Hocko)

 include/linux/mempolicy.h | 13 +------------
 mm/hugetlb.c              | 24 ++++++++++++++++++++----
 mm/mempolicy.c            |  2 +-
 3 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 668389b4b53d..d232de7cdc56 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -151,13 +151,6 @@ extern bool mempolicy_in_oom_domain(struct task_struct *tsk,
 				const nodemask_t *mask);
 extern nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy);
 
-static inline nodemask_t *policy_nodemask_current(gfp_t gfp)
-{
-	struct mempolicy *mpol = get_task_policy(current);
-
-	return policy_nodemask(gfp, mpol);
-}
-
 extern unsigned int mempolicy_slab_node(void);
 
 extern enum zone_type policy_zone;
@@ -189,6 +182,7 @@ static inline bool mpol_is_preferred_many(struct mempolicy *pol)
 	return  (pol->mode == MPOL_PREFERRED_MANY);
 }
 
+extern bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone);
 
 #else
 
@@ -294,11 +288,6 @@ static inline void mpol_put_task_policy(struct task_struct *task)
 {
 }
 
-static inline nodemask_t *policy_nodemask_current(gfp_t gfp)
-{
-	return NULL;
-}
-
 static inline bool mpol_is_preferred_many(struct mempolicy *pol)
 {
 	return  false;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a18c071c294e..ad84bb85b6de 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4330,18 +4330,34 @@ static int __init default_hugepagesz_setup(char *s)
 }
 __setup("default_hugepagesz=", default_hugepagesz_setup);
 
+static nodemask_t *policy_mbind_nodemask(gfp_t gfp)
+{
+#ifdef CONFIG_NUMA
+	struct mempolicy *mpol = get_task_policy(current);
+
+	/*
+	 * Only enforce MPOL_BIND policy which overlaps with cpuset policy
+	 * (from policy_nodemask) specifically for hugetlb case
+	 */
+	if (mpol->mode == MPOL_BIND &&
+		(apply_policy_zone(mpol, gfp_zone(gfp)) &&
+		 cpuset_nodemask_valid_mems_allowed(&mpol->nodes)))
+		return &mpol->nodes;
+#endif
+	return NULL;
+}
+
 static unsigned int allowed_mems_nr(struct hstate *h)
 {
 	int node;
 	unsigned int nr = 0;
-	nodemask_t *mpol_allowed;
+	nodemask_t *mbind_nodemask;
 	unsigned int *array = h->free_huge_pages_node;
 	gfp_t gfp_mask = htlb_alloc_mask(h);
 
-	mpol_allowed = policy_nodemask_current(gfp_mask);
-
+	mbind_nodemask = policy_mbind_nodemask(gfp_mask);
 	for_each_node_mask(node, cpuset_current_mems_allowed) {
-		if (!mpol_allowed || node_isset(node, *mpol_allowed))
+		if (!mbind_nodemask || node_isset(node, *mbind_nodemask))
 			nr += array[node];
 	}
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d39b01fd52fe..9f15bc533601 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1805,7 +1805,7 @@ bool vma_policy_mof(struct vm_area_struct *vma)
 	return pol->flags & MPOL_F_MOF;
 }
 
-static int apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
+bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
 {
 	enum zone_type dynamic_policy_zone = policy_zone;
 
-- 
2.27.0

