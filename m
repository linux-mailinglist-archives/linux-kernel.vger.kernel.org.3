Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3026F57F981
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 08:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiGYGhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 02:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGYGhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 02:37:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0015F113
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 23:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658731061; x=1690267061;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=8SLs0JY1kGfaVztg6KPS61atwTU4p6amQQzBfjOtz3o=;
  b=NRwF7MxOS40dlrXuZhqJ2Ddh9IwqAy20w5T6qIRhRsEoZZHIkTs3WMO/
   UiXrhS+b5+sRrPgvWVGH0GLjM+UTMEh96+Jm1wp+MQto+tmg4WevRedzf
   dwxAlqe6ZtH8TAe0LWmG+WCdE6abj/tty1bH6qKCeh0Fsvyg759G0lEa1
   3/G3+j3e6m6CHYVAtvrntJAI9hs89IJUdgoep/0Uw5xoUCQv9XwqOmOpJ
   i3sRAC8ytMqFnewQABEP+8hlPSrK9X4afLnhlO7/1XwovG9AWGd+fZjM4
   ZrkXTGmN37Dlx0brawpxXZ74ZKyj5ZRQ+eNVI2wJxQdtagqnskFqhvpIY
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="287637655"
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="287637655"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 23:37:41 -0700
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="926777672"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 23:37:38 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
Subject: Re: [PATCH v10 4/8] mm/demotion/dax/kmem: Set node's performance
 level to MEMTIER_PERF_LEVEL_PMEM
References: <20220720025920.1373558-1-aneesh.kumar@linux.ibm.com>
        <20220720025920.1373558-5-aneesh.kumar@linux.ibm.com>
Date:   Mon, 25 Jul 2022 14:37:34 +0800
In-Reply-To: <20220720025920.1373558-5-aneesh.kumar@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Wed, 20 Jul 2022 08:29:16 +0530")
Message-ID: <874jz5zoi9.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> By default, all nodes are assigned to the default memory tier which
> is the memory tier designated for nodes with DRAM
>
> Set dax kmem device node's tier to slower memory tier by assigning
> performance level to MEMTIER_PERF_LEVEL_PMEM. PMEM tier
> appears below the default memory tier in demotion order.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/papr_scm.c | 41 ++++++++++++++++++++---
>  drivers/acpi/nfit/core.c                  | 41 ++++++++++++++++++++++-
>  2 files changed, 76 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index 82cae08976bc..3b6164418d6f 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -14,6 +14,8 @@
>  #include <linux/delay.h>
>  #include <linux/seq_buf.h>
>  #include <linux/nd.h>
> +#include <linux/memory.h>
> +#include <linux/memory-tiers.h>
>  
>  #include <asm/plpar_wrappers.h>
>  #include <asm/papr_pdsm.h>
> @@ -98,6 +100,7 @@ struct papr_scm_priv {
>  	bool hcall_flush_required;
>  
>  	uint64_t bound_addr;
> +	int target_node;
>  
>  	struct nvdimm_bus_descriptor bus_desc;
>  	struct nvdimm_bus *bus;
> @@ -1278,6 +1281,7 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>  	p->bus_desc.module = THIS_MODULE;
>  	p->bus_desc.of_node = p->pdev->dev.of_node;
>  	p->bus_desc.provider_name = kstrdup(p->pdev->name, GFP_KERNEL);
> +	p->target_node = dev_to_node(&p->pdev->dev);
>  
>  	/* Set the dimm command family mask to accept PDSMs */
>  	set_bit(NVDIMM_FAMILY_PAPR, &p->bus_desc.dimm_family_mask);
> @@ -1322,7 +1326,7 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>  	mapping.size = p->blocks * p->block_size; // XXX: potential overflow?
>  
>  	memset(&ndr_desc, 0, sizeof(ndr_desc));
> -	target_nid = dev_to_node(&p->pdev->dev);
> +	target_nid = p->target_node;
>  	online_nid = numa_map_to_online_node(target_nid);
>  	ndr_desc.numa_node = online_nid;
>  	ndr_desc.target_node = target_nid;
> @@ -1582,15 +1586,42 @@ static struct platform_driver papr_scm_driver = {
>  	},
>  };
>  
> +static int papr_scm_callback(struct notifier_block *self,
> +			     unsigned long action, void *arg)
> +{
> +	struct memory_notify *mnb = arg;
> +	int nid = mnb->status_change_nid;
> +	struct papr_scm_priv *p;
> +
> +	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
> +		return NOTIFY_OK;
> +
> +	mutex_lock(&papr_ndr_lock);
> +	list_for_each_entry(p, &papr_nd_regions, region_list) {
> +		if (p->target_node == nid) {
> +			node_devices[nid]->perf_level = MEMTIER_PERF_LEVEL_PMEM;
> +			break;
> +		}
> +	}
> +
> +	mutex_unlock(&papr_ndr_lock);
> +	return NOTIFY_OK;
> +}
> +
>  static int __init papr_scm_init(void)
>  {
>  	int ret;
>  
>  	ret = platform_driver_register(&papr_scm_driver);
> -	if (!ret)
> -		mce_register_notifier(&mce_ue_nb);
> -
> -	return ret;
> +	if (ret)
> +		return ret;
> +	mce_register_notifier(&mce_ue_nb);
> +	/*
> +	 * register a memory hotplug notifier at prio 2 so that we
> +	 * can update the perf level for the node.
> +	 */
> +	hotplug_memory_notifier(papr_scm_callback, MEMTIER_HOTPLUG_PRIO + 1);
> +	return 0;
>  }
>  module_init(papr_scm_init);
>  
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index ae5f4acf2675..7ea1017ef790 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -15,6 +15,8 @@
>  #include <linux/sort.h>
>  #include <linux/io.h>
>  #include <linux/nd.h>
> +#include <linux/memory.h>
> +#include <linux/memory-tiers.h>
>  #include <asm/cacheflush.h>
>  #include <acpi/nfit.h>
>  #include "intel.h"
> @@ -3470,6 +3472,39 @@ static struct acpi_driver acpi_nfit_driver = {
>  	},
>  };
>  
> +static int nfit_callback(struct notifier_block *self,
> +			 unsigned long action, void *arg)
> +{
> +	bool found = false;
> +	struct memory_notify *mnb = arg;
> +	int nid = mnb->status_change_nid;
> +	struct nfit_spa *nfit_spa;
> +	struct acpi_nfit_desc *acpi_desc;
> +
> +	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
> +		return NOTIFY_OK;
> +
> +	mutex_lock(&acpi_desc_lock);
> +	list_for_each_entry(acpi_desc, &acpi_descs, list) {
> +		mutex_lock(&acpi_desc->init_mutex);
> +		list_for_each_entry(nfit_spa, &acpi_desc->spas, list) {
> +			struct acpi_nfit_system_address *spa = nfit_spa->spa;
> +			int target_node = pxm_to_node(spa->proximity_domain);
> +
> +			if (target_node == nid) {
> +				node_devices[nid]->perf_level = MEMTIER_PERF_LEVEL_PMEM;
> +				found = true;
> +				break;
> +			}
> +		}
> +		mutex_unlock(&acpi_desc->init_mutex);
> +		if (found)
> +			break;
> +	}
> +	mutex_unlock(&acpi_desc_lock);
> +	return NOTIFY_OK;
> +}
> +
>  static __init int nfit_init(void)
>  {
>  	int ret;
> @@ -3509,7 +3544,11 @@ static __init int nfit_init(void)
>  		nfit_mce_unregister();
>  		destroy_workqueue(nfit_wq);
>  	}
> -
> +	/*
> +	 * register a memory hotplug notifier at prio 2 so that we
> +	 * can update the perf level for the node.
> +	 */
> +	hotplug_memory_notifier(nfit_callback, MEMTIER_HOTPLUG_PRIO + 1);
>  	return ret;
>  
>  }

I don't think that it's a good idea to set perf_level of a memory device
(node) via NFIT only.

For example, we may prefer HMAT over NFIT when it's available.  So the
perf_level should be set in dax/kmem.c based on information provided by
ACPI or other information sources.  ACPI can provide some functions/data
structures to let drivers (like dax/kmem.c) to query the properties of
the memory device (node).

As the simplest first version, this can be just hard coded.

Best Regards,
Huang, Ying
