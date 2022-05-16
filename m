Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DAC5292A5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349186AbiEPVRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349137AbiEPVRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 17:17:12 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9243E1EE
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 14:14:54 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id c24so18511552lfv.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 14:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mVc949hLeA39MqSMbzTaJoP2sRl/dspbJRT8NSeNYX4=;
        b=qJZIvLrGTuenzqr1yf456WkkwoQYRzEEhmvaKPROjmxi48ert0UqLLwuTsHL38UIzV
         sUgW6e+E65UYTYc0N0GdjDaxi403ptbmk5FG17xpyGT6bfEWfYKawemPaS+zZVGjAPjC
         CvRtjh2cCi4S8f8Xvxa6tYN9hR/zLhuq4D7FvfV9pymJr7N5SCAcqEwHZqmTQDlZQBhz
         oyngojxpRgIECN0bthFX+TJedFsSLqUg4Hoi8SopeOcWPbAlw30v51yhzc60Ul4f33Uc
         JFQRw+WiccEgtCRW8MUUL2Ik396GpL/BbsXBfWWkkXFCQURW+22M6evy6BZEppdTHKkN
         C9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mVc949hLeA39MqSMbzTaJoP2sRl/dspbJRT8NSeNYX4=;
        b=0la7Cafxnz5Uy1lhE8a7kZvN6dbfhKdQrUr9Op+q3X/NUo1atSMzRiUcmJoRY/s5Rg
         vXHF3OJ1dx/+FsbXnBKg9IQofJlq22FcWa2knzlLizqRljXWUmigRKY1FTzmKS1zLIHJ
         rFCLQbDyuEI61yxHqOSms3MbFWy2LRWp5QNnScYudXrI6Qucrl2mAOH7toLU3fptdR62
         pg2pnOy8w9LvfIo3RCtB7c6+hEWQUIi9SUJcKsQ8P79Mlj7pBTdiKbe016nMVNNtDwGc
         MNjk3dPMPnoZny/fkVy8NOzjDDaXYlsKwC/Q/cPNpQMeCzgGUn6v+h5K7qEmRHn7l31d
         /RSQ==
X-Gm-Message-State: AOAM530+4D9s/E/2rr+Q+Q84G2H37gRuq0jO1WyDO1lm/TbpJW1LYWUY
        efl5iX7GIqN5DY5docDmu6w037VS881OGt9B1dr8aw==
X-Google-Smtp-Source: ABdhPJzcKckoHka00EJ/30FITGJtcoKgaVot2sHBtqy0fyvD5CZtw9xZHCwaV33GZBOg5Zh9WwV9MDsANeWz/ofXqX8=
X-Received: by 2002:a05:6512:3047:b0:473:cf43:6d8f with SMTP id
 b7-20020a056512304700b00473cf436d8fmr14956460lfb.380.1652735692632; Mon, 16
 May 2022 14:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220516210954.1660716-1-ndesaulniers@google.com>
In-Reply-To: <20220516210954.1660716-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 16 May 2022 14:14:41 -0700
Message-ID: <CAKwvOd=SkLwa-0i873oUDt9hRQxA=8dbc26v4Di_rysnE=pJpg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] pass -march= only to compiler
To:     Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Ard (I messed up my command line invocation of git send-email, sorry
for more noise)
https://lore.kernel.org/llvm/20220516210954.1660716-1-ndesaulniers@google.com/

On Mon, May 16, 2022 at 2:10 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> When both -march= and -Wa,-march= are specified for assembler or
> assembler-with-cpp sources, GCC and Clang will prefer the -Wa,-march=
> value but Clang will warn that -march= is unused.
>
> warning: argument unused during compilation: '-march=armv6k'
> [-Wunused-command-line-argument]
>
> This is the top group of warnings we observe when using clang to
> assemble the kernel via `ARCH=arm make LLVM=1`.
>
> Arnd sent a v2 of my previous patch
> https://lore.kernel.org/linux-arm-kernel/20210928154143.2106903-14-arnd@kernel.org/
> I added yet a few more instances I found since then.
>
> Fixing this will allow us to enable
> -Werror=unused-command-line-argument for clang builds.
>
> Nick Desaulniers (4):
>   ARM: remove lazy evaluation in Makefile
>   ARM: use .arch directives instead of assembler command line flags
>   ARM: only use -mtp=cp15 for the compiler
>   ARM: pass -march= only to compiler
>
>  arch/arm/Makefile                   | 76 ++++++++++++++++-------------
>  arch/arm/boot/compressed/Makefile   |  1 -
>  arch/arm/common/Makefile            |  2 -
>  arch/arm/common/mcpm_head.S         |  2 +
>  arch/arm/common/vlock.S             |  2 +
>  arch/arm/kernel/Makefile            |  2 -
>  arch/arm/kernel/hyp-stub.S          |  2 +
>  arch/arm/kernel/swp_emulate.c       |  1 +
>  arch/arm/lib/Makefile               |  4 --
>  arch/arm/lib/delay-loop.S           |  4 ++
>  arch/arm/mach-at91/Makefile         |  3 --
>  arch/arm/mach-at91/pm_suspend.S     |  4 ++
>  arch/arm/mach-imx/Makefile          |  3 --
>  arch/arm/mach-imx/headsmp.S         |  2 +
>  arch/arm/mach-imx/resume-imx6.S     |  2 +
>  arch/arm/mach-imx/suspend-imx6.S    |  2 +
>  arch/arm/mach-mvebu/Makefile        |  3 --
>  arch/arm/mach-mvebu/coherency_ll.S  |  1 +
>  arch/arm/mach-mvebu/pmsu.c          |  1 +
>  arch/arm/mach-npcm/Makefile         |  2 -
>  arch/arm/mach-npcm/headsmp.S        |  2 +
>  arch/arm/mach-tegra/Makefile        |  2 -
>  arch/arm/mach-tegra/reset-handler.S |  2 +
>  arch/arm/mach-tegra/sleep-tegra20.S |  2 +
>  arch/arm/mach-tegra/sleep-tegra30.S |  2 +
>  arch/arm/mm/Makefile                | 15 ------
>  arch/arm/mm/abort-ev6.S             |  1 +
>  arch/arm/mm/abort-ev7.S             |  1 +
>  arch/arm/mm/cache-v6.S              |  2 +
>  arch/arm/mm/cache-v7.S              |  2 +
>  arch/arm/mm/cache-v7m.S             |  2 +
>  arch/arm/mm/copypage-feroceon.c     |  1 +
>  arch/arm/mm/proc-v6.S               |  2 +
>  arch/arm/mm/proc-v7-2level.S        |  2 +
>  arch/arm/mm/proc-v7.S               |  2 +
>  arch/arm/mm/tlb-v6.S                |  2 +
>  arch/arm/mm/tlb-v7.S                |  2 +
>  drivers/memory/Makefile             |  2 -
>  drivers/memory/ti-emif-sram-pm.S    |  1 +
>  drivers/soc/bcm/brcmstb/pm/Makefile |  1 -
>  drivers/soc/bcm/brcmstb/pm/s2-arm.S |  1 +
>  41 files changed, 94 insertions(+), 74 deletions(-)
>
>
> base-commit: 0ac824f379fba2c2b17b75fd5ada69cd68c66348
> --
> 2.36.0.550.gb090851708-goog
>


-- 
Thanks,
~Nick Desaulniers
