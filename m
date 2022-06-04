Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA09C53D65E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 12:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbiFDKMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 06:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiFDKMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 06:12:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F3A1EAC0
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 03:12:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 004B260FA7
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 10:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3CDC385B8;
        Sat,  4 Jun 2022 10:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654337566;
        bh=diFWkv6AXJtcnPWZtj+GKRWXyMiOs2dVsMrrhuMUnVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OvCMrnl+xudA+Q9ocIubd2HSZzcZ7W7AIlQ80mAwyQ/md1tUZxcxEY7f/nAU/ju95
         /eRCO5Gq8pG6FNw3qY/Ynh2hYxY43ErEcgZr3sM469fSthmWsFCRzG41Ls8aKJqc6v
         s3om4CuVW6JrrT6mETwEjyvXRh73BBKGTOE/53U4=
Date:   Sat, 4 Jun 2022 12:12:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev
Subject: Re: [GIT PULL] Staging driver updates for 5.19-rc1
Message-ID: <YpswG6Obmp4b3y66@kroah.com>
References: <Ypng29bf0vGJ20fo@kroah.com>
 <CAHk-=wjTkU15iuSVrue_tRhD7=9v2YatrnFNxg=wEpT9-Szd4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjTkU15iuSVrue_tRhD7=9v2YatrnFNxg=wEpT9-Szd4w@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 11:07:46AM -0700, Linus Torvalds wrote:
> On Fri, Jun 3, 2022 at 3:22 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > Note, you will have a merge conflict in the
> > drivers/net/wireless/silabs/wfx/sta.c file, please just take the change
> > that came in from the wifi tree.  We thought as I had pulled the same
> > merge point from the wifi developers this type of conflict wouldn't have
> > happened, but for some reason git flags it as something to pay attention
> > to and couldn't resolve it itself.
> 
> That "some reason" is because the networking tree made other changes
> to the file since (ie commit 2c33360bce6a: "wfx: use container_of() to
> get vif").
> 
> So both branches had done the same change (the merge), but one branch
> had then done other changes on top of that same change.
> 
> Broken SCM thinking then thinks that means that "oh, then we obviously
> have to take the extra change" (eg darcs "patch algebra"), and make
> that the basis of their resolution strategy. It's not actually a valid
> model, because it just assumes that the additional patches were right.
> Maybe there was a _reason_ that extra patch wasn't done in the other
> branch? The extra patch might have been due to particular issues in
> that branch, you can't just make the darcs assumption of reordering
> patches and taking some union of them (which is an over-simplification
> of the patch algebra rules).
> 
> Now, that's not to say that git can't get things wrong too when
> resolving things. But at least it doesn't make some fundamental
> mistake like that.
> 
> The git rules are basically that it will resolve changes that aren't
> overlapping, using the traditional 3-way model (it then has that whole
> "recursion and rename detection" thing, but that's more of a
> higher-level metadata thing separate from the actual code merge).
> 
> So git doesn't assume any "semantics" to the changes. If it sees that
> two branches changed the same code in different ways, git will go
> "this is a conflict", and leave it to human (or scripted)
> intervention.
> 
> Again, it's not that the git model is always right - you can obviously
> have changes that do *not* overlap at all, but still have a very
> fundamental semantic conflict, and git will happily merge those things
> and think it is all good.
> 
> So the git model is basically practical and straightforward (also
> "stupid", but in a good way - do the common truly obvious 3-way
> merges, don't try to do anything clever when that fails). There's no
> "theory" behind it that might turn out to be completely wrong.
> 
> Anyway, the conflict was trivial, but I thought I'd just explain both
> the immediate "why did it conflict" _and_ the more abstract "why did
> git make that choice".

That makes more sense now, git is being "safe" by asking for the
developer to look and resolve it themselves.

thanks for the explanation.

greg k-h
