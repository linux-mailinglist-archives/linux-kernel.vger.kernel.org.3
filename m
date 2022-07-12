Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FA7571ECA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbiGLPTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbiGLPSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:18:35 -0400
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1B528E1C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:13:49 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id B8AE0B00422; Tue, 12 Jul 2022 17:13:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1657638824; bh=7+H5sOVkN3QxHU6DQU93Nr8Rzf1W/u/tyJLdV84maC4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Xj/GN/J6jJvlJrzAyTYFvqxapzZWR96npANp8WILastYr1yA6AZofEFMiv0vdCtXD
         geCh8MPf7MLjcbnU0dWUgWYTBhC6kBakj1/XnLfI9qT0E6AiiU8tr4VHGIQ5GmvxRg
         t+F/h14WJW+QqpvD7NiLVNcqK6RBEO8F8yLCdYu8sGJnNhgP7MoPFqvZRfm7TZI8o4
         oxSJJ3eHrQa+oK2MHqcybzm3eIZ83WTdJaTro0WTbw+lSPpl59S0L4l0CW1EcfdPrU
         aPa4aRoXX985c/dKImmvDelc80KgvwmYtjuB/hfMb0gzBaxtfk6xl5UuuP4d0bVsCJ
         3CMrv8AUiZ+8A==
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id B7EBEB0026E;
        Tue, 12 Jul 2022 17:13:44 +0200 (CEST)
Date:   Tue, 12 Jul 2022 17:13:44 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joe Perches <joe@perches.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Matthew WilCox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 16/16] mm/sl[au]b: check if large object is valid in
 __ksize()
In-Reply-To: <20220712133946.307181-17-42.hyeyoo@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2207121701070.57893@gentwo.de>
References: <20220712133946.307181-1-42.hyeyoo@gmail.com> <20220712133946.307181-17-42.hyeyoo@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022, Hyeonggon Yoo wrote:

> __ksize() returns size of objects allocated from slab allocator.
> When invalid object is passed to __ksize(), returning zero
> prevents further memory corruption and makes caller be able to
> check if there is an error.
>
> If address of large object is not beginning of folio or size of
> the folio is too small, it must be invalid. Return zero in such cases.

Why return 0 if there is an error and why bother the callers with these
checks. BUG()?

> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 1f8db7959366..0d6cbe9d7ad0 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1013,8 +1013,12 @@ size_t __ksize(const void *object)
>
>  	folio = virt_to_folio(object);
>
> -	if (unlikely(!folio_test_slab(folio)))
> +	if (unlikely(!folio_test_slab(folio))) {
> +		if (WARN_ON(object != folio_address(folio) ||
> +				folio_size(folio) <= KMALLOC_MAX_CACHE_SIZE))

Hmmm... This may change things a bit. Before this patch it was possible to
determine the storage size of order-0 pages using ksize(). Now this
returns 0?

I guess this is an error since the order-0 page cannot come from slab
allocations.

