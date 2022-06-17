Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F340A54FE15
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 22:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238735AbiFQUF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 16:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbiFQUF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 16:05:56 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202315B898
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:05:55 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eo8so7575511edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=84H7ZXb1eHOGnR6hMHCvky7gquFVieaFdlbDiS5ZCm0=;
        b=Q5DVApFrs0pH6BvUbcxI+mDXaiSweterCD+P4MWFO6Y93WD1AyRYi8Njqa/TN1jP7y
         vD6XKCNPJM/JbkAi3C4Ej1RsWL+5nBBxbtqydo/DEMYUQZkO4q7IzOTn57uPmZRbruVr
         1n5drP9oEQW34cnHA8A2UivmnHGlIdp3R05c4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=84H7ZXb1eHOGnR6hMHCvky7gquFVieaFdlbDiS5ZCm0=;
        b=l+PTRny6kq8c0Yz2uMby/Q4vMEAnu1NuKSTLS01Xs3MbcOPNw/PZNzT4nMPehYnB/2
         GSVRcVL0U2yMPKAl3L3veK7gJ/jYLgLbIF1BFxf7akXvSyp0y6eSJYClZHqW8sORfwhD
         6WYMqI3tL5Zvi+nqR9srEri/eMawLcnR/ve/1ruIna+ayzuS+so3uRQiCT6X/W35xdpi
         wspub55lIb26GGsLB65bi7YgN9BpBZLDpsBxk+MN6hf/ZvU0yUQOw1qKurPQXXRHTyig
         GCTVy8n4bNaRVDQEBY5OGB1Cni5m6j1rf9rKWQGfZLO/UCEEE8jfZWAVWiwsgMFrzM5b
         aaBA==
X-Gm-Message-State: AJIora+V5UDJwnPUPQpAmlsgcjnJmjIbBc+Ai+R37jyV8ALFGvXI5KQl
        ogrGjyWRmH5eB+rEfJJqdUdjXv6CjDVbTmzJ4ns=
X-Google-Smtp-Source: AGRyM1sU0o0wkRq+CSMHJSvZK3xfaA4A9wYjw3H65lEBfhpZXJBvsGMgMVvIgK7rdfeH2lTAMUilaQ==
X-Received: by 2002:a05:6402:294c:b0:435:2155:fbe8 with SMTP id ed12-20020a056402294c00b004352155fbe8mr14384991edb.256.1655496353470;
        Fri, 17 Jun 2022 13:05:53 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id c18-20020a17090618b200b006f3ef214ddesm2561902ejf.68.2022.06.17.13.05.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 13:05:52 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id g4so6984834wrh.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:05:52 -0700 (PDT)
X-Received: by 2002:a5d:5c08:0:b0:219:e5de:72af with SMTP id
 cc8-20020a5d5c08000000b00219e5de72afmr10604185wrb.513.1655496351987; Fri, 17
 Jun 2022 13:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220617111021.v6.1.I9e299d3fa6fbf50df6fc7207050bf5c3a7bf4c61@changeid>
 <20220617111021.v6.6.I423a007e8c4451bd1d091fcb65d035e5dcfc9a9d@changeid>
In-Reply-To: <20220617111021.v6.6.I423a007e8c4451bd1d091fcb65d035e5dcfc9a9d@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 17 Jun 2022 13:05:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VEukZVJY=EXxhGsjQ-_mVzU-qLfNmALd_ZDh1qVjo7Jg@mail.gmail.com>
Message-ID: <CAD=FV=VEukZVJY=EXxhGsjQ-_mVzU-qLfNmALd_ZDh1qVjo7Jg@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] arm64: dts: qcom: Remove duplicate sc7180-trogdor
 include on lazor/homestar
To:     "Joseph S. Barrera III" <joebar@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 17, 2022 at 11:12 AM Joseph S. Barrera III
<joebar@chromium.org> wrote:
>
> From: Stephen Boyd <swboyd@chromium.org>
>
> The sc7180-trogdor-{lazor,homestar}-*.dtsi files all include
> sc7180-trogdor.dtsi and sc7180-trogdor-lazor.dtsi or
> sc7180-trogdor-homestar.dtsi, so including it here in the
> sc7180-trogdor-{lazor,homestar}.dtsi file means we have a duplicate
> include after commit 19794489fa24 ("arm64: dts: qcom: Only include
> sc7180.dtsi in sc7180-trogdor.dtsi"). We include the sc7180-trogdor.dtsi
> file in a board like sc7180-trogdor-lazor-r1.dts so that we can include
> the display bridge snippet (e.g. sc7180-trogdor-ti-sn65dsi86.dtsi)
> instead of making ever increasing variants like
> sc7180-trogdor-lazor-ti-sn65dsi86.dtsi.
>
> Unfortunately, having the double include like this means the display
> bridge's i2c bus is left disabled instead of enabled by the bridge
> snippet. Any boards that use the i2c bus for the display bridge will
> have the bus disabled when we include sc7180-trogdor.dtsi the second
> time, which picks up the i2c status="disabled" line from sc7180.dtsi.
> This leads to the display not turning on and black screens at boot on
> lazor and homestar devices.
>
> Fix this by dropping the include and making a note that the
> sc7180-trogdor-{lazor,homestar}.dtsi file must be included after
> sc7180-trogdor.dtsi
>
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Cc: "Joseph S. Barrera III" <joebar@chromium.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Fixes: 19794489fa24 ("arm64: dts: qcom: Only include sc7180.dtsi in sc7180-trogdor.dtsi")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>
> Signed-off-by: Joseph S. Barrera III <joebar@chromium.org>
> ---
>
> Changes in v6:
>  - First inclusion of this patch.
>
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi | 2 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi    | 8 ++++++--
>  2 files changed, 7 insertions(+), 3 deletions(-)

Ah, now I see that you did have this patch, but you put it last, not
first. This is an important bugfix that we're hoping to land as soon
as possible. It should be the first patch in the series. ...or just
don't include it in your series and point to Stephen's patch.

-Doug
