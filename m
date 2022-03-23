Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792D64E56ED
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 17:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245581AbiCWQvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 12:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238981AbiCWQvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:51:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4830223BD2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 09:49:46 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D8357210F3;
        Wed, 23 Mar 2022 16:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648054184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=22ADZAB+7skaLqBInlr+u4wR7AIA/10MMMrUH4hmyqg=;
        b=oKhk9Cql8RB3t1jmsW+Oo6vEsnO+LnEOjuudGFTJor/ASf/X8Ihk/o+8wwpS8uMQCu7yxZ
        YQw7MdBmjvSrKzYUACYG6MUo+a6Ak5ms/lBErRmswrGe8YofSONokaQRp61jZduv08dp/7
        QffTCYzlW9hgB5JS8ZHwtKkWEGMuVQU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8B1A4A3B87;
        Wed, 23 Mar 2022 16:49:44 +0000 (UTC)
Date:   Wed, 23 Mar 2022 17:49:43 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Juergen Gross <jgross@suse.com>, linux-mm@kvack.org,
        lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Jerome Glisse <jglisse@redhat.com>
Subject: Re: blocking vs. non-blocking mmu notifiers
Message-ID: <YjtPpxlE/zWwnJ0W@dhcp22.suse.cz>
References: <8e8ec786-74db-157b-a290-b1537941e91d@suse.com>
 <YjrsOnxaPYc3rbdj@dhcp22.suse.cz>
 <20220323163146.GI64706@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323163146.GI64706@ziepe.ca>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-03-22 13:31:46, Jason Gunthorpe wrote:
> On Wed, Mar 23, 2022 at 10:45:30AM +0100, Michal Hocko wrote:
> > [Let me add more people to the CC list - I am not really sure who is the
> >  most familiar with all the tricks that mmu notifiers might do]
> > 
> > On Wed 23-03-22 09:43:59, Juergen Gross wrote:
> > > Hi,
> > > 
> > > during analysis of a customer's problem on a 4.12 based kernel
> > > (deadlock due to a blocking mmu notifier in a Xen driver) I came
> > > across upstream patches 93065ac753e4 ("mm, oom: distinguish
> > > blockable mode for mmu notifiers") et al.
> > > 
> > > The backtrace of the blocked tasks was typically something like:
> > > 
> > >  #0 [ffffc9004222f228] __schedule at ffffffff817223e2
> > >  #1 [ffffc9004222f2b8] schedule at ffffffff81722a02
> > >  #2 [ffffc9004222f2c8] schedule_preempt_disabled at ffffffff81722d0a
> > >  #3 [ffffc9004222f2d0] __mutex_lock at ffffffff81724104
> > >  #4 [ffffc9004222f360] mn_invl_range_start at ffffffffc01fd398 [xen_gntdev]
> > >  #5 [ffffc9004222f398] __mmu_notifier_invalidate_page at ffffffff8123375a
> > >  #6 [ffffc9004222f3c0] try_to_unmap_one at ffffffff812112cb
> > >  #7 [ffffc9004222f478] rmap_walk_file at ffffffff812105cd
> > >  #8 [ffffc9004222f4d0] try_to_unmap at ffffffff81212450
> > >  #9 [ffffc9004222f508] shrink_page_list at ffffffff811e0755
> > > #10 [ffffc9004222f5c8] shrink_inactive_list at ffffffff811e13cf
> > > #11 [ffffc9004222f6a8] shrink_node_memcg at ffffffff811e241f
> > > #12 [ffffc9004222f790] shrink_node at ffffffff811e29c5
> > > #13 [ffffc9004222f808] do_try_to_free_pages at ffffffff811e2ee1
> > > #14 [ffffc9004222f868] try_to_free_pages at ffffffff811e3248
> > > #15 [ffffc9004222f8e8] __alloc_pages_slowpath at ffffffff81262c37
> > > #16 [ffffc9004222f9f0] __alloc_pages_nodemask at ffffffff8121afc1
> > > #17 [ffffc9004222fa48] alloc_pages_current at ffffffff8122f350
> > > #18 [ffffc9004222fa78] __get_free_pages at ffffffff8121685a
> > > #19 [ffffc9004222fa80] __pollwait at ffffffff8127e795
> > > #20 [ffffc9004222faa8] evtchn_poll at ffffffffc00e802b [xen_evtchn]
> > > #21 [ffffc9004222fab8] do_sys_poll at ffffffff8127f953
> > > #22 [ffffc9004222fec8] sys_ppoll at ffffffff81280478
> > > #23 [ffffc9004222ff30] do_syscall_64 at ffffffff81004954
> > > #24 [ffffc9004222ff50] entry_SYSCALL_64_after_hwframe at ffffffff818000b6
> > > 
> > > It was found that the notifier of the Xen gntdev driver was using a
> > > mutex resulting in the deadlock.
> 
> The bug here is that prior to commit a81461b0546c ("xen/gntdev: update
> to new mmu_notifier semantic") wired the mn_invl_range_start() which
> takes a mutex to invalidate_page, which is defined to run in an atomic
> context.

Yeah, we have already identified that but quickly realized that the
whole mmu notifier overhaul which this fix depends on would be no no for
backporting to our older code base. So we are trying to find our way
around that.

> > > Michal Hocko suggested that backporting above mentioned patch might
> > > help, as the mmu notifier call is happening in atomic context.
> 
> IIRC "blocking" was not supposed to be about atomic context or not, but
> more about time to completion/guarenteed completion as it is used from
> a memory reclaim path.

Yeah, when I was introducing that I was mostly concerned about oom path.
But it is essentially impossible to tell what are the existing
assumptions different mmu notifiers operate on.

> 
> > Just to be more explicit. The current upstream code calls
> > mmu_notifier_invalidate_range while the page table locks are held.
> > Are there any notifiers which could sleep in those? 
> 
> There should not be, that would be a bug that lockdep would find.

OK, this is reassuring. Thanks!
-- 
Michal Hocko
SUSE Labs
