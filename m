Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4105A0CC5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240469AbiHYJgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240396AbiHYJge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:36:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA767AA37D;
        Thu, 25 Aug 2022 02:36:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6298E3402E;
        Thu, 25 Aug 2022 09:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661420192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PgbOGaq5aMTSNFSLMgPYN3ecNGfCC0JVORocYZoKd1k=;
        b=kwfbdLYEg1WtBzx1UMpV+o/635ckKwl2DId9hB/3R21GnNQzRHlLKnMLEHZh9QD4dyZHxm
        ZS1KtDlV6ddFPW6kkznE+YfUqWKQETPrbxEgeG4rtCwNOifCEexBLOr60pPXYuiy6trcg3
        0CSRJO2FNPv0X3XW10e2Ja+pj1WkexQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661420192;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PgbOGaq5aMTSNFSLMgPYN3ecNGfCC0JVORocYZoKd1k=;
        b=Tb7AuwQOniD6z/U6CE88AOUH9kyDf2zvM/TKgkxQr7hDA1IEQIBgPCk4QpYrM+TKTZ44Qs
        LzNMqU7+29dBr7CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 29A9313A8E;
        Thu, 25 Aug 2022 09:36:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IpcbCaBCB2OaSgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 25 Aug 2022 09:36:32 +0000
Message-ID: <4a6385a9-8432-21dc-a070-66236c78457b@suse.cz>
Date:   Thu, 25 Aug 2022 11:36:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3] page_ext: introduce boot parameter 'early_page_ext'
Content-Language: en-US
To:     lizhe.67@bytedance.com, akpm@linux-foundation.org, mhocko@suse.com,
        mhiramat@kernel.org, keescook@chromium.org, Jason@zx2c4.com,
        mark-pk.tsai@mediatek.com, rostedt@goodmis.org, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lizefan.x@bytedance.com, yuanzhu@bytedance.com
References: <20220825063102.92307-1-lizhe.67@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220825063102.92307-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/22 08:31, lizhe.67@bytedance.com wrote:
> From: Li Zhe <lizhe.67@bytedance.com>
> 
> In 'commit 2f1ee0913ce5 ("Revert "mm: use early_pfn_to_nid in page_ext_init"")',
> we call page_ext_init() after page_alloc_init_late() to avoid some panic
> problem. It seems that we cannot track early page allocations in current
> kernel even if page structure has been initialized early.
> 
> This patch introduce a new boot parameter 'early_page_ext' to resolve this
> problem. If we pass it to kernel, function page_ext_init() will be moved
> up and feature 'deferred initialization of struct pages' will be disabled.
> It can help us to catch early page allocations. This is useful especially
> when we find that the free memory value is not the same right after
> different kernel booting.
> 
> Changelogs:
> 
> v1->v2:
> - use a cmd line parameter to move up function page_ext_init() instead of
>   using CONFIG_DEFERRED_STRUCT_PAGE_INIT
> - fix oom problem[1]
> 
> v2->v3:
> - make adjustments suggested by Michal Hocko
> 
> v1 patch: https://lore.kernel.org/lkml/Yv3r6Y1vh+6AbY4+@dhcp22.suse.cz/T/

IIRC v1 failed to boot in some automatic bot test. Will this not fail with
the same config/hw combination when the parameter is passed?

> v2 patch: https://lore.kernel.org/lkml/20220824065058.81051-1-lizhe.67@bytedance.com/T/
> 
> [1]: https://lore.kernel.org/linux-mm/YwHmXLu5txij+p35@xsang-OptiPlex-9020/
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
>  include/linux/page_ext.h                        | 11 +++++++++++
>  init/main.c                                     |  6 +++++-
>  mm/page_alloc.c                                 |  2 ++
>  mm/page_ext.c                                   | 12 ++++++++++++
>  5 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index d7f30902fda0..7b5726828ac0 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1471,6 +1471,12 @@
>  			Permit 'security.evm' to be updated regardless of
>  			current integrity status.
>  
> +	early_page_ext [KNL] Boot-time early page_ext initializing option.
> +			This boot parameter disables the deferred initialization
> +			of struct page and move up function page_ext_init() in
> +			order to catch early page allocations. Available with
> +			CONFIG_PAGE_EXTENSION=y.
> +
>  	failslab=
>  	fail_usercopy=
>  	fail_page_alloc=
> diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
> index fabb2e1e087f..68d690649234 100644
> --- a/include/linux/page_ext.h
> +++ b/include/linux/page_ext.h
> @@ -36,9 +36,15 @@ struct page_ext {
>  	unsigned long flags;
>  };
>  
> +extern bool early_page_ext;
>  extern unsigned long page_ext_size;
>  extern void pgdat_page_ext_init(struct pglist_data *pgdat);
>  
> +static inline bool early_page_ext_enable(void)
> +{
> +	return early_page_ext;
> +}

I think it should better be named early_page_ext_enabled() as it returns the
status, not sets it to true?

> +
>  #ifdef CONFIG_SPARSEMEM
>  static inline void page_ext_init_flatmem(void)
>  {
> @@ -67,6 +73,11 @@ static inline struct page_ext *page_ext_next(struct page_ext *curr)
>  #else /* !CONFIG_PAGE_EXTENSION */
>  struct page_ext;
>  
> +static inline bool early_page_ext_enable(void)
> +{
> +	return false;
> +}
> +
>  static inline void pgdat_page_ext_init(struct pglist_data *pgdat)
>  {
>  }
> diff --git a/init/main.c b/init/main.c
> index 91642a4e69be..d95edb67a499 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -849,6 +849,9 @@ static void __init mm_init(void)
>  	pgtable_init();
>  	debug_objects_mem_init();
>  	vmalloc_init();
> +	/* Should be run after vmap initialization */
> +	if (early_page_ext_enable())
> +		page_ext_init();
>  	/* Should be run before the first non-init thread is created */
>  	init_espfix_bsp();
>  	/* Should be run after espfix64 is set up. */
> @@ -1606,7 +1609,8 @@ static noinline void __init kernel_init_freeable(void)
>  	padata_init();
>  	page_alloc_init_late();
>  	/* Initialize page ext after all struct pages are initialized. */
> -	page_ext_init();
> +	if (!early_page_ext_enable())
> +		page_ext_init();
>  
>  	do_basic_setup();
>  
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e5486d47406e..e580b197aa1e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -482,6 +482,8 @@ defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
>  {
>  	static unsigned long prev_end_pfn, nr_initialised;
>  
> +	if (early_page_ext_enable())
> +		return false;
>  	/*
>  	 * prev_end_pfn static that contains the end of previous zone
>  	 * No need to protect because called very early in boot before smp_init.
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index 3dc715d7ac29..bf4f2a12d7dc 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -85,6 +85,18 @@ unsigned long page_ext_size = sizeof(struct page_ext);
>  
>  static unsigned long total_usage;
>  
> +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> +bool early_page_ext __meminitdata;
> +#else
> +bool early_page_ext __meminitdata = true;
> +#endif
> +static int __init setup_early_page_ext(char *str)
> +{
> +	early_page_ext = true;
> +	return 0;
> +}
> +early_param("early_page_ext", setup_early_page_ext);
> +
>  static bool __init invoke_need_callbacks(void)
>  {
>  	int i;

