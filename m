Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D6350F0C2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244899AbiDZGOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236853AbiDZGOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:14:41 -0400
Received: from mailgate.ics.forth.gr (mailgate.ics.forth.gr [139.91.1.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EF63B6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:11:32 -0700 (PDT)
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 23Q6BUQN063569
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:11:30 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1650953485; x=1653545485;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QkE1Bm53YoFRMFRIYyzcyIpaR/FHwI+8u4IHE6YrgQk=;
        b=Bn8Nat0Jr0al1fnSyc6ee+fYznGR/5OxQVES9XMFGd7YD0M1qaSRLgxgoT39jDL7
        tHg8KWKzahD+be/338EEbWgttRqSKm8lActLMnZZeu/XBoZCZ0i8rfM1R5OM9iXH
        dVYkWKte/6Xl6vVroYUiD0mmNaRv6XLGhNPK888pr1w38asp6Vm9N/Ptpylqc5us
        Hjmw3NuvsINQsq2Ysp4r13a+JNgE79rSe+ySAYcMRBh2xJYAxwh3jxnrsn2HL97p
        GFUjO4OC5GcFBUrQ/PfN50s3sUvCGMSJsjDZ5t6ItPp1AmNgpOgc7HzcHbPiDd1O
        Z7u+HmxBv5VY8paLbtXEqg==;
X-AuditID: 8b5b014d-f2ab27000000641e-d9-62678d0d15b2
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 57.D0.25630.D0D87626; Tue, 26 Apr 2022 09:11:25 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user: mick at ics.forth.gr
Message-ID: <8491e0c3-3e6e-325e-0cc1-5b237ce4f9fd@ics.forth.gr>
Date:   Tue, 26 Apr 2022 09:11:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] RISC-V-fixes: relocate DTB if it's outside memory region
Content-Language: el-GR
To:     palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220322132839.3653682-1-mick@ics.forth.gr>
From:   Nick Kossifidis <mick@ics.forth.gr>
In-Reply-To: <20220322132839.3653682-1-mick@ics.forth.gr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsXSHT1dWZe3Nz3J4OkTHYutv2exW1zeNYfN
        YtvnFjaLl5d7mC3aZvE7sHq8efmSxeNwxxd2j81L6j0uNV9n9/i8SS6ANYrLJiU1J7MstUjf
        LoErY+4fq4J/ghUNZ58yNjCe5Oti5OSQEDCRmL/tH3MXIxeHkMBRRok9z5qYIRKWEps/vWQB
        sXkF7CXmbO5jArFZBFQltsxcygQRF5Q4OfMJWI2oQITEsl1TwWxhAV+JSSt3sILYzALiEkfO
        /wabKSLgLrF68h8miLijxLSzM8DqhQQsJC58fgVWzyagKTH/0kGgOAcHJ9ANLWcqIMrNJLq2
        djFC2PIS29/OYZ7AKDALyRWzkGybhaRlFpKWBYwsqxgFEsuM9TKTi/XS8otKMvTSizYxgsOa
        0XcH4+3Nb/UOMTJxMB5ilOBgVhLhnaqaliTEm5JYWZValB9fVJqTWnyIUZqDRUmcl/1ZeJKQ
        QHpiSWp2ampBahFMlomDU6qBiVPkws2pTb535/RLyE87cpN/b8uX1qRlDhMn84k1+92TXzBh
        SVH47gmmlSc2pvxWK3x/i3nehL+Xq2zXih7xdGrdv35j0I00szuJqSH/luQuaXrSvvV46l+R
        4AgrhY5lx2Nif03vLbq6wDr+WW3zhWdhbds7hAp9ff5sivh7YvKF7M5Uvu37Z7nPN/gs9Wj3
        p9levTtfsaS2uMpmRLctPbVRx0tFbX3EuS8frPcfWiWrHTtf/YCYUNaeOIeNHE9VQi667FZq
        ubLGLaPkx6EJlfPUsrcE/UwRKDqoa8dz9vsXY332C5y3byRMl9nw6/1Ndn6hlkiWp61HQvyz
        vh3k3vrR8LhQwt7fbvtr4h/UrFViKc5INNRiLipOBADX9NJW2gIAAA==
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Palmer,

Any updates on this ?

Regards,
Nick

On 3/22/22 15:28, Nick Kossifidis wrote:
> In case the DTB provided by the bootloader/BootROM is before the kernel
> image or outside /memory, we won't be able to access it through the
> linear mapping, and get a segfault on setup_arch(). Currently OpenSBI
> relocates DTB but that's not always the case (e.g. if FW_JUMP_FDT_ADDR
> is not specified), and it's also not the most portable approach since
> the default FW_JUMP_FDT_ADDR of the generic platform relocates the DTB
> at a specific offset that may not be available. To avoid this situation
> copy DTB so that it's visible through the linear mapping.
> 
> Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
> ---
>   arch/riscv/mm/init.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 0d588032d..697a9aed4 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -206,8 +206,25 @@ static void __init setup_bootmem(void)
>   	 * early_init_fdt_reserve_self() since __pa() does
>   	 * not work for DTB pointers that are fixmap addresses
>   	 */
> -	if (!IS_ENABLED(CONFIG_BUILTIN_DTB))
> -		memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
> +	if (!IS_ENABLED(CONFIG_BUILTIN_DTB)) {
> +		/*
> +		 * In case the DTB is not located in a memory region we won't
> +		 * be able to locate it later on via the linear mapping and
> +		 * get a segfault when accessing it via __va(dtb_early_pa).
> +		 * To avoid this situation copy DTB to a memory region.
> +		 * Note that memblock_phys_alloc will also reserve DTB region.
> +		 */
> +		if (!memblock_is_memory(dtb_early_pa)) {
> +			size_t fdt_size = fdt_totalsize(dtb_early_va);
> +			phys_addr_t new_dtb_early_pa = memblock_phys_alloc(fdt_size, PAGE_SIZE);
> +			void *new_dtb_early_va = early_memremap(new_dtb_early_pa, fdt_size);
> +
> +			memcpy(new_dtb_early_va, dtb_early_va, fdt_size);
> +			early_memunmap(new_dtb_early_va, fdt_size);
> +			_dtb_early_pa = new_dtb_early_pa;
> +		} else
> +			memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
> +	}
>   
>   	early_init_fdt_scan_reserved_mem();
>   	dma_contiguous_reserve(dma32_phys_limit);

