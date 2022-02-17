Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E6F4BAD6A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 00:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiBQXuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:50:18 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiBQXuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:50:16 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1B639813
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 15:49:58 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id gb39so10978081ejc.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 15:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IgGbzOlUTHOWKPpui7MHtfG8jNNY4bniwC/YrreyLuI=;
        b=IhdrQsZx8xawrXEakDHV3a9kOZ8U9S9uUunE5nfMVHp+ZBvfxF1mHvbyZG0jMTuTnG
         +/3fdRSqXEn7uwXzF9F3GkCNY4oC7rJDO48HhEuxRPWaU133PgRgpP39DJ7b6cPyP5cC
         s6paU9KqyRAUfYfpmBrnMSZ3Ip5spynzdF2+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IgGbzOlUTHOWKPpui7MHtfG8jNNY4bniwC/YrreyLuI=;
        b=Uf7etFKgd4wV1qVZt+eqngqtV75KSiIz8GtMELnOlqbGrIu/QIPahulTFpfIYoYNB3
         s1TF6ARGcTNGakbmKS/BElhka4MJmL/Ljy1kVIKX/vaIZW//Huxkcc1CtsRzC135+AxQ
         1fG9dpqh8lAjgKdHRJLC/+XUpP+qvRr4X1d0fihcAbofHQD+cpHE3rV6pDjnntKoK5tP
         SqnJvWZvTKAbjbtNni59z5n0a6L75ojzec9sUGqYFZVI1rK+/KDsFpEHf6CA/ur2hBnO
         xGJ7MUeqDGSLIpc0kIUSz1FD8D9XyDw8AZFvXitnHJaJaAYYLL97ZjxpTbmQf6GHTlqR
         UccQ==
X-Gm-Message-State: AOAM532Uvd+Jl3vo7Nhcf2PZj9YkIbt5qcZBIJLbqCnd42Qq8QvqQcnI
        XDnjXgLzS290wpWFznj4Vs8HU91APXkHjLBd1bo=
X-Google-Smtp-Source: ABdhPJz2nZv/3wiK8DbHckgGFHjSpY8OUIk13kX/moLxvNGkI7NaRUVR9Jo1X4t30ZuJlA9BALISXA==
X-Received: by 2002:a17:907:2087:b0:6cf:e170:171 with SMTP id pv7-20020a170907208700b006cfe1700171mr4442084ejb.163.1645141796973;
        Thu, 17 Feb 2022 15:49:56 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id 5sm1645813ejl.211.2022.02.17.15.49.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 15:49:56 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id e3so11714581wra.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 15:49:55 -0800 (PST)
X-Received: by 2002:adf:ef07:0:b0:1e3:333f:a101 with SMTP id
 e7-20020adfef07000000b001e3333fa101mr4100610wro.301.1645141795187; Thu, 17
 Feb 2022 15:49:55 -0800 (PST)
MIME-Version: 1.0
References: <1644494255-6632-1-git-send-email-quic_sbillaka@quicinc.com> <1644494255-6632-3-git-send-email-quic_sbillaka@quicinc.com>
In-Reply-To: <1644494255-6632-3-git-send-email-quic_sbillaka@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 17 Feb 2022 15:49:36 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U9v40Ld1N5VsEbny7BBtSWuC5rNxWqcuLQocS1bxLcoQ@mail.gmail.com>
Message-ID: <CAD=FV=U9v40Ld1N5VsEbny7BBtSWuC5rNxWqcuLQocS1bxLcoQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
> +&pm8350c_gpios {
> +       edp_bl_power: edp-bl-power {
> +               pins = "gpio7";
> +               function = "normal";
> +               qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;

As far as I can tell you're lacking:

#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>

...which is needed to use PMIC_GPIO_STRENGTH_LOW. I'm curious how
you're compiling?
