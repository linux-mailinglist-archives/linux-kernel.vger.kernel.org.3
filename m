Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEE155AB1E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 16:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbiFYOpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 10:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbiFYOph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 10:45:37 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066E7140BA
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 07:45:36 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e2so7207907edv.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 07:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TL/BmZNGSH0YDu8VnWJmtXrclXOV4slFnYUNd3pBuw4=;
        b=aQIBfwmMXYQv2Dj5sonaawXdulKap1MyHWcEGk2rr1YTsThaBv0VAWvyjc7z60te9e
         4FBP4j18U/sh397iE/kUgdCqG1F5zeZs5vuwO5gaamkmTpqKrecFFboWVL+v23NqegqQ
         ZYYm8NdB4DY/M51y3/91g3JkRt1EzEXelW0T4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TL/BmZNGSH0YDu8VnWJmtXrclXOV4slFnYUNd3pBuw4=;
        b=O8W7XimE9kMPIHMzZ1v6k8osYNJLIyBYblBZvcOLMY5LPi9+Ylwm1wqxYt51vVQ0JM
         Gmp+Lw6/qX2J6195Ejqt0HIvUX+HGTljLTTTeZ+A9TDzC7rdeDy5wEZ8ED4abqwM+VTr
         zSFP+mWMRVX6IjDCqclnd5XTGwWz+6X5vIEae+gRyzup0Fv0oezxrnfoubqUCWaNOfNy
         0MF2iW5pkaSEZbBzZp/4b4aWkz/rawUEmqe+PBOZu9wlhRVr8XMbrS2woD6Hd77PaK7Z
         oMfIDqfXYQKICYgheoJ7eDQtUW0uMCpV83SBw1FoHSQqKhE8iP0dOO1q+T2glpkDGcw/
         wmOQ==
X-Gm-Message-State: AJIora86ZXFbAPFt+76FUztgbceincEomYJTulNuLbaxoQWNMrnekn22
        qDZ049v5NvbcgSV7+G0pHyJ2YmUbIUhjxRytfKw=
X-Google-Smtp-Source: AGRyM1uc1zcLXO3bhf/r0xw3zAJ+Xhyg9ByTS+dMix3IziQEnkdUuWVVtkONAI6cDcmzZRKoo67sVg==
X-Received: by 2002:a05:6402:2687:b0:437:652e:26a1 with SMTP id w7-20020a056402268700b00437652e26a1mr5560758edd.36.1656168333852;
        Sat, 25 Jun 2022 07:45:33 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id m16-20020a1709061ed000b006fe8ac6bc69sm2715454ejj.140.2022.06.25.07.45.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 07:45:32 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id i1so2399561wrb.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 07:45:32 -0700 (PDT)
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id
 b13-20020adff90d000000b0020cde324d35mr3993162wrr.583.1656168332218; Sat, 25
 Jun 2022 07:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220625022716.683664-1-joebar@chromium.org> <20220624192643.v13.4.I41e2c2dc12961fe000ebc4d4ef6f0bc5da1259ea@changeid>
In-Reply-To: <20220624192643.v13.4.I41e2c2dc12961fe000ebc4d4ef6f0bc5da1259ea@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Sat, 25 Jun 2022 07:45:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X+92d+PvrHENT3g5=hkJ_UaVWHgMHyuvn3erg10DpVAw@mail.gmail.com>
Message-ID: <CAD=FV=X+92d+PvrHENT3g5=hkJ_UaVWHgMHyuvn3erg10DpVAw@mail.gmail.com>
Subject: Re: [PATCH v13 4/5] arm64: dts: qcom: sc7180: Add pazquel dts files
To:     "Joseph S. Barrera III" <joebar@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
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

On Fri, Jun 24, 2022 at 7:28 PM Joseph S. Barrera III
<joebar@chromium.org> wrote:
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index e55dbaa6dc12..69cd4b3b911b 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -11,6 +11,12 @@
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include <dt-bindings/sound/sc7180-lpass.h>
>
> +#ifdef __SC7180_TROGDOR_DTSI__
> +#error "Duplicate include"
> +#else
> +#define __SC7180_TROGDOR_DTSI__
> +#endif
> +

I'm not convinced about the need for this. That being said:

* If you want to try to do something like this, it should be in a
separate patch, probably at the end of the series. Then if people all
love it then it can be applied and if people don't like it then the
series can simply be applied without it.

* IMO if you wanted to pick one file to put this in it'd be
sc7180.dtsi, not sc7180-trogdor.dtsi.

-Doug
