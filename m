Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D93A531D54
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 23:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiEWVEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 17:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiEWVEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 17:04:52 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3811E72225
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 14:04:50 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 24NL4h5j027319;
        Mon, 23 May 2022 23:04:43 +0200
Date:   Mon, 23 May 2022 23:04:43 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [GIT PULL] nolibc changes for v5.19
Message-ID: <20220523210443.GD25949@1wt.eu>
References: <20220520182428.GA3791250@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wgpAHhPVSqBWb4gYT=CRJzKAZ4inmrL_kcpeNWGkcg3pg@mail.gmail.com>
 <20220523195605.GA13032@1wt.eu>
 <20220523202336.GB13032@1wt.eu>
 <CAHk-=wiX8P8atcx9at_N=-8pjU-d5cG509E=oZHfsVb1R41RZQ@mail.gmail.com>
 <20220523205043.GA25949@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523205043.GA25949@1wt.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 10:50:43PM +0200, Willy Tarreau wrote:
> On Mon, May 23, 2022 at 01:30:37PM -0700, Linus Torvalds wrote:
> > On Mon, May 23, 2022 at 1:23 PM Willy Tarreau <w@1wt.eu> wrote:
> > >
> > > So I've figured it again. When you run:
> > >
> > >    make tools/help
> > >
> > > you get the help of tools/ commands, [..]
> > 
> > You speak the words, but you don't actually look at what it does.
> > 
> > Try it.
> 
> Why are you saying this ? I've figured the commands by trying
> each of them.

I think I found it:

   make -C tools/ <tool>_<command>

and:

   make tools/<tool>_<command>

work the same on all commands but actually:

   make -C tools/ nolibc_headers

fails while:

   make tools/nolibc_headers

works. I've essentially used the latter by simplicity without noticing
that it doesn't work as suggested with <tool>_install, and I guess
that's what you got.

I'll check why it's like this and will propose a fix.

Thanks,
Willy
