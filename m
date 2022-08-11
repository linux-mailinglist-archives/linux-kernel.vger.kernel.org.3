Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4829658F860
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbiHKHaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbiHKH3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:29:55 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B609923F1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 00:29:54 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B92CA68AA6; Thu, 11 Aug 2022 09:29:51 +0200 (CEST)
Date:   Thu, 11 Aug 2022 09:29:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>, Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Donnelly <john.p.donnelly@oracle.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma/pool: do not complain if DMA pool is not allocated
Message-ID: <20220811072951.GC13886@lst.de>
References: <20220325122559.14251-1-mhocko@kernel.org> <Yj28gjonUa9+0yae@dhcp22.suse.cz> <20220325164856.GA16800@lst.de> <Yj3zyLs4f+ba6UqF@dhcp22.suse.cz> <YupFSpXOrcfXJNya@dhcp22.suse.cz> <YuqNToCACD8kKBG+@MiWiFi-R3L-srv> <YuqOrJKcgfamdXkk@dhcp22.suse.cz> <YuqU87SDwP0zg+c7@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuqU87SDwP0zg+c7@MiWiFi-R3L-srv>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5aa4c2ecf5c7..93af781f9445 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2761,7 +2761,6 @@ config ISA_BUS
>  # x86_64 have no ISA slots, but can have ISA-style DMA.
>  config ISA_DMA_API
>  	bool "ISA-style DMA support" if (X86_64 && EXPERT)
> -	default y

This looks sensible to me, but you'll have to get it past Linus.

> -#ifdef CONFIG_ZONE_DMA
> +#if defined(CONFIG_ZONE_DMA) && defined(CONFIG_ISA_DMA_API)
>  	max_zone_pfns[ZONE_DMA]		= min(MAX_DMA_PFN, max_low_pfn);
> +#else
> +	max_zone_pfns[ZONE_DMA]		= min(MAX_DMA32_PFN, max_low_pfn);
>  #endif

But this simply can't work at all.
