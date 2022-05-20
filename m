Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFA652F58D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 00:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353846AbiETWQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 18:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbiETWQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 18:16:21 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459E36D4F8
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 15:16:20 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id er5so12349921edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 15:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xvie0QExXbdO9a6ZetpQ6DoZ8RHzFGI7AHEhn57vJjo=;
        b=b0LWh1jkiwtCTs7/NY5t9cERb0AJv432EorW/6rJ05w/AT0CTG5+oyybm3cf5ei2rH
         mUBjXpXoPNZ9pdd2a/OTiuTn0l25LBjH8JcvbQza4Hp0GCHknr9rLKGBVN0yFZ21sbVv
         KvyQap+JZT9Qt3hfwV4wMkZb/MBoSVAX2rvsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xvie0QExXbdO9a6ZetpQ6DoZ8RHzFGI7AHEhn57vJjo=;
        b=zQovzGCZOPvs0Sn4ORawnn3BaFyuIfUxUiidew0oS60afT6480Zutg1slr/IHgOPwT
         EQs3hBFPd8AdBvH9ZQB8jUdW25agTVb2jRXklOgcdD4NVznpGgaLog9TYvHhZ44TlVoc
         njDCVZliwOgvMYl0kj+xC7/4jvPbhLG2XYKYfMurvFjfGEdlF/m2DdPy3P/MqRr+Wzyi
         IBtbll9Rzsu0bYRt75N1qR9izW+/q09TE1uhK3O6XgfIgLB+tAWIx5/IHCJiVXme2n0C
         ihOX5d5KHhFBdkcEAfNsIxVaxLCrCcMxHxJ4YqolKeFT8z2y3cwZGUqjeLbQOIFEB3oV
         SE6A==
X-Gm-Message-State: AOAM531it190l9ZvqEQ/+vz7X5ns1BhuQ/vaAxnCLpBHG19QyZrmoa2G
        LT1qquhujRpgZvx50ZJwpO8x4yBlAxGP04ay+g0=
X-Google-Smtp-Source: ABdhPJz5KlzZGYYlJ24KAiurITLGf638ms78b9klmlETxKrUs6UkCmZMh4GHOZz2SbGzm9N+r/rqFQ==
X-Received: by 2002:a05:6402:5113:b0:427:f443:f63e with SMTP id m19-20020a056402511300b00427f443f63emr12976107edd.317.1653084978611;
        Fri, 20 May 2022 15:16:18 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id o16-20020aa7c510000000b0042617ba63b1sm4821914edq.59.2022.05.20.15.16.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 15:16:17 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id s28so13050645wrb.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 15:16:17 -0700 (PDT)
X-Received: by 2002:a05:6000:1548:b0:20f:c4e3:637a with SMTP id
 8-20020a056000154800b0020fc4e3637amr932134wry.513.1653084976906; Fri, 20 May
 2022 15:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220427020339.360855-1-swboyd@chromium.org> <20220427020339.360855-4-swboyd@chromium.org>
In-Reply-To: <20220427020339.360855-4-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 May 2022 15:16:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VSMyJrs9bTE2XEC=q7VtZi6YKFaKJQJyLTZhVaYa9-Jg@mail.gmail.com>
Message-ID: <CAD=FV=VSMyJrs9bTE2XEC=q7VtZi6YKFaKJQJyLTZhVaYa9-Jg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: Only include sc7180.dtsi in sc7180-trogdor.dtsi
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 26, 2022 at 7:03 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> The SoC is always present on sc7180-trogdor.dtsi and thus we should
> include it in the "generic" dtsi file for trogdor. Previously we had
> removed it from there because we had to do the spi6/spi0 swizzle, so
> each trogdor variant board had to include sc7180.dtsi and then
> sc7180-trogdor.dtsi so that the latter dtsi file could modify the right
> spi bus for EC and H1 properties that are common to all trogdor boards.
>
> Now that we're done with that we can replace sc7180.dtsi includes with
> sc7180-trogdor.dtsi and include sc7180.dtsi in sc7180-trogdor.dtsi as
> was originally intended. We still need to include sc7180-trogdor.dtsi
> before the bridge dtsi files though because those rely on the panel
> label.
>
> Cc: "Joseph S. Barrera III" <joebar@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi            | 1 -
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dts        | 2 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dts        | 2 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dts        | 2 +-
>  .../boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dts    | 2 +-
>  .../boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts    | 2 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dts  | 2 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dts  | 2 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts           | 2 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts           | 2 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dts        | 2 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts       | 2 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts           | 2 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dts        | 2 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts       | 2 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dts           | 2 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi            | 1 -
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts                 | 1 -
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi                   | 3 ++-
>  19 files changed, 17 insertions(+), 19 deletions(-)

While reviewing a different change, I found something fishy and
tracked it down to ${SUBJECT} patch.

Specifically, after ${SUBJECT} patch then I run `git grep
include.*trogdor.dtsi`. When I do that, I see that
`sc7180-trogdor.dtsi` is double-included in all lazor devices. :( It's
included in the actual dts files and also in the lazor.dtsi file.

That's probably not right. I think we need to remove the one in the
lazor.dtsi file?

-Doug
