Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9314FE65A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 18:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351197AbiDLQ6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 12:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbiDLQ6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 12:58:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDED5F4E7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:55:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A911DB81F14
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 16:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB210C385A1;
        Tue, 12 Apr 2022 16:55:43 +0000 (UTC)
Date:   Tue, 12 Apr 2022 17:55:40 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Ohhoon Kwon <ohkwon1043@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        JaeSang Yoo <jsyoo5b@gmail.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>,
        Jiyoup Kim <lakroforce@gmail.com>,
        Donghyeok Kim <dthex5d@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/slab_common: move dma-kmalloc caches creation into
 new_kmalloc_cache()
Message-ID: <YlWvDBtW1pVY+H8z@arm.com>
References: <20220410162511.656541-1-ohkwon1043@gmail.com>
 <YlQMC9x1hfgonJH/@hyeyoo>
 <9b02d27a-b4c0-acfa-dc0b-ac4912c1d3e6@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b02d27a-b4c0-acfa-dc0b-ac4912c1d3e6@suse.cz>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 05:31:51PM +0200, Vlastimil Babka wrote:
> On 4/11/22 13:07, Hyeonggon Yoo wrote:
> > On Mon, Apr 11, 2022 at 01:25:11AM +0900, Ohhoon Kwon wrote:
> >> @@ -898,20 +900,6 @@ void __init create_kmalloc_caches(slab_flags_t flags)
> >>  
> >>  	/* Kmalloc array is now usable */
> >>  	slab_state = UP;
> >> -
> >> -#ifdef CONFIG_ZONE_DMA
> >> -	for (i = 0; i <= KMALLOC_SHIFT_HIGH; i++) {
> >> -		struct kmem_cache *s = kmalloc_caches[KMALLOC_NORMAL][i];
> >> -
> >> -		if (s) {
> >> -			kmalloc_caches[KMALLOC_DMA][i] = create_kmalloc_cache(
> >> -				kmalloc_info[i].name[KMALLOC_DMA],
> >> -				kmalloc_info[i].size,
> >> -				SLAB_CACHE_DMA | flags, 0,
> >> -				kmalloc_info[i].size);
> >> -		}
> >> -	}
> >> -#endif
> >>  }
> >>  #endif /* !CONFIG_SLOB */
> > 
> > Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> Thanks.
> Added to:
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=for-5.19/refactor
> 
> > BTW this patch may conflict with [1] (not merged yet)
> > 
> > [1] https://lore.kernel.org/linux-mm/20220405135758.774016-9-catalin.marinas@arm.com/
> 
> FYI Catalin, might want to base v2 on the above once the crypto side is
> solved. At cursory look it shouldn't be a significant conflict.

Thanks for the heads-up. I did wonder why this was a separate loop.

-- 
Catalin
