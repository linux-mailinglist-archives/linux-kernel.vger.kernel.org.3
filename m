Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEBA57493F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiGNJmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiGNJl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:41:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9C3286E8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mo2Q939l1SKna16jkIoy7R6Mn2lotxlYpDlgge+GjVo=; b=KHdxs8wav0Y5pvpax5w0I6Gn1K
        dXyuxfq5tep40UxWVOSBgaU9cv1pTmFzGLyEiTioQ8m+n20dBevOvstHfDUS1onPgr6zPb7IEZXYk
        XSRMeDxTb5EcosKSi2Q1E4DuacZO6FbHN24vCjttW3dK3eo5yZwUdSMje29ZIAd6r9mg2OBTCn8N4
        z+tGKfetk1RRQyUmc64969DX4YDWSh0UiT6ID5cUNhDLwwKvEsHbU86ZVdjwW3UOoKX3dUG7zaGBL
        FLswFjX2PfEP+5qd3Mc9KZNTliB8RJlS+f3JiwX0HIYDglYrGR+/L3u/iaYoyjw/IY1ahpHS1BxI7
        lC6dC9JQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBvLw-003oIA-2Q; Thu, 14 Jul 2022 09:41:48 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id DB62D980120; Thu, 14 Jul 2022 11:41:46 +0200 (CEST)
Date:   Thu, 14 Jul 2022 11:41:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        ankur.a.arora@oracle.com, maciej.szmigiero@oracle.com
Subject: Re: [PATCH] x86/entry: Remove UNTRAIN_RET from native_irq_return_ldt
Message-ID: <Ys/k2gPLanPoF+ML@worktop.programming.kicks-ass.net>
References: <20220713195808.452394-1-alexandre.chartre@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713195808.452394-1-alexandre.chartre@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 09:58:08PM +0200, Alexandre Chartre wrote:
> UNTRAIN_RET is not needed in native_irq_return_ldt because ret untrain
> has already be done at this point. In addition, when the RETBleed
> mitigation is IBPB, UNTRAIN_RET clobbers several registers (AX, CX, DX)
> so here it trashes user values which are in these registers.
> 
> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  arch/x86/entry/entry_64.S | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 285e043a3e40..9953d966d124 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -727,7 +727,6 @@ native_irq_return_ldt:
>  	pushq	%rdi				/* Stash user RDI */
>  	swapgs					/* to kernel GS */
>  	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi	/* to kernel CR3 */
> -	UNTRAIN_RET
>  
>  	movq	PER_CPU_VAR(espfix_waddr), %rdi
>  	movq	%rax, (0*8)(%rdi)		/* user RAX */
> -- 
> 2.31.1
> 
