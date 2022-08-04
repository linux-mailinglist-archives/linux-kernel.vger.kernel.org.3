Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B98589CC8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239951AbiHDNhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239818AbiHDNhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:37:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E191CFFA
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:36:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 87580344F1;
        Thu,  4 Aug 2022 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659620209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yYZcEiL+RiDvPwAfOXSFsIqyOOAKdK4eqWC1xb4r4Xk=;
        b=iMTQ2hCh/7WfVQaniQcB66scOEG7yOiTeChPhGwyMqc8MmUD85dOjkLkPJjgfk6jzBkGi1
        Vr3c14MoCwa+mKLlIy9zmRzSA2HgMVVICfm1U2bkOr8xUvKgN739MfO7ejpAhmpaIJaUxh
        M2r66avKHiuXv8U86nTnol4iDBu241Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 671C913434;
        Thu,  4 Aug 2022 13:36:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RRrDFnHL62KCYAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 04 Aug 2022 13:36:49 +0000
Date:   Thu, 4 Aug 2022 15:36:48 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <hansen.dave@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: add dedicated func to get 'allowed' nodemask
 for current process
Message-ID: <YuvLcBp34Ac6Pd7a@dhcp22.suse.cz>
References: <YuuitMLOYqBcXMR3@dhcp22.suse.cz>
 <20220804130342.63355-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804130342.63355-1-feng.tang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 04-08-22 21:03:42, Feng Tang wrote:
> Muchun Song found that after MPOL_PREFERRED_MANY policy was introduced
> in commit b27abaccf8e8 ("mm/mempolicy: add MPOL_PREFERRED_MANY for multiple preferred nodes")
> [1], the policy_nodemask_current()'s semantics for this new policy
> has been changed, which returns 'preferred' nodes instead of 'allowed'
> nodes, and could hurt the usage of its caller in hugetlb:
> allowed_mems_nr().

The acutal user visible effect description is missing here. AFAIU it
would be this.

With the changed semantic of policy_nodemask_current a taks with
MPOL_PREFERRED_MANY policy could fail to get its reservation even though
it can fall back to other nodes (either defined by cpusets or all online
nodes) for that reservation failing mmap calles unnecessarily early.

The fix is to not consider MPOL_PREFERRED_MANY for reservations at all
because they, unlike MPOL_MBIND, do not pose any actual hard constrain.

You can keep the rest.
> Michal found the policy_nodemask_current() is only used by hugetlb,
> and suggested to move it to hugetlb code with more explicit name to
> enforce the 'allowed' semantics for which only MPOL_BIND policy
> matters.
> 
> One note for the new policy_mbind_nodemask() is, the cross check
> from MPOL_BIND, gfp flags and cpuset configuration can lead to
> a no available node case, which is considered to be broken
> configuration, and 'NULL' (equals all nodes) will be returned.

This is neither important nor useful for this particular patch.

> apply_policy_zone() is made extern to be called in hugetlb code
> and its return value is changed to bool.
> 
> [1]. https://lore.kernel.org/lkml/20220801084207.39086-1-songmuchun@bytedance.com/t/

Fixes: b27abaccf8e8 ("mm/mempolicy: add MPOL_PREFERRED_MANY for multiple preferred nodes")

I do not think stable is really required.

> Reported-by: Muchun Song <songmuchun@bytedance.com>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>

with that
Acked-by: Michal Hocko <mhocko@suse.com>

thanks!
> ---
>  include/linux/mempolicy.h | 13 +------------
>  mm/hugetlb.c              | 24 ++++++++++++++++++++----
>  mm/mempolicy.c            |  2 +-
>  3 files changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
> index 668389b4b53d..d232de7cdc56 100644
> --- a/include/linux/mempolicy.h
> +++ b/include/linux/mempolicy.h
> @@ -151,13 +151,6 @@ extern bool mempolicy_in_oom_domain(struct task_struct *tsk,
>  				const nodemask_t *mask);
>  extern nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy);
>  
> -static inline nodemask_t *policy_nodemask_current(gfp_t gfp)
> -{
> -	struct mempolicy *mpol = get_task_policy(current);
> -
> -	return policy_nodemask(gfp, mpol);
> -}
> -
>  extern unsigned int mempolicy_slab_node(void);
>  
>  extern enum zone_type policy_zone;
> @@ -189,6 +182,7 @@ static inline bool mpol_is_preferred_many(struct mempolicy *pol)
>  	return  (pol->mode == MPOL_PREFERRED_MANY);
>  }
>  
> +extern bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone);
>  
>  #else
>  
> @@ -294,11 +288,6 @@ static inline void mpol_put_task_policy(struct task_struct *task)
>  {
>  }
>  
> -static inline nodemask_t *policy_nodemask_current(gfp_t gfp)
> -{
> -	return NULL;
> -}
> -
>  static inline bool mpol_is_preferred_many(struct mempolicy *pol)
>  {
>  	return  false;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a18c071c294e..ad84bb85b6de 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4330,18 +4330,34 @@ static int __init default_hugepagesz_setup(char *s)
>  }
>  __setup("default_hugepagesz=", default_hugepagesz_setup);
>  
> +static nodemask_t *policy_mbind_nodemask(gfp_t gfp)
> +{
> +#ifdef CONFIG_NUMA
> +	struct mempolicy *mpol = get_task_policy(current);
> +
> +	/*
> +	 * Only enforce MPOL_BIND policy which overlaps with cpuset policy
> +	 * (from policy_nodemask) specifically for hugetlb case
> +	 */
> +	if (mpol->mode == MPOL_BIND &&
> +		(apply_policy_zone(mpol, gfp_zone(gfp)) &&
> +		 cpuset_nodemask_valid_mems_allowed(&mpol->nodes)))
> +		return &mpol->nodes;
> +#endif
> +	return NULL;
> +}
> +
>  static unsigned int allowed_mems_nr(struct hstate *h)
>  {
>  	int node;
>  	unsigned int nr = 0;
> -	nodemask_t *mpol_allowed;
> +	nodemask_t *mbind_nodemask;
>  	unsigned int *array = h->free_huge_pages_node;
>  	gfp_t gfp_mask = htlb_alloc_mask(h);
>  
> -	mpol_allowed = policy_nodemask_current(gfp_mask);
> -
> +	mbind_nodemask = policy_mbind_nodemask(gfp_mask);
>  	for_each_node_mask(node, cpuset_current_mems_allowed) {
> -		if (!mpol_allowed || node_isset(node, *mpol_allowed))
> +		if (!mbind_nodemask || node_isset(node, *mbind_nodemask))
>  			nr += array[node];
>  	}
>  
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index d39b01fd52fe..9f15bc533601 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1805,7 +1805,7 @@ bool vma_policy_mof(struct vm_area_struct *vma)
>  	return pol->flags & MPOL_F_MOF;
>  }
>  
> -static int apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
> +bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
>  {
>  	enum zone_type dynamic_policy_zone = policy_zone;
>  
> -- 
> 2.27.0

-- 
Michal Hocko
SUSE Labs
