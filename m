Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCB8597F38
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 09:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243362AbiHRH2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 03:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241717AbiHRH2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 03:28:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC9E4E613
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 00:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pW1/5rYq0S/VSHO+khmNewkH3TTeLKwfeQrhQZaS0bE=; b=JmPNsclJgWX0IB/5CwfFlGKdzP
        PoK1LL9VsZvW5crT4lLZAyHbxBTAJBe8dIXfOF7uoXL1bOh85p3DkdQWf2hgC4AfhkYmToJZP9biK
        xVbjLMknEjiP9D3RbXVP5IEOVrANxZIWW+rFb/D2sZH3qQIiRo/ceRw9DcQ+1Wdh7A9efjllGNJvj
        lqTbcvUelfHeKMoStByY8KBcgLIUfOp0+i4oO3R+O1fNXMZzx2voQe5+PAys7HpR16Bn35xisWmNa
        lnDrLvSwIua3YA6JvboJudfnn9J6cLndBW5vRwmvfm5Etm6HOtmtSQTGNSJv5kxfZkxw1TFRKsask
        8Iv5znxw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOZxA-003WFE-HT; Thu, 18 Aug 2022 07:28:33 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B99A1980083; Thu, 18 Aug 2022 09:28:28 +0200 (CEST)
Date:   Thu, 18 Aug 2022 09:28:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Su, Heng" <heng.su@intel.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>, pbonzini@redhat.com,
        x86@kernel.org
Subject: Re: [PATCH] x86/kvm, objtool: Avoid fastop ENDBR from being sealed
Message-ID: <Yv3qHNGBM2aU2NuA@worktop.programming.kicks-ass.net>
References: <PH0PR11MB4839B4D2FB8B8D8D52A62C7F9A629@PH0PR11MB4839.namprd11.prod.outlook.com>
 <YvzJTxOwmikAlZ6j@worktop.programming.kicks-ass.net>
 <20220818011045.v4baekgxajylqxvh@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818011045.v4baekgxajylqxvh@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 06:10:45PM -0700, Josh Poimboeuf wrote:
> On Wed, Aug 17, 2022 at 12:56:15PM +0200, Peter Zijlstra wrote:
> > Add (yet another) annotation to inhibit objtool from sealing a specific
> > ENDBR instance.
> 
> Nah, just add a throwaway reference to the function.  Then no objtool
> change is needed:

Nice!, should I 'borrow' this and respin the patch or you want to make a
real patch out of it?

> diff --git a/arch/x86/include/asm/ibt.h b/arch/x86/include/asm/ibt.h
> index 689880eca9ba..3ae795150374 100644
> --- a/arch/x86/include/asm/ibt.h
> +++ b/arch/x86/include/asm/ibt.h
> @@ -31,6 +31,16 @@
>  
>  #define __noendbr	__attribute__((nocf_check))
>  
> +/*
> + * Create a dummy function pointer reference to prevent objtool from marking
> + * the function as needing to be "sealed" (i.e. ENDBR converted to NOP by
> + * apply_ibt_endbr()).
> + */
> +#define IBT_NOSEAL(fname)				\
> +	".pushsection .discard.endbr.noseal\n\t"	\
> +	_ASM_PTR fname "\n\t"				\
> +	".popsection\n\t"
> +
>  static inline __attribute_const__ u32 gen_endbr(void)
>  {
>  	u32 endbr;
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index f8382abe22ff..88623add0db4 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -316,7 +316,8 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
>  	".align " __stringify(FASTOP_SIZE) " \n\t" \
>  	".type " name ", @function \n\t" \
>  	name ":\n\t" \
> -	ASM_ENDBR
> +	ASM_ENDBR \
> +	IBT_NOSEAL(name)
>  
>  #define FOP_FUNC(name) \
>  	__FOP_FUNC(#name)
