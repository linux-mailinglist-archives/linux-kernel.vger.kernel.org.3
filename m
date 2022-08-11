Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C8258F968
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbiHKIoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbiHKIoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:44:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00724915D2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:44:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 540F06155C
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60AAC43140
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660207461;
        bh=QRD0SrbRLe1tnBYmPBs/QIzN5Bptooz0fAq+UbSshTw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DcM1ERpbqxK+wP6ZmEj7Aw14MdYz28KXgzfRn+MzzE/m3/zEIeBNrpesOvBiL8f7F
         N6dA0tBy++e4Fuu0g2N2MCwOFGOVegqv39XbpTh2qbjjmMwNB7V+HGI0rAZt1qRcJl
         0cFK4Neu3X9YhZ0LpsjR071G3g2Pk4yIB2TFWPLq7VGKKtkv1SJdRI30R+1SPgNDGI
         Vk4zC6oNsk1aihU2K4sZPC+zgIZM8YtjXoN81BTQt8Mhp93Esj0kKirFrWHnf+I1IH
         NEcjEL/JH23UtqKN+2urkP5RXrRVgvr4K/L2+SSrPF5GX3JtrtWiQyl7fZLAOvy9cG
         27Ipskii18iiQ==
Received: by mail-vs1-f52.google.com with SMTP id j2so17645709vsp.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:44:21 -0700 (PDT)
X-Gm-Message-State: ACgBeo0sqFMp1LzkHNBe7otuZ0tpG+uOFgKy7GrwnSie9lTJBJ2NGYsW
        akf8YTTjR6ZmfGYhycWg/7lfgfcnmcjpBEV28C4=
X-Google-Smtp-Source: AA6agR7v289aXTEpmMENNm15AnL82gCt8uU9R+rdXtgZeJQN62meRDP4J9dV3In/yxKbCNUXd+D6+Z2gDSNm+xxSgi8=
X-Received: by 2002:a05:6102:b14:b0:38a:88dd:c169 with SMTP id
 b20-20020a0561020b1400b0038a88ddc169mr2550690vst.84.1660207460684; Thu, 11
 Aug 2022 01:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220810103156.1214996-1-chenhuacai@loongson.cn>
 <f92fc4f34784217206b53a3709538d5c@kernel.org> <CAAhV-H7DbvjEcms9Y81t_=WyDnKu5vuB4x7g7vU3f9CUhZykHQ@mail.gmail.com>
 <1359c52d-5194-7306-0e76-cde97b5aa31c@xen0n.name> <87lervb74u.wl-maz@kernel.org>
In-Reply-To: <87lervb74u.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 11 Aug 2022 16:44:08 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5D+zHRaAPUqRQOkrv_ae+9UUEt9Cqcpcqd2cWhSiSbiw@mail.gmail.com>
Message-ID: <CAAhV-H5D+zHRaAPUqRQOkrv_ae+9UUEt9Cqcpcqd2cWhSiSbiw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Fix the !CONFIG_SMP build for irqchip drivers
To:     Marc Zyngier <maz@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marc and Xuerui,

On Thu, Aug 11, 2022 at 2:56 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 11 Aug 2022 01:58:15 +0100,
> WANG Xuerui <kernel@xen0n.name> wrote:
> >
> > On 8/10/22 23:38, Huacai Chen wrote:
> >
> > > Hi, Marc,
> > >
> > > On Wed, Aug 10, 2022 at 7:01 PM Marc Zyngier <maz@kernel.org> wrote:
> > >> On 2022-08-10 11:31, Huacai Chen wrote:
> > >>> 1, Guard get_ipi_irq() in CONFIG_SMP;
> > >>> 2, Define cpu_logical_map() for the EIOINTC driver;
> > >>> 3, Make eiointc_set_irq_affinity() return early for !CONFIG_SMP.
> > >>>
> > >>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > >> Frankly, the real question is why do you even bother? As far as
> > >> I can tell, LoongArch has no UP system.
> > >>
> > >> arm64 crossed that bridge a long time ago, and we never looked
> > >> back, because these systems hardly exist.
> > >>
> > >> I'd rather you simply have a CONFIG_SMP always set to 'y', and
> > >> be done with it forever.
> > > LoongArch also has low-end processors (even LoongArch64). Though we
> > > haven't translate all documents at
> > > https://loongson.github.io/LoongArch-Documentation/ in time, there are
> > > currently 4 LoongArch64 processors: Loongson-2K500 (single-core),
> > > Loongon-2K1000 (dual-core), Loongson-3A5000 (quad-core) and
> > > Loongson-3C5000 (16-core). So we indeed need a UP configuration.
> > > Thanks.
> >
> > I remember seeing an alternatives mechanism in the works for
> > LoongArch. If such alternatives mechanism is to be upstreamed in short
> > order, why make SMP one more build-time time option that developers
> > have to decide upon? It's not like SMP code would break, or run with
> > unacceptable overhead, on UP systems AFAIK, so it's probably better to
> > not preemptively support so many *possibilities* that haven't been
> > realized so the *current* maintainability suffers. Practically one
> > can't buy the LoongArch 2K line of products anywhere right now, and
> > the few companies developing for it are likely not using upstream
> > kernels anyway, so it's not like we can't wait either.
>
> And that's exactly my point. Yes, it is always possible to build a UP
> system. But is it worth *maintaining* a configuration option for this?
> I seriously doubt it.
>
> My advise is to stick to SMP only for now (it will run just fine on a
> UP machine), and only if upstream users find it completely
> unacceptable should a !SMP option be introduced, or make it a runtime
> decision (32bit ARM has had SMP_ON_UP support for a long time).
OK, I will drop this patch and follow the ARM64 method, thanks.

Huacai
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
