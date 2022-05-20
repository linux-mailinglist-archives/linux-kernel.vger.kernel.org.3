Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5486452EB1F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348707AbiETLug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345747AbiETLua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:50:30 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5406015A77A
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:50:29 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id 11so4447378qtp.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iZEBHi6WzsLrPiLUokXbaSvp5d1QJNTLQ47lEV5k7Z0=;
        b=yOon8bz1OOMxbEixXt3P5VbNIXBlEcbwOkaEZeoGByvTd+KkM36CKDnBMvO+I+UtyO
         aUkT7jd5fZy/R+s3xA+6I6/fG4W9ToGMO885GMGEYAcGnsSCYAdq+e/7vyjQG0wlUydN
         K76BOnC1Rd7Ytv/rOgs0I3GZSIvDIh9JYimQ5uUFtp75H8cFosvOBbGRvKyakNys6Qm1
         qEgKBBQhx5o/AQJCOgAY8dRTeZ/1ao8BxTYflcqW3v+VEPMLCeLmUC1h2n+od+8fQDle
         eG3p90Dwz9RAyYoJQU6wZCB9dEcN+TK0oiLRvw8/vlDOYJS2Q27J8oVEwdAWrgeWrSn7
         s5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iZEBHi6WzsLrPiLUokXbaSvp5d1QJNTLQ47lEV5k7Z0=;
        b=MPpymKQ0jL8PGL/7GpztLMIDF7XvaFs3GWSf2ls/1HiXxz33baOhGcjFBVXeHOtOuH
         rAAx2QlEgj8s9xreE68ZBbGPwyPvSdOqpsoDPnSFLJbvRaOZbLNLzC3tt5ADoeji0Y9S
         yIKd8IX/H5BaZRZJsJcKPwwGJR6vJ/OtyPMPOUvzvjuRprnCb3VvYp3zv5TEwKTZ0s2C
         QfASyC7wDT62s/Juy0Hxj94nIzZRnVYcvIWqp8vhQrg2fwybvux0zafHL7kXy0+Aa0qQ
         iP72Okz6NTzTfy8BhoiLRU5Z5X1nuFVTkOBDepYtooDHE274WdxrJwxAlBPTjBULmRf7
         2l5w==
X-Gm-Message-State: AOAM5335ohdmvjlEDIQ1yS2sfCASmrHvM5c+mcD8YWHaruTIdJEFxtFh
        oACk9IdcjT1hjbQkQzhJA+U39e2z7zHiGJ/C3HBXOg==
X-Google-Smtp-Source: ABdhPJwIol1CXrm1YTqhC7kWPjSb0EgtqanlpqQ/2DRk0sShD2Vjaedtz42xmIcmD9Outn3iio+5v/AdPgPNvIHSl5A=
X-Received: by 2002:a05:622a:4f:b0:2f3:e77c:2c7e with SMTP id
 y15-20020a05622a004f00b002f3e77c2c7emr7131500qtw.62.1653047428466; Fri, 20
 May 2022 04:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220520100948.19622-1-johan+linaro@kernel.org> <20220520100948.19622-2-johan+linaro@kernel.org>
In-Reply-To: <20220520100948.19622-2-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 20 May 2022 14:50:17 +0300
Message-ID: <CAA8EJpr3_+iS_ntG0pgfG647Ou4Q60sk+-Roc9GJ-0qM5W710g@mail.gmail.com>
Subject: Re: [PATCH 1/3] clk: qcom: gdsc: add collapse-bit helper
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 May 2022 at 13:10, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> Add a helper for updating the SW_COLLAPSE bit during initialisation and
> state updates.
>


> Note that the update during initialisation was relying on the
> SW_COLLAPSE bit not having been set earlier rather than passing in zero
> explicitly to clear the collapse vote.

I think this part deserves a separate commit with proper Fixes: tag.

>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/clk/qcom/gdsc.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index 44520efc6c72..c676416e685f 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -132,10 +132,24 @@ static int gdsc_poll_status(struct gdsc *sc, enum gdsc_status status)
>         return -ETIMEDOUT;
>  }
>
> +static int gdsc_update_collapse_bit(struct gdsc *sc, bool val)
> +{
> +       u32 reg, mask;
> +       int ret;
> +
> +       reg = sc->gdscr;
> +       mask = SW_COLLAPSE_MASK;
> +
> +       ret = regmap_update_bits(sc->regmap, reg, mask, val ? mask : 0);
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +
>  static int gdsc_toggle_logic(struct gdsc *sc, enum gdsc_status status)
>  {
>         int ret;
> -       u32 val = (status == GDSC_ON) ? 0 : SW_COLLAPSE_MASK;
>
>         if (status == GDSC_ON && sc->rsupply) {
>                 ret = regulator_enable(sc->rsupply);
> @@ -143,9 +157,7 @@ static int gdsc_toggle_logic(struct gdsc *sc, enum gdsc_status status)
>                         return ret;
>         }
>
> -       ret = regmap_update_bits(sc->regmap, sc->gdscr, SW_COLLAPSE_MASK, val);
> -       if (ret)
> -               return ret;
> +       ret = gdsc_update_collapse_bit(sc, status == GDSC_OFF);
>
>         /* If disabling votable gdscs, don't poll on status */
>         if ((sc->flags & VOTABLE) && status == GDSC_OFF) {
> @@ -425,8 +437,7 @@ static int gdsc_init(struct gdsc *sc)
>                  * If a Votable GDSC is ON, make sure we have a Vote.
>                  */
>                 if (sc->flags & VOTABLE) {
> -                       ret = regmap_update_bits(sc->regmap, sc->gdscr,
> -                                                SW_COLLAPSE_MASK, val);
> +                       ret = gdsc_update_collapse_bit(sc, false);
>                         if (ret)
>                                 return ret;
>                 }
> --
> 2.35.1
>


-- 
With best wishes
Dmitry
