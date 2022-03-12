Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7795A4D719F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 00:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbiCLX6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 18:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiCLX6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 18:58:09 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBEC1C7C28;
        Sat, 12 Mar 2022 15:57:01 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id d10so26604556eje.10;
        Sat, 12 Mar 2022 15:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MHzA6f0O3UXfB/kOk5VVrrZ4oBWtPnkGe12GuOJG4uE=;
        b=PAxk8eNdgllxX72uRW+A9etKTYEJxmo2qZ2uYPJSlslts+7q5lOrDfAu0MBdqQb6qa
         +RG9Zq2msE8ROSwnk02pqIxjI3sm2VmMSo6csSgF4BwMK9LRJ8t9nVORGd8uOUFt+oF6
         tlPBa7gD3svCrLSPZWV9mBim/PNXNtn6tbCSBFcgJiTqeAEmjHVFvkpZkOYgEWtVdmKp
         prb9tzUvOuhhIDONOUd6BCOu1wMLmJ/tnbTTisFQD5k3qn3eLQafSgu/Mm+1FxbBWIvG
         JZRhM8mY/3+XZgh3SUNoRuwdrDIkvgdXAEYFFwTlAg7NbCeaOrJmznNXwf3dOxj4oIUr
         EJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MHzA6f0O3UXfB/kOk5VVrrZ4oBWtPnkGe12GuOJG4uE=;
        b=2UW/8f/LqZc+4EUidwOG9pq5nSZomafS3tcoHqBrjnVS+ZecwryDnrwc91k7hAFsP6
         S2825CZ0xDsYPX5ES6J8CFccJXsFOEtsColdZDUR4fIpdtNssNX92Lckp3Lp1z87Bh67
         P0t0VRt17t4BOx+6i8/kXTU/PmZchfaAiIQT9SOb4fli/elmypf/sdJJGo4kjbLFIxux
         zSEP1wkHyaQYV2P6WVtgF9SyBkQcyJ/Uz5f/vPJP2rrQnw1R4iP+g1y+fgW8acbXNWbG
         DT1skUeUFkBs+XM0T/HrtKtZtrhLzxI1h4W+YFF6qP+km4rL/60iKLanFR1qtoAxNu2+
         qYEA==
X-Gm-Message-State: AOAM5321PH3so5vqACTJnoSjW3FaG4l8aZMQAwnlM04XE0k3PLEwNxF2
        1gTYuaCCGI2InRkHyXA+z3GGX1g9bOjAHHLZHTQ=
X-Google-Smtp-Source: ABdhPJyI1fKtgO6GHvLdgShgKeBI6WTSEQ6zn+q6jGp2RKqZNWboD1mwvsRIrq7FU9VvPGQ3AQ0CvBLQl02z2zU0MEM=
X-Received: by 2002:a17:907:72d0:b0:6db:4788:66a9 with SMTP id
 du16-20020a17090772d000b006db478866a9mr14229254ejc.516.1647129420213; Sat, 12
 Mar 2022 15:57:00 -0800 (PST)
MIME-Version: 1.0
References: <20220312155603.1752193-1-guoren@kernel.org>
In-Reply-To: <20220312155603.1752193-1-guoren@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Sat, 12 Mar 2022 15:56:48 -0800
Message-ID: <CAMo8Bf+uiM=j+dc6GYNMPnXT9py=RACK3zZwiNv4LDbquTj+4w@mail.gmail.com>
Subject: Re: [RFC PATCH] arch: patch_text: Fixup last cpu should be master
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Chris Zankel <chris@zankel.net>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 7:56 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> These patch_text implementations are using stop_machine_cpuslocked
> infrastructure with atomic cpu_count. The origin idea is that when
> the master CPU patch_text, others should wait for it. But current
> implementation is using the first CPU as master, which couldn't
> guarantee continue CPUs are waiting. This patch changes the last
> CPU as the master to solve the potaintial risk.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Peter Zijlstra <peterz@infradead.org
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/kernel/patching.c      | 4 ++--
>  arch/csky/kernel/probes/kprobes.c | 2 +-
>  arch/riscv/kernel/patch.c         | 2 +-
>  arch/xtensa/kernel/jump_label.c   | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
> index 771f543464e0..6cfea9650e65 100644
> --- a/arch/arm64/kernel/patching.c
> +++ b/arch/arm64/kernel/patching.c
> @@ -117,8 +117,8 @@ static int __kprobes aarch64_insn_patch_text_cb(void *arg)
>         int i, ret = 0;
>         struct aarch64_insn_patch *pp = arg;
>
> -       /* The first CPU becomes master */
> -       if (atomic_inc_return(&pp->cpu_count) == 1) {
> +       /* The last CPU becomes master */
> +       if (atomic_inc_return(&pp->cpu_count) == (num_online_cpus() - 1)) {

atomic_inc_return returns the incremented value, so the last CPU gets
num_online_cpus(), not (num_online_cpus() - 1).

>                 for (i = 0; ret == 0 && i < pp->insn_cnt; i++)
>                         ret = aarch64_insn_patch_text_nosync(pp->text_addrs[i],
>                                                              pp->new_insns[i]);
> diff --git a/arch/csky/kernel/probes/kprobes.c b/arch/csky/kernel/probes/kprobes.c
> index 42920f25e73c..19821a06a991 100644
> --- a/arch/csky/kernel/probes/kprobes.c
> +++ b/arch/csky/kernel/probes/kprobes.c
> @@ -30,7 +30,7 @@ static int __kprobes patch_text_cb(void *priv)
>         struct csky_insn_patch *param = priv;
>         unsigned int addr = (unsigned int)param->addr;
>
> -       if (atomic_inc_return(&param->cpu_count) == 1) {
> +       if (atomic_inc_return(&param->cpu_count) == (num_online_cpus() - 1)) {

Ditto.

>                 *(u16 *) addr = cpu_to_le16(param->opcode);
>                 dcache_wb_range(addr, addr + 2);
>                 atomic_inc(&param->cpu_count);
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index 0b552873a577..cca72a9388e3 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -104,7 +104,7 @@ static int patch_text_cb(void *data)
>         struct patch_insn *patch = data;
>         int ret = 0;
>
> -       if (atomic_inc_return(&patch->cpu_count) == 1) {
> +       if (atomic_inc_return(&patch->cpu_count) == (num_online_cpus() - 1)) {

Ditto.

>                 ret =
>                     patch_text_nosync(patch->addr, &patch->insn,
>                                             GET_INSN_LENGTH(patch->insn));
> diff --git a/arch/xtensa/kernel/jump_label.c b/arch/xtensa/kernel/jump_label.c
> index 61cf6497a646..7e1d3f952eb3 100644
> --- a/arch/xtensa/kernel/jump_label.c
> +++ b/arch/xtensa/kernel/jump_label.c
> @@ -40,7 +40,7 @@ static int patch_text_stop_machine(void *data)
>  {
>         struct patch *patch = data;
>
> -       if (atomic_inc_return(&patch->cpu_count) == 1) {
> +       if (atomic_inc_return(&patch->cpu_count) == (num_online_cpus() - 1)) {

Ditto.

>                 local_patch_text(patch->addr, patch->data, patch->sz);
>                 atomic_inc(&patch->cpu_count);
>         } else {
> --
> 2.25.1
>


-- 
Thanks.
-- Max
