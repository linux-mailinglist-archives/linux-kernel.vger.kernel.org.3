Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3997F4E3D87
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 12:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbiCVL0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 07:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbiCVLZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:25:59 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54DE024592
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 04:24:31 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22MBNx61010599;
        Tue, 22 Mar 2022 12:23:59 +0100
Date:   Tue, 22 Mar 2022 12:23:59 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     David Laight <David.Laight@ACULAB.COM>
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
Message-ID: <20220322112359.GB10306@1wt.eu>
References: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
 <20220322102115.186179-4-ammarfaizi2@gnuweeb.org>
 <35ec31089f724a74a584f946deac6248@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35ec31089f724a74a584f946deac6248@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 10:57:01AM +0000, David Laight wrote:
> From: Ammar Faizi
> > Sent: 22 March 2022 10:21
> > 
> > On i386, the 6th argument of syscall goes in %ebp. However, both Clang
> > and GCC cannot use %ebp in the clobber list and in the "r" constraint
> > without using -fomit-frame-pointer. To make it always available for
> > any kind of compilation, the below workaround is implemented.
> > 
> > For clang (the Assembly statement can't clobber %ebp):
> >   1) Push the 6-th argument.
> >   2) Push %ebp.
> >   3) Load the 6-th argument from 4(%esp) to %ebp.
> >   4) Do the syscall (int $0x80).
> >   5) Pop %ebp (restore the old value of %ebp).
> >   6) Add %esp by 4 (undo the stack pointer).
> > 
> > For GCC, fortunately it has a #pragma that can force a specific function
> > to be compiled with -fomit-frame-pointer, so it can use "r"(var) where
> > var is a variable bound to %ebp.
> 
> You need to use the 'clang' pattern for gcc.
> #pragma optimise is fundamentally broken.
> What actually happens here is the 'inline' gets lost
> (because of the implied -O0) and you get far worse code
> than you might expect.
> 
> Since you need the 'clang' version, use it all the time.

I clearly prefer it as well, it looks much cleaner!

Willy
