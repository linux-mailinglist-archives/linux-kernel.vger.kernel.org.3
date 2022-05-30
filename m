Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CE65388D4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 00:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241336AbiE3WRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 18:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbiE3WRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 18:17:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA39E50B30
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 15:17:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F18260FA9
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 22:17:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC80C385B8;
        Mon, 30 May 2022 22:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1653949051;
        bh=gmPvQFon2SSASGMCkX4ZnrD/0nIIHRD8b1aoavDZPmo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eHno5uisg/IoRujMJmZOcDXvVKOVpeta08vWXaPhGhhPjjiRe8ILcGLP0wwTQIe5w
         WbgN6l/K/0gjBs8T/vKLttabAnVn+KTmvxP1zXkl3gua9hFdFvacyCpUfXjm0bu9+L
         rYt9lng24bVCxmTk8HPwAJboqhWF6byno6XpMS48=
Date:   Mon, 30 May 2022 15:17:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhangshiming@oppo.com, guojian@oppo.com, hanchuanhua@oppo.com,
        Barry Song <v-songbaohua@oppo.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Steven Price <steven.price@arm.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH v2] arm64: enable THP_SWAP for arm64
Message-Id: <20220530151730.39596f41e284b5686acba04f@linux-foundation.org>
In-Reply-To: <20220527100644.293717-1-21cnbao@gmail.com>
References: <20220527100644.293717-1-21cnbao@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2022 22:06:44 +1200 Barry Song <21cnbao@gmail.com> wrote:

> From: Barry Song <v-songbaohua@oppo.com>
> 
> THP_SWAP has been proved to improve the swap throughput significantly
> on x86_64 according to commit bd4c82c22c367e ("mm, THP, swap: delay
> splitting THP after swapped out").
> As long as arm64 uses 4K page size, it is quite similar with x86_64
> by having 2MB PMD THP. So we are going to get similar improvement.
> For other page sizes such as 16KB and 64KB, PMD might be too large.
> Negative side effects such as IO latency might be a problem. Thus,
> we can only safely enable the counterpart of X86_64.
> A corner case is that MTE has an assumption that only base pages
> can be swapped. We won't enable THP_SWP for ARM64 hardware with
> MTE support until MTE is re-arched.
> 
> ...
>
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -45,6 +45,8 @@
>  	__flush_tlb_range(vma, addr, end, PUD_SIZE, false, 1)
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
> +#define arch_thp_swp_supported !system_supports_mte

Does that even work?

	if (arch_thp_swp_supported())

expands to

	if (!system_supports_mte())

so I guess it does work.  Is this ugly party trick required for some
reason?  If so, an apologetic comment describing why would be helpful.

Otherwise, can we use a static inline function here, as we do with the
stub function?

> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -461,4 +461,16 @@ static inline int split_folio_to_list(struct folio *folio,
>  	return split_huge_page_to_list(&folio->page, list);
>  }
>  
> +/*
> + * archs that select ARCH_WANTS_THP_SWAP but don't support THP_SWP due to
> + * limitations in the implementation like arm64 MTE can override this to
> + * false
> + */
> +#ifndef arch_thp_swp_supported
> +static inline bool arch_thp_swp_supported(void)
> +{
> +	return true;
> +}

Missing a #define arch_thp_swp_supported arch_thp_swp_supported here.

> +#endif
> +
>  #endif /* _LINUX_HUGE_MM_H */

Otherwise looks OK to me.  Please include it in the arm64 tree if/when
it's considered ready.

