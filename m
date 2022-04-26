Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17334510C31
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 00:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355909AbiDZWrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 18:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245546AbiDZWra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 18:47:30 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1403187465
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:44:21 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bq30so142018lfb.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aXOC4nDMiIs3BeNgSghO3FPGiSBBxD4qpt6pgqjnGUI=;
        b=jvpS8bvU9PLdLoEDuJacmDvv9VyAl3CUbIROrGU2Neuq8zRwG8M5IRUZ8GpaWUYRF3
         qhcjUPsT4JgE/tDIampjBsPkgiT/Kt0kkrxjQlHrn2YvPGqHQ9oo+FhaH3uZbT5PtRfD
         PchXV7r3Ezh9tHTkfb4wpODQwTX8Xvcmgp54iiCJJ4eVOkdGEKlJHFj9V6A2YI+8Cc+6
         CIQkwwxw3eRE88dImmGGj4d4uB1xoAk7GC7NLdRzk8v9kun7rLZUaoHVRMI8DT3pIs3d
         ruO5t1/ZTNLWbQZ9XY8VRIGpwIguOuPPqFVuhgyxo+hgzTdc1eVV3TcGTt3UNAUZSHJF
         Gpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aXOC4nDMiIs3BeNgSghO3FPGiSBBxD4qpt6pgqjnGUI=;
        b=Wp49PWK83QxyZaP89cysqi/sFde92ekfA9s5ictpVRfGBlU2QZYa+dAjGCuBNTE0m/
         D4PwiZqFToNbEL7e5HLwdiPJz4X8R+eUyeiA5yN2pPpiRoGHut71VtB8CbfhIb+EOVvf
         fdYqKGdrSUl0vrJ0CsYFgnrd7R9QWTbq7BCsIsge0xVuoT8A6+j2gbtfpaINWuEMIl49
         hCtazWzu1P/GCqyycUk/l23cRAJMhLukczGCrHEpKb8FFQ/yUphUCy4GvJHy/zFVoEhc
         DwxRy+i/T8osYj85oPSG2SOmqoXdZINLvqpSl+NQf35Y4Qikyn6lZrqkbC6HAEIAqjkr
         Uygw==
X-Gm-Message-State: AOAM533XF5D0ZWFEK3A8ycKUyHZvJwoT+orqhvR3XDpifnEr6zKfui89
        QOOqW+18bfomSbAdxc3Eai6YQTMXnD57GmUt0t253A==
X-Google-Smtp-Source: ABdhPJxeSl4Wwg6V6lU3GZfaobtTNr9O89vfLZomCPWfsjbhq4M5MMUvz7K0JQVLxm60gHak7PYn2eXZ+lRcOrqapQk=
X-Received: by 2002:a05:6512:301:b0:471:ecd0:ea24 with SMTP id
 t1-20020a056512030100b00471ecd0ea24mr15273491lfp.71.1651013060082; Tue, 26
 Apr 2022 15:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220424090422.97070-1-wanjiabing@vivo.com> <CAPDyKFreW44ou8O4R53XUf7iZTGBBMM+1jmrOeh9cyEOTU-r1Q@mail.gmail.com>
 <YmgKa4xQ+pOd2xfh@myhostname>
In-Reply-To: <YmgKa4xQ+pOd2xfh@myhostname>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 Apr 2022 00:43:42 +0200
Message-ID: <CAPDyKFp38EKC88wGZyYm3agvY9zC2M6-qAgMqmOHne0kkDAhCg@mail.gmail.com>
Subject: Re: [PATCH] mmc: atmel-mci: simplify if-if to if-else
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 at 17:06, Wan Jiabing <wanjiabing@vivo.com> wrote:
>
> On Tue, Apr 26, 2022 at 03:53:09PM +0200, Ulf Hansson wrote:
> > On Sun, 24 Apr 2022 at 11:04, Wan Jiabing <wanjiabing@vivo.com> wrote:
> > >
> > > Use if and else instead of if(A) and if (!A).
> > >
> > > Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> > > ---
> > >  drivers/mmc/host/atmel-mci.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> > > index 807177c953f3..98893ccad4bd 100644
> > > --- a/drivers/mmc/host/atmel-mci.c
> > > +++ b/drivers/mmc/host/atmel-mci.c
> > > @@ -1125,8 +1125,7 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
> > >         chan = host->dma.chan;
> > >         if (chan)
> > >                 host->data_chan = chan;
> > > -
> > > -       if (!chan)
> > > +       else
> > >                 return -ENODEV;
> >
> > To make a slightly better improvement of the code, I suggest we add an
> > early bail out point in the atmci_prepare_data_dma() function. Like
> > below:
> >
> > if (!host->dma.chan)
> >      return -ENODEV;
> >
> > [...]
> >
> > Kind regards
> > Uffe
>
> OK
>
> How about this new patch?

Please post a new version in plain text, not as an attachment.

Kind regards
Uffe
