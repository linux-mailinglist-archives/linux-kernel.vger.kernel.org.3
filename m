Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5201048F1D4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 22:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiANVHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 16:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiANVHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 16:07:32 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106B8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 13:07:32 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id q3so11308185qvc.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 13:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ev8VAWLABgcwjAWOJiwrx2eFMwjFEQ1Ark3f35TvFjs=;
        b=M2yojZLr84nstQZUzNRXprG2/FlU5DJXCa/4lDGpMbgAipBAIr2iB5N9qqsMfwqQkT
         g4yO681gHnyAaJL2H39tZR29z9AG/zWpTNG5WQvh3V4qvQUnEZJgbHJLq89a6QFbmj7U
         T13OJuE02K3CvAEpRN/RzVBWxyp6maN+0PkJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ev8VAWLABgcwjAWOJiwrx2eFMwjFEQ1Ark3f35TvFjs=;
        b=Lq3XS1A1zeOVkuqZ4TV42P9+h/fRKWzoYV910k3MY930X7tW5BBXGy+qEcFJ+rs5Ld
         L/v+cTIn73NeHeYznLJqWRgy37yxF5cpzZAPJBAGsQMKqZ7q/2DNbYghvyLZ8msKd0nV
         CqYdVex8YgQT8nd13MDwVM30ZB6B61gcaniJx88++88q8bPviaRjFDGXcMA1dJRC7D1V
         ph/NGjKg9K5oJu0VCKwYwjiJrdwMUCScr+WBqvhTLFJRwjsqZoPZiWpnuMVEXx707Lho
         MgzNl3ZiJ6/uJ4ncrDFzNqMVVh+dCpwQS4fJcERgXKgnB40oZxnMPO45ZVeZHGou8SlS
         qplA==
X-Gm-Message-State: AOAM532NSjU8eKraS8BqMMo4/uaB22NljCajsMmCXL1fqOiHJSr2dtpK
        xpFoXZ8+Q3/9e1liG1ElH5clm0JLIBWZew==
X-Google-Smtp-Source: ABdhPJxXQVZKrHlEjlWhOUmUciHkk4rXUGlnrqK76jOgMaQPCaML4tbGsxNW2EO7tJycAnN1GhtBBA==
X-Received: by 2002:a05:6214:ca1:: with SMTP id s1mr3215398qvs.59.1642194450895;
        Fri, 14 Jan 2022 13:07:30 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id u6sm4187569qki.129.2022.01.14.13.07.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 13:07:30 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id c6so27239444ybk.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 13:07:30 -0800 (PST)
X-Received: by 2002:a9d:5908:: with SMTP id t8mr7723553oth.186.1642194095619;
 Fri, 14 Jan 2022 13:01:35 -0800 (PST)
MIME-Version: 1.0
References: <20220114201652.3875838-1-briannorris@chromium.org> <20220114121515.1.I46f64b00508d9dff34abe1c3e8d2defdab4ea1e5@changeid>
In-Reply-To: <20220114121515.1.I46f64b00508d9dff34abe1c3e8d2defdab4ea1e5@changeid>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 14 Jan 2022 13:01:22 -0800
X-Gmail-Original-Message-ID: <CA+ASDXMO3sPta-vhMCqAPRFFkNa-nmY+wK6PXJaSUEXBHETG+A@mail.gmail.com>
Message-ID: <CA+ASDXMO3sPta-vhMCqAPRFFkNa-nmY+wK6PXJaSUEXBHETG+A@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: Switch RK3399-Gru DP to SPDIF output
To:     Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     alsa-devel@alsa-project.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sandy Huang <hjc@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Lin Huang <hl@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry to send a self-reply so quickly, but I noticed an error and want
to make sure this doesn't get merged _too_ quickly before I get to
send a revision! See below:

On Fri, Jan 14, 2022 at 12:17 PM Brian Norris <briannorris@chromium.org> wrote:
>
> Commit b18c6c3c7768 ("ASoC: rockchip: cdn-dp sound output use spdif")
> switched the platform to SPDIF, but we didn't fix up the device tree.
>
> Fixes: b18c6c3c7768 ("ASoC: rockchip: cdn-dp sound output use spdif")
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
>  arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> index 45a5ae5d2027..21ec073f4d51 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi

> +&spdif {
> +       status = "okay";

I need to fix up the pinctrl settings here. rk3399.dtsi has a default
that is incorrect. That's OK for several variants (Kevin and Bob,
where the pin is actually unconnected), but it breaks Scarlet (where
the pin in question is actually connected to something else).

I'll send a v2 after waiting a bit, in case there are other comments
worth addressing at the same time.

Brian

> +};
