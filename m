Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75323529B59
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238957AbiEQHsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiEQHr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:47:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486242ED76;
        Tue, 17 May 2022 00:47:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D2EE51F383;
        Tue, 17 May 2022 07:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652773671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ghycn6t5xJ3FJyT4xCbUwPxtWo84lq0XciIN7RNaQPw=;
        b=i868hRhnCUZBdkwQJa44Asp8b1Nc0V/TynvKKK44LKL3NafC+P3RNwyXMfDY3KbBG+R/Na
        QdJYGCO+I4wuL88+HbcyfHGK2GjIZhYTN7K/FceKkrk0akPVhVfISw3W42ziV+/uv2tpu8
        brVz8X3/ql+x4n1JTJm778CHu2zXdBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652773671;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ghycn6t5xJ3FJyT4xCbUwPxtWo84lq0XciIN7RNaQPw=;
        b=Q9pVjJenIkTEi5h+JnIgeYZNGJuWpAXJulbLyZhBh6PUEVTplPxsxls8rVimwa1DseFClU
        x/giIQLPPpKrznAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 391BD13305;
        Tue, 17 May 2022 07:47:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xvtrCiZTg2ILfwAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 17 May 2022 07:47:50 +0000
Date:   Tue, 17 May 2022 09:47:48 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        david@redhat.com, masahiroy@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v12 3/7] mm: memory_hotplug: enumerate all supported
 section flags
Message-ID: <YoNTJNfhUO7/oUrn@localhost.localdomain>
References: <20220516102211.41557-1-songmuchun@bytedance.com>
 <20220516102211.41557-4-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516102211.41557-4-songmuchun@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 06:22:07PM +0800, Muchun Song wrote:
> We are almost running out of free slots, only one bit is available in the

I would be more precise about what are we running out of. Free slots of
what?

> worst case (powerpc with 256k pages).  However, there are still some free
> slots on other architectures (e.g. x86_64 has 10 bits available, arm64
> has 8 bits available with worst case of 64K pages).  We have hard coded
> those numbers in code, it is inconvenient to use those bits on other
> architectures except powerpc.  So transfer those section flags to
> enumeration to make it easy to add new section flags in the future. Also,
> move SECTION_TAINT_ZONE_DEVICE into the scope of CONFIG_ZONE_DEVICE
> to save a bit on non-zone-device case.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
...
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1418,16 +1418,37 @@ extern size_t mem_section_usage_size(void);
>   *      (equal SECTION_SIZE_BITS - PAGE_SHIFT), and the
>   *      worst combination is powerpc with 256k pages,
>   *      which results in PFN_SECTION_SHIFT equal 6.
> - * To sum it up, at least 6 bits are available.
> + * To sum it up, at least 6 bits are available on all architectures.
> + * However, we can exceed 6 bits on some other architectures except
> + * powerpc (e.g. 15 bits are available on x86_64, 13 bits are available
> + * with the worst case of 64K pages on arm64) if we make sure the
> + * exceeded bit is not applicable to powerpc.
>   */
> -#define SECTION_MARKED_PRESENT		(1UL<<0)
> -#define SECTION_HAS_MEM_MAP		(1UL<<1)
> -#define SECTION_IS_ONLINE		(1UL<<2)
> -#define SECTION_IS_EARLY		(1UL<<3)
> -#define SECTION_TAINT_ZONE_DEVICE	(1UL<<4)
> -#define SECTION_MAP_LAST_BIT		(1UL<<5)
> +#define ENUM_SECTION_FLAG(MAPPER)						\
> +	MAPPER(MARKED_PRESENT)							\
> +	MAPPER(HAS_MEM_MAP)							\
> +	MAPPER(IS_ONLINE)							\
> +	MAPPER(IS_EARLY)							\
> +	MAPPER(TAINT_ZONE_DEVICE, CONFIG_ZONE_DEVICE)				\
> +	MAPPER(MAP_LAST_BIT)
> +
> +#define __SECTION_SHIFT_FLAG_MAPPER_0(x)
> +#define __SECTION_SHIFT_FLAG_MAPPER_1(x)	SECTION_##x##_SHIFT,
> +#define __SECTION_SHIFT_FLAG_MAPPER(x, ...)	\
> +	__PASTE(__SECTION_SHIFT_FLAG_MAPPER_, IS_ENABLED(__VA_ARGS__))(x)
> +
> +#define __SECTION_FLAG_MAPPER_0(x)
> +#define __SECTION_FLAG_MAPPER_1(x)		SECTION_##x = BIT(SECTION_##x##_SHIFT),
> +#define __SECTION_FLAG_MAPPER(x, ...)		\
> +	__PASTE(__SECTION_FLAG_MAPPER_, IS_ENABLED(__VA_ARGS__))(x)
> +
> +enum {
> +	ENUM_SECTION_FLAG(__SECTION_SHIFT_FLAG_MAPPER)
> +	ENUM_SECTION_FLAG(__SECTION_FLAG_MAPPER)
> +};
> +
>  #define SECTION_MAP_MASK		(~(SECTION_MAP_LAST_BIT-1))
> -#define SECTION_NID_SHIFT		6
> +#define SECTION_NID_SHIFT		SECTION_MAP_LAST_BIT_SHIFT

Is this really worth the extra code? And it might be me that I am not
familiar with all this magic, but it looks overcomplicated.
Maybe some comments here and there help clarifying what it is going on
here.

>  static inline struct page *__section_mem_map_addr(struct mem_section *section)
>  {
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 111684878fd9..aef3f041dec7 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -655,12 +655,18 @@ static void __meminit resize_pgdat_range(struct pglist_data *pgdat, unsigned lon
>  
>  }
>  
> +#ifdef CONFIG_ZONE_DEVICE
>  static void section_taint_zone_device(unsigned long pfn)
>  {
>  	struct mem_section *ms = __pfn_to_section(pfn);
>  
>  	ms->section_mem_map |= SECTION_TAINT_ZONE_DEVICE;
>  }
> +#else
> +static inline void section_taint_zone_device(unsigned long pfn)
> +{
> +}
> +#endif
>  
>  /*
>   * Associate the pfn range with the given zone, initializing the memmaps
> -- 
> 2.11.0
> 
> 

-- 
Oscar Salvador
SUSE Labs
