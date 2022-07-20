Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807B857B36F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiGTJBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiGTJBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:01:17 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384C9419A4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 02:01:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6D88ACE1F2E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 09:01:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85789C341D0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 09:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658307668;
        bh=vij3xEAreA0G5szeWk88+d4Xp57P6c4ll2m+XCxei8A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O5Wg1M9j1o/NGtP/V0wOdyp6Sb/+31Lpnf5yGATdQVx9KdJpKYjCM8AY9dgsCVwD+
         wLstczMebtKfXc0Ar3+/nu6UmkcmVtKrhOkDvh9VCdCPsJgH28tqLNu4JJA4sfAstZ
         4Z0rOAnumJRejbI0Hz/ssEvWu5bbrjP6/KaZeUiDWlEbk8QcMKu7Ksu2IFyfIfhALS
         anK1PVDv/lbMA5Y7B6rQlFdKQCf7r+nPdybjbn7wAhORqKk1bpJaKCJ2+hYgaJFANr
         t68rdrPscBWD4TlC7i91tDrNtLShQEajiB4LtqCupFz2VGO5i/0p41heejm7CowMrI
         pCj0hJ7EPJBmA==
Received: by mail-ua1-f53.google.com with SMTP id u12so7791640uap.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 02:01:08 -0700 (PDT)
X-Gm-Message-State: AJIora/BaBECgM9SRi+l1YYgg13QBD9XdsBv5IMdTsRVabwPiuCDzMcl
        HCgW4KVIH+S/ePAitsIJ93VEzm8Jzrt/CG8W1Ak=
X-Google-Smtp-Source: AGRyM1uzuCkEWr8GdNBqK0qQcQu6vZNJfhOZ771XERIbrKrdEjicTad3sHXaky/ZCMV5I2IQd9jw3HxI2kAEmIpe0mI=
X-Received: by 2002:a9f:3253:0:b0:383:c330:68 with SMTP id y19-20020a9f3253000000b00383c3300068mr9795065uad.104.1658307666982;
 Wed, 20 Jul 2022 02:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220720072152.3894559-1-maobibo@loongson.cn>
In-Reply-To: <20220720072152.3894559-1-maobibo@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 20 Jul 2022 17:00:54 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6tdimtT4P6LTaR7iMbL9ChF5_RDEFZPZvm-gQrtTotMA@mail.gmail.com>
Message-ID: <CAAhV-H6tdimtT4P6LTaR7iMbL9ChF5_RDEFZPZvm-gQrtTotMA@mail.gmail.com>
Subject: Re: [PATCH 1/2] LoongArch: Remove clock setting during cpu hotplug stage
To:     Bibo Mao <maobibo@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibo,

This series looks good to me, but I want to wait for some time to see
if others have comments. Thanks.

Huacai

On Wed, Jul 20, 2022 at 3:22 PM Bibo Mao <maobibo@loongson.cn> wrote:
>
> On physical machine we can save power by disabling clock of hot removed cpu.
> However there will be problem, since different platforms have different clock
> setting methods, the code is platform relative. Also it can be in firmware/pmu
> compoments or cpu regulator driver, rather than general loongarch cpu booting
> flow.
>
> Also on qemu virt machine, device clock/freq setting is not
> emulated, there is no such registers.
>
> This patch removes hard-coded register accessing in generic
> loongarch cpu boot flow.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/kernel/smp.c | 29 -----------------------------
>  include/linux/cpuhotplug.h  |  1 -
>  2 files changed, 30 deletions(-)
>
> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> index 73cec62504fb..98b3e059d344 100644
> --- a/arch/loongarch/kernel/smp.c
> +++ b/arch/loongarch/kernel/smp.c
> @@ -359,35 +359,6 @@ void play_dead(void)
>         play_dead_uncached(state_addr);
>  }
>
> -static int loongson3_enable_clock(unsigned int cpu)
> -{
> -       uint64_t core_id = cpu_data[cpu].core;
> -       uint64_t package_id = cpu_data[cpu].package;
> -
> -       LOONGSON_FREQCTRL(package_id) |= 1 << (core_id * 4 + 3);
> -
> -       return 0;
> -}
> -
> -static int loongson3_disable_clock(unsigned int cpu)
> -{
> -       uint64_t core_id = cpu_data[cpu].core;
> -       uint64_t package_id = cpu_data[cpu].package;
> -
> -       LOONGSON_FREQCTRL(package_id) &= ~(1 << (core_id * 4 + 3));
> -
> -       return 0;
> -}
> -
> -static int register_loongson3_notifier(void)
> -{
> -       return cpuhp_setup_state_nocalls(CPUHP_LOONGARCH_SOC_PREPARE,
> -                                        "loongarch/loongson:prepare",
> -                                        loongson3_enable_clock,
> -                                        loongson3_disable_clock);
> -}
> -early_initcall(register_loongson3_notifier);
> -
>  #endif
>
>  /*
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 19f0dbfdd7fe..b66c5f389159 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -130,7 +130,6 @@ enum cpuhp_state {
>         CPUHP_ZCOMP_PREPARE,
>         CPUHP_TIMERS_PREPARE,
>         CPUHP_MIPS_SOC_PREPARE,
> -       CPUHP_LOONGARCH_SOC_PREPARE,
>         CPUHP_BP_PREPARE_DYN,
>         CPUHP_BP_PREPARE_DYN_END                = CPUHP_BP_PREPARE_DYN + 20,
>         CPUHP_BRINGUP_CPU,
> --
> 2.31.1
>
>
