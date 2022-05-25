Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD49534181
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242564AbiEYQ3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 12:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbiEYQ3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:29:51 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC9E95DDF
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:29:50 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id t5so4344073edc.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zv7CMfWyVCeGJGAj4LmbRjRR88GIqcNO1qMyqUcwrJc=;
        b=XRvdZ7oIeM697v/DIweNy1GCsnCrvtjzsb5VJl4XkjJ4LO+eUeOeHWhEdnWYB7jB0L
         a/dV+pTQLPhtrhp6yhqIcyoWGILdfNKhEGevrPdMsJVZHvqGEXTtn7FzWxGVf0lTnv18
         LYCvTUbazb/F9OVZldwhEK1xBt8yE5lHPESG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zv7CMfWyVCeGJGAj4LmbRjRR88GIqcNO1qMyqUcwrJc=;
        b=FZ5lbX3wlbQaJlF5JtXcBJO2UMCvY3cvxXH6yvZEPdaeKsPk5PNosdsF2PzqqNJhV8
         pGQ8vh8Kw6XOKGdyQe3PpQ1NErgjLg4B9VittflQ+xnCe8rX8F97Yu0dkPG2mnnl84eH
         QBLv2uh8PU+5KgtOgkPG0ReOYSITuZjQEoUA4j9HyM+/cTzCyVxstaKpuVtR+KPo9GZY
         8YzUkZhrwAXvlfBm8MGVqLA99YqW0fNG5AFqRIeFb2lmA7tunXhWblH+i3DsMRKtYmyo
         MZFgzpCkgaMB+lhbbusYyeoZn9J8F3Wv0jf8CKaWOr4rTox/fqB3eaDm4y7MKwoZGba1
         rDZQ==
X-Gm-Message-State: AOAM530+vsNIPHqbG/Zhub5ozEbRPvIGCNh3DhtqTT5XyKOwO92r/qwn
        nkbZp1Xrr4PLtRgHtlxJuI9pGaBid+diQD8x
X-Google-Smtp-Source: ABdhPJx2YPaJ80ooht2II5PM1Az3WrfkY+xc4w3fLikjRW+/VWRzZwWx2/39Z7HOSxThyockliCSJg==
X-Received: by 2002:a05:6402:388d:b0:42a:ba9f:f85c with SMTP id fd13-20020a056402388d00b0042aba9ff85cmr35876760edb.292.1653496188485;
        Wed, 25 May 2022 09:29:48 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id pk14-20020a170906d7ae00b006fed3fdf421sm3697512ejb.139.2022.05.25.09.29.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 09:29:47 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id p19so4333736wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:29:46 -0700 (PDT)
X-Received: by 2002:a1c:7207:0:b0:397:66ee:9d71 with SMTP id
 n7-20020a1c7207000000b0039766ee9d71mr5193830wmc.8.1653496186288; Wed, 25 May
 2022 09:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220525144013.6481-1-ubizjak@gmail.com> <20220525144013.6481-3-ubizjak@gmail.com>
In-Reply-To: <20220525144013.6481-3-ubizjak@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 May 2022 09:29:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXtP1XT2cVDFKK2-Xz5Z=7AFki4zwFzenm4bbf4iPJKg@mail.gmail.com>
Message-ID: <CAHk-=whXtP1XT2cVDFKK2-Xz5Z=7AFki4zwFzenm4bbf4iPJKg@mail.gmail.com>
Subject: Re: [PATCH 2/2] locking/lockref/x86: Enable ARCH_USE_CMPXCHG_LOCKREF
 for X86_32 && X86_CMPXCHG64
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Waiman.Long@hp.com,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 7:40 AM Uros Bizjak <ubizjak@gmail.com> wrote:
>
> +       select ARCH_USE_CMPXCHG_LOCKREF if X86_64 || (X86_32 && X86_CMPXCHG64)

Ugh. That looks pointlessly complicated. X86_64 already enables
X86_CMPXCHG64 afaik, so you can just say

        select ARCH_USE_CMPXCHG_LOCKREF if X86_CMPXCHG64

which is much clearer: CMPXCHG_LOCKREF needs CMPXCHG64, and the
Kconfig option says exactly that.

That said, this also makes me wonder if we should just make cmpxchg8b
requirement unconditional.

Googling around, it looks like Windows NT stopped booting on CPUs
without cmpxchg8b in version 5.1. That was in 2001.

Here we are, 21 years later, and we still ostensibly try to support
CPUs without it, but I doubt it's worth it.

So maybe time to just say "we require cmpxchg8b".

In fact, I think we have effectively done that already for years, since we have

    config X86_CMPXCHG64
            def_bool y
            depends on X86_PAE || ...

iow, enabling X86_PAE will force-enable CMPXCHG8B due to the wider
page table entries.

And I would assume that all distros basically do that anyway (but I do
not have a 32-bit distro around to check).

It would mean that we would finally drop support for i486 (and
possibly some Pentium clones, but afaik a number of them did actually
support cmpxchg8b even if they didn't report it in cpuid).

Comments?

                 Linus
