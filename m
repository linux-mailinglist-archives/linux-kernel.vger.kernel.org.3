Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3FD588B2B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 13:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbiHCL3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 07:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiHCL3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 07:29:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B711427B14
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 04:29:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5FDC533FC5;
        Wed,  3 Aug 2022 11:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659526140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8dYSp9FkxWYhq7shbNgnFFdDe+YIHT7/x9Ijr1mix0I=;
        b=fcYHHTuqTlfgxJZcvyxGKgTu1VnPjFXTOUt52Ni4Bw7g85QoBmSi4vKwbJPKPNXDrCdZra
        cplMKPt/0pFTe9HQlH6cvsO98tf3NZ6XHPh9IufME2nCHwRwCP1bfXB1qDcSNfbpwLG+fx
        xnnm2nF/mGmZl3fwq5oA261sUfGmXRU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3CA2913A94;
        Wed,  3 Aug 2022 11:29:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RYNeDPxb6mIyQgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 03 Aug 2022 11:29:00 +0000
Date:   Wed, 3 Aug 2022 13:28:59 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH] mm: mempolicy: fix policy_nodemask() for
 MPOL_PREFERRED_MANY case
Message-ID: <Yupb+1mmn9sQ/G8K@dhcp22.suse.cz>
References: <YueXhmiFcI8iw3OI@dhcp22.suse.cz>
 <YuecP/RKXWz7QAs0@feng-skl>
 <YuidPA9knCOoaT0c@FVFYT0MHHV2J>
 <Yui7hWZYMX31ktOr@feng-skl>
 <YujGy8EIeZc1Avc7@FVFYT0MHHV2J>
 <YujUyCIBjFj+FzX5@feng-skl>
 <YujoLQt09Js/sSQL@dhcp22.suse.cz>
 <YuoYkPk+YzdPNvmN@feng-snb>
 <YuolieBmdaIzoS3t@dhcp22.suse.cz>
 <Yuqs+BTpfh9/PjtP@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yuqs+BTpfh9/PjtP@feng-clx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 04-08-22 01:14:32, Feng Tang wrote:
[...]
> Ok, I change it as below:

Wouldn't it be better to make this allowed_mems_nr specific to be
explicit about the intention?

Not that I feel strongly about that.

> ---
>  mm/hugetlb.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)

Not even compile tested
 include/linux/mempolicy.h | 12 ------------
 mm/hugetlb.c              | 24 ++++++++++++++++++++----
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 668389b4b53d..e38b0ef20b8b 100644
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
@@ -294,11 +287,6 @@ static inline void mpol_put_task_policy(struct task_struct *task)
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
index a18c071c294e..6cacbc9b15a1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4330,18 +4330,34 @@ static int __init default_hugepagesz_setup(char *s)
 }
 __setup("default_hugepagesz=", default_hugepagesz_setup);
 
+struct mempolicy *policy_mbind_nodemask(gfp_t gfp)
+{
+#ifdef CONFIG_MEMPOLICY
+	struct mempolicy *mpol = get_task_policy(current);
+
+	/*
+	 * only enforce MBIND which overlaps with cpuset policy (from policy_nodemask)
+	 * specifically for hugetlb case
+	 */
+	if (mpol->mode == MPOL_BIND &&
+		(apply_policy_zone(mpol, gfp_zone(gfp)) &&
+		 cpuset_nodemask_valid_mems_allowed(&policy->nodes))
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
 
-- 
Michal Hocko
SUSE Labs
