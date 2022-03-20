Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE054E1E4F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 00:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343832AbiCTXus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 19:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbiCTXuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 19:50:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5101B51E71;
        Sun, 20 Mar 2022 16:49:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D41466125C;
        Sun, 20 Mar 2022 23:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A396C340F7;
        Sun, 20 Mar 2022 23:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647820161;
        bh=LdVIHoHItcWladjunHHE0TqmokWx34dd4pkenmbLtic=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cGZp03PLkkg7WjyUJH075nQZRGuldahnVs/gF8U1zra6NQ1upmIkD0CeLx54VWJO5
         E5iniwFtkXnkPI6pbQd5kcW/3oBSVkKeHQjCdHm42WqPloHOHMk4+d9J94VyVyMc4L
         va8xny3AZNWvP4ankJO04Ba6mx/3K7dKqVJLkkpxLHVCfm+FzvTGMBCWJs0hiiGlhu
         985selWu5XMI3lruSNxroriY9octOOZWCP5ZlqeLJq6icpoCZ41wHvptN9tRlUvlF2
         43KiXulyMx28u0AniBrVYk81FnZg6gDbu239OlxtbVb7OH4FkGvJ8dTNBlLnBfepO3
         oAyZv9majtYmg==
Received: by mail-vs1-f42.google.com with SMTP id i186so9656358vsc.9;
        Sun, 20 Mar 2022 16:49:21 -0700 (PDT)
X-Gm-Message-State: AOAM5329DNLFG/BWfb68DWVxtp+ik5Rwg0xrzWQCjHFV0cxomR4ysaLo
        tSPHVCsoS436lFHMUwFA8CjTqS2zYtnQ/JUjXlA=
X-Google-Smtp-Source: ABdhPJwzZ7sQ8nqc3/evn0mCeSVPLU9IvQI1EMLbzj7obkq7PpVtp3nW3lxsuUT4URfmvdsv+ieEuyG9qH76lKdBsy0=
X-Received: by 2002:a05:6102:38c6:b0:31b:b386:e467 with SMTP id
 k6-20020a05610238c600b0031bb386e467mr6809705vst.8.1647820160139; Sun, 20 Mar
 2022 16:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220313012221.1755483-1-guoren@kernel.org> <mhng-b034f45a-521b-4c80-a314-4ddf1a1dc534@palmer-mbp2014>
In-Reply-To: <mhng-b034f45a-521b-4c80-a314-4ddf1a1dc534@palmer-mbp2014>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 21 Mar 2022 07:49:09 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR6Pd3nVKt9e=rdMynBV0-EOmy5ZbndduEJiQLLe6vdpA@mail.gmail.com>
Message-ID: <CAJF2gTR6Pd3nVKt9e=rdMynBV0-EOmy5ZbndduEJiQLLe6vdpA@mail.gmail.com>
Subject: Re: [PATCH V2] arch: patch_text: Fixup last cpu should be master
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Chris Zankel <chris@zankel.net>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 2:05 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Sat, 12 Mar 2022 17:22:21 PST (-0800), guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > These patch_text implementations are using stop_machine_cpuslocked
> > infrastructure with atomic cpu_count. The original idea: When the
> > master CPU patch_text, the others should wait for it. But current
> > implementation is using the first CPU as master, which couldn't
> > guarantee the remaining CPUs are waiting. This patch changes the
> > last CPU as the master to solve the potential risk.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Peter Zijlstra <peterz@infradead.org
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Chris Zankel <chris@zankel.net>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> >
> > ---
> > Changes in V2:
> >  - Fixup last cpu should be num_online_cpus() by Max Filippov
> >  - Fixup typos found by Max Filippov
> > ---
> >  arch/arm64/kernel/patching.c      | 4 ++--
> >  arch/csky/kernel/probes/kprobes.c | 2 +-
> >  arch/riscv/kernel/patch.c         | 2 +-
> >  arch/xtensa/kernel/jump_label.c   | 2 +-
> >  4 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
> > index 771f543464e0..33e0fabc0b79 100644
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
> > diff --git a/arch/csky/kernel/probes/kprobes.c b/arch/csky/kernel/probes/kprobes.c
> > index 42920f25e73c..34ba684d5962 100644
> > --- a/arch/csky/kernel/probes/kprobes.c
> > +++ b/arch/csky/kernel/probes/kprobes.c
> > @@ -30,7 +30,7 @@ static int __kprobes patch_text_cb(void *priv)
> >       struct csky_insn_patch *param = priv;
> >       unsigned int addr = (unsigned int)param->addr;
> >
> > -     if (atomic_inc_return(&param->cpu_count) == 1) {
> > +     if (atomic_inc_return(&param->cpu_count) == num_online_cpus()) {
> >               *(u16 *) addr = cpu_to_le16(param->opcode);
> >               dcache_wb_range(addr, addr + 2);
> >               atomic_inc(&param->cpu_count);
> > diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> > index 0b552873a577..765004b60513 100644
> > --- a/arch/riscv/kernel/patch.c
> > +++ b/arch/riscv/kernel/patch.c
> > @@ -104,7 +104,7 @@ static int patch_text_cb(void *data)
> >       struct patch_insn *patch = data;
> >       int ret = 0;
> >
> > -     if (atomic_inc_return(&patch->cpu_count) == 1) {
> > +     if (atomic_inc_return(&patch->cpu_count) == num_online_cpus()) {
> >               ret =
> >                   patch_text_nosync(patch->addr, &patch->insn,
> >                                           GET_INSN_LENGTH(patch->insn));
>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com> # RISC-V
>
> It's better if these sorts of things get split up: there's really no
> dependency between these diffs and having them together just makes for a
> merge/test headache for everyone.
I'm Okay with split patches, @Arnd Bergmann what's your opinion?
We've got all arch vendors' agreements (arm64, csky, riscv, xtensa).

>
> I'm OK taking this through the RISC-V tree if other folks ack it, but
> for now I'm going to assume it's going to go in via somewhere else.
Arnd has given some comments on unnecessary #error, maybe I need to update V2.

>
> > diff --git a/arch/xtensa/kernel/jump_label.c b/arch/xtensa/kernel/jump_label.c
> > index 61cf6497a646..b67efcd7e32c 100644
> > --- a/arch/xtensa/kernel/jump_label.c
> > +++ b/arch/xtensa/kernel/jump_label.c
> > @@ -40,7 +40,7 @@ static int patch_text_stop_machine(void *data)
> >  {
> >       struct patch *patch = data;
> >
> > -     if (atomic_inc_return(&patch->cpu_count) == 1) {
> > +     if (atomic_inc_return(&patch->cpu_count) == num_online_cpus()) {
> >               local_patch_text(patch->addr, patch->data, patch->sz);
> >               atomic_inc(&patch->cpu_count);
> >       } else {



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
