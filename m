Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7900850FFA8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351274AbiDZN5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351228AbiDZN4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:56:54 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A4C15CF61
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:53:46 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id y76so3819213ybe.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ckCZvmbeyyn635mnaKqXxsF4H+ghoyHwVYsC+7BA0B0=;
        b=igwGqJ1N3E7ODSLycDSaVr0WbIXpPlLVINt+CdifwDAJ4gIawXS0nViMwM0ZwMz3cM
         Y4fR5DEtmjMEWumRDWtc4A2/YhCv7x7gKR5KpZZeUJycaCRjTGf9T1tDKw3HDHO92/Cq
         WypqODghI7Sd8bMnc4Jr9OPbxjmKS+4p/vl2XRKZ7E/Xt51ZoyMaNx1ZCNVkqnPdYoIF
         m5umgOdDFSMrF1FGHf8mhUZl+LrEInUPltAY8fuNVAAt5GTePYWc5uYbtvPG7igxz2SU
         by93u6+dbEw46318P4HWU5ZgTv2R08XF+cESh81A43oG2yFIlMBgKK0J52dOiASLqyeC
         tGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ckCZvmbeyyn635mnaKqXxsF4H+ghoyHwVYsC+7BA0B0=;
        b=1xFS+MLTCM6YeErmA/LCgbbGagzJ85Lfv1yb9OVCqr3t8CPZUA98p5hWME6dB3Z9kV
         28TGzmHItsN5KEDhnYx33pufG7hWl7kYMvF7JWP0bhBTf/CXKVdWcLQiJydoefRc571N
         Y31hVCriIVrLbm3Y1H39s/ubp+jw9i/dDcOBhschhH78xVfLUkCko13sc1T8xwiGtMUB
         otf0aItHzwWwbLzQmK+h3gYET7h60eYjN4K3rOC5PAWLOTZeCXYO9Plt8xkad1IOuNun
         no/Dj4xQ+Hq42vAd6RGjOVG+AI3wDyA39GzT8deQff4QTSRvie2JMIrPKHOFJ1JyzYNR
         GehA==
X-Gm-Message-State: AOAM531RV3RHRGKFIgLsXLnqp1oYEoQWTIYfQSE4Fm0xnHloPH1fYSrs
        3aPp20mV7pZvYRxKXLPtD2BFx3gLxzGTwBNBiZWA1g==
X-Google-Smtp-Source: ABdhPJwF18W/ckSAQP+Lb7KRodHA2ZrpGoAfo3MnAwZd2GoH5aVP8IC0RDmP+BEupKkL+maFSkUIUbxWV/ny/0vfhno=
X-Received: by 2002:a25:77c1:0:b0:648:3fb0:d5cf with SMTP id
 s184-20020a2577c1000000b006483fb0d5cfmr13072913ybc.511.1650981225960; Tue, 26
 Apr 2022 06:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220424090422.97070-1-wanjiabing@vivo.com>
In-Reply-To: <20220424090422.97070-1-wanjiabing@vivo.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Apr 2022 15:53:09 +0200
Message-ID: <CAPDyKFreW44ou8O4R53XUf7iZTGBBMM+1jmrOeh9cyEOTU-r1Q@mail.gmail.com>
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

On Sun, 24 Apr 2022 at 11:04, Wan Jiabing <wanjiabing@vivo.com> wrote:
>
> Use if and else instead of if(A) and if (!A).
>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/mmc/host/atmel-mci.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 807177c953f3..98893ccad4bd 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -1125,8 +1125,7 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
>         chan = host->dma.chan;
>         if (chan)
>                 host->data_chan = chan;
> -
> -       if (!chan)
> +       else
>                 return -ENODEV;

To make a slightly better improvement of the code, I suggest we add an
early bail out point in the atmci_prepare_data_dma() function. Like
below:

if (!host->dma.chan)
     return -ENODEV;

[...]

Kind regards
Uffe
