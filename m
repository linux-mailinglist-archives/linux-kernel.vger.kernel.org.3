Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626E8493D53
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 16:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355809AbiASPgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 10:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352437AbiASPgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:36:07 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEFDC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:36:07 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id n16-20020a17090a091000b001b46196d572so2933466pjn.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OMrhSxzcq06Y5Du1J5LkmKoFAbKXMAXT3vH7sejriLY=;
        b=ssfImEcNw476pH+KakbvvBbRQNHR8We3jAnB769CrsR7ZqdjUaTl54C8lg28NNpwt3
         Ujsw27eeIbDM0koFZgiviggwBTeQ8pIjeVcgMaH+REWTo1G0rvLESHp0tpSQkfClxlwd
         2mJasD5GOAEw50iMq2vIfwwGOXZeh6nenLxsszU6upFCfLwZvLFmOgFDEP/YteNgzZUS
         cjs54BZG2ME/5bpw7J6x46p9gWGGFTnCbyuChO84a11jFnn4ZgBhuaf/PeXJh2NFEKpm
         hn3fEtEtv0B+n7QD8jAlB0FqXoaJvl8AyYH5Wm0oZhDctURSmdH7zuB6yXwDNZvzBCX1
         +oqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMrhSxzcq06Y5Du1J5LkmKoFAbKXMAXT3vH7sejriLY=;
        b=t7hwKSoRRtqt9cr8Na6KmGK4HSvPRMyWucXREArIJkt6oqx91nmho42HjnmHnoReEy
         EJoyCcnqct13gEBGTn3T6KyR1Aq+4kO6tVDYeH4hSE+/XRyD2dqxZxZg08liFDWn36f9
         +2RXGsrFkOuTkM1RQ5yMZL++Fp2rIbLONK1V4S9rCQfrD9BEJS/NKk4BG5dzHk9xbs9L
         Tn8pKwAgCynVuB6s+ZcXmhv7kMbk8EBBHiKUk3+3X2hNCJ2IzzOnQ06QSBhQwudAdL3/
         /WGbiLgl0xYmcxS6gDpb+5n5vi8Nk9bVBmdNZp+qVW5IaLEpVLeS1B4u05GKseuaX7OU
         +fQg==
X-Gm-Message-State: AOAM53016ooTLmncOcLZ3aUdKmbQPeL6L7KNshOwOFfv1JmT7B7kTxJH
        t3XpxwuSI/+nD+cpcqSoQq07KCdiF9nah2Ciy9XSHg==
X-Google-Smtp-Source: ABdhPJySyCqqeyw8uXJjJaFzQvTXGSC/lm5A2BRldYPOCcLjtNFpPECtLJjCIH4Pg2dEw9rTuxak1N3cylwER/vXAC8=
X-Received: by 2002:a17:902:b189:b0:149:6c45:24c with SMTP id
 s9-20020a170902b18900b001496c45024cmr33136123plr.21.1642606566766; Wed, 19
 Jan 2022 07:36:06 -0800 (PST)
MIME-Version: 1.0
References: <20220119151751.986185-1-hsinyi@chromium.org> <20220119151751.986185-4-hsinyi@chromium.org>
In-Reply-To: <20220119151751.986185-4-hsinyi@chromium.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 19 Jan 2022 16:35:55 +0100
Message-ID: <CAG3jFyv--OkEOxHr=61oAw8Q0bMdkftZu47M-N0YTiOB0YyiQA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] dt-bindings: drm/bridge: anx7625: Add aux-bus node
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Xin Ji <xji@analogixsemi.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Hsin-Yi,

While I can review this patch, I don't have the authority to merge it
since it is outside the scope of my maintainership. Rob Herring,
Daniel Vetter or David Airlie would have to Ack this patch.

On Wed, 19 Jan 2022 at 16:18, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> List panel under aux-bus node if it's connected to anx7625's aux bus.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Xin Ji <xji@analogixsemi.com>
> ---
>  .../display/bridge/analogix,anx7625.yaml        | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> index 1d3e88daca041a..0d38d6fe39830f 100644
> --- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> @@ -83,6 +83,9 @@ properties:
>      type: boolean
>      description: let the driver enable audio HDMI codec function or not.
>
> +  aux-bus:
> +    $ref: /schemas/display/dp-aux-bus.yaml#
> +
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>
> @@ -167,5 +170,19 @@ examples:
>                      };
>                  };
>              };
> +
> +            aux-bus {
> +                panel {
> +                    compatible = "innolux,n125hce-gn1";
> +                    power-supply = <&pp3300_disp_x>;
> +                    backlight = <&backlight_lcd0>;
> +
> +                    port {
> +                        panel_in: endpoint {
> +                            remote-endpoint = <&anx7625_out>;
> +                        };
> +                    };
> +                };
> +            };
>          };
>      };
> --
> 2.34.1.703.g22d0c6ccf7-goog
>
