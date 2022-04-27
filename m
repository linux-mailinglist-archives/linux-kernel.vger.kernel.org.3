Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2BE511B6C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbiD0OHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236817AbiD0OHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:07:33 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C1249FA4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:04:21 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id k12so1103039qvc.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LjQKVytm/xCXHpyQGfg/kRRHlpZIrxA9mlpFOjG1W5A=;
        b=L2ks9x6opAWkip0omwIpFRnabs3PeH6D7A2PkDG1wx6ynBu8hULjI+oD6/UxBoUbgr
         oKaX3UKxijBHUjLwYKazD6tNbcKmZfxFStyHpS7s8hjPkXGCOEBDhmT2rDEDJ2QeNQV1
         HEHDxo7RHuAbTXs5aZLt99ZG+HoklzrLw9oEZNnFHEzfbaHELWty6k5zd2q66g40hseL
         4/XvSJesBO5UQw04IsXkwBTtL+HsbGTM3LNv3Wk/92IQd0c1bcm0OXQCnV1OeLFww9c1
         XfHmIHwBHI3OJgaVhGPRfKMUe/UIlVcMJ3IbasHCk4LKCTgiIlbarWV0l789ppuetTHp
         HjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LjQKVytm/xCXHpyQGfg/kRRHlpZIrxA9mlpFOjG1W5A=;
        b=WNl5SZJhswxzshZsXREXKSDfhoX8OUM/hb1BnjO28TniLfaK0LZix+HOP7uyw7tkxI
         tlJpgEBOmyOvfJLyhd8dn2LA+qiN0jhSIvkXib9HoQz99OhRNR8dIwTZMfZNXqpr3TgY
         BjY0Qr5VKLBr0ApTvCEVgZD/qzJNrsDiLnLcq4mwRPDcpoy/I+1gcB2lbtz8tzmdGyYo
         kH8FUbuHrhuhIoI7Z4aJLHXfYAJ0hYJAiTr3z0N7Hzs//D0Qt8gUJJ36i4uz+PTJVo05
         1GDf6u+8wVn4wXPPXkhuwVy+ueuUaeJti/Zimo2yHzdEUXSht/ihKuv72jRvQSQsJASk
         4oog==
X-Gm-Message-State: AOAM5339Tb30yb1QmxoTxUg7BtYPSZo6O3tPXJBg2yk4VFNF6pqvm9L/
        iJCPBw8sFfNvj7FexuxXC/Y=
X-Google-Smtp-Source: ABdhPJypDO9eXvH8yce11aUJEQGS4cr5LpYoYj3SvzVJ0x+cGllwwTp0+UbyMKAb93m78a5eHVvD8g==
X-Received: by 2002:ad4:5504:0:b0:456:35e0:1968 with SMTP id az4-20020ad45504000000b0045635e01968mr11224127qvb.126.1651068260539;
        Wed, 27 Apr 2022 07:04:20 -0700 (PDT)
Received: from localhost ([2601:c4:c432:813:8ecb:cb1e:b8e0:947])
        by smtp.gmail.com with ESMTPSA id d134-20020a37688c000000b0069f7bc789cesm2331574qkc.24.2022.04.27.07.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 07:04:20 -0700 (PDT)
Date:   Wed, 27 Apr 2022 07:04:18 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, gcc@gcc.gnu.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>
Subject: Re: [PATCH] linux/find: ignore -Wtype-limits to reduce W=2 warnings
 by 34% tree-wide
Message-ID: <YmlNYt0qVgVPz1+2@yury-laptop>
References: <20220426161658.437466-1-mailhol.vincent@wanadoo.fr>
 <YmhZSZWg9YZZLRHA@yury-laptop>
 <CAMZ6RqJuUPuEJQvyHZr0Gxzh9ZZ2iACTHe3XE70jZ38hmePfuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMZ6RqJuUPuEJQvyHZr0Gxzh9ZZ2iACTHe3XE70jZ38hmePfuA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 11:58:58AM +0900, Vincent MAILHOL wrote:
> + Alexander Lobakin <alexandr.lobakin@intel.com>
> 
> On Wed. 27 Apr 2022 at 05:42, Yury Norov <yury.norov@gmail.com> wrote:
> > + gcc@gcc.gnu.org
> > + Rikard Falkeborn <rikard.falkeborn@gmail.com>
> >
> > On Wed, Apr 27, 2022 at 01:16:58AM +0900, Vincent Mailhol wrote:
> > > find_first_bit(), find_first_and_bit(), find_first_and_bit() and
> > > find_first_and_bit() all invokes GENMASK(size - 1, 0).
> > >
> > > This triggers below warning when compiled with W=2.
> > >
> > > | ./include/linux/find.h: In function 'find_first_bit':
> > > | ./include/linux/bits.h:25:36: warning: comparison of unsigned
> > > | expression in '< 0' is always false [-Wtype-limits]
> > > |    25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
> > > |       |                                    ^
> > > | ./include/linux/build_bug.h:16:62: note: in definition of macro
> > > | 'BUILD_BUG_ON_ZERO'
> > > |    16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> > > |       |                                                              ^
> > > | ./include/linux/bits.h:25:17: note: in expansion of macro '__is_constexpr'
> > > |    25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
> > > |       |                 ^~~~~~~~~~~~~~
> > > | ./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> > > |    38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> > > |       |          ^~~~~~~~~~~~~~~~~~~
> > > | ./include/linux/find.h:119:45: note: in expansion of macro 'GENMASK'
> > > |   119 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
> > > |       |                                             ^~~~~~~
> > >
> > > linux/find.h being a widely used header file, above warning show up in
> > > thousand of files which include this header (either directly on
> > > indirectly).
> > >
> > > Because it is a false positive, we just silence -Wtype-limits flag
> > > locally to remove the spam. clang does not warn about it, so we just
> > > apply the diag_ignore() directive to gcc.
> > >
> > > By doing so, the warnings for a W=2 build are reduced by
> > > 34%. Benchmark was done with gcc 11.2.1 on Linux v5.17 x86_64
> > > allyesconfig (except CONFIG_WERROR). Beforethe patch: 515496 warnings
> > > and after: 340097.
> > >
> > > For reference, past proposal to modify GENMASK_INPUT_CHECK() was
> > > rejected in:
> > > https://lore.kernel.org/all/20220304124416.1181029-1-mailhol.vincent@wanadoo.fr/
> >
> > So, here is nothing wrong with the kernel code and we have an alternative
> > compiler (clang) that doesn't throw Wtype-limits. It sounds to me like an
> > internal GCC problem, and I don't understand how hiding broken Wtype-limits
> > on kernel side would help people to improve GCC.
> >
> > On the thread you mentioned above:
> >
> > > > > > Have you fixed W=1 warnings?
> > > > > > Without fixing W=1 (which makes much more sense, when used with
> > > > > > WERROR=y && COMPILE_TEST=y) this has no value.
> > > > >
> > > > > How is this connected?
> > > >
> > > > By priorities.
> > > > I don't see much value in fixing W=2 per se if the code doesn't compile for W=1.
> > >
> > > *My code* compiles for W=1. For me, fixing this W=2 in the next in line
> > > if speaking of priorities.
> > >
> > > I do not understand why I should be forbidden to fix a W=2 in the
> > > file which I am maintaining on the grounds that some code to which
> > > I do not care still has some W=1.
> >
> > If you are concerned about a particular driver - why don't you silence
> > the warning in there? Or alternatively build it with clang?
> 
> Sorry if my previous comments looked selfish. I used the first
> person to illustrate my point but because this W=2 appears in
> thousands of files my real intent is to fix it for everybody, not
> only for myself.

Globally, we have not yet fixed W=1, that's why W=2 isn't that important.
(If the above statement is wrong - can someone explain me the logic of
splitting warnings by levels?)

Locally you cleared W=1, which is great, and I understand that you'd 
like to have clean W=2 too.
 
> > With all that, I think that the right way to go is to fix the root
> > cause of this churn - broken Wtype-limits in GCC, and after that move
> > Wtype-limits to W=1. Anything else looks hacky to me.
> 
> Why is this use of __diag_ignore() hacky compared when compared
> to the other use of __diag_ignore() or the use of -Wno-something
> in local Makefiles?

__diag_ignore() is not hacky when it's well-justified. Globally
there's a single user of __diag_ignore() - SYSCALL_DEFINE, and
it looks well-justified to me:
    The new warning seems reasonable in principle, but it doesn't
    help us here, since we rely on the type mismatch to sanitize the
    system call arguments. After I reported this as GCC PR82435, a new
    -Wno-attribute-alias option was added that could be used to turn the
    warning off globally on the command line, but I'd prefer to do it a
    little more fine-grained.

Locally, there are just 3 users of the macro in the codebase. All
they appeal to local issues, i.e. don't shut up warnings because
they are broken.

In case of Wtype-limits, the proposed solution is hacky because it
silences broken warning instead of fixing compiler.

> I did my due diligence and researched GCC’s buzilla before
> sending this patch. There is an opened ticket here:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=86647
> 
> In a perfect word, yes, all false positives should be fixed in
> the compiler, but the reality is that this bug was reported in
> July 2018, nearly four years ago. GCC developers have their own
> priorities and fixing this bug does not appear to be part of
> those. And I do not have the knowledge of GCC's internals to fix
> this myself.  So what do we do next, blame GCC and do nothing or
> silence it on our side in order to have a mininfull W=2 output?

1. Yes, do blame GCC and disable Wtype-limits locally where W=1
   is clean.
2. Use clang.
3. Move Wtype-limits to W=3.
4. Test Wtype-limits in Makefile, and enable it if not broken.

My main objection is that this patch puts dirt in *my* selfish area
of responsibility. The code that causes issues is GENMASK_INPUT_CHECK,
but the suggested patch modifies find.h - an innocent random user.

The argument that we need to silence find_bit because it clears 34%
of warnings doesn't work for me. Instead, we'd push GCC community
to provide proper fix and clear 34% of warnings.

Thanks,
Yury
