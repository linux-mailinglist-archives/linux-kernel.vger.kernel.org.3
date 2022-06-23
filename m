Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD83C557801
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiFWKhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiFWKhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:37:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4844A3EB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:37:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFB6061E91
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 10:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C677C3411B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 10:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655980655;
        bh=0Y9nKoXLQwSEF6T0zqCPzYrsrLdHVeldqGjdfHLwb+E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KapQCZyVfIKkXgz3eSWxZVJQ5Hl7eggZo0Z4x8tyREwY8gAiB1RPXACIy/Msuuc95
         ltzViPKtvFWkXWLWCUEbZTuqRdI/byxUHh+aEDQY8ZE9T8ZBnBoju+f4ihd757Q+Sj
         gC+BbsNxelmc536gav1Ti+kgfB/RXUt8lDQ/MyiRk8ec/B/O00WKnnoStBBVnGojNf
         DWDdpYLjz0p/x2ay9a0aEknBcowW5s/+0tIsEubsNMhLdrrHIQKcgUTOFEIa+hWydl
         2r/TfhoYg4RI/nNg1OH0YlhWVO4UUgnA6PfHZKNQefV8ULLJMzkm6cB9xwJeHXQ4Nt
         qjsjYd9XavyKw==
Received: by mail-wr1-f43.google.com with SMTP id o8so27339279wro.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:37:35 -0700 (PDT)
X-Gm-Message-State: AJIora+41m+MBJFeiRmanm00MqP2xW/QW+YxdEDl+aV62+DGri0S4kgC
        Oej/xPzbUepG4uXxFYTpy/7ijaJ3gZ3VihH4RQc=
X-Google-Smtp-Source: AGRyM1sIu57xuQcFNqy/UpFIU0HcLcSI6SlGGumRH5EjM9SNLOP0lNiix5WMcC0upZxdaoZJZ2m4Gdanu8l1n42Xo6U=
X-Received: by 2002:a05:6000:1191:b0:21b:a32e:983b with SMTP id
 g17-20020a056000119100b0021ba32e983bmr5450849wrx.348.1655980653379; Thu, 23
 Jun 2022 03:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <1655541551-3997-1-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H5oaCnRyi0xpzzoUs-VemuQtSEStHHzerZFoAQmEabCdw@mail.gmail.com> <c9123763-a72e-ce2a-83e3-b3e46cec15b3@loongson.cn>
In-Reply-To: <c9123763-a72e-ce2a-83e3-b3e46cec15b3@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 23 Jun 2022 18:37:19 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Lv73KnU-+3FeTiHxApwZ8u2dAZbYWDUkkJ_mUOsk3fA@mail.gmail.com>
Message-ID: <CAAhV-H4Lv73KnU-+3FeTiHxApwZ8u2dAZbYWDUkkJ_mUOsk3fA@mail.gmail.com>
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

On Thu, Jun 23, 2022 at 5:36 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
>
>
> On 06/23/2022 05:26 PM, Huacai Chen wrote:
> > Hi, Tiezhu,
> >
> > On Sat, Jun 18, 2022 at 4:39 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >>
> >> compute_return_era() always returns 0, make it return void,
> >> and then no need to check its return value for its callers.
> >>
> >> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> >> ---
> >>  arch/loongarch/include/asm/branch.h | 3 +--
> >>  arch/loongarch/kernel/traps.c       | 3 +--
> >>  2 files changed, 2 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/loongarch/include/asm/branch.h b/arch/loongarch/include/asm/branch.h
> >> index 3f33c89..9a133e4 100644
> >> --- a/arch/loongarch/include/asm/branch.h
> >> +++ b/arch/loongarch/include/asm/branch.h
> >> @@ -12,10 +12,9 @@ static inline unsigned long exception_era(struct pt_regs *regs)
> >>         return regs->csr_era;
> >>  }
> >>
> >> -static inline int compute_return_era(struct pt_regs *regs)
> >> +static inline void compute_return_era(struct pt_regs *regs)
> >>  {
> >>         regs->csr_era += 4;
> >> -       return 0;
> >>  }
> >>
> >>  #endif /* _ASM_BRANCH_H */
> >> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
> >> index e4060f8..1bf58c6 100644
> >> --- a/arch/loongarch/kernel/traps.c
> >> +++ b/arch/loongarch/kernel/traps.c
> >> @@ -475,8 +475,7 @@ asmlinkage void noinstr do_ri(struct pt_regs *regs)
> >>
> >>         die_if_kernel("Reserved instruction in kernel code", regs);
> >>
> >> -       if (unlikely(compute_return_era(regs) < 0))
> >> -               goto out;
> >> +       compute_return_era(regs);
> > Maybe it is better to simply remove the compute_return_era() function?
>
> Good idea, if so, I think we can also remove exception_era(), and then
> arch/loongarch/include/asm/branch.h can be removed.
>
> If you are OK, I will send a v2 patch to remove
> arch/loongarch/include/asm/branch.h
After some consideration, I think just taking this version is OK,
because maybe there will be more callers in future. Thanks.

Huacai
>
> Thanks,
> Tiezhu
>
> >
> > Huacai
> >>
> >>         if (unlikely(get_user(opcode, era) < 0)) {
> >>                 status = SIGSEGV;
> >> --
> >> 2.1.0
> >>
>
