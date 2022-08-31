Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D059B5A7389
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 03:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiHaBvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 21:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiHaBvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 21:51:43 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B110AE874
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:51:42 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MHRrx33CVz1N7hL;
        Wed, 31 Aug 2022 09:48:01 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 31 Aug 2022 09:51:27 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 31 Aug 2022 09:51:26 +0800
Subject: Re: [PATCH 2/2] arm64: remove unneed defer_reserve_crashkernel() and
 crash_mem_map
To:     Baoquan He <bhe@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
        <ardb@kernel.org>, <rppt@kernel.org>,
        <guanghuifeng@linux.alibaba.com>, <mark.rutland@arm.com>,
        <will@kernel.org>, <linux-mm@kvack.org>,
        <wangkefeng.wang@huawei.com>, <kexec@lists.infradead.org>
References: <20220828005545.94389-1-bhe@redhat.com>
 <20220828005545.94389-3-bhe@redhat.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <fb26388d-9b3e-28cb-5688-828f52c70d24@huawei.com>
Date:   Wed, 31 Aug 2022 09:51:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20220828005545.94389-3-bhe@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/28 8:55, Baoquan He wrote:
> Now they are not needed any more, clean them up.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/arm64/include/asm/memory.h |  5 -----
>  arch/arm64/mm/mmu.c             | 15 ---------------
>  2 files changed, 20 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 9dd08cd339c3..b9e71583c9cb 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -363,11 +363,6 @@ static inline void *phys_to_virt(phys_addr_t x)
>  })
>  
>  void dump_mem_limit(void);
> -
> -static inline bool defer_reserve_crashkernel(void)
> -{
> -	return IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32);
> -}
>  #endif /* !ASSEMBLY */
>  
>  /*
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index cdd338fa2115..c3f8f426c3d8 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -502,21 +502,6 @@ void __init mark_linear_text_alias_ro(void)
>  			    PAGE_KERNEL_RO);
>  }
>  
> -static bool crash_mem_map __initdata;
> -
> -static int __init enable_crash_mem_map(char *arg)
> -{
> -	/*
> -	 * Proper parameter parsing is done by reserve_crashkernel(). We only
> -	 * need to know if the linear map has to avoid block mappings so that
> -	 * the crashkernel reservations can be unmapped later.
> -	 */
> -	crash_mem_map = true;
> -
> -	return 0;
> -}
> -early_param("crashkernel", enable_crash_mem_map);
> -
>  static void __init map_mem(pgd_t *pgdp)
>  {
>  	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
> 

-- 
Regards,
  Zhen Lei
