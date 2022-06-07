Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD05353F35B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 03:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbiFGB3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 21:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbiFGB3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:29:19 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D37CBA9BF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 18:29:18 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id v22so28692031ybd.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 18:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wJwmp6spnUjQkhhiamdKsg4SXfwUBxWG4lL2YAhhnLY=;
        b=VxeKhLGTspyCx4OOQouN+Yp2hXQCxX7YUuplsl+3dE+XNvihRZg//o+pvU06ojycKK
         LlmrJvQea/aHOansTHEyUhUNNNpNiLBCm5j8z8bVBvhDeXQCbW2l1h5hkT8h++eZQyaG
         K6eQq1rXl9L5u/dJVXw72pjJryg6zWn6wHb8pf02vTDL/JjhjqXdLGES5Sq1yU+Cg2CJ
         /O13BCLfDnSXYOyz+s2mRavdpHkx9WLX+Z8nELXlv2NkGrH4vDxHKsGc/CRgsJCUg1Ke
         khWCPGToQC0UsnnjhpKfP/xqMHAG0uS4Yl81QCWRuM9kwAdX4w4AElpL0ystkrFdmFgW
         mxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wJwmp6spnUjQkhhiamdKsg4SXfwUBxWG4lL2YAhhnLY=;
        b=SUsjKm+oUT1o2M4UMfvDZmA5/zUME/0FMkNBzVNpS7JE7HVgGFDmgiVbhNju3nGaJP
         XtrM7PnlNOGoBYIne89SM6K99kPgcefNi0tXSAlROyKdEcTrtym7f9FtwT3ixU0p4KqM
         bPplWmGG83lYQJdzA+1pd70qG5THGw/S17W6kdg6m9K4ds09xcFkpArx8aZ7F7SGI9eR
         j0/43y097VNex3ZLB9EHsK+e6k8TgLyKLkUqNu9d0AJnsCsSGuh3TUjUkZuL7lVVMq7z
         10xv4F4qAy/dslmzQejLALo5Rq4IYIA+lBh7tYG93p0H+/VreHQiTzLLHcmeKB1iV6nX
         ROdw==
X-Gm-Message-State: AOAM532StrxqwlMQhTr945n4qYaBo+AvaIx8fiBEuleVRshiekybIOsE
        sHjrf/aAoYo4NyvHCs0pYLCIo5PG3TbiSQCabIM=
X-Google-Smtp-Source: ABdhPJzwt+YPl5SwabT25UuX88Df96Yq1AxfZ64vge9Zxb2NRbCttFlNqSHbmm/u24MOyj413MnQUvkYJbnMeMdcl80=
X-Received: by 2002:a25:dbc8:0:b0:65b:7bc1:679f with SMTP id
 g191-20020a25dbc8000000b0065b7bc1679fmr28156426ybf.510.1654565357597; Mon, 06
 Jun 2022 18:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAJNi4rNwPQf747UM_hiYYwL=HDxg8QnPpfFPv1PfrtN9ZP1y1g@mail.gmail.com>
 <35f95ba3-8a7b-7918-0f9d-e14274a5ffe9@arm.com> <CAJNi4rMbBbLP2Tsv-wnnJKt4Y0moOE5-sNaZN1fCty908pwAKw@mail.gmail.com>
 <87ee0gn5rq.wl-maz@kernel.org> <CAJNi4rOHYqL8jN5Ju3ndANc-5Te4WEc-z5YGxCN-2ZtN8vf1cQ@mail.gmail.com>
 <20220530084039.7rjjbm4gkplg5747@maple.lan> <CAJNi4rNBXs4mwv2dsR+DrV9Of6_eb3Wm3FAJxZsWv5LHnVmVxQ@mail.gmail.com>
 <20220606100848.ir4bkj5qsskxe6in@maple.lan>
In-Reply-To: <20220606100848.ir4bkj5qsskxe6in@maple.lan>
From:   richard clark <richard.xnu.clark@gmail.com>
Date:   Tue, 7 Jun 2022 09:29:06 +0800
Message-ID: <CAJNi4rPKbkqws6FvB66SaOR82LVHJo3F9DA6Q8SX4D2waiaieg@mail.gmail.com>
Subject: Re: Question about SPIs' interrupt trigger type restrictions
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Marc Zyngier <maz@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        s32@nxp.com, leoyang.li@nxp.com, catalin-dan.udma@nxp.com,
        bogdan.hamciuc@nxp.com, bogdan.folea@nxp.com,
        ciprianmarian.costea@nxp.com, radu-nicolae.pirea@nxp.com,
        ghennadi.procopciuc@nxp.com
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

On Mon, Jun 6, 2022 at 6:08 PM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Sun, Jun 05, 2022 at 08:03:02PM +0800, richard clark wrote:
> > On Mon, May 30, 2022 at 4:40 PM Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > >
> > > On Thu, May 26, 2022 at 08:09:32PM +0800, richard clark wrote:
> > > > CC'ing some nxp guys for the S32G274A SOC...
> > > >
> > > > On Thu, May 26, 2022 at 2:54 PM Marc Zyngier <maz@kernel.org> wrote:
> > > > > richard clark <richard.xnu.clark@gmail.com> wrote:
> > > > > > On Thu, May 26, 2022 at 3:14 AM Robin Murphy <robin.murphy@arm.com> wrote:
> > > > > > > On 2022-05-25 11:01, richard clark wrote:
> > > > > From the GIC500 r1p1 TRM, page 2-8:
> > > > >
> > > > > <quote>
> > > > > SPIs are generated either by wire inputs or by writes to the AXI4
> > > > > slave programming interface.  The GIC-500 can support up to 960 SPIs
> > > > > corresponding to the external spi[991:32] signal. The number of SPIs
> > > > > available depends on the implemented configuration. The permitted
> > > > > values are 32-960, in steps of 32. The first SPI has an ID number of
> > > > > 32. You can configure whether each SPI is triggered on a rising edge
> > > > > or is active-HIGH level-sensitive.
> > > > > </quote>
> > > > >
> > > > > So I have no idea what you are talking about, but you definitely have
> > > > > the wrong end of the stick. Both the architecture and the
> > > > > implementations are aligned with what the GIC drivers do.
> > > >
> > > > What I am talking about is - The SPI is triggered on a rising edge
> > > > only, while the falling edge is not as the document says. But I've
> > > > observed the falling edge does trigger the SPI interrupt on my
> > > > platform (the SOC is NXP S32G274A, an external wakeup signal with high
> > > > to low transition to wake up the SOC - 'Wakeup/Interrupt Rising-Edge
> > > > Event Enable Register (WIREER)' and 'Wakeup/Interrupt Falling-Edge
> > > > Event Enable Register (WIFEER)', WIFEER set 1 and WIREER  set 0
> > > > works).
> > > >
> > > > I don't know why the GIC has such a behavior and what the subtle
> > > > rationale is behind this, so just mark this as a record...
> > >
> > > Are you really describing the GIC behaviour here? It sounds like you are
> > > describing the behaviour of the Wakeup Unit.
> >
> > Definitely it's behavior of GIC, not WKPU's
>
> I don't understand what evidence you are basing this on. Everything you
> say below contradicts this assertion.

Ah, I think we're not on the same page here before

>
>
> > > The SPI that goes to the GIC is the *output* of the WKPU. However the
> > > registers you mention above all control edge detection at the input to
> > > the WKPU. If so, the kernel would need an WKPU irqchip driver in order
> > > to manage the trigger mode registers above (and to clear them).
> >
> > external wakeup signal has a transition from High to Low to the SOC,
> > then output of WIREER (rising detect) or WIFEER(falling detect) to
> > generate INTID to the GIC, you have to enable WIFEER to generate the
> > IRQ signal to the GIC which is also an evidence that the external
> > wakup is falling edge.
>
> That's what I mean.
>
> How can you reason about the behaviour of the GIC when every
> observation you make is based on the behaviour of a second level
> interrupt controller (the WKPU)?
>
> I have no doubt you are observing a falling edge being delivered to the
> SoC... but that falling edge is *not* delivered to the GIC; it is
> delivered to the WKPU.
>
> The WKPU then delivers an active-high signal to the GIC.

but now I understand and agree with you that the output from the WKPU
to the GIC is different with the external wakeup of the SOC, but
please note that even with the
IRQ_TYPE_EDGE_RISING to pass the sanity check, the final value
programmed into the trigger mode register(GICD_ICFGR) of GIC is still
the edge-triggered, you can't tell it's falling or rising because that
register is just distinct as *edge* or *level*, definitely it's not
active-high. Since the SOC likes a blackbox we can't tell it's a
falling or rising edge, the only clue is come from the WKPU interrupt
generation block diagram from the NXP S32G274A RM, I reason that the
final signal output from the WKPU to the GIC is still same as the
external one.
>
> > With this clear *falling edge*, I have to
> > write the below irq_request code as:
> >
> >   request_irq(50, wkup12_interrupt, IRQ_TYPE_EDGE_RISING...)
> >
> > IMO, this is very weird because the wakeup signal is falling edge from
> > the point of SOC/GIC side, but I have to name it as
> > *IRQ_TYPE_EDGE_RISING*, but it works just to pass the sanity
> > check(although I think which is not necessary as the fact shows)
>
> It is indeed very weird.
>
> However it is not the falling edge from the SoC/GIC side that makes it
> weird! In fact there is *not* a falling edge from the SoC *and* the GIC
> because they are not the same thing.

'Not the same thing' doesn't mean it has to be different

> There is a secondary interrupt
> controller between the SoC pin and the GIC which inverts the logic (and
> also obviates any need to deploy the GIC's edge detection features at
> all... IMHO the GIC trigger mode should be active high).
I don't think there's a interrupt controller between SOC WKPU and GIC,
all the WKPU interrupt related does is to *detect* the external
signal(falling/rising) and route to the GIC
>
> Instead, I think the reason your code is weird is because the irqchip
> driver for the WKPU is missing or broken. A secondary interrupt
> controller requires an irqchip driver or you will end up with pieces of
> the interrupt controller management code (e.g. weird pokes to the WKPU
> to acknowledge things) appearing in all manner of inappropriate places.
>
Again, no so-called second irq-chip except the GIC within the SOC.
For me, the most important thing is WHY the GIC only support the
rising edge just as its document said.
>
> > > PS I can't find any sign of a WKPU driver in the mainline kernel and
> > >    AFAICT this would make wake up sources unusable. What kernel have
> > >    you been running your experiments on?
> >
> > 5.10.44- BSP code from NXP:
> > https://source.codeaurora.org/external/autobsps32/linux
>
> Given you are running a vendor kernel I think you need to discuss this
> with that vendor's support channels. To stop your code being weird then
> you need to obtain (or implement) an irqchip driver for the WKPU.
>
>
> Daniel.
