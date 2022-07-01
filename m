Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB61A5629DD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 05:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiGAD43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 23:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiGAD41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 23:56:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF8C65D5D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 20:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656647786; x=1688183786;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RpCqpdA60H48DUaJg+JlKNTs3frcvmd++S2H7WWwe6k=;
  b=O1qXhJ5K80U18ZVl4yoereTzR7EdJXtQKAHawTEgXN/ezdAvlpc47hfP
   0F2uXTWfA/dRpc0PdjeUQMmNIIJajaRhpTg1cNgsndxUPcwHZrEYhE5fZ
   9J9e27E5rQNJVs2idP8U1IQKkv7tOFYoD9SxsUs2WEOjg66baMmiFL5/Q
   dsdhe826LJjAB4d/kfBryokl3LrLSNfcq2IlxO9lTbd7e7vwB7QvFyFZr
   J+7AjK6OYXfqBHaH6//kPQlKMyU5xcvY1OghZtmBSi5owATalh6LgtlSf
   3irWBSbBtrtX85qMlkEjX+CS9slsyrRzyVNK8StDhlv3MUx5qOIaisJpM
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="280094871"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="280094871"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 20:56:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="694339877"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.138])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jun 2022 20:56:23 -0700
Date:   Fri, 1 Jul 2022 11:56:22 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH] iommu/iova: change IOVA_MAG_SIZE to 127 to save memory
Message-ID: <20220701035622.GB14806@shbuild999.sh.intel.com>
References: <20220630073304.26945-1-feng.tang@intel.com>
 <13db50bb-57c7-0d54-3857-84b8a4591d9e@arm.com>
 <7c29d01d-d90c-58d3-a6e0-0b6c404173ac@huawei.com>
 <117b31b5-8d06-0af4-7f1c-231d86becf1d@arm.com>
 <2920df89-9975-5785-f79b-257d3052dfaf@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2920df89-9975-5785-f79b-257d3052dfaf@huawei.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Thu, Jun 30, 2022 at 11:52:18AM +0100, John Garry wrote:
> > > > 
> > > > >    [    4.319253] iommu: Adding device 0000:06:00.2 to group 5
> > > > >    [    4.325869] iommu: Adding device 0000:20:01.0 to group 15
> > > > >    [    4.332648] iommu: Adding device 0000:20:02.0 to group 16
> > > > >    [    4.338946] swapper/0 invoked oom-killer:
> > > > > gfp_mask=0x6040c0(GFP_KERNEL|__GFP_COMP), nodemask=(null),
> > > > > order=0, oom_score_adj=0
> > > > >    [    4.350251] swapper/0 cpuset=/ mems_allowed=0
> > > > >    [    4.354618] CPU: 0 PID: 1 Comm: swapper/0 Not
> > > > > tainted 4.19.57.mx64.282 #1
> > > > >    [    4.355612] Hardware name: Dell Inc. PowerEdge
> > > > > R7425/08V001, BIOS 1.9.3 06/25/2019
> > > > >    [    4.355612] Call Trace:
> > > > >    [    4.355612]  dump_stack+0x46/0x5b
> > > > >    [    4.355612]  dump_header+0x6b/0x289
> > > > >    [    4.355612]  out_of_memory+0x470/0x4c0
> > > > >    [    4.355612]  __alloc_pages_nodemask+0x970/0x1030
> > > > >    [    4.355612]  cache_grow_begin+0x7d/0x520
> > > > >    [    4.355612]  fallback_alloc+0x148/0x200
> > > > >    [    4.355612]  kmem_cache_alloc_trace+0xac/0x1f0
> > > > >    [    4.355612]  init_iova_domain+0x112/0x170
> 
> Note for Feng Tang: This callchain does not exist anymore since we separated
> out the rcache init from the IOVA domain init. Indeed, not so much memory is
> wasted for unused rcaches now.
 
Thanks for the info, I also planned to remove the callstack as Robin suggested.  

> My point really is that it would be nicer to see a modern callchain - but
> don't read that as me saying that the change is this patch is bad.
> 
> > > > >    [    4.355612]  amd_iommu_domain_alloc+0x138/0x1a0
> > > > >    [    4.355612]  iommu_group_get_for_dev+0xc4/0x1a0
> > > > >    [    4.355612]  amd_iommu_add_device+0x13a/0x610
> > > > >    [    4.355612]  add_iommu_group+0x20/0x30
> > > > >    [    4.355612]  bus_for_each_dev+0x76/0xc0
> > > > >    [    4.355612]  bus_set_iommu+0xb6/0xf0
> > > > >    [    4.355612]  amd_iommu_init_api+0x112/0x132
> > > > >    [    4.355612]  state_next+0xfb1/0x1165
> > > > >    [    4.355612]  amd_iommu_init+0x1f/0x67
> > > > >    [    4.355612]  pci_iommu_init+0x16/0x3f
> > > > >    ...
> > > > >    [    4.670295] Unreclaimable slab info:
> > > > >    ...
> > > > >    [    4.857565] kmalloc-2048           59164KB      59164KB
> > > > > 
> > > > > Change IOVA_MAG_SIZE from 128 to 127 to make size of 'iova_magazine'
> > > > > 1024 bytes so that no memory will be wasted.
> > > > > 
> > > > > [1]. https://lkml.org/lkml/2019/8/12/266
> > > > > 
> > > > > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > > > > ---
> > > > >   drivers/iommu/iova.c | 7 ++++++-
> > > > >   1 file changed, 6 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> > > > > index db77aa675145b..27634ddd9b904 100644
> > > > > --- a/drivers/iommu/iova.c
> > > > > +++ b/drivers/iommu/iova.c
> > > > > @@ -614,7 +614,12 @@ EXPORT_SYMBOL_GPL(reserve_iova);
> > > > >    * dynamic size tuning described in the paper.
> > > > >    */
> > > > > -#define IOVA_MAG_SIZE 128
> > > > > +/*
> > > > > + * As kmalloc's buffer size is fixed to power of 2, 127 is chosen to
> > > > > + * assure size of 'iova_magzine' to be 1024 bytes, so that no memory
> > > > 
> > > > Typo: iova_magazine
> > > > 
> > > > > + * will be wasted.
> > > > > + */
> > > > > +#define IOVA_MAG_SIZE 127
> > > 
> > > I do wonder if we will see some strange new behaviour since
> > > IOVA_FQ_SIZE % IOVA_MAG_SIZE != 0 now...
> > 
> > I doubt it - even if a flush queue does happen to be entirely full of
> > equal-sized IOVAs, a CPU's loaded magazines also both being perfectly
> > empty when it comes to dump a full fq seem further unlikely, so in
> > practice I don't see this making any appreciable change to the
> > likelihood of spilling back to the depot or not. In fact the smaller the
> > magazines get, the less time would be spent flushing the depot back to
> > the rbtree, where your interesting workload falls off the cliff and> > never catches back up with the fq timer, so at some point it might even
> > improve (unless it's also already close to the point where smaller
> > caches would bottleneck allocation)... might be interesting to
> > experiment with a wider range of magazine sizes if you had the time and
> > inclination.
> > 
> 
> ok, what you are saying sounds reasonable. I just remember that when we
> analyzed the longterm aging issue that we concluded that the FQ size and its
> relation to the magazine size was a factor and this change makes me a little
> worried about new issues. Better the devil you know and all that...
> 
> Anyway, if I get some time I might do some testing to see if this change has
> any influence.
> 
> Another thought is if we need even store the size in the iova_magazine? mags
> in the depot are always full. As such, we only need worry about mags loaded
> in the cpu rcache and their sizes, so maybe we could have something like
> this:
> 
> struct iova_magazine {
> -       unsigned long size;
>        unsigned long pfns[IOVA_MAG_SIZE];
> };
> 
> @@ -631,6 +630,8 @@ struct iova_cpu_rcache {
>        spinlock_t lock;
>        struct iova_magazine *loaded;
>        struct iova_magazine *prev;
> +       int loaded_size;
> +       int prev_size;
> };
> 
> I haven't tried to implement it though..

I have very few knowledge of iova, so you can chose what's the better
solution. I just wanted to raise the problem and will be happy to see
it solved :)

Thanks,
Feng

> Thanks,
> John
