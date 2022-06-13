Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B4F548049
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 09:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238787AbiFMHIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 03:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiFMHIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 03:08:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B6A6324
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 00:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655104089; x=1686640089;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4ZL5x0SSS5qZVmA+JgyUkPjLyNtKpHowUfKdZup163A=;
  b=L8NYmZR8jMyeK+1owr5MTSCzv2AMh7KmkiHSMnV7kWHzLIrWm2MQkcQz
   5boTAInpsR+04TDoWqu609sWQJJ7g4u1tOIwGFZ7n7F2m6sTB/9AC2fqM
   e1Kfymih0cUyZh4jDxdSGFIvRAuno15IRAFORx5C4ec9JIOBxF3GVHvNu
   OnrDJySms6F03KEIn9sYLVE+K4oZt0nEVBg0JSJDdt/fvkrBJNwUWMvwB
   ZMnqR23RgRF6myRKzJbzROaBct+yAR5QDeE1yMK73feQZt6A6LnyK0ej7
   aIIqHeIsrNeSCz+HtAWP4b+OjNBkEWcNKV43Gko4fRsyTeOlzkkhfqOHV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="279240371"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="279240371"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 00:08:04 -0700
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="651263450"
Received: from xinyangc-mobl.ccr.corp.intel.com ([10.254.214.65])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 00:07:59 -0700
Message-ID: <d4170cd543b250260678341c3ffbe5bb8aaf97f1.camel@intel.com>
Subject: Re: [PATCH v6 09/13] mm/demotion: Add pg_data_t member to track
 node memory tier details
From:   Ying Huang <ying.huang@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
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
Date:   Mon, 13 Jun 2022 15:07:57 +0800
In-Reply-To: <20220610135229.182859-10-aneesh.kumar@linux.ibm.com>
References: <20220610135229.182859-1-aneesh.kumar@linux.ibm.com>
         <20220610135229.182859-10-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-06-10 at 19:22 +0530, Aneesh Kumar K.V wrote:
> Also update different helpes to use NODE_DATA()->memtier. Since
> node specific memtier can change based on the reassignment of
> NUMA node to a different memory tiers, accessing NODE_DATA()->memtier
> needs to under an rcu read lock of memory_tier_lock.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  include/linux/memory-tiers.h |  14 +++++
>  include/linux/mmzone.h       |   3 ++
>  mm/memory-tiers.c            | 102 ++++++++++++++++++++++++++---------
>  3 files changed, 94 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index 52896f5970b7..53f3e4c7cba8 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -6,6 +6,9 @@
>  
> 
>  #ifdef CONFIG_TIERED_MEMORY
>  
> 
> +#include <linux/device.h>
> +#include <linux/nodemask.h>
> +
>  #define MEMORY_TIER_HBM_GPU	0
>  #define MEMORY_TIER_DRAM	1
>  #define MEMORY_TIER_PMEM	2
> @@ -18,13 +21,24 @@
>  #define MAX_STATIC_MEMORY_TIERS  3
>  #define MAX_MEMORY_TIERS  (MAX_STATIC_MEMORY_TIERS + 2)
>  
> 
> +struct memory_tier {
> +	struct list_head list;
> +	struct device dev;
> +	nodemask_t nodelist;
> +	int rank;
> +};
> +

I suggest to use two data structure,

struct memory_tier {
	struct list_head list;
	nodemask_t nodelist;
	int rank;
};

struct memory_tier_dev {
	struct list_head list;
	struct device dev;
	struct memory_tier *tier;
};

Then we can put struct memory_tier here and still hide struct
memory_tier_dev in memory_tiers.c.  In this way, we don't need to
force all struct memory_tier users to compile the entire driver core
headers.  And we can separate the user space interface implementation
from the other part of the kernel.

>  extern bool numa_demotion_enabled;
>  int node_create_and_set_memory_tier(int node, int tier);
>  int next_demotion_node(int node);
>  int node_set_memory_tier(int node, int tier);
>  int node_get_memory_tier_id(int node);
>  int node_reset_memory_tier(int node, int tier);
> +struct memory_tier *node_get_memory_tier(int node);
> +void node_put_memory_tier(struct memory_tier *memtier);

I don't find caller of these 2 functions in series.  Can we remove
these functions?

Best Regards,
Huang, Ying

[snip]

