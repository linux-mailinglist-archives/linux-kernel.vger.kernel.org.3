Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED3549D121
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243915AbiAZRsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237359AbiAZRsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:48:13 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162A9C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:48:13 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id u14so362016lfo.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xLIqTYmkTKOqFZ7wfTxJc0kW+NLs1daqfDz4QtnxNOE=;
        b=X7xFhQb0effXUmTlH3FmiQFSjih+K3eCM4h2wZJ054D9JP1TSMgXnMEaB/pdXYEy5c
         2Etcy5rpxHp2A0RX+i2i/btx63SQ++MTYGlnecrBFBQHBRGkRmYVAUqdSTmFbRbIgxrS
         2J5nGnYneeAhCmlCzlsLn/OHqj4UtTiQRJvrjqxcN8UsjR7b7t9miS4OaD7s6yBGhXHb
         c3VWNfAOCPMNO0S/CbdcNky/g8Cp1MIDXb6CA4h00IWqs3xpJ1tZwIEDgfSlohXtwZjV
         x3tF+gFFIs8u6PweR2xt1E0+lIwdUbwMhlHE/MojKKToZfkqVV8I1PoXJl3gjLUVrqg2
         v3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xLIqTYmkTKOqFZ7wfTxJc0kW+NLs1daqfDz4QtnxNOE=;
        b=NRkhkVZUaLE/+GSgUmdq/7/uPgQxjZBdPvOJ54n3ofVsuZlrhU9qNJBSHxr2JyTmMc
         uYX2/5rN00J/S+CEoum1dWifDP7eNFiv4ecxk1KIkjyJOL4ooD6UtzSfu/B/eVkcVWCc
         G9BO0a2nInxrtqVBXC+Y9kq4np/C6SokyNi6cX7my1G1FvR4BjvQ4QnNuF08JRYkl3Vi
         e7+Y94CBEOEdCFDHqNSXcfqfYfUQFwwkWBA5s/3AZpszsq/cw5QuAxODpgUBBTjIkLPT
         BR0jOZpb/BuOFRbrw+PcHEdfg0KUbIMk1elf1saxw3GZwA9DgBEu7/2SiJEL3B5jL4EM
         Y2Og==
X-Gm-Message-State: AOAM532YWiELRf6xhzQot6uwjOMbXRJFcYQs4fpNPucADVHHHzClaiyp
        EFrnnnIzAPBpTTFV18Tf482BlzKenGH0+m1aivHSnw==
X-Google-Smtp-Source: ABdhPJyKBr1xlRALAliUxF/Mxw6N6CtPCpFxFHyPizOx2SCGgGSfY2PslatnaC51qgTuIuVL7AbXBVVi3vNrd8VbREM=
X-Received: by 2002:a19:ee13:: with SMTP id g19mr32931lfb.288.1643219291219;
 Wed, 26 Jan 2022 09:48:11 -0800 (PST)
MIME-Version: 1.0
References: <20220126171232.2599547-1-jannh@google.com> <CACT4Y+b8ty07hAANzktksbbe5HdDM=jm6TSYLKawctpBmPfatw@mail.gmail.com>
In-Reply-To: <CACT4Y+b8ty07hAANzktksbbe5HdDM=jm6TSYLKawctpBmPfatw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 26 Jan 2022 18:47:45 +0100
Message-ID: <CAG48ez3mfAwgkJp+GKLnbtgQoQVT78U+voRN09H5S=7Ewf+DgQ@mail.gmail.com>
Subject: Re: [PATCH] x86/csum: Add KASAN/KCSAN instrumentation
To:     Dmitry Vyukov <dvyukov@google.com>
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

On Wed, Jan 26, 2022 at 6:38 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, 26 Jan 2022 at 18:13, Jann Horn <jannh@google.com> wrote:
> >
> > In the optimized X86 version of the copy-with-checksum helpers, use
> > instrument_*() before accessing buffers from assembly code so that KASAN
> > and KCSAN don't have blind spots there.
[...]
> Can these potentially be called with KERNEL_DS as in some compat
> syscalls? If so it's better to use instrument_copy_to/from_user.
> Or probably it's better to use them anyway b/c we also want to know
> about user accesses for uaccess logging and maybe other things.

Christoph Hellwig has basically eradicated KERNEL_DS. :)

In particular, on X86, set_fs(KERNEL_DS) doesn't really do anything
anymore since commit 47058bb54b579 ("x86: remove address space
overrides using set_fs()").
