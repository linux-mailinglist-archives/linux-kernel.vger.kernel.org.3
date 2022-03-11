Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FD74D5FB2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348006AbiCKKgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347995AbiCKKf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:35:58 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3FB107DBE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uyaT3+EVPViBMT6fbeRdikl9gpqbHKai7w6iSnQ9lMw=; b=GNpys08Jj1EfZyuN/R7NoIsNZk
        7ASPesLjsnYaKm7NwsDst25U/lFQfC+AldmV6gQxutMIbG4EjikFcX4MK5c1NPmMuTMo9oQvSEkRp
        0LGqjJ60GoW0wUA6Je8sO5vH4fp2F8tp6iautLO6lIgLH1DzEHWL2dGAj3aVZ2Pe32mfK8Rk0W7m8
        AnarrN5QihUBjV7vRo1VhopTsJDJ4827e8hf2v3URH53rqaUE77gSxmJWEH7EBZwjWn+YjzyQkcv/
        5rMd5Z50WiEVamsjxWZF9Lc/JEQ5x+euXagDty4qw/qJyiDRvJ7uNNakOY4BATe4NykZGETzlZ+O5
        wcKah0aA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57786)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nScba-0002Qe-Qz; Fri, 11 Mar 2022 10:34:43 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nScbX-0001Wi-Bk; Fri, 11 Mar 2022 10:34:39 +0000
Date:   Fri, 11 Mar 2022 10:34:39 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        andreyknvl@gmail.com, anshuman.khandual@arm.com, ardb@kernel.org,
        arnd@arndb.de, dvyukov@google.com, geert+renesas@glider.be,
        glider@google.com, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, lukas.bulwahn@gmail.com,
        mark.rutland@arm.com, masahiroy@kernel.org, matthias.bgg@gmail.com,
        ryabinin.a.a@gmail.com, yj.chiang@mediatek.com
Subject: Re: [PATCH v3 1/2] arm: kasan: support CONFIG_KASAN_VMALLOC
Message-ID: <YislvzIg3Tvwj2+J@shell.armlinux.org.uk>
References: <20220227134726.27584-1-lecopzer.chen@mediatek.com>
 <20220227134726.27584-2-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220227134726.27584-2-lecopzer.chen@mediatek.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2022 at 09:47:25PM +0800, Lecopzer Chen wrote:
> Simply make shadow of vmalloc area mapped on demand.
> 
> Since the virtual address of vmalloc for Arm is also between
> MODULE_VADDR and 0x100000000 (ZONE_HIGHMEM), which means the shadow
> address has already included between KASAN_SHADOW_START and
> KASAN_SHADOW_END.
> Thus we need to change nothing for memory map of Arm.
> 
> This can fix ARM_MODULE_PLTS with KASan, support KASan for higmem
> and provide the first step to support CONFIG_VMAP_STACK with Arm.
> 
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> ---
>  arch/arm/Kconfig                 |  1 +
>  arch/arm/include/asm/kasan_def.h | 11 ++++++++++-
>  arch/arm/mm/kasan_init.c         |  6 +++++-
>  3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 4c97cb40eebb..78250e246cc6 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -72,6 +72,7 @@ config ARM
>  	select HAVE_ARCH_KFENCE if MMU && !XIP_KERNEL
>  	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
>  	select HAVE_ARCH_KASAN if MMU && !XIP_KERNEL
> +	select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
>  	select HAVE_ARCH_MMAP_RND_BITS if MMU
>  	select HAVE_ARCH_PFN_VALID
>  	select HAVE_ARCH_SECCOMP
> diff --git a/arch/arm/include/asm/kasan_def.h b/arch/arm/include/asm/kasan_def.h
> index 5739605aa7cf..96fd1d3b5a0c 100644
> --- a/arch/arm/include/asm/kasan_def.h
> +++ b/arch/arm/include/asm/kasan_def.h
> @@ -19,7 +19,16 @@
>   * space to use as shadow memory for KASan as follows:
>   *
>   * +----+ 0xffffffff
> - * |    |							\
> + * |    |\
> + * |    | |-> ZONE_HIGHMEM for vmalloc virtual address space.
> + * |    | |   Such as vmalloc(), GFP_HIGHUSER (__GFP__HIGHMEM),
> + * |    | |   module address using ARM_MODULE_PLTS, etc.
> + * |    | |
> + * |    | |   If CONFIG_KASAN_VMALLOC=y, this area would populate
> + * |    | |   shadow address on demand.
> + * |    |/

This diagram is incorrect. We already have the memory layout in
Documentation/arm/memory.rst, so we don't need another set of
documentation that is misleading.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
