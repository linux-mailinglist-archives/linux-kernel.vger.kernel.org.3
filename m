Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533D8542807
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiFHHWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241422AbiFHHMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 03:12:37 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1ACE1D0887
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 23:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654671151; x=1686207151;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q+QS/cn0Iya0AlVh9AVNArnJL/U93flfH93KNZW4kJk=;
  b=DUbzwg4yIS/tmTkgJUh1dV7YKsxr3KoiCIb8tZti12ozlWF21TGPVcuT
   2HQohRwiNq+wxziTErmc09L63zyJnVqzZUalryF1NPgq0l4N5m2DerhEl
   AmKof9uDsyk6QWW3CYVpmKeh8VuX3gOMiQa3R82bQv4GE/j6j4ATyLYAA
   lg9NlAQ1Apfa25Dyj4HJQMLRYf530Fifg6r4Y7wZEMZVum2EciXAOMpXG
   l+lfFjjM4Hqw3YTmuGm8khwD8mdoC3tSOsZ+AXZwIpTPWYY0KFmR1U8jb
   BAlQ6UrKBadWZkrA7XIDTsqx/FN3AGjzSNtb1AvA54KZzy4UVXj8Zuf8u
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="277619320"
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="277619320"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 23:52:27 -0700
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="636620957"
Received: from xding11-mobl.ccr.corp.intel.com ([10.254.214.239])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 23:52:22 -0700
Message-ID: <d8ff7d76ac9b67cd0141124e99016ca8992dcacd.camel@intel.com>
Subject: Re: [PATCH v5 4/9] mm/demotion: Build demotion targets based on
 explicit memory tiers
From:   Ying Huang <ying.huang@intel.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
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
        David Rientjes <rientjes@google.com>
Date:   Wed, 08 Jun 2022 14:52:20 +0800
In-Reply-To: <c4678658cdd04d14ced7d0407da32f5fdec19f95.camel@linux.intel.com>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
         <20220603134237.131362-5-aneesh.kumar@linux.ibm.com>
         <c4678658cdd04d14ced7d0407da32f5fdec19f95.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-06-07 at 15:51 -0700, Tim Chen wrote:
> On Fri, 2022-06-03 at 19:12 +0530, Aneesh Kumar K.V wrote:
> > 
> > +int next_demotion_node(int node)
> > +{
> > +	struct demotion_nodes *nd;
> > +	int target, nnodes, i;
> > +
> > +	if (!node_demotion)
> > +		return NUMA_NO_NODE;
> > +
> > +	nd = &node_demotion[node];
> > +
> > +	/*
> > +	 * node_demotion[] is updated without excluding this
> > +	 * function from running.
> > +	 *
> > +	 * Make sure to use RCU over entire code blocks if
> > +	 * node_demotion[] reads need to be consistent.
> > +	 */
> > +	rcu_read_lock();
> > +
> > +	nnodes = nodes_weight(nd->preferred);
> > +	if (!nnodes)
> > +		return NUMA_NO_NODE;
> > +
> > +	/*
> > +	 * If there are multiple target nodes, just select one
> > +	 * target node randomly.
> > +	 *
> > +	 * In addition, we can also use round-robin to select
> > +	 * target node, but we should introduce another variable
> > +	 * for node_demotion[] to record last selected target node,
> > +	 * that may cause cache ping-pong due to the changing of
> > +	 * last target node. Or introducing per-cpu data to avoid
> > +	 * caching issue, which seems more complicated. So selecting
> > +	 * target node randomly seems better until now.
> > +	 */
> > +	nnodes = get_random_int() % nnodes;
> > +	target = first_node(nd->preferred);
> > +	for (i = 0; i < nnodes; i++)
> > +		target = next_node(target, nd->preferred);
> 
> We can simplify the above 4 lines.
> 
> 	target = node_random(nd->preferred);
> 
> There's still a loop overhead though :(

To avoid loop overhead, we can use the original implementation of
next_demotion_node.  The performance is much better for the most common
cases, the number of preferred node is 1.

Best Regards,
Huang, Ying

> > 
> > 

> > +
> > +	rcu_read_unlock();
> > +
> > +	return target;
> > +}
> > +
> > 
> > + */
> > +static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
> > +						 unsigned long action, void *_arg)
> > +{
> > +	struct memory_notify *arg = _arg;
> > +
> > +	/*
> > +	 * Only update the node migration order when a node is
> > +	 * changing status, like online->offline.
> > +	 */
> > +	if (arg->status_change_nid < 0)
> > +		return notifier_from_errno(0);
> > +
> > +	switch (action) {
> > +	case MEM_OFFLINE:
> > +		/*
> > +		 * In case we are moving out of N_MEMORY. Keep the node
> > +		 * in the memory tier so that when we bring memory online,
> > +		 * they appear in the right memory tier. We still need
> > +		 * to rebuild the demotion order.
> > +		 */
> > +		mutex_lock(&memory_tier_lock);
> > +		establish_migration_targets();
> > +		mutex_unlock(&memory_tier_lock);
> > +		break;
> > +	case MEM_ONLINE:
> > +		/*
> > +		 * We ignore the error here, if the node already have the tier
> > +		 * registered, we will continue to use that for the new memory
> > +		 * we are adding here.
> > +		 */
> > +		node_set_memory_tier(arg->status_change_nid, DEFAULT_MEMORY_TIER);
> 
> Should establish_migration_targets() be run here? Otherwise what are the
> demotion targets for this newly onlined node?
> 
> > +		break;
> > +	}
> > +
> > +	return notifier_from_errno(0);
> > +}
> > +
> 
> Tim
> 


