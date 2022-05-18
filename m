Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC4A52BDC2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239065AbiERPDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 11:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239043AbiERPDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 11:03:51 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4410C1DE556;
        Wed, 18 May 2022 08:03:50 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id y7so2902248ejr.13;
        Wed, 18 May 2022 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DIU6nbXTAiAMQ/3SVzqxTbsO2euyVD3quCdWwb6E3nA=;
        b=hgY1QL+wrUYK+LW+M54xhYQFTwEP4IRsM0Mco4O9DObO2rtCLqAlHBidMaXWSbpmMi
         3Oa87JQXe0SqLcqDByMzvK+a0Tyse1PppKxDLAl4FYsygwkP6Kbwxyd4ie1nVYlbvdGX
         IhhiYPD+Jgysiu/kkjSRm8Oe/qWjf7lJYtKAD2Z6icwz8j3fe4s9xpmPJ2YekV9JExgG
         l1Qj5Lt2KTyAoSWdBr9vdPnGTG62z6faKRLWxttT0nsjnxUIJtQIvWey4WreqNri999G
         rMkJm3q30orS5dkGdXZLCNttmr6EPm/BY3LsknjeTOXd8oK6oykweUVgPNUa+WH+uB8A
         5Iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DIU6nbXTAiAMQ/3SVzqxTbsO2euyVD3quCdWwb6E3nA=;
        b=4PvuAV+Z2S6EpZSEJme/2NP/DLe2rH7/I9TzOmaUgbCirIDJIgRmh+Q6Jd3xSIJgKT
         hGHIulskPgDxWqCZ+e8cNxx+o5obiEs4tPJrZw3VzsvEOGqBLrX3EUREGXXs6zdGSFJi
         4TovsRQHIcVDIUOMjrZm35abe5pgt5lg0eeucTKYCkJl92tFNBWHmn1NVrKy2nVyQtW3
         qMYHKH1OJ36GvPG7e/gLJ8frN3zO0oRsdJevrffbeu7zgsPPHWPcRbFu31cv7MublW66
         sC77OMrDlOkhH7t+E/o7jC1nXxaaqVlloDIcai7nhrZfw/62vb1JdNZYog8JQkPPl0vu
         xAHA==
X-Gm-Message-State: AOAM532gRytwbgLowojC+oC0vbMdOfUUtCXXeXlDmVbZwtVSQxO0eKwt
        /VwH2rqL9XTkvJpf/JZhPfW/7QXj7XTkQ9NjFVs=
X-Google-Smtp-Source: ABdhPJxpb/ukSW3BtDrH/mQU2isMxd4g390WY6v6LQsg3UqFwHJueUlapMsF+ouMRujJ/pebfVVWjFa6dw09jDekpJU=
X-Received: by 2002:a17:907:6d8a:b0:6fe:1b36:dfcc with SMTP id
 sb10-20020a1709076d8a00b006fe1b36dfccmr19071735ejc.579.1652886228719; Wed, 18
 May 2022 08:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220509050953.11005-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220509050953.11005-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <CACRpkdafrkyQjmyoa4CAJXJ8JdT3owapq10=yBQLyPp0EwO6AQ@mail.gmail.com>
In-Reply-To: <CACRpkdafrkyQjmyoa4CAJXJ8JdT3owapq10=yBQLyPp0EwO6AQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 May 2022 17:03:07 +0200
Message-ID: <CAHp75VdFuV_vSvJMjuOn9+CewXXJjfxOYw6gVhmX_gwSC2R6mg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] gpio: gpiolib: Add ngirq member to struct gpio_irq_chip
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
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

On Sat, May 14, 2022 at 4:14 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, May 9, 2022 at 7:10 AM Lad Prabhakar
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

> As mentioned in some other patch, try to use .valid_mask for this instead.

I have not been Cc'ed, but briefly reading I agree with Linus.

-- 
With Best Regards,
Andy Shevchenko
