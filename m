Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6419587981
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 11:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbiHBJCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 05:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiHBJCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 05:02:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DE5DEF7
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 02:02:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 93E56204E8;
        Tue,  2 Aug 2022 09:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659430958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=enN4apayAjkrT927v9mhEiCtXb5ss0zIUG7iWK9c2gU=;
        b=asZA5PDgAsGUJYGV6Omk87zDwIzkRzzl16s2v8QIHdwl9kr0Sd3TUzzRtxdS8XQSO5KpyY
        uS4xioxnwli5I02SAklNUDcrD7PzDi8wRGoJpG0j4oJDheAA13pN9UBqWL1RKMY/cqJl1V
        comIo8HkWakwsZacZ++6XqmeyVa9fMQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70CAE1345B;
        Tue,  2 Aug 2022 09:02:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nxNKGS7o6GKfXAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 02 Aug 2022 09:02:38 +0000
Date:   Tue, 2 Aug 2022 11:02:37 +0200
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
Message-ID: <YujoLQt09Js/sSQL@dhcp22.suse.cz>
References: <20220801084207.39086-1-songmuchun@bytedance.com>
 <YueXhmiFcI8iw3OI@dhcp22.suse.cz>
 <YuecP/RKXWz7QAs0@feng-skl>
 <YuidPA9knCOoaT0c@FVFYT0MHHV2J>
 <Yui7hWZYMX31ktOr@feng-skl>
 <YujGy8EIeZc1Avc7@FVFYT0MHHV2J>
 <YujUyCIBjFj+FzX5@feng-skl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YujUyCIBjFj+FzX5@feng-skl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please make sure to CC Mike on hugetlb related changes.

I didn't really get to grasp your proposed solution but it feels goind
sideways. The real issue is that hugetlb uses a dedicated allocation
scheme which is not fully MPOL_PREFERRED_MANY aware AFAICS. I do not
think we should be tricking that by providing some fake nodemasks and
what not.

The good news is that allocation from the pool is MPOL_PREFERRED_MANY
aware because it first tries to allocation from the preffered node mask
and then fall back to the full nodemask (dequeue_huge_page_vma).
If the existing pools cannot really satisfy that allocation then it
tries to allocate a new hugetlb page (alloc_fresh_huge_page) which also
performs 2 stage allocation with the node mask and no node masks. But
both of them might fail.

The bad news is that other allocation functions - including those that
allocate to the pool are not fully MPOL_PREFERRED_MANY aware. E.g.
__nr_hugepages_store_common paths which use the allocating process
policy to fill up the pool so the pool could be under provisioned if
that context is using MPOL_PREFERRED_MANY.

Wrt. allowed_mems_nr (i.e. hugetlb_acct_memory) this is a reservation
code and I have to admit I do not really remember details there. This is
a subtle code and my best guess would be that policy_nodemask_current
should be hugetlb specific and only care about MPOL_BIND.

On Tue 02-08-22 15:39:52, Feng Tang wrote:
> On Tue, Aug 02, 2022 at 02:40:11PM +0800, Muchun Song wrote:
> > On Tue, Aug 02, 2022 at 01:52:05PM +0800, Feng Tang wrote:
> > > On Tue, Aug 02, 2022 at 11:42:52AM +0800, Muchun Song wrote:
> > > > On Mon, Aug 01, 2022 at 05:26:23PM +0800, Feng Tang wrote:
> > > > > On Mon, Aug 01, 2022 at 05:06:14PM +0800, Michal Hocko wrote:
> > > > > > On Mon 01-08-22 16:42:07, Muchun Song wrote:
> > > > > > > policy_nodemask() is supposed to be returned a nodemask representing a mempolicy
> > > > > > > for filtering nodes for page allocation, which is a hard restriction (see the user
> > > > > > > of allowed_mems_nr() in hugetlb.c).  However, MPOL_PREFERRED_MANY is a preferred
> > > > > > > mode not a hard restriction.  Now it breaks the user of HugeTLB.  Remove it from
> > > > > > > policy_nodemask() to fix it, which will not affect current users of policy_nodemask()
> > > > > > > since all of the users already have handled the case of MPOL_PREFERRED_MANY before
> > > > > > > calling it.  BTW, it is found by code inspection.
> > > > > > 
> > > > > > I am not sure this is the right fix. It is quite true that
> > > > > > policy_nodemask is a tricky function to use. It pretends to have a
> > > > > > higher level logic but all existing users are expected to be policy
> > > > > > aware and they special case allocation for each policy. That would mean
> > > > > > that hugetlb should do the same.
> > > > > 
> > > > > Yes, when I worked on the MPOL_PREFERRED_MANY patches, I was also
> > > > > confused about policy_nodemask(), as it is never a 'strict' one as
> > > > > the old code is:
> > > > > 
> > > > > 	if (unlikely(mode == MPOL_BIND) &&
> > > > > 		apply_policy_zone(policy, gfp_zone(gfp)) &&
> > > > > 		cpuset_nodemask_valid_mems_allowed(&policy->nodes))
> > > > > 		return &policy->nodes;
> > > > > 
> > > > > 	return NULL
> > > > > 
> > > > > Even when the MPOL_BIND's nodes is not allowed by cpuset, it will 
> > > > > still return NULL (equals all nodes).
> > > > >
> > > > 
> > > > Well, I agree policy_nodemask() is really confusing because of the
> > > > shortage of comments and the weird logic.
> > > > 
> > > > > From the semantics of allowed_mems_nr(), I think it does get changed
> > > > > a little by b27abaccf8e8. And to enforce the 'strict' semantic for
> > > > > 'allowed', we may need a more strict nodemask API for it.
> > > > >
> > > > 
> > > > Maybe this is a good idea to fix this, e.g. introducing a new helper
> > > > to return the strict allowed nodemask.
> > > 
> > > Yep. 
> > > 
> > > I had another thought to add one global all-zero nodemask, for API like
> > > policy_nodemask(), it has 2 types of return value:
> > > * a nodemask with some bits set
> > > * NULL (means all nodes)
> > > 
> > > Here a new type of zero nodemask (a gloabl variable)can be created to
> > > indicate no qualified node.
> > >
> > 
> > I know why you want to introduce a gloable zero nidemask. Since we already
> > have a glable nodemask array, namely node_states, instead of returning NULL
> > for the case of all nodes, how about returing node_states[N_ONLINE] for it?
> > And make it return NULL for the case where no nodes are allowed. Any thought?
> 
> I think return node_states[N_ONLINE] can simplify the code in allowed_mems_nr(),
> the empty zero nodes can simplify further.
> 
> Here is some draft patch (not tested) to show the idea
> 
> Thanks,
> Feng
> 
> ---
>  include/linux/mempolicy.h |  8 ++++++++
>  include/linux/nodemask.h  |  7 +++++++
>  mm/hugetlb.c              |  7 ++++---
>  mm/mempolicy.c            | 17 +++++++++++++++++
>  mm/page_alloc.c           |  3 +++
>  5 files changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
> index 668389b4b53d..b5451fef1620 100644
> --- a/include/linux/mempolicy.h
> +++ b/include/linux/mempolicy.h
> @@ -150,6 +150,7 @@ extern bool init_nodemask_of_mempolicy(nodemask_t *mask);
>  extern bool mempolicy_in_oom_domain(struct task_struct *tsk,
>  				const nodemask_t *mask);
>  extern nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy);
> +extern nodemask_t *allowed_policy_nodemask(gfp_t gfp, struct mempolicy *policy);
>  
>  static inline nodemask_t *policy_nodemask_current(gfp_t gfp)
>  {
> @@ -158,6 +159,13 @@ static inline nodemask_t *policy_nodemask_current(gfp_t gfp)
>  	return policy_nodemask(gfp, mpol);
>  }
>  
> +static inline nodemask_t *allowed_policy_nodemask_current(gfp_t gfp)
> +{
> +	struct mempolicy *mpol = get_task_policy(current);
> +
> +	return allowed_policy_nodemask(gfp, mpol);
> +}
> +
>  extern unsigned int mempolicy_slab_node(void);
>  
>  extern enum zone_type policy_zone;
> diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
> index 0f233b76c9ce..dc5fab38e810 100644
> --- a/include/linux/nodemask.h
> +++ b/include/linux/nodemask.h
> @@ -409,6 +409,13 @@ enum node_states {
>  
>  extern nodemask_t node_states[NR_NODE_STATES];
>  
> +extern nodemask_t zero_nodes;
> +
> +static inline bool is_empty_nodes(nodemask_t *pnodes)
> +{
> +	 return (pnodes == &zero_nodes || __nodes_empty(pnodes, MAX_NUMNODES));
> +}
> +
>  #if MAX_NUMNODES > 1
>  static inline int node_state(int node, enum node_states state)
>  {
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a57e1be41401..dc9f4ed32909 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4340,10 +4340,11 @@ static unsigned int allowed_mems_nr(struct hstate *h)
>  
>  	mpol_allowed = policy_nodemask_current(gfp_mask);
>  
> -	for_each_node_mask(node, cpuset_current_mems_allowed) {
> -		if (!mpol_allowed || node_isset(node, *mpol_allowed))
> +	if (is_empty_nodes(mpol_allowed))
> +		return 0;
> +
> +	for_each_node_mask(node, mpol_allowed)
>  			nr += array[node];
> -	}
>  
>  	return nr;
>  }
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index d39b01fd52fe..3e936b8ca9ea 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1845,6 +1845,23 @@ nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
>  	return NULL;
>  }
>  
> +/*
> + * Return the allowed nodes mask for a mempolicy and page allocation,
> + * which is a 'stricter' semantic than policy_nodemsk()
> + */
> +nodemask_t *allowed_policy_nodemask(gfp_t gfp, struct mempolicy *policy)
> +{
> +	if (unlikely(policy->mode == MPOL_BIND)) {
> +		if (apply_policy_zone(policy, gfp_zone(gfp)) &&
> +			cpuset_nodemask_valid_mems_allowed(&policy->nodes))
> +			return &policy->nodes;
> +		else
> +			return &zero_nodes;
> +	}
> +
> +	return NULL;
> +}
> +
>  /*
>   * Return the  preferred node id for 'prefer' mempolicy, and return
>   * the given id for all other policies.
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e008a3df0485..3549ea037588 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -181,6 +181,9 @@ nodemask_t node_states[NR_NODE_STATES] __read_mostly = {
>  };
>  EXPORT_SYMBOL(node_states);
>  
> +nodemask_t zero_nodes = NODE_MASK_NONE;
> +EXPORT_SYMBOL(zero_nodes);
> +
>  atomic_long_t _totalram_pages __read_mostly;
>  EXPORT_SYMBOL(_totalram_pages);
>  unsigned long totalreserve_pages __read_mostly;
> -- 
> 2.27.0
> 

-- 
Michal Hocko
SUSE Labs
