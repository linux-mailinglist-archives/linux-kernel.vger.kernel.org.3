Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07A14DC245
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbiCQJEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiCQJEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:04:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85ABFD9E9A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 02:03:33 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0806921116;
        Thu, 17 Mar 2022 09:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647507812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WtgvzimuVIwgiBIv2UaJd9O6/UC+hQ6MdPo+P2U41Yo=;
        b=cXBMxsAwriXK5Kegx30gvaXQ/UuClgNLX/CMD/xM8+hE7Sp753sBw0S1u7/ql6SLXdXqz/
        odf5dA+MBqNrpeWN2tAvYQvClXfn8LMWwN1emdDYzx0fE8Nk0rx9Ld7EY+UG0uPYCLkWzE
        Zy/5/mOzLg4sZesKFAZjT6qXckv/aLQ=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C7BB7A3B9E;
        Thu, 17 Mar 2022 09:03:31 +0000 (UTC)
Date:   Thu, 17 Mar 2022 10:03:31 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, kosaki.motohiro@jp.fujitsu.com,
        mgorman@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mempolicy: fix potential mpol_new leak in
 shared_policy_replace
Message-ID: <YjL5Y6ZrZ2eLnnTv@dhcp22.suse.cz>
References: <20220311093624.39546-1-linmiaohe@huawei.com>
 <Yi9w7TCYbj+OLGXJ@dhcp22.suse.cz>
 <26577566-ae1e-801c-8c64-89c2c89a487d@huawei.com>
 <YjCwYpTbGzAj9kmg@dhcp22.suse.cz>
 <24b2a9ef-eea0-09bd-6842-121d8436e56a@huawei.com>
 <YjG0PsF25wpAEOY3@dhcp22.suse.cz>
 <6ebebfd6-6356-e956-4fbc-0abaa58308ff@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ebebfd6-6356-e956-4fbc-0abaa58308ff@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17-03-22 10:05:08, Miaohe Lin wrote:
> On 2022/3/16 17:56, Michal Hocko wrote:
> > On Wed 16-03-22 14:39:37, Miaohe Lin wrote:
> >> On 2022/3/15 23:27, Michal Hocko wrote:
> >>> On Tue 15-03-22 21:42:29, Miaohe Lin wrote:
> >>>> On 2022/3/15 0:44, Michal Hocko wrote:
> >>>>> On Fri 11-03-22 17:36:24, Miaohe Lin wrote:
> >>>>>> If mpol_new is allocated but not used in restart loop, mpol_new will be
> >>>>>> freed via mpol_put before returning to the caller. But refcnt is not
> >>>>>> initialized yet, so mpol_put could not do the right things and might
> >>>>>> leak the unused mpol_new.
> >>>>>
> >>>>> The code is really hideous but is there really any bug there? AFAICS the
> >>>>> new policy is only allocated in if (n->end > end) branch and that one
> >>>>> will set the reference count on the retry. Or am I missing something?
> >>>>>
> >>>>
> >>>> Many thanks for your comment.
> >>>> IIUC, new policy is allocated via the below code:
> >>>>
> >>>> shared_policy_replace:
> >>>> 	alloc_new:
> >>>> 		write_unlock(&sp->lock);
> >>>> 		ret = -ENOMEM;
> >>>> 		n_new = kmem_cache_alloc(sn_cache, GFP_KERNEL);
> >>>> 		if (!n_new)
> >>>> 			goto err_out;
> >>>> 		mpol_new = kmem_cache_alloc(policy_cache, GFP_KERNEL);
> >>>> 		if (!mpol_new)
> >>>> 			goto err_out;
> >>>> 		goto restart;
> >>>>
> >>>> And mpol_new' reference count will be set before used in n->end > end case. But
> >>>> if that is "not" the case, i.e. mpol_new is not inserted into the rb_tree, mpol_new
> >>>> will be freed via mpol_put before return:
> >>>
> >>> One thing I have missed previously is that the lock is dropped during
> >>> the allocation so I guess the memory policy could have been changed
> >>> during that time. Is this possible? Have you explored this possibility?
> >>> Is this a theoretical problem or it can be triggered intentionally.
> >>>
> >>
> >> This is found via code investigation. I think this could be triggered if there
> >> are many concurrent mpol_set_shared_policy in place. But the user-visible effect
> >> might be obscure as only sizeof(struct mempolicy) bytes leaks possiblely every time.
> >>
> >>> These details would be really interesting for the changelog so that we
> >>> can judge how important this would be.
> >>
> >> This might not be that important as this issue should have been well-concealed for
> >> almost ten years (since commit 42288fe366c4 ("mm: mempolicy: Convert shared_policy mutex to spinlock")).
> > 
> > I think it is really worth to drill down to the bottom of the issue.
> > While theoretically possible can be a good enough to justify the change
> > it is usually preferred to describe the underlying problem for future
> > maintainability. 
> 
> This issue mainly causes mpol_new memory leaks and this is pointed out in the commit log.
> Am I supposed to do something more to move forward this patch ? Could you point that out
> for me?

Sorry if I was not really clear. My main request is to have a clear
insight whether this is a theretical issue or the leak could be really
triggered. If the later we need to mark it properly and backport to
older kernels because memory leaks can lead to DoS when they are
reasonably easy to trigger.

Is this more clear now?
-- 
Michal Hocko
SUSE Labs
