Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2729A598F8E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 23:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242552AbiHRVav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 17:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347171AbiHRVab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 17:30:31 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63D3B8F1C
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:29:14 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-32a09b909f6so76383057b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=lAZWTD/ZICVg0LDV29If/DkOf/M6td1O8C85lbuNtx4=;
        b=Jw2fwjJxFysS6dly4T7qMHiVlXuUDJnlFgx69LZliYnmBo7zmEErUGMNbIcd5mFJ3l
         T5L2JOuj40RPJbtngjWgicprKfi+Qp+SXbdVdtyX5SfapH4IwU0TV1qhIXJl060ox0G9
         k00nBwD1V5o5EcvEG06md00j8wP9t8xp1ewuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lAZWTD/ZICVg0LDV29If/DkOf/M6td1O8C85lbuNtx4=;
        b=q5MARUay87oROoeGOJry5VczTfc6l8M7vATi+P3sKTYPT5+nyy3d0/1HVn4/J4xEqm
         vlRFjr7igInTBYlueNGky5VmIYpuHihVQy2PJIanASGWhFBFTiUvbYcfxbptWuxT1KXh
         dj80t7jfRLAVuxKu4GPCyRbe6Q0wrL1C4ptcftL+VS8c2900hXxI1f5SUf59JcujUP8Q
         V53lCUWNXVsmiLMuXNCvU276DCoVTLLbZ6FwRSTnNk8ReN7NJYwFX4bOfA0Ko3LTC/pR
         2gD6ukIJYpcfawH66sUJcW4NO9UYzCTqjQoPVX2OPPYmKa/ABcwgkqdC3pCjlKZf3xsg
         qCpA==
X-Gm-Message-State: ACgBeo1yGA/NqgbTE9sBKrS+ETT5uxpb3LJBYL9i3DCpgCQsc5nfrVFR
        lmOaeku+HONHhinVvmLQd8F023adngMEn0t6WrFB
X-Google-Smtp-Source: AA6agR6gTUMES80CQ41uaydLm3+tG//C1C6nybqXPGXeiBU9JHT0M2je0AYehFCgFl9XqCTTnUW5KY4BWhSwdd3P+zs=
X-Received: by 2002:a81:10c9:0:b0:337:6e4a:af6c with SMTP id
 192-20020a8110c9000000b003376e4aaf6cmr2333072ywq.508.1660858154077; Thu, 18
 Aug 2022 14:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220420112408.155561-1-apatel@ventanamicro.com> <CAAhSdy15v3-_2bbJuCVm5zp1nNHHLjtypAESOoPkcChjgFsssw@mail.gmail.com>
In-Reply-To: <CAAhSdy15v3-_2bbJuCVm5zp1nNHHLjtypAESOoPkcChjgFsssw@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 18 Aug 2022 14:29:03 -0700
Message-ID: <CAOnJCUKUTt1VfU+wMfxE4P21ttW5uaegXD+0oq4O4KgpGOWhaQ@mail.gmail.com>
Subject: Re: [PATCH v3] RISC-V: Increase range and default value of NR_CPUS
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 5:08 AM Anup Patel <anup@brainfault.org> wrote:
>
> Hi Palmer,
>
> On Wed, Apr 20, 2022 at 4:54 PM Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > Currently, the range and default value of NR_CPUS is too restrictive
> > for high-end RISC-V systems with large number of HARTs. The latest
> > QEMU virt machine supports upto 512 CPUs so the current NR_CPUS is
> > restrictive for QEMU as well. Other major architectures (such as
> > ARM64, x86_64, MIPS, etc) have a much higher range and default
> > value of NR_CPUS.
> >
> > This patch increases NR_CPUS range to 2-512 and default value to
> > XLEN (i.e. 32 for RV32 and 64 for RV64).
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>
> Can this PATCH be considered for 5.19 ?
>
> Thanks,
> Anup
>
> > ---
> > Changes since v2:
> >  - Rebased on Linux-5.18-rc3
> >  - Use a different range when SBI v0.1 is enabled
> > Changes since v1:
> >  - Updated NR_CPUS range to 2-512 which reflects maximum number of
> >    CPUs supported by QEMU virt machine.
> > ---
> >  arch/riscv/Kconfig | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 00fd9c548f26..1823f281069f 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -275,10 +275,13 @@ config SMP
> >           If you don't know what to do here, say N.
> >
> >  config NR_CPUS
> > -       int "Maximum number of CPUs (2-32)"
> > -       range 2 32
> > +       int "Maximum number of CPUs (2-512)"
> >         depends on SMP
> > -       default "8"
> > +       range 2 512 if !SBI_V01
> > +       range 2 32 if SBI_V01 && 32BIT
> > +       range 2 64 if SBI_V01 && 64BIT
> > +       default "32" if 32BIT
> > +       default "64" if 64BIT
> >
> >  config HOTPLUG_CPU
> >         bool "Support for hot-pluggable CPUs"
> > --
> > 2.25.1
> >


Ping ?
It would be useful to include this patch sooner than later to enable
high HART count testing by default.


-- 
Regards,
Atish
