Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9383854C525
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346292AbiFOJwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236849AbiFOJwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:52:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10ECE167FB;
        Wed, 15 Jun 2022 02:52:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2594152B;
        Wed, 15 Jun 2022 02:52:51 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.38.208])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C56BF3F792;
        Wed, 15 Jun 2022 02:52:49 -0700 (PDT)
Date:   Wed, 15 Jun 2022 10:52:41 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-mips@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 3/3] jump_label: make initial NOP patching the special
 case
Message-ID: <Yqmr6fvu4OYkarCm@FVFF77S0Q05N>
References: <20220608104512.1176209-1-ardb@kernel.org>
 <20220608104512.1176209-4-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608104512.1176209-4-ardb@kernel.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 12:45:12PM +0200, Ard Biesheuvel wrote:
> Instead of defaulting to patching NOP opcodes at init time, and leaving
> it to the architectures to override this if this is not needed, switch
> to a model where doing nothing is the default. This is the common case
> by far, as only MIPS requires NOP patching at init time. On all other
> architectures, the correct encodings are emitted by the compiler and so
> no initial patching is needed.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  Documentation/staging/static-keys.rst |  3 ---
>  arch/arc/kernel/jump_label.c          | 13 -------------
>  arch/arm/kernel/jump_label.c          |  6 ------
>  arch/arm64/kernel/jump_label.c        | 11 -----------
>  arch/mips/include/asm/jump_label.h    |  2 ++
>  arch/parisc/kernel/jump_label.c       | 11 -----------
>  arch/riscv/kernel/jump_label.c        | 12 ------------
>  arch/s390/kernel/jump_label.c         |  5 -----
>  arch/x86/kernel/jump_label.c          | 13 -------------
>  kernel/jump_label.c                   | 14 +++-----------
>  10 files changed, 5 insertions(+), 85 deletions(-)

I have one minor comment below, but either way this is a nice cleanup (and I'm
always happy to see __weak functions disappear), so FWIW:

  Acked-by: Mark Rutland <mark.rutland@arm.com>

[...]

> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> index b1ac2948be79..ff8576c00893 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -332,17 +332,9 @@ static int __jump_label_text_reserved(struct jump_entry *iter_start,
>  	return 0;
>  }
>  
> -/*
> - * Update code which is definitely not currently executing.
> - * Architectures which need heavyweight synchronization to modify
> - * running code can override this to make the non-live update case
> - * cheaper.
> - */
> -void __weak __init_or_module arch_jump_label_transform_static(struct jump_entry *entry,
> -					    enum jump_label_type type)
> -{
> -	arch_jump_label_transform(entry, type);
> -}
> +#ifndef arch_jump_label_transform_static
> +#define arch_jump_label_transform_static(entry, type)
> +#endif

It might be slightly better to make this a static inline stub so that we always
get the compiler to type-check it, e.g.

| #ifndef arch_jump_label_transform_static
| static inline void arch_jump_label_transform_static(struct jump_entry *entry,
| 						    enum jump_label_type type)
| {
| 	/* nothing to do on most architectures */
| }
| #define arch_jump_label_transform_static arch_jump_label_transform_static
| #endif

Mark.
