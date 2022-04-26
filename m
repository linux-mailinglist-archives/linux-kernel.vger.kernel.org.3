Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC2B50FA4C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348735AbiDZK0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349081AbiDZKYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:24:23 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCB5403C5;
        Tue, 26 Apr 2022 02:55:50 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2f7b90e8b37so98475657b3.6;
        Tue, 26 Apr 2022 02:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=weWPZwTpqiHPHgcVzIIdA7nRDKZOshuGpKa1VF6LHgo=;
        b=Zidjjk277gxvzedd4edYCSb6Cn9K1V3dPeUgbbEb5gLCI8VtvCKz20lBep7DWHtcRQ
         64pJZ8eGC6Q6OP3at/hwyq6ZC82wuELOUdPHx3yLbrMLPYWy3gnKv2HM/+O6/dDwIUgp
         GZc2Y1OoyA47jGPhH2xOV+QqvHguE8F8s7D0CSsTHN8J2VzPWFw2dQVF09lEs2/elM+T
         8y2FFNzKmND94cAR5JpEGVj5911tNu77MIztnM07yFoWADZmH8Dv007sz5BA3dY85iG9
         iH2UqWKuoLVdHr4ugmGiaWErZBjTBujwCDGi9XVP75OAvlAbfqlMBG7dQyByGGAsQqRi
         TD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=weWPZwTpqiHPHgcVzIIdA7nRDKZOshuGpKa1VF6LHgo=;
        b=0styUv2P83iTdagi2F3/9uBADsiW2UlYeJuaA10TEaHSRMI59HVcfavZgqwt4cTanG
         UGdK5dR127Yj61zbRIldeEqFNuDv7fojysMY0TwpQVsIBJitfOglbBM+BjDJxX06AAqq
         BEf1NcXXe8J/s09WyLQolmYcUkv/I8Rof7NXr4s59qnCfZmbaohlFC0H+lw+eggR3rX3
         4PaAHnuBghdpTvVIkEhLwsU3SYe1dT0eucV+Na6V2wE3WR3ekTDYbywhCqmH6Jf63SKk
         FCYk6jX7EdP0oaJAwGcY0SOiejjA6kaA//f/0TcO93WJjtIVRVwXV/T0IdM/E7LGfDta
         qIzw==
X-Gm-Message-State: AOAM532Q4RXoDSEvIPs63pu+UW5ivPcGTB9zXDqztsRJcvpkqzJVnuhk
        KvPqfL7hsPPBBqi88gHvKdIoj5TGGdVn0FNW49c=
X-Google-Smtp-Source: ABdhPJwsCSuWCB3O/ko1vmdn3uUKURlpkvVP2MmwfwdioZMUvlxGbUz6V84fLJ5dZFEpB90VPoxTbMU7pwxUCojYksU=
X-Received: by 2002:a0d:dd16:0:b0:2f4:dc1e:e0d8 with SMTP id
 g22-20020a0ddd16000000b002f4dc1ee0d8mr21532262ywe.413.1650966949989; Tue, 26
 Apr 2022 02:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220426074922.13319-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220426074922.13319-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <5bb82736-50bc-eafd-7d68-df1ed966d572@omp.ru>
In-Reply-To: <5bb82736-50bc-eafd-7d68-df1ed966d572@omp.ru>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 26 Apr 2022 10:55:23 +0100
Message-ID: <CA+V-a8s=7nDHEE=kcdqcyM5SurY9KwteNwnc7PZ4xiqGQFvY=g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ASoC: sh: rz-ssi: Propagate error codes returned
 from platform_get_irq_byname()
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        alsa-devel <alsa-devel@alsa-project.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Pavel Machek <pavel@denx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

Thank you for the review.

On Tue, Apr 26, 2022 at 10:47 AM Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
>
> Hello!
>
> On 4/26/22 10:49 AM, Lad Prabhakar wrote:
>
> > Propagate error codes returned from platform_get_irq_byname() instead of
> > returning -ENODEV. platform_get_irq_byname() may return -EPROBE_DEFER, to
> > handle such cases propagate the error codes.
> >
> > While at it drop the dev_err_probe() messages as platform_get_irq_byname()
> > already does this for us in case of error.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2
> > * No change
> > ---
> >  sound/soc/sh/rz-ssi.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
> > index cec458b8c507..d9a684e71ec3 100644
> > --- a/sound/soc/sh/rz-ssi.c
> > +++ b/sound/soc/sh/rz-ssi.c
> > @@ -977,8 +977,7 @@ static int rz_ssi_probe(struct platform_device *pdev)
> >       /* Error Interrupt */
> >       ssi->irq_int = platform_get_irq_byname(pdev, "int_req");
> >       if (ssi->irq_int < 0)
> > -             return dev_err_probe(&pdev->dev, -ENODEV,
> > -                                  "Unable to get SSI int_req IRQ\n");
> > +             return ssi->irq_int;
>
>    Why not:
>
>                 return dev_err_probe(&pdev->dev, ssi->irq_int,
>                                      "Unable to get SSI int_req IRQ\n");
>
That is because platform_get_irq_byname() already does this for us [0]
(also mentioned in the commit message). In case I keep the
dev_err_probe() I'll get two prints for each error.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/platform.c?h=v5.18-rc4#n471

Cheers,
Prabhakar

> [...]
> > @@ -990,8 +989,7 @@ static int rz_ssi_probe(struct platform_device *pdev)
> >               /* Tx and Rx interrupts (pio only) */
> >               ssi->irq_tx = platform_get_irq_byname(pdev, "dma_tx");
> >               if (ssi->irq_tx < 0)
> > -                     return dev_err_probe(&pdev->dev, -ENODEV,
> > -                                          "Unable to get SSI dma_tx IRQ\n");
> > +                     return ssi->irq_tx;
>
>    Same here...
>
> >
> >               ret = devm_request_irq(&pdev->dev, ssi->irq_tx,
> >                                      &rz_ssi_interrupt, 0,
> > @@ -1002,8 +1000,7 @@ static int rz_ssi_probe(struct platform_device *pdev)
> >
> >               ssi->irq_rx = platform_get_irq_byname(pdev, "dma_rx");
> >               if (ssi->irq_rx < 0)
> > -                     return dev_err_probe(&pdev->dev, -ENODEV,
> > -                                          "Unable to get SSI dma_rx IRQ\n");
> > +                     return ssi->irq_rx;
>
>    And here...
>
> [...]
>
> MBR, Sergey
