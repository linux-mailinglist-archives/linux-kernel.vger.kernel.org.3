Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB18C5A0F5D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238978AbiHYLf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241813AbiHYLf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:35:26 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A818FB0891
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 04:34:34 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id d1so15111018qvs.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 04:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=dqjoE029ZvFL7U2E4uqFs8h8zgLuCK5PNlmRfywX58k=;
        b=fg9Qio/ML3BXQTKdTI8VUXfiLtt55uwkZmKPwtm11zO3xnzhg0a8UrtL8pJXi70uvH
         a9154pTbCFtNAOIeACcVytIRJpR0UbkFmlFbotbE3gvI0a8Gv11xPnJsZJRvrAHOdvg1
         R47VY9xc1swlmOesnRo44Ux+jyBfbvInbqoOzAYx3xKKxibGeEKwcgemqaVXfeq3mmWl
         J9MyIB8hU1b6tKKqUBqNOLtOWqgcFFpln1R2H9VUXqMlwnB/lAHr6fUaBF4nYql/KFlH
         2qav11hKWlwH+s2kVRhFQBKsWi6ZUYRDTAEfbp4BIwHVeC7C21fv9fcOuUCSmAu/3wOv
         eu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=dqjoE029ZvFL7U2E4uqFs8h8zgLuCK5PNlmRfywX58k=;
        b=PL5mjlI8K36URgcDbiB/o23c70Q0IlfBJicgPBDBRZ9gQRc/I5G289mzOsClabsL1G
         RJg0ZemaiSNGHO8h+LMURTxOA+0KgcZhr+AcmQXwWGnIg8AUURI2mEFrBO2exlhDFW2l
         b8bYwICV78UTSmu5gvyWL3m1d/gInmpudXW4/M5dOmZJrTydt88+aw6aQNkIEfr+pkiN
         adhqmNtrkNzlgu2tSHiEzPWVWEJ+aUTfh1FmXvRzfaBJkSeuV/I0fEC5Dh7U26MovEgl
         Jhw6di8ylmgwDvVR4hqwNsyi4jyxvthy+muQqWySKKs2ALdMKtfDEXELLctfsO42jNAc
         1h2Q==
X-Gm-Message-State: ACgBeo0GeGC7Sv5P9jU+NGcYZWmXuns1zDmto8T2oQld8JOZ8VM+4wY9
        U1arhiOP2uL+ZcJbVJDHBD+HGBwCkBNBoDzsWUgVtkQ1zCk=
X-Google-Smtp-Source: AA6agR6/MRpSGWUTrYfzP1RnQ5Sqo0olutO6cmdBph6qdwoVLqO1RmUTIsI4ZaJOXo/6Qq8WfGjZkaSE7Qab2ghr2rc=
X-Received: by 2002:a0c:da87:0:b0:496:cc8f:c072 with SMTP id
 z7-20020a0cda87000000b00496cc8fc072mr3065884qvj.31.1661427273349; Thu, 25 Aug
 2022 04:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220624141412.72274-1-ubizjak@gmail.com> <1661422971.cqtahfm22j.naveen@linux.ibm.com>
In-Reply-To: <1661422971.cqtahfm22j.naveen@linux.ibm.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 25 Aug 2022 13:34:22 +0200
Message-ID: <CAFULd4Zh3Hw+hy-8YFxSNgmPpk4ahM=8ycRgF_fwqJ6AoaTcug@mail.gmail.com>
Subject: Re: [PATCH] compiler-gcc.h: Remove ancient workaround for gcc PR 58670
To:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, sv@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 12:30 PM Naveen N. Rao
<naveen.n.rao@linux.ibm.com> wrote:
>
> Uros Bizjak wrote:
> > The workaround for 'asm goto' miscompilation introduces a compiler
> > barrier quirk that inhibits many useful compiler optimizations. For
> > example, __try_cmpxchg_user compiles to:
> >
> >    11375:     41 8b 4d 00             mov    0x0(%r13),%ecx
> >    11379:     41 8b 02                mov    (%r10),%eax
> >    1137c:     f0 0f b1 0a             lock cmpxchg %ecx,(%rdx)
> >    11380:     0f 94 c2                sete   %dl
> >    11383:     84 d2                   test   %dl,%dl
> >    11385:     75 c4                   jne    1134b <...>
> >    11387:     41 89 02                mov    %eax,(%r10)
> >
> > where the barrier inhibits flags propagation from asm when
> > compiled with gcc-12.
> >
> > When the mentioned quirk is removed, the following code is generated:
> >
> >    11553:     41 8b 4d 00             mov    0x0(%r13),%ecx
> >    11557:     41 8b 02                mov    (%r10),%eax
> >    1155a:     f0 0f b1 0a             lock cmpxchg %ecx,(%rdx)
> >    1155e:     74 c9                   je     11529 <...>
> >    11560:     41 89 02                mov    %eax,(%r10)
> >
> > The refered compiler bug:
> >
> > http://gcc.gnu.org/bugzilla/show_bug.cgi?id=58670
> >
> > was fixed for gcc-4.8.2.
> >
> > Current minimum required version of GCC is version 5.1 which has
> > the above 'asm goto' miscompilation fixed, so remove the workaround.
> >
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >  include/linux/compiler-gcc.h | 11 -----------
> >  1 file changed, 11 deletions(-)
> >
> > diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> > index a0c55eeaeaf1..9b157b71036f 100644
> > --- a/include/linux/compiler-gcc.h
> > +++ b/include/linux/compiler-gcc.h
> > @@ -66,17 +66,6 @@
> >               __builtin_unreachable();        \
> >       } while (0)
> >
> > -/*
> > - * GCC 'asm goto' miscompiles certain code sequences:
> > - *
> > - *   http://gcc.gnu.org/bugzilla/show_bug.cgi?id=58670
> > - *
> > - * Work it around via a compiler barrier quirk suggested by Jakub Jelinek.
> > - *
> > - * (asm goto is automatically volatile - the naming reflects this.)
> > - */
> > -#define asm_volatile_goto(x...)      do { asm goto(x); asm (""); } while (0)
> > -
> >  #if defined(CONFIG_ARCH_USE_BUILTIN_BSWAP)
> >  #define __HAVE_BUILTIN_BSWAP32__
> >  #define __HAVE_BUILTIN_BSWAP64__
>
> This is causing a build issue on ppc64le with a new patch replacing use
> of unreachable() with __builtin_unreachable() in __WARN_FLAGS():
> https://lore.kernel.org/linuxppc-dev/20220808114908.240813-2-sv@linux.ibm.com/
>
> during RTL pass: combine
> In file included from /linux/kernel/locking/rtmutex_api.c:9:
> /linux/kernel/locking/rtmutex.c: In function '__rt_mutex_slowlock.constprop':
> /linux/kernel/locking/rtmutex.c:1612:1: internal compiler error: in purge_dead_edges, at cfgrtl.c:3369
>  1612 | }
>       | ^
> 0x142817c internal_error(char const*, ...)
>         ???:0
> 0x5c8a1b fancy_abort(char const*, int, char const*)
>         ???:0
> 0x72017f purge_all_dead_edges()
>         ???:0
> Please submit a full bug report,
> with preprocessed source if appropriate.
> Please include the complete backtrace with any bug report.
> See <file:///usr/share/doc/gcc-11/README.Bugs> for instructions.
>
>
> So, it looks like gcc still has issues with certain uses of asm goto.

This looks like a powerpc specific bug, and has nothing to do with
PR58560 (asm goto miscompilation). If this is indeed a target specific
bug, it should be worked around in
arch/powerpc/include/asm/compiler.h, but please also report it to the
GCC bugzilla.

Uros.
