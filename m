Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904D9526D07
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 00:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384839AbiEMWoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 18:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349751AbiEMWoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 18:44:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB00C4B86E
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 15:43:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4149BB831EB
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 22:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9F9C34100;
        Fri, 13 May 2022 22:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652481836;
        bh=CijBO6wAUnPaCFQTl2hJH05BXYHWLo9sWJxBUdgdKoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ObSfTv7WKs96jZfkU1xpZM/cHsUgFN9XhcihtZr+JLZs2bE7cJWtRdFiOLCuEELBV
         BFPwv/vgXbiEqNviB7tWKSWcYi32cpJvRhAFzN9aC7g3VZZ4mPzm4OG/u+fMdKX9ch
         MRI5bkl3B/oc+bYOwqSo8zYN+jRjxc0b87h8AAO85VslQHPD+x/RF8d1kW9dcvPU+Z
         em5k2gFi5Vwp32LQEmTvX+8VHZW7cjKURGA1McGbgJA2RZn1v4HcWjt40VGFjYdFG9
         sSPqpEcq2btfkN+YJ1zmujV2kPKUje0nsGDTK1jPwS4iHLjD0c8kMLCXnOLjoxLF/z
         yu8L9P+aJhbwg==
Received: by pali.im (Postfix)
        id C9DA22B90; Sat, 14 May 2022 00:43:53 +0200 (CEST)
Date:   Sat, 14 May 2022 00:43:53 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Ash Logan <ash@heyquark.com>
Cc:     paulus@samba.org, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        robh+dt@kernel.org, benh@kernel.crashing.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        j.ne@posteo.net
Subject: Re: [PATCH 11/12] powerpc: wiiu: don't enforce flat memory
Message-ID: <20220513224353.n56qg5fhstbaqhfz@pali>
References: <20220302044406.63401-1-ash@heyquark.com>
 <20220302044406.63401-12-ash@heyquark.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302044406.63401-12-ash@heyquark.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 March 2022 15:44:05 Ash Logan wrote:
> pgtable_32.c:mapin_ram loops over each valid memory range, which means
> non-contiguous memory just works.

Hello! Does it mean that non-contiguous memory works for any 32-bit
powerpc platform, and not only for wiiu? If yes, should not be
non-contiguous memory support enabled for all 32-bit ppc boards then?

> Signed-off-by: Ash Logan <ash@heyquark.com>
> ---
>  arch/powerpc/mm/init_32.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
> index 3d690be48e84..59a84629d9a0 100644
> --- a/arch/powerpc/mm/init_32.c
> +++ b/arch/powerpc/mm/init_32.c
> @@ -125,10 +125,10 @@ void __init MMU_init(void)
>  	 * lowmem_end_addr is initialized below.
>  	 */
>  	if (memblock.memory.cnt > 1) {
> -#ifndef CONFIG_WII
> +#if !defined(CONFIG_WII) && !defined(CONFIG_WIIU)
>  		memblock_enforce_memory_limit(memblock.memory.regions[0].size);
>  		pr_warn("Only using first contiguous memory region\n");
> -#else
> +#elif defined(CONFIG_WII)
>  		wii_memory_fixups();
>  #endif
>  	}
> -- 
> 2.35.1
> 
