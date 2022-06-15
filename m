Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8526E54D259
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 22:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347306AbiFOUNg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Jun 2022 16:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346543AbiFOUNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 16:13:23 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0512340F6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 13:13:21 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 08FE01C0BC7; Wed, 15 Jun 2022 22:13:20 +0200 (CEST)
Date:   Wed, 15 Jun 2022 22:13:18 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Tim Murray <timmurray@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [GIT PULL] f2fs for 5.18
Message-ID: <20220615201318.GA1194@bug>
References: <YjjihIZuvZpUjaSs@google.com>
 <CAHk-=wgsmvoJFKFWxQ2orEVUOWH1agk9iUNZ=-DFh5OXZL=Ldw@mail.gmail.com>
 <51cded74-3135-eed8-06d3-0b2165e3b379@redhat.com>
 <CAHk-=wi=Xsekgj7zfw_vpOM673CG24vznmz-yx9G05rWSAAYXg@mail.gmail.com>
 <Yjo4fg4HRzEVDr7o@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <Yjo4fg4HRzEVDr7o@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > AFAICS, the read-unfair rwsem code is created to resolve a potential
> > > lock starvation problem that they found on linux-5.10.y stable tree. I
> > > believe I have fixed that in the v5.11 kernel, see commit 2f06f702925
> > > ("locking/rwsem: Prevent potential lock starvation").
> > 
> > Ahh.
> > 
> > Adding Tim Murray to the cc, since he was the source of that odd
> > reader-unfair thing.
> > 
> > I really *really* dislike people thinking they can do locking
> > primitives, because history has taught us that they are wrong.
> > 
> > Even when people get the semantics and memory ordering right (which is
> > not always the case, but at least the f2fs code uses real lock
> > primitives - just oddly - and should thus be ok), it invariably tends
> > to be a sign of something else being very wrong.
> > 
> > And I can easily believe that in this case it's due to a rmsem issue
> > that was already fixed long long ago as per Waiman.
> > 
> > Can people please test with the actual modern rwsem code and with the
> > odd reader-unfair locks disabled?
> 
> The pain point is 1) we don't have a specific test to reproduce the issue,
> but got some foundings from field only, 2) in order to test the patches, we
> need to merge the patches into Android kernel [1] through LTS, 3) but, LTS
> wants to see any test results [2].
> 
> [1] https://android-review.googlesource.com/q/topic:rwsem_unfair
> [2] https://lore.kernel.org/stable/988fd9b5-8e89-03ae-3858-85320382792e@redhat.com/

Wait, what? Normally, patches are tested before going to mainline, and especially
before being backported to stable.

If you can't reproduce issue on mainline kernel, there's something very wrong
with trying to fix it on mainline kernel. You should not be merging untested fixes
so that they can make it into mainline and then into stable and then into android kernel
to be tested.

If there's no other way, you should be able to backport those patches to android kernel and
test them _before_ merging them. Android phones are rather cheap. Some should even run mainline
kernels -- see for example Oneplus 4T -- if you don't need all the features.

It looks hch was right NAKing the patches.

Best regards,

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
