Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9C35759ED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 05:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241057AbiGODUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 23:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiGODUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 23:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4767FA447
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 20:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC5AA621EE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 03:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CB6C341C6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 03:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657855221;
        bh=r9nH0nnXki3fn2qUEx//h7cuqEVQBiYMXEgpzqbyJ5g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oKw6mCZOD1HPIbLdEpgbQaev8ZMcZVxjKSGNSOdQchcnAh9IwRz8aZ2io+E+MTbbs
         XcmIqOkLdbMkSErlBQNXmCN4tH1N8M/5uhNwn5IT0Kmiky4/q9Qmhqt5V75U7eniEm
         od+2dX50pYreYY7GoKdd23jyYFRPrlFJH0r5Lh71vaftCd8mhUuqbtRkv5VnYyG+nx
         1Jr5VxxHNSn4Qt9Gsn9P+a75y1IMp6sMMBkO2CFQtG+DOX3Gif1PGBMreTHt/PN/zc
         rT5vLW7VBRTgIxnF15DbEyWLedboADMcTJUBusvin3BHOr002YDnkexTbxCWudGtpY
         Ki5496NqPPDSg==
Received: by mail-vk1-f172.google.com with SMTP id 7so1648665vkq.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 20:20:21 -0700 (PDT)
X-Gm-Message-State: AJIora/YUVnTCcMhY84W75imyY0DZwDhPy4kwQz391zJzs8mhzFNvntf
        NNnPne1KteO5Xtze4GaCA0vmtXPMqTcRy2cqSYg=
X-Google-Smtp-Source: AGRyM1sN/ekI6UBawgnS3GWAQCMGXmmQNl+i2V8eRmbTHANUBobaCVtXNRsxJogDqP7TV8roV7OyjVCMMeIJdfGqkbs=
X-Received: by 2002:a1f:340f:0:b0:374:7b8a:378 with SMTP id
 b15-20020a1f340f000000b003747b8a0378mr4918379vka.37.1657855220231; Thu, 14
 Jul 2022 20:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220714062550.4934-1-huqi@loongson.cn> <CAAhV-H6NWYG1ChLRyK-EAGAmhDvP-x+z9BgBo3a=GAbQ-2bKig@mail.gmail.com>
 <6896bb4c-5224-678f-e73c-fe95be41d196@loongson.cn>
In-Reply-To: <6896bb4c-5224-678f-e73c-fe95be41d196@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 15 Jul 2022 11:20:07 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6eBuGS5F2=DQEMnV1JWOi8rn8g=SR++FxAWa5V6WABgQ@mail.gmail.com>
Message-ID: <CAAhV-H6eBuGS5F2=DQEMnV1JWOi8rn8g=SR++FxAWa5V6WABgQ@mail.gmail.com>
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

On Thu, Jul 14, 2022 at 10:07 PM Qi Hu <huqi@loongson.cn> wrote:
>
>
> On 2022/7/14 21:12, Huacai Chen wrote:
> > Hi,
> >
> > On Thu, Jul 14, 2022 at 2:26 PM Qi Hu <huqi@loongson.cn> wrote:
> >> In file ptrace.c, function fpr_set does not copy fcsr data from ubuf
> >> to kbuf. That's the reason why fcsr cannot be modified by ptrace.
> >>
> >> This patch fixs this problem and allows users using ptrace to modify
> >> the fcsr.
> >>
> >> Signed-off-by: Qi Hu <huqi@loongson.cn>
> >> Signed-off-by: Xu Li <lixu@loongson.cn>
> >> ---
> >>   arch/loongarch/kernel/ptrace.c | 12 +++++++-----
> >>   1 file changed, 7 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/arch/loongarch/kernel/ptrace.c b/arch/loongarch/kernel/ptrace.c
> >> index e6ab87948e1d..dc2b82ea894c 100644
> >> --- a/arch/loongarch/kernel/ptrace.c
> >> +++ b/arch/loongarch/kernel/ptrace.c
> >> @@ -193,7 +193,7 @@ static int fpr_set(struct task_struct *target,
> >>                     const void *kbuf, const void __user *ubuf)
> >>   {
> >>          const int fcc_start = NUM_FPU_REGS * sizeof(elf_fpreg_t);
> >> -       const int fcc_end = fcc_start + sizeof(u64);
> >> +       const int fcsr_start = fcc_start + sizeof(u64);
> >>          int err;
> >>
> >>          BUG_ON(count % sizeof(elf_fpreg_t));
> >> @@ -209,10 +209,12 @@ static int fpr_set(struct task_struct *target,
> >>          if (err)
> >>                  return err;
> >>
> >> -       if (count > 0)
> >> -               err |= user_regset_copyin(&pos, &count, &kbuf, &ubuf,
> >> -                                         &target->thread.fpu.fcc,
> >> -                                         fcc_start, fcc_end);
> >> +       err |= user_regset_copyin(&pos, &count, &kbuf, &ubuf,
> >> +                                 &target->thread.fpu.fcc, fcc_start,
> >> +                                 fcc_start + sizeof(u64));
> >> +       err |= user_regset_copyin(&pos, &count, &kbuf, &ubuf,
> >> +                                 &target->thread.fpu.fcsr, fcsr_start,
> >> +                                 fcsr_start + sizeof(u32));
> > You shouldn't remove (count > 0) here, because  the above
> > user_regset_copyin() will modify count inside, and so "count == 0" is
> > possible.
> >
> > Huacai
>
> Yes, the "count" should be considered. But the "count" is checked at the
> beginning of the "user_regset_copyin()".
>
> So "count > 0" is useless, i think.
Yes, you are right, thanks.

Huacai
>
> Also like riscv, "count" is not checked in "riscv_fpr_set()".
>
> >>          return err;
> >>   }
> >> --
> >> 2.37.0
> >>
>
