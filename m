Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AB150BA0F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448390AbiDVO22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbiDVO21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:28:27 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1337A5B3C1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:25:34 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c23so11231404plo.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5U1B+r5dI91eemQbNmhtpBG76v/tJF367OhTyEiuJYw=;
        b=aIiFPoXxKaRqwY4PN/p53d++Od8n971gwUb5Qwv32WBGZ1JABPxmiOaa2YJNNpddT9
         jsy45X/7nMzEn3m/hka/6NnPJxXfER6mrL4f/ioq3sc/5cFUINalDi1dH++EsCmEqqQ6
         2/rZaT5xl/Q949cLFCwddI8iYP/9ylb/EcRnFVSCW81TVeXG5VnRM11TgTboXdHa8LLF
         nTO4Mz9qOJlyBhvGeDkea/HHZbMWsdW0EvSQ9M68jC0+RvkN8yxOmVDuSJO7KN1sLZ7l
         YPf9MVT7NqVOsfaDxaVyqmb5PBfe4MjQRRXQdFfzZk9snchZs73vjGhAjJRWhhKPYKJQ
         kS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5U1B+r5dI91eemQbNmhtpBG76v/tJF367OhTyEiuJYw=;
        b=nC7jeShPsc45gNk6drdF2/9+TAfgX56xwBv3SVAUuLmlJ9FEmftyae2V39yI8B+POF
         K53WQYdnZEqT5Iy21K6qJ/X11m0gHd/5uv9lXjSPNOTD48eiuc9b/k6r972pCKOYWnva
         3rWfQ4esVE2VChSDmCI3jv5bvCtRuFF2IoB9wBOdIvbHR1AXxPfWTPDpVo4wKqKOrONq
         YzJuxdKDpPT5w0aaspzCMUsa5zY+8j0ne1XWy+YG6FSKbLLLvMQje+bfLF68K8MG7dEu
         KAx+6IRtGLjDkwDfTm7fH+inohvNRHb9r8ijhvg3LF4F5eTe+izWdnO7l6WXN8+Gwikv
         CB7g==
X-Gm-Message-State: AOAM533yOM/ImPFLUV4ltugqAn2CusNGvnsKDI3JbhcC0TAceGNs/ljy
        353ZZVJhip720twgdQp67G3tRmNLOlHyOT/05IRGug==
X-Google-Smtp-Source: ABdhPJx/OfLk811aAN+8jtFmfQSWVem5/nbH09MwqtRr2Dkk615n62FowreIEGeQZ0W3gmtsFGf/7S96ds0mB32bXhE=
X-Received: by 2002:a17:903:2352:b0:159:3fa:261 with SMTP id
 c18-20020a170903235200b0015903fa0261mr4673732plh.21.1650637533559; Fri, 22
 Apr 2022 07:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220319151016.983348-1-alvin@pqrs.dk> <20220319151016.983348-2-alvin@pqrs.dk>
In-Reply-To: <20220319151016.983348-2-alvin@pqrs.dk>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 22 Apr 2022 16:25:22 +0200
Message-ID: <CAG3jFyuZuf-yoy42iSbsdaxVXQvV69-XVyf-6bT-7LDpRpQhjQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm: bridge: adv7511: enable CEC support for ADV7535
To:     =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Mar 2022 at 16:10, Alvin =C5=A0ipraga <alvin@pqrs.dk> wrote:
>
> From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
>
> Like the ADV7533, the ADV7535 has an offset for the CEC register map,
> and it is the same value (ADV7533_REG_CEC_OFFSET =3D 0x70).
>
> Rather than testing for numerous chip types in the offset calculations
> throughout the driver, just compute it during driver probe and put it in
> the private adv7511 data structure.
>
> Signed-off-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511.h     |  1 +
>  drivers/gpu/drm/bridge/adv7511/adv7511_cec.c | 18 ++++++------------
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c |  5 +++--
>  3 files changed, 10 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511.h b/drivers/gpu/drm/b=
ridge/adv7511/adv7511.h
> index 6a882891d91c..da6d8ee2cd84 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511.h
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511.h
> @@ -335,6 +335,7 @@ struct adv7511 {
>
>         struct regmap *regmap;
>         struct regmap *regmap_cec;
> +       unsigned int reg_cec_offset;
>         enum drm_connector_status status;
>         bool powered;
>
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c b/drivers/gpu/d=
rm/bridge/adv7511/adv7511_cec.c
> index 28d9becc939c..1f619389e201 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
> @@ -21,8 +21,7 @@
>
>  static void adv_cec_tx_raw_status(struct adv7511 *adv7511, u8 tx_raw_sta=
tus)
>  {
> -       unsigned int offset =3D adv7511->type =3D=3D ADV7533 ?
> -                                       ADV7533_REG_CEC_OFFSET : 0;
> +       unsigned int offset =3D adv7511->reg_cec_offset;
>         unsigned int val;
>
>         if (regmap_read(adv7511->regmap_cec,
> @@ -73,8 +72,7 @@ static void adv_cec_tx_raw_status(struct adv7511 *adv75=
11, u8 tx_raw_status)
>
>  void adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1)
>  {
> -       unsigned int offset =3D adv7511->type =3D=3D ADV7533 ?
> -                                       ADV7533_REG_CEC_OFFSET : 0;
> +       unsigned int offset =3D adv7511->reg_cec_offset;
>         const u32 irq_tx_mask =3D ADV7511_INT1_CEC_TX_READY |
>                                 ADV7511_INT1_CEC_TX_ARBIT_LOST |
>                                 ADV7511_INT1_CEC_TX_RETRY_TIMEOUT;
> @@ -118,8 +116,7 @@ void adv7511_cec_irq_process(struct adv7511 *adv7511,=
 unsigned int irq1)
>  static int adv7511_cec_adap_enable(struct cec_adapter *adap, bool enable=
)
>  {
>         struct adv7511 *adv7511 =3D cec_get_drvdata(adap);
> -       unsigned int offset =3D adv7511->type =3D=3D ADV7533 ?
> -                                       ADV7533_REG_CEC_OFFSET : 0;
> +       unsigned int offset =3D adv7511->reg_cec_offset;
>
>         if (adv7511->i2c_cec =3D=3D NULL)
>                 return -EIO;
> @@ -165,8 +162,7 @@ static int adv7511_cec_adap_enable(struct cec_adapter=
 *adap, bool enable)
>  static int adv7511_cec_adap_log_addr(struct cec_adapter *adap, u8 addr)
>  {
>         struct adv7511 *adv7511 =3D cec_get_drvdata(adap);
> -       unsigned int offset =3D adv7511->type =3D=3D ADV7533 ?
> -                                       ADV7533_REG_CEC_OFFSET : 0;
> +       unsigned int offset =3D adv7511->reg_cec_offset;
>         unsigned int i, free_idx =3D ADV7511_MAX_ADDRS;
>
>         if (!adv7511->cec_enabled_adap)
> @@ -235,8 +231,7 @@ static int adv7511_cec_adap_transmit(struct cec_adapt=
er *adap, u8 attempts,
>                                      u32 signal_free_time, struct cec_msg=
 *msg)
>  {
>         struct adv7511 *adv7511 =3D cec_get_drvdata(adap);
> -       unsigned int offset =3D adv7511->type =3D=3D ADV7533 ?
> -                                       ADV7533_REG_CEC_OFFSET : 0;
> +       unsigned int offset =3D adv7511->reg_cec_offset;
>         u8 len =3D msg->len;
>         unsigned int i;
>
> @@ -289,8 +284,7 @@ static int adv7511_cec_parse_dt(struct device *dev, s=
truct adv7511 *adv7511)
>
>  int adv7511_cec_init(struct device *dev, struct adv7511 *adv7511)
>  {
> -       unsigned int offset =3D adv7511->type =3D=3D ADV7533 ?
> -                                               ADV7533_REG_CEC_OFFSET : =
0;
> +       unsigned int offset =3D adv7511->reg_cec_offset;
>         int ret =3D adv7511_cec_parse_dt(dev, adv7511);
>
>         if (ret)
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/d=
rm/bridge/adv7511/adv7511_drv.c
> index 005bf18682ff..0be65a1ffc47 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -1027,8 +1027,7 @@ static bool adv7511_cec_register_volatile(struct de=
vice *dev, unsigned int reg)
>         struct i2c_client *i2c =3D to_i2c_client(dev);
>         struct adv7511 *adv7511 =3D i2c_get_clientdata(i2c);
>
> -       if (adv7511->type =3D=3D ADV7533 || adv7511->type =3D=3D ADV7535)
> -               reg -=3D ADV7533_REG_CEC_OFFSET;
> +       reg -=3D adv7511->reg_cec_offset;
>
>         switch (reg) {
>         case ADV7511_REG_CEC_RX_FRAME_HDR:
> @@ -1073,6 +1072,8 @@ static int adv7511_init_cec_regmap(struct adv7511 *=
adv)
>                 ret =3D adv7533_patch_cec_registers(adv);
>                 if (ret)
>                         goto err;
> +
> +               adv->reg_cec_offset =3D ADV7533_REG_CEC_OFFSET;
>         }
>
>         return 0;

Reviewed-by: Robert Foss <robert.foss@linaro.org>
