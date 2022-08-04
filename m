Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067E5589C18
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbiHDNDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiHDNDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:03:31 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BCC2BED
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659618210; x=1691154210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fjBaY/FwafB1AaXjG6rMcxtrVelzXUJzoU+isxw1T7E=;
  b=QXhRPgM+iJ7V5w5fTchgJA+NZtUVNyGLBC9lUdONzJWvDKn7B0hOLZy3
   g509LxRJLNO5xvqkAo8ksBD4ph2HfOkxUj+rL0TzSNZNYaKpgrnLcgrOg
   HN6IBedTumilxVBKUQgO5ZECNSL4i2XR+YqAEvX1Xh/41ToqAVIx718Ne
   qPrJaZbmrqH8WQPOLWOs5CvQWUggYbBkPb+UQ7HA2MvD7w3pjhm4OHXWe
   YczJibXdFrmSf6MOPTusw4RJLs4yIeYCQW/4VYmbVBkehzlCz/Hp/pTUd
   KrVW6PdVGfXZHmRqxfSNPdJHqsNi7yD72qvC7sfcNB9HuPTXj5qSabewp
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="270306449"
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="270306449"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 06:03:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="631576174"
Received: from shbuild999.sh.intel.com ([10.239.147.181])
  by orsmga008.jf.intel.com with ESMTP; 04 Aug 2022 06:03:13 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Hansen <hansen.dave@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>
Subject: [PATCH] mm/hugetlb: add dedicated func to get 'allowed' nodemask for current process
Date:   Thu,  4 Aug 2022 21:03:42 +0800
Message-Id: <20220804130342.63355-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <YuuitMLOYqBcXMR3@dhcp22.suse.cz>
References: <YuuitMLOYqBcXMR3@dhcp22.suse.cz>
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
in commit b27abaccf8e8 ("mm/mempolicy: add MPOL_PREFERRED_MANY for multiple preferred nodes")
[1], the policy_nodemask_current()'s semantics for this new policy
has been changed, which returns 'preferred' nodes instead of 'allowed'
nodes, and could hurt the usage of its caller in hugetlb:
allowed_mems_nr().

Michal found the policy_nodemask_current() is only used by hugetlb,
and suggested to move it to hugetlb code with more explicit name to
enforce the 'allowed' semantics for which only MPOL_BIND policy
matters.

One note for the new policy_mbind_nodemask() is, the cross check
from MPOL_BIND, gfp flags and cpuset configuration can lead to
a no available node case, which is considered to be broken
configuration, and 'NULL' (equals all nodes) will be returned.

apply_policy_zone() is made extern to be called in hugetlb code
and its return value is changed to bool.

[1]. https://lore.kernel.org/lkml/20220801084207.39086-1-songmuchun@bytedance.com/t/
Reported-by: Muchun Song <songmuchun@bytedance.com>
Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
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

