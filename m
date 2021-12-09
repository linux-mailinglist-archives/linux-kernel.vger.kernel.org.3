Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612BA46E782
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbhLIL0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbhLIL0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:26:06 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052DBC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 03:22:32 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J8s865gcxz4xZ1;
        Thu,  9 Dec 2021 22:22:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1639048951;
        bh=L4KhAjslg+bTyBL9obtudj08BBzaKbkkrH1InEo6//Q=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=EE66aZj/Y+no5HK1ypXKUCgJCl4leAZ9HZs1ltsJUW7STjfgBgq7Ej4CtbMw4EMY4
         rhqQ65rZSY9oZgk3C72JzvePeEZ/oZUX1VhKOzDHEMOFdbgpKjWCRZvagiP3k0YnOZ
         G3Mah6bSvwHKkSRV+CDp2Cy44Yx5xRDvMjBL5BC8DOuNeKEkRJxSFUTl3+PhN0cq6n
         EQvGTaezM8CfgruLjVwyL6GTT+wnQHVDJfBwgWZXBE6UISbal2B9yK6oH7RHVqqT+c
         +AirC57MK7fi60Cr1CLlc02d+ems/YJ4uwP8DchIOZardwIXnQj0I+YF2vQQ+gStM7
         YRCYYnEJioOZA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        "alex@ghiti.fr" <alex@ghiti.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v4 09/10] powerpc/mm: Convert to default topdown mmap
 layout
In-Reply-To: <1639046542.qkwu4mjtew.astroid@bobo.none>
References: <cover.1638976228.git.christophe.leroy@csgroup.eu>
 <d2d5510115cba2d56866fa01dab267655a20da71.1638976229.git.christophe.leroy@csgroup.eu>
 <1639044621.jeow25j0pr.astroid@bobo.none>
 <360e2a3e-63c6-3ce2-f481-695ad0ec4880@csgroup.eu>
 <1639046542.qkwu4mjtew.astroid@bobo.none>
Date:   Thu, 09 Dec 2021 22:22:29 +1100
Message-ID: <87v8zym39m.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Piggin <npiggin@gmail.com> writes:

> Excerpts from Christophe Leroy's message of December 9, 2021 8:22 pm:
>>=20
>>=20
>> Le 09/12/2021 =C3=A0 11:15, Nicholas Piggin a =C3=A9crit=C2=A0:
>>> Excerpts from Christophe Leroy's message of December 9, 2021 3:18 am:
>>>> Select CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT and
>>>> remove arch/powerpc/mm/mmap.c
>>>>
>>>> This change provides standard randomisation of mmaps.
>>>>
>>>> See commit 8b8addf891de ("x86/mm/32: Enable full randomization on i386
>>>> and X86_32") for all the benefits of mmap randomisation.
>>>=20
>>> The justification seems pretty reasonable.
>>>=20
>>>>
>>>> Comparison between powerpc implementation and the generic one:
>>>> - mmap_is_legacy() is identical.
>>>> - arch_mmap_rnd() does exactly the same allthough it's written
>>>> slightly differently.
>>>> - MIN_GAP and MAX_GAP are identical.
>>>> - mmap_base() does the same but uses STACK_RND_MASK which provides
>>>> the same values as stack_maxrandom_size().
>>>> - arch_pick_mmap_layout() is almost identical. The only difference
>>>> is that it also adds the random factor to mm->mmap_base in legacy mode.
>>>>
>>>> That last point is what provides the standard randomisation of mmaps.
>>>=20
>>> Thanks for describing it. Could you add random_factor to mmap_base for
>>> the legacy path for powerpc as a 2-line change that adds the legacy
>>> randomisation. And then this bigger patch would be closer to a no-op.
>>>=20
>>=20
>> You mean you would like to see the following patch before doing the=20
>> convert ?
>>=20
>> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/7dabf1cbde67a346=
a187881d4f0bd17347e0334a.1533732583.git.christophe.leroy@c-s.fr/
>
> Yes.

My comment at the time was:

  Basically mmap_is_legacy() tells you if any of these is true:
=20=20
   - process has the ADDR_COMPAT_LAYOUT personality
   - global legacy_va_layout sysctl is enabled
   - stack is unlimited

  And we only want to change the behaviour for the stack. Or at least the
  change log of your patch only talks about the stack limit, not the
  others.
=20=20
  Possibly we should just enable randomisation for all three of those
  cases, but if so we must spell it out in the patch.
=20=20
  It'd also be good to see the output of /proc/x/maps for some processes
  before and after, to show what actually changes.


From: https://github.com/linuxppc/issues/issues/59#issuecomment-502066947


So I think at least the change log on that patch still needs updating to
be clear that it's changing behaviour for all mmap_is_legacy() cases,
not just the stack unlimited case.

There's also a risk changing the mmap legacy behaviour breaks something.
But we are at least matching the behaviour of other architectures, and
there is also an escape hatch in the form of `setarch -R`.

cheers

