Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1208348B3DA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344215AbiAKR2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344256AbiAKR2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:28:12 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A959C03400E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 09:28:07 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id pj2so58628pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 09:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=12+q0b6y6nH7kbDmn5mxOCkgQv+jyWWInPi8qR3sLk0=;
        b=JXfN+aLUdx2zlu9qac6uYhla2U/n8TT6p+hrU2GGv0I6TKuQe+IPgh8G5lv5757keI
         l5oDFnb4HpmzkMW6hgqDXu0R/FRYbjfs6AKjay71k5mZWDQkXNA3DAuMPbMBksXzp2xw
         FQ9PWBH9Ry/ouH+0AL2n0zYCPZK0gjci88ohw3L1motWzX7XKg5CDN1c9ErNPgh95FV0
         OX0dG4OBgbQjFk3zoxgez0BiFzqcJ5zVc4913i8lszMlKgwld3eJIGOYujLXcl1A9DDF
         SyWXmN5lD7NIhnlESzVUqYLSOb0TClQ0V4cCz+2tVvRdVx6rFTQrYx0I+JIVLxzdQOoS
         DHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=12+q0b6y6nH7kbDmn5mxOCkgQv+jyWWInPi8qR3sLk0=;
        b=0nZNh5TER4YYJL4U7yfPzSkj8rWWau21T8jInR7ns3zLDTn39QTlqi45lwfnf14FtP
         pG8Bxjzv5O9hKzmMI8xpr6tlZplDI76Kv9hdLfBKALd4RykAVoIZihna3HhwktcHzujb
         ur2mJCsRgu760U7OaBlhyI8VLAC/2apwNopshgzrZMmSWwRb9yw5iFD+wT+GmXX47Sea
         yuUKjsSKl3eaX2bifQKZSCwbLPnOKaD0B7NLFLjRptc0jR/JsjWLARUdPT+qVAYtiwe9
         6joTP3GF27e9fD0xbECMhTzycgFUmsK5umygdMnI5sD8OM03px/8W3I10T3tterasNTV
         d/ow==
X-Gm-Message-State: AOAM531MbTY8QtIEEljjaWbMyijN7uxeg6lMYjW7d6Mni7csfiYjwXuK
        33FrFXRfX0+YWmy2QQk45noBCevebGXLQQ==
X-Google-Smtp-Source: ABdhPJyMMLCfkog+/r5Po8vgFXuxtpWPcgiAhliF7cPIp8Sqws1L7o06MOk1nanJj51Y59PSWbbI3A==
X-Received: by 2002:a05:6a00:1413:b0:4bf:a0d7:1f55 with SMTP id l19-20020a056a00141300b004bfa0d71f55mr5587142pfu.13.1641922086523;
        Tue, 11 Jan 2022 09:28:06 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id b21sm11261590pfv.74.2022.01.11.09.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 09:28:05 -0800 (PST)
Date:   Tue, 11 Jan 2022 09:28:05 -0800 (PST)
X-Google-Original-Date: Tue, 11 Jan 2022 09:27:38 PST (-0800)
Subject:     Re: [PATCH] riscv: mm: fix wrong phys_ram_base value for RV64
In-Reply-To: <20211202153641.1961-1-jszhang@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        alex@ghiti.fr, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang@kernel.org
Message-ID: <mhng-662897d8-3b0a-4580-a607-f853c01263b5@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Dec 2021 07:36:41 PST (-0800), jszhang@kernel.org wrote:
> Currently, if 64BIT and !XIP_KERNEL, the phys_ram_base is always 0,
> no matter the real start of dram reported by memblock is. The original
> patch[1] is correct, I believe it's not corrected merged due to lots
> of #ifdef in arch/riscv/mm/init.c, I plan to send a clean up series
> soon.
>
> [1] http://lists.infradead.org/pipermail/linux-riscv/2021-July/007650.html
>
> Fixes: 6d7f91d914bc ("riscv: Get rid of CONFIG_PHYS_RAM_BASE in kernel physical address conversion")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Thanks, this is on for-next.

> ---
>  arch/riscv/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 24b2b8044602..3c0649dba4ff 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -187,10 +187,10 @@ static void __init setup_bootmem(void)
>
>
>  	phys_ram_end = memblock_end_of_DRAM();
> -#ifndef CONFIG_64BIT
>  #ifndef CONFIG_XIP_KERNEL
>  	phys_ram_base = memblock_start_of_DRAM();
>  #endif
> +#ifndef CONFIG_64BIT
>  	/*
>  	 * memblock allocator is not aware of the fact that last 4K bytes of
>  	 * the addressable memory can not be mapped because of IS_ERR_VALUE
