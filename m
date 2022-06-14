Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC7E54B20D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 15:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbiFNNIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 09:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239020AbiFNNH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:07:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2649711824
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 06:07:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 746916166B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7C9C3411B;
        Tue, 14 Jun 2022 13:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655212063;
        bh=o1i62i9cvcd6zXd6+ZKu0naAcMPa5eKgxWy6B4lu02k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Z6k5BnOssL4pis2anV8YUt2r+AigMLzMiGGeo8b0AO4vBL++oEct0NLuPZ+1a2iMQ
         BBGEW0gyIhOOL0uOIZpP/uVB3H5Y1mUc7eyJ8IM/m595KBHkXljkhh6wVfmyXxJI2g
         B3HzNNV/zhDSGx64Qvb9tueKXZjTRpmtPekoPuVPZAsqI7RZqPin6vUfIzxXWXiXIa
         Q2n3EHCpVlHUG53+vmZ/e2Nor4OQYyUAu5kgQSRmxetAN7hkF69bONJdq8YmBAbG5b
         6x4EUcWgCE0OQz1dYfjBy+JnCCSW14dMHcL8WLon0U+SMpBvZxbgCjNgTOB07k38Wj
         Fbtx97cgz9LNw==
Message-ID: <5f295a8f-058a-97d1-d9e0-095fdb5e5a7c@kernel.org>
Date:   Tue, 14 Jun 2022 15:07:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/3] mm/page_alloc: use might_alloc()
Content-Language: en-US
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
References: <20220605152539.3196045-1-daniel.vetter@ffwll.ch>
From:   "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20220605152539.3196045-1-daniel.vetter@ffwll.ch>
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
> ... instead of open codding it. Completely equivalent code, just
> a notch more meaningful when reading.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2db95780e003..277774d170cb 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5177,10 +5177,7 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
>  			*alloc_flags |= ALLOC_CPUSET;
>  	}
>  
> -	fs_reclaim_acquire(gfp_mask);
> -	fs_reclaim_release(gfp_mask);
> -
> -	might_sleep_if(gfp_mask & __GFP_DIRECT_RECLAIM);
> +	might_alloc(gfp_mask);
>  
>  	if (should_fail_alloc_page(gfp_mask, order))
>  		return false;

