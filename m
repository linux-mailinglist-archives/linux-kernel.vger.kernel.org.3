Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F15553E81B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240846AbiFFPaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240797AbiFFPaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:30:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B6433A26
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:30:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B24C612D0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 15:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB9BC385A9;
        Mon,  6 Jun 2022 15:30:02 +0000 (UTC)
Date:   Mon, 6 Jun 2022 16:29:59 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Patrick Wang <patrick.wang.shcn@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yee.lee@mediatek.com
Subject: Re: [PATCH v2 4/4] mm: kmemleak: kmemleak_*_phys() set address type
 and check PA when scan
Message-ID: <Yp4dd2vvO49BRaj3@arm.com>
References: <20220603035415.1243913-1-patrick.wang.shcn@gmail.com>
 <20220603035415.1243913-5-patrick.wang.shcn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603035415.1243913-5-patrick.wang.shcn@gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 11:54:15AM +0800, Patrick Wang wrote:
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 246a70b7218f..62d1ad8f8a44 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -1156,8 +1156,12 @@ EXPORT_SYMBOL(kmemleak_no_scan);
>  void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, int min_count,
>  			       gfp_t gfp)
>  {
> -	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
> -		kmemleak_alloc(__va(phys), size, min_count, gfp);
> +	pr_debug("%s(0x%pa, %zu, %d)\n", __func__, &phys, size, min_count);
> +
> +	if (kmemleak_enabled && !min_count)
> +		/* create object with OBJECT_PHYS flag */
> +		create_object((unsigned long)phys, size, min_count,
> +			      gfp, true);
>  }

With an early patch, just drop min_count altogether from this API,
assume 0.

>  EXPORT_SYMBOL(kmemleak_alloc_phys);
>  
> @@ -1170,8 +1174,10 @@ EXPORT_SYMBOL(kmemleak_alloc_phys);
>   */
>  void __ref kmemleak_free_part_phys(phys_addr_t phys, size_t size)
>  {
> -	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
> -		kmemleak_free_part(__va(phys), size);
> +	pr_debug("%s(0x%pa)\n", __func__, &phys);
> +
> +	if (kmemleak_enabled)
> +		delete_object_part((unsigned long)phys, size, true);
>  }
>  EXPORT_SYMBOL(kmemleak_free_part_phys);
>  
> @@ -1182,8 +1188,10 @@ EXPORT_SYMBOL(kmemleak_free_part_phys);
>   */
>  void __ref kmemleak_not_leak_phys(phys_addr_t phys)
>  {
> -	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
> -		kmemleak_not_leak(__va(phys));
> +	pr_debug("%s(0x%pa)\n", __func__, &phys);
> +
> +	if (kmemleak_enabled)
> +		make_gray_object((unsigned long)phys, true);
>  }
>  EXPORT_SYMBOL(kmemleak_not_leak_phys);

This function doesn't have any callers, so please remove it.

> @@ -1194,8 +1202,10 @@ EXPORT_SYMBOL(kmemleak_not_leak_phys);
>   */
>  void __ref kmemleak_ignore_phys(phys_addr_t phys)
>  {
> -	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
> -		kmemleak_ignore(__va(phys));
> +	pr_debug("%s(0x%pa)\n", __func__, &phys);
> +
> +	if (kmemleak_enabled)
> +		make_black_object((unsigned long)phys, true);
>  }
>  EXPORT_SYMBOL(kmemleak_ignore_phys);

Ah, that's still in use and we do need make_black_object(), contrary to
what I commented on a previous patch. We can still avoid changing
make_gray_object().

(we could replace the kmemleak_ignore_phys() calls
kmemleak_free_part_phys() but that's not in line with what we do for the
virtual objects)

> @@ -1468,6 +1478,17 @@ static void kmemleak_scan(void)
>  			dump_object_info(object);
>  		}
>  #endif
> +
> +		/* ignore objects outside lowmem (paint them black) */
> +		if ((object->flags & OBJECT_PHYS) &&
> +		   !(object->flags & OBJECT_NO_SCAN)) {
> +			unsigned long phys = object->pointer;
> +
> +			if (PHYS_PFN(phys) < min_low_pfn ||
> +			    PHYS_PFN(phys + object->size) >= max_low_pfn)
> +				__paint_it(object, KMEMLEAK_BLACK);
> +		}
> +
>  		/* reset the reference count (whiten the object) */
>  		object->count = 0;
>  		if (color_gray(object) && get_object(object))

This looks fine.

-- 
Catalin
