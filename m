Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4EA48F047
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 20:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243911AbiANTJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 14:09:24 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47118 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231557AbiANTJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 14:09:23 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CAA371EC050F;
        Fri, 14 Jan 2022 20:09:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642187357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PPHXW8DmjPUYqTAYqj9c9oaDkHSWzmjopWoY/gnxiTg=;
        b=qUPSsGci9EXKVVx9R6VGzmmvpb8ZH2QyHxkmyBTvxYODI7Zkb5c+mWGs/au08Q5E61zueM
        rAAh2bpnT1G4Y5LMkaCh9jKKfYCrl5YrsahDwBL/XXoGo9XjAFyxXokTEgbsipwXIK/eiq
        4v8goGrAFjF2e0P9O3RNreTNDD6IPDg=
Date:   Fri, 14 Jan 2022 20:09:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: Remove a.out support
Message-ID: <YeHKYXssmfX9Lfrr@zn.tnic>
References: <20220113160115.5375-1-bp@alien8.de>
 <YeBzxuO0wLn/B2Ew@mit.edu>
 <YeCuNapJLK4M5sat@zn.tnic>
 <YeD2q77KmaD8k87Q@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YeD2q77KmaD8k87Q@mit.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just to answer the "do we still wanna support running original a.out
binaries" aspect...

On Thu, Jan 13, 2022 at 11:06:03PM -0500, Theodore Ts'o wrote:
> > > Let's pour one out for being able to run Minix binaries on Linux.  :-)
> > 
> > https://en.wikipedia.org/wiki/Minix_3:
> > 
> > "2013-02-21 ... Dropped support for a.out binaries"
> > 
> > They themselves killed that support a lot earlier. :-)
> 
> Well, Minix 3 is a very different beast than the Minix 1.x

Right, but if the Minix 1.x successor has deemed a.out support obsolete
and has removed in 2013 I figure we can too. :-)

And, btw, Alan had a good, practical idea at the time we talked about
deprecating a.out support:

https://lore.kernel.org/all/20190305134347.4be2449c@alans-desktop/

And that is probably the best thing to do: if people wanna run old a.out
binaries, they can either write an a.out loader as an ELF program or
slap an old linux distro in a VM and do that there just fine.

If you look at the original thread which started this:

https://lore.kernel.org/all/CAG48ez1RVd5mQ_Pb6eygQESaZhpQz765OAZYSoPE0kPqfZEXQg@mail.gmail.com/

it looked even back then like a.out support is so rusty, bitrotten and
broken that we're probably even doing ourselves a favor to remove it.

Especially if not even the toolchains would even create an a.out
executable and no one even noticed.

So...

> that Linus used when he was boot-strapping Linux back in 1991. :-)
>
> Among other things Minux 1.x is system call compatible with the
> original V7 Unix from AT&T, whereas Minux 2.x and higher switch to
> having system calls that were Posix comaptible --- and Minix 2, being
> at teaching OS, wouldn't have kept any backwards compatibility when
> Prof. Tannenbaum released the 2nd edition of his Operating Systems
> Design and Implementation book in 1997.

I had a lot of fun reading that book. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
