Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7FA4DD97E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 13:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbiCRMRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 08:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236102AbiCRMRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 08:17:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0BDF1EBE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 05:15:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD6416185C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 12:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A57C340E8;
        Fri, 18 Mar 2022 12:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647605747;
        bh=apeeG6WHRgatQTif+1EPcuy7+7eZkIEix8HhadU5MZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=bGScCB0Xn69LYU84wjG6fNIR0WKtN3pDC/uAs8BxGSt85dKp+W/t+Nkuq6vZYY426
         OE8DzopDzg5ogmjolQrR4JAXnHOHe3DsBwLhoJteKuFmE5LdcHD74W6+O04vfvtiA8
         teeWJJyD1q1s3a7esrs/Q4XPvtCivFsqj4Gda6RNqriKtkrd86/0q6B1P77E2waQFb
         5x3c42ObpRFegAKi8UKolYmT/wvskMpv69bVBe1dZc3zhID3sf5QV3M72q0cwVmkdm
         wD0NC/FHfk9FztZ4q4PvDR8KJJQduo8KertujFzAOzNijAGiGT9ehtw/6rVjNhw2I8
         i3LXuf6VVzknw==
From:   sj@kernel.org
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: Make the sampling more accurate
Date:   Fri, 18 Mar 2022 12:15:43 +0000
Message-Id: <20220318121543.26861-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <6cb97421-ab4a-2520-2503-10fec548edd0@linux.alibaba.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2022 19:58:07 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> 
> 
> On 3/18/2022 6:49 PM, sj@kernel.org wrote:
> > On Fri, 18 Mar 2022 18:01:19 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> > 
> >>
> >> On 3/18/2022 5:40 PM, sj@kernel.org wrote:
> >>> Hi Baolin,
> >>>
> >>> On Fri, 18 Mar 2022 17:23:13 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> >>>
> >>>> When I try to sample the physical address with DAMON to migrate pages
> >>>> on tiered memory system, I found it will demote some cold regions mistakenly.
> >>>> Now we will choose an physical address in the region randomly, but if
> >>>> its corresponding page is not an online LRU page, we will ignore the
> >>>> accessing status in this cycle of sampling, and actually will be treated
> >>>> as a non-accessed region. Suppose a region including some non-LRU pages,
> >>>> it will be treated as a cold region with a high probability, and may be
> >>>> merged with adjacent cold regions, but there are some pages may be
> >>>> accessed we missed.
> >>>>
> >>>> So instead of ignoring the access status of this region if we did not find
> >>>> a valid page according to current sampling address, we can use last valid
> >>>> sampling address to help to make the sampling more accurate, then we can do
> >>>> a better decision.
> >>>
> >>> Well...  Offlined pages are also a valid part of the memory region, so treating
> >>> those as not accessed and making the memory region containing the offlined
> >>> pages looks colder seems legal to me.  IOW, this approach could make memory
> >>> regions containing many non-online-LRU pages as hot.
> >>
> >> IMO I don't think this is a problem, since if this region containing
> >> many non-online-LRU pages is treated as hot, which means threre are aome
> >> pages are hot, right? We can find them and promote them to fast memory
> >> (or do other schemes). Meanwhile, for non-online-LRU pages, we can
> >> filter them and do nothing for them, since we can not get a valid page
> >> struct for them.
> > 
> > For some of DAMOS actions that you mentioned, that could make sense.  However,
> > that wouldn't make much sense for some other cases, especially for manual
> > DAMON-based access pattern profiling.
> 
> I am not sure about this case, could you elaborate on how this can worse 
> the case you mentioned?

For an example, let's suppose a user using DAMON to know the working set size
of the system.  And further suppose there is a region that containing many
offlined pages and one online hot page.  With this patch, once DAMON sampled
the one hot page, the entire region will be reported as hot, though the other
offlined pages has not accessed.  As a result, the user will think the working
set size is bigger than real.

> 
> Like you said as below, we can split the regions to separate the hot 
> pages out of the hot regions containing some offline or non-lru pages, 
> that is also a benefit to improve the regions adjustment.
> 
> > After all, we already have a mechanism for this case: adaptive regions
> > adjustment (or, regions split/merge).  That mechanism will eventually separate
> > out hot oneline-LRU pages in the memory regions.  Before the region is
> > adjusted, reporting the whole region as hot looks like a right result to me.
> > Of course, I admit that it could take too much time to converge to the optimal
> > regions, and there are many rooms for improvement of the regions adjustment
> > mechanism.  I think we should pursue the direction (improving the regions
> > adjustment mechanism).
> 
> Yes, agree.
> 
> > FYI, I have some rough ideas for improving the mechanism including partitioning
> > regions into more than 2 sub-regions if we belive it is not making a good
> > progress.  Nevertheless, I'd like to first make a methodology for evaluating
> > current accuracy.  For that, I am planning to implement a page-granularity
> > access monitoring.
> 
> Great, I think the page-granularity monitoring will be more suitable for 
> tiered memory system, which can reduce redundant demotion and promotion. 
> However, I still concern the overhead if the monitoring is a 
> page-granularity, especially for a large memory size.

Sure.  It's main purpose for now is only to be compared with DAMON for
evaluating DAMON's accuracy.  Someone who has small-enough memory size of
huge-enough CPU resource could use that for their product, of course.

> Anyway, I'd like to help to test or review the new page-granularity
> monitoring when you're ready to send out. Thanks.

So glad to hear that and appreciate always for your help!


Thanks,
SJ
