Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313614A6BE9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 07:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245104AbiBBGxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 01:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244694AbiBBGwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 01:52:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CC3C061751
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 22:08:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3FBDB83008
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 06:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E52C004E1;
        Wed,  2 Feb 2022 06:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643782084;
        bh=HvguaN/KnZ4Mt0Cs/C294n4Y3l8Qu7MGLAl0oB6BX8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dmv/O/fu5NnmFseISuSg9qnGKsfJ+GJKJEkZ8vZjnaF7XparyJocs3xwnglIv0Hn5
         B1wgm/vqIf/RxYTIDwPtrBlHm3BO4o6YI+3tR8ymy0ODR19N+P8gfPYcYM+2NG0s8V
         8WotdaRor7WyMp4yCgDoyYtMDcvJoviH0w1CojQD0LqJrxP3tRdUHh7PmL+o8/5M+o
         CC2Q9zJjwOcN20qyU5og1CQA1Lu8COT6nL/CQHFZZJEi6MSAoUZZpMn5cGD6G9RXrr
         R8yI1HFyuMiZRXrLLvh+IQYvxo2RLmd8/sLF+OSLlIfJV8h999dPQP4g++k3yHuadB
         8KI7BZDO14UYg==
Date:   Wed, 2 Feb 2022 08:07:55 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Justin Forbes <jforbes@redhat.com>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH] mm/sparsemem: Fix 'mem_section' will never be NULL gcc
 12 warning
Message-ID: <Yfofu76KPbT2S9Ni@kernel.org>
References: <20220201192924.672675-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201192924.672675-1-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 02:29:24PM -0500, Waiman Long wrote:
> The gcc 12 compiler reports a warning on the following code:
> 
>     static inline struct mem_section *__nr_to_section(unsigned long nr)
>     {
>     #ifdef CONFIG_SPARSEMEM_EXTREME
>         if (!mem_section)
>                 return NULL;
>     #endif
>        :
> 
> With CONFIG_SPARSEMEM_EXTREME on, the mem_section definition is
> 
>     extern struct mem_section **mem_section;
> 
> Obviously, mem_section cannot be NULL, but *mem_section can be if memory
> hasn't been allocated for the dynamic mem_section[] array yet. Fix this
> warning by checking for "!*mem_section" instead.

Hmm, if mem_section cannot be NULL, it means if will be never allocated,
no?

static void __init memory_present(int nid, unsigned long start, unsigned long end)
{
	unsigned long pfn;

#ifdef CONFIG_SPARSEMEM_EXTREME
	if (unlikely(!mem_section)) {
		unsigned long size, align;

		size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
		align = 1 << (INTERNODE_CACHE_SHIFT);
		mem_section = memblock_alloc(size, align);
		if (!mem_section)
			panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
			      __func__, size, align);
	}
#endif

...

> 
> Fixes: 83e3c48729d9 ("mm/sparsemem: Allocate mem_section at runtime for CONFIG_SPARSEMEM_EXTREME=y")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/mmzone.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index aed44e9b5d89..bd1b19925f3b 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1390,7 +1390,7 @@ static inline unsigned long *section_to_usemap(struct mem_section *ms)
>  static inline struct mem_section *__nr_to_section(unsigned long nr)
>  {
>  #ifdef CONFIG_SPARSEMEM_EXTREME
> -	if (!mem_section)
> +	if (!*mem_section)
>  		return NULL;
>  #endif
>  	if (!mem_section[SECTION_NR_TO_ROOT(nr)])
> -- 
> 2.27.0
> 
> 

-- 
Sincerely yours,
Mike.
