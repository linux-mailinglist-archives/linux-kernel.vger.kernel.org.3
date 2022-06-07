Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B357541B49
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 23:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381840AbiFGVpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 17:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378864AbiFGUwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 16:52:38 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9AE2E696
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654627395; x=1686163395;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A/5BMYgNu0Yt+eZ+D/1xw5NF6LjHXm/NfMiYDFkov/E=;
  b=fz8aDaP64ANsWlhebzZNz0ydhV/mOiheQKp4ixSKXUo8Ty1p2rB2sEvs
   mEgZHmwrT9EVtjosLpMIr+UC64Ws44c99hVJDACbCfYMtCP6/BgO48ofr
   DT9idM/1VgsdFTIVqn6li9gwxU6X4Pk/9Upu6aCDFldzvks8+Db2gob8Q
   +i0Hwjo2mDJgMm8UsKADQpvgt1du16bRjx9X5vspJBmN14lcrTwhgxmfs
   mBQ0nm7GXBhMf33ETn3mVJGJJrIORpbDIv9a2DLYWr5Hq1kFESHgLo/CH
   vXWpFSQdpCU4/DGMFwrTvQEqgOiBK5L30bp6mLq5bsGYZNmuDurOfX8nu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="257178716"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="257178716"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 11:43:06 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="579716176"
Received: from schen9-mobl.amr.corp.intel.com ([10.251.8.166])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 11:43:05 -0700
Message-ID: <92649c9a6e0b6931b34aeaaf22c0a1e874484b7f.camel@linux.intel.com>
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory
 tiers
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
Date:   Tue, 07 Jun 2022 11:43:05 -0700
In-Reply-To: <20220603134237.131362-2-aneesh.kumar@linux.ibm.com>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
         <20220603134237.131362-2-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-06-03 at 19:12 +0530, Aneesh Kumar K.V wrote:
> 
> 
> The nodes which are part of a specific memory tier can be listed
> via
> /sys/devices/system/memtier/memtierN/nodelist
> 
> "Rank" is an opaque value. Its absolute value doesn't have any
> special meaning. But the rank values of different memtiers can be
> compared with each other to determine the memory tier order.
> 
> For example, if we have 3 memtiers: memtier0, memtier1, memiter2, and
> their rank values are 300, 200, 100, then the memory tier order is:
> memtier0 -> memtier2 -> memtier1, 

Why is memtier2 (rank 100) higher than memtier1 (rank 200)?  Seems like
the order should be memtier0 -> memtier1 -> memtier2?
                    (rank 300)  (rank 200)  (rank 100)

> where memtier0 is the highest tier
> and memtier1 is the lowest tier.

I think memtier2 is the lowest as it has the lowest rank value.
> 
> The rank value of each memtier should be unique.
> 
> 
> +
> +static void memory_tier_device_release(struct device *dev)
> +{
> +	struct memory_tier *tier = to_memory_tier(dev);
> +

Do we need some ref counts on memory_tier?
If there is another device still using the same memtier,
free below could cause problem.

> +	kfree(tier);
> +}
> +
> 
...
> +static struct memory_tier *register_memory_tier(unsigned int tier)
> +{
> +	int error;
> +	struct memory_tier *memtier;
> +
> +	if (tier >= MAX_MEMORY_TIERS)
> +		return NULL;
> +
> +	memtier = kzalloc(sizeof(struct memory_tier), GFP_KERNEL);
> +	if (!memtier)
> +		return NULL;
> +
> +	memtier->dev.id = tier;
> +	memtier->rank = get_rank_from_tier(tier);
> +	memtier->dev.bus = &memory_tier_subsys;
> +	memtier->dev.release = memory_tier_device_release;
> +	memtier->dev.groups = memory_tier_dev_groups;
> +

Should you take the mem_tier_lock before you insert to
memtier-list?

> +	insert_memory_tier(memtier);
> +
> +	error = device_register(&memtier->dev);
> +	if (error) {
> +		list_del(&memtier->list);
> +		put_device(&memtier->dev);
> +		return NULL;
> +	}
> +	return memtier;
> +}
> +
> +__maybe_unused // temporay to prevent warnings during bisects
> +static void unregister_memory_tier(struct memory_tier *memtier)
> +{

I think we should take mem_tier_lock before modifying memtier->list.

> +	list_del(&memtier->list);
> +	device_unregister(&memtier->dev);
> +}
> +
> 

Thanks.

Tim

