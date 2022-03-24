Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C8C4E5E20
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 06:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346954AbiCXF2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 01:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiCXF2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 01:28:09 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45662939BA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 22:26:36 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m30so5023567wrb.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 22:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UPHKSpU1uD0rrViGw+MJCaYsmsBqORLnJdi+EK4GXp4=;
        b=4erF0JJbyt2usIgCKQ+imVSaTwbCFuBUBSGC3nf3baGYXKVVnqcBre/vafj4XWaU/G
         XnT5YQsjvDnYmtg0ZOjzSlQV/ibKnYYjeu5Rah+WHNBj8QOT6ejLJ9ldrp3YsgU52hOl
         vT2/5QBVuiYhOK05YbvSgODYIO/mPAOvWwNVinxg11KAJSqJ+xfrKlFCjLT7hEfG7f3E
         9diC7FDnPlwJW8PMl9tHm5RX41GmhV8r0OFzLlNnksrcoz5tL/3kwlbuMWgCmmdGACWA
         rmL98RDvkILYLzFhUFiZz6QdnTddy/EM1BluEwHFcFeODsfvxsFhXQyKj5VeFbm29xz/
         NZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UPHKSpU1uD0rrViGw+MJCaYsmsBqORLnJdi+EK4GXp4=;
        b=SFlsqsVvyYjEdRTKT2LZa9sKJUsm+wIAxXETIQvPFzNjHYtNhBDYEE/Y3/5fdB0SLw
         EGC2UGyBOPXQoE4oyekBz6mhNdGEhARuqSWAh8a9HIVtfaBOp1RzRscqV+nrs+cCMpdZ
         j4Uvq6eICvewba97IRbz3YAC8sqzY+XeE2HfA9chILsTRfElBcJCDbMS4gkgez6op2gv
         HrNdvLRoi7BGXkrcb3eWOe3oyhQSzAWj7UfF+OcX7RpMxFPG3q7MFkGVdgzYaDX1JU2Z
         qXDtNMdzXOAuKE3+6sJ3LsRbn6S9Ml3kYz5+Ytk3xM/rgL40p6DZlPj3CgPqjtedKCnr
         BbzQ==
X-Gm-Message-State: AOAM533ZlepfI62i+a2VuEPbHshs8yeQx/5uL6J/TSQjxFAz0y+uqF6M
        QDEwtgIk6VfiSLmCR+7261tGKQWL/YhiqT3ZHKwtag==
X-Google-Smtp-Source: ABdhPJz3Mtc/BV9i1Kk0ZAafNaEBUtgYnsIvkd3WulJaS+i+A9mMD6+aniomgb2QMiOyr0HCbldKqPciea7+9bXnEtA=
X-Received: by 2002:a5d:6ac9:0:b0:203:de0b:295f with SMTP id
 u9-20020a5d6ac9000000b00203de0b295fmr3003827wrw.86.1648099594672; Wed, 23 Mar
 2022 22:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220323090025.546808-1-apatel@ventanamicro.com> <CAOnJCUJnc3VJq3PRn+wTMTbf2N5VdJs_uPjRyWTs-EKuC_190w@mail.gmail.com>
In-Reply-To: <CAOnJCUJnc3VJq3PRn+wTMTbf2N5VdJs_uPjRyWTs-EKuC_190w@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 24 Mar 2022 10:56:21 +0530
Message-ID: <CAAhSdy0_9kL-TLCiB-tJ0bzRCmbaahyUKj09Jone6CipZvZ9Pg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Enable perf events by default
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 10:04 PM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Wed, Mar 23, 2022 at 2:00 AM Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > Let us enable perf events by default in RV32 and RV64 defconfigs
> > so that we can use RISC-V PMU drivers on various RISC-V platforms.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  arch/riscv/configs/defconfig      | 1 +
> >  arch/riscv/configs/rv32_defconfig | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> > index f120fcc43d0a..57aaedc7cf74 100644
> > --- a/arch/riscv/configs/defconfig
> > +++ b/arch/riscv/configs/defconfig
> > @@ -15,6 +15,7 @@ CONFIG_CHECKPOINT_RESTORE=y
> >  CONFIG_BLK_DEV_INITRD=y
> >  CONFIG_EXPERT=y
> >  # CONFIG_SYSFS_SYSCALL is not set
> > +CONFIG_PERF_EVENTS=y
> >  CONFIG_SOC_MICROCHIP_POLARFIRE=y
> >  CONFIG_SOC_SIFIVE=y
> >  CONFIG_SOC_VIRT=y
> > diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> > index 8b56a7f1eb06..21d422e740d5 100644
> > --- a/arch/riscv/configs/rv32_defconfig
> > +++ b/arch/riscv/configs/rv32_defconfig
> > @@ -15,6 +15,7 @@ CONFIG_CHECKPOINT_RESTORE=y
> >  CONFIG_BLK_DEV_INITRD=y
> >  CONFIG_EXPERT=y
> >  # CONFIG_SYSFS_SYSCALL is not set
> > +CONFIG_PERF_EVENTS=y
> >  CONFIG_SOC_SIFIVE=y
> >  CONFIG_SOC_VIRT=y
> >  CONFIG_ARCH_RV32I=y
> > --
> > 2.25.1
> >
>
> I think it is better to enable perf events by adding CONFIG_PROFILING
> to the defconfig similar to other ISAs.

Sure, I will update this patch like you suggested.

Regards,
Anup

>
> --
> Regards,
> Atish
