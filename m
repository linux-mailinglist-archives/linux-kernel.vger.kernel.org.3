Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B88E524EC6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354687AbiELNuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354686AbiELNud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:50:33 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2A924A390;
        Thu, 12 May 2022 06:50:32 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2ebf4b91212so57126177b3.8;
        Thu, 12 May 2022 06:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QEFiFZ1/ciZzHW+xjDIhz3vWAg4nMa4ZVXzSZCjuxq0=;
        b=eWiMTMcE7xdesXFlcaYF+vIe62G2XVMe02DKy6lG4V3iHzsii2svHkjvVs3A9IQqLy
         Y9ktwHLUEKhLrZpZvquPUA97WntlLJwLgFtp/5UG7ULm/ywxbJNuvcPDrh+XtmDnWabd
         JlJ1GxWQBA8mr17CUfHy5m+HbSED00lY24SALvYXSMSejXcGaifgeW0gExOOmU5f0QYE
         MicFXWleXqXhvqqjZoXJHexmS9gJUdJ5cebOyQnQay9yYHORyiFS/t4f96kQKSmymXWu
         QHe9XKO+2YuRyiZDDWA2AXKCQdnrWpGnWI0ENTGhPbudbeoDQNUBkX5Eu2LhrK0/Em+4
         T4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QEFiFZ1/ciZzHW+xjDIhz3vWAg4nMa4ZVXzSZCjuxq0=;
        b=HQZgxQlzH0CE1gxuzWAKRTivQmh5Wpiy3SFXGWkcYbYFxdW6T47xwstE7EbaNeZ8i1
         XHx1Q+XT2rlC1YptcsH9nHYEaFCufanhzUinS7Qpx+l2d9YJtty4IH0lYDFqDuBlC2PD
         0ui6El0VLsFf3AQIOYu/6FuDshbpV9eE09ae42MC4aYcp380auXCKzpnJt7Z4BFavMSc
         L770u5WWSfP57vjUBe4uaVu7BtWv8CxBXThI/QmY0xOQfnrDBGV1SsfDXrI77WqvZWzP
         nuCPtU/ces7L35yeXlusD07kqsoEaihZ1D0JAJZ1lmn2ga/eLCl40nrFZE17IpZLRb+p
         eQ2g==
X-Gm-Message-State: AOAM532ctKr2s7ScWXtupzGVn31IerPqc6oHcdPBL7UDn2+2KSqBEr8W
        MlBS+JPn1Jz7yai+YnmPovYADwrYNGYS7xp/PkY=
X-Google-Smtp-Source: ABdhPJwyqBCes83LPhGfqcSycC7Et8kDreO3/Xg1TIXilOVO2QsFMMYciDEIbOgk+p+Ri0lT1eW1HECG7A4h5Do4scU=
X-Received: by 2002:a0d:d491:0:b0:2ef:5485:fca with SMTP id
 w139-20020a0dd491000000b002ef54850fcamr154901ywd.16.1652363431692; Thu, 12
 May 2022 06:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220511183210.5248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220511183210.5248-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <87y1z75770.wl-maz@kernel.org> <CA+V-a8tf1RmT-cX5y807rTAPES2NXLJHp=u1WUG11fLrtt-5Mg@mail.gmail.com>
 <87wneq6fz3.wl-maz@kernel.org>
In-Reply-To: <87wneq6fz3.wl-maz@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 12 May 2022 14:50:05 +0100
Message-ID: <CA+V-a8v9WodNNK7AL4XemDnSrrWc9wG+qDKZb7SmbWixs5Q3Nw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] gpio: gpiolib: Allow free() callback to be overridden
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Thu, May 12, 2022 at 2:24 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 12 May 2022 13:48:53 +0100,
> "Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:
> >
> > Hi Marc,
> >
> > Thank you for the review.
> >
> > On Thu, May 12, 2022 at 12:19 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Wed, 11 May 2022 19:32:08 +0100,
> > > Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > >
> > > > Allow free() callback to be overridden from irq_domain_ops for
> > > > hierarchical chips.
> > > >
> > > > This allows drivers to free any resources which are allocated during
> > > > populate_parent_alloc_arg().
> > >
> > > Do you mean more than the fwspec? I don't see this being used.
> > >
> > The free callback is used in patch 5/5 where free is overridden by
> > rzg2l_gpio_irq_domain_free. I just gave an example there as an
> > populate_parent_alloc_arg()  In actual in the child_to_parent_hwirq
> > callback I am using a bitmap [0] to get a free tint slot, this bitmap
> > needs freeing up when the GPIO interrupt is released from the driver
> > that as when overridden free callback frees the allocated tint slot so
> > that its available for re-use.
>
> Right, so that's actually a different life-cycle, and the whole
> populate_parent_alloc_arg() is a red herring. What you want is to free
> resources that have been allocated via some other paths. It'd be good
Is there any other path which I have missed where I can free up resources?

> if your commit message actually reflected this instead of using an
> example that doesn't actually exist.
>
My bad, I will update the commit message.

> >
> > > There is also the question of why we need to have dynamic allocation
> > > for the fwspec itself. Why isn't that a simple stack allocation in the
> > > context of gpiochip_hierarchy_irq_domain_alloc()?
> > >
> > you mean gpio core itself should handle the fwspec
> > allocation/freeing?
>
> Yes. The only reason we resort to dynamic allocation is because
> ThunderX is using MSI-based GPIOs, and thus doesn't use a fwspec (no
> firmware is involved here).
>
I see..

> If we had a union of the two types, we could just have a stack
> variable, and pass that along, completely sidestepping the whole
> dynamic allocation/freeing business.
>
Right agreed.

Cheers,
Prabhakar
