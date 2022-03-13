Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5740D4D7205
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 02:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbiCMBFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 20:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiCMBFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 20:05:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B92A4132C;
        Sat, 12 Mar 2022 17:04:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23E7F60DBA;
        Sun, 13 Mar 2022 01:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F61C340F6;
        Sun, 13 Mar 2022 01:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647133478;
        bh=tmh3mcghRvIKmmkKy22it572bdUg52D3C1cFrncPwe8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fN2YrbP8OwsgbWeT3pk5tAT0Qma4PiRp7v+JWFbn+C0FjyxGnTfkLXKCIDBJHndKB
         RzNoW2czGcU6KU+V7K16QlXoY6XokwLhGuzhSHcmWSRiAqjk4p4+Q/kyJcrC0mbx2+
         TETWvgksmnmANrdFs/rK1TDMuoPBnIh8MKXoVFQRhO2Jqgt1IZoL7HUKXAn/GlF082
         TvIMtWk8XhVetI9V44dQPxxURMZFeMEfJ14Qol4tdX7X/pO/a0y5QvjVSz1mcDwy/p
         bG9iH7odtEeeF35ry7jGkWwcYiBuQWSMEbKoUwxDgu3BC/nOBNvcaahBXeHvy72cni
         OeGQpDCZcaz7g==
Received: by mail-vs1-f49.google.com with SMTP id u124so13406927vsb.10;
        Sat, 12 Mar 2022 17:04:38 -0800 (PST)
X-Gm-Message-State: AOAM531nRbJWkkg9IPt+Y37WfmeyOYmvPUxSrg+LF9FoYyBoUJpknb9r
        pz8VvFFxoYXYQQs3fMx9bgDTLxN7nfB7KpyQzd8=
X-Google-Smtp-Source: ABdhPJxtkpJ2doQ7OHcfl8ievbN2j3XlIIXj/uVH35EPFsAjM+j2GwNMiH2cCrZxpi2YvnoZ2/hM1nn9R9WN6VmWZCg=
X-Received: by 2002:a05:6102:3a10:b0:322:3bf6:a54d with SMTP id
 b16-20020a0561023a1000b003223bf6a54dmr6999633vsu.51.1647133477285; Sat, 12
 Mar 2022 17:04:37 -0800 (PST)
MIME-Version: 1.0
References: <20220312155603.1752193-1-guoren@kernel.org> <CAMo8Bf+uiM=j+dc6GYNMPnXT9py=RACK3zZwiNv4LDbquTj+4w@mail.gmail.com>
In-Reply-To: <CAMo8Bf+uiM=j+dc6GYNMPnXT9py=RACK3zZwiNv4LDbquTj+4w@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 13 Mar 2022 09:04:26 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT44yEp5VySOGd-1+MAy3=xLw3-8hCPQ74w_zHJ1fJ3ww@mail.gmail.com>
Message-ID: <CAJF2gTT44yEp5VySOGd-1+MAy3=xLw3-8hCPQ74w_zHJ1fJ3ww@mail.gmail.com>
Subject: Re: [RFC PATCH] arch: patch_text: Fixup last cpu should be master
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Chris Zankel <chris@zankel.net>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 13, 2022 at 7:57 AM Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> On Sat, Mar 12, 2022 at 7:56 AM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > These patch_text implementations are using stop_machine_cpuslocked
> > infrastructure with atomic cpu_count. The origin idea is that when
> > the master CPU patch_text, others should wait for it. But current
> > implementation is using the first CPU as master, which couldn't
> > guarantee continue CPUs are waiting. This patch changes the last
> > CPU as the master to solve the potaintial risk.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Peter Zijlstra <peterz@infradead.org
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Chris Zankel <chris@zankel.net>
> > Cc: Max Filippov <jcmvbkbc@gmail.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/arm64/kernel/patching.c      | 4 ++--
> >  arch/csky/kernel/probes/kprobes.c | 2 +-
> >  arch/riscv/kernel/patch.c         | 2 +-
> >  arch/xtensa/kernel/jump_label.c   | 2 +-
> >  4 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
> > index 771f543464e0..6cfea9650e65 100644
> > --- a/arch/arm64/kernel/patching.c
> > +++ b/arch/arm64/kernel/patching.c
> > @@ -117,8 +117,8 @@ static int __kprobes aarch64_insn_patch_text_cb(void *arg)
> >         int i, ret = 0;
> >         struct aarch64_insn_patch *pp = arg;
> >
> > -       /* The first CPU becomes master */
> > -       if (atomic_inc_return(&pp->cpu_count) == 1) {
> > +       /* The last CPU becomes master */
> > +       if (atomic_inc_return(&pp->cpu_count) == (num_online_cpus() - 1)) {
>
> atomic_inc_return returns the incremented value, so the last CPU gets
> num_online_cpus(), not (num_online_cpus() - 1).
Oops! You are right, thx.

>
> >                 for (i = 0; ret == 0 && i < pp->insn_cnt; i++)
> >                         ret = aarch64_insn_patch_text_nosync(pp->text_addrs[i],
> >                                                              pp->new_insns[i]);
> > diff --git a/arch/csky/kernel/probes/kprobes.c b/arch/csky/kernel/probes/kprobes.c
> > index 42920f25e73c..19821a06a991 100644
> > --- a/arch/csky/kernel/probes/kprobes.c
> > +++ b/arch/csky/kernel/probes/kprobes.c
> > @@ -30,7 +30,7 @@ static int __kprobes patch_text_cb(void *priv)
> >         struct csky_insn_patch *param = priv;
> >         unsigned int addr = (unsigned int)param->addr;
> >
> > -       if (atomic_inc_return(&param->cpu_count) == 1) {
> > +       if (atomic_inc_return(&param->cpu_count) == (num_online_cpus() - 1)) {
>
> Ditto.
>
> >                 *(u16 *) addr = cpu_to_le16(param->opcode);
> >                 dcache_wb_range(addr, addr + 2);
> >                 atomic_inc(&param->cpu_count);
> > diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> > index 0b552873a577..cca72a9388e3 100644
> > --- a/arch/riscv/kernel/patch.c
> > +++ b/arch/riscv/kernel/patch.c
> > @@ -104,7 +104,7 @@ static int patch_text_cb(void *data)
> >         struct patch_insn *patch = data;
> >         int ret = 0;
> >
> > -       if (atomic_inc_return(&patch->cpu_count) == 1) {
> > +       if (atomic_inc_return(&patch->cpu_count) == (num_online_cpus() - 1)) {
>
> Ditto.
>
> >                 ret =
> >                     patch_text_nosync(patch->addr, &patch->insn,
> >                                             GET_INSN_LENGTH(patch->insn));
> > diff --git a/arch/xtensa/kernel/jump_label.c b/arch/xtensa/kernel/jump_label.c
> > index 61cf6497a646..7e1d3f952eb3 100644
> > --- a/arch/xtensa/kernel/jump_label.c
> > +++ b/arch/xtensa/kernel/jump_label.c
> > @@ -40,7 +40,7 @@ static int patch_text_stop_machine(void *data)
> >  {
> >         struct patch *patch = data;
> >
> > -       if (atomic_inc_return(&patch->cpu_count) == 1) {
> > +       if (atomic_inc_return(&patch->cpu_count) == (num_online_cpus() - 1)) {
>
> Ditto.
>
> >                 local_patch_text(patch->addr, patch->data, patch->sz);
> >                 atomic_inc(&patch->cpu_count);
> >         } else {
> > --
> > 2.25.1
> >
>
>
> --
> Thanks.
> -- Max



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
