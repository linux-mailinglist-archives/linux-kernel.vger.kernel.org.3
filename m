Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078175394F8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 18:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346165AbiEaQ3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 12:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244326AbiEaQ3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 12:29:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA33862CEE
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 09:29:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85C5C60BA7
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 16:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC2AC385A9;
        Tue, 31 May 2022 16:29:16 +0000 (UTC)
Date:   Tue, 31 May 2022 17:29:13 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Patrick Wang <patrick.wang.shcn@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yee.lee@mediatek.com
Subject: Re: [PATCH] mm: kmemleak: check boundary of objects allocated with
 physical address when scan
Message-ID: <YpZCWbfNE32EzCnz@arm.com>
References: <20220531150823.1004101-1-patrick.wang.shcn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531150823.1004101-1-patrick.wang.shcn@gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 11:08:23PM +0800, Patrick Wang wrote:
> @@ -1132,8 +1135,13 @@ EXPORT_SYMBOL(kmemleak_no_scan);
>  void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, int min_count,
>  			       gfp_t gfp)
>  {
> -	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
> -		kmemleak_alloc(__va(phys), size, min_count, gfp);
> +	pr_debug("%s(0x%p, %zu, %d)\n", __func__, __va(phys), size, min_count);

I'd print just phys here since that's the function argument.

> +	if (kmemleak_enabled && (unsigned long)__va(phys) >= PAGE_OFFSET &&
> +	    !IS_ERR(__va(phys)))
> +		/* create object with OBJECT_PHYS flag */
> +		create_object((unsigned long)__va(phys), size, min_count,
> +			      gfp, true);

Do we still need to check for __va(phys) >= PAGE_OFFSET? Also I don't
think IS_ERR(__va(phys)) makes sense, we can't store an error in a
physical address. The kmemleak_alloc_phys() function is only called on
successful allocation, so shouldn't bother with error codes.

> @@ -1436,6 +1441,13 @@ static void kmemleak_scan(void)
>  			dump_object_info(object);
>  		}
>  #endif
> +
> +		/* outside lowmem, make it black */

Maybe a bit more verbose:

		/* ignore objects outside lowmem (paint them black) */

> +		if (object->flags & OBJECT_PHYS)
> +			if (PHYS_PFN(__pa((void *)object->pointer)) < min_low_pfn ||
> +			    PHYS_PFN(__pa((void *)object->pointer)) >= max_low_pfn)
> +				__paint_it(object, KMEMLEAK_BLACK);

I'd skip the checks if the object is OBJECT_NO_SCAN (side-effect of
__paint_it()) so that the next scan won't have to go through the __pa()
checks again. It's also probably more correct to check the upper object
boundary). Something like:

		if ((object->flags & OBJECT_PHYS) &&
		    !(object->flags & OBJECT_NO_SCAN)) {
			unsigned long phys = __pa((void *)object->pointer);
			if (PHYS_PFN(phys) < min_low_pfn ||
			    PHYS_PFN(phys + object->size) >= max_low_pfn)
				__paint_it(object, KMEMLEAK_BLACK);
		}

Thanks.

-- 
Catalin
