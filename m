Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFB94EF8A0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 19:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349504AbiDARHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 13:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237726AbiDARHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 13:07:07 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C63A412759D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 10:05:17 -0700 (PDT)
Received: from [192.168.4.54] (cpe-70-95-196-11.san.res.rr.com [70.95.196.11])
        by linux.microsoft.com (Postfix) with ESMTPSA id 105EE20DEECE;
        Fri,  1 Apr 2022 10:05:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 105EE20DEECE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1648832717;
        bh=8iqwr0fkDf/M1HJO1B33GqKPPbT8OnwevZSVUEf6xFc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WYm/onuc+L4XZzc3uS3IFOs9xTQzuXAe+ZbFQh7p34Y8Q0USYgdpW5svKlmeX+Njf
         TjRwsHY0AqWU4KIszhBBAOOa0/8Odt7IzJrUtf+p3gfCLi1lXT/v41IQ9+6qGj+72S
         E60gRXE7vFCHJvdp65DBVe8X0TC7VvPPBbokJbns=
Message-ID: <28b9ca3e-83d8-ea4b-1f27-d23c2d29424f@linux.microsoft.com>
Date:   Fri, 1 Apr 2022 10:05:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 resend 3/3] arm64: mm: Cleanup useless parameters in
 zone_sizes_init()
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com
References: <20220331074055.125824-1-wangkefeng.wang@huawei.com>
 <20220331074055.125824-4-wangkefeng.wang@huawei.com>
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
In-Reply-To: <20220331074055.125824-4-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/31/2022 12:40 AM, Kefeng Wang wrote:
> Directly use max_pfn for max and no one use min, kill them.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Looks good.  Reference to dma32_phys_limit in zone_sizes_init() depends 
on what you do with my comment [1].

[1] 
https://lore.kernel.org/all/69c1e722-33ea-95cf-de84-aed3022cb042@linux.microsoft.com/

Reviewed-by: Vijay Balakrishna <vijayb@linux.microsoft.com>

> ---
>   arch/arm64/mm/init.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 0aafa9181607..80e9ff37b697 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -181,7 +181,7 @@ static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
>   	return min(zone_mask, memblock_end_of_DRAM() - 1) + 1;
>   }
>   
> -static void __init zone_sizes_init(unsigned long min, unsigned long max)
> +static void __init zone_sizes_init(void)
>   {
>   	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
>   #ifdef CONFIG_ZONE_DMA
> @@ -199,7 +199,7 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>   #ifdef CONFIG_ZONE_DMA32
>   	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(dma32_phys_limit);
>   #endif
> -	max_zone_pfns[ZONE_NORMAL] = max;
> +	max_zone_pfns[ZONE_NORMAL] = max_pfn;
>   
>   	free_area_init(max_zone_pfns);
>   }
> @@ -401,7 +401,7 @@ void __init bootmem_init(void)
>   	 * done after the fixed reservations
>   	 */
>   	sparse_init();
> -	zone_sizes_init(min, max);
> +	zone_sizes_init();
>   
>   	/*
>   	 * Reserve the CMA area after arm64_dma_phys_limit was initialised.
