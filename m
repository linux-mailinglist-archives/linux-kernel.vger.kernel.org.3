Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A954E4522
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238322AbiCVR1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239670AbiCVR1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:27:45 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F106952E1A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:26:06 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22MHPomx011663;
        Tue, 22 Mar 2022 18:25:50 +0100
Date:   Tue, 22 Mar 2022 18:25:50 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        llvm@lists.linux.dev
Subject: Re: [RFC PATCH v2 2/8] tools/nolibc: Remove .global _start from the
 entry point code
Message-ID: <20220322172550.GL10306@1wt.eu>
References: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
 <20220322102115.186179-3-ammarfaizi2@gnuweeb.org>
 <CAKwvOdkEwkzT0uf9a5SokCScDTY4gbhNFZ+fLxsti9innaEZRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkEwkzT0uf9a5SokCScDTY4gbhNFZ+fLxsti9innaEZRQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Tue, Mar 22, 2022 at 10:09:18AM -0700, Nick Desaulniers wrote:
> On Tue, Mar 22, 2022 at 3:21 AM Ammar Faizi <ammarfaizi2@gnuweeb.org> wrote:
> >
> > Building with clang yields the following error:
> > ```
> >   <inline asm>:3:1: error: _start changed binding to STB_GLOBAL
> >   .global _start
> >   ^
> >   1 error generated.
> > ```
> > Make sure only specify one between `.global _start` and `.weak _start`.
> > Removing `.global _start`.
> 
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> Yes, symbols should either be `.weak` or `.global`. The warning from
> Clang's integrated assembler is meant to flush out funny business.
> 
> I assume there's a good reason _why_ _start is weak and not strong?

Yes, the issue appears when you start to build programs made of more than
one C file. That's why we have a few weak symbols here and there (others
like errno are static and the lack of inter-unit portability is assumed).

> Then again, I'm not familiar with nolibc.

No problem. The purpose is clearly *not* to implement a libc, but to have
something very lightweight that allows to compile trivial programs. A good
example of this is tools/testing/selftests/rcutorture/bin/mkinitrd.sh. I'm
personally using a tiny pre-init shell that I always package with my
kernels and that builds with them [1]. It will never do big things but
the balance between ease of use and coding effort is pretty good in my
experience. And I'm also careful not to make it complicated to use nor
to maintain, pragmatism is important and the effort should remain on the
program developer if some arbitration is needed.

Regards,
Willy

[1] https://github.com/formilux/flxutils/tree/master/init
