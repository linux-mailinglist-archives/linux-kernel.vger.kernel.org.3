Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609CB53AA9B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351295AbiFAQAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355989AbiFAQAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:00:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAB05DBEE;
        Wed,  1 Jun 2022 09:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Y4MMjPUMJE17uRA1W8JeqNIa3gV1RDtW27U/YpItROE=; b=PNPjea3Bdl437M1+0zPKZ4cwLN
        hFYNzny9457JNo5FUnAC5pAYinngm5Tzi532WmplRYl6mclmGlkBTPQV3EWbzjL1lJsdCgFHoFuKE
        xkLOTIBC7a3cNimiGIlT1XQgleDQ8LF8XeG1gAtwaqa4Iib1MdVEEyvODkxXbwqgTlo6BYnm50u2f
        T4VZjAUy88+ZiooYd85oj0NRQS8ZrJWdoH3QHSQWCpMEohMg0rVlF13Rh0cfgNc+F58qRHyEGWpcy
        jNiQZA2jP0hH7K9WKcTKhXLA7jvLD8Jvrqc783shML119GeiVR3I97cMu2AHW7pekIpxw5XCaxa82
        yN+8YoxA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwQlH-003pGW-Rj; Wed, 01 Jun 2022 15:59:57 +0000
Message-ID: <86c1aaa4-df2e-d541-e24e-2d1cc9537500@infradead.org>
Date:   Wed, 1 Jun 2022 08:59:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] RISCV: kexec: Fix build error without CONFIG_MODULES
Content-Language: en-US
To:     Li Zhengyu <lizhengyu3@huawei.com>, palmer@rivosinc.com
Cc:     paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        liaochang1@huawei.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-next@vger.kernel.org
References: <20220601063924.13037-1-lizhengyu3@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220601063924.13037-1-lizhengyu3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/22 23:39, Li Zhengyu wrote:
> When CONFIG_MODULES is not set/enabled:
> 
> ../arch/riscv/kernel/elf_kexec.c:353:9: error: unknown type name 'Elf_Rela'; did you mean 'Elf64_Rela'?
>   353 |         Elf_Rela *relas;
>       |         ^~~~~~~~
>       |         Elf64_Rela
> 
> Replace Elf_Rela by Elf64_Rela to avoid relying on CONFIG_MODULES.
> 
> Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

thanks.

> ---
>  arch/riscv/kernel/elf_kexec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
> index 9cb85095fd45..0cb94992c15b 100644
> --- a/arch/riscv/kernel/elf_kexec.c
> +++ b/arch/riscv/kernel/elf_kexec.c
> @@ -349,7 +349,7 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>  {
>  	const char *strtab, *name, *shstrtab;
>  	const Elf_Shdr *sechdrs;
> -	Elf_Rela *relas;
> +	Elf64_Rela *relas;
>  	int i, r_type;
>  
>  	/* String & section header string table */

-- 
~Randy
