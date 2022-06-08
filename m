Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4E4542775
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240352AbiFHHEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354198AbiFHGT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:19:26 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83571483D4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 23:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654668412; x=1686204412;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uVvtxf05SKDsySGKn1SFfLh2lQyAvaiLbpKHel9kyOU=;
  b=TM9gFjFc9tekQ9LjZSlulKIGxKcj2GpCEdplyybMJxK8MXfvNTXMnykc
   CxwGeJod+HnaP+uWPc9hiwK8j8FlgRpx1LnxfbGkP8g0Q6cxO5HV4gCkN
   ezdYfuG/oravshYTE4/fwfI9Zr16cRZBIdF1nCoSgZ0nw6WoIvcrJ9TEg
   i+WGDvafnPWxoN5ReMaF9rSe7IXMMUF0rS+zh3mH+uMNoqD99E4k7uOqI
   oKVBA1oFaW8DcnopdD++OnB0LeN+d8g3HPcNXxHdoBDfmlhVCARHZjpiD
   1AUuPC1TYsjB39sxKevde95XtIMYrkCj6F5jddvEm19OfkcopT2wjX8ES
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="338551267"
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="338551267"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 23:06:27 -0700
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="826760381"
Received: from xding11-mobl.ccr.corp.intel.com ([10.254.214.239])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 23:06:22 -0700
Message-ID: <6d72cab6badb003d996eaf5454939e552d2ba67d.camel@intel.com>
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory
 tiers
From:   Ying Huang <ying.huang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
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
Date:   Wed, 08 Jun 2022 14:06:20 +0800
In-Reply-To: <8a42d52c-6275-4798-19c0-dfc530c04b0e@linux.ibm.com>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
         <20220603134237.131362-2-aneesh.kumar@linux.ibm.com>
         <92649c9a6e0b6931b34aeaaf22c0a1e874484b7f.camel@linux.intel.com>
         <8a42d52c-6275-4798-19c0-dfc530c04b0e@linux.ibm.com>
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

On Wed, 2022-06-08 at 10:00 +0530, Aneesh Kumar K V wrote:
> On 6/8/22 12:13 AM, Tim Chen wrote:
> > On Fri, 2022-06-03 at 19:12 +0530, Aneesh Kumar K.V wrote:
> > > 
> > > 
> > > The nodes which are part of a specific memory tier can be listed
> > > via
> > > /sys/devices/system/memtier/memtierN/nodelist
> > > 
> > > "Rank" is an opaque value. Its absolute value doesn't have any
> > > special meaning. But the rank values of different memtiers can be
> > > compared with each other to determine the memory tier order.
> > > 
> > > For example, if we have 3 memtiers: memtier0, memtier1, memiter2, and
> > > their rank values are 300, 200, 100, then the memory tier order is:
> > > memtier0 -> memtier2 -> memtier1,
> > 
> > Why is memtier2 (rank 100) higher than memtier1 (rank 200)?  Seems like
> > the order should be memtier0 -> memtier1 -> memtier2?
> >                      (rank 300)  (rank 200)  (rank 100)
> > 
> > > where memtier0 is the highest tier
> > > and memtier1 is the lowest tier.
> > 
> > I think memtier2 is the lowest as it has the lowest rank value.
> 
> 
> typo error. Will fix that in the next update
> 
> > > 
> > > The rank value of each memtier should be unique.
> > > 
> > > 
> > > +
> > > +static void memory_tier_device_release(struct device *dev)
> > > +{
> > > +	struct memory_tier *tier = to_memory_tier(dev);
> > > +
> > 
> > Do we need some ref counts on memory_tier?
> > If there is another device still using the same memtier,
> > free below could cause problem.
> > 
> > > +	kfree(tier);
> > > +}
> > > +
> > > 
> > ...
> > > +static struct memory_tier *register_memory_tier(unsigned int tier)
> > > +{
> > > +	int error;
> > > +	struct memory_tier *memtier;
> > > +
> > > +	if (tier >= MAX_MEMORY_TIERS)
> > > +		return NULL;
> > > +
> > > +	memtier = kzalloc(sizeof(struct memory_tier), GFP_KERNEL);
> > > +	if (!memtier)
> > > +		return NULL;
> > > +
> > > +	memtier->dev.id = tier;
> > > +	memtier->rank = get_rank_from_tier(tier);
> > > +	memtier->dev.bus = &memory_tier_subsys;
> > > +	memtier->dev.release = memory_tier_device_release;
> > > +	memtier->dev.groups = memory_tier_dev_groups;
> > > +
> > 
> > Should you take the mem_tier_lock before you insert to
> > memtier-list?
> 
> 
> Both register_memory_tier and unregister_memory_tier get called with 
> memory_tier_lock held.

Then please add locking requirements to the comments above these
functions.

Best Regards,
Huang, Ying

> > 
> > > +	insert_memory_tier(memtier);
> > > +
> > > +	error = device_register(&memtier->dev);
> > > +	if (error) {
> > > +		list_del(&memtier->list);
> > > +		put_device(&memtier->dev);
> > > +		return NULL;
> > > +	}
> > > +	return memtier;
> > > +}
> > > +
> > > +__maybe_unused // temporay to prevent warnings during bisects
> > > +static void unregister_memory_tier(struct memory_tier *memtier)
> > > +{
> > 
> > I think we should take mem_tier_lock before modifying memtier->list.
> > 
> 
> unregister_memory_tier get called with memory_tier_lock held.
> 
> > > +	list_del(&memtier->list);
> > > +	device_unregister(&memtier->dev);
> > > +}
> > > +
> > > 
> 
> -aneesh


