Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B2A523B8B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345570AbiEKRaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239654AbiEKRaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:30:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561387890B;
        Wed, 11 May 2022 10:30:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 115C0B82529;
        Wed, 11 May 2022 17:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B52C340EE;
        Wed, 11 May 2022 17:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652290207;
        bh=WvIKEZHgEn+Dq25Zw6Rksrl5jKHKzLQEMQqd1N3j2Ko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GFN6k71AHMTgNwJwkH1IqkuKUozdUKqDNTuKbJ2jJ+BaNtNcV4i/l9n1TSzaUH6oA
         p/Q/MWNZfRv99aOZ6I/p8457maoeuz7iUx+Xqb3/SXGTny37hRQe+jY+b5uN+n/CC5
         RJRhLeHl7oPmsIVTDDiQzUpKWmeeOPyuB+dGUw3lMqZZSlBCF9zk9hVsAq7ITXs2G4
         +RzhJFL77Q2N/y/VqzXgO3evkSHPIg7MDkPRSI2vgwPYBFLNeLds8AScgtCLxzamRl
         /EKA49IJd5x/zajQO1DbTb3+bM5me72u1MHoxpoaNVufOZcVhJuhl9r8mCTdkG1/DU
         r3DcvRmJDTG7g==
Date:   Wed, 11 May 2022 10:30:05 -0700
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
Message-ID: <YnvynSZfF/8I8vmT@dev-arch.thelio-3990X>
References: <20220511120532.2228616-1-hca@linux.ibm.com>
 <20220511120532.2228616-5-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511120532.2228616-5-hca@linux.ibm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Wed, May 11, 2022 at 02:05:28PM +0200, Heiko Carstens wrote:
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
>  arch/s390/kernel/entry.S | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
> index e1664b45090f..ff7a75078e93 100644
> --- a/arch/s390/kernel/entry.S
> +++ b/arch/s390/kernel/entry.S
> @@ -171,8 +171,19 @@ _LPP_OFFSET	= __LC_LPP
>  	.macro OUTSIDE reg,start,end,outside_label
>  	larl	%r14,\start
>  	slgrk	%r14,\reg,%r14
> +#ifdef CONFIG_CC_IS_CLANG

I intend to put this series through my build and boot test matrix later
today but one fly by comment in the meantime. Should this be
CONFIG_AS_IS_LLVM if this is an integrated assembler limitation, rather
than a clang one?

> +	clgfrl	%r14,.Lrange_size\@
> +#else
>  	clgfi	%r14,\end - \start
> +#endif
>  	jhe	\outside_label
> +#ifdef CONFIG_CC_IS_CLANG
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
> 
> 

Cheers,
Nathan
