Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A046D54BCFD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358176AbiFNVtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358083AbiFNVtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:49:14 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67D74515BA;
        Tue, 14 Jun 2022 14:49:13 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 25ELeePu014655;
        Tue, 14 Jun 2022 16:40:40 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 25ELeePL014654;
        Tue, 14 Jun 2022 16:40:40 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 14 Jun 2022 16:40:39 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Buka <vitalybuka@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Subject: Re: [PATCH] [RFC] Initialization of unused function parameters
Message-ID: <20220614214039.GA25951@gate.crashing.org>
References: <20220614144853.3693273-1-glider@google.com> <CAHk-=whaWnwB8guceg8V=bA1adv74GNaMk2FEu+YQkBKUqxVoA@mail.gmail.com> <CAG_fn=WEed5NJ8hdrrP_N8aQ_1Ad11VoJgdVxQheo3VfT_xyXQ@mail.gmail.com> <CAHk-=whjz3wO8zD+itoerphWem+JZz4uS3myf6u1Wd6epGRgmQ@mail.gmail.com> <CAG_fn=UPoM3bafwu6inGPMjg1bPw3HSFM_KrE_hen_MN3fu2vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=UPoM3bafwu6inGPMjg1bPw3HSFM_KrE_hen_MN3fu2vA@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue, Jun 14, 2022 at 10:19:53PM +0200, Alexander Potapenko wrote:
> ================
> char *kmalloc(int size);
> 
> char *kmalloc_or_not(int flag, int size, char *p) {
>   if (flag)
>     return kmalloc(size);
>   else
>     return p;
> }
> 
> char global[16];
> 
> char *p(int flag) {
>   char *c;
>   int size;
>   if (flag)
>     return kmalloc_or_not(1, 4, c);
>   else
>     return kmalloc_or_not(0, size, global);
> }
> ================

Since C11, lvalue conversion of an automatic variable that does not have
its address taken is explicitly undefined behaviour (6.3.2.1/2).  So in
function "p", both where "c" and where "size" are passed causes UB (so
that executing "p" always causes UB btw).

> In this example `size` is passed into kmalloc_or_not() initialized,
> however it is never used, so the code probably has defined behavior.

No such luck: the passing itself already causes UB.

GCC does not warn, it has already optimised the code to what you expect
by the time this warning is done.  If you use -fno-inline it does warn
for both "c" and "size" (via -Wmaybe-uninitialized).

But it is still UB!  All bets are off, no compiler can do any correct
translation of your program, since there *is none*.


Segher
