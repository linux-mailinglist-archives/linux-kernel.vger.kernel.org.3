Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3844C1D61
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 21:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241892AbiBWUzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 15:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241838AbiBWUzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 15:55:08 -0500
X-Greylist: delayed 330 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Feb 2022 12:54:37 PST
Received: from mx02.puc.rediris.es (outbound3sev.lav.puc.rediris.es [130.206.19.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35B64DF7E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 12:54:37 -0800 (PST)
Received: from mta-out03.sim.rediris.es (mta-out03.sim.rediris.es [130.206.24.45])
        by mx02.puc.rediris.es  with ESMTP id 21NKmHO5005544-21NKmHO7005544
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 23 Feb 2022 21:48:17 +0100
Received: from mta-out03.sim.rediris.es (localhost.localdomain [127.0.0.1])
        by mta-out03.sim.rediris.es (Postfix) with ESMTPS id 6237930004B1;
        Wed, 23 Feb 2022 21:48:17 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mta-out03.sim.rediris.es (Postfix) with ESMTP id 4F364306B1F1;
        Wed, 23 Feb 2022 21:48:17 +0100 (CET)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta-out03.sim.rediris.es
Received: from mta-out03.sim.rediris.es ([127.0.0.1])
        by localhost (mta-out03.sim.rediris.es [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SWZS_Scr0pjj; Wed, 23 Feb 2022 21:48:17 +0100 (CET)
Received: from lt-gp.iram.es (haproxy02.sim.rediris.es [130.206.24.70])
        by mta-out03.sim.rediris.es (Postfix) with ESMTPA id 33B8430004B1;
        Wed, 23 Feb 2022 21:48:16 +0100 (CET)
Date:   Wed, 23 Feb 2022 21:48:09 +0100
From:   Gabriel Paubert <paubert@iram.es>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Kees Cook <keescook@chromium.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32: Clear volatile regs on syscall exit
Message-ID: <YhadiVbwao/p2N7o@lt-gp.iram.es>
References: <28b040bd2357a1879df0ca1b74094323f778a472.1645636285.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28b040bd2357a1879df0ca1b74094323f778a472.1645636285.git.christophe.leroy@csgroup.eu>
X-FE-Policy-ID: 23:8:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=iram.es; s=DKIM; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=bz6Q3MCl84at11A0B3YpTI0E5vC6G8qpl+kHI5iMXXA=;
 b=EDuB3ZsP42vMN0Hn/eWIC0hn2u5caeCWIsjU5g6NFDBpt+ZoFWaW+M6QLurdDP5epHqd1ixNrV18
        P0L9k0KpCQ4UGRA2eAe3kUkafu82cXab5JA5gUZ4d9toOaJMb/V6PqCATIcjL7OdBElWbxSUPG9F
        g8MfNbEvjJqx7/9zaSlXdrAWwl1a+V96yAsgoSnEw3YG6Q7jfEkFxtEQ8eHnQ90G+PGzRdokM6lU
        /baXqEFOXkWYpqTOuLALCmRq8RjbOj0/ilwsXpa+IxkvbhoY5GLmFpYnLfrA3uAEY5qg8m6FxOB9
        SJOUDbTkTo82sUSMAk2nrz2HwnX5zQj4uk+tQA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 06:11:36PM +0100, Christophe Leroy wrote:
> Commit a82adfd5c7cb ("hardening: Introduce CONFIG_ZERO_CALL_USED_REGS")
> added zeroing of used registers at function exit.
> 
> At the time being, PPC64 clears volatile registers on syscall exit but
> PPC32 doesn't do it for performance reason.
> 
> Add that clearing in PPC32 syscall exit as well, but only when
> CONFIG_ZERO_CALL_USED_REGS is selected.
> 
> On an 8xx, the null_syscall selftest gives:
> - Without CONFIG_ZERO_CALL_USED_REGS		: 288 cycles
> - With CONFIG_ZERO_CALL_USED_REGS		: 305 cycles
> - With CONFIG_ZERO_CALL_USED_REGS + this patch	: 319 cycles
> 
> Note that (independent of this patch), with pmac32_defconfig,
> vmlinux size is as follows with/without CONFIG_ZERO_CALL_USED_REGS:
> 
>    text	   	data	    bss	    dec	    hex		filename
> 9578869		2525210	 194400	12298479	bba8ef	vmlinux.without
> 10318045	2525210  194400	13037655	c6f057	vmlinux.with
> 
> That is a 7.7% increase on text size, 6.0% on overall size.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kernel/entry_32.S | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
> index 7748c278d13c..199f23092c02 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -151,6 +151,21 @@ syscall_exit_finish:
>  	bne	3f
>  	mtcr	r5
>  
> +#ifdef CONFIG_ZERO_CALL_USED_REGS
> +	/* Zero volatile regs that may contain sensitive kernel data */
> +	li	r0,0
> +	li	r4,0
> +	li	r5,0
> +	li	r6,0
> +	li	r7,0
> +	li	r8,0
> +	li	r9,0
> +	li	r10,0
> +	li	r11,0
> +	li	r12,0
> +	mtctr	r0
> +	mtxer	r0

Here, I'm almost sure that on some processors, it would be better to
separate mtctr form mtxer. mtxer is typically very expensive (pipeline
flush) but I don't know what's the best ordering for the average core.

And what about lr? Should it also be cleared?

	Gabriel

> +#endif
>  1:	lwz	r2,GPR2(r1)
>  	lwz	r1,GPR1(r1)
>  	rfi
> -- 
> 2.34.1
> 
 

