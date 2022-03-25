Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F5E4E735A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 13:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356576AbiCYM1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356074AbiCYM0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:26:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28E99728E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 05:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P7tGyqEwWc81RHVSYIN5UGxFvVuN1kKnpEJ4mIzQ1Pk=; b=g5nXrnxIRrWhg8jmJtH39s9+7R
        6jSVWAy018qvV1YJiTJ3PI5oqepEL/IYgyoeKBKNhQBvKhd3+IPyHs9QU+T8yoYe05FhSSQjVSJve
        nRL6VKChyltx66sqVTkzgQRIleVvyi7PsikiWBu+d9RWzPOh42/f+S6Wgbhi8wi0hS+0vOMZFTrrl
        zud+0zPJIRx0VGhCHqd4OtEBTdEwmgdVbxJWHeBcA1HCz/vPc44V3FrGvnmPv6/fCbxXJU1/Nvx6O
        oJb2Q6iCQ1jzzTHxqyefmtHkuPvA5r6CdPa02r34KQ9Xh0QTZ90kvQG6/+uCiXviatraLLRV4dqyp
        VORC/8Iw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXiyg-00ELfg-6W; Fri, 25 Mar 2022 12:23:38 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 76659987D26; Fri, 25 Mar 2022 13:23:36 +0100 (CET)
Date:   Fri, 25 Mar 2022 13:23:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [GIT PULL] locking changes for v5.18
Message-ID: <20220325122336.GQ8939@worktop.programming.kicks-ass.net>
References: <YjhdcJB4FaLfsoyO@gmail.com>
 <CAHk-=wjS6ptr5=JqmmyEb_qTjDz_68+S=h1o1bL1fEyArVOymA@mail.gmail.com>
 <YjpLiKRUIB4TGJm0@zn.tnic>
 <CAHk-=wifoM9VOp-55OZCRcO9MnqQ109UTuCiXeZ-eyX_JcNVGg@mail.gmail.com>
 <Yj2qZT6gdRYpkSIR@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yj2qZT6gdRYpkSIR@smile.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 01:41:25PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 22, 2022 at 03:58:47PM -0700, Linus Torvalds wrote:
> > On Tue, Mar 22, 2022 at 3:20 PM Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > Ah, you say build error because you have CONFIG_WERROR=y.
> > 
> > EVERYBODY should have CONFIG_WERROR=y on at least x86-64 and other
> > serious architectures, unless you have some completely random
> > experimental (and broken) compiler.
> > 
> > New compiler warnings are not acceptable.
> 
> What about old one? I have already complained in the early discussion that
> `make W=1 ...` is broken by this change. Enabling it without fixing
> _existing_ warnings on W=1 is not suitable for somebody. Now, I have to
> modify my configs to disable WERROR because of inability to built at all.
> 
> (Yes, I understand that I may drop W=1, but that's not the point. since I
>  want to have clean builds of a new code on level 1 of warnings)

It would be fairly easy to make scripts/Makefile.extrawarn strip out
-Werror when W= is used.

