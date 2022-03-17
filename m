Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A294DCAB4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 17:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbiCQQEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 12:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236300AbiCQQEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 12:04:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C217DAB5;
        Thu, 17 Mar 2022 09:03:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C66BCB80122;
        Thu, 17 Mar 2022 16:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C3AC340F7;
        Thu, 17 Mar 2022 16:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647532998;
        bh=NGiQFPVnfDqZ1ROyWh9ETbUs7TxBnFHdgwPh/4n9jkA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rh3zXpgLbT6SxqOATKmV9Yg1s5i3qEYz1c57woGTPEB9HVQOvoNJg27Eh+Vpr5bnB
         9l5P2ZTbDZaUyjAkAuW69dtO6pyULM2UcfPOa/ltFPnPz77RHcuBH0PVA5FQJ12/RC
         Vk505u32UA7dKFDT0dy2VxMqKGqWACf/31xxW4OqezMnTHpxYCMn1KQiwkY/kCWZjl
         tez2KzHX0g5xYLn7LOcGj9kCZD3N5v3/Q8DWhareckpREHZplQyMPK0Lacqa+cRkYa
         +F+S5yDxaEib1+Rm48oukLIWleLtwPzHRjq6T+UmUWe4bisqNoOKNa4rHPwNTuLNGA
         61hyjnnLNxwhA==
Received: by mail-ua1-f49.google.com with SMTP id i26so2231972uap.6;
        Thu, 17 Mar 2022 09:03:18 -0700 (PDT)
X-Gm-Message-State: AOAM531bLQ9j5G+gp/Lo/PFiis0JHUWfBPW46CD/bKg5JwkV1cVcXPng
        SjWhnrtPMTOZbCm2i6hJ3lON1f5MEG/g1xzQyf8=
X-Google-Smtp-Source: ABdhPJx56mP1yBItNhpbrH5BO1aKkva0leBOvED1GBx+mkRa6thFGwJA/RpUKcskkXEWf9nO8JBbTl9WVNeKe2iBtLA=
X-Received: by 2002:ab0:3785:0:b0:350:c22e:9908 with SMTP id
 d5-20020ab03785000000b00350c22e9908mr1907268uav.114.1647532997252; Thu, 17
 Mar 2022 09:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220313012221.1755483-1-guoren@kernel.org> <YjH2e4bfTl+0/+yc@arm.com>
In-Reply-To: <YjH2e4bfTl+0/+yc@arm.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 18 Mar 2022 00:03:06 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQmix3hc5-EntHZ_cTpp6XeCmDfOD4vHCd8Y+svUjPgGA@mail.gmail.com>
Message-ID: <CAJF2gTQmix3hc5-EntHZ_cTpp6XeCmDfOD4vHCd8Y+svUjPgGA@mail.gmail.com>
Subject: Re: [PATCH V2] arch: patch_text: Fixup last cpu should be master
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Will Deacon <will@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Chris Zankel <chris@zankel.net>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 10:38 PM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Sun, Mar 13, 2022 at 09:22:21AM +0800, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > These patch_text implementations are using stop_machine_cpuslocked
> > infrastructure with atomic cpu_count. The original idea: When the
> > master CPU patch_text, the others should wait for it.
>
> I couldn't find the original intent in the commit logs (at least not in
> the arm64 logs). Maybe the intention was for the CPUs to wait for the
> text patching to complete rather than the master CPU to wait for the
> others to enter the cpu_relax() loop before patching.
>
> I think your patch makes sense anyway, the master CPU would wait for all
> the others to enter the cpu_relax() loop before patching and releasing
> them with another increment. You probably wouldn't see any issues in
> practice unless you insert probes in the multi_stop_cpu() function (or
> we could mark this function as __kprobes and get rid of the extra loops
> entirely).
That could depend on micro-arch, trigger other harts' IPI is not
guaranteed by hw.

>
> > --- a/arch/arm64/kernel/patching.c
> > +++ b/arch/arm64/kernel/patching.c
> > @@ -117,8 +117,8 @@ static int __kprobes aarch64_insn_patch_text_cb(void *arg)
> >       int i, ret = 0;
> >       struct aarch64_insn_patch *pp = arg;
> >
> > -     /* The first CPU becomes master */
> > -     if (atomic_inc_return(&pp->cpu_count) == 1) {
> > +     /* The last CPU becomes master */
> > +     if (atomic_inc_return(&pp->cpu_count) == num_online_cpus()) {
> >               for (i = 0; ret == 0 && i < pp->insn_cnt; i++)
> >                       ret = aarch64_insn_patch_text_nosync(pp->text_addrs[i],
> >                                                            pp->new_insns[i]);
>
> For arm64:
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Thx

>
> --
> Catalin



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
