Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B43650DCB0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiDYJdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240288AbiDYJcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:32:46 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6040525C54;
        Mon, 25 Apr 2022 02:29:42 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2f7c57ee6feso46807627b3.2;
        Mon, 25 Apr 2022 02:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7DI/4yWN3y1GMnceS1NFP6W+fM0r79CNMIWUatbJf0I=;
        b=GCZuUnp932JxImCO8yyc4Gc8wkN98T+o2cGsdEEVoxF899i6hRCXUz2OVFWzZcrvXj
         76MEiMn2LB4F2TlZBPj1tpYKE1kWpUxpfMjGKbKEaKhvPn61cEgu+MTEtZuig9QuGO8D
         /cbW5lAIiXLyzhZPP0MKrlG/LXT1vBPRYMD18sTaeN5Kk1qRD2vRnDNdyjpz7Gmr1Udb
         UUgkkwngftahjHMpHyW8CdC42noowsLzEFVjhFvf7W+MglaDl1JpoMd+jWVHPMEkFhS4
         iW2ZTI506E3XEKox9qIvbFG2L4CCcmZZMVYO8DC5FYdqtIJAyzaQjfDeHpyP2RL2H5WX
         EhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7DI/4yWN3y1GMnceS1NFP6W+fM0r79CNMIWUatbJf0I=;
        b=BFNN0NZQNht4unU39S23zLc619E7B7esdNZxqIDn2pCIM/HnYBlBMBpKiy+cqj+JVG
         TAKFNOCwL7RInnU6bkMD8s7wyjwPXxGr7R0Nq4h6qtjSS11kpddYj3yFNo6aeJbKweqY
         DtmreEDeEGQ0R0GNBl0oAN+8EKxWohn8xjzaLqueDzkrRZfvbzNozab2vYv/Ni1z5roA
         v4SbmOs3PKs4D8GrrjVRSvBbshyt71tai/dW5RAzoGjrz0mwcSYBl1q/pCXE2kRvY08K
         l3DUfh12oTOwDsfijP+HQY/LpdEXDzxNQJGYhoqwt+7lnYPK0DH2bsCp60fj1gYfgFmN
         SzaA==
X-Gm-Message-State: AOAM533w2NHAHlyYiinh5lNzc54xbB+FH/mbSmjvePqF3CWiFu2sZpfo
        +rWZllzCIAKsTr5rGVd2uP7qp/YfXdqJl/EdKNk=
X-Google-Smtp-Source: ABdhPJzuYw9o/w71YlaAQBnSBo3Oq9wnJmCtC+7inm7LG9vm9W7JrUu2ex+pkxwWlm67/LgyDA1JRGeK+fregfJ01b4=
X-Received: by 2002:a81:6a46:0:b0:2f4:dc3f:e8f8 with SMTP id
 f67-20020a816a46000000b002f4dc3fe8f8mr16106476ywc.292.1650878981595; Mon, 25
 Apr 2022 02:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220421203555.29011-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220421203555.29011-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <OS0PR01MB5922C8287D7EEAB3F9DB60C386F79@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922C8287D7EEAB3F9DB60C386F79@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 25 Apr 2022 10:29:15 +0100
Message-ID: <CA+V-a8uGhUMK11BXQX9e-+8bwaq9Gx_AGHBob1KTiT6Npb-8Rw@mail.gmail.com>
Subject: Re: [PATCH 3/3] ASoC: sh: rz-ssi: Add a devres action to release the
 DMA channels
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Pavel Machek <pavel@denx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
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

Hi Biju,

Thank you for the review.

On Fri, Apr 22, 2022 at 7:52 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Hi Lad Prabhakar,
>
> Thanks for the patch.
>
> > Subject: [PATCH 3/3] ASoC: sh: rz-ssi: Add a devres action to release the
> > DMA channels
> >
> > DMA channels requested by rz_ssi_dma_request() in rz_ssi_probe() were never
> > released in the error path apart from one place. This patch fixes this
> > issue by adding a devres action to release the DMA channels and dropping
> > the single rz_ssi_release_dma_channels() call which was placed in the error
> > path in case devm_snd_soc_register_component() failed.
> >
> > Fixes: 26ac471c5354 ("ASoC: sh: rz-ssi: Add SSI DMAC support")
> > Reported-by: Pavel Machek <pavel@denx.de>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  sound/soc/sh/rz-ssi.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c index
> > d9a684e71ec3..f04da1bf5680 100644
> > --- a/sound/soc/sh/rz-ssi.c
> > +++ b/sound/soc/sh/rz-ssi.c
> > @@ -912,6 +912,11 @@ static const struct snd_soc_component_driver
> > rz_ssi_soc_component = {
> >       .pcm_construct  = rz_ssi_pcm_new,
> >  };
> >
> > +static void rz_ssi_release_dma_channels_action(void *data) {
> > +     rz_ssi_release_dma_channels(data);
> > +}
> > +
> >  static int rz_ssi_probe(struct platform_device *pdev)  {
> >       struct rz_ssi_priv *ssi;
> > @@ -966,6 +971,11 @@ static int rz_ssi_probe(struct platform_device *pdev)
> >               dev_info(&pdev->dev, "DMA enabled");
> >               ssi->playback.transfer = rz_ssi_dma_transfer;
> >               ssi->capture.transfer = rz_ssi_dma_transfer;
> > +
> > +             ret = devm_add_action_or_reset(&pdev->dev,
> > +                                            rz_ssi_release_dma_channels_action,
> > ssi);
> > +             if (ret)
> > +                     return ret;
> >       }
> >
> >       ssi->playback.priv = ssi;
> > @@ -1027,8 +1037,6 @@ static int rz_ssi_probe(struct platform_device *pdev)
> >                                             rz_ssi_soc_dai,
> >                                             ARRAY_SIZE(rz_ssi_soc_dai));
> >       if (ret < 0) {
> > -             rz_ssi_release_dma_channels(ssi);
> > -
>
> Maybe we need to keep this as it is, otherwise DMA channel release will happen
> after CLK disable and Reset assert. Ideally release the channel, disable the clock and assert
> the reset.
>
Ok will move this call to individual error paths.

> Similarly, you may want to add "rz_ssi_release_dma_channels(ssi)" for error path related to
> Pm_runtime_resume_get.
>
yes this needs to go under all error paths except the pio chunk.

>
> Also with this change there is unbalanced release_dma_channels() one from devres and other from remove.
>
Agreed.

Cheers,
Prabhakar

> Regards,
> Biju
>
>
>
> >               pm_runtime_put(ssi->dev);
> >               pm_runtime_disable(ssi->dev);
> >               reset_control_assert(ssi->rstc);
> > --
> > 2.17.1
>
