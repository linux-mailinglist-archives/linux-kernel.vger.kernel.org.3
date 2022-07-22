Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1899F57DF86
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbiGVKQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiGVKQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:16:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433E57B1C5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 03:16:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC46262202
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393D2C341CF
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658485001;
        bh=a02VdCexlm3OkbCmnMFw3KVR6d8nsjBAf/XhBNM2oJQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VMGEihN3MtFqrzxsI81VxfGH8FAkYwEGvmt2LRJ6eUmh3auBMwHxWr40+rTwkwWoC
         SYuUxe0LMLTe9HoNLzNuWlCIt31+OsPt8Y/41ukprmZJUmnWLGjRP8ipn4BLuEXixU
         jMj7ARMElsVTP2+cRS6kRYvRBWuuxoopCL11CAOtmsPPmmDPAr6BmWNK7Ldj2qg4xL
         2ep5JmJVeVxtfmqndMLe4Ybtu29zBHyxqsIQtpiDy3W8VMEzMw8lYR9eHWoAhX1csP
         p0/u+5akoADcZlHyLJGJ2CFqJfTZMfuaKzUqHB+MRRLY9tv+FvUNMlN9txSMLhqDE9
         DVuQZOmBch7kg==
Received: by mail-ua1-f50.google.com with SMTP id p8so1541003uam.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 03:16:41 -0700 (PDT)
X-Gm-Message-State: AJIora/7mwj+qOuBHlVZ68CJy2An3l4wyqgDqt4rKXeKeVJU3HlhjOO8
        P2UaZE3wST3DQM6mGxW/iVcawP0A0+HM/YnF0PQ=
X-Google-Smtp-Source: AGRyM1vHgzwnraaVoS54NE7DNV/0hu8Gr9V7fiYMsj2FVf5ri4PwsqN/WiZJbScRfQzqFivu31ML+ZdbdY8OP/ocjag=
X-Received: by 2002:ab0:1393:0:b0:383:26e8:7bf3 with SMTP id
 m19-20020ab01393000000b0038326e87bf3mr864594uae.22.1658484999686; Fri, 22 Jul
 2022 03:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <1658314292-35346-1-git-send-email-lvjianmin@loongson.cn>
 <874jzcyrjl.wl-maz@kernel.org> <CAAhV-H4LXGE1mPQDf1wbuaCuB1G02RG1JA-B78+pNTPwwwKPWw@mail.gmail.com>
 <87r12dy3hq.wl-maz@kernel.org>
In-Reply-To: <87r12dy3hq.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 22 Jul 2022 18:16:26 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6rSS2NfxZy69CVPyAz9WhJTb_J4rSKwEYkQ+Ln2PHd=Q@mail.gmail.com>
Message-ID: <CAAhV-H6rSS2NfxZy69CVPyAz9WhJTb_J4rSKwEYkQ+Ln2PHd=Q@mail.gmail.com>
Subject: Re: [PATCH V18 00/13] irqchip: Add LoongArch-related irqchip drivers
To:     Marc Zyngier <maz@kernel.org>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, loongarch@lists.linux.dev,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marc,

On Fri, Jul 22, 2022 at 4:07 PM Marc Zyngier <maz@kernel.org> wrote:
>
> Hi Huacai,
>
> On Fri, 22 Jul 2022 03:25:23 +0100,
> Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > Hi, Marc,
> >
> > On Wed, Jul 20, 2022 at 7:03 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Wed, 20 Jul 2022 11:51:19 +0100,
> > > Jianmin Lv <lvjianmin@loongson.cn> wrote:
> > > >
> > > > LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
> > > > LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
> > > > version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as its
> > > > boot protocol LoongArch-specific interrupt controllers (similar to APIC)
> > > > are already added in the ACPI Specification 6.5(which may be published in
> > > > early June this year and the board is reviewing the draft).
> > > >
> > > > Currently, LoongArch based processors (e.g. Loongson-3A5000) can only
> > > > work together with LS7A chipsets. The irq chips in LoongArch computers
> > > > include CPUINTC (CPU Core Interrupt Controller), LIOINTC (Legacy I/O
> > > > Interrupt Controller), EIOINTC (Extended I/O Interrupt Controller), PCH-PIC
> > > > (Main Interrupt Controller in LS7A chipset), PCH-LPC (LPC Interrupt Controller
> > > > in LS7A chipset) and PCH-MSI (MSI Interrupt Controller).
> > >
> > > [...]
> > >
> > > OK, that's 4 versions in quick succession, so I suggest we stop the
> > > bikeshedding and focus on getting this actually merged.
> > >
> > > I'm going to stick this in a branch and throw it at -next. Any change
> > > will need to go on top of it, no rebasing. If anything that breaks
> > > cannot be fixed easily, I will drop the branch.
> > Thank you very much for this series finally get merged.
> > But there is a question that has puzzled me for a long time so I want
> > to consult with you: Why exporting fwnode_handle in the driver is
> > acceptable but exporting irqdomain is not? In my opinion, exporting
> > irqdomain is more simple and direct because it can avoid
> > irq_find_matching_fwnode() in the consumer side.
>
> The idea is that creating a mapping is normally driven by the code
> that parses firmware tables, be it DT or ACPI. That code normally only
> has access to something that eventually derives into a fwnode.
> irqdomains should only be a concern for the IRQ stack itself, and not
> the firmware interface.
>
> Now, your architecture breaks some of the fundamentals of what we have
> tried to do over the past 10 years, which is to separate the FW
> interface from the IRQ code, because you can't describe the topology
> in the firmware tables and are stuck with some in-code flow.
>
> We have two choices:
>
> - Either we let you break the above separation and start exposing
>   irqdomains everywhere outside of the IRQ stack,
>
> - Or we turn your arch code into its own firmware interface, and make
>   it drive the IRQ code as DT/ACPI would normally do.
>
> I have decided to go for the latter, because I don't think the
> LoongArch model is a good one. I'm convinced that eventually you will
> have to redesign a FW interface that allows full topology discovery
> (probably similar to IORT, should you stick with the ACPI model), and
> that the current code will become a historical artefact.
>
> And I really don't want this legacy in the core code.
OK, I know, thank you very much.

Huacai
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
