Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752CA48BA62
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 23:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345204AbiAKWBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 17:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343842AbiAKWB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 17:01:29 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F56C06173F;
        Tue, 11 Jan 2022 14:01:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 09133CE1BAF;
        Tue, 11 Jan 2022 22:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B65C36AE9;
        Tue, 11 Jan 2022 22:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641938485;
        bh=9lyo4a7wsSQoH9aAqy6csVZ0oeEb5XrusjosDq6bNi4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=egNfDjOvv46AdQ2B6ud2WT6mVIGPjavhSHH2PHK3HKIuE3aXsdg/GvBRDo5aALxka
         escHHXylha6bDTT+aXPk0zU5ZeMF+cCnVR2mr7j+VllKY5KMOTr7PT6XAWLiFfEd7L
         a3wgwPjM38ls+9dT0xcUJH+0sItn04wO7cr/RD4zj4UE2Wswy0PvGYlhlDt2PEWLCt
         8C60co6m2EShIUQmgCkbNqCcO/RCSDR/ppwtmwKb810UvE2LBAXTBuMpw1yZNz9uIr
         8HXQMl+aKlK9McFSuvr9BCzg2ELyww4xBTThCqczVXzDG3jFpdzYP1ba7W7wieSA2i
         RBxvXUO41Xi2A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2675940714; Tue, 11 Jan 2022 19:01:23 -0300 (-03)
Date:   Tue, 11 Jan 2022 19:01:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        kajoljain <kjain@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the perf tree
Message-ID: <Yd3+M+efH6bTEpP9@kernel.org>
References: <20220106091921.3fa617bc@canb.auug.org.au>
 <6623bc13-d99c-74c1-29c8-b4ae7a570d99@linux.ibm.com>
 <20220112084553.2aa71f08@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112084553.2aa71f08@canb.auug.org.au>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jan 12, 2022 at 08:45:53AM +1100, Stephen Rothwell escreveu:
> Hi all,
> 
> On Fri, 7 Jan 2022 14:28:37 +0530 kajoljain <kjain@linux.ibm.com> wrote:
> >
> > On 1/6/22 3:49 AM, Stephen Rothwell wrote:
> > > 
> > > After merging the perf tree, today's linux-next build (powerpc
> > > ppc64_defconfig) failed like this:
> > > 
> > > In file included from include/linux/perf_event.h:17,
> > >                  from arch/powerpc/perf/isa207-common.h:12,
> > >                  from arch/powerpc/perf/isa207-common.c:9:
> > > arch/powerpc/perf/isa207-common.c: In function 'isa207_find_source':
> > > include/uapi/linux/perf_event.h:1339:11: error: 'PERF_MEM_HOPS_2' undeclared (first use in this function); did you mean 'PERF_MEM_HOPS_0'?
> > >  1339 |  (((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
> > >       |           ^~~~~~~~~
> > > arch/powerpc/perf/isa207-common.h:273:20: note: in expansion of macro 'PERF_MEM_S'
> > >   273 | #define P(a, b)    PERF_MEM_S(a, b)
> > >       |                    ^~~~~~~~~~
> > > arch/powerpc/perf/isa207-common.c:240:51: note: in expansion of macro 'P'
> > >   240 |     ret |= PH(LVL, REM_RAM1) | REM | LEVEL(RAM) | P(HOPS, 2);
> > >       |                                                   ^
> > > include/uapi/linux/perf_event.h:1339:11: note: each undeclared identifier is reported only once for each function it appears in
> > >  1339 |  (((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
> > >       |           ^~~~~~~~~
> > > arch/powerpc/perf/isa207-common.h:273:20: note: in expansion of macro 'PERF_MEM_S'
> > >   273 | #define P(a, b)    PERF_MEM_S(a, b)
> > >       |                    ^~~~~~~~~~
> > > arch/powerpc/perf/isa207-common.c:240:51: note: in expansion of macro 'P'
> > >   240 |     ret |= PH(LVL, REM_RAM1) | REM | LEVEL(RAM) | P(HOPS, 2);
> > >       |                                                   ^
> > > include/uapi/linux/perf_event.h:1339:11: error: 'PERF_MEM_HOPS_3' undeclared (first use in this function); did you mean 'PERF_MEM_HOPS_0'?
> > >  1339 |  (((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
> > >       |           ^~~~~~~~~
> > > arch/powerpc/perf/isa207-common.h:273:20: note: in expansion of macro 'PERF_MEM_S'
> > >   273 | #define P(a, b)    PERF_MEM_S(a, b)
> > >       |                    ^~~~~~~~~~
> > > arch/powerpc/perf/isa207-common.c:244:51: note: in expansion of macro 'P'
> > >   244 |     ret |= PH(LVL, REM_RAM2) | REM | LEVEL(RAM) | P(HOPS, 3);
> > >       |                                                   ^
> > > 
> > > Caused by commit
> > > 
> > >   af2b24f228a0 ("perf powerpc: Add data source encodings for power10 platform")
> > > 
> > > It looks like patch 1/4 of this series is missing ...  
> > 
> > Hi Stephen,
> >      Yes you are right, original patch series contain 4 patches, where
> > 1/4 patch contain kernel side changes for the same. Hence we are getting
> > this error, as that patch is missing in the Arnaldo tree.
> > 
> > Link to the patchset: https://lkml.org/lkml/2021/12/6/143
> > 
> > That kernel side patch is taken by Michael Ellermen via powerpc git.
> > 
> > Link to the patchset on powerpc/next:
> > 
> > [1/4] perf: Add new macros for mem_hops field
> > https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?id=cb1c4aba055f928ffae0c868e8dfe08eeab302e7
> > 
> > 
> > [3/4] powerpc/perf: Add encodings to represent data based on newer
> > composite PERF_MEM_LVLNUM* fields
> >  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?id=4a20ee106154ac1765dea97932faad29f0ba57fc
> > 
> > [4/4] powerpc/perf: Add data source encodings for power10 platform
> > https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?id=6ed05a8efda56e5be11081954929421de19cce88
> > 
> > Thanks,
> > Kajol Jain
> > 
> > > 
> > > I have used the perf tree from next-20220105 for today.
> > >   
> 
> I am still getting this build failure.

Yeah, this patch shouldn't have been merged thru the perf _tools_ tree,
my bad, it should have gone thru Michael PPC kernel tree.

It was a single series mixing up tools/ with kernel bits, I thought I
had picked just the tools part but made a mistake.

This should get resolved when the rest of the kernel bits go via
Michael's powerpc tree, right?

- Arnaldo
