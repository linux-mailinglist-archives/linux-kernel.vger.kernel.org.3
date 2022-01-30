Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16B34A372D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 16:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355386AbiA3PL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 10:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349175AbiA3PL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 10:11:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B564C061714;
        Sun, 30 Jan 2022 07:11:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA2426124C;
        Sun, 30 Jan 2022 15:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19190C340F1;
        Sun, 30 Jan 2022 15:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643555516;
        bh=bjY5Bd8WmnLHJ0/+E+BfU396MaNZGVNtIYeOtwQvt6g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mZ0ZlJ/lU2kQQdZJe9lUTm5uIlQm/lY0zHmBxzHKgOsEruCpf2svcyi0SNqfmgbVj
         iaLel856SEz8fiB+B6LJae2tOUcOu9CELIlhAjC3h1wbRCxxkN3GeWvGObTCGtIJy9
         jodkfRf6SZV/ADfbpvozpjMxcwx+HoPFMW7Uzky3QWFBvuL3SVNtLDbb5CVL7ROW/f
         +VpSwqB8weruf1R3hbV/ad7Oz99myFABa2EUTS59+o17a5VWgys9iBoP3WFjGcdpNw
         t6h82+/TbPhnCG6A4uTjkaWbNEy/oXyZ82g+NATSCYw07jif2P2KEkKRDHzyYHfuAJ
         voFTwRfEwAQjw==
Received: by mail-vs1-f48.google.com with SMTP id f6so8831175vsa.5;
        Sun, 30 Jan 2022 07:11:56 -0800 (PST)
X-Gm-Message-State: AOAM533SvSQgq2yenh6dgyX7kTTIXq0PZpXL4eV7uBhoxFIg6lHme34z
        eJwOB0vbvkVMhD9PXGa8lvtFDsMHZMxakypPKXA=
X-Google-Smtp-Source: ABdhPJwMK9DUIzKUAIOWlaq0Ta5XXx5E4OMuiq5shsMOycqIZItMc4Gr9hUgonYaoC8Fda1dzq199JcGzBkeL2fUibA=
X-Received: by 2002:a67:e947:: with SMTP id p7mr6666466vso.59.1643555515158;
 Sun, 30 Jan 2022 07:11:55 -0800 (PST)
MIME-Version: 1.0
References: <20220129162726.1154501-1-guoren@kernel.org> <20220129162726.1154501-3-guoren@kernel.org>
 <87r18qxui9.wl-maz@kernel.org> <CAJF2gTTYN0bxnnMtP9L1KvaH0h6ny+Lr3+fC7GP-YWnwjAYd4A@mail.gmail.com>
 <35b1838d-ef80-1816-46f6-9cba7afc813e@sholland.org> <CAJF2gTQsi6uT8ea6MTu6oDA-9xsd3fW5ETHAtpzGZxapLpLsWA@mail.gmail.com>
 <87o83ty0ti.wl-maz@kernel.org> <CAJF2gTR=Gyw33dt36g+uqDSMckqJW+bifpue2N_+FAMEn4NqAQ@mail.gmail.com>
 <87mtjdxoam.wl-maz@kernel.org>
In-Reply-To: <87mtjdxoam.wl-maz@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 30 Jan 2022 23:11:44 +0800
X-Gmail-Original-Message-ID: <CAJF2gTROgAuj0j2qC6AZFgP+k3erU7erQRadH5ugaVPkj_=1hQ@mail.gmail.com>
Message-ID: <CAJF2gTROgAuj0j2qC6AZFgP+k3erU7erQRadH5ugaVPkj_=1hQ@mail.gmail.com>
Subject: Re: [PATCH V6 2/2] irqchip/sifive-plic: Fixup thead,c900-plic dt
 parse in opensbi
To:     Marc Zyngier <maz@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Anup Patel <anup@brainfault.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 10:59 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sun, 30 Jan 2022 13:09:21 +0000,
> Guo Ren <guoren@kernel.org> wrote:
> >
> > On Sun, Jan 30, 2022 at 6:28 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Sun, 30 Jan 2022 04:39:34 +0000,
> > > Guo Ren <guoren@kernel.org> wrote:
> > > >
> > > > > +IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_init);
> > > > I think we should give clear info in /proc/interrupts. I hope we could
> > > > keep thead_plic_init.
> > >
> > > Why? There is no material difference at the driver level, and
> > > /proc/interrupts won't be the target of a branding exercise (which
> > > this series seems to be all about).
> > It's not a branding exercise, the series just correct the broken code
> > & incorrect /proc/interrupts display.
>
> There is *nothing* incorrect in /proc/interrupt. If anything, changing
> the string *is* an ABI change, for no good reason.
I've minimized the modification to fix the problem, please have a look:

https://lore.kernel.org/linux-riscv/20220130135634.1213301-3-guoren@kernel.org/T/#u

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
