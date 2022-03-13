Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C584D7564
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 13:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbiCMM6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 08:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiCMM6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 08:58:21 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A91B0A7A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 05:57:11 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id v130so25755949ybe.13
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 05:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fkXYlJ6C6wkFx+x1ssKNLuodQj89i4Wuj3dyn8HZpf4=;
        b=e6LfJXTDrJfr5e+FFTBR0v8xULBC4J7mRTDfbLN9gxn7hKKROSV7ZupjXMLbjousk1
         xo3TallrpFvTBcUxLYiWQoDzUINEUjp0OnUTfRNdrVUYmyiY4gjx//bLKVUYDi31D+Pf
         c1qPal5zb3zJU2M1jTTSUein/9JRR1fbzyWfhW5Gqbt2uUlGJNWuMkLEqPNqg01VBjcp
         vUaEA7NxHf2krE4SbXeHOv3AcOMnRsdHQ9giyIm6nWRalg/MkCJpdKMuO4Z1smX5fazZ
         aH6qJY53kFdK7D3JZ+RuT4jMwsBmBMo/2JCUN9UsIeTkzEZLYJzxlTPQBEtEWzS+TH5u
         KLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fkXYlJ6C6wkFx+x1ssKNLuodQj89i4Wuj3dyn8HZpf4=;
        b=5ZWJlzgfbGuphD/MF5fJjyMgxHxc9RGqOXDNgPfAXonT+7TmADmSNy3Y6aPvD242iP
         1bSZ/MOlosV3chro8AZaW1MIP1RwUaFZ+5IlGkJf1n1t/N9fhLhpoQyoJYcdTZ3IetMo
         ovZePabO5uunIA5iyOCgjnzZLz8eEcQ8mp/t+MgwBOHVcJQOKZBF0oDH/3XEbUabMVJ0
         +ZPyU61ILy0eFuuPTb0SQRQ4Ci/79uWLfTgIjkas1pVdGKUKEZsIsg7cS9kKSx7xP0hV
         NcwG4lp/JNDam39XdPvIJr19q52TO1gxYaosfEgmAIfkvlFb6Yqu7GYyKzhngktl624+
         OI/g==
X-Gm-Message-State: AOAM533/hRnrwTlfWs0ifTJXy1HQjYYE+zusuGhfCXUrV8qu5KhFXDHG
        0DgW0PYqG8IN8iTrwii9UPsynognZYKyUxgFzOM=
X-Google-Smtp-Source: ABdhPJxH2ISX8S+q91FSxXNkK8blf42NUZjIRur4xEN3Knox2qgPaszmg0iOARYnwXKwf7vmcknjfuEcvofiXpzpTFc=
X-Received: by 2002:a25:e697:0:b0:629:1f4a:5a3c with SMTP id
 d145-20020a25e697000000b006291f4a5a3cmr14243335ybh.228.1647176227256; Sun, 13
 Mar 2022 05:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220126202427.3047814-1-pgwipeout@gmail.com> <3AFD1DD4-AF0A-4ECC-B4F5-E6BD6B9F1BB7@gmail.com>
In-Reply-To: <3AFD1DD4-AF0A-4ECC-B4F5-E6BD6B9F1BB7@gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Sun, 13 Mar 2022 08:56:55 -0400
Message-ID: <CAMdYzYq06QSmFAwCuTmBYy4LfQAQDxzx2PGc8HOB1iEjxXHGyg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: synopsys/dw-hdmi: set cec clock rate
To:     Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Pierre-Hugues Husson <phh@phh.me>,
        Archit Taneja <architt@codeaurora.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        dri-devel@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Sun, Mar 13, 2022 at 6:13 AM Piotr Oniszczuk
<piotr.oniszczuk@gmail.com> wrote:
>
>
>
> > Wiadomo=C5=9B=C4=87 napisana przez Peter Geis <pgwipeout@gmail.com> w d=
niu 26.01.2022, o godz. 21:24:
> >
> > The hdmi-cec clock must be 32khz in order for cec to work correctly.
> > Ensure after enabling the clock we set it in order for the hardware to
> > work as expected.
> > Warn on failure, in case this is a static clock that is slighty off.
> > Fixes hdmi-cec support on Rockchip devices.
> >
> > Fixes: ebe32c3e282a ("drm/bridge: synopsys/dw-hdmi: Enable cec clock")
> >
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> > drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 7 +++++++
> > 1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/dr=
m/bridge/synopsys/dw-hdmi.c
> > index 54d8fdad395f..1a96da60e357 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > @@ -48,6 +48,9 @@
> >
> > #define HDMI14_MAX_TMDSCLK    340000000
> >
> > +/* HDMI CEC needs a clock rate of 32khz */
> > +#define HDMI_CEC_CLK_RATE    32768
> > +
> > enum hdmi_datamap {
> >       RGB444_8B =3D 0x01,
> >       RGB444_10B =3D 0x03,
> > @@ -3347,6 +3350,10 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_de=
vice *pdev,
> >                               ret);
> >                       goto err_iahb;
> >               }
> > +
> > +             ret =3D clk_set_rate(hdmi->cec_clk, HDMI_CEC_CLK_RATE);
> > +             if (ret)
> > +                     dev_warn(hdmi->dev, "Cannot set HDMI cec clock ra=
te: %d\n", ret);
> >       }
> >
> >       /* Product and revision IDs */
> > --
> > 2.25.1
> >
> >
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
>
> Peter,
>
> On my 5.17-rc7 with applied rk356x VOP2 v8 series - this patch makes CEC =
working on rk3566.
> Unfortunately it breaks working ok CEC on rk3399 rockpi-4b.
>
> Reverting this patch brings back CEC on rk3399 - but rk3366 becomes with =
non working CEC
>
> I'm not sure how to move forward with this....

I was worried about that, thanks for testing it.
Can you send me the cec_clk rate before and after this patch?

>
> br
