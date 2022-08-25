Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1945A09B2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238122AbiHYHMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237655AbiHYHLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:11:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3B174DED;
        Thu, 25 Aug 2022 00:11:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6752A33E05;
        Thu, 25 Aug 2022 07:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661411490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hYk1CnPdLO2LHUgZMvVL7L3R4XtMQBeqSHHiwG6UZ2c=;
        b=mb80c827eT4ohCJRwod+u5TlWnmDrOa+OXQFltf40zxZcQ9EV/9EnVfTCq0wR7IMmpIjwJ
        Oy6N/DxUJHFZwSWC4gTIrkMREpQ0U5NrD7PYGXRqP3ztTaT65HulDttQHfoIfiTKm7lo6k
        AVxMM3Iaz/tFAwPrhJxdVsaFJHje/HU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 463F213A47;
        Thu, 25 Aug 2022 07:11:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9XndDqIgB2OsRwAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 25 Aug 2022 07:11:30 +0000
Date:   Thu, 25 Aug 2022 09:11:29 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     lizhe.67@bytedance.com
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, mhiramat@kernel.org,
        keescook@chromium.org, Jason@zx2c4.com, mark-pk.tsai@mediatek.com,
        rostedt@goodmis.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lizefan.x@bytedance.com, yuanzhu@bytedance.com
Subject: Re: [PATCH v3] page_ext: introduce boot parameter 'early_page_ext'
Message-ID: <YwcgoZfw4RhZ1Bl6@dhcp22.suse.cz>
References: <20220825063102.92307-1-lizhe.67@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825063102.92307-1-lizhe.67@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-08-22 14:31:02, lizhe.67@bytedance.com wrote:
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

will be disabled to initialize the page allocator early and prevent from
the OOM mentioned above.

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
> v2 patch: https://lore.kernel.org/lkml/20220824065058.81051-1-lizhe.67@bytedance.com/T/
> 
> [1]: https://lore.kernel.org/linux-mm/YwHmXLu5txij+p35@xsang-OptiPlex-9020/

the changelog is usually not part of the changelog and goes under ---
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>

I still have few comments below before I am going to ack. But this looks
much better already.

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

For admins it would likely be more easier to understand something like
following
	early_page_ext [KNL] Enforces page_ext initialization to earlier
			stages so cover more early boot allocations.
			Please note that as side effect some 
			optimizations might be disabled to achieve that
			(e.g. parallelized memory initialization is
			disabled) so the boot process might take longer,
			especially on systems with a lot of memory.
			Available with CONFIG_PAGE_EXTENSION=y
[...]
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

Why should default depend on DEFERRED_STRUCT_PAGE_INIT at all. This is
just confusing and I do not see how it serves a purpose. We might grow
more optimizations which would prefent early page_ext init.

Let's just have default false and only enforce with the parameter. This
is more predictable and easier to understand.

-- 
Michal Hocko
SUSE Labs
