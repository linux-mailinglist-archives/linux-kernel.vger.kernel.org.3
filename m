Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6EB5241AF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 02:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349754AbiELAt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 20:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345699AbiELAty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 20:49:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4875066FAA
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 17:49:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCBDBB825FE
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD4DC340EE;
        Thu, 12 May 2022 00:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652316590;
        bh=eWke+NN1Ar4ZNDhe1jOCTRWa0cwyvdm8F4X6YA+8kK8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=k6d9rbL12uyyjp74yBjzKvcn4ZUeTVKs87va/EwFEHTRQSsy29qeTg7zvvtrx+Jw4
         /hGLSxt0gJgUrV4qnDkcuwLNquYV+10gydxteNl50VwNuSs2GTZ2SIPKobtnqNGdyV
         xhvx038uhHTXSNQ4wEFYMpwFZrTkNn6f8wSgQ4jGkmgxr6+mnbFSO9Qlu70DSsxkVj
         agk2G4k2wnHP20Wou776/LGM+O+D4pVzIK07eTORqoW+de/RAt57+1VleS9ZftLJPE
         piZFMJijh94kkFSbhhUAJM2TZgBFlMpxkJLk3SaWArNA8YOORmWTlIADNUNcomO6GY
         IZsFaAKa2ml2Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 06F3E5C05FC; Wed, 11 May 2022 17:49:50 -0700 (PDT)
Date:   Wed, 11 May 2022 17:49:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Message-ID: <20220512004949.GK1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Ynw6mauQuNhrOAHy@google.com>
 <f7bcda22-8ffe-67be-36bc-fcde58d8884a@nvidia.com>
 <YnxCCPZUfgQNXSg6@google.com>
 <8f083802-7ab0-15ec-b37d-bc9471eea0b1@nvidia.com>
 <20220511234534.GG1790663@paulmck-ThinkPad-P17-Gen-1>
 <ea64b36c-ecc1-74db-dd2e-909e7e507ef8@nvidia.com>
 <0d90390c-3624-4f93-f8bd-fb29e92237d3@nvidia.com>
 <20220512002207.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnxUTxnCJ6EsmjEi@google.com>
 <f7ff4186-e629-a5da-3f4d-ec629b0c8dd9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7ff4186-e629-a5da-3f4d-ec629b0c8dd9@nvidia.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 05:34:52PM -0700, John Hubbard wrote:
> On 5/11/22 17:26, Minchan Kim wrote:
> > > > Let me try to say this more clearly: I don't think that the following
> > > > __READ_ONCE() statement can actually help anything, given that
> > > > get_pageblock_migratetype() is non-inlined:
> > > > 
> > > > +	int __mt = get_pageblock_migratetype(page);
> > > > +	int mt = __READ_ONCE(__mt);
> > > > +
> > > > +	if (mt & (MIGRATE_CMA | MIGRATE_ISOLATE))
> > > > +		return false;
> > > > 
> > > > 
> > > > Am I missing anything here?
> > > 
> > > In the absence of future aggression from link-time optimizations (LTO),
> > > you are missing nothing.
> > 
> > A thing I want to note is Android kernel uses LTO full mode.
> 
> Thanks Paul for explaining the state of things.
> 
> Minchan, how about something like very close to your original draft,
> then, but with a little note, and the "&" as well:
> 
> int __mt = get_pageblock_migratetype(page);
> 
> /*
>  * Defend against future compiler LTO features, or code refactoring
>  * that inlines the above function, by forcing a single read. Because, this
>  * routine races with set_pageblock_migratetype(), and we want to avoid
>  * reading zero, when actually one or the other flags was set.
>  */
> int mt = __READ_ONCE(__mt);
> 
> if (mt & (MIGRATE_CMA | MIGRATE_ISOLATE))
>     return false;
> 
> 
> ...which should make everyone comfortable and protected from the
> future sins of the compiler and linker teams? :)

This would work, but it would force a store to the stack and an immediate
reload.  Which might be OK on this code path.

But using READ_ONCE() in (I think?) __get_pfnblock_flags_mask()
would likely generate the same code that is produced today.

	word = READ_ONCE(bitmap[word_bitidx]);

But I could easily have missed a turn in that cascade of functions.  ;-)

Or there might be some code path that really hates a READ_ONCE() in
that place.

							Thanx, Paul
