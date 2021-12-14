Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB1F474809
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbhLNQ3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhLNQ3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:29:19 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED1DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:29:18 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id n15-20020a17090a394f00b001b0f6d6468eso1115991pjf.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=39DaSKbHGHl7/uZlQw9m3Qmqoy9t3ZKBAe/0qF5AL7A=;
        b=J+SmqJeel8TNyygsI3wZ4ScOB2rLowFvDuzh7kQDx8iGeWQclt8jYJ8jZNIsLMTiH4
         2g+A1XFg1ewp5QmwSL+7rMhxOFKxW7ULYd/G38rooC1rMQ8sDwsEB60pyikT90T+RGyT
         A00xWoPEJfKfLnjASoBwzvG4qxF/Qx4SSryBpZFioxJWFwEi6KNfjx2K8UBcfPiq79x4
         jiSTaX1hfweF75J/xShF8o0erIGuMm7WxQkDXVpRgNbq+NpZhXXeS7oouFBKzsMZLxgI
         lqJdfq9vnx8LJNivjHKEUEAADup5do3kNQIYLDuVns+6KP9tngLYZ0ZfmcO7rz5XWLXA
         ES0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=39DaSKbHGHl7/uZlQw9m3Qmqoy9t3ZKBAe/0qF5AL7A=;
        b=y4jn8pOZBkpOPTEolI2A5rBl+2xklYs6J8GYbhhQ74EbUYYEoW+MPVODQaFXrOn7DB
         7FT7Otr2/Kd81nXvGVYL7dmFW/rtKlCUfgGFv1an+XAPK/tx07DI+fopGMbUdB4mdGNY
         6PISPAFQ7jZjL+/WXp6a0C4vXGtiOXCptPM9jzaEUe/WHLTUbRJn+WPkfnHJv7SbwEZ4
         VoSdYpR10JJA/ll7gl3DpBdM80pels2GXvGFzHpqfkKz9SNZHMAdBa7mmovT0o7iwqC5
         asCESvw2x711Wre5nmI+1d6shcooiTTNFXlHLJXb/3eD5OZu6+jRyU9qQqfLDGC4NkOD
         snDg==
X-Gm-Message-State: AOAM533m5zADSkkdx4rnc4nVoKKDvWT6olcAt3Hv2U4l7l2hu3rXNHWJ
        uc+7f2Q4Y/WWb6tzZkAV3QNL3w==
X-Google-Smtp-Source: ABdhPJyY8ybr7iy7kIyHObng97M3Jkf17suzvWAEqcJ4Iq5MWhD+8BDF5JHxA8iMCHmYtm3YS3zvPQ==
X-Received: by 2002:a17:902:e890:b0:148:a2e7:fb3c with SMTP id w16-20020a170902e89000b00148a2e7fb3cmr63676plg.125.1639499358143;
        Tue, 14 Dec 2021 08:29:18 -0800 (PST)
Received: from localhost ([12.163.77.120])
        by smtp.gmail.com with ESMTPSA id b2sm283472pfv.198.2021.12.14.08.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 08:29:17 -0800 (PST)
Date:   Tue, 14 Dec 2021 08:29:17 -0800 (PST)
X-Google-Original-Date: Mon, 13 Dec 2021 18:17:35 PST (-0800)
Subject:     Re: [PATCH v9 01/17] riscv: Separate patch for cflags and aflags
In-Reply-To: <f76b0312113bf960e114724cb578a060b3f101ab.1636362169.git.greentime.hu@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     greentime.hu@sifive.com
Message-ID: <mhng-24dd1554-4004-4132-abde-6142a4aa19d3@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Nov 2021 01:48:13 PST (-0800), greentime.hu@sifive.com wrote:
> From: Guo Ren <ren_guo@c-sky.com>
>
> Use "subst fd" in Makefile is a hack way and it's not convenient
> to add new ISA feature. Just separate them into riscv-march-cflags
> and riscv-march-aflags.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  arch/riscv/Makefile | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 0eb4568fbd29..37de70df4fae 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -48,12 +48,18 @@ endif
>  endif
>
>  # ISA string setting
> -riscv-march-$(CONFIG_ARCH_RV32I)	:= rv32ima
> -riscv-march-$(CONFIG_ARCH_RV64I)	:= rv64ima
> -riscv-march-$(CONFIG_FPU)		:= $(riscv-march-y)fd
> -riscv-march-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-y)c
> -KBUILD_CFLAGS += -march=$(subst fd,,$(riscv-march-y))
> -KBUILD_AFLAGS += -march=$(riscv-march-y)
> +riscv-march-cflags-$(CONFIG_ARCH_RV32I)		:= rv32ima
> +riscv-march-cflags-$(CONFIG_ARCH_RV64I)		:= rv64ima
> +riscv-march-$(CONFIG_FPU)			:= $(riscv-march-y)fd
> +riscv-march-cflags-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-cflags-y)c
> +
> +riscv-march-aflags-$(CONFIG_ARCH_RV32I)		:= rv32ima
> +riscv-march-aflags-$(CONFIG_ARCH_RV64I)		:= rv64ima
> +riscv-march-aflags-$(CONFIG_FPU)		:= $(riscv-march-aflags-y)fd
> +riscv-march-aflags-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-aflags-y)c
> +
> +KBUILD_CFLAGS += -march=$(riscv-march-cflags-y)
> +KBUILD_AFLAGS += -march=$(riscv-march-aflags-y)
>
>  KBUILD_CFLAGS += -mno-save-restore
>  KBUILD_CFLAGS += -DCONFIG_PAGE_OFFSET=$(CONFIG_PAGE_OFFSET)

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
