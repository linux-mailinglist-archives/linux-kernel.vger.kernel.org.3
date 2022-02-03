Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C8A4A7CDF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 01:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240733AbiBCA2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 19:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiBCA2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 19:28:36 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D28C061714;
        Wed,  2 Feb 2022 16:28:35 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id s18so1189975ioa.12;
        Wed, 02 Feb 2022 16:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jdtk8UC2KDvFAfWxVTu60U5ncTIHp4dRqG8Pp1F6Se0=;
        b=pna34lSVqp/u41It8n/Fo5fhhDVwanvK/Lo9P1ktvW5tmybhz5Hr5o7fyaM83d3wqh
         6/vKbCy5lg6nx9v2EEURDMxfmtVlnL0z3InQlFacvthbuxIeh/KXnCwBzwbIA00e0ZHi
         rUHvG9B2ITbJCis8Hb9pmf0XSVgNoG9E91nKsmxfWeosHA0KpVCkNm+zWoINipET2kBl
         cmgBPyjgRSK+SNrs9vrM7/6SjEehdwwiAdt/lqUskoZxK5PtCCZMUz1q1IxoLXwKiqs3
         GgIbUzktGkF5/ZMKQsTqaSCBgbpQBbV58T69Z8VlbAb2q+RBLoKBTA8nKgimp6E97Wh7
         dVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jdtk8UC2KDvFAfWxVTu60U5ncTIHp4dRqG8Pp1F6Se0=;
        b=hFpyS7vNS/LXosEFMGM67vxnnzH4wUmesAigbzghLre9G7AIolVzuyV6zUivrq7rwX
         4EUc6nThaRyPkQFExcXVSHdMUGg1Yi8xmOzsQUXV7ZhBuIxFRpCNF/RVGoKVZjmHHp7s
         k1XfCiq+wfmL+4+NJdDgxjahAEDnBVr8uIoNkSRGduEFCQoF2aXE/eBD0Afc0tWmfTbV
         icSxU83WUlCM7isKf+bLXYvny10JaYsrrJOWodaVzE0dIszDIJeV5JOK1JA7YzyzavLp
         Z7VvQj8+cd+3kDSalMJFCDl00KQf0Ee7YmCmuKpMfhaCYG1TfhOY/WcfONYwVLI6X77C
         iVLw==
X-Gm-Message-State: AOAM532ze2SgWZojGVNuKVt7CVNuVjbzAwMzt8R3GVn3rhcbao2M3WVp
        mSVAZJxSU4lVP7MntBwW92CGkFvfbUCltJi42ro=
X-Google-Smtp-Source: ABdhPJxUvqr9og1U18lvfIf6cbS9/L/voRkEv9GAQUq+kRmHVEcMZPDe6S6csVaamV5zAeoL1fe1XCurvR9XKJDXLGk=
X-Received: by 2002:a6b:ea08:: with SMTP id m8mr17362901ioc.172.1643848115331;
 Wed, 02 Feb 2022 16:28:35 -0800 (PST)
MIME-Version: 1.0
References: <20220131204357.1133674-1-keescook@chromium.org>
 <6641e01b86374ce197020d57c65ae3b3@AcuMS.aculab.com> <311c9ca5-e2d4-22fb-0299-d47f84470677@prevas.dk>
 <91f0956687b341a9861f467aafe6dc4d@AcuMS.aculab.com>
In-Reply-To: <91f0956687b341a9861f467aafe6dc4d@AcuMS.aculab.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 3 Feb 2022 01:28:24 +0100
Message-ID: <CANiq72nkwKVGODWn1Ri_he+MOzp=Cw_L+3+2TX0UP_3=K0n5pA@mail.gmail.com>
Subject: Re: [PATCH] linux/const.h: Explain how __is_constexpr() works
To:     David Laight <David.Laight@aculab.com>
Cc:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
        Ingo Molnar <mingo@kernel.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 11:42 PM David Laight <David.Laight@aculab.com> wrote:
>
> The compiler needs to find a 'compatible type' either for:
>         (void *)x       and     (int *)8
> or for:
>         (void *)0       and     (int *)8
>
> In the former it is 'void *' and the latter 'int *' because the (void *)0
> is NULL and thus a valid 'int *' pointer.

I think you are trying to come up with an explanation of how it works
based on compiler outputs (it makes sense to think that the compiler
has to find some reasonable "common" type). But the conditional
operator works case-by-case, slightly differently depending on what
kind of operands you give.

In the two cases involved, there is no "finding a compatible type" /
promotions going on -- the standard gives explicitly that it is a
pointer to void (former case), and the type of the other operand
(latter case). The value is still decided by the condition.

e.g. https://godbolt.org/z/zzE8dc7Ye

0 ?          void pointer (1) : pointer to object type (42) = (void *) 0x2a
1 ?          void pointer (1) : pointer to object type (42) = (void *) 0x1
0 ? null pointer constant (0) : pointer                (42) = ( int *) 0x2a
1 ? null pointer constant (0) : pointer                (42) = ( int *) (nil)

> In any case suggesting that it is based on the value before the ? is bogus.

What Rasmus was saying is that which value is selected still depends
on the condition, because the last paragraph of the explanation in the
commit is wrong. It should be something like:

  - The ultimate comparison to "sizeof(int)" reduces to either:
        sizeof(int) == sizeof(*(int *)0)  (x was a constant expression)
        sizeof(int) == sizeof(*(void *)0) (x was not a constant expression)

Cheers,
Miguel
