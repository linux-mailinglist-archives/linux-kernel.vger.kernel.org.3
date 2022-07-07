Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23AC56A0BD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 13:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbiGGLBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 07:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbiGGLBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 07:01:34 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E85B5724C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 04:01:33 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id j22so5502797ejs.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 04:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sjSXqoI7a+HOTC+YTCSBLGDQWqnl9EwapnigLIHqSzk=;
        b=iG6EIylhIwZjx9zBcet13PJNSBWdfghExcuUmzMef2p0NXrXG2SRh2MepnBv5fUdm7
         Yat1znLxWxiKA7/STWGsDtdiQB1Hglo0LCuZN6Rp2rkDabtLEx0MUspaEPi513ySiBZb
         jRCWSFg9Gu9dtC/FVfKUlFHn1MgqcBceSYIm64vU5r+SGecfH7OOgr3FE+eU7UiI7PsG
         HTI3CcrTEwraENMSI9b4k8hmPoLjhM72MGMZFGLKa7vhu9ej5poBkNGmjIF5rP2lsxBN
         lI72V89qOJwJUgdpuYW9EASdBx+nCIb+RS/+mcAOaC5kCFEwpnKq0AdoLXfFbolYiz1L
         Gtgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sjSXqoI7a+HOTC+YTCSBLGDQWqnl9EwapnigLIHqSzk=;
        b=DnfCpLC89NGJP891Ujbo/HfF6Gm8cQ85C49JW4CYe/G9k5wAm2T9rFQst21DONbHH4
         1+Gd+0Y9BabMbsuiWi54KelF7hLaNWMr+7HaTrBlKfTtFsBdu0VsVOBmp5073GgcKBYR
         XwsfutjNNB6Gcq7g7oQDEEiTmteJcvU/yFG56A2DCixU4k+lm/wm36CrGGNXhKJU8pii
         /VslNiNrFY6ZAbqK+sfUJbTAoZ/vzY3CvhENleqp4Q58k0g1N2rbOq401DHMLXiBzo9o
         5N42hHAZ/KukJbtQTe9S92HQfGUCRfru2WTUYerWdTHgcnrPyeFY8QvD12Wpg2xZ0YVU
         gluw==
X-Gm-Message-State: AJIora891PEP3p9W/QEH+MwroR66TDNtzbNEYYMn+RU9mz8FkC20gh27
        H9k7+//6GLyPACNZbgA6AQzAPyZuzBF5pW1NdGsbvA==
X-Google-Smtp-Source: AGRyM1tshOPj4suuDXTbEPdKeVduVbjptKtkSRYnKzY+oqKLXU+GQLqXwfPKavWxbr1VVW2HNoT8Hl1TSgM18vZZzGg=
X-Received: by 2002:a17:906:8459:b0:72a:ee63:ca58 with SMTP id
 e25-20020a170906845900b0072aee63ca58mr11472249ejy.487.1657191691742; Thu, 07
 Jul 2022 04:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220612144854.2223873-1-alvin@pqrs.dk>
In-Reply-To: <20220612144854.2223873-1-alvin@pqrs.dk>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 7 Jul 2022 13:01:19 +0200
Message-ID: <CAG3jFyvOBAXxBgv2JtEg=0hOeM0UN5CaOQopzvA2twE6ew6zyA@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/2] drm: bridge: adv7511: two fixes for CEC
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

Hey Alvin,

On Sun, 12 Jun 2022 at 16:49, Alvin =C5=A0ipraga <alvin@pqrs.dk> wrote:
>
> From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
>
> Previously sent back in March, see here:
>
> https://lore.kernel.org/dri-devel/20220319145939.978087-1-alvin@pqrs.dk/
>
> No changes besides rebasing on today's drm-misc-fixes.
>
> Alvin =C5=A0ipraga (2):
>   drm: bridge: adv7511: fix CEC power down control register offset
>   drm: bridge: adv7511: unregister cec i2c device after cec adapter
>
>  drivers/gpu/drm/bridge/adv7511/adv7511.h     | 5 +----
>  drivers/gpu/drm/bridge/adv7511/adv7511_cec.c | 4 ++--
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 5 ++---
>  3 files changed, 5 insertions(+), 9 deletions(-)
>
> --
> 2.36.1
>

Sorry about being incredibly slow reviewing & merging this relatively
simple series.

Applied to drm-misc-next.
