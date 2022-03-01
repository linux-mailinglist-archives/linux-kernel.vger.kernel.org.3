Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A364C8DC7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbiCAOcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbiCAOci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:32:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC844A1472;
        Tue,  1 Mar 2022 06:31:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68B04615A3;
        Tue,  1 Mar 2022 14:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE37C340EE;
        Tue,  1 Mar 2022 14:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646145115;
        bh=iJGcKs3EFTZxwY5OYzsHuFQIOWVuyWXpcuW8J5KMOfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XzEYZqdNO26snXjLDdHwtozmVQkSkeCS42yZ9Pk0EsfUBJI35V0icrfHKmRhDfEzt
         jABS9bDzz0ZNov4uq6Fp2s++Zyb4dW1GAa6FJthe0lk0pqMFXv+3KGRH+cSUJ1cxR5
         wYvcH9/9l+ciwXo2fjQwDTgLOaTdDtSXA+kA/dSgsNmsAO0BGasD7SyMWtMRrOTe/U
         QXiwtBs7BPdK95H3+C2hRD1OM5G/6FaYw4qaqiCkx1hVl+NIY3UHhX+LS2ndjFEqHn
         YlIk4DtjPzM5LJ/TLVK+SRoWGzo6pykfaO4pyTdEexL3ZwN1wYnt9mBmHHq5+WT/Vv
         p+hmtIJAarKOg==
Date:   Tue, 1 Mar 2022 16:31:46 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] MIPS: Modify mem= and memmap= parameter
Message-ID: <Yh4uUoYT+YS5Jxsv@kernel.org>
References: <1646108941-27919-1-git-send-email-yangtiezhu@loongson.cn>
 <Yh3tgr+g/6IElq0P@kernel.org>
 <cfd74b5b-39c3-733a-5226-515991f91f39@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfd74b5b-39c3-733a-5226-515991f91f39@loongson.cn>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 07:51:23PM +0800, Tiezhu Yang wrote:
> 
> 
> On 03/01/2022 05:55 PM, Mike Rapoport wrote:
> > Hi,
> > 
> > On Tue, Mar 01, 2022 at 12:28:57PM +0800, Tiezhu Yang wrote:
> > > In the current code, the kernel command-line parameter mem= and memmap=
> > > can not work well on MIPS, this patchset refactors the related code to
> > > fix them.
> > > 
> > > For kdump on MIPS, if the users want to limit the memory region for the
> > > capture kernel to avoid corrupting the memory image of the panic kernel,
> > > use the parameter memmap=limit@base is the proper way, I will submit a
> > > patch to use memmap=limit@base for kexec-tools after this patchset is
> > > applied.
> > 
> > Sorry, apparently I misread the prevoius version.
> > What's wrong with the current implementation of mem=limit@base for the
> > kdump case?
> 
> In the current code, without this patchset, kernel boot hangs when add
> mem=3G, mem=3G@64M or memmap=3G@64M to the command-line, it means that
> the parameter mem= and memmap= have bug on mips.

I can see how mem=3G may be wrong when the memory does not start at 0, but
it seems to do the right thing of mem=3G@64M. 

Do you see system hangs with mem=3G@64M?

Do you have the logs before the hang?

As for memmap= option, it does not specify the memory map but rather alters
the memory map passed by the firmware. Particularity in MIPS implementation
it allows to add a single range of available or reserved memory.

AFAIU, for the kdump use-case mem=X@Y should suffice.

> Thanks,
> Tiezhu
> 
> > 
> > > v4: Fix some build warnings reported by kernel test robot
> > > 
> > > v3: Modify patch #3 to maintain compatibility for memmap=limit{$,#,!}base,
> > >     commented by Mike Rapoport, thank you
> > > 
> > > v2: Add some new patches to support memmap=limit@base
> > > 
> > > Tiezhu Yang (4):
> > >   MIPS: Refactor early_parse_mem() to fix mem= parameter
> > >   memblock: Introduce memblock_mem_range_remove_map()
> > >   MIPS: Refactor early_parse_memmap() to fix memmap= parameter
> > >   MIPS: Remove not used variable usermem
> > > 
> > >  arch/mips/kernel/setup.c | 69 ++++++++++++++++++++++--------------------------
> > >  include/linux/memblock.h |  1 +
> > >  mm/memblock.c            |  9 +++++--
> > >  3 files changed, 40 insertions(+), 39 deletions(-)
> > > 
> > > --
> > > 2.1.0
> > > 
> > 
> 

-- 
Sincerely yours,
Mike.
