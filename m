Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0EB54E845
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245417AbiFPRC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 13:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345057AbiFPRC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 13:02:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F5F443C3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:02:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B39AC6194A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 17:02:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6488C34114;
        Thu, 16 Jun 2022 17:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655398944;
        bh=XnVv4J01sdGBe11MNJIXMTTsXg4laIcwwL1T++aKoAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RcWyAlCr0j8hyWym7NRFXVgQcYDBVCnYdfXopAy+sBmRw59Ei3RFI86S6eWFdDkRw
         yOT53lW3zswSA6EgeLsI+M9SgidiiobkmfeZOTGQykdcqq5AfotbvsMRhxJl0W2WAL
         re7TJCh1n6zpyyoaDwTlno3Odx9bfybDVjTaBOnD79wgzONbGehld0Ekqp9uenrbot
         uDqE/JODSJK3lW7gZgdqMqzZUBUxswtX1s+G4XE65kvJhxp24jLjOJ32WTUDyMb7fh
         Gv/gFzgOEErxTi2NMfM6K8bao92r8awJaNRKVI5DfiUOA5/4OhD0S4SVvdTy9sAUws
         Sir100L21DLqg==
Date:   Thu, 16 Jun 2022 10:02:22 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Tim Murray <timmurray@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [GIT PULL] f2fs for 5.18
Message-ID: <YqtiHmFTbWyrueq8@google.com>
References: <YjjihIZuvZpUjaSs@google.com>
 <CAHk-=wgsmvoJFKFWxQ2orEVUOWH1agk9iUNZ=-DFh5OXZL=Ldw@mail.gmail.com>
 <51cded74-3135-eed8-06d3-0b2165e3b379@redhat.com>
 <CAHk-=wi=Xsekgj7zfw_vpOM673CG24vznmz-yx9G05rWSAAYXg@mail.gmail.com>
 <Yjo4fg4HRzEVDr7o@google.com>
 <20220615201318.GA1194@bug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615201318.GA1194@bug>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/15, Pavel Machek wrote:
> Hi!
> 
> > > > AFAICS, the read-unfair rwsem code is created to resolve a potential
> > > > lock starvation problem that they found on linux-5.10.y stable tree. I
> > > > believe I have fixed that in the v5.11 kernel, see commit 2f06f702925
> > > > ("locking/rwsem: Prevent potential lock starvation").
> > > 
> > > Ahh.
> > > 
> > > Adding Tim Murray to the cc, since he was the source of that odd
> > > reader-unfair thing.
> > > 
> > > I really *really* dislike people thinking they can do locking
> > > primitives, because history has taught us that they are wrong.
> > > 
> > > Even when people get the semantics and memory ordering right (which is
> > > not always the case, but at least the f2fs code uses real lock
> > > primitives - just oddly - and should thus be ok), it invariably tends
> > > to be a sign of something else being very wrong.
> > > 
> > > And I can easily believe that in this case it's due to a rmsem issue
> > > that was already fixed long long ago as per Waiman.
> > > 
> > > Can people please test with the actual modern rwsem code and with the
> > > odd reader-unfair locks disabled?
> > 
> > The pain point is 1) we don't have a specific test to reproduce the issue,
> > but got some foundings from field only, 2) in order to test the patches, we
> > need to merge the patches into Android kernel [1] through LTS, 3) but, LTS
> > wants to see any test results [2].
> > 
> > [1] https://android-review.googlesource.com/q/topic:rwsem_unfair
> > [2] https://lore.kernel.org/stable/988fd9b5-8e89-03ae-3858-85320382792e@redhat.com/
> 
> Wait, what? Normally, patches are tested before going to mainline, and especially
> before being backported to stable.
> 
> If you can't reproduce issue on mainline kernel, there's something very wrong
> with trying to fix it on mainline kernel. You should not be merging untested fixes
> so that they can make it into mainline and then into stable and then into android kernel
> to be tested.

What do you mean "untested fixes" here? As Tim mentioned [1], this F2FS patch
resolved the issue in our Pixel devices.

[1] https://lore.kernel.org/lkml/CAEe=Sxmcn5+YUXBQhxDpzZVJu_T6S6+EURDqrP9uUS-PHGyuSg@mail.gmail.com/

> 
> If there's no other way, you should be able to backport those patches to android kernel and
> test them _before_ merging them. Android phones are rather cheap. Some should even run mainline
> kernels -- see for example Oneplus 4T -- if you don't need all the features.

IIUC, the point here was whether we need another generic rwsem API to address
the issue or not. [1] said some rwsem fixes couldn't resolve our issue,
and Waiman wanted to test another patch [2]. In order to avoid endless
tests, I decided to get some results from Pixel using v5.15 (at least) by
turning CONFIG_F2FS_UNFAIR_RWSEM off as of now. If we can see v5.15
works, I'm happy to revert the F2FS patch. Otherwise, we need it for
our production.

[2] https://lore.kernel.org/lkml/5acaaf61-5419-178d-c805-62f979697653@redhat.com/#t

> 
> It looks hch was right NAKing the patches.
> 
> Best regards,
> 
> 									Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
