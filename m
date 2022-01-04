Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A8F483E72
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbiADItm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbiADItl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:49:41 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70E9C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 00:49:40 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id l68so4240751vkh.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 00:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U03uBIxPfThiblBP6Q6lubnyc+HItcY5qVTa/C4uzLI=;
        b=eQ4avva1R16F3yHgnpKQvE4j14VvfOcSQDb+hKSbkH6o9dsIgHPtqsvdS5l81wF08A
         eJwAyXoj4/nYwy+HEewSXlLcmPG2pHtaKJuRQpaNNk1KS6hIOWllXwHRS5viFr9glnWJ
         ZSAk3I9nlyNLU2rNQhIsbjL9ZzfMmCUZI2JN/eW3+ZAnM8gvXTvEwEcnfwFRjOlmmf0E
         7p/mJkkaf+yIUBhxo0sGDiE7ygpEyI5LyzUPSOlcjHOTCpJfeJIRTqca/mn26npSTECg
         7VZDBjhojVVAQ/bg9kJRAFdBkbGV7qPa9JSsOUFbtW4Q/dTfTvZdRJvk4d9HwRBTQcMh
         xFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U03uBIxPfThiblBP6Q6lubnyc+HItcY5qVTa/C4uzLI=;
        b=DLnMa4g/RUIK+rr1EPoCocebd9Vg+8D+OPcYn8t9NzxiGNjMjX3MKd9lr9QqDcBHJ2
         4yK15WtG8Ollnb6Nht9rwH4d70SnFgH5lf5TBhuhLR7V0pC2912HncxMPX8GdfqsIDbC
         s1/Ss39kGmFiys84nAO4cBeF200iN8p4NPUr/Y64g/LSlMQVMGQqistA1B5o7WyliEoP
         l+3NRBAApwaV8kyEy3zP0Ibg5VEwk7GphfwEya3or0u5L7OsUfbrEsZK4F8vDAUuHLgU
         F4xNzKepR5bzNWMfG3nF4jXFVIUWzswY890DY7H1wIHjz/cKf+qXg+rnn2b+w70V61tk
         Z3Dw==
X-Gm-Message-State: AOAM5329YvlcX4wVRZSD576Vw7zlXhZpWWeQZUtWReduVhvTnO3SeYgE
        gSQVd0g36avBGLmENsDxRbAgTVQ+kH7n0EFog8s=
X-Google-Smtp-Source: ABdhPJzJbRZpqzJ+OprjZKJ7D/YnnV/A3Xf3wA8XYGB6ouBps8ht6RCNCO+bAE46HG95kMVjHbp4mYWf0wmuW00YKHQ=
X-Received: by 2002:ac5:cb72:: with SMTP id l18mr16328117vkn.1.1641286179786;
 Tue, 04 Jan 2022 00:49:39 -0800 (PST)
MIME-Version: 1.0
References: <20211207124002.59877-1-liuqi115@huawei.com> <20211213183851.GD12405@willie-the-truck>
 <20211214092657.5b9c26b4e3852602eced4fda@kernel.org> <CAAgTQPUKqFn9_ENKbfJkFjT3v9L2NiFAY2xvULEj_6wguqWYNg@mail.gmail.com>
 <f4552c3e-8f1a-bef1-9396-39aa2405b486@huawei.com> <CAAgTQPWAK==cYPKeYNGE7nPGh0Y7Py4TcUoMPz76h15YNBNsLQ@mail.gmail.com>
 <CAAgTQPWomoiGdVJxwYBmXOj7RegHM4TSa2+yKVTQFhBFg8PtLg@mail.gmail.com> <20220104113559.7dd1ff2cb575f62e0b01fb47@kernel.org>
In-Reply-To: <20220104113559.7dd1ff2cb575f62e0b01fb47@kernel.org>
From:   Jianhua Liu <jianhua.ljh@gmail.com>
Date:   Tue, 4 Jan 2022 16:49:29 +0800
Message-ID: <CAAgTQPUL-DPTD2-sPQzYB+Eoko7aw40-bhyE_9Kjd90qowQBfw@mail.gmail.com>
Subject: Re: [PATCH v5] arm64: kprobe: Enable OPTPROBE for arm64
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "liuqi (BA)" <liuqi115@huawei.com>, Will Deacon <will@kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>, robin.murphy@arm.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 10:36 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi Jianhua,
>
> On Mon, 3 Jan 2022 17:03:33 +0800
> Jianhua Liu <jianhua.ljh@gmail.com> wrote:
>
> > Hi Qi,
> > I have tested your patch on UNISOC s9863a.
> > Test case "kprobe_example & kretprobe_example" is OK.
> >
> > Two point:
> > 1. backtrace is not perfect.
> >    optprobe_common does not saved frame pointer,
> >    backtrace lacks two calls.
> > such as for dup_mm: lack copy_process-->dup_mm
> > dup_mm backtrace from your patch:
> > [  832.387066] CPU: 0 PID: 296 Comm: sh Not tainted 5.16.0-rc5+ #8
> > [  832.387078] Hardware name: Spreadtrum SP9863A-1H10 Board (DT)
> > [  832.387083] Call trace:
> > [  832.387086]  dump_backtrace+0x0/0x1e0
> > [  832.387103]  show_stack+0x24/0x30
> > [  832.387112]  dump_stack_lvl+0x68/0x84
> > [  832.387123]  dump_stack+0x18/0x34
> > [  832.387131]  handler_pre+0x40/0x50 [kprobe_example]
> > [  832.387143]  opt_pre_handler+0x84/0xc0
> > [  832.387154]  optprobe_optimized_callback+0xec/0x164
> > [  832.387164]  optprobe_common+0x70/0xc4
> > [  832.387173]  kernel_clone+0x98/0x440
> > [  832.387182]  __do_sys_clone+0x54/0x80
> > [  832.387191]  __arm64_sys_clone+0x2c/0x40
> > [  832.387199]  invoke_syscall+0x50/0x120
> > [  832.387208]  el0_svc_common.constprop.0+0x4c/0xf4
> > [  832.387217]  do_el0_svc+0x30/0x9c
> > [  832.387225]  el0_svc+0x20/0x60
> > [  832.387235]  el0t_64_sync_handler+0xe8/0xf0
> > [  832.387242]  el0t_64_sync+0x1a0/0x1a4
> >
> >
> > dup_mm backtrace from other:
> > [  173.352294] CPU: 6 PID: 309 Comm: sh Not tainted 5.16.0-rc5+ #19
> > [  173.352301] Hardware name: Spreadtrum SP9863A-1H10 Board (DT)
> > [  173.352304] Call trace:
> > [  173.352307]  dump_backtrace+0x0/0x1d4
> > [  173.352319]  show_stack+0x18/0x24
> > [  173.352326]  dump_stack_lvl+0x68/0x84
> > [  173.352333]  dump_stack+0x18/0x34
> > [  173.352338]  handler_pre+0x38/0x48 [kprobe_example]
> > [  173.352347]  opt_pre_handler+0x74/0xb0
> > [  173.352354]  optimized_callback+0x108/0x130
> > [  173.352361]  optinsn_slot+0x258/0x1000
> > [  173.352366]  dup_mm+0x4/0x4b0
> > [  173.352373]  copy_process+0x1284/0x1360
> > [  173.352378]  kernel_clone+0x5c/0x3c0
> > [  173.352384]  __do_sys_clone+0x54/0x80
> > [  173.352390]  __arm64_sys_clone+0x24/0x30
> > [  173.352396]  invoke_syscall+0x48/0x114
> > [  173.352402]  el0_svc_common.constprop.0+0x44/0xec
> > [  173.352408]  do_el0_svc+0x24/0x90
> > [  173.352413]  el0_svc+0x20/0x60
> > [  173.352420]  el0t_64_sync_handler+0xe8/0xf0
> > [  173.352427]  el0t_64_sync+0x1a0/0x1a4
>
> Is the second one with your patch?
Yes, the second one is from my patch.

Thanks,
Jianhua

>
> >
> > 2. The reserve memory "OPT_SLOT_SIZE - PAGE_SIZE"  is waste.
> >    kernel/kprobe.c used only one PAGE_SIZE slot memory.
>
> Good catch!
> Qi, can you make an array (or bit map) of usage flags and
> manage the reserved memory?
>
> #define OPT_INSN_PAGES (OPT_SLOT_SIZE/PAGE_SIZE)
> static bool insn_page_in_use[OPT_INSN_PAGES];
>
> void *alloc_optinsn_page(void)
> {
>         int i;
>
>         for (i = 0; i < OPT_INSN_PAGES; i++)
>                 if (!insn_page_in_use[i])
>                         goto found;
>         return NULL;
> found:
>         insn_page_in_use[i] = true;
>         return (void *)((unsigned long)optinsn_slot + PAGE_SIZE * i);
> }
>
> void free_optinsn_page(void *page)
> {
>         unsigned long idx = (unsigned long)page - (unsigned long)optinsn_slot;
>
>         WARN_ONCE(idx & (PAGE_SIZE - 1));
>         idx >>= PAGE_SHIFT;
>         if (WARN_ONCE(idx >= OPT_INSN_PAGES))
>                 return;
>         insn_page_in_use[idx] = false;
> }
>
> Thank you,
>
>
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
