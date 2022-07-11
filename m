Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA8A570810
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiGKQMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiGKQMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:12:46 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA1379EE6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:12:46 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id fd6so6867540edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EpUWA0CCK9VbBCJDoo4DsDsKj3ehCYJDBTp0s+uL7as=;
        b=ixU/xMq7Hv7sYGK7x3fdtMTt6aasWztP+joaQKiF3Qoz8jom4Zbc/6yW2OaMtJkOni
         QRGTqspiIYsKDwbpNgmJ05SE4tIR3oGEcMR0OpCFjW/x/t+QR2pLDk1XL1qU/cZ3VQjn
         R+Rda0PCnymlDaO5mqJNz0TzmHAvame4MLDOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EpUWA0CCK9VbBCJDoo4DsDsKj3ehCYJDBTp0s+uL7as=;
        b=epsYcoPiBKS/Or+OqagnJkAkGE76Aj3oszExBlixI3hpoPhyXozkhCvvwYajgxKU6O
         MR+tEdq6u84DFQZkXhR5DdG6en7sez2GtOx4+vxvFHCQ0/NhwSajlZn+IuLx9OguqDkc
         FFgcw47YqAJeYf6xkPm23o0oVaAoc/o0ek7aiL0Z18GfzsL92uEbH3VVjvX8IR0WEAT2
         ibk9klI7cr8epmXaE0LgdOaAuhvP6nCgtI4vu4lep+fpHrszeQldj8wM4lh0352vM7Eq
         HTSJXABqpsvykM9VnwZa94+EqWbLgHZy+pOLp3PrAjQNG2s8uGOb1nW1OmkrZ3yGRirH
         Y7nw==
X-Gm-Message-State: AJIora+QUt7VlkTBmKaLupCfIKhi55d/cmkeJxSYhUZg/UTklTuq4VHn
        BzG41LPCmVVc+io8P2ru0cYnnb3dJm4NIgbAT/g=
X-Google-Smtp-Source: AGRyM1uVpcUM41OpblJQTIvsGmVtDDcuQPOciOEKoJUMPYR5e5Dpo0ghf4YlwCWa+LMwnJ/cpPDI3A==
X-Received: by 2002:a05:6402:b3b:b0:439:b0cc:d409 with SMTP id bo27-20020a0564020b3b00b00439b0ccd409mr25203008edb.325.1657555964411;
        Mon, 11 Jul 2022 09:12:44 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id ks6-20020a170906f84600b0072ae8fb13e6sm2785363ejb.126.2022.07.11.09.12.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 09:12:43 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id v16so7629725wrd.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:12:42 -0700 (PDT)
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id
 b13-20020adff90d000000b0020cde324d35mr17134813wrr.583.1657555961970; Mon, 11
 Jul 2022 09:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <1657555122-18605-1-git-send-email-quic_khsieh@quicinc.com>
 <CAD=FV=WC0XQqOyONddX37=ad8M4N2NHB5UTmDVZU5SEggLvFEA@mail.gmail.com> <9abb6a67-e7a5-a3dc-1bff-30e9d2922b84@quicinc.com>
In-Reply-To: <9abb6a67-e7a5-a3dc-1bff-30e9d2922b84@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Jul 2022 09:12:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VHC_mTya4ywa50_Af0uwt19rYDs9PyGfOh_AhRAJTEgA@mail.gmail.com>
Message-ID: <CAD=FV=VHC_mTya4ywa50_Af0uwt19rYDs9PyGfOh_AhRAJTEgA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dta: qcom: sc7280: delete vdda-1p2 and vdda-0p9
 from mdss_edp
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
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 11, 2022 at 9:10 AM Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
>
> On 7/11/2022 9:02 AM, Doug Anderson wrote:
>
> Hi,
>
> On Mon, Jul 11, 2022 at 8:58 AM Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> Both vdda-1p2-supply and vdda-0p9-supply regulators are controlled
> by dp combo phy. Therefore remove them from dp controller.
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi | 3 ---
>  1 file changed, 3 deletions(-)
>
> You also need to remove it from
> `arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi`.
>
> arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi: vdda-1p2-supply = <&vdd_a_usbssdp_0_1p2>;
>
> I did not see above line at sc7280-herobrine.dtsi at latest msm-next tree.

It's in the qcom tree...

https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/tree/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi?h=for-next#n438

-Doug
