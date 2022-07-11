Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7201B56D873
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiGKIlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiGKIkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:40:46 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3F7921E2D;
        Mon, 11 Jul 2022 01:40:07 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oAoxa-0006eA-01; Mon, 11 Jul 2022 10:40:06 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id B4444C0353; Mon, 11 Jul 2022 10:37:54 +0200 (CEST)
Date:   Mon, 11 Jul 2022 10:37:54 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: mm: Use the bitmap API to allocate bitmaps
Message-ID: <20220711083754.GB6084@alpha.franken.de>
References: <4b64934fe14f1c2d30193df01e67a52022703b95.1656961396.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b64934fe14f1c2d30193df01e67a52022703b95.1656961396.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 10:56:51PM +0200, Christophe JAILLET wrote:
> Use bitmap_zalloc() instead of hand-writing them.
> 
> It is less verbose and it improves the semantic.
> 
> While at it, turn a bitmap_clear() into an equivalent bitmap_zero(). It is
> also less verbose.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v1 --> v2: don't speak about bitmap_free() in the log message (Sergey Shtylyov)
> ---
>  arch/mips/mm/context.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/mm/context.c b/arch/mips/mm/context.c
> index b25564090939..966f40066f03 100644
> --- a/arch/mips/mm/context.c
> +++ b/arch/mips/mm/context.c
> @@ -67,7 +67,7 @@ static void flush_context(void)
>  	int cpu;
>  
>  	/* Update the list of reserved MMIDs and the MMID bitmap */
> -	bitmap_clear(mmid_map, 0, num_mmids);
> +	bitmap_zero(mmid_map, num_mmids);
>  
>  	/* Reserve an MMID for kmap/wired entries */
>  	__set_bit(MMID_KERNEL_WIRED, mmid_map);
> @@ -277,8 +277,7 @@ static int mmid_init(void)
>  	WARN_ON(num_mmids <= num_possible_cpus());
>  
>  	atomic64_set(&mmid_version, asid_first_version(0));
> -	mmid_map = kcalloc(BITS_TO_LONGS(num_mmids), sizeof(*mmid_map),
> -			   GFP_KERNEL);
> +	mmid_map = bitmap_zalloc(num_mmids, GFP_KERNEL);
>  	if (!mmid_map)
>  		panic("Failed to allocate bitmap for %u MMIDs\n", num_mmids);
>  
> -- 
> 2.34.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
