Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF805587921
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbiHBIhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbiHBIhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:37:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA42DF77;
        Tue,  2 Aug 2022 01:37:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15F76B819A6;
        Tue,  2 Aug 2022 08:37:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722ECC433D6;
        Tue,  2 Aug 2022 08:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659429431;
        bh=yVMVoT/6Mw0lk1hw42cWt6ofhqaPBU8Dsd54VMW97C0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JxAhykuX9sQh9v8UcR46j9w+XNKe2vsiSm9sJevrJ9SG1m7eWpi7old3zWBjXpK9Q
         mj0HjrQcZ8jsCD6iuqulqWBsc3XxGE5mJaBliv/6diaCiFF91bUspCtTZI3IHcJil7
         1SGlOBi7D7dxOwsL45QWamyd5NU7Y6bGIsY62nIMsxJGB91uTKHQopl6I0v+nh1DZB
         g/PVaSJHAUf7CZRPGaESiyC1oG/6lTuE8YnWtPHQj1uu8Ag3lV4O4W4/KKGANQN4cD
         qiPFXtM2pigOX43aHjwoPVNlnuEGbu7o1k2oGI0gP1n2qWxu8W5ErLfBN3Bj68OPn9
         GNJMedzFw75kw==
Date:   Tue, 2 Aug 2022 09:37:04 +0100
From:   Will Deacon <will@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>, ardb@kernel.org
Subject: Re: [PATCH v3 1/2] arm64: kdump: Provide default size when
 crashkernel=Y,low is not specified
Message-ID: <20220802083703.GA26962@willie-the-truck>
References: <20220711090319.1604-1-thunder.leizhen@huawei.com>
 <20220711090319.1604-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711090319.1604-2-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 05:03:18PM +0800, Zhen Lei wrote:
> To be consistent with the implementation of x86 and improve cross-platform
> user experience. Try to allocate at least 256 MiB low memory automatically
> for the case that crashkernel=,high is explicitly specified, while
> crashkenrel=,low is omitted.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  8 +-------
>  arch/arm64/mm/init.c                            | 12 +++++++++++-
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 2522b11e593f239..65a2c3a22a4b57d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -843,7 +843,7 @@
>  			available.
>  			It will be ignored if crashkernel=X is specified.
>  	crashkernel=size[KMG],low
> -			[KNL, X86-64] range under 4G. When crashkernel=X,high
> +			[KNL, X86-64, ARM64] range under 4G. When crashkernel=X,high
>  			is passed, kernel could allocate physical memory region
>  			above 4G, that cause second kernel crash on system
>  			that require some amount of low memory, e.g. swiotlb
> @@ -857,12 +857,6 @@
>  			It will be ignored when crashkernel=X,high is not used
>  			or memory reserved is below 4G.
>  
> -			[KNL, ARM64] range in low memory.
> -			This one lets the user specify a low range in the
> -			DMA zone for the crash dump kernel.
> -			It will be ignored when crashkernel=X,high is not used
> -			or memory reserved is located in the DMA zones.
> -
>  	cryptomgr.notests
>  			[KNL] Disable crypto self-tests
>  
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 339ee84e5a61a0b..5390f361208ccf7 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -96,6 +96,14 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
>  #define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
>  #define CRASH_ADDR_HIGH_MAX		(PHYS_MASK + 1)
>  
> +/*
> + * This is an empirical value in x86_64 and taken here directly. Please
> + * refer to the code comment in reserve_crashkernel_low() of x86_64 for more
> + * details.

Honestly, I read that comment and I'm none the wiser. What does "due to
mapping restrictions" mean? The remainder of the comment appears to be
specific to x86 and refers to jump ranges with 5-level page-tables.

> +#define DEFAULT_CRASH_KERNEL_LOW_SIZE	\
> +	max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20)

So why does this value make sense for arm64? We have considerable platform
fragmentation^Wdiversity compared to x86 and picking a one-size-fits-all
default is more likely to cause weird problems when it doesn't work imo. I'd
actually prefer that the default is something that fails obviously (e.g. 0)
and we force an appropriate size to be specified.

On the other hand, if you can convince me that having a global constant is
the right way forward, then please move this out of the arch code.

Will
