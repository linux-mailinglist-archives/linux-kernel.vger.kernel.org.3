Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F66B4D0A8A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 23:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242265AbiCGWIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 17:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbiCGWIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 17:08:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AFE2AF2;
        Mon,  7 Mar 2022 14:07:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5DC860BC6;
        Mon,  7 Mar 2022 22:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB7DC340E9;
        Mon,  7 Mar 2022 22:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646690857;
        bh=MbxK4BPXX7Ie0YOP0mxZfgC5/K3/ktLCIYUXqFDFb/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ISmv1JDwhARWWANtx6Ya2hNGPMkrKs2t60EQB42sWlz6cczqsgM0ysE3nUrbBXXp/
         hoSU96u6eKC0Lofc1a2F1UrlF3A309P1uGF+CR/mByM/ELOcSSlSxs+nXwyOa+kfqN
         oxzF1cUTlRl6iVu5GOIiW0fEY/GzdGSkZseXoAL29RqrE+NqP6FCzzVyRgXiR1O3VH
         d59SoL2cyI9SfltDUh+Bvp83tA9manjwiWJF76jEEJORZrOyIbhliGix48Y37EsDUX
         C2g22bB4qR5KknCaaEiWiC0BoEFeKv5+HuTEUgFySJ02WlNWzQtGt+FBxWofGUPWGP
         FeveaYPO+ANtw==
Date:   Tue, 8 Mar 2022 00:07:27 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] MIPS: Refactor early_parse_mem() to fix mem=
 parameter
Message-ID: <YiaCH6UsQZSbnNHd@kernel.org>
References: <1646108941-27919-1-git-send-email-yangtiezhu@loongson.cn>
 <1646108941-27919-2-git-send-email-yangtiezhu@loongson.cn>
 <20220304151052.GA27642@alpha.franken.de>
 <20220304153517.GA28487@alpha.franken.de>
 <alpine.DEB.2.21.2203041634040.47558@angie.orcam.me.uk>
 <20220307162909.GA18728@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307162909.GA18728@alpha.franken.de>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 05:29:09PM +0100, Thomas Bogendoerfer wrote:
> On Fri, Mar 04, 2022 at 05:11:44PM +0000, Maciej W. Rozycki wrote:
> > On Fri, 4 Mar 2022, Thomas Bogendoerfer wrote:
> > 
> > > > > With this patch, when add "mem=3G" to the command-line, the
> > > > > kernel boots successfully, we can see the following messages:
> > > > 
> > > > unfortunately this patch would break platforms without memory detection,
> > > > which simply use mem=32M for memory configuration. Not sure how many
> > > > rely on this mechanism. If we can make sure nobody uses it, I'm fine
> > > > with your patch.
> > > 
> > > maybe we could add a CONFIG option, which will be selected by
> > > platforms, which don't need/want this usermem thing.
> > 
> >  FWIW I don't understand what the issue is here beyond that we have a bug 
> > that causes a system to hang when "mem=3G" is passed on the kernel command 
> > line.  That is assuming that system does have contiguous RAM available for 
> > the kernel to use from address 0 up to 3GiB; otherwise it's a user error 
> > to tell the kernel it has that memory available (I did get bitten by that 
> > myself too): garbage in, garbage out.
> 
> I did a quick test with an IP30:
> 
> >> bootp(): ip=dhcp root=/dev/nfs console=ttyS0 mem=384M
> Setting $netaddr to 192.168.8.208 (from server )
> Obtaining  from server 
> 9012640+181664 entry: 0xa800000020664a60
> Linux version 5.17.0-rc3+ (tbogendoerfer@adalid) (mips64-linux-gnu-gcc (GCC) 6.1.1 20160621 (Red Hat Cross 6.1.1-2), GNU ld version 2.27-3.fc24) #155 SMP Mon Mar 7 13:12:01 CET 2022
> ARCH: SGI-IP30
> PROMLIB: ARC firmware Version 64 Revision 0
> printk: bootconsole [early0] enabled
> CPU0 revision is: 00000934 (R10000)
> FPU revision is: 00000900
> Detected 512MB of physical memory.
> User-defined physical RAM map overwrite
> Kernel sections are not in the memory maps
> IP30: Slot: 0, PrID: 00000934, PhyID: 0, VirtID: 0
> IP30: Slot: 1, PrID: 00000934, PhyID: 1, VirtID: 1
> IP30: Detected 2 CPU(s) present.
> Primary instruction cache 32kB, VIPT, 2-way, linesize 64 bytes.
> Primary data cache 32kB, 2-way, VIPT, no aliases, linesize 32 bytes
> Unified secondary cache 1024kB 2-way, linesize 128 bytes.
> Zone ranges:
>   DMA32    [mem 0x0000000000000000-0x00000000ffffffff]
>   Normal   empty
> Movable zone start for each node
> Early memory node ranges
>   node   0: [mem 0x0000000000000000-0x0000000017ffffff]
>   node   0: [mem 0x0000000020004000-0x00000000208c7fff]
> Initmem setup node 0 [mem 0x0000000000000000-0x00000000208c7fff]
> 
> after that it's dead (it doesn't have memory starting at 0x0).
> Most SGI systems will act broken with mem= in one way or another.
> And I already had the need to limit the amount of memory.
> 
> >  I think having a CONFIG option automatically selected to disable the 
> > ability to give a memory map override would handicap people in debugging 
> > their systems or working around firmware bugs, so I would rather be 
> > against it.
> 
> I'm thinking about a CONFIG option, which isn't user selectable, but
> selected via Kconfig only. But that would give to differents semantics
> for mem=
> 
> So can I just limit amount of memory without interfering with normal
> memory detection ?

Maybe it's better to add a new encoding to mem= that will have the semantics
of limiting amount of memory?

E.g.

mem=384M@

would mean "only use 384M of memory that firmware reported" while

mem=384M would mean "set memory to 0 - 384M" as it does now.

I think it's fine to have this MIPS specific because there is anyway no
consistency among architectures in mem= handling.
 
> Thomas.
> 
> -- 
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]

-- 
Sincerely yours,
Mike.
