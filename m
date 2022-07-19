Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94FB57A9ED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 00:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237971AbiGSWkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 18:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbiGSWku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 18:40:50 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB01FC6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 15:40:49 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id os14so29941101ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 15:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=36+j+A/1DWKJeG29CSuGqRzbVrNZKvXAm48SwcsWC9Q=;
        b=T5hPpPBFqoMWgNsSaumUPSHTwyol2HuOWiJK643KpafdASmbF8lXU4ViBJzhahA7yA
         +bpMp5/lj+8od+3UcpqCoBRr4kzdcYgUFfUKAdGieFFRzzn1Huh5bMalP5kCjpWNDbYS
         7bxfHHy9eCswbXZushJVIzlE9DpUXplbVqMzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=36+j+A/1DWKJeG29CSuGqRzbVrNZKvXAm48SwcsWC9Q=;
        b=U/yhIa4iWOKfmYbB0BYJik4qPeTywCB75+WM75zqN02ZM8AgoViWaY1rnhMDw+0KAY
         gYR3GBiUWVJLpASQstHzMl6ZdQuO3XXIDllT6W9EosT6GzRIUBhp2mrCfoy8xdv/7HBD
         w4jWyT7PXyIl65RXQ5pOrMHYTOLM2btEsA7wNjtGObYFlTcOLoxJEqByXZcGVU27sD+C
         VhOXfsDmEkwWrmNV41aJ8lUEaioypfULyvVkUrswDc3Yct3+SFW2J5TX4FhEA2UpDH4g
         nx1tPAwECo4b22d8mJZUumPACiTnPg6BZv/n8ma3RwyJH8RBvEw+R5YGLTpfZ0ZnGrKX
         7NXw==
X-Gm-Message-State: AJIora/ORhEUojQeYWSqPjSm1PjFzuQj0FmRfoGCJR7AHKRYkQWlfkV7
        d58473Plx64ZfbtaBj/fp2vL4AAyUkw77/FkS8Q=
X-Google-Smtp-Source: AGRyM1vk5jFu2iZZ8SpEiDeOPkCScktR1GaI0vmydsLyswa2pdip4tWSDPscllUMhWtEsgHSEs7ODg==
X-Received: by 2002:a17:907:e8b:b0:72b:811a:1193 with SMTP id ho11-20020a1709070e8b00b0072b811a1193mr33518935ejc.265.1658270448198;
        Tue, 19 Jul 2022 15:40:48 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id q25-20020a17090676d900b006fece722508sm7232846ejn.135.2022.07.19.15.40.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 15:40:46 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id r2so22658674wrs.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 15:40:45 -0700 (PDT)
X-Received: by 2002:a5d:5889:0:b0:21d:bccd:38e3 with SMTP id
 n9-20020a5d5889000000b0021dbccd38e3mr27718830wrf.659.1658270445458; Tue, 19
 Jul 2022 15:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220719203857.1488831-1-nfraprado@collabora.com> <20220719203857.1488831-2-nfraprado@collabora.com>
In-Reply-To: <20220719203857.1488831-2-nfraprado@collabora.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 19 Jul 2022 15:40:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XgWAMXGAfBw9dBoKB6Y6_AAT6ccAtLg=jy3qLa2HOxBA@mail.gmail.com>
Message-ID: <CAD=FV=XgWAMXGAfBw9dBoKB6Y6_AAT6ccAtLg=jy3qLa2HOxBA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/panel-edp: Add panel entry for R140NWF5 RH
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 19, 2022 at 1:39 PM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> Add panel identification entry for the IVO R140NWF5 RH (product ID:
> 0x057d) panel.
>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>
> ---
> The comments on the driver indicate that the T3 timing should be set on
> hpd_absent, while hpd_reliable would have a shorter time just while the
> HPD line stabilizes on low after power is supplied.

Right. Ideally hpd_reliable is 0 unless you've got a badly-designed panel.


> But can we really assume that the HPD line will be reliable at all
> before the DDIC is done booting up, at which point the HPD line is
> brought up? IOW, shouldn't we always delay T3 (by setting hpd_reliable =
=3D
> T3), since only then we're really sure that the DDIC is done setting up
> and the HPD line is reliable?

If the panel is hooked up properly, then the HPD pin should be pulled
low at the start and then should only go high after the panel is ready
for us to talk to it, right? So it's not like the DDIC has to boot up
and actively init the state. I would assume that the initial state of
the "HPD output" from the panel's IC would be one of the following:
* A floating input.
* A pulled down input.
* An output driven low.

In any of those cases just adding a pull down on the line would be
enough to ensure that the HPD line is reliable until the panel comes
around and actively drives the line high.

Remember, this is eDP and it's not something that's hot-plugged, so
there's no debouncing involved and in a properly designed system there
should be no time needed for the signal to stabilize. I would also
point out that on the oficial eDP docs the eDP timing diagram doesn't
show the initial state of "HPD" as "unknown". It shows it as low.

Now, that all being said, I have seen at least one panel that glitched
itself at bootup. After you powered it on it would blip its HPD line
high before it had actually finished booting. Then the HPD would go
low again before finally going high after the panel finished booting.
This is the reason for "hpd_reliable".

If you've got a board with a well-designed panel but the hookup
between the panel and the board is wrong (maybe the board is missing a
pulldown on the HPD line?) then you can just set the "no-hpd" property
for your board. That will tell the kernel to just always delay the
"hpd-absent" delay.

> I've set the T3 delay to hpd_absent in this series, following what's
> instructed in the comments, but I'd like to discuss whether we shouldn't
> be setting T3 on hpd_reliable instead, for all panels, to be on the
> safer side.

The way it's specified right now is more flexible, though, isn't it?
This way if you're on a board where the HPD truly _isn't_ stable then
you can just set the "no-hpd" and it will automatically use the
"hpd_absent" delay, right?


>  drivers/gpu/drm/panel/panel-edp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 3626469c4cc2..675d793d925e 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -1854,6 +1854,12 @@ static const struct panel_delay delay_100_500_e200=
 =3D {
>         .enable =3D 200,
>  };
>
> +static const struct panel_delay delay_200_500_e200 =3D {
> +       .hpd_absent =3D 200,
> +       .unprepare =3D 500,
> +       .enable =3D 200,
> +};
> +
>  #define EDP_PANEL_ENTRY(vend_chr_0, vend_chr_1, vend_chr_2, product_id, =
_delay, _name) \
>  { \
>         .name =3D _name, \
> @@ -1882,6 +1888,8 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>
>         EDP_PANEL_ENTRY('C', 'M', 'N', 0x114c, &innolux_n116bca_ea1.delay=
, "N116BCA-EA1"),
>
> +       EDP_PANEL_ENTRY('I', 'V', 'O', 0x057d, &delay_200_500_e200, "R140=
NWF5 RH"),
> +

This looks fine to me:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'm happy to apply this in a day or two assuming you're OK with my
explanation above.
