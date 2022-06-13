Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC64F547EBC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 06:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiFMEpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 00:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiFMEp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 00:45:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64D913C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 21:45:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DCEFB80D24
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 04:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95920C34114;
        Mon, 13 Jun 2022 04:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655095523;
        bh=2gfgxSOdN8ePd6U0tBQuA784FmmxwA8r9uHQ7gR3/oE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g+cruqpI45jzQMW0rt7fI1hjfkO7NkqcsGb66LHPXMdW3qe+lz99Ev2OYARQBOWMY
         vsfu+fsvdpCzUJ77QHleih83BohVwDFFkNGS7tBfYvp9DSggteapHvGiEV2Dp83Rsp
         Sg+lPkh1Bt6+UKNJ634+yPRhn+6Q7NRl7IpISHgqzeNbJdqOtG6mHJAX0oydfhBXdM
         qAkCZ9EVts9IvzLKPW/y9W6AbVRQP5XsF2hTwSJMgiV80fr7mxJD1Ed5N0nu8Q/SZU
         8wNHu+EmXMHud8eVJovTSEdMaQUfnDjSEIWyU4YISGSL7P5mYeT7GloEL+HOh2UhTC
         grfYF8/qagnhA==
Date:   Mon, 13 Jun 2022 07:45:18 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     tjytimi <tjytimi@163.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock: avoid some repeat when add new range
Message-ID: <YqbA3oAL/mFQbRjj@kernel.org>
References: <20220609024122.6679-1-tjytimi@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609024122.6679-1-tjytimi@163.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 10:41:22AM +0800, tjytimi wrote:
> The worst case is that the new memory range overlaps all existing
> regions,which need type->cnt + 1 free area of struct memblock_region.
> So if type->cnt + 1 + type->cnt is less than type->max,we can insert
> regions directly.And becase of merge operation in the end of function,
> tpye->cnt increase slowly for many cases.So this patch can avoid
> unnecessary repeat for many cases when add new memory range.
> 
> Signed-off-by: tjytimi <tjytimi@163.com>
> ---
>  mm/memblock.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index e4f03a6e8..243cd7de5 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -602,6 +602,9 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>  	base = obase;
>  	nr_new = 0;
>  
> +	if (type->cnt<<1 < type->max - 1)
> +		insert = true;
> +

Several things here:
- cnt * 2 looks clearer than cnt << 1 and the performance difference (if
  any) is negligible
- I think checking that cnt + 1 < max is easier to read
- there should be space around operators, i.e. cnt << 1

I'd also appreciate a comment in the code with the explanation similar
to the changelog

>  	for_each_memblock_type(idx, type, rgn) {
>  		phys_addr_t rbase = rgn->base;
>  		phys_addr_t rend = rbase + rgn->size;
> -- 
> 2.32.0
> 

-- 
Sincerely yours,
Mike.
