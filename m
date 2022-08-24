Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640E159F4C5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbiHXIJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbiHXIJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:09:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1956BCDD;
        Wed, 24 Aug 2022 01:09:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7979F2008D;
        Wed, 24 Aug 2022 08:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661328591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TLtgpnjQlGtD1ZAJ+2wQtkWv5tNE69LQcLT1NXtK3ms=;
        b=j20rO/LUe+ZNPgoL3sgzAB9Uo0qwAB2hz+HKpI+VJ7OoO+6WpFy0JbHRnKNinUUW3p3sEP
        GzKu+ecTUHYR9qtLYWUjlMmuHioEtPsuPQUiwYNfsppQDRn7at24wWWLnp0VSI3Oaejk+C
        Yd/1GdFhE3kj7bIhJi3Ge1qoMFLQ71c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5904A13AC0;
        Wed, 24 Aug 2022 08:09:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xBYSFc/cBWNvXgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 24 Aug 2022 08:09:51 +0000
Date:   Wed, 24 Aug 2022 10:09:50 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     lizhe.67@bytedance.com
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, mhiramat@kernel.org,
        keescook@chromium.org, Jason@zx2c4.com, mark-pk.tsai@mediatek.com,
        rostedt@goodmis.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lizefan.x@bytedance.com, yuanzhu@bytedance.com
Subject: Re: [PATCH v2] page_ext: introduce boot parameter 'early_page_ext'
Message-ID: <YwXczj8Dh0uI0EA9@dhcp22.suse.cz>
References: <20220824065058.81051-1-lizhe.67@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824065058.81051-1-lizhe.67@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-08-22 14:50:58, lizhe.67@bytedance.com wrote:
[...]
> diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
> index fabb2e1e087f..3e081cf8a1ec 100644
> --- a/include/linux/page_ext.h
> +++ b/include/linux/page_ext.h
> @@ -38,19 +38,22 @@ struct page_ext {
>  
>  extern unsigned long page_ext_size;
>  extern void pgdat_page_ext_init(struct pglist_data *pgdat);
> +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> +extern bool early_page_ext_enable(void);
> +#endif
>  
>  #ifdef CONFIG_SPARSEMEM
>  static inline void page_ext_init_flatmem(void)
>  {
>  }
> -extern void page_ext_init(void);
> +extern void page_ext_init(bool early);
>  static inline void page_ext_init_flatmem_late(void)
>  {
>  }
>  #else
>  extern void page_ext_init_flatmem(void);
>  extern void page_ext_init_flatmem_late(void);
> -static inline void page_ext_init(void)
> +static inline void page_ext_init(bool early)
>  {
>  }
>  #endif

Why do you need to make it CONFIG_DEFERRED_STRUCT_PAGE_INIT
dependant?

[...]
> diff --git a/init/main.c b/init/main.c
> index 91642a4e69be..3760c0326525 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -849,6 +849,8 @@ static void __init mm_init(void)
>  	pgtable_init();
>  	debug_objects_mem_init();
>  	vmalloc_init();
> +	/* Should be run after vmap initialization */
> +	page_ext_init(true);

you can just 
	if (early_page_ext)
		page_ext_init();

>  	/* Should be run before the first non-init thread is created */
>  	init_espfix_bsp();
>  	/* Should be run after espfix64 is set up. */
> @@ -1606,7 +1608,7 @@ static noinline void __init kernel_init_freeable(void)
>  	padata_init();
>  	page_alloc_init_late();
>  	/* Initialize page ext after all struct pages are initialized. */
> -	page_ext_init();
> +	page_ext_init(false);

	if (!early_page_ext)
		page_ext_init();
>  
>  	do_basic_setup();
>  

and without the ifdefery it all becomes much more simple.
-- 
Michal Hocko
SUSE Labs
