Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8495B54E687
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378086AbiFPQAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377806AbiFPQAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:00:12 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744B443486
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:00:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id d14so2786939eda.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BJ2jAaiEzLNQ93crLBAe3sDvH4iCO/x2lZ+zRlgdV/4=;
        b=cxj6vejdZIrdWg7i57fno7dIoPvsbKilzHyEXWvFkAoBv9r+QoFdy7bpOwZp2Ylk3B
         pfE/wp7Kfj88bh8j/WDUFirzzoX10qWcVrp+aqFo0r03zBUiPzkWhr4H7OcxpoTJRrbK
         rSMSCgfc1ly2bqQk3lU50OAV7bXFWH86uHjt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BJ2jAaiEzLNQ93crLBAe3sDvH4iCO/x2lZ+zRlgdV/4=;
        b=IO9ew9bxjYZ8Jr+lHMDtjo+vmzljDYydBOKcp+uDCXYn/t5j+mo5MurMPqGGXjLgan
         KMFd7IgPy+Qxap4gD+Uc31Mu+SVsF4Lb5AUjWSKQyUzJnqn13FMqnGC8ztThrbRGH3t+
         dlIV8dJIWgI8a4hTGMUHNgfB6xzb046IgPIl+JcV6/Y0MGuTFic8Wvy7qKDcqdvnmioV
         rhpF/ROFdATTujWWc95sKmUy2SDetAt5B/reeOJLKdKJD+s4bMa/Xb0sYJiqhxiAly1A
         yCJ+v7hyho0MzccufO3t/fdbhEzxuhj6y66haqyyAKNyBGGuLrEGklTKkc0EIYZbluCU
         2sYA==
X-Gm-Message-State: AJIora/0P5fALIUi2g3I/ooRJJYPg95+0D3nxephLcplCj/C/1bq9lzm
        i44RAspwPiqKsL29++rNKyy117h/MgpLZTfM3qI=
X-Google-Smtp-Source: AGRyM1vIVFQEYEryzeT+Fdzkg8lrScGzcAxW+JfxjxlqKoDh6TTjQooYqE8S7iQnMjBCTJ/LOQ75Eg==
X-Received: by 2002:a05:6402:35c4:b0:42f:b0f8:6a69 with SMTP id z4-20020a05640235c400b0042fb0f86a69mr7420567edc.180.1655395209591;
        Thu, 16 Jun 2022 09:00:09 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id sb8-20020a1709076d8800b007094f98788csm943446ejc.113.2022.06.16.09.00.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 09:00:08 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id o8so2466006wro.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:00:08 -0700 (PDT)
X-Received: by 2002:a5d:47aa:0:b0:218:5ac8:f3a8 with SMTP id
 10-20020a5d47aa000000b002185ac8f3a8mr5432558wrb.442.1655395207618; Thu, 16
 Jun 2022 09:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220616143617.449094-1-Jason@zx2c4.com> <YqtAShjjo1zC6EgO@casper.infradead.org>
 <YqtDXPWdFQ/fqgDo@zx2c4.com> <YqtKjAZRPBVjlE8S@casper.infradead.org>
In-Reply-To: <YqtKjAZRPBVjlE8S@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Jun 2022 08:59:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2OHy-5e+srG1fy+ZU00TmZ1NFp6kFLbVLMXHe7A1d-g@mail.gmail.com>
Message-ID: <CAHk-=wj2OHy-5e+srG1fy+ZU00TmZ1NFp6kFLbVLMXHe7A1d-g@mail.gmail.com>
Subject: Re: [PATCH] usercopy: use unsigned long instead of uintptr_t
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
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

On Thu, Jun 16, 2022 at 8:21 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> I don't know why people call uintptr_t a "userspace type".  It's a type
> invented by C99 that is an integer type large enough to hold a pointer.
> Which is exactly what we want here.

On the other hand, "unsigned long" has existed since the first version
of C, and is an integer type large enough to hold a pointer.

Which is exactly what we want here, and what we use everywhere else too.

The whole "uintptr_t handles the historical odd cases with pointers
that are smaller than a 'long'" is entirely irrelevant, since those
odd cases are just not a factor.

And the "pointers are _larger_ than a 'long'" case is similarly
irrelevant, since we very much want to use arithmetic on these things,
and they are 'long' later. They aren't used as pointers, they are used
as integer indexes into the virtual address space that we do odd
operations on.

Honestly, even if you believe in the 128-bit pointer thing, changing
one cast in one random place to be different from everything else is
*not* productive. We're never going to do some "let's slowly migrate
from one to the other".

And honestly, we're never going to do that using "uintptr_t" anyway,
since it would be based on a kernel config variable and be a very
specific type, and would need to be type-safe for any sane conversion.

IOW, in a hypothetical word where the address size is larger than the
word-size, it would have to be something like out "pte_t", which is
basically wrapped in a struct so that C implicit type conversion
doesn't bite you in the arse.

So no. There is ABSOLUTELY ZERO reason to ever use 'uintptr_t' in the
kernel. It's wrong. It's wrong *even* for actual user space interfaces
where user space might use 'uintptr_t', because those need to be
specific kernel types so that we control them (think for compat
reasons etc).

We use the user-space types in a few places, and they have caused
problems, but at least they are really traditional and the compiler
actually enforces them for some really standard functions. I'm looking
at 'size_t' in particular, which caused problems exactly because it's
a type that is strictly speaking not under our control.

'size_t' is actually a great example of why 'uintptr_t' is a horrid
thing. It's effectively a integer type that is large enough to hold a
pointer difference. On unsegmented architectures, that ends up being a
type large enough to hold a pointer.

Sound familiar?

And does it sound familiar how on some architectures it's "unsigned
int", and on others it is "unsigned long"? It's very annoying, and
it's been annoying over the years. The latest annoyance was literally
less than a week ago in 1c27f1fc1549 ("iov_iter: fix build issue due
to possible type mis-match").

Again, "unsigned long" is superior.

And the only reason to migrate away from it is because you want
something *type-safe*, which uintptr_t very much is not. As
exemplified by size_t, it's the opposite of type-safe. It's actively
likely to be type-confused.

              Linus
