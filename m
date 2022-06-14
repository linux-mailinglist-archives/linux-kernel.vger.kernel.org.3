Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC79454AB48
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355325AbiFNHyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355884AbiFNHxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:53:41 -0400
Received: from smtp.gentoo.org (smtp.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF2641F9D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:53:02 -0700 (PDT)
Date:   Tue, 14 Jun 2022 15:52:48 +0800
From:   Yixun Lan <dlan@gentoo.org>
To:     tjytimi <tjytimi@163.com>
Cc:     rppt@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock: avoid some repeat when add new range
Message-ID: <Yqg+UKAB6iiHd9N4@ofant>
References: <20220609024122.6679-1-tjytimi@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609024122.6679-1-tjytimi@163.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10:41 Thu 09 Jun     , tjytimi wrote:
> The worst case is that the new memory range overlaps all existing
> regions,which need type->cnt + 1 free area of struct memblock_region.
> So if type->cnt + 1 + type->cnt is less than type->max,we can insert
> regions directly.And becase of merge operation in the end of function,
> tpye->cnt increase slowly for many cases.So this patch can avoid
> unnecessary repeat for many cases when add new memory range.
> 
> Signed-off-by: tjytimi <tjytimi@163.com>
Can you fix the author/signed-off tag with your real legal name?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v4.18#n460

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
>  	for_each_memblock_type(idx, type, rgn) {
>  		phys_addr_t rbase = rgn->base;
>  		phys_addr_t rend = rbase + rgn->size;
> -- 
> 2.32.0
> 

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
