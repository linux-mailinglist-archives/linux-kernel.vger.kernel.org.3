Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABFA5AA41D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 02:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbiIBANx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 20:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiIBANv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 20:13:51 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653BA76778
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 17:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EsucP7zXtT1s2puFStADOK+ntllkhPbc1VqqCw1HoIk=; b=mjAWJamtj0wrpSi6hSFAzefcbd
        JrsaWUi151GxKTxNiHzJ74AZGaLaKzPaIw1mH7Y2usj1l82lrbddX78G7fSDgAsBjIYchAWmrMrhT
        xL5hwE/lUsxNq/XZRkGNiI4Jx8+Gs7V3674C6B6abfGOgfuU3wdQ1EA+gg1PGHwqD9qSGh9F+9bnK
        5nlXTTiQyrXCkQTbDYqgwFikReCuG7UMnFro69AkDbe4PP+CGfJ+rV4kcnLdUyyJRtvZ0qlL6Gug8
        cWzT5vj0+eSzuLT2Ff214Zq2xUR/akm4E4l7O1Y4LHZBrhzlmScNoi3ADloCIJkK4Bz+MU3USXtOf
        rtTS1WOA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oTuJe-00B9pb-Uf;
        Fri, 02 Sep 2022 00:13:47 +0000
Date:   Fri, 2 Sep 2022 01:13:46 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-riscv@lists.infradead.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: fix a nasty sigreturn bug...
Message-ID: <YxFKuhw9ZGB8f/Ne@ZenIV>
References: <YU0wDzeS/jXwkAca@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YU0wDzeS/jXwkAca@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?  Does anybody have objections?  AFAICS, the bug is still
there...

On Fri, Sep 24, 2021 at 01:55:27AM +0000, Al Viro wrote:
> riscv has an equivalent of arm bug fixed by 653d48b22166; if signal
> gets caught by an interrupt that hits when we have the right value
> in a0 (-513), *and* another signal gets delivered upon sigreturn()
> (e.g. included into the blocked mask for the first signal and posted
> while the handler had been running), the syscall restart logics will
> see regs->cause equal to EXC_SYSCALL (we are in a syscall, after all)
> and a0 already restored to its original value (-513, which happens to
> be -ERESTARTNOINTR) and assume that we need to apply the usual
> syscall restart logics.
>     
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
> index c2d5ecbe55264..f8fb85dc94b7a 100644
> --- a/arch/riscv/kernel/signal.c
> +++ b/arch/riscv/kernel/signal.c
> @@ -121,6 +121,8 @@ SYSCALL_DEFINE0(rt_sigreturn)
>  	if (restore_altstack(&frame->uc.uc_stack))
>  		goto badframe;
>  
> +	regs->cause = -1UL;
> +
>  	return regs->a0;
>  
>  badframe:
