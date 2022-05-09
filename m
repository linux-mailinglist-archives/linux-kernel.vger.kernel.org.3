Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF0751F844
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238014AbiEIJeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238319AbiEIJOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:14:17 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9321572B;
        Mon,  9 May 2022 02:10:24 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id z126so10288762qkb.2;
        Mon, 09 May 2022 02:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CgQLbQVdIN14SPt3YzwHXDrfh8JRKAmJocLk5KwR+yk=;
        b=CoM3Jn0gY4RTQLUh5mul6q4k1LbmPG7Xf2bLFJAhTx7kGLie8eWTqnko4hlHCMDCiy
         0zo+vLGC3IALXPbB5lWNjV3SXDjJmoMuFUt9daucrQQ5028/LA4qxs8velATTuGiH3W0
         65x38TBN5dfliT4mPQRDZXLsEub292mzuYA8xCaho8SOVyK2FGBHNpWCe9Rg87HVl9lC
         rbNiTm728F5F+SoqirChKn5S7qRR7lMBWcP2C0uEtjGGUUrTpBQHPulSakNWA5YwX9Az
         whINVSLUA9B9AB0o/gMRHKpPzrdUa+U/bHb/JqCxpt2OjrE3Zuiz+eYckHhtqpPa8+c2
         GUXA==
X-Gm-Message-State: AOAM530xVfcw4GbNgMdzlaTn6SBby29Vra/bJZCYfNIpoIXr23XESmQb
        hnS2MJgz3ivBXS1+Y/cWZQB0a/WNVKAnzw==
X-Google-Smtp-Source: ABdhPJxdc3uoOtr8jzAZ5g6dgVL6PCn7gBiAhbUBMVoPz6Umt8CKVTgCfE51/93MENuFL2EYnUzhog==
X-Received: by 2002:a05:620a:444e:b0:6a0:68da:2105 with SMTP id w14-20020a05620a444e00b006a068da2105mr5045212qkp.366.1652087423153;
        Mon, 09 May 2022 02:10:23 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id d5-20020ae9ef05000000b0069fc13ce1ebsm6504891qkg.28.2022.05.09.02.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 02:10:22 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2f7b815ac06so136900937b3.3;
        Mon, 09 May 2022 02:10:22 -0700 (PDT)
X-Received: by 2002:a81:547:0:b0:2f8:6e8:19d7 with SMTP id 68-20020a810547000000b002f806e819d7mr13589711ywf.383.1652087422113;
 Mon, 09 May 2022 02:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220509050953.11005-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220509050953.11005-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <OS0PR01MB5922B58BB70B92813041745786C69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922B58BB70B92813041745786C69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 May 2022 11:10:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVuLq1Q2KB7gFQ5MsQmyUTv4yuu-GUBVn_xGwKhUwYQZg@mail.gmail.com>
Message-ID: <CAMuHMdVuLq1Q2KB7gFQ5MsQmyUTv4yuu-GUBVn_xGwKhUwYQZg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] irqchip: Add RZ/G2L IA55 Interrupt Controller driver
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 9, 2022 at 9:22 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > Subject: [PATCH v2 2/5] irqchip: Add RZ/G2L IA55 Interrupt Controller
> > driver
> >
> > Add a driver for the Renesas RZ/G2L Interrupt Controller.
> >
> > This supports external pins being used as interrupts. It supports one line
> > for NMI, 8 external pins and 32 GPIO pins (out of 123) to be used as IRQ
> > lines.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

> > --- /dev/null
> > +++ b/drivers/irqchip/irq-renesas-rzg2l.c

> > +static void rzg2l_irqc_irq_disable(struct irq_data *d) {
> > +     unsigned int hw_irq = irqd_to_hwirq(d);
> > +
> > +     if (hw_irq >= IRQC_TINT_START && hw_irq <= IRQC_TINT_COUNT) {
> > +             struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
> > +             u32 offset = hw_irq - IRQC_TINT_START;
> > +             u32 tssr_offset = TSSR_OFFSET(offset);
> > +             u8 tssr_index = TSSR_INDEX(offset);
> > +             u32 reg;
> > +
> > +             raw_spin_lock(&priv->lock);
> > +             reg = readl_relaxed(priv->base + TSSR(tssr_index));
> > +             reg &= ~(TSSEL_MASK << tssr_offset);
> > +             writel_relaxed(reg, priv->base + TSSR(tssr_index));
> > +             raw_spin_unlock(&priv->lock);
> > +     }
> > +     irq_chip_disable_parent(d);
> > +}

> > +static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type) {
> > +     struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
> > +     unsigned int hwirq = irqd_to_hwirq(d);
> > +     u32 titseln = hwirq - IRQC_TINT_START;
> > +     u32 offset;
> > +     u8 sense;
> > +     u32 reg;
> > +
> > +     switch (type & IRQ_TYPE_SENSE_MASK) {
> > +     case IRQ_TYPE_EDGE_RISING:
> > +             sense = TITSR_TITSEL_EDGE_RISING;
> > +             break;
> > +
> > +     case IRQ_TYPE_EDGE_FALLING:
> > +             sense = TITSR_TITSEL_EDGE_FALLING;
> > +             break;
> > +
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
>
> > +     if (titseln < TITSR0_MAX_INT) {
> > +             offset = TITSR0;
> > +     } else {
> > +             titseln /= TITSEL_WIDTH;
> > +             offset  = TITSR1;
> > +     }
>
> as TITSR0 (0x24) and TITSR1(0x28) are contiguous address location
>
> May be like others, above declare it as
> u32 offset = TITSR0; ??
>
> and here
>  if ((titseln >= TITSR0_MAX_INT) {
>         titseln /= TITSEL_WIDTH;
>         offset  += 4;
>  }

Why "titseln /= TITSEL_WIDTH"?
Shouldn't that be "titseln -= TITSR0_MAX_INT"?
Do I need more coffee?

Can't you define TITSR_{OFFSET,INDEX}() helper macros, like for
TSSR above?

> > +
> > +     raw_spin_lock(&priv->lock);
> > +     reg = readl_relaxed(priv->base + offset);
> > +     reg &= ~(IRQ_MASK << (titseln * TITSEL_WIDTH));
> > +     reg |= sense << (titseln * TITSEL_WIDTH);
> > +     writel_relaxed(reg, priv->base + offset);
> > +     raw_spin_unlock(&priv->lock);
> > +
> > +     return 0;
> > +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
