Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436E84635BC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhK3NtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhK3NtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:49:12 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63ADC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 05:45:53 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [80.241.60.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4J3Nlf29wCzQjgG;
        Tue, 30 Nov 2021 14:45:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1638279947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ItI444G9e5tXrP/g4X348MAJhSBK9T/nqdzoxQSk2I=;
        b=h9aIgWAnQJz9DAnlN7AgJI3JYRj2oFrTby7AHHS4j74xzpm1ZpCFz8A+zGm40ZzeaZraEk
        XNWc1EnoAks4s0E8JEW6CVm75CZ49rPQ2+IKr92Z4eAohs67aN/0xoqi9M34B0EJp/HVQf
        +82zBznhJC4Kt/z/AQrHsaPMGzpgebI28+MMbQVZ3rwSkGoqxc8X7kBzLwqCyYeugRCWme
        y4ouOC1RFtOni5e1my5RGg4hNICxmQQkcakAYsVh0SzXpFCE64yyBMAM2GRJfwApRPctfD
        pyyOddFogTsjoKY6XhEX2SQBFV7+KPHsUViMhp+lHzD1kH7LSKc08vAoXIOPsA==
Date:   Tue, 30 Nov 2021 14:45:41 +0100
From:   "Erhard F." <erhard_f@mailbox.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/32s: Fix shift-out-of-bounds in KASAN init
Message-ID: <20211130144541.2597f936@yea>
In-Reply-To: <15cbc3439d4ad988b225e2119ec99502a5cc6ad3.1638261744.git.christophe.leroy@csgroup.eu>
References: <15cbc3439d4ad988b225e2119ec99502a5cc6ad3.1638261744.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 09:42:37 +0100
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> ================================================================================
> UBSAN: shift-out-of-bounds in arch/powerpc/mm/kasan/book3s_32.c:22:23
> shift exponent -1 is negative
> CPU: 0 PID: 0 Comm: swapper Not tainted 5.15.5-gentoo-PowerMacG4 #9
> Call Trace:
> [c214be60] [c0ba0048] dump_stack_lvl+0x80/0xb0 (unreliable)
> [c214be80] [c0b99288] ubsan_epilogue+0x10/0x5c
> [c214be90] [c0b98fe0] __ubsan_handle_shift_out_of_bounds+0x94/0x138
> [c214bf00] [c1c0f010] kasan_init_region+0xd8/0x26c
> [c214bf30] [c1c0ed84] kasan_init+0xc0/0x198
> [c214bf70] [c1c08024] setup_arch+0x18/0x54c
> [c214bfc0] [c1c037f0] start_kernel+0x90/0x33c
> [c214bff0] [00003610] 0x3610
> ================================================================================
> 
> This happens when the directly mapped memory is a power of 2.
> 
> Fix it by checking the shift and set the result to 0 when shift is -1
> 
> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215169
> Fixes: 7974c4732642 ("powerpc/32s: Implement dedicated kasan_init_region()")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/mm/kasan/book3s_32.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/kasan/book3s_32.c b/arch/powerpc/mm/kasan/book3s_32.c
> index 202bd260a009..35b287b0a8da 100644
> --- a/arch/powerpc/mm/kasan/book3s_32.c
> +++ b/arch/powerpc/mm/kasan/book3s_32.c
> @@ -19,7 +19,8 @@ int __init kasan_init_region(void *start, size_t size)
>  	block = memblock_alloc(k_size, k_size_base);
>  
>  	if (block && k_size_base >= SZ_128K && k_start == ALIGN(k_start, k_size_base)) {
> -		int k_size_more = 1 << (ffs(k_size - k_size_base) - 1);
> +		int shift = ffs(k_size - k_size_base);
> +		int k_size_more = shift ? 1 << (shift - 1) : 0;
>  
>  		setbat(-1, k_start, __pa(block), k_size_base, PAGE_KERNEL);
>  		if (k_size_more >= SZ_128K)
> -- 
> 2.33.1
> 

Tested Christophes patch applied on 5.15.5 which works fine. Thanks!

I'll close the bugzilla report once it gets into stable.

Regards
Erhard
