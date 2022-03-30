Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC374EB8F4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 05:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242357AbiC3Diu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 23:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbiC3Dis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 23:38:48 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4BF21593D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 20:37:04 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mr5-20020a17090b238500b001c67366ae93so838308pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 20:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WuaiwYvOTwQ+/sJcpkfv+PmwJ4PjGjNA2qt+U1utxww=;
        b=F5i6s4aX9dewu0eQZC/evu0gwwCMspUxxWQqwNqg32zj8r8Qo7Di7WwKPX19PLnam5
         SQ5pQVTKQMi5HFm+XmeVCjQpgdl0/BpVMIOKINJySp/CSNHPEORIv+Q3US++n7yod/ZC
         6G4cxnNLPMxucgTAFtA2CxhvM17WlcwaXhusRTut4YO8lKQ1mx5ng2E0zBAlpORexv6q
         8CuKXzRqrULL5SgdLAvTkrF+oZr/PM3WHmNp7o/AC50tOU1NiyAHntuxPLZLzIw46LOo
         iZ/gGiitOFZ4iVEiRTFpqo1lq0pqflWb14noEJI3UEEVzp5zba8n8zAKfu1salwIl8Qp
         /5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WuaiwYvOTwQ+/sJcpkfv+PmwJ4PjGjNA2qt+U1utxww=;
        b=DaBcyUWikkQGQIOX2E9JrW4oQm2jbLVgVr+pNX9C20jWKrt4Wl5KPmUAvl26GUBnL9
         uFa/V0xvrzcWisw3SOEtG8NWsyO/C981cUO/nxhIORnMUgfYT96xm7dS5GZ0rDl5BDud
         MqU3S48NO3JWXY3JOp0/6AowcootD0AXZPopLBE694bWNdsuQS3N68ki4JjNtQGHI+qP
         Z71AHPhI4nMqhQVITmHE2cM1ieoLoTV1xaqQ1kZvjDZO65JPEDiQJEmIlGaaoEI1IPXY
         hCDlujtWazhrQMOX30jf+nci9po6ZXQqAR4Jyl5wPXmc+G9dyyhLu9VOL9BdjqFd+Qio
         RwUw==
X-Gm-Message-State: AOAM531yMb3QOGL1jRyFdLzXufs4XFVWOnFYHp5tyZm7Ztb0r/g1iGkA
        rruy6aPpakc3d/MnH7M9lrk=
X-Google-Smtp-Source: ABdhPJzlaUvvZOKk5pfSIN08gKcO9fQ1bMYnmBENgu+WtgKUKxpxsQ5xN5XkauYymjmwhXKihxoN9Q==
X-Received: by 2002:a17:902:d4c1:b0:153:d493:3f1 with SMTP id o1-20020a170902d4c100b00153d49303f1mr33494733plg.102.1648611423812;
        Tue, 29 Mar 2022 20:37:03 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id a9-20020a056a000c8900b004fb37ecc6bbsm13476326pfv.65.2022.03.29.20.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 20:37:03 -0700 (PDT)
Message-ID: <de8e450f-596f-bf99-d18a-ee771f9f2127@gmail.com>
Date:   Tue, 29 Mar 2022 20:37:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] arm64: mm: Do not defer reserve_crashkernel() if only
 ZONE_DMA32
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Vijay Balakrishna <vijayb@linux.microsoft.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
References: <20220325055315.25671-1-wangkefeng.wang@huawei.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220325055315.25671-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/2022 10:53 PM, Kefeng Wang wrote:
> The kernel could be benifit due to BLOCK_MAPPINGS, see commit
> 031495635b46 ("arm64: Do not defer reserve_crashkernel() for
> platforms with no DMA memory zones"), if there is only with
> ZONE_DMA32, we could set arm64_dma_phys_limit to max_zone_phys(32)
> earlier in arm64_memblock_init(), then we will benifit too.
> 
> Cc: Vijay Balakrishna <vijayb@linux.microsoft.com>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   arch/arm64/mm/init.c | 18 ++++++++++--------
>   arch/arm64/mm/mmu.c  |  6 ++----
>   2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 8ac25f19084e..9dded8779d72 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -157,14 +157,14 @@ static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
>   	return min(zone_mask, memblock_end_of_DRAM() - 1) + 1;
>   }
>   
> +phys_addr_t __ro_after_init dma32_phys_limit;

This variable should still be scoped to this file, it is not used 
outside of arch/arm64/mm/init.c.
-- 
Florian
