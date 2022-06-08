Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C89754288E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiFHHwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiFHHvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 03:51:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F49100500
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 00:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654672687; x=1686208687;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wotc8dogZL4LUHpHacn7DgZBf7g5fqOuafBDysmW2Zg=;
  b=mwJfDLWOX8Mv2WcWhHE/0220uCodnLtQ/mHbPlTDExZuljg/PcoZoevT
   d9CILGK/LrDZcryADqeZdUwNnyJxAV27RLKd7lZKOCyjfINgIHQ4p0a9e
   060Gq3CRMV9duuIL+VbAJPudgvIaVby6C6/GyiRcGDnXb2pxzrVodIj5e
   XW2IdNueyjCWaiPIb+wWUD+XxJIyqiDdfs/HdANzQgrnMWC6chzWeiAxG
   h4zHBIE8D4L3ymUPBM7rntHeowlYxSPIVv13aI79YL5assp052uCJ0dX5
   efz0/iLzJ37ACzU1eNlCcrtZ/XF8+G4/FmqYoWQ8lY4XNp78wZExuqSnt
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="274332753"
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="274332753"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 00:18:06 -0700
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="907515184"
Received: from xding11-mobl.ccr.corp.intel.com ([10.254.214.239])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 00:18:02 -0700
Message-ID: <e5c311d6c2f97407373aba0895aa6e7c0ce8d377.camel@intel.com>
Subject: Re: [RFC PATCH v4 2/7] mm/demotion: Expose per node memory tier to
 sysfs
From:   Ying Huang <ying.huang@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Greg Thelen <gthelen@google.com>, Yang Shi <shy828301@gmail.com>,
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
Date:   Wed, 08 Jun 2022 15:18:00 +0800
In-Reply-To: <20220527122528.129445-3-aneesh.kumar@linux.ibm.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
         <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
         <20220527122528.129445-3-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-27 at 17:55 +0530, Aneesh Kumar K.V wrote:
> From: Jagdish Gediya <jvgediya@linux.ibm.com>
> 
> Add support to read/write the memory tierindex for a NUMA node.
> 
> /sys/devices/system/node/nodeN/memtier
> 
> where N = node id
> 
> When read, It list the memory tier that the node belongs to.
> 
> When written, the kernel moves the node into the specified
> memory tier, the tier assignment of all other nodes are not
> affected.
> 
> If the memory tier does not exist, writing to the above file
> create the tier and assign the NUMA node to that tier.
> 
> mutex memory_tier_lock is introduced to protect memory tier
> related chanegs as it can happen from sysfs as well on hot
> plug events.
> 
> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  drivers/base/node.c     |  35 ++++++++++++++
>  include/linux/migrate.h |   4 +-
>  mm/migrate.c            | 103 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 141 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index ec8bb24a5a22..cf4a58446d8c 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -20,6 +20,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/swap.h>
>  #include <linux/slab.h>
> +#include <linux/migrate.h>
>  
> 
> 
> 
>  static struct bus_type node_subsys = {
>  	.name = "node",
> @@ -560,11 +561,45 @@ static ssize_t node_read_distance(struct device *dev,
>  }
>  static DEVICE_ATTR(distance, 0444, node_read_distance, NULL);
>  
> 
> 
> 
> +#ifdef CONFIG_TIERED_MEMORY
> +static ssize_t memtier_show(struct device *dev,
> +			    struct device_attribute *attr,
> +			    char *buf)
> +{
> +	int node = dev->id;
> +
> +	return sysfs_emit(buf, "%d\n", node_get_memory_tier(node));
> +}
> +
> +static ssize_t memtier_store(struct device *dev,
> +			     struct device_attribute *attr,
> +			     const char *buf, size_t count)
> +{
> +	unsigned long tier;
> +	int node = dev->id;
> +
> +	int ret = kstrtoul(buf, 10, &tier);
> +	if (ret)
> +		return ret;
> +
> +	ret = node_reset_memory_tier(node, tier);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(memtier);
> +#endif
> +
>  static struct attribute *node_dev_attrs[] = {
>  	&dev_attr_meminfo.attr,
>  	&dev_attr_numastat.attr,
>  	&dev_attr_distance.attr,
>  	&dev_attr_vmstat.attr,
> +#ifdef CONFIG_TIERED_MEMORY
> +	&dev_attr_memtier.attr,
> +#endif
>  	NULL
>  };
>  
> 
> 
> 
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 0ec653623565..d37d1d5dee82 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -177,13 +177,15 @@ enum memory_tier_type {
>  };
>  
> 
> 
> 
>  int next_demotion_node(int node);
> -
>  extern void migrate_on_reclaim_init(void);
>  #ifdef CONFIG_HOTPLUG_CPU
>  extern void set_migration_target_nodes(void);
>  #else
>  static inline void set_migration_target_nodes(void) {}
>  #endif
> +int node_get_memory_tier(int node);
> +int node_set_memory_tier(int node, int tier);
> +int node_reset_memory_tier(int node, int tier);
>  #else
>  #define numa_demotion_enabled	false
>  static inline int next_demotion_node(int node)
> diff --git a/mm/migrate.c b/mm/migrate.c
> index f28ee93fb017..304559ba3372 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2132,6 +2132,7 @@ static struct bus_type memory_tier_subsys = {
>  	.dev_name = "memtier",
>  };
>  
> 
> 
> 
> +DEFINE_MUTEX(memory_tier_lock);
>  static struct memory_tier *memory_tiers[MAX_MEMORY_TIERS];
>  
> 
> 
> 
>  static ssize_t nodelist_show(struct device *dev,
> @@ -2225,6 +2226,108 @@ static const struct attribute_group *memory_tier_attr_groups[] = {
>  	NULL,
>  };
>  
> 
> 
> 
> +static int __node_get_memory_tier(int node)
> +{
> +	int tier;
> +
> +	for (tier = 0; tier < MAX_MEMORY_TIERS; tier++) {
> +		if (memory_tiers[tier] && node_isset(node, memory_tiers[tier]->nodelist))
> +			return tier;
> +	}
> +
> +	return -1;
> +}
> +
> +int node_get_memory_tier(int node)
> +{
> +	int tier;
> +
> +	/*
> +	 * Make sure memory tier is not unregistered
> +	 * while it is being read.
> +	 */
> +	mutex_lock(&memory_tier_lock);
> +
> +	tier = __node_get_memory_tier(node);
> +
> +	mutex_unlock(&memory_tier_lock);
> +
> +	return tier;
> +}
> +
> +int __node_set_memory_tier(int node, int tier)
> +{
> +	int ret = 0;
> +	/*
> +	 * As register_memory_tier() for new tier can fail,
> +	 * try it before modifying existing tier. register
> +	 * tier makes tier visible in sysfs.
> +	 */
> +	if (!memory_tiers[tier]) {
> +		ret = register_memory_tier(tier);
> +		if (ret) {
> +			goto out;
> +		}
> +	}
> +
> +	node_set(node, memory_tiers[tier]->nodelist);
> +
> +out:
> +	return ret;
> +}
> +
> +int node_reset_memory_tier(int node, int tier)

I think "reset" isn't a good name here.  Maybe something like "change"
or "move"?

Best Regards,
Huang, Ying

> +{
> +	int current_tier, ret = 0;
> +
> +	mutex_lock(&memory_tier_lock);
> +
> +	current_tier = __node_get_memory_tier(node);
> +	if (current_tier == tier)
> +		goto out;
> +
> +	if (current_tier != -1 )
> +		node_clear(node, memory_tiers[current_tier]->nodelist);
> +
> +	ret = __node_set_memory_tier(node, tier);
> +
> +	if (!ret) {
> +		if (nodes_empty(memory_tiers[current_tier]->nodelist))
> +			unregister_memory_tier(current_tier);
> +	} else {
> +		/* reset it back to older tier */
> +		ret = __node_set_memory_tier(node, current_tier);
> +	}
> +out:
> +	mutex_unlock(&memory_tier_lock);
> +
> +	return ret;
> +}
> +
> +int node_set_memory_tier(int node, int tier)
> +{
> +	int current_tier, ret = 0;
> +
> +	if (tier >= MAX_MEMORY_TIERS)
> +		return -EINVAL;
> +
> +	mutex_lock(&memory_tier_lock);
> +	current_tier = __node_get_memory_tier(node);
> +	/*
> +	 * if node is already part of the tier proceed with the
> +	 * current tier value, because we might want to establish
> +	 * new migration paths now. The node might be added to a tier
> +	 * before it was made part of N_MEMORY, hence estabilish_migration_targets
> +	 * will have skipped this node.
> +	 */
> +	if (current_tier != -1)
> +		tier = current_tier;
> +	ret = __node_set_memory_tier(node, tier);
> +	mutex_unlock(&memory_tier_lock);
> +
> +	return ret;
> +}
> +
>  /*
>   * node_demotion[] example:
>   *


