Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A6454E120
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 14:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbiFPMxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 08:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbiFPMxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 08:53:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154081CB08
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 05:53:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA7D6B823AC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 12:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BF0C3411A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 12:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655383983;
        bh=myK7d98cLrH7qhQA1zgoDRUULM2Cp9liFcQdJNrHrjM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qz7R6TXxY3BL8iMWUvOLbyRl+7DQoSXW72CPWK9zMmomsGuc/39cf9WLdf0wgaUPI
         QEsKmoE6pDjihj5ATKx1j9HybvkY/x+CMj+WlQhdKXUf2nJ0LTBkl3Jxi1kBzhOowy
         cV+sg6DuG8YbZPMR3CUQV7JNntvAXhuU7+EN21NHGgYGuuG+og28tkAGDodModJpxW
         sfESDW2/h80KqeoO2Xo4gGqtvWfZJINxxTKQxxfOfEsKgfMH01HtWE/bfsXlcDA2hw
         rgSyNTmdPCGw3cy3kZI3HsvTec1CNM/kLKpKqRBMZxfxahGHoAvWICQxm4GJmbNJat
         atygQopUGC9IQ==
Received: by mail-lf1-f50.google.com with SMTP id 20so2066767lfz.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 05:53:03 -0700 (PDT)
X-Gm-Message-State: AJIora/8OHHKNQuXMOqAHYmyrnTwmqJH3EgveitKE3UjRYmiYwtXZpqU
        6ls2u38vUz14CvxRpp8/u/ayQGwpkXCnqtCyCdY=
X-Google-Smtp-Source: AGRyM1uP5sNWwyN4GX+1MNAFJlblTUV3hV8XoWVbHwYokhl7Q3Tazef7ybyhaK/WM1pvMQBj9h4WPhmLBpFgNd+2g9I=
X-Received: by 2002:a05:6512:2398:b0:479:24aa:6454 with SMTP id
 c24-20020a056512239800b0047924aa6454mr2778400lfv.664.1655383981216; Thu, 16
 Jun 2022 05:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <1655288973-6066-1-git-send-email-yangtiezhu@loongson.cn> <1655288973-6066-4-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1655288973-6066-4-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 16 Jun 2022 20:52:48 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7ULiOUP-7RfLvQb2mOKt7NtqKUxipkfXdbkPGgzEptrQ@mail.gmail.com>
Message-ID: <CAAhV-H7ULiOUP-7RfLvQb2mOKt7NtqKUxipkfXdbkPGgzEptrQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/3] LoongArch: No need to call RESTORE_ALL_AND_RET
 for all syscalls
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>, Jun Yi <yijun@loongson.cn>,
        Rui Wang <wangrui@loongson.cn>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tiezhu,

On Wed, Jun 15, 2022 at 6:29 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> In handle_syscall, it is unnecessary to call RESTORE_ALL_AND_RET
> for all syscalls.
>
> (1) clone and clone3 call RESTORE_STATIC_SOME_SP_AND_RET.
> (2) rt_sigreturn and rt_sigsuspend call RESTORE_TEMP_SOME_SP_AND_RET.
I doubt that you have not tested, it is obvious that rt_sigreturn need
RESTORE_ALL.

Huacai

> (3) The other syscalls call RESTORE_SOME_SP_AND_RET.
>
> With this patch, it can reduce many load instructions.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/include/asm/stackframe.h | 17 +++++++++++++++++
>  arch/loongarch/kernel/entry.S           | 25 ++++++++++++++++++++++++-
>  2 files changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
> index 4ca9530..52649a5f 100644
> --- a/arch/loongarch/include/asm/stackframe.h
> +++ b/arch/loongarch/include/asm/stackframe.h
> @@ -216,4 +216,21 @@
>         RESTORE_SP_AND_RET \docfi
>         .endm
>
> +       .macro  RESTORE_SOME_SP_AND_RET docfi=0
> +       RESTORE_SOME \docfi
> +       RESTORE_SP_AND_RET \docfi
> +       .endm
> +
> +       .macro  RESTORE_STATIC_SOME_SP_AND_RET docfi=0
> +       RESTORE_STATIC \docfi
> +       RESTORE_SOME \docfi
> +       RESTORE_SP_AND_RET \docfi
> +       .endm
> +
> +       .macro  RESTORE_TEMP_SOME_SP_AND_RET docfi=0
> +       RESTORE_TEMP \docfi
> +       RESTORE_SOME \docfi
> +       RESTORE_SP_AND_RET \docfi
> +       .endm
> +
>  #endif /* _ASM_STACKFRAME_H */
> diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
> index a0f7fcc..e27e38b 100644
> --- a/arch/loongarch/kernel/entry.S
> +++ b/arch/loongarch/kernel/entry.S
> @@ -72,10 +72,33 @@ SYM_FUNC_START(handle_syscall)
>         li.d    tp, ~_THREAD_MASK
>         and     tp, tp, sp
>
> +       /* Syscall number held in a7, we can store it in TI_SYSCALL. */
> +        LONG_S  a7, tp, TI_SYSCALL
> +
>         move    a0, sp
>         bl      do_syscall
>
> -       RESTORE_ALL_AND_RET
> +       /*
> +        * Syscall number held in a7 which is stored in TI_SYSCALL.
> +        * clone and clone3 call RESTORE_STATIC_SOME_SP_AND_RET.
> +        * rt_sigreturn and rt_sigsuspend call RESTORE_TEMP_SOME_SP_AND_RET.
> +        * The other syscalls call RESTORE_SOME_SP_AND_RET.
> +        */
> +       LONG_L  t3, tp, TI_SYSCALL
> +       li.w    t4, __NR_clone
> +       beq     t3, t4, 3f
> +       li.w    t4, __NR_clone3
> +       beq     t3, t4, 3f
> +       li.w    t4, __NR_rt_sigreturn
> +       beq     t3, t4, 4f
> +       li.w    t4, __NR_rt_sigsuspend
> +       beq     t3, t4, 4f
> +
> +       RESTORE_SOME_SP_AND_RET
> +3:
> +       RESTORE_STATIC_SOME_SP_AND_RET
> +4:
> +       RESTORE_TEMP_SOME_SP_AND_RET
>  SYM_FUNC_END(handle_syscall)
>
>  SYM_CODE_START(ret_from_fork)
> --
> 2.1.0
>
