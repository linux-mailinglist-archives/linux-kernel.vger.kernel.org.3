Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8D05B137A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 06:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiIHEWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 00:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiIHEWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 00:22:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D51C69
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 21:21:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78B4FB81DA8
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 04:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E76C433D6;
        Thu,  8 Sep 2022 04:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662610592;
        bh=1+aAstvbE2bUQV0BbstwqMS6S5sNwJIGfHGFeYUewaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L+lq45NGGDGsmGc84T9A9wHHVos52dAH08gzUwha2fIQPhvQE1sQhAoj6g14bVvvi
         pGHY0PhMLOYLBiP3giWK3nOlaSb0qlj3NHT3+XKlmXr4q1SvaNaTjNAnK8s4nZh99K
         q74G8p6c1XzPERzyFx6pgtMlO9mgRe5TpRM3BJK5Uhkr0YJC1pipBkVrQLe1c6or/G
         xbbiF3tijZxrQzgXKHvtJIrUBtZjyauGGz7QHo8VXMtuvh3d+T7JmxyEIMgkR7MFlq
         0/cP0c/hgqJ05O1VtNo4FnKU0niOifZ8ugWu9cb3j7GWs6CPe1AhyNi4IW5H53NYVB
         MLP17kEhE9MqQ==
Date:   Thu, 8 Sep 2022 07:16:17 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 4/3] memblock tests: add new pageblock related macro
Message-ID: <YxlskUbwXSiYr7hC@kernel.org>
References: <20220907082643.186979-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907082643.186979-1-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Do you mind taking this along with the pageblock macros series?

On Wed, Sep 07, 2022 at 04:26:43PM +0800, Kefeng Wang wrote:
> Add new pageblock_start_pfn() and pageblock_align() macro
> which are needed by memblock tests.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  tools/testing/memblock/linux/mmzone.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/memblock/linux/mmzone.h b/tools/testing/memblock/linux/mmzone.h
> index 7c2eb5c9bb54..e65f89b12f1c 100644
> --- a/tools/testing/memblock/linux/mmzone.h
> +++ b/tools/testing/memblock/linux/mmzone.h
> @@ -22,6 +22,8 @@ enum zone_type {
>  
>  #define pageblock_order		(MAX_ORDER - 1)
>  #define pageblock_nr_pages	BIT(pageblock_order)
> +#define pageblock_align(pfn)	ALIGN((pfn), pageblock_nr_pages)
> +#define pageblock_start_pfn(pfn)	ALIGN_DOWN((pfn), pageblock_nr_pages)
>  
>  struct zone {
>  	atomic_long_t		managed_pages;
> -- 
> 2.35.3
> 

-- 
Sincerely yours,
Mike.
