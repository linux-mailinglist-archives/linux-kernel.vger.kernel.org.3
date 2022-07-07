Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B6156A073
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbiGGKxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbiGGKxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:53:18 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074D657228
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 03:53:18 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ez10so1565906ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 03:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/MdPU7/0LhUESABqOcsJRA8NbvdGq3zsY92OcPiOhSc=;
        b=wEf+WpAM38MWTewyyu9oF3P+XqIq5idiDLfWgfEIJrYheTo8xBuCKSvl9H99kcUTDZ
         kUerrZi0GlhDFjaTQzg544xMdL07XfP77NjR/PlZB66hEvmE08EBIrmso0LEjgVw19QK
         WJeFgRsjGU74J7nz0IKXIXNT2AS9+Nwlfh/Mtwq83/f3f/alfn0rnxEZ3+OjqwEdVywI
         75nAi+HXNi0h5EJBqXBpSBOYZMUgaTOena6exxvQ+vg3ind7cNMS7Nme4F9veyCOAqJd
         xg6fXwSTLm+dpoQxCFDWOMnh2yfVaCCAeNsFXCGAXQqG+ZMfc3SxttsLeGypVm6eHOGf
         wEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/MdPU7/0LhUESABqOcsJRA8NbvdGq3zsY92OcPiOhSc=;
        b=M5ttEcqu+jreLRkUwT7tJruhnyYuXFRG+pm1aDl1eNVyKvskUnWOgeJYlbmV8/QMcF
         duSjQhg2g09No/x6/a5ASBXUgbRJuOHPvrMrgjMt1dX9RV+57EWEcreILjwLXN10mvnz
         qMZBbGUQAKBdbbke4XHUaMAEweIMd0Z6KSc75/9zq4FhAbEkLpabRYeAsJ2P7Iu0Hjqb
         tWeEUpoWC35O8WaErvZO0XH4nrLB2lWF3OsD+aazKTGZq2NIiZA5lo79+7CpomlV76eb
         QiLpdQEtn/Gl6flEaLJmucTkKJUNYQXXnmRgts2kgmoywwi+GVWRxGeymVyqHykYKyvM
         0r0g==
X-Gm-Message-State: AJIora+6Q5lx17is2PhHyswLxSBtyjeLX8AONC+/6HQW5UqjJp3sy6yn
        DXKn75I0f7rcKdxGGHbgWcVKKUDHN+xelbrpn14/Nb/jfseC7g==
X-Google-Smtp-Source: AGRyM1tG+R5xjPewg3TqpK5d5/L3gIH6N57ZzdlDvPbR39hXy+R0tUkD/nSkx2YVxrSf1tB/Ezq9w8FA+u47jlY7iyU=
X-Received: by 2002:a17:907:16a6:b0:726:574d:d31f with SMTP id
 hc38-20020a17090716a600b00726574dd31fmr43051467ejc.514.1657191196466; Thu, 07
 Jul 2022 03:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220612144854.2223873-1-alvin@pqrs.dk> <20220612144854.2223873-2-alvin@pqrs.dk>
In-Reply-To: <20220612144854.2223873-2-alvin@pqrs.dk>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 7 Jul 2022 12:53:05 +0200
Message-ID: <CAG3jFysYKJc3Ar99HsoSri+wxW2=KOdSwwsU9qBpypxrNCMaiQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] drm: bridge: adv7511: fix CEC power down
 control register offset
To:     alvin@pqrs.dk
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Archit Taneja <architt@codeaurora.org>,
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jun 2022 at 16:49, Alvin =C5=A0ipraga <alvin@pqrs.dk> wrote:
>
> From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
>
> The ADV7511_REG_CEC_CTRL =3D 0xE2 register is part of the main register
> map - not the CEC register map. As such, we shouldn't apply an offset to
> the register address. Doing so will cause us to address a bogus register
> for chips with a CEC register map offset (e.g. ADV7533).
>
> Fixes: 3b1b975003e4 ("drm: adv7511/33: add HDMI CEC support")
> Signed-off-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511.h     | 5 +----
>  drivers/gpu/drm/bridge/adv7511/adv7511_cec.c | 4 ++--
>  2 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511.h b/drivers/gpu/drm/b=
ridge/adv7511/adv7511.h
> index 9e3bb8a8ee40..46ae6c0d9aa5 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511.h
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511.h
> @@ -406,10 +406,7 @@ void adv7511_cec_irq_process(struct adv7511 *adv7511=
, unsigned int irq1);
>  #else
>  static inline int adv7511_cec_init(struct device *dev, struct adv7511 *a=
dv7511)
>  {
> -       unsigned int offset =3D adv7511->type =3D=3D ADV7533 ?
> -                                               ADV7533_REG_CEC_OFFSET : =
0;
> -
> -       regmap_write(adv7511->regmap, ADV7511_REG_CEC_CTRL + offset,
> +       regmap_write(adv7511->regmap, ADV7511_REG_CEC_CTRL,
>                      ADV7511_CEC_CTRL_POWER_DOWN);
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c b/drivers/gpu/d=
rm/bridge/adv7511/adv7511_cec.c
> index 399f625a50c8..6d067fa54bea 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
> @@ -347,7 +347,7 @@ int adv7511_cec_init(struct device *dev, struct adv75=
11 *adv7511)
>                 goto err_cec_alloc;
>         }
>
> -       regmap_write(adv7511->regmap, ADV7511_REG_CEC_CTRL + offset, 0);
> +       regmap_write(adv7511->regmap, ADV7511_REG_CEC_CTRL, 0);
>         /* cec soft reset */
>         regmap_write(adv7511->regmap_cec,
>                      ADV7511_REG_CEC_SOFT_RESET + offset, 0x01);
> @@ -374,7 +374,7 @@ int adv7511_cec_init(struct device *dev, struct adv75=
11 *adv7511)
>         dev_info(dev, "Initializing CEC failed with error %d, disabling C=
EC\n",
>                  ret);
>  err_cec_parse_dt:
> -       regmap_write(adv7511->regmap, ADV7511_REG_CEC_CTRL + offset,
> +       regmap_write(adv7511->regmap, ADV7511_REG_CEC_CTRL,
>                      ADV7511_CEC_CTRL_POWER_DOWN);
>         return ret =3D=3D -EPROBE_DEFER ? ret : 0;
>  }
> --
> 2.36.1
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>
