Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA4C57DBFB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbiGVIN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbiGVING (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:13:06 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069239CE08
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 01:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1658477577; bh=LWDnby6DHYYfy30ljiAO8OPFEpGRu2tko2sxtbpJc08=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=snqK9ZpooW8OVA3dP+6M4juLxvS1m+kdPwWjXflikrCQtp5yGNDHbEf4qsOnXf7oP
         jPnT0yyxhn6h4//K9REa7IhGA4qayhsJjJbJRAK6HLnk1nxlztXwrzNEahu/QwF39w
         eb9kEvuKKmqrAACTItvMB1seMLF8uXWZwmF0ro2M=
Received: from [100.100.35.250] (unknown [58.34.185.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 5676F6061B;
        Fri, 22 Jul 2022 16:12:57 +0800 (CST)
Message-ID: <a1978090-b2d6-5176-808c-6aa1561a8926@xen0n.name>
Date:   Fri, 22 Jul 2022 16:12:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:104.0)
 Gecko/20100101 Thunderbird/104.0a1
Subject: Re: [PATCH 2/2] LoongArch: Remove unused variable
Content-Language: en-US
To:     Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220720072152.3894559-1-maobibo@loongson.cn>
 <20220720072152.3894559-2-maobibo@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220720072152.3894559-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/7/20 15:21, Bibo Mao wrote:
> There are some variables never used or referenced, this patch
> removes these varaibles and make the code cleaner.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   arch/loongarch/include/asm/loongson.h | 12 ------------
>   arch/loongarch/kernel/env.c           | 20 --------------------
>   2 files changed, 32 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/loongson.h b/arch/loongarch/include/asm/loongson.h
> index 6a8038725ba7..2df649e73371 100644
> --- a/arch/loongarch/include/asm/loongson.h
> +++ b/arch/loongarch/include/asm/loongson.h
> @@ -39,18 +39,6 @@ extern const struct plat_smp_ops loongson3_smp_ops;
>   
>   #define MAX_PACKAGES 16
>   
> -/* Chip Config register of each physical cpu package */
> -extern u64 loongson_chipcfg[MAX_PACKAGES];
> -#define LOONGSON_CHIPCFG(id) (*(volatile u32 *)(loongson_chipcfg[id]))
> -
> -/* Chip Temperature register of each physical cpu package */
> -extern u64 loongson_chiptemp[MAX_PACKAGES];
> -#define LOONGSON_CHIPTEMP(id) (*(volatile u32 *)(loongson_chiptemp[id]))
> -
> -/* Freq Control register of each physical cpu package */
> -extern u64 loongson_freqctrl[MAX_PACKAGES];
> -#define LOONGSON_FREQCTRL(id) (*(volatile u32 *)(loongson_freqctrl[id]))
> -
>   #define xconf_readl(addr) readl(addr)
>   #define xconf_readq(addr) readq(addr)
>   
> diff --git a/arch/loongarch/kernel/env.c b/arch/loongarch/kernel/env.c
> index 467946ecf451..82b478a5c665 100644
> --- a/arch/loongarch/kernel/env.c
> +++ b/arch/loongarch/kernel/env.c
> @@ -17,21 +17,6 @@ u64 efi_system_table;
>   struct loongson_system_configuration loongson_sysconf;
>   EXPORT_SYMBOL(loongson_sysconf);
>   
> -u64 loongson_chipcfg[MAX_PACKAGES];
> -u64 loongson_chiptemp[MAX_PACKAGES];
> -u64 loongson_freqctrl[MAX_PACKAGES];
> -unsigned long long smp_group[MAX_PACKAGES];
> -
> -static void __init register_addrs_set(u64 *registers, const u64 addr, int num)
> -{
> -	u64 i;
> -
> -	for (i = 0; i < num; i++) {
> -		*registers = (i << 44) | addr;
> -		registers++;
> -	}
> -}
> -
>   void __init init_environ(void)
>   {
>   	int efi_boot = fw_arg0;
> @@ -50,11 +35,6 @@ void __init init_environ(void)
>   	efi_memmap_init_early(&data);
>   	memblock_reserve(data.phys_map & PAGE_MASK,
>   			 PAGE_ALIGN(data.size + (data.phys_map & ~PAGE_MASK)));
> -
> -	register_addrs_set(smp_group, TO_UNCACHE(0x1fe01000), 16);
> -	register_addrs_set(loongson_chipcfg, TO_UNCACHE(0x1fe00180), 16);
> -	register_addrs_set(loongson_chiptemp, TO_UNCACHE(0x1fe0019c), 16);
> -	register_addrs_set(loongson_freqctrl, TO_UNCACHE(0x1fe001d0), 16);
>   }
>   
>   static int __init init_cpu_fullname(void)

These information, although removed here, are actually available in the 
official docs repo [1], so no harm in cleaning the code. Thanks.

Reviewed-by: WANG Xuerui <git@xen0n.name>

[1]: 
https://loongson.github.io/LoongArch-Documentation/Loongson-3A5000-usermanual-EN.html

