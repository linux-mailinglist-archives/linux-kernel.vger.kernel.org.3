Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98A34E9BE4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 18:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241103AbiC1QHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 12:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241123AbiC1QHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:07:06 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBA34EA18
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:05:25 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id h4so9727257edr.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zl5bNVtTXRun7IC2oPFQdw2uugdFrGTUyOrWt/czGSQ=;
        b=b2dIoq93N/tIB0g20QaOpGQ07fOZZq4vHcMttRbcyFjzu8Wh531Qpskl9anTkXZfju
         eodCltzgSRcUcl60XDVXyBV6T63R54FkE6Kjr2aECvnthj7PXGS5ja2nzTbnR3g5DSLf
         kJ8G1NOKEq0RtfF55bYcZTFRX8JmLYZWmgFxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zl5bNVtTXRun7IC2oPFQdw2uugdFrGTUyOrWt/czGSQ=;
        b=IPz4r1b8vTlfUpwHlgxx3zvb6iyCqcffyJfJJHPr8Obc+ETUIk+LiV0jYdze0t9FZ7
         Y2yKvxMEqdw5BCI644xuTrsDylhbcsSiSijGVhLMqIsEyhqFgbBtkJtjxRKRITp0IZV9
         o9PMeXXufPq27v4sTicUPKbk6NBxPLLyVkSc22w+hm/mhdevovERNH0nYRznt9CAUDnX
         0i7ItTro4ebzC421k7QwleipVxzL9qmLOXGMdeMr5LaEmHeCRiudogPxhYOVpPaM2ggc
         U49ln39N/Q/rlo1sYqyiMpBMHDLoXGoGyudQUXmQGgsP7QBWNX1rqtwm20C6Ubpswgjj
         XXRg==
X-Gm-Message-State: AOAM5319HP2yWiWo1TuFyeo1VQqs81uJcrsLBs3RZWoeKA8ndCNOVI+U
        8bL590hcaYp7wHaUksz9ujNNL7IJuareCNXd
X-Google-Smtp-Source: ABdhPJzlb7O0XYabO9lSmweN1os/Imj59sjFKJwowoo4++ZeYA0dGu07oLjPfz7XWWE3YaU+nOaxwg==
X-Received: by 2002:a05:6402:2794:b0:419:2ed8:f36e with SMTP id b20-20020a056402279400b004192ed8f36emr17175862ede.44.1648483523690;
        Mon, 28 Mar 2022 09:05:23 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id f6-20020a0564021e8600b00412ae7fda95sm7199724edf.44.2022.03.28.09.05.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 09:05:19 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id l9-20020a05600c4f0900b0038ccd1b8642so163989wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:05:18 -0700 (PDT)
X-Received: by 2002:a05:600c:2e02:b0:38c:8390:d8ca with SMTP id
 o2-20020a05600c2e0200b0038c8390d8camr27620141wmf.15.1648483518132; Mon, 28
 Mar 2022 09:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220325234344.199841-1-swboyd@chromium.org> <20220325234344.199841-3-swboyd@chromium.org>
In-Reply-To: <20220325234344.199841-3-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 28 Mar 2022 09:05:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wk86sd1m0DU0gYrA2PASArdLnKnf_M8EAeSxzpLt_f8A@mail.gmail.com>
Message-ID: <CAD=FV=Wk86sd1m0DU0gYrA2PASArdLnKnf_M8EAeSxzpLt_f8A@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc7180-trogdor: Simplify spi0/spi6 labeling
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Joseph Barrera <joebar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 25, 2022 at 4:43 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We had to do this spi0/spi6 flip-flop on trogdor-r0 because the spi
> buses got swizzled between r0 and r1. The swizzle stopped after r1, but
> we kept this around to support either hardware possibility and to keep
> trogdor-r0 working.
>
> trogdor-r0 isn't supported upstream, so this swizzle is not doing
> anything besides making a pattern that others try to copy for the EC and
> H1 nodes. Let's remove it and simplify the dts files.
>
> Cc: Joseph Barrera <joebar@google.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi   | 5 -----
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi | 3 ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi    | 3 ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi          | 5 +++--
>  4 files changed, 3 insertions(+), 13 deletions(-)

What about pompom?
What about trogdor-r1?


> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
> index 75df5d1633b2..fe2369c29aad 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
> @@ -5,9 +5,6 @@
>   * Copyright 2020 Google LLC.
>   */
>
> -ap_ec_spi: &spi6 {};
> -ap_h1_spi: &spi0 {};
> -
>  #include "sc7180-trogdor.dtsi"
>
>  &ap_sar_sensor {
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index 3bf40b6abcba..3123665f6c3c 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include <dt-bindings/sound/sc7180-lpass.h>
>
> +#include "sc7180.dtsi"

If we're going to move the "sc7180.dtsi" to trogdor then we should
move it for everyone, right? Right now you're _only_ removing it from
coachz. I think that means that for every other board the
"sc7180.dtsi" file is included more than once. These aren't like C
header files where there's a convention to have header guards.

I _think_ that could actually cause problems too, right? So if you
include it once and then you override a status to "okay" and then you
included it again it might get changed back to "disabled" ?

The easiest solution would be to just leave the sc7180.dtsi include
where it was. If you want to try to do better, I _think_ (but haven't
tried) that you can change all of the existing includes of
"sc7180.dtsi" to be includes of "sc7180-trogdor.dtsi" and then remove
the existing includes of "sc7180-trogdor.dtsi". IIRC the reason that
the sc7180.dtsi include is scattered everywhere is that we needed the
i2c bus before we could define the parade / ti bridge but then we
needed the parade / ti bridge before we included the board specific
bits so we could define the panel.
