Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244D15321B7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 05:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbiEXDrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 23:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbiEXDre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 23:47:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691636C0FB;
        Mon, 23 May 2022 20:47:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E75F16135A;
        Tue, 24 May 2022 03:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A376C34116;
        Tue, 24 May 2022 03:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653364050;
        bh=8tcF8bQShGWFWzNCMNh0zMWba2CPnkK1xQA6jsfKgwc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qLORkRcpbE/mbh+ysON84YFTBjvE4CAdwfvauETluzQN0DmkJovSQoyg3eTrQVETs
         k1RvQrazR8W/5DZSg5ER2PzL1nsIxCMm9+aEj0rU5J9ukvjSUpbvoaKbbxDr7c/hNW
         y739Kei6YXg2uvV4uHyF/+JRg26q9WKRalEinQWuSX30d2lgQnPsimRn+0ivSUmfy0
         bW8jwJ2yndHBoFtKovyN3ZN7meicNoCQ/F+8sUwaN0TPxEpf1Ha1VvzsE3w7C6ZFJN
         h+ji7OdLUvXDrazOFO9CWDpVkqxb7Gtexn86Ls70R6ID8AM+0c5OhStubcRAo7Tfpe
         Bo+LGMkl2/BYg==
Received: by mail-vs1-f43.google.com with SMTP id c26so16980670vsl.6;
        Mon, 23 May 2022 20:47:30 -0700 (PDT)
X-Gm-Message-State: AOAM531UhgyBcdhhyv58SotF5LTE2QridM20dF8BpqYy/Nh8QiibZUrg
        1CDliJqLHhFHXyiGkpMdgqfoh79WkGT9FlhmGVc=
X-Google-Smtp-Source: ABdhPJw4KEDQ2Km2rsvHXF7AwDdVRTcBE2+Ke1X9TBBuXKa6wieavAx7ke+avjUJaTk0EZOXe2ax2Fv2zBYBZ9lzvfA=
X-Received: by 2002:a67:e1c4:0:b0:335:cdc4:395f with SMTP id
 p4-20020a67e1c4000000b00335cdc4395fmr9637977vsl.71.1653364049315; Mon, 23 May
 2022 20:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <1c4e81eda5f9651f581f1554629d334f1afda841.1653227039.git.christophe.jaillet@wanadoo.fr>
 <CAAhV-H73Gj-KDjLuqCtasX5dtBRTHe_8s51wR1mrd=_rBF_XZA@mail.gmail.com>
In-Reply-To: <CAAhV-H73Gj-KDjLuqCtasX5dtBRTHe_8s51wR1mrd=_rBF_XZA@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 24 May 2022 11:47:23 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Z4Ujif3UcSeSUMdT6SR0hVQnLCCzdGhg27mrtW4OvnQ@mail.gmail.com>
Message-ID: <CAAhV-H4Z4Ujif3UcSeSUMdT6SR0hVQnLCCzdGhg27mrtW4OvnQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip/loongson-liointc: Fix an error handling path in liointc_init()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dan.carpenter@oracle.com, Jiaxun Yang <jiaxun.yang@flygoat.com>,
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

Hi, Christophe,

On Tue, May 24, 2022 at 10:50 AM Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Hi, Christophe,
>
> On Sun, May 22, 2022 at 9:44 PM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
> >
> > If a of_property_match_string() call fails, we still need to release some
> > resources.
> > Add the corresponding goto instead of a direct return.
> Your patch is correct, but 807e93d0ecbb hasn't been upstream, I don't
> know how to handle it.
>
> Huacai
> >
> > Fixes: 807e93d0ecbb ("irqchip/loongson-liointc: Add ACPI init support")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> >  drivers/irqchip/irq-loongson-liointc.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
> > index ff3cb5b05710..2227b702a81d 100644
> > --- a/drivers/irqchip/irq-loongson-liointc.c
> > +++ b/drivers/irqchip/irq-loongson-liointc.c
> > @@ -185,8 +185,10 @@ static int liointc_init(phys_addr_t addr, unsigned long size, int revision,
> >                         int index = of_property_match_string(node,
> >                                         "reg-names", core_reg_names[i]);
> >
> > -                       if (index < 0)
> > -                               return -EINVAL;
> > +                       if (index < 0) {
> > +                               err = -EINVAL;
> > +                               goto out_iounmap;
> > +                       }
Just goto out_iounmap is OK, because it returns -EINVAL at last.
I've squash your patch to the original one and add a Co-developed-by:,
not sure it is the best solution. Thanks.

Huacai
> >
> >                         priv->core_isr[i] = of_iomap(node, index);
> >                 }
> > --
> > 2.34.1
> >
