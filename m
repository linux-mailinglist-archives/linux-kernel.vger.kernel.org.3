Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D134506072
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbiDSAEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236772AbiDSADv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:03:51 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B082A70E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650326456; x=1681862456;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=slJKPvfkL1F/w5QJNOdWLawMAtPvZc5SwNSn9nJ5J/Q=;
  b=U8mWHLePtnfYAHuhxlzcvuV041IuevffnuUa1UuzbturPIVV0T9AblyC
   nmDIYiY0SGXau1hCCv+jNAr2/Ah8KoNwjL9k7RBNRQ6RO9JvFEOCFq3Fd
   sCk08FnJW31fwldWdjEmb6YSbkwZHzcLVor5cqFEA+1qA7Pug8dAksdrX
   ZH3Sf7Houo38VcVvWnepELJZLYLYfrkWeBuqi9q+XliDHfMtvBoawiw1A
   /HyOQ/03ABU+hH3pYO9ZU5q7Sd0bIiFpRvHLqwfq9YvshduetOCVDUl+a
   9q4MA9diRF6rdbRAcOAA+kOmcBWTNwjl3V460l5cdwQ28hJA4zt6DXuZL
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="288730760"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="288730760"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 17:00:56 -0700
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="561511613"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.117.29])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 17:00:55 -0700
Message-ID: <c7520aec8bd41550a520e411a829de892807dcb5.camel@linux.intel.com>
Subject: Re: [PATCH 4/6] mm: introduce per-node proactive reclaim interface
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org, rientjes@google.com,
        yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com,
        dave.hansen@linux.intel.com, roman.gushchin@linux.dev,
        gthelen@google.com, a.manzanares@samsung.com,
        heekwon.p@samsung.com, gim.jongmin@samsung.com,
        linux-kernel@vger.kernel.org
Date:   Mon, 18 Apr 2022 17:00:55 -0700
In-Reply-To: <20220416053902.68517-5-dave@stgolabs.net>
References: <20220416053902.68517-1-dave@stgolabs.net>
         <20220416053902.68517-5-dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-04-15 at 22:39 -0700, Davidlohr Bueso wrote:
> This patch introduces a mechanism to trigger memory reclaim
> as a per-node sysfs interface, inspired by compaction's
> equivalent; ie:
> 
> 	 echo 1G > /sys/devices/system/node/nodeX/reclaim
> 

I think it will be more flexible to specify a node mask
as a parameter along with amount of memory with the 
memory.reclaim memcg interface proposed by Yosry.  Doing it node
by node is more cumbersome.  It is just a special case
of reclaiming from root cgroup for a specific node.

Wei Gu, YIng and I have some discssions on this
https://lore.kernel.org/all/df6110a09cacc80ee1cbe905a71273a5f3953e16.camel@linux.intel.com/  

 
Tim

> It is based on the discussions from David's thread[1] as
> well as the current upstreaming of the memcg[2] interface
> (which has nice explanations for the benefits of userspace
> reclaim overall). In both cases conclusions were that either
> way of inducing proactive reclaim should be KISS, and can be
> later extended. So this patch does not allow the user much
> fine tuning beyond the size of the reclaim, such as anon/file
> or whether or semantics of demotion.
> 
> [1] https://lore.kernel.org/all/5df21376-7dd1-bf81-8414-32a73cea45dd@google.com/
> [2] https://lore.kernel.org/all/20220408045743.1432968-1-yosryahmed@google.com/
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  Documentation/ABI/stable/sysfs-devices-node | 10 ++++
>  drivers/base/node.c                         |  2 +
>  include/linux/swap.h                        | 16 ++++++
>  mm/vmscan.c                                 | 59 +++++++++++++++++++++
>  4 files changed, 87 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
> index 8db67aa472f1..3c935e1334f7 100644
> --- a/Documentation/ABI/stable/sysfs-devices-node
> +++ b/Documentation/ABI/stable/sysfs-devices-node
> @@ -182,3 +182,13 @@ Date:		November 2021
>  Contact:	Jarkko Sakkinen <jarkko@kernel.org>
>  Description:
>  		The total amount of SGX physical memory in bytes.
> +
> +What:		/sys/devices/system/node/nodeX/reclaim
> +Date:		April 2022
> +Contact:	Davidlohr Bueso <dave@stgolabs.net>
> +Description:
> +		Write the amount of bytes to induce memory reclaim in this node.
> +		This file accepts a single key, the number of bytes to reclaim.
> +		When it completes successfully, the specified amount or more memory
> +		will have been reclaimed, and -EAGAIN if less bytes are reclaimed
> +		than the specified amount.
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 6cdf25fd26c3..d80c478e2a6e 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -670,6 +670,7 @@ static int register_node(struct node *node, int num)
>  
>  	hugetlb_register_node(node);
>  	compaction_register_node(node);
> +	reclaim_register_node(node);
>  	return 0;
>  }
>  
> @@ -685,6 +686,7 @@ void unregister_node(struct node *node)
>  	hugetlb_unregister_node(node);		/* no-op, if memoryless node */
>  	node_remove_accesses(node);
>  	node_remove_caches(node);
> +	reclaim_unregister_node(node);
>  	device_unregister(&node->dev);
>  }
>  
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 27093b477c5f..cca43ae6d770 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -398,6 +398,22 @@ extern unsigned long shrink_all_memory(unsigned long nr_pages);
>  extern int vm_swappiness;
>  long remove_mapping(struct address_space *mapping, struct folio *folio);
>  
> +#if defined(CONFIG_SYSFS) && defined(CONFIG_NUMA)
> +extern int reclaim_register_node(struct node *node);
> +extern void reclaim_unregister_node(struct node *node);
> +
> +#else
> +
> +static inline int reclaim_register_node(struct node *node)
> +{
> +	return 0;
> +}
> +
> +static inline void reclaim_unregister_node(struct node *node)
> +{
> +}
> +#endif /* CONFIG_SYSFS && CONFIG_NUMA */
> +
>  extern unsigned long reclaim_pages(struct list_head *page_list);
>  #ifdef CONFIG_NUMA
>  extern int node_reclaim_mode;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 1735c302831c..3539f8a0f0ea 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4819,3 +4819,62 @@ void check_move_unevictable_pages(struct pagevec *pvec)
>  	}
>  }
>  EXPORT_SYMBOL_GPL(check_move_unevictable_pages);
> +
> +#if defined(CONFIG_SYSFS) && defined(CONFIG_NUMA)
> +static ssize_t reclaim_store(struct device *dev,
> +			     struct device_attribute *attr,
> +			     const char *buf, size_t count)
> +{
> +	int err, nid = dev->id;
> +	gfp_t gfp_mask = GFP_KERNEL;
> +	struct pglist_data *pgdat = NODE_DATA(nid);
> +	unsigned long nr_to_reclaim, nr_reclaimed = 0;
> +	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
> +	struct scan_control sc = {
> +		.gfp_mask = current_gfp_context(gfp_mask),
> +		.reclaim_idx = gfp_zone(gfp_mask),
> +		.priority = NODE_RECLAIM_PRIORITY,
> +		.may_writepage = !laptop_mode,
> +		.may_unmap = 1,
> +		.may_swap = 1,
> +	};
> +
> +	buf = strstrip((char *)buf);
> +	err = page_counter_memparse(buf, "", &nr_to_reclaim);
> +	if (err)
> +		return err;
> +
> +	sc.nr_to_reclaim = max(nr_to_reclaim, SWAP_CLUSTER_MAX);
> +
> +	while (nr_reclaimed < nr_to_reclaim) {
> +		unsigned long reclaimed;
> +
> +		if (test_and_set_bit(PGDAT_RECLAIM_LOCKED, &pgdat->flags))
> +			return -EAGAIN;
> +
> +		/* does cond_resched() */
> +		reclaimed = __node_reclaim(pgdat, gfp_mask,
> +					   nr_to_reclaim - nr_reclaimed, &sc);
> +
> +		clear_bit(PGDAT_RECLAIM_LOCKED, &pgdat->flags);
> +
> +		if (!reclaimed && !nr_retries--)
> +			break;
> +
> +		nr_reclaimed += reclaimed;
> +	}
> +
> +	return nr_reclaimed < nr_to_reclaim ? -EAGAIN : count;
> +}
> +
> +static DEVICE_ATTR_WO(reclaim);
> +int reclaim_register_node(struct node *node)
> +{
> +	return device_create_file(&node->dev, &dev_attr_reclaim);
> +}
> +
> +void reclaim_unregister_node(struct node *node)
> +{
> +	return device_remove_file(&node->dev, &dev_attr_reclaim);
> +}
> +#endif

