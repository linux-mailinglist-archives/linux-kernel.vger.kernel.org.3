Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949E554E64F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377996AbiFPPob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377724AbiFPPo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:44:26 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CF52E687
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:44:22 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id cn20so2755591edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5dVDuCM8VRK665zH/HV+gDuurZlzqRaw3AF4f+4QEQY=;
        b=YpSpNH3K+KjKkXCuVKrFBcVrP5SWlYv3RWSSUdRdHJUnj+BZbndMy/7IyaCo4ZQ5rb
         d5YerNu+HSuaHbXK9sCxIH2I4yswgUI5cbWPgvOV+jsqmpGVVOzFPK8wchjbBtnuyFNC
         yiHYfw8thWjslkqgb7sZ31mB5KIv7561wqhQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5dVDuCM8VRK665zH/HV+gDuurZlzqRaw3AF4f+4QEQY=;
        b=fbTBQfLBBdsh4LKfnOo6SNdSY2Mo1Xvs6NMW1Mvv2sC0VxrwTfQ+/TWqOmBzkB1Q5p
         8j8ygxiMeYnA+PjWF0lfrNLqLJTeP4JAIZPNi5XXtIu+5hfd/EZ/R0vygnsXtla7aOM3
         HPKPd6FOAMU3xuoVJj9qKAv3bC4Bq+jiivMvn2h9pPol+PXMFxHnsc7YL4kvh07hpcIS
         rh2T1ML4NT3Tvi2JRBFL4IaBDjq4kyuccyQRv2Sc3r4kWzUPqOQo5yEwjA5tqT09yTDT
         +lBZh0aw9oCxVqevXibi1efEIdbXl3xu2jCKFeiNM4uYiR46CYSAeKLjJ6NIeIuaQNrs
         GD3A==
X-Gm-Message-State: AJIora8rtgdlIvG7JqxTo24fqE9YkUEEYdjBh79rWaneLh66+32uCUTV
        dpxC2+5fvU2DfsNA1nqRRZh+Wr1NoIFc24emgHQ=
X-Google-Smtp-Source: AGRyM1tdojTeHwAs75OpkqJZIJFuM97pA88MBr28LSTBrcp4E4OEIyxOtxzw2kK9Xnsux+PErXdjWA==
X-Received: by 2002:a05:6402:448a:b0:435:3fbe:2593 with SMTP id er10-20020a056402448a00b004353fbe2593mr3409389edb.226.1655394260882;
        Thu, 16 Jun 2022 08:44:20 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id o27-20020a170906359b00b0070a5ba0669dsm888815ejb.218.2022.06.16.08.44.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 08:44:20 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id g4so2382610wrh.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:44:20 -0700 (PDT)
X-Received: by 2002:a5d:68d2:0:b0:210:31cc:64a6 with SMTP id
 p18-20020a5d68d2000000b0021031cc64a6mr5183133wrw.679.1655393766098; Thu, 16
 Jun 2022 08:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220425210643.2420919-1-dianders@chromium.org> <20220425140619.2.Iae013f0ff4599294189f3a6e91376fad137bbabf@changeid>
In-Reply-To: <20220425140619.2.Iae013f0ff4599294189f3a6e91376fad137bbabf@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 16 Jun 2022 08:35:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wbi=CXhPpOUJj=1PdgB8i6Lf1Sfr=T7wrQsgBx790S_w@mail.gmail.com>
Message-ID: <CAD=FV=Wbi=CXhPpOUJj=1PdgB8i6Lf1Sfr=T7wrQsgBx790S_w@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: phy: List supplies for qcom,edp-phy
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-phy@lists.infradead.org, Stephen Boyd <swboyd@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
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

On Mon, Apr 25, 2022 at 2:07 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> We're supposed to list the supplies in the dt bindings but there are
> none in the eDP PHY bindings.
>
> Looking at the driver in Linux, I can see that there seem to be two
> relevant supplies: "vdda-phy" and "vdda-pll". Let's add those to the
> bindings.
>
> NOTE: from looking at the Qualcomm datasheet for sc7280, it's not
> immediately clear how to figure out how to fill in these supplies. The
> only two eDP related supplies are simply described as "power for eDP
> 0.9V circuits" and "power for eDP 1.2V circuits". From guessing and
> from comparing how a similar PHY is hooked up on other similar
> Qualcomm boards, I'll make the educated guess that the 1.2V supply
> goes to "vdda-phy" and the 0.9V supply goes to "vdda-pll" and I'll use
> that in the example here.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

Even though patch #1 in this series should be dropped, this patch
(patch #2) is still valid. Vinod: I assume this would land in your
tree along with the first two patches in Kuogee's series [1], which
are related. Please let me know if you need me to re-send or anything.
Thanks!

[1] https://lore.kernel.org/r/1653507433-22585-1-git-send-email-quic_khsieh@quicinc.com/

-Doug
