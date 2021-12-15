Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB324759CB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242921AbhLONj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbhLONj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:39:56 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D717C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 05:39:56 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id be32so31631854oib.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 05:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=svxJfpg8jVkgXyVh9JGM5x7NaruneFPKWdsMZ9I2EiM=;
        b=cW48MB1IB1kQpbYVyCknBwpS9l45TSlBP232cQZlBNbg0Oh/muiXq1JbSQd9YzyZ9x
         sEdSY8Skr56faZwMXNEGPTHE5DYshbrQK2hGDxgM6aPhEkH+vs6UogoypduPjNmpUuWk
         wSvaTW382XrL8HAG6KIO/gdtAAXH8y+JFo2rFJNitbfitqVzD/ZSI1LJJ6cV/YM5g6JP
         xohPNT5dp8pKC3ltpmh+t/fUdk4tob6DUCN5ipiEsaSKCxkKyBubjnVDfe7wMuKTZEBh
         hgjTzyiLpGuvkbayjjX7UvP4rZ/O02ME50j5ZDJAQZ4A//7KIhjUh7jFDBNOJ0v1RIcl
         KIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=svxJfpg8jVkgXyVh9JGM5x7NaruneFPKWdsMZ9I2EiM=;
        b=1fNkl+JxhEmz6J7vDz3s+acycg4QZQsuMhHo0gKj8WBLvWwedDHo+zfDK2I7yeEb0K
         RdT0unN4z7Tuoywu2zMbQzQ/h47JYBgcEZ2tN5Mc6Snomglg8VC6jTsk4S6135KiKqWt
         PsDr/Ffk2/YNw/MHECQMEo5THqBAmhoex42wdCGQ+FvRRXs8EJK4NR/OrM3udb+fF7n4
         zEg6lqaggDMrAyme1LuMydAUx7JqKpJQZ3IR/4v2/ZX2vcPYdvVNVDKd3yu62TBQHoeL
         mbuHwAyUjrGmxRaaKDX3z4t9CNr3txAKzhSRQl4L7FGLA8fsWcObnxucyrAOesLKtZVC
         CUfA==
X-Gm-Message-State: AOAM532/FkCrAJeT8rPwxFmoz9p21kfNQAxabFiTUtvqTSmiGAhBmrIZ
        6lOStuNsxj9HLLi4QbMLplZ9mfEpINX5eBhalA3YKg==
X-Google-Smtp-Source: ABdhPJyhw9fV+5iWAXiiH/X/hxiW9UIqmhsUKwKcvZOrbUGfo1qIcn4wox0DtfrBc4ECp+n6hw3bCuswYLT11Fn+PL4=
X-Received: by 2002:a05:6808:118c:: with SMTP id j12mr8618083oil.65.1639575595612;
 Wed, 15 Dec 2021 05:39:55 -0800 (PST)
MIME-Version: 1.0
References: <20211214162050.660953-1-glider@google.com> <20211214162050.660953-13-glider@google.com>
 <Ybnuup0eMnhrwp8e@FVFF77S0Q05N>
In-Reply-To: <Ybnuup0eMnhrwp8e@FVFF77S0Q05N>
From:   Marco Elver <elver@google.com>
Date:   Wed, 15 Dec 2021 14:39:43 +0100
Message-ID: <CANpmjNNLG0F9WzNnQkJX+QEqdxnhWstuag_9jrid7zdJgivHyw@mail.gmail.com>
Subject: Re: [PATCH 12/43] kcsan: clang: retire CONFIG_KCSAN_KCOV_BROKEN
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 at 14:33, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Dec 14, 2021 at 05:20:19PM +0100, Alexander Potapenko wrote:
> > kcov used to be broken prior to Clang 11, but right now that version is
> > already the minimum required to build with KCSAN, that is why we don't
> > need KCSAN_KCOV_BROKEN anymore.
>
> Just to check, how is that requirement enforced?

HAVE_KCSAN_COMPILER will only be true with Clang 11 or later, due to
no prior compiler having "-tsan-distinguish-volatile=1".

> I see the core Makefiles enforce 10.0.1+, but I couldn't spot an explicit
> version dependency in Kconfig.kcsan.
>
> Otherwise, this looks good to me!

I think 5.17 will be Clang 11 only, so we could actually revert
ea91a1d45d19469001a4955583187b0d75915759:
https://lkml.kernel.org/r/Yao86FeC2ybOobLO@archlinux-ax161

I should resend that to be added to the -kbuild tree.
