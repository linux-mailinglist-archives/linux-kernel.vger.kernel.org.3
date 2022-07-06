Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F172C56880D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbiGFMMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbiGFMME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:12:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0032A721
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 05:11:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05B9C61F8C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 12:11:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376C8C341C0;
        Wed,  6 Jul 2022 12:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657109512;
        bh=SeP+pP9PIpzAPPpJhtZkpan835Qsg2jX4rok4kM3sRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lwCf+b5YlgzovcNzoC+4ZeUraeGLv/Sw51y8rFKv9x+kKwiJzJeQm3AGRaDNAfIQv
         OZkf3j+7FfcaTNwmuL58WhUHcLKLnhHBMsSHzmBC3+YsWeK9tZefF3y26C151bH7Qd
         U9svzLMEdPsnlalg7nkHuu2oQnIZRgC1UixyybKFENWTDazFKxTMX5+Q8OqQn1RzdP
         FO2fT6zuwhcTs16IMELy73gL8TPupxG45MRzCuJtz6XWXI4kESHjGGg5dTH709IqA9
         F/QNjICHhh25JoTHiOa8f1KbF4TMtTetdpOhxYgARTqjEAvdUYoTDOT5qVQVipf8fS
         sjAEvTC+KzK7A==
Date:   Wed, 6 Jul 2022 13:11:44 +0100
From:   Will Deacon <will@kernel.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        robin.murphy@arm.com, mst@redhat.com, jasowang@redhat.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        chenxiang66@hisilicon.com, jean-philippe@linaro.org,
        linuxarm@huawei.com
Subject: Re: [PATCH RESEND v5 2/5] iova: Allow rcache range upper limit to be
 flexible
Message-ID: <20220706121144.GG2403@willie-the-truck>
References: <1649071634-188535-1-git-send-email-john.garry@huawei.com>
 <1649071634-188535-3-git-send-email-john.garry@huawei.com>
 <834447a0-675a-5978-8ffe-285ce09f4213@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <834447a0-675a-5978-8ffe-285ce09f4213@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 03:52:53PM +0800, Leizhen (ThunderTown) wrote:
> On 2022/4/4 19:27, John Garry wrote:
> > Some low-level drivers may request DMA mappings whose IOVA length exceeds
> > that of the current rcache upper limit.
> > 
> > This means that allocations for those IOVAs will never be cached, and
> > always must be allocated and freed from the RB tree per DMA mapping cycle.
> > This has a significant effect on performance, more so since commit
> > 4e89dce72521 ("iommu/iova: Retry from last rb tree node if iova search
> > fails"), as discussed at [0].
> > 
> > As a first step towards allowing the rcache range upper limit be
> > configured, hold this value in the IOVA rcache structure, and allocate
> > the rcaches separately.
> > 
> > Delete macro IOVA_RANGE_CACHE_MAX_SIZE in case it's reused by mistake.
> > 
> > [0] https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/
> > 
> > Signed-off-by: John Garry <john.garry@huawei.com>
> > ---
> >  drivers/iommu/iova.c | 20 ++++++++++----------
> >  include/linux/iova.h |  3 +++
> >  2 files changed, 13 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> > index db77aa675145..5c22b9187b79 100644
> > --- a/drivers/iommu/iova.c
> > +++ b/drivers/iommu/iova.c
> > @@ -15,8 +15,6 @@
> >  /* The anchor node sits above the top of the usable address space */
> >  #define IOVA_ANCHOR	~0UL
> >  
> > -#define IOVA_RANGE_CACHE_MAX_SIZE 6	/* log of max cached IOVA range size (in pages) */
> > -
> >  static bool iova_rcache_insert(struct iova_domain *iovad,
> >  			       unsigned long pfn,
> >  			       unsigned long size);
> > @@ -443,7 +441,7 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
> >  	 * rounding up anything cacheable to make sure that can't happen. The
> >  	 * order of the unadjusted size will still match upon freeing.
> >  	 */
> > -	if (size < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
> > +	if (size < (1 << (iovad->rcache_max_size - 1)))
> >  		size = roundup_pow_of_two(size);
> >  
> >  	iova_pfn = iova_rcache_get(iovad, size, limit_pfn + 1);
> > @@ -713,13 +711,15 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
> >  	unsigned int cpu;
> >  	int i, ret;
> >  
> > -	iovad->rcaches = kcalloc(IOVA_RANGE_CACHE_MAX_SIZE,
> > +	iovad->rcache_max_size = 6; /* Arbitrarily high default */
> 
> It would be better to assign this constant value to iovad->rcache_max_size
> in init_iova_domain().

I think it's fine where it is as it's a meaningless number outside of the
rcache code.

Will
