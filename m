Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9B64F6824
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239542AbiDFRnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239952AbiDFRm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:42:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0995B323884;
        Wed,  6 Apr 2022 09:28:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7ABAB824CD;
        Wed,  6 Apr 2022 16:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9AFC385A3;
        Wed,  6 Apr 2022 16:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649262501;
        bh=RO6oFh4/G2Dex/wyHDpkixhfO/24KmgeZmhyqDepGCU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=n85auwxTRUdd1nnTgXWAIcEu2FZwejkbMRK610T7d7+18gL80AOV7kUGrR7XQDhBM
         +AEVH+sOg8R8zIi5VGn8OFqErztJnyMlyBHyu0iq0EuNWZ4wjD2+BmrYihhX5SOwLU
         Ie6i3zPtGlPhrqsHGqAJ5PeB11zpcDuH6a34i65UhxF4kLAs5TCxbtT6QMG3fw8Qi4
         mNi4KS4fbsbRAhktTS1kYhO/kbTUcymPEBf9RRrGtSaklPQ2WrCb1fP0lOHSa4D22W
         2SkLWD4ULhOf0xPTBWEnABGhJoKwmSzfhmg+ZN6U+iAk+AggUJK+iPv0QvqcLU/+Iu
         lS6JU5vWQDvUA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 110485C0B85; Wed,  6 Apr 2022 09:28:21 -0700 (PDT)
Date:   Wed, 6 Apr 2022 09:28:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: linux-next: manual merge of the rcu tree with the tip tree
Message-ID: <20220406162821.GM4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220406124503.25e8ed68@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406124503.25e8ed68@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 12:45:03PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the rcu tree got conflicts in:
> 
>   kernel/sched/core.c
>   include/linux/sched.h
> 
> between commit:
> 
>   cfe43f478b79 ("preempt/dynamic: Introduce preemption model accessors")
> 
> from the tip tree and commit:
> 
>   42e3e3c6a774 ("EXP preempt/dynamic: Introduce preempt mode accessors")
> 
> from the rcu tree.
> 
> Well, this is just a pain.  Paul, please don't put expierimental things
> in you linuc-nect included branch.  I have dropped the rcu tree today.

Gah!  Please accept my apologies for the hassle!

In the short term, I have reset rcu/next to the commit preceding
42e3e3c6a774 ("EXP preempt/dynamic: Introduce preempt mode accessors").
This could cause some trouble for a few corner-case -next users, but...

Longer term, this is excellent news, because it means that I can drop
that commit from my tree entirely and rebase my stack on top of the
version of that same commit that is just now in -tip.

> The rules I use for the linux-next tree are:
> 
> "You will need to ensure that the patches/commits in your tree/series have
> been:
>      * submitted under GPL v2 (or later) and include the Contributor's
>         Signed-off-by,
>      * posted to the relevant mailing list,
>      * reviewed by you (or another maintainer of your subsystem tree),
>      * successfully unit tested, and 
>      * destined for the current or next Linux merge window.
> 
> Basically, this should be just what you would send to Linus (or ask him
> to fetch).  It is allowed to be rebased if you deem it necessary."

Understood, and thank you.

The next time that I am forced to choose between propagating a bug into
-next on the one hand and precisely following the above rules on the
other, I will consult with you beforehand.  Please accept my apologies
for failing to have done so this time.

							Thanx, Paul
