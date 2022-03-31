Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504B14EE40B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 00:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242462AbiCaWc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 18:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbiCaWc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:32:57 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03A51AD1E9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:31:05 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c23so922215plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=6rCIWfpdFAllh+9z/8pwwHeBN74C9Zcoha/nyACYmoU=;
        b=2dwO5l/WblSbRyA/G4tpPYKzqLPlGlQZk1glLxEPxzRRKLyqRqT2NX4K9/fO3Sr2vm
         AFx3rSxw9XC3u6d5dlb1dJDGLvkWuTgON5KIId1jPXp1aVxWmq3ZZhBghb87Lc0X/qHm
         mHclNe2SQjb9svdijG888dkZDmjxCkaii1zL8imrwL0Zp5zOnPxc2IE+CyCoDOBc0qYk
         0njDHKKkh3t+WIm+ZxWGoKMGPzXtp1KOl5NgL3sBjZIK8+N/+IoAd/P89NExVDVD9EMY
         2/5a6Pdjvxnf4KFMHwAZmousU7JZwsMYfQDYf/aFmrVrX9Ve2TTuFFeD1eFhdXtVGSo2
         cFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=6rCIWfpdFAllh+9z/8pwwHeBN74C9Zcoha/nyACYmoU=;
        b=HEY19xRko0LLzw+QPDzkPUgOjFu9rAiXAdpWH8mCW6YGD1eJwd0VJw1aWGxac77Abg
         CoIlARtMQu5FgiqhfxlUvyxHsLsnniMdEcfm1s8AHMg149IgeAGq/L7+dmwegL2MUWTN
         8Tt/J569EEEK62nZ4SZ4sP6x1isciKVx9m6bBVKBA1OpLxSzd5dKAGaS0P3JhaVNuqE8
         Kf6fhBL40OhGesBvJYQc1wfyjkoWJT7NKN8mqvbqvjqhRfVi30svjT84PW5etlQW5Zp7
         wJxs9vTp+HLAsBgM4lDmYGScUY4hiGFQjTgbSIv2Ha8w5Vo/NcyzArGCW+FstJkmyHZk
         ip2g==
X-Gm-Message-State: AOAM533QhXUMTgdNvE8kESmLm5c0nY95yVdvwUjJA4YYMA9sD7iGFdv/
        CZFLaNEC7cqPVFSFujRY29dnpw==
X-Google-Smtp-Source: ABdhPJyhj2zGOHhxHI/lpYy2Ix6Q0TfDIi54rB5i74CsZ92GfKnbBcxwzHOjaQxm2UnYfYO7i1f2bA==
X-Received: by 2002:a17:90a:8595:b0:1bb:fbfd:bfbf with SMTP id m21-20020a17090a859500b001bbfbfdbfbfmr8384073pjn.125.1648765865165;
        Thu, 31 Mar 2022 15:31:05 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a019600b001c6457e1760sm339213pjc.21.2022.03.31.15.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 15:31:03 -0700 (PDT)
Date:   Thu, 31 Mar 2022 15:31:03 -0700 (PDT)
X-Google-Original-Date: Thu, 31 Mar 2022 13:54:35 PDT (-0700)
Subject:     Re: [PATCH v2] RISC-V: Enable profiling by default
In-Reply-To: <20220324053020.606637-1-apatel@ventanamicro.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, atishp@atishpatra.org,
        Alistair Francis <Alistair.Francis@wdc.com>,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, apatel@ventanamicro.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     apatel@ventanamicro.com
Message-ID: <mhng-82bfc066-f5f9-42ab-9cbf-f41d91011748@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2022 22:30:20 PDT (-0700), apatel@ventanamicro.com wrote:
> Let us enable profiling by default in RV32 and RV64 defconfigs so
> that we can use RISC-V PMU drivers on various RISC-V platforms.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
> Changes since v1:
>  - Enable CONFIG_PROFILING instead of CONFIG_PREF_EVENTS in defconfigs
> ---
>  arch/riscv/configs/defconfig      | 1 +
>  arch/riscv/configs/rv32_defconfig | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index f120fcc43d0a..bfebee46784c 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -15,6 +15,7 @@ CONFIG_CHECKPOINT_RESTORE=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_EXPERT=y
>  # CONFIG_SYSFS_SYSCALL is not set
> +CONFIG_PROFILING=y
>  CONFIG_SOC_MICROCHIP_POLARFIRE=y
>  CONFIG_SOC_SIFIVE=y
>  CONFIG_SOC_VIRT=y
> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> index 8b56a7f1eb06..2b68b1bd2559 100644
> --- a/arch/riscv/configs/rv32_defconfig
> +++ b/arch/riscv/configs/rv32_defconfig
> @@ -15,6 +15,7 @@ CONFIG_CHECKPOINT_RESTORE=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_EXPERT=y
>  # CONFIG_SYSFS_SYSCALL is not set
> +CONFIG_PROFILING=y
>  CONFIG_SOC_SIFIVE=y
>  CONFIG_SOC_VIRT=y
>  CONFIG_ARCH_RV32I=y

Thanks, this is on for-next.
