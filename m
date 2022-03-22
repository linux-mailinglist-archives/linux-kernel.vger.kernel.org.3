Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940F64E3E6A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbiCVMXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbiCVMX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:23:29 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8828985671
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 05:22:02 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22MCLqxg010791;
        Tue, 22 Mar 2022 13:21:52 +0100
Date:   Tue, 22 Mar 2022 13:21:52 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "'Ammar Faizi'" <ammarfaizi2@gnuweeb.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: Re: [RFC PATCH v2 6/8] tools/nolibc/stdlib: Implement `malloc()`,
 `calloc()`, `realloc()` and `free()`
Message-ID: <20220322122152.GE10306@1wt.eu>
References: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
 <20220322102115.186179-7-ammarfaizi2@gnuweeb.org>
 <56935393241242adab6f32c50dd74c23@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56935393241242adab6f32c50dd74c23@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 11:52:43AM +0000, David Laight wrote:
> > +struct nolibc_heap {
> > +	size_t	len;
> > +	char	user_p[] __attribute__((__aligned__));
> 
> Doesn't that need (number) in the attribute?

That was my question in the previous review but Ammar pointed me to
the doc indicating that without value it's "large enough for any type"
(i.e. the usual double-long stuff). So that's fine.

> > +static __attribute__((unused))
> > +void *malloc(size_t len)
> > +{
> > +	struct nolibc_heap *heap;
> 
> If you do (say):
> 	len = ROUNDUP(len + sizeof *heap, 4096)
> you can optimise a lot of the realloc() calls.

Could be, but do we *really* care ? Again, I didn't even intend to
implement dynamic allocation at all for the targetted use cases.

> I actually wonder if compiling a mini-libc.a
> and then linking the programs against it might
> be better than all these static functions?
> -ffunction-sections can help a bit (where supported).

That was really not the intent when I started this project this
a few years ago. Instead the purpose precisely was *not* to have
to depend on any pre-compiled stuff and it seems a few of us find
this lack of dependency convenient. Right now using bare-metal
compilers from kernel.org/pub/tools/crosstool works out of the
box and is very convenient for testing and for pre-init stuff; if
the compiler can build the kernel, it can also build your userland
code.

Willy
