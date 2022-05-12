Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A295352555F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 21:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357885AbiELTHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 15:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357878AbiELTHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 15:07:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8C82457B9;
        Thu, 12 May 2022 12:07:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 103EE61B87;
        Thu, 12 May 2022 19:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD27CC385B8;
        Thu, 12 May 2022 19:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652382422;
        bh=UAhhpbytMvD5GfxmgGkk/MtSBThhQKdLGrX/1MNtNA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ngO8388PC0TyRKE6gLj7jvwizRWRPkJKgXmmKrxbqDGcTq1kvkKMFwlRuhdcfOreR
         F19MBziPbLyG6srNayZkpqIworEmPnsbdVXw4ZKh/ePQ/sh5f0DuZ6Oo7qGy/mN12e
         Ix0ubp1oYNMDSlYrYryPW6LBd9MF0q7Xs60lLkoesQP3x8ALiELwb0nCl51tZfYnoy
         gTnX0Kaqsi8lBUP7QWqDMIkG+VS2GEZHpd2RVsVYEQKdWs+YTJgv6uCUlcsrUdj5hu
         vqcpfBOBPturfU1Pfhvms+qNzjJa+92sS1kIQcX4BMRr8MG945W+KEy4o8YmiIUVEq
         nIdCzP0vRn5rw==
Date:   Thu, 12 May 2022 12:06:59 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jonas Paulsson <paulsson@linux.vnet.ibm.com>,
        Ulrich Weigand <ulrich.weigand@de.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 4/8] s390/entry: workaround llvm's IAS limitations
Message-ID: <Yn1a01xhijM5MH1o@dev-arch.thelio-3990X>
References: <20220511120532.2228616-1-hca@linux.ibm.com>
 <20220511120532.2228616-5-hca@linux.ibm.com>
 <YnvynSZfF/8I8vmT@dev-arch.thelio-3990X>
 <Yn1CyTcrZk1Kgvoq@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn1CyTcrZk1Kgvoq@osiris>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 07:24:25PM +0200, Heiko Carstens wrote:
> On Wed, May 11, 2022 at 10:30:05AM -0700, Nathan Chancellor wrote:
> > Hi Heiko,
> > 
> > On Wed, May 11, 2022 at 02:05:28PM +0200, Heiko Carstens wrote:
> > > llvm's integrated assembler cannot handle immediate values which are
> > > calculated with two local labels:
> > > 
> > > <instantiation>:3:13: error: invalid operand for instruction
> > >  clgfi %r14,.Lsie_done - .Lsie_gmap
> > > 
> > > Workaround this by adding clang specific code which reads the specific
> > > value from memory. Since this code is within the hot paths of the kernel
> > > and adds an additional memory reference, keep the original code, and add
> > > ifdef'ed code.
> > > 
> > > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> > > ---
> > >  arch/s390/kernel/entry.S | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
> > > index e1664b45090f..ff7a75078e93 100644
> > > --- a/arch/s390/kernel/entry.S
> > > +++ b/arch/s390/kernel/entry.S
> > > @@ -171,8 +171,19 @@ _LPP_OFFSET	= __LC_LPP
> > >  	.macro OUTSIDE reg,start,end,outside_label
> > >  	larl	%r14,\start
> > >  	slgrk	%r14,\reg,%r14
> > > +#ifdef CONFIG_CC_IS_CLANG
> > 
> > I intend to put this series through my build and boot test matrix later
> > today but one fly by comment in the meantime. Should this be
> > CONFIG_AS_IS_LLVM if this is an integrated assembler limitation, rather
> > than a clang one?
> 
> Yes, that makes a lot of sense. Considering that I will drop the
> previous patch within this series, the new version looks like:
> 
> From fe4fb0b014378d84ae517deaea338577b2ea6ae0 Mon Sep 17 00:00:00 2001
> From: Heiko Carstens <hca@linux.ibm.com>
> Date: Sat, 7 May 2022 15:00:40 +0200
> Subject: [PATCH 3/7] s390/entry: workaround llvm's IAS limitations
> 
> llvm's integrated assembler cannot handle immediate values which are
> calculated with two local labels:
> 
> <instantiation>:3:13: error: invalid operand for instruction
>  clgfi %r14,.Lsie_done - .Lsie_gmap
> 
> Workaround this by adding clang specific code which reads the specific
> value from memory. Since this code is within the hot paths of the kernel
> and adds an additional memory reference, keep the original code, and add
> ifdef'ed code.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/entry.S | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
> index a6b45eaa3450..f2f30bfba1e9 100644
> --- a/arch/s390/kernel/entry.S
> +++ b/arch/s390/kernel/entry.S
> @@ -172,9 +172,19 @@ _LPP_OFFSET	= __LC_LPP
>  	lgr	%r14,\reg
>  	larl	%r13,\start
>  	slgr	%r14,%r13
> -	lghi	%r13,\end - \start
> -	clgr	%r14,%r13
> +#ifdef CONFIG_AS_IS_LLVM
> +	clgfrl	%r14,.Lrange_size\@
> +#else
> +	clgfi	%r14,\end - \start
> +#endif
>  	jhe	\outside_label
> +#ifdef CONFIG_CC_IS_CLANG

I think this one also wants to be CONFIG_AS_IS_LLVM, right?

Other than that, seems fine to me, although I have no knowledge of s390
assembly so that statement probably means next to nothing :)

Cheers,
Nathan

> +	.section .rodata, "a"
> +	.align 4
> +.Lrange_size\@:
> +	.long	\end - \start
> +	.previous
> +#endif
>  	.endm
>  
>  	.macro SIEEXIT
> -- 
> 2.32.0
