Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB1749E4E9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242575AbiA0Ook (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242589AbiA0Oog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:44:36 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E9EC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 06:44:36 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id s185so6260725oie.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 06:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=darEVYQSE8nP3jpJzwSkUiUgFJtcguGHbAaA8wiRNaA=;
        b=Ypwxd6R69jdEi7v85ZpAoA++E5ZdaNFLhQI7oFvsnng/vm4suU1TWo0YEj5rgZ0eAX
         x4X/DCGq/OZw2IjERsddLvz2PN8Qw2zARqXg+pRcZ49XBjAm0Tx9bFH5XsiSRGPgAalt
         w/8nvHMrblwuL3Jb+qwBrxsF6vLJz6O3LlTzcauEgTqRsXJCzfRJjZxtaa6wuPzohZ09
         IDXxDNhN83LNO/eVTUpMzZqkhDFtd+mEgk6gSPyQqduI4+m7RIvUVlhrPiIjrr0fl2Kd
         FSHQaVB/NWcA70SEss5ZoS+0dBIcjv5cfze/AvGUiIhf2DRFlDpnip3DT5ojr4GMKgHs
         34mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=darEVYQSE8nP3jpJzwSkUiUgFJtcguGHbAaA8wiRNaA=;
        b=GnngO5VOurN34ErbEuA06LXjGTJ2NQkZjVw3j8+j5ppk6VCZwWB4VSdek3ezeHkByb
         7CIxwuMrKxUYDYmV6BJ+QjXQSZGPY3JWmkT/bwC9Aua/xLDOkRw4kFjddK8Ocs1QhSFX
         75c0D1oujFor5J1xwBWJ6meImozrk2PeCYy1Cks134wEnDMOxs5Qeb+DphZiH/mkx9yL
         g5BFJ7bTRx05qjhC00pemsV0pqXdtZdNdEkbJXKgUfQOEGEo0+iYyGNsL0tp2VVzafIS
         NrUlVrQQwmeVJg5eivCCnGZX4DCYamBABecpnnW5LUsxcNBg6L+f8v8Kbs11AUvRmZPV
         YpPA==
X-Gm-Message-State: AOAM531NzEwDFFnIRuCwTfZN0NnTrwCTR2sPD+XPPVDzGPOqujLrDplC
        19ZrAAiHcc9II+iXTn1WNpCiJQCON4eWeuaRhoTG+w==
X-Google-Smtp-Source: ABdhPJx4uxUdzNLOjtmP4roFlEQVaxC6kgtGFXTbTsPTVjAMwP3ZTHmEUmX1RdOLYiTInZ5cC0JLwb9wMsusDW+wdS0=
X-Received: by 2002:a05:6808:b10:: with SMTP id s16mr2364269oij.307.1643294675382;
 Thu, 27 Jan 2022 06:44:35 -0800 (PST)
MIME-Version: 1.0
References: <20220126171232.2599547-1-jannh@google.com> <CACT4Y+b8ty07hAANzktksbbe5HdDM=jm6TSYLKawctpBmPfatw@mail.gmail.com>
 <CAG48ez3mfAwgkJp+GKLnbtgQoQVT78U+voRN09H5S=7Ewf+DgQ@mail.gmail.com>
In-Reply-To: <CAG48ez3mfAwgkJp+GKLnbtgQoQVT78U+voRN09H5S=7Ewf+DgQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 27 Jan 2022 15:44:24 +0100
Message-ID: <CACT4Y+bOsS+veBKSMQX+Etz=93PZv-nhKYm4-Gmigmv551LCtg@mail.gmail.com>
Subject: Re: [PATCH] x86/csum: Add KASAN/KCSAN instrumentation
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev@googlegroups.com, Eric Dumazet <edumazet@google.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022 at 18:48, Jann Horn <jannh@google.com> wrote:
> > > In the optimized X86 version of the copy-with-checksum helpers, use
> > > instrument_*() before accessing buffers from assembly code so that KASAN
> > > and KCSAN don't have blind spots there.
> [...]
> > Can these potentially be called with KERNEL_DS as in some compat
> > syscalls? If so it's better to use instrument_copy_to/from_user.
> > Or probably it's better to use them anyway b/c we also want to know
> > about user accesses for uaccess logging and maybe other things.
>
> Christoph Hellwig has basically eradicated KERNEL_DS. :)
>
> In particular, on X86, set_fs(KERNEL_DS) doesn't really do anything
> anymore since commit 47058bb54b579 ("x86: remove address space
> overrides using set_fs()").

That's good!

But still need this for uaccess logging.
