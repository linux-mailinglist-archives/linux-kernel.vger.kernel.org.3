Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7DA55E21E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243173AbiF1H7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243121AbiF1H7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:59:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECE01145B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UBub0aQrCBJIDUEBVquFwPWBRxEAkuA9d+EzYexwvls=; b=wEECVkQuIW0fyDMwcdKQQ6uSYd
        n6B0t6s8ej8uDb7HwGiNOXxa73gBiF1JttoDAaTMBHQdawJ72Q51CFToqJsmZ9MKNJxhYSCIw2gWI
        pQuZEkBvQOeEtGgCwpGjI//62MsSmlYSDoxkWv3PI8IM4Kp/wvOuCoj/hW8jZdq6tJUESqEtKUsAj
        +35e4UXDcyzHRbx7XUSqoBkxNmIKGLYxDAsKRqhNZCdfS7Ckh1j2D/1hIymRApNWMQK6UxLBy805l
        rbjJ3/mVB4O6xj4ez7pR9Y5JBCsCzj8LUruokY1i19fDuPSy78fr7102a6qvMBg/EW39F75lKMqEO
        rNmS4jhw==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o667R-00C6CY-KQ; Tue, 28 Jun 2022 07:58:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 52B273003B0;
        Tue, 28 Jun 2022 09:58:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 19614203BF71D; Tue, 28 Jun 2022 09:58:43 +0200 (CEST)
Date:   Tue, 28 Jun 2022 09:58:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wedson Almeida Filho <wedsonaf@google.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 3/3] kthread: Stop abusing TASK_UNINTERRUPTIBLE
 (INCOMPLETE)
Message-ID: <Yrq0swWUDQL2DPXc@hirez.programming.kicks-ass.net>
References: <CAHk-=whX_=BNZ4kVEAu2NV3CMnhwsuYTyE65FQXUMx8VPNOAOA@mail.gmail.com>
 <87ilonuti2.fsf_-_@email.froward.int.ebiederm.org>
 <871qvbutex.fsf_-_@email.froward.int.ebiederm.org>
 <CAHk-=wg9eqtrpYrjJ=yobkwkTimWFtiDd_JOfADttG0fyAJrqg@mail.gmail.com>
 <YrjAJN7dDJ9R7Ocu@mtj.duckdns.org>
 <Yrlavf4Ymnz4T3LM@hirez.programming.kicks-ass.net>
 <YrlmOA/Xd+U7+b2E@mtj.duckdns.org>
 <YrnxHBoi6sO0vqV0@google.com>
 <Yrop5Wzc72GIREVv@hirez.programming.kicks-ass.net>
 <YrpMIcECVOMPVpJN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrpMIcECVOMPVpJN@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 12:32:33AM +0000, Wedson Almeida Filho wrote:
> On Tue, Jun 28, 2022 at 12:06:29AM +0200, Peter Zijlstra wrote:
> > On Mon, Jun 27, 2022 at 06:04:12PM +0000, Wedson Almeida Filho wrote:
> > 
> > >   let new_thread = task::new_paused(|| pr_info!("Hello world\n"))?;
> > 
> > I'm still having a really hard time with this Rust stuff, the above
> > looks like a syntax error and random characters to me :/
> 
> Peter, I meant to ask in my previous email: setting aside the syntax for
> a moment, do you have an opinion on the sort of things that Rust allows
> us to enforce at compile time (as exemplified in the new_paused()
> fragment)?

So I used to do quite a lot of C++ in a previous life; I think I'm more
or less familiar with a lot of the things Rust offers, except it is a
lot stricter. C++ allows you to do the right thing, but also allows you
to take your own foot off (a bit like C, except you can make an even
bigger mess of things), where Rust tries really hard to protect the
foot.

The one thing I dread is compile times, C++ is bad, but given Rust has
to do even more compile time enforcement it'll suck worse. And I'm
already not using clang because it's so much worse than gcc.

I've just not had *any* time to actually look at Rust in any detail :/

But given I'm the kind of idiot that does tree-wide cleanups just
because it's the right thing, I'm bound to run into it sooner rather
than later, and then I'll curse my way through having to learn it just
to get crap done I expect ...

Anyway; from what I understand Rust is a fair way away from core code.
