Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4222C4EA269
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 23:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiC1V2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 17:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiC1V23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 17:28:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4B913DB7B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 14:26:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D54D6CE13BA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 21:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD87C340F0;
        Mon, 28 Mar 2022 21:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1648502790;
        bh=wxoq9ME/nIVvmUovBMwsQE6E8oPpAYoAac/ZEw8Fya0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yf2w62tXhWPSCdrwhr8ccax+GVrf2ywD2KQk2KtH9HUhQmdXMDPoZJ5V4UvoTySq2
         udT2dg8Ev7lBimxMk1Yq0bG3gGeCJIEKACvs4H2DV+ytQ3vhyr2qVP3V3iBJMJqaSl
         UGQFD1P1IKswDwMgGsYlOLpcmpYHzqAkQk+kHK+Y=
Date:   Mon, 28 Mar 2022 14:26:29 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <mhocko@suse.com>, <kosaki.motohiro@jp.fujitsu.com>,
        <mgorman@suse.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mm/mempolicy: fix mpol_new leak in
 shared_policy_replace
Message-Id: <20220328142629.6ab7c5312d9ec154ccc502b2@linux-foundation.org>
In-Reply-To: <c8625168-4a40-1f6c-47b1-2c9194d3d4b3@huawei.com>
References: <20220322104345.36379-1-linmiaohe@huawei.com>
        <20220325172907.57dd381b746563be5dc77097@linux-foundation.org>
        <c8625168-4a40-1f6c-47b1-2c9194d3d4b3@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Mar 2022 14:46:28 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> On 2022/3/26 8:29, Andrew Morton wrote:
> > On Tue, 22 Mar 2022 18:43:45 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> > 
> >> If mpol_new is allocated but not used in restart loop, mpol_new will be
> >> freed via mpol_put before returning to the caller.  But refcnt is not
> >> initialized yet, so mpol_put could not do the right things and might leak
> >> the unused mpol_new. This would happen if mempolicy was updated on the
> >> shared shmem file while the sp->lock has been dropped during the memory
> >> allocation.
> >>
> >> This issue could be triggered easily with the below code snippet if there
> >> are many processes doing the below work at the same time:
> >>
> >>   shmid = shmget((key_t)5566, 1024 * PAGE_SIZE, 0666|IPC_CREAT);
> >>   shm = shmat(shmid, 0, 0);
> >>   loop many times {
> >>     mbind(shm, 1024 * PAGE_SIZE, MPOL_LOCAL, mask, maxnode, 0);
> >>     mbind(shm + 128 * PAGE_SIZE, 128 * PAGE_SIZE, MPOL_DEFAULT, mask,
> >>           maxnode, 0);
> >>   }
> >>
> >> ...
> >>
> >> --- a/mm/mempolicy.c
> >> +++ b/mm/mempolicy.c
> >> @@ -2733,6 +2733,7 @@ static int shared_policy_replace(struct shared_policy *sp, unsigned long start,
> >>  	mpol_new = kmem_cache_alloc(policy_cache, GFP_KERNEL);
> >>  	if (!mpol_new)
> >>  		goto err_out;
> >> +	refcount_set(&mpol_new->refcnt, 1);
> >>  	goto restart;
> >>  }
> > 
> > Two other sites in this file do
> > 
> > 	atomic_set(&policy->refcnt, 1);
> > 
> > 
> > Could we please instead have a little helper function which does the
> > kmem_cache_alloc()+refcount_set()?> .
> 
> There are usecases like below:
> 
> 	struct mempolicy *new = kmem_cache_alloc(policy_cache, GFP_KERNEL);
> 	*new = *old;
> 	^^^^^^^^^^^^
> 	refcount_set(&new->refcnt, 1);
> 
> If we use helper function to do kmem_cache_alloc()+refcount_set() above, separate
> refcount_set(&new->refcnt, 1) is still needed as old is copied to new and overwrites
> the refcnt field. So that little helper function might not work. Or am I miss something?
> 

Hm, spose so.  I guess the helper doesn't add much in that case.

Can we please redo this on mainline?  I'm not happy with the bloat
which refcnt_t adds and I think I'll drop
mm-mempolicy-convert-from-atomic_t-to-refcount_t-on-mempolicy-refcnt.patch.
