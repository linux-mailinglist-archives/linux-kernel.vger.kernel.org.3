Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E7952C25F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241504AbiERSg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241296AbiERSg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:36:56 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796321C345C;
        Wed, 18 May 2022 11:36:55 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id q135so5154018ybg.10;
        Wed, 18 May 2022 11:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z+wFB5Fdlp80HPZ0rDBxYUuhgX0VkiUoP9qDKbx3W6U=;
        b=i6uC2Gh7/Iu4IYcfm/izqjPXBLaBPFh9F7S/XxDzPCmeusV+g95LEEU2TxZ5+Eybcn
         vSzevKbVChVrkixF3JhT34XLebrh3DBiRdNizqnmoccc/nzrX0H+Ex8ugdsNGzIh/3mp
         DURbMuGpIoI7NC9lUr37VzbvjkZDgfAUGnfu5dUJGaQnxnp+qHdXtIKe6ZGFOdDoWxUD
         taiDR28BLZGYDqhf0KXaaSv1F61XaDLid7rjBpqWmRBCp9r4fm4agcJmke60LmtzsERZ
         Qdk63z7GJw7R0h4N0rg79sOYS+UIrCGEEr46NyYvPgb2cHD7dn6HAE+GYbmg6lnG42D6
         4u9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z+wFB5Fdlp80HPZ0rDBxYUuhgX0VkiUoP9qDKbx3W6U=;
        b=2jCpqcCFrCNOBNUdtDqBlJeqvsuFg+OVf4NK7iayON38XOFpdngItq3YRP79ABpxfa
         AsEJkxN2xpTqlPjchWkYDenJFLRaDDHGiYTAxSigpKbsmdK1vQAU0SxwmrdtRFYp+29J
         OAJV0ArGfrEwy0HC8q6oRvNF7YR5gl+aNLLJqVBOHhAi7czTGEoSNBK605Jh963objFn
         7rqumDaz5B8WIkcpFbrtTN76WdqVDCZDSH9pURkYIKXgpwLzz1RGLXZX8CihN+AM5Lbe
         i1yaD2xFZkI4ld2eCgNR/xtOJFWwFOQw8mxvEh30lhErmICX1aAaThBQ/6CAJqYjcFRD
         abQQ==
X-Gm-Message-State: AOAM530kcWi3LG7rSlhuAX9heYXd0QRjYy5lqE7s1tNRxb/PTEkO186a
        O4sXFVvRa3rIv4k8T6dOpTE1ucMkb+GP0BVK4BU=
X-Google-Smtp-Source: ABdhPJxomAexeHpFDfrCohF3Dr3KktAL/UvFbfVdhyWtHW79Q4HxbdlPH0duXEI0EhEhmuUukOhmCshmVdmPlacd24s=
X-Received: by 2002:a05:6902:1407:b0:64a:ecc7:aa2 with SMTP id
 z7-20020a056902140700b0064aecc70aa2mr937661ybu.645.1652899014699; Wed, 18 May
 2022 11:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220511183210.5248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220511183210.5248-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <CACRpkdYQAsam_v0XHm-A_trbyifj1pBQq5N+zc9KVw1vXVTYUw@mail.gmail.com>
In-Reply-To: <CACRpkdYQAsam_v0XHm-A_trbyifj1pBQq5N+zc9KVw1vXVTYUw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 18 May 2022 19:36:28 +0100
Message-ID: <CA+V-a8v_bCtoipKXyYoHsSku0-AbABi6Wj0RsHrj7_Sk4MUJyg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] gpio: gpiolib: Add ngirq member to struct gpio_irq_chip
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
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

Hi Linus,

Thank you for the review.

On Fri, May 13, 2022 at 9:47 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, May 11, 2022 at 8:32 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> > Supported GPIO IRQs by the chip is not always equal to the number of GPIO
> > pins. For example on Renesas RZ/G2L SoC where it has GPIO0-122 pins but at
> > a give point a maximum of only 32 GPIO pins can be used as IRQ lines in
> > the IRQC domain.
> >
> > This patch adds ngirq member to struct gpio_irq_chip and passes this as a
> > size to irq_domain_create_hierarchy()/irq_domain_create_simple() if it is
> > being set in the driver otherwise fallbacks to using ngpio.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> As Geert says, I think you can just use .valid_mask for this,
> what do you say?
>
I don't think Geert is suggesting that. The .valid_mask option is one
time setting but what I need is something dynamic i.e. out of 392 GPIO
pins any 32 can be used as an interrupt pin. Also with this patch we
also save on memory [0].

[0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/kernel/irq/irqdomain.c?h=next-20220518#n153

Cheers,
Prabhakar
