Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9764FE784
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358570AbiDLR6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243499AbiDLR6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:58:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E70A58E57
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:56:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A6A4619FA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 17:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAE2C385A1;
        Tue, 12 Apr 2022 17:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649786188;
        bh=6oXyr4qSszqrDDIC74ST89Ik9P/w7VoRTbzZBuF4jtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mwyz5Grs9bx03m0WIXTHSUbER+tsU3Db4ke2pTBkBtdtNOQHEvJE5j2JrZ6hTdSS7
         cLHyJlxIrfuFqRmHAN+WDkglsl2GqY+WRoihNWgeEmONNQaDPGo0Oz40wNSweoeszO
         H3sX0HqZidwdlHMnFwryXNEjB+jca0mRkmDH4QhRiV5v/HhuXWD2mKDll6Nf6CQnJg
         HannvPl5Vj9rasJCcJaWAKN91UKotJUQMWg8BjCT1SjyQs8sZCkMBTGYRFCeyySWJA
         O/7ok8P7fjN8sHCNoFQYVBS7eacPe1ifMm/iycXaGPGR3RGLlfAmpCY+IduPHJdpnQ
         MrIqLI8dDhyeA==
Date:   Tue, 12 Apr 2022 20:56:19 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Ariel Marcovitch <arielmarcovitch@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: False positive kmemleak report for dtb properties names on
 powerpc
Message-ID: <YlW9Q05HDWwSmr7l@kernel.org>
References: <9dd08bb5-f39e-53d8-f88d-bec598a08c93@gmail.com>
 <YjtXXlnbEp64eL0T@arm.com>
 <Yjtvtkn+CishCef6@kernel.org>
 <2603cae9-3b75-cd13-1d41-2f1bed6ca32e@gmail.com>
 <a9d13878-7820-d41c-9357-135094c8357f@csgroup.eu>
 <87pmlm6bn0.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pmlm6bn0.fsf@mpe.ellerman.id.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 04:47:47PM +1000, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> > Hi Ariel
> >
> > Le 09/04/2022 à 15:47, Ariel Marcovitch a écrit :
> >> Hi Christophe, did you get the chance to look at this?
> >
> > I tested something this morning, it works for me, see below
> >
> >> 
> >> On 23/03/2022 21:06, Mike Rapoport wrote:
> >>> Hi Catalin,
> >>>
> >>> On Wed, Mar 23, 2022 at 05:22:38PM +0000, Catalin Marinas wrote:
> >>>> Hi Ariel,
> >>>>
> >>>> On Fri, Feb 18, 2022 at 09:45:51PM +0200, Ariel Marcovitch wrote:
> >>>>> I was running a powerpc 32bit kernel (built using
> >>>>> qemu_ppc_mpc8544ds_defconfig
> >>>>> buildroot config, with enabling DEBUGFS+KMEMLEAK+HIGHMEM in the kernel
> >>>>> config)
> >
> > ...
> >
> >>>>> I don't suppose I can just shuffle the calls in setup_arch() around, 
> >>>>> so I
> >>>>> wanted to hear your opinions first
> >>>> I think it's better if we change the logic than shuffling the calls.
> >>>> IIUC MEMBLOCK_ALLOC_ACCESSIBLE means that __va() works on the phys
> >>>> address return by memblock, so something like below (untested):
> >>> MEMBLOCK_ALLOC_ACCESSIBLE means "anywhere", see commit e63075a3c937
> >>> ("memblock: Introduce default allocation limit and use it to replace
> >>> explicit ones"), so it won't help to detect high memory.
> >>>
> >>> If I remember correctly, ppc initializes memblock *very* early, so 
> >>> setting
> >>> max_low_pfn along with lowmem_end_addr in
> >>> arch/powerpc/mm/init_32::MMU_init() makes sense to me.
> >>>
> >>> Maybe ppc folks have other ideas...
> >>> I've added Christophe who works on ppc32 these days.
> >
> > I think memblock is already available at the end of MMU_init() on PPC32 
> > and at the end of early_setup() on PPC64. It means it is ready when we 
> > enter setup_arch().
> >
> > I tested the change below, it works for me, I don't get any kmemleak 
> > report anymore.
> >
> > diff --git a/arch/powerpc/kernel/setup-common.c 
> > b/arch/powerpc/kernel/setup-common.c
> > index 518ae5aa9410..9f4e50b176c9 100644
> > --- a/arch/powerpc/kernel/setup-common.c
> > +++ b/arch/powerpc/kernel/setup-common.c
> > @@ -840,6 +840,9 @@ void __init setup_arch(char **cmdline_p)
> >   	/* Set a half-reasonable default so udelay does something sensible */
> >   	loops_per_jiffy = 500000000 / HZ;
> >
> > +	/* Parse memory topology */
> > +	mem_topology_setup();
> > +
> >   	/* Unflatten the device-tree passed by prom_init or kexec */
> >   	unflatten_device_tree();
> 
> The 64-bit/NUMA version of mem_topology_setup() requires the device tree
> to be unflattened, so I don't think that can work.
> 
> Setting max_low_pfn etc in MMU_init() as Mike suggested seems more
> likely to work.
> 
> But we might need to set it again in mem_topology_setup() though, so
> that things that change memblock_end_of_DRAM() are reflected, eg. memory
> limit or crash dump?

I don't think this can cause issues for kmemleak Ariel reported. The
kmemleak checks if there is a linear mapping for a PFN or that PFN is only
accessible via HIGHMEM. Memory limit or crash dump won't change the split,
or am I missing something?
 
> cheers

-- 
Sincerely yours,
Mike.
