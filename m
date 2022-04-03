Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEC24F0CC8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 00:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376575AbiDCW16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 18:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376563AbiDCW1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 18:27:54 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0043982F
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 15:25:58 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 798AC1EC0391;
        Mon,  4 Apr 2022 00:25:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649024753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Hp4L2cVTqta3/N48brNHzNHGdOlT5FDTQPDHhtqZR6U=;
        b=RCrYpMKBIoF34czM4Y1d0g2hGszHWl+bZuGTBkhiYlQ9cEHHSM95JeUMDlG3Kob7dGxyfZ
        jDcoj9xVjPLAwwHHkYsbBGaBfMY80u59ea9UlZ49SIeLy+qLqAQsepWJgRePAjFgwzxLHH
        /lX8cg1Gi2aOZmW3m/KsvPbDc8uQl8U=
Date:   Mon, 4 Apr 2022 00:25:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] x86/alternative: simplify DUMP_BYTES macro
Message-ID: <Ykoe7zdOBAwDjSh+@zn.tnic>
References: <20220311144312.88466-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220311144312.88466-1-adobriyan@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 05:43:08PM +0300, Alexey Dobriyan wrote:
> Avoid zero length check with clever whitespace placement in the format
> string.
> 
> Signed-off-by: Alexey Dobriyan (CloudLinux) <adobriyan@gmail.com>
> ---
>  arch/x86/kernel/alternative.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 5007c3ffe96f..6c9758ee6810 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -66,13 +66,10 @@ do {									\
>  	if (unlikely(debug_alternative)) {				\
>  		int j;							\
>  									\
> -		if (!(len))						\
> -			break;						\
> -									\
>  		printk(KERN_DEBUG pr_fmt(fmt), ##args);			\
> -		for (j = 0; j < (len) - 1; j++)				\
> -			printk(KERN_CONT "%02hhx ", buf[j]);		\
> -		printk(KERN_CONT "%02hhx\n", buf[j]);			\
> +		for (j = 0; j < (len); j++)				\
> +			printk(KERN_CONT " %02hhx", buf[j]);		\
> +		printk(KERN_CONT "\n");					\
>  	}								\
>  } while (0)

That doesn't work always.

Before:

SMP alternatives: feat: 9*32+0, old: (current_save_fsgs+0x32/0xa0 (ffffffff81017762) len: 5), repl: (ffffffff89997c78, len: 0)
SMP alternatives: ffffffff81017762:   old_insn: eb 32 0f 1f 00
SMP alternatives: ffffffff81017762: final_insn: 90 90 90 90 90
SMP alternatives: ffffffff81017762: [0:5) optimized NOPs: 0f 1f 44 00 00


After:

SMP alternatives: feat: 9*32+0, old: (current_save_fsgs+0x32/0xa0 (ffffffff81017762) len: 5), repl: (ffffffff89997c78, len: 0)
SMP alternatives: ffffffff81017762:   old_insn: eb 32 0f 1f 00
SMP alternatives: ffffffff89997c78:   rpl_insn:			<----- *
SMP alternatives: ffffffff81017762: final_insn: 90 90 90 90 90
SMP alternatives: ffffffff81017762: [0:5) optimized NOPs: 0f 1f 44 00 00

there is no replacement insn in this case:

static __always_inline bool _static_cpu_has(u16 bit)
{
	asm_volatile_goto(
		ALTERNATIVE_TERNARY("jmp 6f", %P[feature], "", "jmp %l[t_no]")
						   	   ^^

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
