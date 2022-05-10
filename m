Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154B1520F87
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 10:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237897AbiEJIPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiEJIPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:15:37 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC248AE43;
        Tue, 10 May 2022 01:11:39 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id 185so3209750qke.7;
        Tue, 10 May 2022 01:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uhALeu7x2VWkulby+gfNBCQt8rp7fFwVaYXJL9pXNm0=;
        b=wt8wMIuDjMB7gU1zffk+qKhq0Dqu47nN9ruZfJH6BOtlakLsn53tgFWt6WpKUfmyT2
         pP9xrpknGd6Fk1G7X7QElv432Y/hrQKnycimP25w1rhkbGtHZjADI0kEKr7SIToCiPqQ
         b1APwc75I5AmheWD18cV5+Anm8mSMKC0WDdHdGjNmdyXJzqZx28LGC4X+jEtBG1J89OX
         hy5ZimmHZkXJ21sJbU2tfVS6IxmiuOxqEV5nztq2Ph2PEISLxUiXNxIiX9i18DutzopO
         YZ6Zp+OssF3g0R+V6J4TWAmxnyKpC2eQVOqCL8dLS0nTan0f9rFGrwAGW5YodQbZrnrE
         mmLw==
X-Gm-Message-State: AOAM532TsZlmcPDS/+Df5YjrIis1QEtDUeHh0HNIgT2wJ7khh6hoeItD
        CK0i6/0xB2flwX1TiP9VUJsHT/8L66ejqg==
X-Google-Smtp-Source: ABdhPJyS1rN8w/pK5oYsNJ6Y32WLozIy/jd1LWLGWxbsG0kF0+/qV/kpaiavv8RSFj85offI9wB71g==
X-Received: by 2002:a05:620a:210e:b0:69f:9d3e:3ced with SMTP id l14-20020a05620a210e00b0069f9d3e3cedmr13925529qkl.536.1652170298850;
        Tue, 10 May 2022 01:11:38 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id 191-20020a3705c8000000b0069fc13ce204sm8319786qkf.53.2022.05.10.01.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 01:11:37 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2f7d621d1caso170537987b3.11;
        Tue, 10 May 2022 01:11:37 -0700 (PDT)
X-Received: by 2002:a81:913:0:b0:2f7:c833:f304 with SMTP id
 19-20020a810913000000b002f7c833f304mr18325160ywj.283.1652170296892; Tue, 10
 May 2022 01:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220509050953.11005-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220509050953.11005-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB5922B58BB70B92813041745786C69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdVuLq1Q2KB7gFQ5MsQmyUTv4yuu-GUBVn_xGwKhUwYQZg@mail.gmail.com> <CA+V-a8uG8qzzWj+=6EhzSd5j8NC3bpf=9tU9jgxzK8Cg75BTtw@mail.gmail.com>
In-Reply-To: <CA+V-a8uG8qzzWj+=6EhzSd5j8NC3bpf=9tU9jgxzK8Cg75BTtw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 May 2022 10:11:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU+WprHzht+daRpvF_mYe+b8SoCYhN_F=DhBgn55cAH9Q@mail.gmail.com>
Message-ID: <CAMuHMdU+WprHzht+daRpvF_mYe+b8SoCYhN_F=DhBgn55cAH9Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] irqchip: Add RZ/G2L IA55 Interrupt Controller driver
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
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
        <linux-renesas-soc@vger.kernel.org>
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

Hi Prabhakar,

On Mon, May 9, 2022 at 9:24 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Mon, May 9, 2022 at 10:10 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Mon, May 9, 2022 at 9:22 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > > Subject: [PATCH v2 2/5] irqchip: Add RZ/G2L IA55 Interrupt Controller
> > > > driver
> > > >
> > > > Add a driver for the Renesas RZ/G2L Interrupt Controller.
> > > >
> > > > This supports external pins being used as interrupts. It supports one line
> > > > for NMI, 8 external pins and 32 GPIO pins (out of 123) to be used as IRQ
> > > > lines.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > > > --- /dev/null
> > > > +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> >
> > > > +static void rzg2l_irqc_irq_disable(struct irq_data *d) {
> > > > +     unsigned int hw_irq = irqd_to_hwirq(d);
> > > > +
> > > > +     if (hw_irq >= IRQC_TINT_START && hw_irq <= IRQC_TINT_COUNT) {
> > > > +             struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
> > > > +             u32 offset = hw_irq - IRQC_TINT_START;
> > > > +             u32 tssr_offset = TSSR_OFFSET(offset);
> > > > +             u8 tssr_index = TSSR_INDEX(offset);
> > > > +             u32 reg;
> > > > +
> > > > +             raw_spin_lock(&priv->lock);
> > > > +             reg = readl_relaxed(priv->base + TSSR(tssr_index));
> > > > +             reg &= ~(TSSEL_MASK << tssr_offset);
> > > > +             writel_relaxed(reg, priv->base + TSSR(tssr_index));
> > > > +             raw_spin_unlock(&priv->lock);
> > > > +     }
> > > > +     irq_chip_disable_parent(d);
> > > > +}
> >
> > > > +static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type) {
> > > > +     struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
> > > > +     unsigned int hwirq = irqd_to_hwirq(d);
> > > > +     u32 titseln = hwirq - IRQC_TINT_START;
> > > > +     u32 offset;
> > > > +     u8 sense;
> > > > +     u32 reg;
> > > > +
> > > > +     switch (type & IRQ_TYPE_SENSE_MASK) {
> > > > +     case IRQ_TYPE_EDGE_RISING:
> > > > +             sense = TITSR_TITSEL_EDGE_RISING;
> > > > +             break;
> > > > +
> > > > +     case IRQ_TYPE_EDGE_FALLING:
> > > > +             sense = TITSR_TITSEL_EDGE_FALLING;
> > > > +             break;
> > > > +
> > > > +     default:
> > > > +             return -EINVAL;
> > > > +     }
> > > > +
> > >
> > > > +     if (titseln < TITSR0_MAX_INT) {
> > > > +             offset = TITSR0;
> > > > +     } else {
> > > > +             titseln /= TITSEL_WIDTH;
> > > > +             offset  = TITSR1;
> > > > +     }
> > >
> > > as TITSR0 (0x24) and TITSR1(0x28) are contiguous address location
> > >
> > > May be like others, above declare it as
> > > u32 offset = TITSR0; ??
> > >
> > > and here
> > >  if ((titseln >= TITSR0_MAX_INT) {
> > >         titseln /= TITSEL_WIDTH;
> > >         offset  += 4;
> > >  }
> >
> > Why "titseln /= TITSEL_WIDTH"?
> > Shouldn't that be "titseln -= TITSR0_MAX_INT"?
>
> Ouch, that should be "titseln -= TITSR0_MAX_INT".
>
> > Do I need more coffee?
> >
> > Can't you define TITSR_{OFFSET,INDEX}() helper macros, like for
> > TSSR above?
> >
> you mean a macro to get the TITSELx offset?

Either a macro, or an open-coded calculation (if you need it in only
one place).

As TITSR0 and TITSR1 are stored contiguous, you can easily
derive offset/shift from irq index.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
