Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0550C4B8CE4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbiBPPvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:51:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235769AbiBPPvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:51:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521952A82E2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 07:50:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E236761A5C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 15:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE471C004E1;
        Wed, 16 Feb 2022 15:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645026655;
        bh=SFNdUdbviVuwsH4h90rOML9Z996F328RaBfL4P8s3dM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oj5fpci1jHz1H55wQp76gOIJCXMFRUFI3BjWhaSX82iHKgncmP6hA1UUjEUoWqeYI
         3Ab9eS1RHRzahzf3lCXWT2D6Dq66/gtrVdFac+2RpOmnUEu2A4A8mdyuv1rJ/3DM/L
         1eGThY/89DyIfpV3MtlDe5RxlCpgfnNPbGVpTwamRd7eoq5itZFNcREkDfmCSQvc8B
         dv5Ra3sfarVvztyXI9UUU0NHTE3ziM3eyxfjJ9gzXrIgtSyNxuXWN6pTdXHDF1vGY6
         UbVAjuSyqeUXjU44QFQBbJyBzDTzyb74dA3t6p6qgEfdpZzoQxfa/1g7o9UjLwlt2x
         ZMOchAVzzvaAw==
Date:   Wed, 16 Feb 2022 08:50:51 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        "kernelci.org bot" <bot@kernelci.org>
Subject: Re: [PATCH] mm/page_alloc: Mark pagesets as __maybe_unused
Message-ID: <Yg0dWwfpGyGC/q40@dev-arch.archlinux-ax161>
References: <20220215184322.440969-1-nathan@kernel.org>
 <YgyvCTiIWAFKq6G4@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgyvCTiIWAFKq6G4@linutronix.de>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 09:00:09AM +0100, Sebastian Andrzej Siewior wrote:
> On 2022-02-15 11:43:22 [-0700], Nathan Chancellor wrote:
> > Commit 9983a9d577db ("locking/local_lock: Make the empty local_lock_*()
> > function a macro.") in the -tip tree converted the local_lock_*()
> > functions into macros, which causes a warning with clang with
> > CONFIG_PREEMPT_RT=n + CONFIG_DEBUG_LOCK_ALLOC=n:
> > 
> >   mm/page_alloc.c:131:40: error: variable 'pagesets' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
> >   static DEFINE_PER_CPU(struct pagesets, pagesets) = {
> >                                          ^
> >   1 error generated.
> > 
> > Prior to that change, clang was not able to tell that pagesets was
> > unused in this configuration because it does not perform cross function
> > analysis in the frontend. After that change, it sees that the macros
> > just do a typecheck on the lock member of pagesets, which is evaluated
> > at compile time (so the variable is technically "used"), meaning the
> > variable is not needed in the final assembly, as the warning states.
> > 
> > Mark the variable as __maybe_unused to make it clear to clang that this
> > is expected in this configuration so there is no more warning.
> > 
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1593
> > Reported-by: "kernelci.org bot" <bot@kernelci.org>
> > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >  mm/page_alloc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 7ff1efc84205..406f5d0c610f 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -128,7 +128,7 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
> >  struct pagesets {
> >  	local_lock_t lock;
> >  };
> > -static DEFINE_PER_CPU(struct pagesets, pagesets) = {
> > +static DEFINE_PER_CPU(struct pagesets, pagesets) __maybe_unused = {
> 
> No, I need to think of something else then for the local_lock thing.  I
> haven't seen it with gcc. There is probably more than just this one.

As far as I am aware, this is a clang only warning.

From my brief audit of uses of local_lock_t, I believe this is the only
one that will trigger this warning because every other structure that
has a local_lock_t also has another member that is unconditionally used,
meaning an instance of that structure will not just be used at compile
time. In this case, 'struct pagesets' ONLY contains a local_lock_t,
which is only used at compile time in this configuration, hence the
warning.

Of course, if you can think of something that works for your use case
and doesn't make clang warn, that would be ideal but I don't see this
patch as the worst solution. I'll run through my full set of builds
tonight and see if there are any other instances of this warning; this
particular instance was visible in several defconfigs so I fixed it
first.

Cheers,
Nathan
