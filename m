Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE3B515840
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381450AbiD2WSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381298AbiD2WR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:17:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA45DCAAC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3IoXqscm/GDB8ayCU86uJUqG77jsTrHm9nyAZKLbLS0=; b=cB+HOg4h9IRvZr98l3wNejVaiK
        KHKK/QWiK7mse+v/+129F07PiliiE3gS5MVOXw1MLNWwhLuqnAFlrqGLee2M5UGQIeBZk8xRZsEG2
        +wvCB9A2YnclGFgLlwVZFIPoq1zMem+6oU2Y0nqy9zYGRiOkzm4BTpITh5WJJjpsQ3IUMCrp4NAtj
        3PYlmbIcaXeC58NtBIJfmHZgjl/5W9tEfdl3qOE81gHL8W2SkG+htIEL7+4Cqc4Ut8FlEyAc1drlt
        uO8ybuOfqaS45vUhcdFVqufOYTp+kp2Cw8Y4TAYuScoEkpUxEeDxm1eE9h1QZq0xiCqPG+sHAhSGt
        TMzkwWpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkYsf-00Cr4i-F3; Fri, 29 Apr 2022 22:14:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EC01B3003AA;
        Sat, 30 Apr 2022 00:14:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D049820295B05; Sat, 30 Apr 2022 00:14:28 +0200 (CEST)
Date:   Sat, 30 Apr 2022 00:14:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] x86,entry: Use PUSH_AND_CLEAR_REGS for compat
Message-ID: <YmxjRIh4SiTiqQKD@hirez.programming.kicks-ass.net>
References: <20220429091301.GR2731@worktop.programming.kicks-ass.net>
 <CAJhGHyBUzURTBBnkO5c5xRC+c9+KFvLXw06h5uQ7gODeiSR-QA@mail.gmail.com>
 <YmxU2JoswWMYm4nl@hirez.programming.kicks-ass.net>
 <CAHk-=wg1p87BAj3ebiugG9Q5YaKNUDpEWmjLKam69Ak3g__Aug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg1p87BAj3ebiugG9Q5YaKNUDpEWmjLKam69Ak3g__Aug@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 02:30:45PM -0700, Linus Torvalds wrote:
> On Fri, Apr 29, 2022 at 2:13 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > (Linus, can I add your SoB to the thing?)
> 
> If you teste this with some actual old int80 compat syscalls, then absolutely:

I ran tools/testing/selftests/x86/*_32 on it. That definitely tickles
the int80 path. Also, without the off-by-one fixed that gives some
generous helpings of segfault.

>    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Thanks!

> > +       pushq   %rdi                    /* pt_regs->di */
> >         pushq   %rsi                    /* pt_regs->si */
> >         xorl    %esi, %esi              /* nospec   si */
> 
> It would probably make sense to add a comment about why %rdi isn't
> cleared when pushed, like all the other registers are.
> 
> Even if that comment is just "%rdi will be overwritten as arg0 of the
> call to C, so no need to clear it".
> 
> Maybe as part of the PUSH_AND_CLEAR_REGS changes?

I'll stick the comment on.
