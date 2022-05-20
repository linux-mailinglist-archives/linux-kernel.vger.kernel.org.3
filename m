Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792D852E6EC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346806AbiETIFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346841AbiETIFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:05:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45F015E604
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 01:05:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A37FB82A5B
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E373C385A9;
        Fri, 20 May 2022 08:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653033897;
        bh=2+UsR8SY09lQomSf/1VOLFJ4QEsxG2ZXRneVf/dRIRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PLGFqZccKSIjEgIWJN2VKqwQzgxTVsmT1Os/COyLLsf72r3km7q6scL8RKqTvMzGH
         fGGyAXIDxmixCis7kbCQUDTIFR+kkCMEKpDbG44/e4AT9f73rI8rmDq7IZV/NiGMYo
         fj2GQzGF5i1bTCoYocEVOl3Wu1H4tz94tet7vKNJd8ogrKJWWzKFu3b62ZZaZqMebv
         3mWP3KnJvOYxTn02uLcE6bF8pPkk9iTHX4Kbr1IRhEfO6zSuL2V4+3PEzB9wns8iV9
         D7I2+rPaUBv+4OIfsw3KtPCyb/q5GcgyQQzGLobuGO4KxLZJm2PW+mqJug7Ax53DtE
         KLNrk+p+H7yFw==
Received: by pali.im (Postfix)
        id 3491053E; Fri, 20 May 2022 10:04:54 +0200 (CEST)
Date:   Fri, 20 May 2022 10:04:54 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Ash Logan <ash@heyquark.com>
Cc:     paulus@samba.org, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        robh+dt@kernel.org, benh@kernel.crashing.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        j.ne@posteo.net
Subject: Re: [PATCH 11/12] powerpc: wiiu: don't enforce flat memory
Message-ID: <20220520080454.c3cqodsdbfbkmg56@pali>
References: <20220302044406.63401-1-ash@heyquark.com>
 <20220302044406.63401-12-ash@heyquark.com>
 <20220513224353.n56qg5fhstbaqhfz@pali>
 <d84e4d24-f350-80fc-6c31-b7e7f8d429f4@heyquark.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d84e4d24-f350-80fc-6c31-b7e7f8d429f4@heyquark.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 May 2022 13:41:04 Ash Logan wrote:
> On 14/5/22 08:43, Pali Rohár wrote:
> > On Wednesday 02 March 2022 15:44:05 Ash Logan wrote:
> >> pgtable_32.c:mapin_ram loops over each valid memory range, which means
> >> non-contiguous memory just works.
> > 
> > Hello! Does it mean that non-contiguous memory works for any 32-bit
> > powerpc platform, and not only for wiiu? If yes, should not be
> > non-contiguous memory support enabled for all 32-bit ppc boards then?
> 
> Hi! Sorry for my delayed response. As best I can tell, it does indeed
> Just Work, but I have only been able to test on wiiu which is missing a
> lot of features other boards have (like PCI) - so it's possible there's
> still an assumption elsewhere in the kernel that I haven't hit.
> 
> As best I can tell, the Wii and Wii U are the only 32-bit powerpc boards
> out there where it's even possible to have non-contiguous memory.

What is the reason that those two boards are the **only**? Is there some
specific requirement from bootloader or hardware to "enable"
non-contiguous memory support?

I'm interested in enabling non-contiguous memory support for P2020-based
board as it has gaps in its 32-bit memory layout and which could be used
for RAM mapping when 4GB DDR3 module is plugged in (default is 2GB).

> >> Signed-off-by: Ash Logan <ash@heyquark.com>
> >> ---
> >>  arch/powerpc/mm/init_32.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
> >> index 3d690be48e84..59a84629d9a0 100644
> >> --- a/arch/powerpc/mm/init_32.c
> >> +++ b/arch/powerpc/mm/init_32.c
> >> @@ -125,10 +125,10 @@ void __init MMU_init(void)
> >>  	 * lowmem_end_addr is initialized below.
> >>  	 */
> >>  	if (memblock.memory.cnt > 1) {
> >> -#ifndef CONFIG_WII
> >> +#if !defined(CONFIG_WII) && !defined(CONFIG_WIIU)
> >>  		memblock_enforce_memory_limit(memblock.memory.regions[0].size);
> >>  		pr_warn("Only using first contiguous memory region\n");
> >> -#else
> >> +#elif defined(CONFIG_WII)
> >>  		wii_memory_fixups();
> >>  #endif
> >>  	}
> >> -- 
> >> 2.35.1
> >>
