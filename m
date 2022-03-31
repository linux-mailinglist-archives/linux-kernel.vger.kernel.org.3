Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CCA4ED441
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 08:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiCaG5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 02:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiCaG52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:57:28 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8200263DA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 23:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1P99cbgcKyenMIXAIS8yhOnAiro5GgvjDpUxTeyc0Go=; b=K++RLGxMkxvPSlyZKD7HePjIBL
        QcOMSQPQfXME0LgeabX+vb6UkMHq5+jQZdZyDbUVRvs631e0AM/nHYmsGz2icdNbBcwNog/1D01KL
        HQ9AYRV0O3lTylIPdvc6EpEiMkNKrqsQ5GFMV7y7Kk+dL+khXMgue59kDftZ39DFeaL6KwnkLEa3i
        cDxzA9+dc8V0g2oZEwewdDbEl3PRFt1B0oSm9+aq7iFn5DHK9XzYO4k6orRdnB6h9kLlmzkuYZY9v
        sghN7Stmnt53h8jb5428gpHZHGyblhqUpkA5xkg25zAoiQ+2wt75EluWY/TfAkkAiH5c4ldN3ifd2
        eU6/8tDg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58036)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nZoiP-0004JW-I7; Thu, 31 Mar 2022 07:55:29 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nZoiK-0007On-Ax; Thu, 31 Mar 2022 07:55:24 +0100
Date:   Thu, 31 Mar 2022 07:55:24 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     alexander.sverdlin@nokia.com, ardb@kernel.org,
        linus.walleij@linaro.org, nico@fluxnic.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: module: Add all unwind tables when load module
Message-ID: <YkVQXPYkae41B7Z2@shell.armlinux.org.uk>
References: <20220325011252.55844-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325011252.55844-1-chenzhongjin@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 25, 2022 at 09:12:52AM +0800, Chen Zhongjin wrote:
> For EABI stack unwinding, when loading .ko module
> the EXIDX sections will be added to a unwind_table list.
> 
> However not all EXIDX sections are added because EXIDX
> sections are searched by hardcoded section names.
> 
> For functions in other sections such as .ref.text
> or .kprobes.text, gcc generates seprated EXIDX sections
> (such as .ARM.exidx.ref.text or .ARM.exidx.kprobes.text).
> 
> These extra EXIDX sections are not loaded, so when unwinding
> functions in these sections, we will failed with:
> 
> 	unwind: Index not found xxx
> 
> To fix that, I refactor the code for searching and adding
> EXIDX sections:
> 
> - Check section type to search EXIDX tables (0x70000001)
> instead of strcmp() the hardcoded names. Then find the
> corresponding text sections by their section names.
> 
> - Add a unwind_table list in module->arch to save their own
> unwind_table instead of the fixed-lenth array.
> 
> - Save .ARM.exidx.init.text section ptr, because it should
> be cleaned after module init.
> 
> Now all EXIDX sections of .ko can be added correctly.
> 
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
>  arch/arm/include/asm/module.h | 17 ++------
>  arch/arm/include/asm/unwind.h |  1 +
>  arch/arm/kernel/module.c      | 73 +++++++++++++++++------------------
>  3 files changed, 40 insertions(+), 51 deletions(-)
> 
> diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
> index cfffae67c04e..8139b6a33a22 100644
> --- a/arch/arm/include/asm/module.h
> +++ b/arch/arm/include/asm/module.h
> @@ -3,20 +3,10 @@
>  #define _ASM_ARM_MODULE_H
>  
>  #include <asm-generic/module.h>
> -
> -struct unwind_table;
> +#include <asm/unwind.h>
>  
>  #ifdef CONFIG_ARM_UNWIND
> -enum {
> -	ARM_SEC_INIT,
> -	ARM_SEC_DEVINIT,
> -	ARM_SEC_CORE,
> -	ARM_SEC_EXIT,
> -	ARM_SEC_DEVEXIT,
> -	ARM_SEC_HOT,
> -	ARM_SEC_UNLIKELY,
> -	ARM_SEC_MAX,
> -};
> +#define ELF_SECTION_UNWIND 0x70000001
>  #endif
>  
>  #define PLT_ENT_STRIDE		L1_CACHE_BYTES
> @@ -36,7 +26,8 @@ struct mod_plt_sec {
>  
>  struct mod_arch_specific {
>  #ifdef CONFIG_ARM_UNWIND
> -	struct unwind_table *unwind[ARM_SEC_MAX];
> +	struct unwind_table unwind_list;
> +	struct unwind_table *init_table;
>  #endif
>  #ifdef CONFIG_ARM_MODULE_PLTS
>  	struct mod_plt_sec	core;
> diff --git a/arch/arm/include/asm/unwind.h b/arch/arm/include/asm/unwind.h
> index 0f8a3439902d..b51f85417f58 100644
> --- a/arch/arm/include/asm/unwind.h
> +++ b/arch/arm/include/asm/unwind.h
> @@ -24,6 +24,7 @@ struct unwind_idx {
>  
>  struct unwind_table {
>  	struct list_head list;
> +	struct list_head mod_list;
>  	const struct unwind_idx *start;
>  	const struct unwind_idx *origin;
>  	const struct unwind_idx *stop;
> diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
> index 549abcedf795..272f9bdeb1ed 100644
> --- a/arch/arm/kernel/module.c
> +++ b/arch/arm/kernel/module.c
> @@ -459,46 +459,36 @@ int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
>  #ifdef CONFIG_ARM_UNWIND
>  	const char *secstrs = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
>  	const Elf_Shdr *sechdrs_end = sechdrs + hdr->e_shnum;
> -	struct mod_unwind_map maps[ARM_SEC_MAX];
> -	int i;
> +	struct unwind_table *table_list = &mod->arch.unwind_list;

Please rename "table_list" to "unwind_list" so we use a consistent name
for this.

>  
> -	memset(maps, 0, sizeof(maps));
> +	INIT_LIST_HEAD(&table_list->mod_list);
> +	mod->arch.init_table = NULL;
>  
>  	for (s = sechdrs; s < sechdrs_end; s++) {
> -		const char *secname = secstrs + s->sh_name;
> +		const unsigned int sectype = s->sh_type;

Please loose this local variable.

>  
>  		if (!(s->sh_flags & SHF_ALLOC))
>  			continue;
>  
> -		if (strcmp(".ARM.exidx.init.text", secname) == 0)
> -			maps[ARM_SEC_INIT].unw_sec = s;
> -		else if (strcmp(".ARM.exidx", secname) == 0)
> -			maps[ARM_SEC_CORE].unw_sec = s;
> -		else if (strcmp(".ARM.exidx.exit.text", secname) == 0)
> -			maps[ARM_SEC_EXIT].unw_sec = s;
> -		else if (strcmp(".ARM.exidx.text.unlikely", secname) == 0)
> -			maps[ARM_SEC_UNLIKELY].unw_sec = s;
> -		else if (strcmp(".ARM.exidx.text.hot", secname) == 0)
> -			maps[ARM_SEC_HOT].unw_sec = s;
> -		else if (strcmp(".init.text", secname) == 0)
> -			maps[ARM_SEC_INIT].txt_sec = s;
> -		else if (strcmp(".text", secname) == 0)
> -			maps[ARM_SEC_CORE].txt_sec = s;
> -		else if (strcmp(".exit.text", secname) == 0)
> -			maps[ARM_SEC_EXIT].txt_sec = s;
> -		else if (strcmp(".text.unlikely", secname) == 0)
> -			maps[ARM_SEC_UNLIKELY].txt_sec = s;
> -		else if (strcmp(".text.hot", secname) == 0)
> -			maps[ARM_SEC_HOT].txt_sec = s;
> +		if (sectype == ELF_SECTION_UNWIND) {

I think given the amouont of indentation this causes, that:

		if (!(s->sh_flags & SHF_ALLOC)) ||
		    s->sh_type != ELF_SECTION_UNWIND)
			continue;

would be preferred here.

Other than that, patch looks fine, thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
