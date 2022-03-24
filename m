Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F402A4E663A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 16:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351341AbiCXPoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 11:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351343AbiCXPn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:43:59 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11D3BA0BDF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 08:42:25 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22OFgAuG019967;
        Thu, 24 Mar 2022 16:42:10 +0100
Date:   Thu, 24 Mar 2022 16:42:10 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH v1 04/11] tools/nolibc: x86-64: Use appropriate register
 constraints if exist
Message-ID: <20220324154210.GC19142@1wt.eu>
References: <20220324073039.140946-1-ammarfaizi2@gnuweeb.org>
 <20220324073039.140946-5-ammarfaizi2@gnuweeb.org>
 <20220324075728.GC18586@1wt.eu>
 <CAOG64qMwKYHLrUVro1gFhYqHvm8wq5DUdO7QfK5gG2TKhfnNhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOG64qMwKYHLrUVro1gFhYqHvm8wq5DUdO7QfK5gG2TKhfnNhA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 03:33:57PM +0700, Alviro Iskandar Setiawan wrote:
> On Thu, Mar 24, 2022 at 2:57 PM Willy Tarreau <w@1wt.eu> wrote:
> > On Thu, Mar 24, 2022 at 02:30:32PM +0700, Ammar Faizi wrote:
> > > Use appropriate register constraints if exist. Don't use register
> > > variables for all inputs.
> > >
> > > Register variables with "r" constraint should be used when we need to
> > > pass data through a specific register to extended inline assembly that
> > > doesn't have a specific register constraint associated with it (anything
> > > outside %rax, %rbx, %rcx, %rdx, %rsi, %rdi).
> > >
> > > It also simplifies the macro definition.
> >
> > I'm a bit bothered by this one because I went the exact opposite route
> > in the early design precisely because I found that the current one was
> > simpler. [...]
> [...]
> > I'd say that if there is any technical benefit in doing this (occasional
> > code improvement or better support for older or exotic compilers), I'd say
> > "ok go for it", but if it's only a matter of taste, I'm not convinced at
> > all and am rather seeing this as a regression. Now if there's rough
> > consensus around this approach I'll abide, but then I'd request that other
> > archs are adapted as well so that we don't keep a different approach only
> > for these two ones.
> 
> I don't see any technical benefit for x86-64, so I don't think there
> is a need in doing this. Though I personally prefer to use register
> constraints if they exist instead of register variables for everything
> (oh yeah, matter of taste since I don't have any technical argument to
> say it's better respecting the resulting codegen). The only real issue
> is for the syscall6() implementation on i386 as we've been bitten by a
> real compiler issue. In short, I am neutral on this change.

Just to be clear, I usually only use register constraints as well but I
changed this for the syscalls since they were not sufficient, and found
that the mix of the two was really not great to deal with.

Thanks,
Willy
