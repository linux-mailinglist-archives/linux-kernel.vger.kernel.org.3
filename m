Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFD35779A8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 04:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbiGRCi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 22:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGRCi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 22:38:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4747013CC3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 19:38:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF19EB80EA6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830BEC341CF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658111903;
        bh=l4JDhb76uroMy5awOXCVXB5HT/NZzSo8NBdMi4GfwQ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ua4UCIlq88p/FlBUVi5i8SmTGpBcVHWvBSgMB0AYJAKyEtvP0IQxMfd889InFrkxX
         +KJw9/toPe2TYxy+eonMZ1TAEleteGQ3+QMLbK1k5I5b4nrxkKwM6qbVKiNz0pnfT9
         mKSn5TrFkRs0JzY1I5zpxR5/EkYPdMmycfhiuFdrj8vgPGCaLw8HzMvx3300XxBVhM
         H24MdgV13GdMHerf9yj5VaVciCfDl40+LkXqTshIn1IX+e6+bQ7VK8J/4nqpfVuIFa
         b8/7PJHKemOHBqmYsku0++PjEnpiyT8+TLwP1ftmklUGMP7XEKya2s7JIe9ukxGwYD
         +dkVM/2TUJ8Tg==
Received: by mail-vs1-f43.google.com with SMTP id k2so9255639vsc.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 19:38:23 -0700 (PDT)
X-Gm-Message-State: AJIora/K7aVE8c0AYd+unlhH6knPJJr5RXSjZ3QpeKn0Hu3tfz1rhCVK
        7DG1wKqmFgLNG8/IcM2+SB4diZi9J7oiiFjg0XQ=
X-Google-Smtp-Source: AGRyM1v/DirRnQPX39ns5LyWiP2zbTvUxmRpt25N1K8QB9Dwo8iN/Ifs3/66jao8XTq1WbGdVwobR5f71MC0daiRsxI=
X-Received: by 2002:a67:d495:0:b0:357:688d:f65c with SMTP id
 g21-20020a67d495000000b00357688df65cmr8459502vsj.59.1658111902427; Sun, 17
 Jul 2022 19:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <1657868751-30444-1-git-send-email-lvjianmin@loongson.cn>
 <87less52bx.wl-maz@kernel.org> <6e9def1e-31fe-787d-1b2b-a328424352f0@loongson.cn>
 <87ilnw3vlg.wl-maz@kernel.org> <20994a99-b5b1-442d-d23d-2a11ecef24a0@loongson.cn>
 <CAAhV-H6CJ-aF2s9D4QJ5zYZGt_=C4QHFCzKByT6urcFMgWv+4g@mail.gmail.com> <87y1wrzto7.wl-maz@kernel.org>
In-Reply-To: <87y1wrzto7.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 18 Jul 2022 10:38:09 +0800
X-Gmail-Original-Message-ID: <CAAhV-H74rSy3DkFFgyGwW-rGO5tVJhrthQ78vAztnzze7-NYrA@mail.gmail.com>
Message-ID: <CAAhV-H74rSy3DkFFgyGwW-rGO5tVJhrthQ78vAztnzze7-NYrA@mail.gmail.com>
Subject: Re: [PATCH V15 00/15] irqchip: Add LoongArch-related irqchip drivers
To:     Marc Zyngier <maz@kernel.org>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, loongarch@lists.linux.dev,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marc,

On Sun, Jul 17, 2022 at 10:43 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sun, 17 Jul 2022 15:08:14 +0100,
> Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > Hi, Marc, Jianmin,
> >
> > I have an idea but I don't know whether it is acceptable: Marc gives
> > an Acked-by for the whole series, then this irqchip series goes
> > through the loongarch tree together with the PCI patches, then we
> > don't need other hacks except the ACPI definitions.
>
> Not sure how this solves the original problem. PCI should never be
> mandatory (it is actually super useful to be able to build a very
> small kernel without too many drivers), and there shouldn't be
> configurations where the kernel doesn't build.
Now, the pci-loongson controller code (A) is in the PCI tree, the pci
enablement code (B) is in the LoongArch tree, and the irqchip code (C)
is in the irqchip tree. If the order for upstream is (A) --> (B) -->
(C), there will be no build error. My above idea is to make sure the
order of (B) and (C) is controlled in the same tree. PCI/MSI is a
mandatory requirement for LoongArch, so I want to avoid some
unnecessary #ifdefs.

>
> It is also my own responsibility to merge these things, and I'd rather
> not delegate this, specially as it touches a bunch of other
> subsystems.
I know, this is reasonable. Then if we can control the order of
(A)(B)(C) in three trees, the build error can be avoided in the
linux-next tree.

Huacai

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
