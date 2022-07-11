Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1DC56D875
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiGKIl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiGKIkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:40:47 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D401B21E2E;
        Mon, 11 Jul 2022 01:40:07 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oAoxa-0006eA-00; Mon, 11 Jul 2022 10:40:06 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 95B8DC0344; Mon, 11 Jul 2022 10:37:35 +0200 (CEST)
Date:   Mon, 11 Jul 2022 10:37:35 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH] MIPS: math-emu: Use the bitmap API to allocate bitmaps
Message-ID: <20220711083735.GA6084@alpha.franken.de>
References: <dd954ccb2472019c64da0dd3a90d7b39a2fadc98.1656960999.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd954ccb2472019c64da0dd3a90d7b39a2fadc98.1656960999.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 08:56:52PM +0200, Christophe JAILLET wrote:
> Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.
> 
> It is less verbose and it improves the semantic.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  arch/mips/math-emu/dsemul.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/mips/math-emu/dsemul.c b/arch/mips/math-emu/dsemul.c
> index e2d46cb93ca9..e02bd20b60a6 100644
> --- a/arch/mips/math-emu/dsemul.c
> +++ b/arch/mips/math-emu/dsemul.c
> @@ -82,11 +82,8 @@ static int alloc_emuframe(void)
>  
>  	/* Ensure we have an allocation bitmap */
>  	if (!mm_ctx->bd_emupage_allocmap) {
> -		mm_ctx->bd_emupage_allocmap =
> -			kcalloc(BITS_TO_LONGS(emupage_frame_count),
> -					      sizeof(unsigned long),
> -				GFP_ATOMIC);
> -
> +		mm_ctx->bd_emupage_allocmap = bitmap_zalloc(emupage_frame_count,
> +							    GFP_ATOMIC);
>  		if (!mm_ctx->bd_emupage_allocmap) {
>  			idx = BD_EMUFRAME_NONE;
>  			goto out_unlock;
> @@ -206,7 +203,7 @@ void dsemul_mm_cleanup(struct mm_struct *mm)
>  {
>  	mm_context_t *mm_ctx = &mm->context;
>  
> -	kfree(mm_ctx->bd_emupage_allocmap);
> +	bitmap_free(mm_ctx->bd_emupage_allocmap);
>  }
>  
>  int mips_dsemul(struct pt_regs *regs, mips_instruction ir,
> -- 
> 2.34.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
