Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5FD57A9FD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 00:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240338AbiGSWqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 18:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbiGSWp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 18:45:57 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730084D4D6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 15:45:56 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id t3so21607241edd.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 15:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fv+GNXlN9UxF9XBdT2UlE6jI8/2x/dbHCuQ1tk+iXUs=;
        b=ZmE6QeSILOLriTuD+A60orcSHG5MM5lDq068GNLBGBf0gp2j+kgRdIcg4p5EzEAsg0
         NJc57UwpNJmUS20kWorgRWJzqgWdOVzT47jIrMIccxokQbbxJNZv0Dl0Xjh8tkuEieKa
         9fG5elw4bKwSsGETu04l7LiBnxio5sYPavxD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fv+GNXlN9UxF9XBdT2UlE6jI8/2x/dbHCuQ1tk+iXUs=;
        b=XGZnuIkE3YsmSHWfyufUzeC+JyzFUEX3vnFnhJ83HytlBDcryi1DThHOaBp0YRKOmp
         ux8PxexI8zsXRwPnM81AaMLg01DIMxizmnn3kyPixD9U0/Uf+kVxDReK9Bx7I5B6X5IC
         5jO0X0YTDAWn1yYIusFf1AZ0OCiRU8MZII1z4Jsqypb6ehX73ZjKyqto7ZvJTtZ0hX1d
         rykR+CDcnXnGzj+z+o0lnP7Fg1lF8iwou89RXw4TXWBeEHPj7FP7l2bReazP7RBudaJz
         8MeSjDpShRcCslLfWW3zsc0DcjxGv1Wv11FW+FRiKSONNh5YzHTHpn/BegzPNxIjmGkX
         T8YQ==
X-Gm-Message-State: AJIora9Xo5Q2qRmhn56vc3FEdyPpE3YQ64OMPRKLIb65aOCwunu+wi8Z
        M24Wq3UYDUJuC+5lUNQLnJ4RsF2u/TBlWLDLqjg=
X-Google-Smtp-Source: AGRyM1sXN6QnJXreRfddX4SZ7vNO4gc/sYMQ0SnoiaQfNwH3VgijLfJTDefOOiRHG4T0wdCSIzo4OQ==
X-Received: by 2002:a05:6402:48c:b0:43a:8bc7:f440 with SMTP id k12-20020a056402048c00b0043a8bc7f440mr46855597edv.8.1658270754856;
        Tue, 19 Jul 2022 15:45:54 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id ah8-20020a1709069ac800b00722d5b26ecesm7111258ejc.205.2022.07.19.15.45.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 15:45:53 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id z13so4119481wro.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 15:45:53 -0700 (PDT)
X-Received: by 2002:adf:fb12:0:b0:20c:79b2:a200 with SMTP id
 c18-20020adffb12000000b0020c79b2a200mr28616133wrr.617.1658270752900; Tue, 19
 Jul 2022 15:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220719203857.1488831-1-nfraprado@collabora.com> <20220719203857.1488831-4-nfraprado@collabora.com>
In-Reply-To: <20220719203857.1488831-4-nfraprado@collabora.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 19 Jul 2022 15:45:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X0End8u3nNNXSMVhuJo0KWmJYRNg3yeC9yQ+5bLKTmYg@mail.gmail.com>
Message-ID: <CAD=FV=X0End8u3nNNXSMVhuJo0KWmJYRNg3yeC9yQ+5bLKTmYg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/panel-edp: Fix variable typo when saving hpd
 absent delay from DT
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
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
> The value read from the "hpd-absent-delay-ms" property in DT was being
> saved to the wrong variable, overriding the hpd_reliable delay. Fix the
> typo.
>
> Fixes: 5540cf8f3e8d ("drm/panel-edp: Implement generic "edp-panel"s probe=
d by EDID")
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>
>  drivers/gpu/drm/panel/panel-edp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 152e00eb846f..b3536d8600f4 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -738,7 +738,7 @@ static int generic_edp_panel_probe(struct device *dev=
, struct panel_edp *panel)
>         of_property_read_u32(dev->of_node, "hpd-reliable-delay-ms", &reli=
able_ms);
>         desc->delay.hpd_reliable =3D reliable_ms;
>         of_property_read_u32(dev->of_node, "hpd-absent-delay-ms", &absent=
_ms);
> -       desc->delay.hpd_reliable =3D absent_ms;
> +       desc->delay.hpd_absent =3D absent_ms;

Well that's embarrassing. In the end I never used any of these
properties for anything shipping since HPD was always hooked up on
later boards and the only board that needed "hpd_reliable" never ended
up switching to the generic "edp-panel".

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'll apply this right away to drm-misc-fixes.
