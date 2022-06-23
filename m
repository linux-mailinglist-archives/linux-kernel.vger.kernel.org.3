Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4842F557691
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiFWJ0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiFWJ0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:26:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A79543AE2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:26:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA04961D9E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:26:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288A5C341C0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655976411;
        bh=NLqoLncFxRQwlNZgVEkCnqqWs0Cpa13aY3b0Kh1BfWs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AqDHxfAilg5w0BQmTOcF4B3k+usMaJS1K1beUNpm2pBW1PqLdbCGhyPgsEErIeVx/
         qWUPyw/6TRVbZeiZCov2IzFyfB+7OSQF6x02ZGU40krjEvQBiL+Nx7Css0uowkxlQl
         M2wvlqBWAr45VCWFKXxZDJ+vJb1NQQ1Ad8rVqicBcO6Ce40i8P7o+KsUK1gxEq2qYg
         O+7sd4JG5TpwWIcemEmGv+/CCQ2HaSpHbITLVO4KLfAwZOqrrojKjbCkpKfpDdyiSo
         MRDmChFzcUKx2wDPKhM84ke6hM3wqPjOaz2xVTAzgmPL9Dgo3/tBjLptTC4HQdgrIy
         hL5ADubheKpKQ==
Received: by mail-lj1-f170.google.com with SMTP id s10so22523704ljh.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:26:51 -0700 (PDT)
X-Gm-Message-State: AJIora+jfxxC7zN/16zZf/OXI1G50TDJ/KSOP+Xtv4rwinFUXlXGWuAE
        +ONeibN0RYLVvkpIBDKJP+utMYAkUJwQlQBvGWw=
X-Google-Smtp-Source: AGRyM1swPC8XDEX7GijXBa86ISvW22X7XQXOK5EtB0uETmxaCMd5+uCAREsmvpCPnMduQjhP+d3tzIW6b+MjkrS7azw=
X-Received: by 2002:a2e:95c8:0:b0:255:abb5:d0e7 with SMTP id
 y8-20020a2e95c8000000b00255abb5d0e7mr4095110ljh.23.1655976409185; Thu, 23 Jun
 2022 02:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <1655541551-3997-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1655541551-3997-1-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 23 Jun 2022 17:26:35 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5oaCnRyi0xpzzoUs-VemuQtSEStHHzerZFoAQmEabCdw@mail.gmail.com>
Message-ID: <CAAhV-H5oaCnRyi0xpzzoUs-VemuQtSEStHHzerZFoAQmEabCdw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Make compute_return_era() return void
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Xuefeng Li <lixuefeng@loongson.cn>,
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

On Sat, Jun 18, 2022 at 4:39 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> compute_return_era() always returns 0, make it return void,
> and then no need to check its return value for its callers.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/include/asm/branch.h | 3 +--
>  arch/loongarch/kernel/traps.c       | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/branch.h b/arch/loongarch/include/asm/branch.h
> index 3f33c89..9a133e4 100644
> --- a/arch/loongarch/include/asm/branch.h
> +++ b/arch/loongarch/include/asm/branch.h
> @@ -12,10 +12,9 @@ static inline unsigned long exception_era(struct pt_regs *regs)
>         return regs->csr_era;
>  }
>
> -static inline int compute_return_era(struct pt_regs *regs)
> +static inline void compute_return_era(struct pt_regs *regs)
>  {
>         regs->csr_era += 4;
> -       return 0;
>  }
>
>  #endif /* _ASM_BRANCH_H */
> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
> index e4060f8..1bf58c6 100644
> --- a/arch/loongarch/kernel/traps.c
> +++ b/arch/loongarch/kernel/traps.c
> @@ -475,8 +475,7 @@ asmlinkage void noinstr do_ri(struct pt_regs *regs)
>
>         die_if_kernel("Reserved instruction in kernel code", regs);
>
> -       if (unlikely(compute_return_era(regs) < 0))
> -               goto out;
> +       compute_return_era(regs);
Maybe it is better to simply remove the compute_return_era() function?

Huacai
>
>         if (unlikely(get_user(opcode, era) < 0)) {
>                 status = SIGSEGV;
> --
> 2.1.0
>
