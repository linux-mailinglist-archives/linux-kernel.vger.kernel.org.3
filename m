Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862344DDFC3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 18:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239576AbiCRRW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 13:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239569AbiCRRW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 13:22:27 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4F42DF3FE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 10:21:08 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bi12so18349345ejb.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 10:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PCoJVU7mrdRYYKIeNxpHu40jIUtYCc2ytq8sJtJQeGU=;
        b=G/3LRJiL3DqJDP4WBNy8s7yyrZw6nESOCNsC2Nwpxwkyj67SgiTW1sew1I9mDZ9rmq
         5LXuoS1QxtJ748Oyjmt7XCguWrg/XLVqNtIkCzWgSXsqWI6/amBXVbX/UMrghLTYUU7X
         trR4fIkpdHtHmSusLVFyY7k9PVKpBF1ayFw4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PCoJVU7mrdRYYKIeNxpHu40jIUtYCc2ytq8sJtJQeGU=;
        b=7YpqB/0DgluBeEk2ERVVrQ0vPsdj+wTkdeFCJ6v+HdkBvu/qZxit40pogJfWRFkSm9
         oM4oHF4gNPtgOlsr2+jl3TFFLTC5wmYUQc4Cwhp8UDPK7t6D4mbgIT2W9HKgU7kW6uUB
         SEkf8Gm0C6AqAXHmWVAWrdrujzef1y22UbRNw15Y5CB2YShg3p8bm7jzy8O3U9JZlhzY
         2inr15WO5QNx49R0Tx9c+pYIfLaFqrr6gd2mbGA5KU8a/gsRSo4ZHSq3Qp6lTz65Qs8n
         m8KMjfQIT+19zFNR8JGX5irRsKEdN6iBCe2xXYP+UfxSFsPOZI+/7Zzvw3sQUm71fwDJ
         U6Wg==
X-Gm-Message-State: AOAM530zRP8lX0T0iftS3/LUKp3eugrx0NUH5ofBsjbySbFEKEzyUhVO
        Src6SqfDWHiJI2Gm+JlswiGJutC3bpdlMQIMjJs=
X-Google-Smtp-Source: ABdhPJyaoT6ABbCixWjbM8uABnpqtjcLv+4V6C7CtW7y2fFEzMJ+skIKGOglka/RaUt3xncQ6S6ByQ==
X-Received: by 2002:a17:907:8687:b0:6d7:8f6a:3c0e with SMTP id qa7-20020a170907868700b006d78f6a3c0emr9755565ejc.500.1647624067004;
        Fri, 18 Mar 2022 10:21:07 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id a22-20020a50ff16000000b00410d029ea5csm4259256edu.96.2022.03.18.10.21.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 10:21:05 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id d7so12588980wrb.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 10:21:05 -0700 (PDT)
X-Received: by 2002:adf:fc47:0:b0:203:dda1:4311 with SMTP id
 e7-20020adffc47000000b00203dda14311mr9062480wrs.301.1647624064675; Fri, 18
 Mar 2022 10:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <1647452154-16361-1-git-send-email-quic_sbillaka@quicinc.com> <1647452154-16361-3-git-send-email-quic_sbillaka@quicinc.com>
In-Reply-To: <1647452154-16361-3-git-send-email-quic_sbillaka@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 18 Mar 2022 10:20:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XM1njMY63SCC3yNoA9Uvu+_3xLGkC5OWoLjR-0KnmhWg@mail.gmail.com>
Message-ID: <CAD=FV=XM1njMY63SCC3yNoA9Uvu+_3xLGkC5OWoLjR-0KnmhWg@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] arm64: dts: qcom: sc7280: Add support for eDP
 panel on CRD
To:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        quic_abhinavk@quicinc.com, quic_khsieh@quicinc.com,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, krzk+dt@kernel.org,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        quic_vproddut@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 16, 2022 at 10:36 AM Sankeerth Billakanti
<quic_sbillaka@quicinc.com> wrote:
>
> Enable support for eDP interface via aux_bus on CRD platform.
>
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> ---
>
> Changes in v5:
>   - Change the order of patches
>   - Remove the backlight nodes
>   - Remove the bias setting
>   - Fix compilation issue
>   - Model VREG_EDP_BP for backlight power
>
> Changes in v4:
>   - Create new patch for name changes
>   - Remove output-low
>
> Changes in v3:
>   - Sort the nodes alphabetically
>   - Use - instead of _ as node names
>   - Place the backlight and panel nodes under root
>   - Change the name of edp_out to mdss_edp_out
>   - Change the names of regulator nodes
>   - Delete unused properties in the board file
>
>
> Changes in v2:
>   - Sort node references alphabetically
>   - Improve readability
>   - Move the pwm pinctrl to pwm node
>   - Move the regulators to root
>   - Define backlight power
>   - Remove dummy regulator node
>   - Cleanup pinctrl definitions
>
>  arch/arm64/boot/dts/qcom/sc7280-crd.dts | 93 +++++++++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)

At a high level, I'd expect your patch to be based upon Matthias's
series, AKA the 4 patches from:

https://lore.kernel.org/r/20220316172814.v1.1.I2deda8f2cd6adfbb525a97d8fee008a8477b7b0e@changeid/

I'll leave it up to you about whether you care to support eDP on the
old CRD1/2 or just on CRD3. Personally I'd think CRD3 would be enough.

Then, I'd expect your patch to mostly incorporate
<https://crrev.com/c/3379844>, though that patch was written before
aux-bus support so the panel would need to go in a different place.

Stephen already gave some comments and basing on Matthias's patches
will be a pretty big change, so I probably won't comment lots more.


> +&mdss_edp {
> +       status = "okay";
> +
> +       data-lanes = <0 1 2 3>;
> +       vdda-1p2-supply = <&vreg_l6b_1p2>;
> +       vdda-0p9-supply = <&vreg_l10c_0p8>;
> +
> +       aux-bus {
> +               edp_panel: edp-panel {

As Stephen pointed out, it should be called "panel".
