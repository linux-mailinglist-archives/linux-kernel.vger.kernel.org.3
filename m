Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2214D4748B4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbhLNRBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbhLNRBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:01:19 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242A3C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 09:01:19 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id de30so17406074qkb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 09:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K6SwQ7kN/dDw+w0mSseLUAWkx7P46fy2j21+TDwHRGQ=;
        b=geSylfNXtOBB5MFpassheNNfvCZZL8x1Ti8xIAp8L7G+Cs8a5Uj4HqJbNfYU6qm2jq
         5vCr00Av2R22T5+ybKQMT2+DZIxGWKFkQPujityyd2ZcHjzGLSmZXGo4csyMxvAC31tt
         r19YWVeLJAE3LtK3E10d3I8Cg6I3F0OUiBXC2p2qtLaNq01HQDDzS0q1Yc8J+hXL6ntJ
         ldppbrkbhz0x/CRAZ4Wpn8ilCgchJTxl31qpycWOVvObIakvDqz6ykJdTPnAGp23M80v
         P98OetMrefut5qXrSfttToSSXdlZ5LSl/frMmQG7fnFg82aloqsDJaVG5IB3hfAIiM71
         8Bpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K6SwQ7kN/dDw+w0mSseLUAWkx7P46fy2j21+TDwHRGQ=;
        b=6bBxiYMnWhs7vIRtFuGr5bK9TKM7bRPNhee+h20wjQE5QHYaZKb4ePxyUaL14fdI2F
         7kZspvNw5KMe4NojsQz4QBw7gxDgITlXcheyS6WThefDgt27P1P57ZZ8xIqY3cmEJzzD
         SYmAtaQ3KGATon4WVFmD5BNM/hbcXBvo4fNvyc9ZqUMsGJ7rAXI3aJRXgogHOWecGXki
         Lw1XysZdVEXgn+Ec793bA9W7ssF9X1e8MCmJI9p0PqMn90aaavuR+iyiYzzSe9Xs0IYt
         5RUF1HgRZQynN1OGBM+fbDo2911TYkrTutbLdgyppNGRBqW5sEzIx0qUqZ+Z7fgSZqt3
         Yw6w==
X-Gm-Message-State: AOAM530dmr5xP1CV1qcwhCvgGZW/y2qPBilkuCKKrtLVZ2K3M/Teciz8
        neFz6tbqBmMchINSNmF0E7XqwMz4eKlPO8oxPQCctA==
X-Google-Smtp-Source: ABdhPJxFv9ZFHoPXaaC/osRtc8a0bS2qHEXsr2DcKiYvm2pnK++TLb5sKoemfjwrn9CS2MWsFW6/45fBFq2DIZSvFzI=
X-Received: by 2002:a05:620a:2848:: with SMTP id h8mr5214238qkp.610.1639501277945;
 Tue, 14 Dec 2021 09:01:17 -0800 (PST)
MIME-Version: 1.0
References: <20211214162050.660953-1-glider@google.com> <20211214162050.660953-42-glider@google.com>
 <YbjIbpFRqMac/X8s@kroah.com>
In-Reply-To: <YbjIbpFRqMac/X8s@kroah.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 14 Dec 2021 18:00:41 +0100
Message-ID: <CAG_fn=XSMbgyJZnivZCh30M3JYQsJZZ0yL+5z074B_WrEBkRDQ@mail.gmail.com>
Subject: Re: [PATCH 41/43] security: kmsan: fix interoperability with auto-initialization
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
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

On Tue, Dec 14, 2021 at 5:38 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> > @@ -124,6 +125,7 @@ choice
> >       config INIT_STACK_ALL_ZERO
> >               bool "zero-init everything (strongest and safest)"
> >               depends on CC_HAS_AUTO_VAR_INIT_ZERO
> > +             depends on !KMSAN
>
> So this means KMSAN is a developer debugging feature only and should
> never be turned on on a real device/server that has users?

100% correct. KMSAN is way slower than KASAN, it also eats 2/3 of your
memory to store the metadata.
I thought it was sort of self-evident, but I can surely mention this
explicitly in the cover letter.
