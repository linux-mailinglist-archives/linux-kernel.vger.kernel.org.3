Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412754CB81B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 08:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiCCHtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 02:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiCCHtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:49:20 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FB6674E3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 23:48:34 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 775E41F381;
        Thu,  3 Mar 2022 07:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646293713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+M2pNqHE/aOs6jr/fL87EioeI0y3A/KHNWJGqCoCUD8=;
        b=pX+XjyCUfQW5kB4qA25NsEQDvzQRSLFFlTDKAMkS2yp5RD1QYBkWrAO9n405sJviTesbKt
        urQ6rNtrV+G5cx/YpV2s2wJXtl7BsXEc6C6O/lYvfQ5w7mtLPmLEFgDG+TqDaaWqYKOoot
        HC20m7D9tEX9lf8VVr+f4m/H+Huc6L8=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4B0E2A3B81;
        Thu,  3 Mar 2022 07:48:28 +0000 (UTC)
Date:   Thu, 3 Mar 2022 08:48:32 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Nico Pache <npache@redhat.com>
Cc:     Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        jsavitz@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@collabora.com
Subject: Re: [PATCH v3] mm/oom: do not oom reap task with an unresolved
 robust futex
Message-ID: <YiBy0MXkefqfFvKk@dhcp22.suse.cz>
References: <20220114180135.83308-1-npache@redhat.com>
 <YeUuWcNArnDhOjFY@dhcp22.suse.cz>
 <ad639326-bea8-9bfb-23e3-4e2b216d9645@redhat.com>
 <43a6c470-9fc2-6195-9a25-5321d17540e5@redhat.com>
 <YeZ/mL808DpA8mdG@dhcp22.suse.cz>
 <118fc685-c68d-614f-006a-7d5487302122@redhat.com>
 <Yh9+O/xqNLnV1jmA@dhcp22.suse.cz>
 <7f1ba14f-34e8-5f05-53b7-c12913693df8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f1ba14f-34e8-5f05-53b7-c12913693df8@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02-03-22 12:26:45, Nico Pache wrote:
> 
> 
> On 3/2/22 09:24, Michal Hocko wrote:
> > Sorry, this has slipped through cracks.
> > 
> > On Mon 14-02-22 15:39:31, Nico Pache wrote:
> > [...]
> >> We've recently been discussing the following if statement in __oom_reap_task_mm:
> >> 	if (vma_is_anonymous(vma) || !(vma->vm_flags & VM_SHARED))
> >>
> >> Given the comment above it, and some of the upstream discussion the original
> >> RFC, we are struggling to see why this should be a `||` and not an `&&`. If we
> >> only want to reap anon memory and reaping shared memory can be dangerous is this
> >> statement incorrect?
> >>
> >> We have a patch queued up to make this change, but wanted to get your opinion on
> >> why this was originally designed this way in case we are missing something.
> > 
> > I do not really see why this would be wrong. Private file backed
> > mappings can contain a reapable memory as well. I do not see how this
> > would solve the futex issue.
> We were basing our discussion around the following comment:
> /*
>  * Only anonymous pages have a good chance to be dropped
>  * without additional steps which we cannot afford as we
>  * are OOM already.
>  *
>  * We do not even care about fs backed pages because all
>  * which are reclaimable have already been reclaimed and
>  * we do not want to block exit_mmap by keeping mm ref
>  * count elevated without a good reason.
>  */
> 
> So changing to an && would align the functionality with this comment by ignoring
> fs backed pages, and additionally it prevents shared mappings from being reaped.
> We have tested this change and found we can no longer reproduce the issue. In
> our case we allocate the mutex on a MAP_SHARED|MAP_ANONYMOUS mmap so the if-
> statement in question would no longer return true after the && change.
> 
> If it is the case that private fs backed pages matter perhaps we want something
> like this:
> 	if ((vma_is_anonymous(vma) && !(vma->vm_flags & VM_SHARED))
> 	||(!vma_is_anonymous(vma) && !(vma->vm_flags & VM_SHARED)))
> 
> or more simply:
> 	if(!(vma->vm_flags & VM_SHARED))
> 
> to exclude all VM_SHARED mappings.

I would have to think about that some more but I do not really see how
this is related to the futex issue. In other words what kind of problem
does this solve?

-- 
Michal Hocko
SUSE Labs
