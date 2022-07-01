Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86347563781
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 18:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiGAQN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 12:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGAQNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:13:23 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB69A31509
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 09:13:20 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ay16so4910218ejb.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 09:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iU1WXNqtWMrZUa+JVDcKXW+n/u2YiixZY6UAGKLDnPg=;
        b=iq8OARlHdwjKJaotlBm1jpgne1kU1PT5n8rnl6fpp9YAyJoLGzBe5hekwwTHO4U6WG
         ZHK2qR50/rtNqUyDApnn0W+70spOH37v/wSryluuzENNpTsfhHWf5E7ADyc2jEgaJWZ7
         jHT3znd5Z/JBcuN1ieNFm6MgqTMUf+yFMuuW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iU1WXNqtWMrZUa+JVDcKXW+n/u2YiixZY6UAGKLDnPg=;
        b=xjAwo4f0zr/KrzStl1PFKHx+BVcvLZqu7hkh4i4VOvwREETua4shI73GF+N3GWCdI4
         jIqEXbsog30ID6y3rYstnx2b2fwEWxbDb1Vaq/E3VV/Lm+i/DtXOu5rFuof8qGo9TUgo
         YmRSrDkkKUVAs/4MCwMZZmDcp2kzvILG0WVyA6ojQA6z/k43xZXDCNSFNtf3vOGq1/Xy
         dyhKMfif9Kz8Y+lvns74r5tEA2CD5GFoEf1eH7qaYpP1RUrU5Tdk5oyPmqTRS3whwkUv
         9I6iZR4FsFQ2G7i4JtKRsYeL6eMfgXYkOKWw/2lzbKauWWeN9SjP13tKFpQJDkSZQezg
         nGNA==
X-Gm-Message-State: AJIora+8qozZg1ytOot7ikZteawgS7+FLNonBD78KD14j30XDD7Mxj0R
        pJS94Y5YWF+vcUYAUFCWUAfsIU/rZjtjRjlU
X-Google-Smtp-Source: AGRyM1vmQfZjzPNKzkDHLSpSRikJkCD/XyAo1pkmSYZBdQfbWX0b4q9RHGVHgkZxOKpCyN46AxnDog==
X-Received: by 2002:a17:906:6015:b0:726:95c1:924f with SMTP id o21-20020a170906601500b0072695c1924fmr14634255ejj.576.1656691999123;
        Fri, 01 Jul 2022 09:13:19 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id bh25-20020a170906a0d900b00722e1635531sm10588301ejb.193.2022.07.01.09.13.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 09:13:18 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id t17-20020a1c7711000000b003a0434b0af7so1881174wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 09:13:18 -0700 (PDT)
X-Received: by 2002:a05:600c:4e8d:b0:3a1:2e4d:1dd2 with SMTP id
 f13-20020a05600c4e8d00b003a12e4d1dd2mr17792094wmq.85.1656691617857; Fri, 01
 Jul 2022 09:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <1656690436-15221-1-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1656690436-15221-1-git-send-email-quic_khsieh@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 1 Jul 2022 09:06:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V5uLz9aqrgHrsPYHzBXL+Bx5Ds8aEP_kSzA29d-9jtBg@mail.gmail.com>
Message-ID: <CAD=FV=V5uLz9aqrgHrsPYHzBXL+Bx5Ds8aEP_kSzA29d-9jtBg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dta: qcom: sc7180: delete vdda-1p2 and vdda-0p9
 from mdss_dp
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        quic_mkrishn@quicinc.com, quic_kalyant@quicinc.coml,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 1, 2022 at 8:47 AM Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> Both vdda-1p2-supply and vdda-0p9-supply regulators are controlled
> by dp combo phy. Therefore remove them from dp controller.
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index 732e118..824a98c 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -813,8 +813,6 @@ hp_i2c: &i2c9 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&dp_hot_plug_det>;
>         data-lanes = <0 1>;
> -       vdda-1p2-supply = <&vdda_usb_ss_dp_1p2>;
> -       vdda-0p9-supply = <&vdda_usb_ss_dp_core>;
>  };

Reviewed-by: Douglas Anderson <dianders@chromium.org>

NOTE: this is somewhat related to Kuogee's series [1] but it's OK to
take even though his series hasn't landed. On trogdor we always keep
these regulators in HPM mode so we're not truly dependent on the
addition of regulator_set_load in the DP PHY.

[1] https://lore.kernel.org/lkml/8b751eb3-2e19-0e03-4c94-b26b3badd397@linaro.org/

-Doug
