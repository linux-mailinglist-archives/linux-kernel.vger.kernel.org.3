Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED3D57D138
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbiGUQRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbiGUQQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:16:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025878BABD;
        Thu, 21 Jul 2022 09:15:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 50D06CE2665;
        Thu, 21 Jul 2022 16:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE73C3411E;
        Thu, 21 Jul 2022 16:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658420104;
        bh=bc+HNadWZW5/Ebtg39b5IGqTWAWv9J8k07Uo8LXCfew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e2BkRgffYqa1p0Ky6qJNOMVTlJp4lZExi6dbD0hPpPrBciRvRQBaV960i8l4PIEYY
         4gNnbR0fq1l04GziqepX2uFXK3zboi7aNBlyFi4//ByHPgq97wgYWIlunTszyjmyf2
         4rSp7iOqeQNOa/HyuzmhKWeaG1Re8dHRPWoOAbf/gHyCfigHEDbYfHWH136PVW8IEp
         //0oi24afVkFn+Wntc4eVkZ0AbLbWQHbuQgxIZAjv9hTFeZwBddLZ89KZQqgNkTjK9
         hhveIweq0F0ddhSamlvu+6u0fjlUWExrBdpyqu5CT0sI/Ei62Qhq2WvkZYQ5wtrbFZ
         qRLDJBQ+WYCXQ==
Date:   Thu, 21 Jul 2022 17:14:58 +0100
From:   Will Deacon <will@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Peter Collingbourne <pcc@google.com>
Subject: Re: linux-next: manual merge of the arm64 tree with the arm64-fixes
 tree
Message-ID: <20220721161458.GA17567@willie-the-truck>
References: <20220721094512.5419f75f@canb.auug.org.au>
 <20220721204517.53bab2a3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721204517.53bab2a3@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, Jul 21, 2022 at 08:45:17PM +1000, Stephen Rothwell wrote:
> On Thu, 21 Jul 2022 09:45:12 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the arm64 tree got a conflict in:
> > 
> >   arch/arm64/kernel/head.S
> > 
> > between commit:
> > 
> >   f7b4c3b82e7d ("arm64: set UXN on swapper page tables")
> > 
> > from the arm64-fixes tree and commits:
> > 
> >   e42ade29e3bc ("arm64: head: split off idmap creation code")
> >   c3cee924bd85 ("arm64: head: cover entire kernel image in initial ID map")
> > 
> > from the arm64 tree.
> > 
> > I didn't know if the change from the former was still needed after the
> > changes in the latter, so I left it out for now.
> 
> OK, so my arm64 defconfig build produced these errors:
> 
> arch/arm64/kernel/head.S: Assembler messages:
> arch/arm64/kernel/head.S:334: Error: immediate cannot be moved by a single instruction
> arch/arm64/kernel/head.S:343: Error: immediate cannot be moved by a single instruction
> arch/arm64/kernel/head.S:354: Error: immediate cannot be moved by a single instruction
> arch/arm64/kernel/head.S:379: Error: immediate cannot be moved by a single instruction
> arch/arm64/mm/proc.S:296: Error: immediate cannot be moved by a single instruction
> 
> So I tried this patch:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 21 Jul 2022 20:21:36 +1000
> Subject: [PATCH] fixup for "arm64: set UXN on swapper page tables"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/arm64/kernel/head.S | 8 ++++----
>  arch/arm64/mm/proc.S     | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index cefe6a73ee54..aa7c58689f68 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -331,7 +331,7 @@ SYM_FUNC_START_LOCAL(create_idmap)
>  	adrp	x0, init_idmap_pg_dir
>  	adrp	x3, _text
>  	adrp	x6, _end + MAX_FDT_SIZE + SWAPPER_BLOCK_SIZE
> -	mov	x7, SWAPPER_RX_MMUFLAGS
> +	mov_q	x7, SWAPPER_RX_MMUFLAGS

[...]

I think Marc posted something similar here:

https://lore.kernel.org/r/20220721124244.903567-1-maz@kernel.org

but in further discussion offline (and echoed on that thread), we've decided
to drop f7b4c3b82e7d ("arm64: set UXN on swapper page tables") for now; the
issue it addresses doesn't affect the hardware which is readily available at
the moment so we'll just get it into -stable instead rather than disrupt
everything at this stage in the release cycle.

> So I gave up and left arm64 broken for today :-(

No problem, thank you for trying and hopefully it will be better tomorrow
once we've dropped that commit.

Will
