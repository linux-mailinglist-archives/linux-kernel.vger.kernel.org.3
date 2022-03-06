Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6804C4CE810
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 02:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbiCFBXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 20:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiCFBXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 20:23:52 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10E765FC3;
        Sat,  5 Mar 2022 17:22:59 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id E6A1792009C; Sun,  6 Mar 2022 02:22:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id D7D5992009B;
        Sun,  6 Mar 2022 01:22:58 +0000 (GMT)
Date:   Sun, 6 Mar 2022 01:22:58 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Mike Rapoport <rppt@kernel.org>
cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] MIPS: Modify mem= and memmap= parameter
In-Reply-To: <YiPDfhfwYUQy9Pfd@kernel.org>
Message-ID: <alpine.DEB.2.21.2203060110210.47558@angie.orcam.me.uk>
References: <1646108941-27919-1-git-send-email-yangtiezhu@loongson.cn> <Yh3tgr+g/6IElq0P@kernel.org> <cfd74b5b-39c3-733a-5226-515991f91f39@loongson.cn> <Yh4uUoYT+YS5Jxsv@kernel.org> <8956c625-c18d-846e-3e65-7920776b27f3@loongson.cn>
 <alpine.DEB.2.21.2203041627150.47558@angie.orcam.me.uk> <4e10d7a4-3b3e-a220-8cd2-565614288950@loongson.cn> <YiNlDxF9WppxbkiX@kernel.org> <alpine.DEB.2.21.2203051837280.47558@angie.orcam.me.uk> <YiPDfhfwYUQy9Pfd@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Mar 2022, Mike Rapoport wrote:

> >  There's nothing to implement as the MIPS port has supported arbitrary 
> > memory maps since Dec 11th, 2000; that's almost 22 years now.  C.f.: 
> > <https://lore.kernel.org/linux-mips/Pine.GSO.3.96.1000814133957.7256S-100000@delta.ds2.pg.gda.pl/>, 
> > <https://git.kernel.org/pub/scm/linux/kernel/git/ralf/linux.git/commit/?id=97b7ae4257ef>.
> 
> You are right, and providing mem=X@Y for each contiguous memory range
> should work even after 22 years.
> I missed the fact that mem= can be repeated several times.

 Yep, I have now finally tracked down the original bootstrap log for the 
first try of that change:

This DECstation is a DS5000/2x0
Loading R[23]00 MMU routines.
CPU revision is: 00000230
Primary instruction cache 64kb, linesize 4 bytes
Primary data cache 64kb, linesize 4 bytes
Linux version 2.4.0-test5 (macro@macro.ds2.pg.gda.pl) (gcc version 2.95.3 19991030 (prerelease)) #16 Sun Aug 13 16:43:22 CEST 2000
PROM-provided physical RAM map:
 memory: 06800000 @ 00000000
 memory: 00800000 @ 08000000
 memory: 00800000 @ 0a000000
User-defined physical RAM map:
 memory: 06800000 @ 00000000
 memory: 00800000 @ 08000000
 memory: 00800000 @ 0a000000
 memory: 00800000 @ 0c000000
On node 0 totalpages: 51200
zone(0): 51200 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: rw console=ttyS2 mem=104M@0M mem=8M@128M mem=8M@160M mem=8M@192M
Calibrating delay loop... 39.85 BogoMIPS
Memory: 127852k/204800k available (2403k kernel code, 76948k reserved, 610k data, 72k init)
[...]

NB that system is still in service, with more RAM since added.

> >  Sadly commit a09fc446fb6d ("[MIPS] setup.c: use early_param() for early 
> > command line parsing") removed last pieces of inline documentation; I 
> > don't know why things like that get approved, but neither I can take 
> > responsibility.
> 
> This is sad indeed, but we still can update the kernel-parameters.txt with
> a MIPS paragraph.

 Sure, patches are welcome.

  Maciej
