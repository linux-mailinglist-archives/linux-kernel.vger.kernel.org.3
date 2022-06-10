Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B3A545A75
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 05:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346063AbiFJDWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 23:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346110AbiFJDWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 23:22:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F48D205FB1;
        Thu,  9 Jun 2022 20:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ChyT0oyx9WdA4yK5yPyg83KmH+2gh/M8HpFx0h62jOY=; b=oVy9GtbWUKOXfXSkGDcg0oxC9L
        5/sh+JxCGyID3b3Fg0UcmqjNYabidBU4P7h/v/0CtKVJFKKxTdroqL4VmZ2MaK2WZ4wqwUgVe6Lv/
        YfiHMVc9KqE78yL5V+vmJ20pa7i0kP7AkjgN9DjTA26YzEPCIZNrxPQYkPcTu6g38UjfC6ffIO02e
        TOe0LhdmHSttoRmWxhVJEHAnLJTKIMb+xMuN37tRpHNtD1w/RX4SBBg0fZk6SZaAZigRGHXnLh5uf
        aPEm78CbXLp3fa+MeBoM2Qn98OLfg1tnBUTa45BhcqhkzEXXHBwTpFOI5WVFCwPe/aT+UylXUefc/
        A3iMISyQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzVE5-00E6a4-8q; Fri, 10 Jun 2022 03:22:21 +0000
Message-ID: <57f53f61-f79f-5520-9de1-d410e6c704c9@infradead.org>
Date:   Thu, 9 Jun 2022 20:22:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/3] riscv: Implement Zicbom-based cache management
 operations
Content-Language: en-US
To:     Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, hch@lst.de, samuel@sholland.org,
        atishp@atishpatra.org, anup@brainfault.org, mick@ics.forth.gr,
        robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org,
        drew@beagleboard.org, Atish Patra <atish.patra@wdc.com>
References: <20220610004308.1903626-1-heiko@sntech.de>
 <20220610004308.1903626-3-heiko@sntech.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220610004308.1903626-3-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/22 17:43, Heiko Stuebner wrote:
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 32ffef9f6e5b..384d0c15f2b6 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -376,6 +376,21 @@ config RISCV_ISA_SVPBMT
>  
>  	   If you don't know what to do here, say Y.
>  
> +config RISCV_ISA_ZICBOM
> +	bool "Zicbom extension support for non-coherent dma operation"
> +	select ARCH_HAS_DMA_PREP_COHERENT
> +	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
> +	select ARCH_HAS_SYNC_DMA_FOR_CPU
> +	select ARCH_HAS_SETUP_DMA_OPS
> +	select DMA_DIRECT_REMAP
> +	select RISCV_ALTERNATIVE

Since RISCV_ALTERNATIVE depends on !XIP_KERNEL and since 'select' does not
follow any dependency chains, this config also needs to depend on
!XIP_KERNEL.

> +	default y
> +	help
> +	   Adds support to dynamically detect the presence of the ZICBOM extension
> +	   (Cache Block Management Operations) and enable its usage.
> +
> +	   If you don't know what to do here, say Y.

-- 
~Randy
