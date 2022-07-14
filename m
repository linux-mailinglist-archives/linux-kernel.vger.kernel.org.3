Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4472C574EBE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239257AbiGNNMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiGNNMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:12:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA6D43E60
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:12:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 890BD62047
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF7BC34115
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657804353;
        bh=nEK6K0+xvlBOpmwF55h7AMv2fTvVGg4WhQpZfCPwTck=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K4QkIeEnSjNOVvIakhJPaz+BMQichtSdqlqgo/9PLPrADjb9O9Q7eTVA5sAArg7G7
         Wz2U29ZAffJAfCXtoyOV+ugQq7WiQTilWhdtejxGRfB79Ei8UPkylXA7hifTOYzqpj
         9eX59A1bmQ3oOtuS7yZxkIBZwJGXLb+YCFMrXg3CYQJ1PRRSeHFzf+o083G/g+ZpBO
         9bueQO2PlVC/gxQyaExACobVz9Y4bQZD+UWOczvu6Jwr3S1gjUffzVLPx7VLI0t5H/
         hNOIwmDnOoxuaMcs3fXNaRIurBTkTWzTK5+hYAONAWeGobvMhsha+U2cAlgrdgnXBr
         FcjGfj2Ij2hbA==
Received: by mail-vk1-f169.google.com with SMTP id y129so780486vkg.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:12:33 -0700 (PDT)
X-Gm-Message-State: AJIora953oNUQIlXXnw8fdyPmH7mD81x8JDXXYDQdve5cRFkHcie0QPy
        ZTUnchA+YIq2ZA+QJ2ROSSuTanmcjZs4QbWGPFw=
X-Google-Smtp-Source: AGRyM1vfuUcnXizkvLae+QNNbMgGaJxyylCp70bxKvXjxeF0ccvn003iMZHCh7GShPROgiewYW9IR85nmtOm2qXw1Wg=
X-Received: by 2002:a05:6122:329:b0:374:f09c:876f with SMTP id
 d9-20020a056122032900b00374f09c876fmr3625484vko.12.1657804352795; Thu, 14 Jul
 2022 06:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220714062550.4934-1-huqi@loongson.cn>
In-Reply-To: <20220714062550.4934-1-huqi@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 14 Jul 2022 21:12:20 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6NWYG1ChLRyK-EAGAmhDvP-x+z9BgBo3a=GAbQ-2bKig@mail.gmail.com>
Message-ID: <CAAhV-H6NWYG1ChLRyK-EAGAmhDvP-x+z9BgBo3a=GAbQ-2bKig@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Fix missing fcsr in ptrace's fpr_set
To:     Qi Hu <huqi@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>, Oleg Nesterov <oleg@redhat.com>,
        Xu Li <lixu@loongson.cn>, loongarch@lists.linux.dev,
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

Hi,

On Thu, Jul 14, 2022 at 2:26 PM Qi Hu <huqi@loongson.cn> wrote:
>
> In file ptrace.c, function fpr_set does not copy fcsr data from ubuf
> to kbuf. That's the reason why fcsr cannot be modified by ptrace.
>
> This patch fixs this problem and allows users using ptrace to modify
> the fcsr.
>
> Signed-off-by: Qi Hu <huqi@loongson.cn>
> Signed-off-by: Xu Li <lixu@loongson.cn>
> ---
>  arch/loongarch/kernel/ptrace.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/arch/loongarch/kernel/ptrace.c b/arch/loongarch/kernel/ptrace.c
> index e6ab87948e1d..dc2b82ea894c 100644
> --- a/arch/loongarch/kernel/ptrace.c
> +++ b/arch/loongarch/kernel/ptrace.c
> @@ -193,7 +193,7 @@ static int fpr_set(struct task_struct *target,
>                    const void *kbuf, const void __user *ubuf)
>  {
>         const int fcc_start = NUM_FPU_REGS * sizeof(elf_fpreg_t);
> -       const int fcc_end = fcc_start + sizeof(u64);
> +       const int fcsr_start = fcc_start + sizeof(u64);
>         int err;
>
>         BUG_ON(count % sizeof(elf_fpreg_t));
> @@ -209,10 +209,12 @@ static int fpr_set(struct task_struct *target,
>         if (err)
>                 return err;
>
> -       if (count > 0)
> -               err |= user_regset_copyin(&pos, &count, &kbuf, &ubuf,
> -                                         &target->thread.fpu.fcc,
> -                                         fcc_start, fcc_end);
> +       err |= user_regset_copyin(&pos, &count, &kbuf, &ubuf,
> +                                 &target->thread.fpu.fcc, fcc_start,
> +                                 fcc_start + sizeof(u64));
> +       err |= user_regset_copyin(&pos, &count, &kbuf, &ubuf,
> +                                 &target->thread.fpu.fcsr, fcsr_start,
> +                                 fcsr_start + sizeof(u32));
You shouldn't remove (count > 0) here, because  the above
user_regset_copyin() will modify count inside, and so "count == 0" is
possible.

Huacai
>
>         return err;
>  }
> --
> 2.37.0
>
