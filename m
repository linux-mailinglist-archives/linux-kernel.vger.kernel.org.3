Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C985B53B3B9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiFBGlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiFBGlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:41:49 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F522A3A04
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654152107; x=1685688107;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hkExu+xypCvEZ2GrPWlhA1VX0WFEoqjTwVjGVoC+Nkk=;
  b=P5DR1tbGOGWXVWqNjyB5RITAgEzUngeKBfVsVIwpJRAjxUBya+WhvA0I
   UPnDQXnsIB+w94R3O5wciIox0biEbl8K51NIk9hj48dGbcs/ajZC1Rfpj
   okAd6YGiYyltQr1UHsoh3QIdlP0x4gPwmnSyrGD4RFVkBq+I43k6ukbz2
   Xa2mSw7zGHPTg2tpeG8K0dFDpchs/3ESgEujofsX+UUYEW7xkOU00RSL8
   T12SkzA86P2AbZGffXB7DcEucymHzW3wvlD9GlKbBxFXsy/EJYjOWPYLj
   YqtmqjFDVa2fqdpIl3XuwHYbiI2X133TC8z+miC9OAQ83IIqxHOfqpwIE
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="301206430"
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="301206430"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 23:41:46 -0700
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="552685962"
Received: from yanqingl-mobl1.ccr.corp.intel.com ([10.254.212.10])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 23:41:41 -0700
Message-ID: <d8bf8096ef268d8bc4a60c86a7be04e690c69099.camel@intel.com>
Subject: Re: [RFC PATCH v4 5/7] mm/demotion: Add support to associate rank
 with memory tier
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
Date:   Thu, 02 Jun 2022 14:41:39 +0800
In-Reply-To: <20220527122528.129445-6-aneesh.kumar@linux.ibm.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
         <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
         <20220527122528.129445-6-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-27 at 17:55 +0530, Aneesh Kumar K.V wrote:
> The rank approach allows us to keep memory tier device IDs stable even if there
> is a need to change the tier ordering among different memory tiers. e.g. DRAM
> nodes with CPUs will always be on memtier1, no matter how many tiers are higher
> or lower than these nodes. A new memory tier can be inserted into the tier
> hierarchy for a new set of nodes without affecting the node assignment of any
> existing memtier, provided that there is enough gap in the rank values for the
> new memtier.
> 
> The absolute value of "rank" of a memtier doesn't necessarily carry any meaning.
> Its value relative to other memtiers decides the level of this memtier in the tier
> hierarchy.
> 
> For now, This patch supports hardcoded rank values which are 100, 200, & 300 for
> memory tiers 0,1 & 2 respectively.
> 
> Below is the sysfs interface to read the rank values of memory tier,
> /sys/devices/system/memtier/memtierN/rank
> 
> This interface is read only for now, write support can be added when there is
> a need of flexibility of more number of memory tiers(> 3) with flexibile ordering
> requirement among them, rank can be utilized there as rank decides now memory
> tiering ordering and not memory tier device ids.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  drivers/base/node.c     |   5 +-
>  drivers/dax/kmem.c      |   2 +-
>  include/linux/migrate.h |  17 ++--
>  mm/migrate.c            | 218 ++++++++++++++++++++++++----------------
>  4 files changed, 144 insertions(+), 98 deletions(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index cf4a58446d8c..892f7c23c94e 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -567,8 +567,11 @@ static ssize_t memtier_show(struct device *dev,
>  			    char *buf)
>  {
>  	int node = dev->id;
> +	int tier_index = node_get_memory_tier_id(node);
>  
> 
> 
> 
> -	return sysfs_emit(buf, "%d\n", node_get_memory_tier(node));
> +	if (tier_index != -1)
> +		return sysfs_emit(buf, "%d\n", tier_index);
> +	return 0;
>  }
>  
> 
> 
> 
>  static ssize_t memtier_store(struct device *dev,
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 991782aa2448..79953426ddaf 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -149,7 +149,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  	dev_set_drvdata(dev, data);
>  
> 
> 
> 
>  #ifdef CONFIG_TIERED_MEMORY
> -	node_set_memory_tier(numa_node, MEMORY_TIER_PMEM);
> +	node_set_memory_tier_rank(numa_node, MEMORY_RANK_PMEM);

I think that we can work with memory tier ID inside kernel?

Best Regards,
Huang, Ying


[snip]

