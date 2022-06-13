Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5F15481B1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239748AbiFMIOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239931AbiFMINz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:13:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B34C1D;
        Mon, 13 Jun 2022 01:13:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 81E661FAC2;
        Mon, 13 Jun 2022 08:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655108030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UnM1FmEvdFfKVD81K9bggDM1Zy2DxTM7scV/JPdKiRo=;
        b=Pvu7YtW/f+9ruzt4zW+On0gr6h/4Lj7+AM2oazHZlKsc5lNBda/Z7qt1XMhCqmjWww0mem
        nv/XQEZt3tY2GaHcW1fNjcfAyqgwNJsjxCATUi63CsO+zF+sFDsd8bK3DauijtzF5yXPYQ
        cZj0tYWSYywjr/MJlVclY93D7zN654s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655108030;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UnM1FmEvdFfKVD81K9bggDM1Zy2DxTM7scV/JPdKiRo=;
        b=GN6ms8ryCo2n3xeivxDAiuujNVpD8BQil8hes9rAeAt4+DUXD1SxWKbcXHLIcAnWrHBtND
        E4HzGWW0db2e6oCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0261513443;
        Mon, 13 Jun 2022 08:13:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fQdwOb3xpmJ0IwAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 13 Jun 2022 08:13:49 +0000
Date:   Mon, 13 Jun 2022 10:13:48 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, corbet@lwn.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/6] mm: hugetlb_vmemmap: introduce the name HVO
Message-ID: <YqbxvDcNnPXr2Z9s@localhost.localdomain>
References: <20220613063512.17540-1-songmuchun@bytedance.com>
 <20220613063512.17540-4-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613063512.17540-4-songmuchun@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 02:35:09PM +0800, Muchun Song wrote:
> It it inconvenient to mention the feature of optimizing vmemmap pages associated
> with HugeTLB pages when communicating with others since there is no specific or
> abbreviated name for it when it is first introduced.  Let us give it a name HVO
> (HugeTLB Vmemmap Optimization) from now.
> 
> This commit also updates the document about "hugetlb_free_vmemmap" by the way
> discussed in thread [1].
> 
> Link: https://lore.kernel.org/all/21aae898-d54d-cc4b-a11f-1bb7fddcfffa@redhat.com/ [1]
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

For the Documentation/admin-guide/kernel-parameters.txt, I think it gets much
more clear.
About the name, I do not have a strong opinion.

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  Documentation/admin-guide/kernel-parameters.txt |  7 ++++---
>  Documentation/admin-guide/mm/hugetlbpage.rst    |  3 +--
>  Documentation/admin-guide/sysctl/vm.rst         |  3 +--
>  fs/Kconfig                                      | 13 ++++++-------
>  mm/hugetlb_vmemmap.c                            |  8 ++++----
>  mm/hugetlb_vmemmap.h                            |  4 ++--
>  6 files changed, 18 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 391b43fee93e..7539553b3fb0 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1725,12 +1725,13 @@
>  	hugetlb_free_vmemmap=
>  			[KNL] Reguires CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>  			enabled.
> +			Control if HugeTLB Vmemmap Optimization (HVO) is enabled.
>  			Allows heavy hugetlb users to free up some more
>  			memory (7 * PAGE_SIZE for each 2MB hugetlb page).
> -			Format: { [oO][Nn]/Y/y/1 | [oO][Ff]/N/n/0 (default) }
> +			Format: { on | off (default) }
>  
> -			[oO][Nn]/Y/y/1: enable the feature
> -			[oO][Ff]/N/n/0: disable the feature
> +			on: enable HVO
> +			off: disable HVO
>  
>  			Built with CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON=y,
>  			the default is on.
> diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
> index a90330d0a837..64e0d5c512e7 100644
> --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> @@ -164,8 +164,7 @@ default_hugepagesz
>  	will all result in 256 2M huge pages being allocated.  Valid default
>  	huge page size is architecture dependent.
>  hugetlb_free_vmemmap
> -	When CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is set, this enables optimizing
> -	unused vmemmap pages associated with each HugeTLB page.
> +	When CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is set, this enables HVO.
>  
>  When multiple huge page sizes are supported, ``/proc/sys/vm/nr_hugepages``
>  indicates the current number of pre-allocated huge pages of the default size.
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index d7374a1e8ac9..c9f35db973f0 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -569,8 +569,7 @@ This knob is not available when the size of 'struct page' (a structure defined
>  in include/linux/mm_types.h) is not power of two (an unusual system config could
>  result in this).
>  
> -Enable (set to 1) or disable (set to 0) the feature of optimizing vmemmap pages
> -associated with each HugeTLB page.
> +Enable (set to 1) or disable (set to 0) HugeTLB Vmemmap Optimization (HVO).
>  
>  Once enabled, the vmemmap pages of subsequent allocation of HugeTLB pages from
>  buddy allocator will be optimized (7 pages per 2MB HugeTLB page and 4095 pages
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 5976eb33535f..2f9fd840cb66 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -247,8 +247,7 @@ config HUGETLB_PAGE
>  
>  #
>  # Select this config option from the architecture Kconfig, if it is preferred
> -# to enable the feature of minimizing overhead of struct page associated with
> -# each HugeTLB page.
> +# to enable the feature of HugeTLB Vmemmap Optimization (HVO).
>  #
>  config ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>  	bool
> @@ -259,14 +258,14 @@ config HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>  	depends on SPARSEMEM_VMEMMAP
>  
>  config HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON
> -	bool "Default optimizing vmemmap pages of HugeTLB to on"
> +	bool "Default HugeTLB Vmemmap Optimization (HVO) to on"
>  	default n
>  	depends on HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>  	help
> -	  When using HUGETLB_PAGE_OPTIMIZE_VMEMMAP, the optimizing unused vmemmap
> -	  pages associated with each HugeTLB page is default off. Say Y here
> -	  to enable optimizing vmemmap pages of HugeTLB by default. It can then
> -	  be disabled on the command line via hugetlb_free_vmemmap=off.
> +	  When using HUGETLB_PAGE_OPTIMIZE_VMEMMAP, the HugeTLB Vmemmap
> +	  Optimization (HVO) is off by default. Say Y here to enable HVO
> +	  by default. It can then be disabled on the command line via
> +	  hugetlb_free_vmemmap=off or sysctl.
>  
>  config MEMFD_CREATE
>  	def_bool TMPFS || HUGETLBFS
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 132dc83f0130..c10540993577 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -1,8 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Optimize vmemmap pages associated with HugeTLB
> + * HugeTLB Vmemmap Optimization (HVO)
>   *
> - * Copyright (c) 2020, Bytedance. All rights reserved.
> + * Copyright (c) 2020, ByteDance. All rights reserved.
>   *
>   *     Author: Muchun Song <songmuchun@bytedance.com>
>   *
> @@ -120,8 +120,8 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
>  
>  	/*
>  	 * There are only (RESERVE_VMEMMAP_SIZE / sizeof(struct page)) struct
> -	 * page structs that can be used when CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP,
> -	 * so add a BUILD_BUG_ON to catch invalid usage of the tail struct page.
> +	 * page structs that can be used when HVO is enabled, add a BUILD_BUG_ON
> +	 * to catch invalid usage of the tail page structs.
>  	 */
>  	BUILD_BUG_ON(__NR_USED_SUBPAGE >=
>  		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
> diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> index 109b0a53b6fe..ba66fadad9fc 100644
> --- a/mm/hugetlb_vmemmap.h
> +++ b/mm/hugetlb_vmemmap.h
> @@ -1,8 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Optimize vmemmap pages associated with HugeTLB
> + * HugeTLB Vmemmap Optimization (HVO)
>   *
> - * Copyright (c) 2020, Bytedance. All rights reserved.
> + * Copyright (c) 2020, ByteDance. All rights reserved.
>   *
>   *     Author: Muchun Song <songmuchun@bytedance.com>
>   */
> -- 
> 2.11.0
> 
> 

-- 
Oscar Salvador
SUSE Labs
