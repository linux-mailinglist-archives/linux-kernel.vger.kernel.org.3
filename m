Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BFB53282B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 12:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbiEXKsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 06:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiEXKsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 06:48:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD63D606D5;
        Tue, 24 May 2022 03:48:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BF27B8175D;
        Tue, 24 May 2022 10:48:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D898C34116;
        Tue, 24 May 2022 10:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653389313;
        bh=+C41sXPIy1muiAhd9BjbS005yqo35L82+zf83HNOtmc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eVlz8pi5H8IL3/TMtdbjw1D1PcGrdtofMB9DBlMyvSwUv5WWm7DGG6oY8O+/EQ1p8
         zLvcEREYhJIuSYWy1O7d76KrvCyaFm0yCCTsEVm8YOJ/OB4Ow0ovxLZqkVAhUhG4yv
         K9tY4f7WXsit7O+JsJfluDl+DO9GvHrk77boAzjH/co4LmmqBQvuMC7VHZJ4y17m1G
         tM5SVrkN9APSaJgzAajzEyFDPuFPcGGTQEqCksQHtROS+nmMsQmU891AD7ObirRBka
         n2uCA9CmA9ab+lR+F4TPeWzlm3pqnlVguRnBsKtVJpWAygWvw7eBgZtLliQHpZqJ6M
         mcYPl9MAWD1Tw==
Received: by mail-ua1-f49.google.com with SMTP id 90so6117352uam.8;
        Tue, 24 May 2022 03:48:33 -0700 (PDT)
X-Gm-Message-State: AOAM5320bRoNn0GEfQwnMHTZIGJxupLQU+SA8qUynTfUdvFbWNnZ49Vu
        yU1VKX1mhngAsCUZhvpVzhWt37SUcUHIOmM+jII=
X-Google-Smtp-Source: ABdhPJzHtt/cupLGwCUKXn8e5lITotXXxcAA1U0tC1JRX9ojisuSaem2Smms7m/djCJeebElmURJu5FzYeugI0JQQl0=
X-Received: by 2002:a9f:354f:0:b0:368:c2c0:f2b5 with SMTP id
 o73-20020a9f354f000000b00368c2c0f2b5mr8746708uao.96.1653389312187; Tue, 24
 May 2022 03:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <1c4e81eda5f9651f581f1554629d334f1afda841.1653227039.git.christophe.jaillet@wanadoo.fr>
 <CAAhV-H73Gj-KDjLuqCtasX5dtBRTHe_8s51wR1mrd=_rBF_XZA@mail.gmail.com>
 <CAAhV-H4Z4Ujif3UcSeSUMdT6SR0hVQnLCCzdGhg27mrtW4OvnQ@mail.gmail.com> <c939b102-6e96-5be2-e41d-9ef028e5a50e@xen0n.name>
In-Reply-To: <c939b102-6e96-5be2-e41d-9ef028e5a50e@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 24 May 2022 18:48:25 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6k=xC-fDYnwsqSeoj7QPPn8RAcR+waQMa8yTs5J-XOSg@mail.gmail.com>
Message-ID: <CAAhV-H6k=xC-fDYnwsqSeoj7QPPn8RAcR+waQMa8yTs5J-XOSg@mail.gmail.com>
Subject: Re: [PATCH] irqchip/loongson-liointc: Fix an error handling path in liointc_init()
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dan.carpenter@oracle.com, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        "open list:MIPS" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Xuerui,

On Tue, May 24, 2022 at 1:41 PM WANG Xuerui <kernel@xen0n.name> wrote:
>
> Hi Huacai,
>
> On 5/24/22 11:47, Huacai Chen wrote:
> > Hi, Christophe,
> >
> > On Tue, May 24, 2022 at 10:50 AM Huacai Chen <chenhuacai@kernel.org> wrote:
> >> Hi, Christophe,
> >>
> >> On Sun, May 22, 2022 at 9:44 PM Christophe JAILLET
> >> <christophe.jaillet@wanadoo.fr> wrote:
> >>> If a of_property_match_string() call fails, we still need to release some
> >>> resources.
> >>> Add the corresponding goto instead of a direct return.
> >> Your patch is correct, but 807e93d0ecbb hasn't been upstream, I don't
> >> know how to handle it.
> >>
> >> Huacai
> >>> Fixes: 807e93d0ecbb ("irqchip/loongson-liointc: Add ACPI init support")
> >>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> >>> ---
> >>>   drivers/irqchip/irq-loongson-liointc.c | 6 ++++--
> >>>   1 file changed, 4 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
> >>> index ff3cb5b05710..2227b702a81d 100644
> >>> --- a/drivers/irqchip/irq-loongson-liointc.c
> >>> +++ b/drivers/irqchip/irq-loongson-liointc.c
> >>> @@ -185,8 +185,10 @@ static int liointc_init(phys_addr_t addr, unsigned long size, int revision,
> >>>                          int index = of_property_match_string(node,
> >>>                                          "reg-names", core_reg_names[i]);
> >>>
> >>> -                       if (index < 0)
> >>> -                               return -EINVAL;
> >>> +                       if (index < 0) {
> >>> +                               err = -EINVAL;
> >>> +                               goto out_iounmap;
> >>> +                       }
> > Just goto out_iounmap is OK, because it returns -EINVAL at last.
> > I've squash your patch to the original one and add a Co-developed-by:,
> > not sure it is the best solution. Thanks.
> You could also "Reported-by" and/or "Suggested-by", to give proper
> credit. Mention of this mail thread (link to lore.kernel.org archive
> maybe) in the commit message is good too.
I think "Reported-by" is used for a bugfix patch, not suitable for the
original patch. And maybe "Suggested-by" is the best.

Huacai
> >
> > Huacai
> >>>                          priv->core_isr[i] = of_iomap(node, index);
> >>>                  }
> >>> --
> >>> 2.34.1
> >>>
