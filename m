Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54860577812
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 22:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiGQUB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 16:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGQUBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 16:01:23 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 997E51208E;
        Sun, 17 Jul 2022 13:01:22 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 26HJsmgu016415;
        Sun, 17 Jul 2022 14:54:48 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 26HJsmPs016414;
        Sun, 17 Jul 2022 14:54:48 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sun, 17 Jul 2022 14:54:48 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-hardening@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: mainline build failure of powerpc allmodconfig for prom_init_check
Message-ID: <20220717195448.GB25951@gate.crashing.org>
References: <Ys/aDKZNhhsENH9S@debian> <CADVatmO9XzFnX+N0TuOtr0FYyxKr1oe5RAhCEJjmnvjteT5QNw@mail.gmail.com> <CAHk-=whc3Uvhrmrr27xp5=oOhSDjXc5s1ZxC3B7xMYV6oj4WRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whc3Uvhrmrr27xp5=oOhSDjXc5s1ZxC3B7xMYV6oj4WRQ@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 07:44:22AM -0700, Linus Torvalds wrote:
> On Sun, Jul 17, 2022 at 2:13 AM Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> > I was trying to check it. With gcc-11 the assembly code generated is
> > not using memset, but using __memset.
> > But with gcc-12, I can see the assembly code is using memset. One
> > example from the assembly:
> 
> You could try making the 'args' array in 'struct prom_args' be marked
> 'volatile'.
> 
> Ie something like this:
> 
>   --- a/arch/powerpc/kernel/prom_init.c
>   +++ b/arch/powerpc/kernel/prom_init.c
>   @@ -115,6 +115,6 @@ struct prom_args {
>            __be32 service;
>            __be32 nargs;
>            __be32 nret;
>   -          __be32 args[10];
>   +        volatile __be32 args[10];
>    };
> 
> because I think it's just the compilers turning the small loop over
> those fields into a "memset()".

Yes.  See <https://gcc.gnu.org/onlinedocs/gcc/Standards.html#C-Language>
near the end:
  Most of the compiler support routines used by GCC are present in
  libgcc, but there are a few exceptions. GCC requires the freestanding
  environment provide memcpy, memmove, memset and memcmp. Finally, if
  __builtin_trap is used, and the target does not implement the trap
  pattern, then GCC emits a call to abort.

Can't we simply have a small simple implementation of these functions in
arch/powerpc/boot/?  This stuff is not performance-critical, and this is
not the first time we hit these problems.


Segher
