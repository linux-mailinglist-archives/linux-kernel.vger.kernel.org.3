Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351A848E997
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 13:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240879AbiANMDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 07:03:36 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:47583 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbiANMDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 07:03:35 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jb0Lr395Cz4xsm;
        Fri, 14 Jan 2022 23:03:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1642161814;
        bh=W2d5eSEiJo9C9+QtIF8NuKJuZoTNBxXPIEc8dpgjuiU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mjFYM7+hFm6B70dXRU7Wy7aidB2b4xGns8nKlar/vslrWaUUCyMZ5lEoW6B87jxWu
         AtzNZ3pOVZ4ppDNHaxv+PYQWV73IZ6UeE14cmX6svLGmOnbmdrHkbLIg1FKZpacIlf
         cAD9rHKClxq6GHlemNqx6XRnOD11N7PS6nTc14BNP76E1iIOj+9Ef2zal2hepRXn/B
         5yoOHZ8aHQWiXrR7Pi8kBVN98a9aeRdhgxBRlq+G41FdoO4nfSyKrYrsi7HAqX5ta1
         Qe9cyP2OT0+8rOU66/9xKQQP0MPoWJ+DwVtMWqyPTP0q5hQ3iS6hcqjnN9IzLGWS5t
         19ZR0neR4wxTg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        kajoljain <kjain@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the perf tree
In-Reply-To: <Yd3+M+efH6bTEpP9@kernel.org>
References: <20220106091921.3fa617bc@canb.auug.org.au>
 <6623bc13-d99c-74c1-29c8-b4ae7a570d99@linux.ibm.com>
 <20220112084553.2aa71f08@canb.auug.org.au> <Yd3+M+efH6bTEpP9@kernel.org>
Date:   Fri, 14 Jan 2022 23:03:32 +1100
Message-ID: <87r19a1q3v.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo <acme@kernel.org> writes:
> Em Wed, Jan 12, 2022 at 08:45:53AM +1100, Stephen Rothwell escreveu:
>> Hi all,
>> 
>> On Fri, 7 Jan 2022 14:28:37 +0530 kajoljain <kjain@linux.ibm.com> wrote:
>> >
>> > On 1/6/22 3:49 AM, Stephen Rothwell wrote:
>> > > 
>> > > After merging the perf tree, today's linux-next build (powerpc
>> > > ppc64_defconfig) failed like this:
>> > > 
>> > > In file included from include/linux/perf_event.h:17,
>> > >                  from arch/powerpc/perf/isa207-common.h:12,
>> > >                  from arch/powerpc/perf/isa207-common.c:9:
>> > > arch/powerpc/perf/isa207-common.c: In function 'isa207_find_source':
>> > > include/uapi/linux/perf_event.h:1339:11: error: 'PERF_MEM_HOPS_2' undeclared (first use in this function); did you mean 'PERF_MEM_HOPS_0'?
>> > >  1339 |  (((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
>> > >       |           ^~~~~~~~~
>> > > arch/powerpc/perf/isa207-common.h:273:20: note: in expansion of macro 'PERF_MEM_S'
>> > >   273 | #define P(a, b)    PERF_MEM_S(a, b)
>> > >       |                    ^~~~~~~~~~
>> > > arch/powerpc/perf/isa207-common.c:240:51: note: in expansion of macro 'P'
>> > >   240 |     ret |= PH(LVL, REM_RAM1) | REM | LEVEL(RAM) | P(HOPS, 2);
>> > >       |                                                   ^
>> > > include/uapi/linux/perf_event.h:1339:11: note: each undeclared identifier is reported only once for each function it appears in
>> > >  1339 |  (((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
>> > >       |           ^~~~~~~~~
>> > > arch/powerpc/perf/isa207-common.h:273:20: note: in expansion of macro 'PERF_MEM_S'
>> > >   273 | #define P(a, b)    PERF_MEM_S(a, b)
>> > >       |                    ^~~~~~~~~~
>> > > arch/powerpc/perf/isa207-common.c:240:51: note: in expansion of macro 'P'
>> > >   240 |     ret |= PH(LVL, REM_RAM1) | REM | LEVEL(RAM) | P(HOPS, 2);
>> > >       |                                                   ^
>> > > include/uapi/linux/perf_event.h:1339:11: error: 'PERF_MEM_HOPS_3' undeclared (first use in this function); did you mean 'PERF_MEM_HOPS_0'?
>> > >  1339 |  (((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
>> > >       |           ^~~~~~~~~
>> > > arch/powerpc/perf/isa207-common.h:273:20: note: in expansion of macro 'PERF_MEM_S'
>> > >   273 | #define P(a, b)    PERF_MEM_S(a, b)
>> > >       |                    ^~~~~~~~~~
>> > > arch/powerpc/perf/isa207-common.c:244:51: note: in expansion of macro 'P'
>> > >   244 |     ret |= PH(LVL, REM_RAM2) | REM | LEVEL(RAM) | P(HOPS, 3);
>> > >       |                                                   ^
>> > > 
>> > > Caused by commit
>> > > 
>> > >   af2b24f228a0 ("perf powerpc: Add data source encodings for power10 platform")
>> > > 
>> > > It looks like patch 1/4 of this series is missing ...  
>> > 
>> > Hi Stephen,
>> >      Yes you are right, original patch series contain 4 patches, where
>> > 1/4 patch contain kernel side changes for the same. Hence we are getting
>> > this error, as that patch is missing in the Arnaldo tree.
>> > 
>> > Link to the patchset: https://lkml.org/lkml/2021/12/6/143
>> > 
>> > That kernel side patch is taken by Michael Ellermen via powerpc git.
>> > 
>> > Link to the patchset on powerpc/next:
>> > 
>> > [1/4] perf: Add new macros for mem_hops field
>> > https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?id=cb1c4aba055f928ffae0c868e8dfe08eeab302e7
>> > 
>> > 
>> > [3/4] powerpc/perf: Add encodings to represent data based on newer
>> > composite PERF_MEM_LVLNUM* fields
>> >  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?id=4a20ee106154ac1765dea97932faad29f0ba57fc
>> > 
>> > [4/4] powerpc/perf: Add data source encodings for power10 platform
>> > https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?id=6ed05a8efda56e5be11081954929421de19cce88
>> > 
>> > Thanks,
>> > Kajol Jain
>> > 
>> > > 
>> > > I have used the perf tree from next-20220105 for today.
>> > >   
>> 
>> I am still getting this build failure.
>
> Yeah, this patch shouldn't have been merged thru the perf _tools_ tree,
> my bad, it should have gone thru Michael PPC kernel tree.
>
> It was a single series mixing up tools/ with kernel bits, I thought I
> had picked just the tools part but made a mistake.
>
> This should get resolved when the rest of the kernel bits go via
> Michael's powerpc tree, right?

Sorry about this.

I've just sent my pull request to Linus.

cheers
