Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6684D4BAF06
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 02:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiBRBJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 20:09:51 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiBRBJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 20:09:49 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770433BF8E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 17:09:33 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id bg10so11291925ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 17:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YhNqz0TwV7gSLYgP9YWbRspB12calUNnn7qInjIWMb8=;
        b=kjaQXcd+qDo6HeXDPEWhbFh7itNDJeBgJ0jJRODQBOZ7hs979pzm2WflsUaeHt87yP
         QfxDMnIRoaJ7eDkvmb/yckwyk9YSdc1FaxiFI9ozai/ESqHRWGC3j6y8tn1v5Pwbp/xi
         y+HpVyyGh9scpSCcn61WSMOXHDjMnjoadxSfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YhNqz0TwV7gSLYgP9YWbRspB12calUNnn7qInjIWMb8=;
        b=8G2HohxHJDWNfppVVOqnbXwqz3ZiCok06L3i5L7Gtk5EbI6ZWoAtTC1CYa3jgWKBTs
         +ylOvpU36HAOtirMbjBgZMXtxoWL/o59VuR2zMh4lUZnv4BBdr5k760GCSyBJPpv3dGv
         E5TR0EaM1BJqyFmske1jy/RdBCY69N5bwxukEvfJcjWTk53nzUqmLm+piVi5A82iimUy
         rhE9G93s8GKQBDPhAIiDh+FySiub0B3VdCCOFgvGQBJ0PlHgeeDEnnGTswu5lMPeQvig
         GHsAC89UbomUqFgan/5UsEcDqQ7JmU3T2EI04i7ImgoGTaBYIKdq6YTUa86JCJuCo2MU
         2FUg==
X-Gm-Message-State: AOAM530jB9fj4eDUxmLJVxQl9UcN0WE43GTfdMD8nqC7JsEn0fOxnTTL
        rrKauCA4rpPepiNvsYIUx42lMfQzVM/47Tl7bkM=
X-Google-Smtp-Source: ABdhPJx0FkyMSzC0xVJfJKPa6ZdfNxg4+E4oQspKRjxlr5B1vfKWBCCJPJKHwYMK8vUq7zF97gxFQA==
X-Received: by 2002:a17:906:c08a:b0:6ce:36f8:bfe8 with SMTP id f10-20020a170906c08a00b006ce36f8bfe8mr4528722ejz.52.1645146571763;
        Thu, 17 Feb 2022 17:09:31 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id q14sm4055398edd.54.2022.02.17.17.09.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 17:09:31 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id hw13so11217224ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 17:09:31 -0800 (PST)
X-Received: by 2002:a5d:64ef:0:b0:1e3:1e05:d042 with SMTP id
 g15-20020a5d64ef000000b001e31e05d042mr4049131wri.679.1645146213585; Thu, 17
 Feb 2022 17:03:33 -0800 (PST)
MIME-Version: 1.0
References: <1644494255-6632-1-git-send-email-quic_sbillaka@quicinc.com> <1644494255-6632-3-git-send-email-quic_sbillaka@quicinc.com>
In-Reply-To: <1644494255-6632-3-git-send-email-quic_sbillaka@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 17 Feb 2022 17:03:13 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VVvcn1VpLXjd+X9Xe50sS_vY5ukKJE8i=eAZf1Phofuw@mail.gmail.com>
Message-ID: <CAD=FV=VVvcn1VpLXjd+X9Xe50sS_vY5ukKJE8i=eAZf1Phofuw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] arm64: dts: qcom: sc7280: Add support for eDP
 panel on CRD
To:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, quic_kalyant@quicinc.com,
        quic_abhinavk@quicinc.com, quic_khsieh@quicinc.com,
        quic_mkrishn@quicinc.com, quic_vproddut@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 10, 2022 at 3:58 AM Sankeerth Billakanti
<quic_sbillaka@quicinc.com> wrote:
>
> +       backlight_3v3_regulator: backlight-3v3-regulator {
> +               compatible = "regulator-fixed";
> +               regulator-name = "backlight_3v3_regulator";
> +
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +
> +               gpio = <&pm8350c_gpios 7 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&edp_bl_power>;
> +       };

So I'm pretty sure that this is wrong and what you had on a previous
patch was more correct. Specifically the PMIC's GPIO 7 truly _is_ an
enable pin for the backlight. In the schematics I see it's named as
"PMIC_EDP_BL_EN" and is essentially the same net as "EDP_BL_EN". This
is distinct from the backlight _regulator_ that is named VREG_EDP_BP.
I believe the VREG_EDP_BP is essentially sourced directly from
PPVAR_SYS. That's how it works on herobrine and I believe that CRD is
the same. You currently don't model ppvar_sys, but it's basically just
a variable-voltage rail that could be provided somewhat directly from
the battery or could be provided from Type C components. I believe
that the panel backlight is designed to handle this fairly wide
voltage range and it's done this way to get the best efficiency.

So personally I'd prefer if you do something like herobrine and model
PPVAR_SYS. Then the backlight can use ppvar_sys as its regulator and
you can go back to providing this as an "enable" pin for the
backlight.

I know, technically it doesn't _really_ matter, but it's nice to model
it more correctly.
