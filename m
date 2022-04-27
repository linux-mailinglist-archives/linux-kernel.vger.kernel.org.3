Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5619512452
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 23:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbiD0VKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 17:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235490AbiD0VKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 17:10:12 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C6F8F1B4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 14:06:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id dk23so5797040ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 14:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jjauEsEHj5sd6R0bf8PubRvrJywSXsRV0wPk6pUL5dM=;
        b=lqj+aRvM9wHKgYPNZJHCdMN7jqtNcF8wOkGevnc9WIDv+1Uh+iBIxocTBII9pBiT8a
         GJyn1HWGPh1cAam7gj83EA9YuXCRZZ8IbQ8zjznfC4RczXzNk7R60uGz78vmDBA9KdIj
         fq78Fg9uk9GVx2GI4ERJEBWCUC+hso/XqgVjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jjauEsEHj5sd6R0bf8PubRvrJywSXsRV0wPk6pUL5dM=;
        b=izV8grbp9xpPJmZ5eWGUq5N1XM6poQWR0vR7kI4g4XMUxMZYHfygxvHCRGowbr7+Di
         +Bx7NEJJWYAKZbFHg/5ZwpVBsb9gTwo3wETlJzaTR/V5xV6RGxXjcaTZ52tQObh4Cc9u
         DGC8So5gAVR5axBoSuAZulhkSTlcX/k7KoNemUGsG/SRUPO6tuf0XwlMAaBx5FCtCf1M
         iP0pwiAsr4ZKo+GWgyuWW6KVV9agXrY2txoLbH1oue19TJYdSWglsC4XrdTHSUhXJIId
         UqTEmXIdf5oL/hkm/yyIm8fZfbGwxnCF/jvK1HkYS6L/AVszZ6L81l7FzCL5p3Ogqdmt
         gvAw==
X-Gm-Message-State: AOAM531wuR5R2i3Q1k6i9OY1FRn8YGnNh1aC/f8KrBJFOSJ2rCYijgBB
        m0L02vvSBmAhaK37ReeE6uMirQbn2dzzluPJ
X-Google-Smtp-Source: ABdhPJzo7GlHOlx/GZ5ZkFm0hq6XDQ2LQxUwUTElOaAOrefXcgCDUsdmK19iISzVdIUGTcpyPaELgg==
X-Received: by 2002:a17:906:99c5:b0:6df:8215:4ccd with SMTP id s5-20020a17090699c500b006df82154ccdmr28856113ejn.684.1651093574189;
        Wed, 27 Apr 2022 14:06:14 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id n9-20020aa7c689000000b0042617ba639csm211526edq.38.2022.04.27.14.06.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 14:06:13 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso1916801wml.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 14:06:12 -0700 (PDT)
X-Received: by 2002:a05:600c:502b:b0:38f:f7c6:3609 with SMTP id
 n43-20020a05600c502b00b0038ff7c63609mr27998069wmr.15.1651093572373; Wed, 27
 Apr 2022 14:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220426170306.v22.1.I7a1a6448d50bdd38e6082204a9818c59cc7a9bfd@changeid>
 <20220426170306.v22.2.I18481b296484eec47bdc292a31fa46fa8c655ca9@changeid>
In-Reply-To: <20220426170306.v22.2.I18481b296484eec47bdc292a31fa46fa8c655ca9@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 27 Apr 2022 14:06:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UWPG6cZ_dcuXSKuO8ZA34J5TE1OJDxs7B3qn34V6n+eg@mail.gmail.com>
Message-ID: <CAD=FV=UWPG6cZ_dcuXSKuO8ZA34J5TE1OJDxs7B3qn34V6n+eg@mail.gmail.com>
Subject: Re: [PATCH v22 2/2] arm64: dts: qcom: sc7280-herobrine: Add nodes for
 onboard USB hub
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 26, 2022 at 5:03 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Add nodes for the onboard USB hub on herobrine devices. Remove the
> 'always-on' property from the hub regulator, since the regulator
> is now managed by the onboard_usb_hub driver.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
> Changes in v22:
> - patch added to the series
>
>  .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 21 ++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)

Just like on patch #1, I presume it will be moderately annoying if
this lands in the Qualcomm branch before the driver lands in mainline?
I guess very few people have herobrine hardware, so maybe not that big
of a deal...

In any case, I'm happy with:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
