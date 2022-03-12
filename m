Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E774D70FE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 22:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbiCLVTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 16:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiCLVTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 16:19:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9232752E47
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 13:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tq7dwFIJbITsNO2LekYJLHOEN8UGoQm1/wacvzkLbv0=; b=QEGGguWEurttr7a484QMGxNOnT
        bMcz2DoLTNGga+oL/TL05wvm6YSQAHWk1UGQWNdZpawwzDSpMODKCE8Reqb5uHEp3NlpxeWuU0Fua
        jImJdMMiRFQthX5KfgIaJYUSVHZNDmJYNf0ttCAAVVaywxSOaDKFJo5wFhtppdhlh/Zq+077dacIp
        1t18ytWYfLJ0mGPzt3z/S9nYt2jJxp3szQFxeZ20gcpi/XdnbnNfytzbczsbfyY8n8ow/tEb7aMHH
        NduGxYyn+no5uDWLMBby8ZKIpXI2wetN0W7v9fKly2hdJ75v7AtWZAmsWrfEtNcV0CLGbqw+i8lRB
        2oQPsn4w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nT97O-002hIm-J3; Sat, 12 Mar 2022 21:17:43 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 499A1987D0D; Sat, 12 Mar 2022 22:17:40 +0100 (CET)
Date:   Sat, 12 Mar 2022 22:17:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] x86/alternative: record .altinstructions section
 entity size
Message-ID: <20220312211740.GG28057@worktop.programming.kicks-ass.net>
References: <20220311144312.88466-1-adobriyan@gmail.com>
 <20220311144312.88466-3-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311144312.88466-3-adobriyan@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 05:43:10PM +0300, Alexey Dobriyan wrote:
> .altinstructions entry was 12 bytes in size, then it was 13 bytes,
> now it is 12 again. It was 24 bytes on some distros as well.
> Record this information as section sh_entsize value so that tools
> which parse .altinstructions have easier time.

Which tools would that be? Because afaict you've not actually updated
objtool.

> Signed-off-by: Alexey Dobriyan (CloudLinux) <adobriyan@gmail.com>
> ---
>  arch/x86/include/asm/alternative.h | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
> index 58eee6402832..cf7722a106b3 100644
> --- a/arch/x86/include/asm/alternative.h
> +++ b/arch/x86/include/asm/alternative.h
> @@ -9,6 +9,8 @@
>  #define ALTINSTR_FLAG_INV	(1 << 15)
>  #define ALT_NOT(feat)		((feat) | ALTINSTR_FLAG_INV)
>  
> +#define sizeof_struct_alt_instr 12
> +
>  #ifndef __ASSEMBLY__
>  
>  #include <linux/stddef.h>
> @@ -66,6 +68,7 @@ struct alt_instr {
>  	u8  instrlen;		/* length of original instruction */
>  	u8  replacementlen;	/* length of new instruction */
>  } __packed;
> +_Static_assert(sizeof(struct alt_instr) == sizeof_struct_alt_instr, "");

Would it not be much simpler to have this in asm-offsets.h ?

> +	".pushsection .altinstructions,\"aM\",@progbits," __stringify(sizeof_struct_alt_instr) "\n"\
> +	".pushsection .altinstructions,\"aM\",@progbits," __stringify(sizeof_struct_alt_instr) "\n"\
> +	".pushsection .altinstructions,\"aM\",@progbits," __stringify(sizeof_struct_alt_instr) "\n"\

> +	.pushsection .altinstructions,"aM",@progbits,sizeof_struct_alt_instr
> +	.pushsection .altinstructions,"aM",@progbits,sizeof_struct_alt_instr

Aside of adding entsize, you're also adding the M(ergable) bit. Also,
those lines are on the unwieldy side of things.
