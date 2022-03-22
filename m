Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7E24E47EF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiCVVAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 17:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiCVVAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 17:00:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA6A14017
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 13:58:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4D846171D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 20:58:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019BBC340EC;
        Tue, 22 Mar 2022 20:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647982720;
        bh=qneKTjCnzz1tSRczDENyPpegPElP0m0jzzOPobXNPLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ht4dYd/bNEB12UbTCLdQOiYj35b9WG6DBUguqxmVkhLeU5fCqJUa8ZLhRZbqmPnKa
         leOOQPPl9CIm2JlCWfDym3kx99dyQ8JyM0HmSxS3JWmsisL0aJhsL9wRjN6jnTRTTs
         Y16qQV8sHJCGnqSP9JDo//puaaVKuF/eQIQmIal2zlpphLTmsxqr78C43cE78uVYaz
         n0nPEsNfE/62DIrpwvnbCjB56Q9naia+8XdWszdQNMoWbkHchBr+qU1JJCgFL59abo
         2NWqJgv2/GiP0Rk640D9z4gmlJYagwuoyR+ALI6j49boo9+u6aEzvSkVvS+saGcqHG
         I5sa/JchBKDtw==
Date:   Tue, 22 Mar 2022 13:58:38 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Waiman Long <longman@redhat.com>,
        Tim Murray <timmurray@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [GIT PULL] f2fs for 5.18
Message-ID: <Yjo4fg4HRzEVDr7o@google.com>
References: <YjjihIZuvZpUjaSs@google.com>
 <CAHk-=wgsmvoJFKFWxQ2orEVUOWH1agk9iUNZ=-DFh5OXZL=Ldw@mail.gmail.com>
 <51cded74-3135-eed8-06d3-0b2165e3b379@redhat.com>
 <CAHk-=wi=Xsekgj7zfw_vpOM673CG24vznmz-yx9G05rWSAAYXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi=Xsekgj7zfw_vpOM673CG24vznmz-yx9G05rWSAAYXg@mail.gmail.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 03/22, Linus Torvalds wrote:
> On Tue, Mar 22, 2022 at 10:37 AM Waiman Long <longman@redhat.com> wrote:
> >
> > AFAICS, the read-unfair rwsem code is created to resolve a potential
> > lock starvation problem that they found on linux-5.10.y stable tree. I
> > believe I have fixed that in the v5.11 kernel, see commit 2f06f702925
> > ("locking/rwsem: Prevent potential lock starvation").
> 
> Ahh.
> 
> Adding Tim Murray to the cc, since he was the source of that odd
> reader-unfair thing.
> 
> I really *really* dislike people thinking they can do locking
> primitives, because history has taught us that they are wrong.
> 
> Even when people get the semantics and memory ordering right (which is
> not always the case, but at least the f2fs code uses real lock
> primitives - just oddly - and should thus be ok), it invariably tends
> to be a sign of something else being very wrong.
> 
> And I can easily believe that in this case it's due to a rmsem issue
> that was already fixed long long ago as per Waiman.
> 
> Can people please test with the actual modern rwsem code and with the
> odd reader-unfair locks disabled?

The pain point is 1) we don't have a specific test to reproduce the issue,
but got some foundings from field only, 2) in order to test the patches, we
need to merge the patches into Android kernel [1] through LTS, 3) but, LTS
wants to see any test results [2].

[1] https://android-review.googlesource.com/q/topic:rwsem_unfair
[2] https://lore.kernel.org/stable/988fd9b5-8e89-03ae-3858-85320382792e@redhat.com/

So, I thought applying it in f2fs could avoid kernel version issues without
any risk of updating rwsem. Meanwhile, agreed that we should use the right APIs,
I'm going to disable this f2fs change in the next device having newer kernel to
see whether or not uptodate rwsem can really fix the issue.

> 
>             Linus
