Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF22533BF1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 13:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237897AbiEYLq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 07:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiEYLq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 07:46:57 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084F4A205D;
        Wed, 25 May 2022 04:46:56 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id 14so10934912qkl.6;
        Wed, 25 May 2022 04:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZEhsrnmH5bWQhJRb1s8S6ZF7bqzQ8zLRH/dG9jf2XA=;
        b=K9Fo8fHT99W64Tq5wMXujUQrygiKt2jwC2LYB/Fp8IdjGUmuXlW4vD0vPrM2NdebCv
         SvNe0lUZ2wyva4VCvgamnhIuFEq/WgrzwshnvZR5urJlBmIxCqhcxcgVZYaC/9bT+3e8
         9J6WAyvSKoUfihvE8lnUOigIrVxmeO+ak/WhnII3SfsDxwwz6bUBA9ggP0p0ThixruQ+
         H2I2So/tpWAtHDlSiQayORN+eNfBsa2yBGEPAVHZcIoXDjJ/55l7R+MxcdsEjiUNH0t7
         l5ULZqqgTfyslsTwPKAD2HGPih11uY+LeZ9avjcNBnXUtPm0/aG3ybTk8QWTzDr1t2UM
         4UBQ==
X-Gm-Message-State: AOAM530XH4yyzR3p8zp1jTebJ4XOmFADJ2TBIfFUECR3+z+cTkatuGJm
        ojlk3q70syppEdCXWLPb4QsCy+EcXfbVUQ==
X-Google-Smtp-Source: ABdhPJy9hyEuoLM663LZg350bTUcyi4EkO1tU/6vEupDEENGK1erELD/OY4LeqWx/UvM47rJzoVL5Q==
X-Received: by 2002:a05:620a:400e:b0:6a5:7289:c449 with SMTP id h14-20020a05620a400e00b006a57289c449mr5607610qko.561.1653479214997;
        Wed, 25 May 2022 04:46:54 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id p6-20020a05620a22e600b0069fc13ce250sm1041292qki.129.2022.05.25.04.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 04:46:54 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-300312ba5e2so45534747b3.0;
        Wed, 25 May 2022 04:46:53 -0700 (PDT)
X-Received: by 2002:a81:234b:0:b0:2f8:4082:bbd3 with SMTP id
 j72-20020a81234b000000b002f84082bbd3mr32969304ywj.47.1653479213622; Wed, 25
 May 2022 04:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220524172214.5104-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220524172214.5104-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdX0pqr8pmbX8OfUyTeEwiFGSG5uyP4nLG1LPy7_zzLPbQ@mail.gmail.com>
 <CA+V-a8ubrkDU2B=mJopzFrjhv1nVn5EXZmaprta0oj4p3J_N5Q@mail.gmail.com>
 <CAMuHMdVncBnD25RLLqL2qDFwboPSVvo5faJvamDxPH_wq9r22Q@mail.gmail.com> <CA+V-a8tHfyqJx9YBFX3hJBEKuCbDpminz_4uSLK=MHV7W8-hJg@mail.gmail.com>
In-Reply-To: <CA+V-a8tHfyqJx9YBFX3hJBEKuCbDpminz_4uSLK=MHV7W8-hJg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 May 2022 13:46:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWizSaABqAnwQi-Sa3ceiZV2CnAhiio4aCx_Bd7NvN1NQ@mail.gmail.com>
Message-ID: <CAMuHMdWizSaABqAnwQi-Sa3ceiZV2CnAhiio4aCx_Bd7NvN1NQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] irqchip/sifive-plic: Add support for Renesas
 RZ/Five SoC
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

On Wed, May 25, 2022 at 11:43 AM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Wed, May 25, 2022 at 10:35 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Wed, May 25, 2022 at 11:01 AM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > > On Wed, May 25, 2022 at 9:01 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Tue, May 24, 2022 at 7:22 PM Lad Prabhakar
> > > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > > > The Renesas RZ/Five SoC has a RISC-V AX45MP AndesCore with NCEPLIC100. The
> > > > > NCEPLIC100 supports both edge-triggered and level-triggered interrupts. In
> > > > > case of edge-triggered interrupts NCEPLIC100 ignores the next interrupt
> > > > > edge until the previous completion message has been received and
> > > > > NCEPLIC100 doesn't support pending interrupt counter, hence losing the
> > > > > interrupts if not acknowledged in time.
> > > > >
> > > > > So the workaround for edge-triggered interrupts to be handled correctly
> > > > > and without losing is that it needs to be acknowledged first and then
> > > > > handler must be run so that we don't miss on the next edge-triggered
> > > > > interrupt.
> > > > >
> > > > > This patch adds a new compatible string for Renesas RZ/Five SoC and adds
> > > > > support to change interrupt flow based on the interrupt type. It also
> > > > > implements irq_ack and irq_set_type callbacks.
> > > > >
> > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Thanks for your patch!
> > > >
> > > > > --- a/drivers/irqchip/irq-sifive-plic.c
> > > > > +++ b/drivers/irqchip/irq-sifive-plic.c
> >
> > > > > @@ -163,10 +166,31 @@ static int plic_set_affinity(struct irq_data *d,
> > > > >  }
> > > > >  #endif
> > > > >
> > > > > +static void plic_irq_ack(struct irq_data *d)
> > > > > +{
> > > > > +       struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> > > > > +
> > > >
> > > > No check for RZ/Five or irq type?
> > > That is because we set the handle_fasteoi_ack_irq() only in case of
> > > RZ/Five and it is already checked in set_type() callback.
> > >
> > > > .irq_ack() seems to be called for level interrupts, too
> > > > (from handle_level_irq() through mask_ack_irq()).
> > > >
> > > Right but we are using handle_fasteoi_irq() for level interrupt which
> > > doesn't call mask_ack_irq(). And I have confirmed by adding a print in
> > > ack callback  and just enabling the serial (which has level
> > > interrupts).
> >
> > But handle_fasteoi_irq() is configured only on RZ/Five below?
> > Which handler is used on non-RZ/Five?
> >
> For non RZ/Five, handle_fasteoi_irq() [0] is used for both edge/level
> interrupts.
>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/irqchip/irq-sifive-plic.c?h=next-20220525#n195

Thanks, that was the missing piece!

Due to the new "select IRQ_FASTEOI_HIERARCHY_HANDLERS", I thought
your new call to handle_fasteoi_irq() had to be the first one in this
file...  But that config symbol protects handle_fasteoi_ack_irq(),
not handle_fasteoi_irq().

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
