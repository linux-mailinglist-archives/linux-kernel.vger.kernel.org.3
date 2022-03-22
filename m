Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9A64E3FBA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbiCVNnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiCVNmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:42:43 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F61B86E2B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:41:15 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22MDf0De011046;
        Tue, 22 Mar 2022 14:41:00 +0100
Date:   Tue, 22 Mar 2022 14:41:00 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     David Laight <David.Laight@aculab.com>
Cc:     "'Ammar Faizi'" <ammarfaizi2@gnuweeb.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [RFC PATCH v2 3/8] tools/nolibc: i386: Implement syscall with 6
 arguments
Message-ID: <20220322134100.GH10306@1wt.eu>
References: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
 <20220322102115.186179-4-ammarfaizi2@gnuweeb.org>
 <8653f6784a9b4272a59a75a530663567@AcuMS.aculab.com>
 <a8eeec1d-656d-15a3-dde5-0f8cc8c5956b@gnuweeb.org>
 <20220322121338.GD10306@1wt.eu>
 <81569a1c-a6d3-ceb2-a1f1-f229a024d684@gnuweeb.org>
 <20220322133413.GG10306@1wt.eu>
 <58cb5455-d065-b508-b328-20b57c3a67a7@gnuweeb.org>
 <3b8984ecfbcd4c93aeb468d01728cd74@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b8984ecfbcd4c93aeb468d01728cd74@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 01:39:41PM +0000, David Laight wrote:
> From: Ammar Faizi
> > Sent: 22 March 2022 13:37
> > 
> > On 3/22/22 8:34 PM, Willy Tarreau wrote:
> > >> I turned out GCC refuses to use "rm" if we compile without -fomit-frame-pointer
> > >> (e.g. without optimization / -O0). So I will still use "m" here.
> > >
> > > OK that's fine. then you can probably simplify it like this:
> > >
> > >        long _arg6 = (long)(arg6); /* Might be in memory */    \
> > >                                                               \
> > >        asm volatile (                                         \
> > >            "pushl  %%ebp\n\t"                                 \
> > >            "movl   %[_arg6], %%ebp\n\t"                       \
> > >            "int    $0x80\n\t"                                 \
> > >            "popl   %%ebp\n\t"                                 \
> > >            : "=a"(_ret)                                       \
> > >            : "r"(_num), "r"(_arg1), "r"(_arg2), "r"(_arg3),   \
> > >              "r"(_arg4),"r"(_arg5), [_arg6]"m"(_arg6)        \
> > >            : "memory", "cc"                                   \
> > >        );                                                     \
> > >
> > > See ? no more push, no more addl, direct load from memory.
> > 
> > Uggh... I crafted the same code like you suggested before, but then
> > I realized it's buggy, it's buggy because %[_arg6] may live in N(%esp).
> > 
> > When you pushl %ebp, the %esp changes, N(%esp) no longer points to the
> > 6-th argument.
> 
> Yep - that is why I wrote the 'push arg6'.

Got it and you're right indeed, sorry for the noise :-)

Willy
