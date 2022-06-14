Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC4054B20A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 15:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244291AbiFNNIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 09:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343534AbiFNNIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:08:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C8E62F6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 06:08:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8AD361677
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:08:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2081EC3411B;
        Tue, 14 Jun 2022 13:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655212117;
        bh=EZWyEzJis+wg+PHTrtf74/eJzbtQm0oSGOp6nBki/Rk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AHrZD7735QNaoCMuug4m4qn9KDEQV0TbICVBpz+nqBEOQCVpQ60kgseLGx6wx4DyY
         A/CS2P/thli6EBiDkEiUayVVmhgyskPzplaDm2HqJeYNnEsxvwoMRRHT7cco34hTvi
         ca4wyxORjxPgD44fL2mBeCA+aOSR2lPKCXDade6oMAyCZSyhDnw19SDWPGttx5R1R9
         pr3Srk7PmSU9/NFBH3BypFwJL0zPQWXY1N3+Vq5MezkjHRpUyE4iq5F5WJ0GQKrvLW
         kJl7EWKB2wL18RUY22AXcOYO1hYsQWoa8stdoUgeVt/lS8ibbeKs3mo4BcaUJrHXqr
         6YIuDW6u3H10Q==
Message-ID: <bdcb78c1-eeda-d9e2-90fc-527bda8dd28c@kernel.org>
Date:   Tue, 14 Jun 2022 15:08:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/3] mm/mempool: use might_alloc()
Content-Language: en-US
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
References: <20220605152539.3196045-1-daniel.vetter@ffwll.ch>
 <20220605152539.3196045-3-daniel.vetter@ffwll.ch>
From:   "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20220605152539.3196045-3-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/22 17:25, Daniel Vetter wrote:
> mempool are generally used for GFP_NOIO, so this wont benefit all that
> much because might_alloc currently only checks GFP_NOFS. But it does
> validate against mmu notifier pte zapping, some might catch some
> drivers doing really silly things, plus it's a bit more meaningful in
> what we're checking for here.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/mempool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mempool.c b/mm/mempool.c
> index b933d0fc21b8..96488b13a1ef 100644
> --- a/mm/mempool.c
> +++ b/mm/mempool.c
> @@ -379,7 +379,7 @@ void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask)
>  	gfp_t gfp_temp;
>  
>  	VM_WARN_ON_ONCE(gfp_mask & __GFP_ZERO);
> -	might_sleep_if(gfp_mask & __GFP_DIRECT_RECLAIM);
> +	might_alloc(gfp_mask);
>  
>  	gfp_mask |= __GFP_NOMEMALLOC;	/* don't allocate emergency reserves */
>  	gfp_mask |= __GFP_NORETRY;	/* don't loop in __alloc_pages */

