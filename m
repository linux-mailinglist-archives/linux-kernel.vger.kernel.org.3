Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C244455CEF8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiF0HUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbiF0HUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:20:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5C25FE5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K8NxPx1jbqhLbCIeQl9QlBhlrp1zweaLyeE/ESUidak=; b=uzdIbozA0ktf0YFaK/anRamjlD
        SlZXIoHYFJZN0gnZbAz6jAVW1z1g1qF04O0Px871KkmaSR/StWRtGgMTBHezIGDVRBaAqb4O+Dudb
        Gm4jbtfX+l+4nyDeLLxZDHpVZYEePOPPDI3tQN6m4wID+1uYLXVcysTKyyQlk3mBEl+OOcBRgJ3We
        mVIBTaVKJZ6e9fCqS5qadsW0sDfK+Tr4hYpQMiBNC8aL5ALK6had5us6H8wIArsrIhT28w5xKW/+t
        yfu+ZaahSXD7ZayXAKWzvp+g38q884rtGCX+Ya/LWEEQYRQrU34+kdP/c8h+wduLuYF2+fgpqZjOO
        fR2fDU1g==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o5j28-00B8to-4F; Mon, 27 Jun 2022 07:19:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8FA2930040C;
        Mon, 27 Jun 2022 09:11:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E759D29BD6E00; Mon, 27 Jun 2022 09:11:10 +0200 (CEST)
Date:   Mon, 27 Jun 2022 09:11:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wedson Almeida Filho <wedsonaf@google.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Tejun Heo <tj@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: re. Spurious wakeup on a newly created kthread
Message-ID: <YrlYDppYKw6HRP1j@hirez.programming.kicks-ass.net>
References: <YraWWl+Go17uPOgR@mtj.duckdns.org>
 <CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com>
 <874k0863x8.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wgTG2K3erROP19320zBN6BHVf0hRfXGdawkGR4gzrJN6w@mail.gmail.com>
 <CAHk-=whLsaRKaFKS0UffeCYYCVyP0bbiB4BTYTaXtScgu6R9yA@mail.gmail.com>
 <87pmiw1fy6.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wiutNT47oNhyk_WvMj2qp4pehYFptXCUzW=u_2STLQiww@mail.gmail.com>
 <CAHk-=whX_=BNZ4kVEAu2NV3CMnhwsuYTyE65FQXUMx8VPNOAOA@mail.gmail.com>
 <87y1xkwa28.fsf@email.froward.int.ebiederm.org>
 <YrjxcR2M6AD6S9dW@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrjxcR2M6AD6S9dW@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 12:01:04AM +0000, Wedson Almeida Filho wrote:
> On Sat, Jun 24, 2022 at 07:19:27PM -0500, Eric W. Biederman wrote:
> > 
> > Further it is necessary for Peter Zijlstra's rewrite of the kernel
> > freezer.   As anything that isn't a special stop state (which
> > TASK_UNINTERRUPTIBLE is not) will receive a spurious wake up on when
> > thawed out.
> 
> Do you know if the current (i.e., prior to the rewrite) kernel freezer
> also sends spurious wakeups when thawing tasks?

Current freezer can thaw at random points in time, even before SMP
bringup if you're unlucky. And yes, I think it can induce 'spurious'
wakeups as well.

But really; like Linus already said upsteam, every wait loop *MUST*
already be able to deal with spurious wakeups. This is why pretty much
every wait primitive we have looks like:

	for (;;) {
		set_current_state(state);
		if (cond)
			break;
		schedule();
	}
	__set_current_state(RUNNING);

Which is immune to random wake-ups since it need @cond to make progress.
*NEVER* rely on just the wakeup itself for progress, that's buggy as
heck in lots of ways.

There are a few exceptions, but they all require special wait states and
much carefulness.
