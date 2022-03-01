Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8557D4C8894
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbiCAJ4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbiCAJ4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:56:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D3B7C784;
        Tue,  1 Mar 2022 01:55:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFC5EB81850;
        Tue,  1 Mar 2022 09:55:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5F9C340EE;
        Tue,  1 Mar 2022 09:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646128521;
        bh=8YjTRp7NuUv65z90+NN5SmTpZZtNhw5jeBiXRggxlOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DQgKSnJwn0l0I3BAOltTsJBNcSxl6GThPSHqvZTrMtG6vLn7K0TWQp55sepHrgWYM
         FaWeEUl39+Q3V6gV4f816/foCdaz52QegnFGvDy3OwX5vbWefq9SDBieVs3iR/tS3w
         TdObEGBaWClFRA2pjr2oF4Kr56dDV/dyCXJg8KlOlFoBnEO1elGSkVEEiYzNac6+j0
         JBGu5BTq0xUAgqidKRXGvyW0VOvAonuD2IxhL4FBHvdGNLRIpwdu0pOEDVPvF+UBO3
         rw2sSBUHw1EYUvjbpxTG+bp2zvp3ZBjVesUryTsfizAZ7RgPnOq+7/jdbMy1ztLck6
         AY3caNkCuWQJA==
Date:   Tue, 1 Mar 2022 11:55:14 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] MIPS: Modify mem= and memmap= parameter
Message-ID: <Yh3tgr+g/6IElq0P@kernel.org>
References: <1646108941-27919-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646108941-27919-1-git-send-email-yangtiezhu@loongson.cn>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 01, 2022 at 12:28:57PM +0800, Tiezhu Yang wrote:
> In the current code, the kernel command-line parameter mem= and memmap=
> can not work well on MIPS, this patchset refactors the related code to
> fix them.
> 
> For kdump on MIPS, if the users want to limit the memory region for the
> capture kernel to avoid corrupting the memory image of the panic kernel,
> use the parameter memmap=limit@base is the proper way, I will submit a
> patch to use memmap=limit@base for kexec-tools after this patchset is
> applied.

Sorry, apparently I misread the prevoius version.
What's wrong with the current implementation of mem=limit@base for the
kdump case?
 
> v4: Fix some build warnings reported by kernel test robot
> 
> v3: Modify patch #3 to maintain compatibility for memmap=limit{$,#,!}base,
>     commented by Mike Rapoport, thank you
> 
> v2: Add some new patches to support memmap=limit@base
> 
> Tiezhu Yang (4):
>   MIPS: Refactor early_parse_mem() to fix mem= parameter
>   memblock: Introduce memblock_mem_range_remove_map()
>   MIPS: Refactor early_parse_memmap() to fix memmap= parameter
>   MIPS: Remove not used variable usermem
> 
>  arch/mips/kernel/setup.c | 69 ++++++++++++++++++++++--------------------------
>  include/linux/memblock.h |  1 +
>  mm/memblock.c            |  9 +++++--
>  3 files changed, 40 insertions(+), 39 deletions(-)
> 
> -- 
> 2.1.0
> 

-- 
Sincerely yours,
Mike.
