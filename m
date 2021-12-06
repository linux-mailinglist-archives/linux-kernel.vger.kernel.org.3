Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B762746981E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245616AbhLFONi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:13:38 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:29091 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbhLFONh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:13:37 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4J74xg4ZhZz1DJsx;
        Mon,  6 Dec 2021 22:07:19 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 22:10:07 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 22:10:07 +0800
Message-ID: <52a86012-026e-12e5-2c56-7e86537bab73@huawei.com>
Date:   Mon, 6 Dec 2021 22:10:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] arm64: mm: Make randomization works again in some case
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20211104062747.55206-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20211104062747.55206-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello， Ard and Catalin, kindly ping...

On 2021/11/4 14:27, Kefeng Wang wrote:
> After commit 97d6786e0669 ("arm64: mm: account for hotplug memory when
> randomizing the linear region"), the KASLR could not work well in some
> case, eg, without memory hotplug and with va=39/pa=44, that is, linear
> region size < CPU's addressable PA range, the KASLR fails now but could
> work before this commit. Let's calculate pa range by memblock end/start
> without CONFIG_RANDOMIZE_BASE.
>
> Meanwhile, let's add a warning message if linear region size is too small
> for randomization.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> Hi Ard, one more question, the parange from mmfr0 register may also too large,
> then even with this patch, the randomization still could not work.
>
> If we know the max physical memory range(including hotplug memory), could we
> add a way(maybe cmdline) to set max parange, then we could make randomization
> works in more cases, any thought?
>
>   arch/arm64/mm/init.c | 30 +++++++++++++++++++++---------
>   1 file changed, 21 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index a8834434af99..27ec7f2c6fdb 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -284,21 +284,33 @@ void __init arm64_memblock_init(void)
>   
>   	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
>   		extern u16 memstart_offset_seed;
> -		u64 mmfr0 = read_cpuid(ID_AA64MMFR0_EL1);
> -		int parange = cpuid_feature_extract_unsigned_field(
> -					mmfr0, ID_AA64MMFR0_PARANGE_SHIFT);
> -		s64 range = linear_region_size -
> -			    BIT(id_aa64mmfr0_parange_to_phys_shift(parange));
> +		s64 range;
> +
> +		if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG)) {
> +			u64 mmfr0 = read_cpuid(ID_AA64MMFR0_EL1);
> +			int parange = cpuid_feature_extract_unsigned_field(
> +						mmfr0, ID_AA64MMFR0_PARANGE_SHIFT);
> +			range = linear_region_size -
> +				BIT(id_aa64mmfr0_parange_to_phys_shift(parange));
> +
> +		} else {
> +			range = linear_region_size -
> +				(memblock_end_of_DRAM() - memblock_start_of_DRAM());
> +		}
>   
>   		/*
>   		 * If the size of the linear region exceeds, by a sufficient
>   		 * margin, the size of the region that the physical memory can
>   		 * span, randomize the linear region as well.
>   		 */
> -		if (memstart_offset_seed > 0 && range >= (s64)ARM64_MEMSTART_ALIGN) {
> -			range /= ARM64_MEMSTART_ALIGN;
> -			memstart_addr -= ARM64_MEMSTART_ALIGN *
> -					 ((range * memstart_offset_seed) >> 16);
> +		if (memstart_offset_seed > 0) {
> +			if (range < (s64)ARM64_MEMSTART_ALIGN) {
> +				pr_warn("linear mappings size is too small for KASLR\n");
> +			} else {
> +				range /= ARM64_MEMSTART_ALIGN;
> +				memstart_addr -= ARM64_MEMSTART_ALIGN *
> +						 ((range * memstart_offset_seed) >> 16);
> +			}
>   		}
>   	}
>   
