Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0877F466856
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347848AbhLBQeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:34:11 -0500
Received: from foss.arm.com ([217.140.110.172]:37560 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230060AbhLBQeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:34:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E490F1515;
        Thu,  2 Dec 2021 08:30:41 -0800 (PST)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8067D3F73B;
        Thu,  2 Dec 2021 08:30:36 -0800 (PST)
Date:   Thu, 2 Dec 2021 16:30:30 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 3/3] arm64: mm: log potential KASAN shadow alias
Message-ID: <Yaj0pvC14AsAAN1y@lakrids>
References: <20211202112731.3346975-1-mark.rutland@arm.com>
 <20211202112731.3346975-4-mark.rutland@arm.com>
 <CA+fCnZdeD+9+n7vAhfFUJy20YVms+GME6r4C12ScYsDx=AjdEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZdeD+9+n7vAhfFUJy20YVms+GME6r4C12ScYsDx=AjdEg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 05:20:56PM +0100, Andrey Konovalov wrote:
> On Thu, Dec 2, 2021 at 12:27 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > When the kernel is built with KASAN_GENERIC or KASAN_SW_TAGS, shadow
> > memory is allocated and mapped for all legitimate kernel addresses, and
> > prior to a regular memory access instrumentation will read from the
> > corresponding shadow address.
> >
> > Due to the way memory addresses are converted to shadow addresses,
> > bogus pointers (e.g. NULL) can generate shadow addresses out of the
> > bounds of allocated shadow memory. For example, with KASAN_GENERIC and
> > 48-bit VAs, NULL would have a shadow address of dfff800000000000, which
> > falls between the TTBR ranges.
> >
> > To make such cases easier to debug, this patch makes die_kernel_fault()
> > recover dump the real memory address range for any potential KASAN
> > shadow access. Since we can't reliably distinguish shadow accesses from
> > regular accesses, we always dump this information when shadow memory is
> > in use.

> > @@ -297,6 +297,12 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
> >         pr_alert("Unable to handle kernel %s at virtual address %016lx\n", msg,
> >                  addr);
> >
> > +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
> > +       pr_alert("Possible KASAN shadow access for range [%016lx..%016lx]\n",
> > +                (unsigned long)kasan_shadow_to_mem((void *)addr),
> > +                (unsigned long)kasan_shadow_to_mem((void *)addr + 1) - 1);
> > +#endif
> 
> Hi Mark,
> 
> There's the kasan_non_canonical_hook() function that's used on x86 for
> the same purpose: adding clarity to GPF faults caused by KASAN shadow
> accesses. Would it possible to reuse it for arm64?

Aha! That looks like exactly what I'm after; I'll go try that for v2.

Thanks for the pointer!

Mark.
