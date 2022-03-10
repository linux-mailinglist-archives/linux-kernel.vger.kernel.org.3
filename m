Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE194D52D5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 21:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244556AbiCJUIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 15:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238154AbiCJUIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 15:08:05 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B658199E1D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 12:07:04 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id e2so5838789pls.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 12:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Ppb+nGqWIW/h/QwBcLw4pfKIt8cQodBBM6cAdLT5fmg=;
        b=YBCZBfTIz23WWu52f/w33APGnaMo4Ft4vbVYLvHDN5C8XSlriqdDpZ2Eohqo/r8lOM
         GbJ393d6CB40bzKpuc7X+GXaJ93iAZHIZCnVQsc8VjEtG3zEaldDyQffxuWaZmbaxUhg
         nomlAeOcgZixR3aA5pCDXs3fcAz4LForgtfbNVXWUQ1SkBqCNH1a/6TZFAGl25xBXKDT
         ZPLlVFfx2w5RC1Q2gbS9fwGkNeCMwKcHUiMGPU0ZI2Vi7xCO+xRkwPsBQYho/397MX0+
         O88MiL4bFACHTX0DbUkIq+05yugAALYXQVQMLvD6dkxqaXz2TdeOEa2z5Qk7YmBWJhNv
         fTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Ppb+nGqWIW/h/QwBcLw4pfKIt8cQodBBM6cAdLT5fmg=;
        b=zfSwmQO1ZAu60mZoI4JwMfMG1H7pzQ4I3+BezLOedOPv51EqYfa2bshax3EnObf0ys
         Zit6NP7B81ZmRa4gagsDlZU5BIaFV5kvcy6TZLQdJSIHOH99+Z1yKY2G/LxJILdoUi0h
         lnOK5R3RZhLsA8gdZrRuus3j/4NX5za4H5whiMRObZOgBfzfMoLihckT9eaKYi2YwiNs
         AJzXfrsJskGuNPOgiR8//Cvf5Emq70M887PCYm5fO5jjM/i3o42hznwrr4nnpemyn21X
         JxnRzX7Szv+SbIEIqbwuQnbno130Cg7ssZwrdcJpgFfyLJ7DnRJdsA9NuhhYC210iGNp
         WDnA==
X-Gm-Message-State: AOAM531ClQ2g4E7IOcqaSBE2bt42ExUYbDYZFng4XAxwQk6FdZKTnvUo
        PVA/uc9M9H6LA0272eak8NKz6A==
X-Google-Smtp-Source: ABdhPJx4NYlzgFs+WmYMXzXTZ4RuxK05hR+/Tjnk6lJFxCjljwre381MVmPlu9JE10S/2ylACzy2bQ==
X-Received: by 2002:a17:90b:1e01:b0:1bf:5f6e:cbef with SMTP id pg1-20020a17090b1e0100b001bf5f6ecbefmr6853622pjb.130.1646942823454;
        Thu, 10 Mar 2022 12:07:03 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id a32-20020a631a20000000b003756899829csm6258878pga.58.2022.03.10.12.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 12:07:02 -0800 (PST)
Date:   Thu, 10 Mar 2022 12:07:02 -0800 (PST)
X-Google-Original-Date: Thu, 10 Mar 2022 12:06:07 PST (-0800)
Subject:     Re: [PATCH] riscv: alternative only works on !XIP_KERNEL
In-Reply-To: <20220210164943.2646-1-jszhang@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        heiko@sntech.de
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang@kernel.org
Message-ID: <mhng-3d749a55-0e5d-49fd-8682-06e8a058dfe0@palmer-ri-x1c9>
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

On Thu, 10 Feb 2022 08:49:43 PST (-0800), jszhang@kernel.org wrote:
> The alternative mechanism needs runtime code patching, it can't work
> on XIP_KERNEL. And the errata workarounds are implemented via the
> alternative mechanism. So add !XIP_KERNEL dependency for alternative
> and erratas.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/Kconfig.erratas | 1 +
>  arch/riscv/Kconfig.socs    | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
> index b44d6ecdb46e..0aacd7052585 100644
> --- a/arch/riscv/Kconfig.erratas
> +++ b/arch/riscv/Kconfig.erratas
> @@ -2,6 +2,7 @@ menu "CPU errata selection"
>
>  config RISCV_ERRATA_ALTERNATIVE
>  	bool "RISC-V alternative scheme"
> +	depends on !XIP_KERNEL
>  	default y
>  	help
>  	  This Kconfig allows the kernel to automatically patch the
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 6ec44a22278a..c112ab2a9052 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -14,8 +14,8 @@ config SOC_SIFIVE
>  	select CLK_SIFIVE
>  	select CLK_SIFIVE_PRCI
>  	select SIFIVE_PLIC
> -	select RISCV_ERRATA_ALTERNATIVE
> -	select ERRATA_SIFIVE
> +	select RISCV_ERRATA_ALTERNATIVE if !XIP_KERNEL
> +	select ERRATA_SIFIVE if !XIP_KERNEL
>  	help
>  	  This enables support for SiFive SoC platform hardware.

Thanks, this is on fixes.
