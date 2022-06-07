Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5993F542720
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443891AbiFHCG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1587901AbiFGXxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:53:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D85580C7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 15:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654642318; x=1686178318;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=khH4Qxle0YPqCnpZ0X/zFyy4Qo0r/sKFGCE5CQoJbzc=;
  b=CT5VrMs5/fi9LDJArlqjGXK3h4emQAkGRXP3wS1QV6/QcSxZNK4VWcFR
   +0pfn1PV5oTQ/h2/wL7czLTcxpq6wetdlX7jg3YKlBVshAGxvOcLCm4ZV
   jUmoG7/pfD7p29h27Qv6cTksaXP8aIK/GLFTNFQPkUHy/3eOJhZUt3RWu
   QRwo914QOn1hNmjoww4FtRMUmisHfuoz9j2Av4tJXfdkM+pwUdNapLHwr
   QtTr/GAEY8Epi+0dA+JFHEt17QFUAL8uMePCDs038CZ2AIrnWpgRClpJv
   cBqhQfM6uaM5mc866wNGURFwCpHvjdehKiSQOtqhxsVgpF1UxwE7kQhVE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="274293437"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="274293437"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 15:51:58 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="609400279"
Received: from schen9-mobl.amr.corp.intel.com ([10.251.8.166])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 15:51:57 -0700
Message-ID: <c4678658cdd04d14ced7d0407da32f5fdec19f95.camel@linux.intel.com>
Subject: Re: [PATCH v5 4/9] mm/demotion: Build demotion targets based on
 explicit memory tiers
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
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
        David Rientjes <rientjes@google.com>
Date:   Tue, 07 Jun 2022 15:51:57 -0700
In-Reply-To: <20220603134237.131362-5-aneesh.kumar@linux.ibm.com>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
         <20220603134237.131362-5-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-06-03 at 19:12 +0530, Aneesh Kumar K.V wrote:
> 
> +int next_demotion_node(int node)
> +{
> +	struct demotion_nodes *nd;
> +	int target, nnodes, i;
> +
> +	if (!node_demotion)
> +		return NUMA_NO_NODE;
> +
> +	nd = &node_demotion[node];
> +
> +	/*
> +	 * node_demotion[] is updated without excluding this
> +	 * function from running.
> +	 *
> +	 * Make sure to use RCU over entire code blocks if
> +	 * node_demotion[] reads need to be consistent.
> +	 */
> +	rcu_read_lock();
> +
> +	nnodes = nodes_weight(nd->preferred);
> +	if (!nnodes)
> +		return NUMA_NO_NODE;
> +
> +	/*
> +	 * If there are multiple target nodes, just select one
> +	 * target node randomly.
> +	 *
> +	 * In addition, we can also use round-robin to select
> +	 * target node, but we should introduce another variable
> +	 * for node_demotion[] to record last selected target node,
> +	 * that may cause cache ping-pong due to the changing of
> +	 * last target node. Or introducing per-cpu data to avoid
> +	 * caching issue, which seems more complicated. So selecting
> +	 * target node randomly seems better until now.
> +	 */
> +	nnodes = get_random_int() % nnodes;
> +	target = first_node(nd->preferred);
> +	for (i = 0; i < nnodes; i++)
> +		target = next_node(target, nd->preferred);

We can simplify the above 4 lines.

	target = node_random(nd->preferred);

There's still a loop overhead though :(

> +
> +	rcu_read_unlock();
> +
> +	return target;
> +}
> +
> 
> + */
> +static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
> +						 unsigned long action, void *_arg)
> +{
> +	struct memory_notify *arg = _arg;
> +
> +	/*
> +	 * Only update the node migration order when a node is
> +	 * changing status, like online->offline.
> +	 */
> +	if (arg->status_change_nid < 0)
> +		return notifier_from_errno(0);
> +
> +	switch (action) {
> +	case MEM_OFFLINE:
> +		/*
> +		 * In case we are moving out of N_MEMORY. Keep the node
> +		 * in the memory tier so that when we bring memory online,
> +		 * they appear in the right memory tier. We still need
> +		 * to rebuild the demotion order.
> +		 */
> +		mutex_lock(&memory_tier_lock);
> +		establish_migration_targets();
> +		mutex_unlock(&memory_tier_lock);
> +		break;
> +	case MEM_ONLINE:
> +		/*
> +		 * We ignore the error here, if the node already have the tier
> +		 * registered, we will continue to use that for the new memory
> +		 * we are adding here.
> +		 */
> +		node_set_memory_tier(arg->status_change_nid, DEFAULT_MEMORY_TIER);

Should establish_migration_targets() be run here? Otherwise what are the
demotion targets for this newly onlined node?

> +		break;
> +	}
> +
> +	return notifier_from_errno(0);
> +}
> +

Tim

