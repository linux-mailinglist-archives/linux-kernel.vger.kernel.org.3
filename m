Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1443534969
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 05:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244552AbiEZDpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 23:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243945AbiEZDoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 23:44:54 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D30E021
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 20:44:53 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id t26so973971ybt.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 20:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vqm3/hRG3VFupBjNaowrJsn6+8n6Q/MlLgSOykyM6ao=;
        b=Rdq2EDWfNjlToyu3i1KDJ36brOAsakHrEl5hcbEJW4eAVWWqGU5/rq7y16zc+SnLqv
         EBdnVR4v6xa2tT9ESLo03C2WPDqbq/12c/p/kexJ45pBO+8F5WDQ3vLLNCSNNaiORzOT
         AcD5dF769nRhCOkWZZHrJTE2EYG4tDmvV6qb1I0JK0ZpUjMswYvuofbV67+YfgRLX4C+
         djdwO4HQIgLIsTdda/Hz6wKgnwczBQM9jJNIPpUJInA/t7IpAgBeypMGO6U3sSVtc+Q3
         Jo7mi4SaZCTzOdKJSaYGEpN6ugpfu3EeV831yONPtoIqI5BMGk3V27qrxieEis+/dS7r
         y82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vqm3/hRG3VFupBjNaowrJsn6+8n6Q/MlLgSOykyM6ao=;
        b=huTkFAT7GMkxABBlRhv/r12CvqRh70sd0PPjsMEsEjrOIJuwczw9xF9idkpA5/2nHL
         A+7HjPT+nQ+ZpkyJjaKvBAxAsKhImA3mlr5terjasXHDvlhep9AfE06257BfWpvtcutN
         LG5A7Aypah4NU3WNCqiZIx2drcQlhh0h8MCd1JZRBRUJq9gJRzCtIpsQU7InFXZdqoff
         bTOClVnz7E7YFIjhM5BH4R5XAcxrC2jLmjt6A1+Uumx22RkzgeCZ2NErcWRKOvgRPAK1
         JPUPOIYQn6rYpK1wzTyjVTwr73UEboThLN5XwO3r+Y+EkhnhSggBRSvIy01+fhDMRFGF
         BI1A==
X-Gm-Message-State: AOAM5305yCZqYOWJjn1i8UamqAHhTcmRUwbl1/Goig3b2+YEYj3j+sCx
        aFuNIVlWVotEjpE5gENlFgeMlN7Zud6up7vfAzCgWTFMvKc=
X-Google-Smtp-Source: ABdhPJwrr5Izo/sSMvdH5Mj96mptxHwIoJU9RuKzu2xD4OWsbCBPcWuumUFcAT2RC1OmCOl7pEZQKaKvh4d8sdoLLRE=
X-Received: by 2002:a25:c8c6:0:b0:651:2cb7:138d with SMTP id
 y189-20020a25c8c6000000b006512cb7138dmr12199396ybf.524.1653536692766; Wed, 25
 May 2022 20:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAJNi4rNwPQf747UM_hiYYwL=HDxg8QnPpfFPv1PfrtN9ZP1y1g@mail.gmail.com>
 <35f95ba3-8a7b-7918-0f9d-e14274a5ffe9@arm.com>
In-Reply-To: <35f95ba3-8a7b-7918-0f9d-e14274a5ffe9@arm.com>
From:   richard clark <richard.xnu.clark@gmail.com>
Date:   Thu, 26 May 2022 11:44:41 +0800
Message-ID: <CAJNi4rMbBbLP2Tsv-wnnJKt4Y0moOE5-sNaZN1fCty908pwAKw@mail.gmail.com>
Subject: Re: Question about SPIs' interrupt trigger type restrictions
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     maz@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 3:14 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-05-25 11:01, richard clark wrote:
> > Hi Marc,
> >
> > For below code snippet about SPI interrupt trigger type:
> >
> > static int gic_set_type(struct irq_data *d, unsigned int type)
> > {
> >          ...
> >          /* SPIs have restrictions on the supported types */
> >          if ((range =3D=3D SPI_RANGE || range =3D=3D ESPI_RANGE) &&
> >              type !=3D IRQ_TYPE_LEVEL_HIGH && type !=3D IRQ_TYPE_EDGE_R=
ISING)
> >                  return -EINVAL;
> >          ...
> > }
> >
> > We have a device at hand whose interrupt type is SPI, Falling edge
> > will trigger the interrupt. But the request_irq(50, handler,
> > IRQ_TYPE_EDGE_FALLING, ...) will return -EINVAL.
> >
> > The question is, why must the SPI interrupt use IRQ_TYPE_EDGE_RISING
> > instead of IRQ_TYPE_EDGE_FALLING?
>
> Because that's what the GIC architecture[1] says. From section 1.2.1
> "Interrupt Types":
>
> "An interrupt that is edge-triggered has the following property:
>         =E2=80=A2 It is asserted on detection of a rising edge of an inte=
rrupt signal

This rising edge detection is not true, it's also asserted by falling
edge, just like the GICD_ICFGR register says:
Changing the interrupt configuration between level-sensitive and
*edge-triggered (in either direction)* at a time when there is a
pending interrupt ..., which
has been confirmed by GIC-500 on my platform.

> and then, regardless of the state of the signal, remains asserted until
> the interrupt is acknowledged by software."
>
> External signals with the wrong polarity may need external logic to

IMO, it's not wrong polarity for a device to interrupt the processor
with a falling edge, it's normal. Actually, the GIC supports
edge-trigger type:
'0b10 Corresponding interrupt is edge-triggered', the
IRQ_TYPE_EDGE_RISING check in gic_set_type(...) is just a sanity check
from this point of view.
I would more like to have below changes applied:

--- a/linux/drivers/irqchip/irq-gic-v3.c
+++ b/linux/drivers/irqchip/irq-gic-v3.c

@@ -560,8 +560,7 @@ static int gic_set_type(struct irq_data *d,
unsigned int type)
                return type !=3D IRQ_TYPE_EDGE_RISING ? -EINVAL : 0;
        /* SPIs have restrictions on the supported types */
-       if ((range =3D=3D SPI_RANGE || range =3D=3D ESPI_RANGE) &&
-           type !=3D IRQ_TYPE_LEVEL_HIGH && type !=3D IRQ_TYPE_EDGE_RISING=
)
+       if ((range =3D=3D SPI_RANGE || range =3D=3D ESPI_RANGE) && !(type &=
 0xf))
                return -EINVAL;

 I believe irq-gic.c has the same issue, but can't confirm now.


> invert them (which might even be offered by the GIC implementation
> itself, e.g. [2]), but the programmer's model neither knows nor cares
> about such details, it only knows notions of "edge-triggered" and
> "level-sensitive", where from its point of view the asserted states are
> rising and high respectively.
>
> Robin.
>
> [1] https://developer.arm.com/documentation/ihi0069/latest
> [2]
> https://developer.arm.com/documentation/100336/0106/components-and-config=
uration/spi-collator/spi-collator-wires?lang=3Den
