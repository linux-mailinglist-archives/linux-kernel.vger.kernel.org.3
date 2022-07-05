Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1F1566288
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 06:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiGEExf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 00:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGEExd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 00:53:33 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8041F2BD5;
        Mon,  4 Jul 2022 21:53:31 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r18so13754164edb.9;
        Mon, 04 Jul 2022 21:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NDzaO0So9K6zv80bFkYO/VLA9FCbszT74hpLI59vh0M=;
        b=jduImZAuK9TTByg0x/5M8lq9VxzFvWUDSW1B39oBUfMTgKFezRfEtgJUG1FASTePG3
         oDsNZQbj4WQabt/y0zUtkCwvCgKaa/DK+skiK9iL33vir1us127p+hdift4Q3oaevhqG
         9HhofSxAsdqGoW014G+K+CO95/jfDRpnE6Efsftl40ECpPJH8R6bTtMgT2lI+mXNeIO2
         e39sJ0h3egIOUGdLBqxkSA7XNwpPhG63azQFiAa9Brptm5JS8ckiqQq67v2K1bUZq/2B
         RpmgxVMdHWn4F9p7GfGdj0ImTZX50e3l++dSk+j13SkiJcWu0L+0ERGtr5027eJs23yz
         I0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NDzaO0So9K6zv80bFkYO/VLA9FCbszT74hpLI59vh0M=;
        b=wJARlrBQcu8e+ETBO/50q3rEymrBaOvOVutDIz6XKH7vrq0hykRu1ChKDj9sBdl7Sp
         9/KyzOXMshQAWZmLst/cWFKERRiN9n/EF1MCAsh3RiaLMchZVoS9nqOBymM56Ff4+1a3
         qooUNHvChMvh8F1PWBWuIden382JUyjqUKugz20nSmWzDP+urV9uF+eGkL4zZSEXrvdT
         xo+Cy3SoGM6TgIVEEm2L5qw/1YD/Jbs2uLNI9yO6lAlEkqMz+d/epbnQw3hbGaQD+3Cz
         c8/9mas+SZ47ZLQz71yixodAuqze41YQHJyOdP0Drqs5OUCC4+o6JogjAj+nrtJAX2mV
         gd2Q==
X-Gm-Message-State: AJIora8D6jKwdfeMGtopCTIuUlLLVHV4ELCX1hMfO9IgOXNQmBEjbgpR
        i4DpegeJPQWCnnYD7MUPdoaIn25C9DZY0tkYx9c=
X-Google-Smtp-Source: AGRyM1tWTlELSg1SZoz7Yz45CZcUVSXPNq7wPnuV6znbnrylh0iPjMgvgwluYG6ib3AEt91h7s/CLXeavaDOnoWyG9I=
X-Received: by 2002:a05:6402:42d3:b0:435:2c49:313d with SMTP id
 i19-20020a05640242d300b004352c49313dmr42162751edc.86.1656996810125; Mon, 04
 Jul 2022 21:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220703194020.78701-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220703194020.78701-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAHp75VfFZ146p1sZ2=Ec-F-9zYJZHPWyvgYQeVsG=2TzssaPmA@mail.gmail.com>
In-Reply-To: <CAHp75VfFZ146p1sZ2=Ec-F-9zYJZHPWyvgYQeVsG=2TzssaPmA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 5 Jul 2022 05:53:03 +0100
Message-ID: <CA+V-a8vua6t5wDNc2CT_XWhoy6OjmzCXyaJ1FtGaqeG5g-qS-w@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] gpio: gpiolib: Allow free() callback to be overridden
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Mon, Jul 4, 2022 at 5:16 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sun, Jul 3, 2022 at 9:43 PM Lad Prabhakar <prabhakar.csengg@gmail.com> wrote:
> >
> > Allow free() callback to be overridden from irq_domain_ops for
> > hierarchical chips.
> >
> > This allows drivers to free up resources which are allocated during
> > child_to_parent_hwirq()/populate_parent_alloc_arg() callbacks.
> >
> > On Renesas RZ/G2L platform a bitmap is maintained for TINT slots, a slot
> > is allocated in child_to_parent_hwirq() callback which is freed up in free
> > callback hence this override.
>
> Hmm... To me this sounds asymmetrical. We alloc something in another
> callback, which is not what this free is for. Perhaps it should be an
> optional
>
> free_populated_parent_arg() or alike?
>
@Marc your thoughts?

Cheers,
Prabhakar
