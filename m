Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9044E746A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 14:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358031AbiCYNqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 09:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356987AbiCYNqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 09:46:25 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0242670935
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 06:44:51 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id j15so15433066eje.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 06:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gOz+6Jxgi4s/aMhrYK7cy8+f432CABX9+S0xakAnHqY=;
        b=N3uhTkSoAhpdcH0K9ce+7Zd2W0nvWZhX9pG5rSFFU8rLbtBT/XC1CXLSlH+1vk9kzu
         4mlDtldSOeRHo6HikkOr3+q33eoqytnVuzi8kEmzL6qRHtCfkXWX7sFUeP5bTxxGwvDF
         1w8JeKXKER0xIkg+HAXcPJZqJCJXg1T2ErHwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gOz+6Jxgi4s/aMhrYK7cy8+f432CABX9+S0xakAnHqY=;
        b=u87ucjxY6yBWmJpmb5771y8JkSGdY46MaRCl9oPbZBWTBxIICIkgTAJJ7NmExwzlPw
         hBN3T4d25MrQFiwDjtOtY1onqywACYKSLnLnw6QXwRYr3TLOZcgfkmqmbiPzGGoAHyOX
         E1i/hhw4l2DxRrTon3oIs6KW+oHpCqZvojMI4a+FAHIRxcWMCAe37B8/tqxUyF47wd9c
         uscFZgRtZ979Z7VOJXyQRWn8Seo4fcqO6/nAMyNI3bBqgw3XaFeP0O0PNVGyLtTtWhA9
         gGnXE/Jk7rDax1EatEA1GaphydtOmgbYVW+NfLe0qdYg3ZEwEzJjV0W4zJw3MJ1zmEAY
         Sz4A==
X-Gm-Message-State: AOAM5315bsQ7xwI//v4ukN0o/Zz8+PNCGhis4qUjyWMPToQcLB0/qjJn
        yl+1/t76kbCvlC69EJIXQYxZRlWEotdChvPy
X-Google-Smtp-Source: ABdhPJznYpEe4YiEhKCtQGJJoqXCxQQWZuhI7X1Sg9xabSoUHTgNexZAv3nlsNsp5+V9z2CAsnAL5g==
X-Received: by 2002:a17:906:af6b:b0:6df:83a9:67db with SMTP id os11-20020a170906af6b00b006df83a967dbmr11962191ejb.222.1648215889238;
        Fri, 25 Mar 2022 06:44:49 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id dm11-20020a170907948b00b006cf488e72e3sm2327514ejc.25.2022.03.25.06.44.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 06:44:47 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id b19so10919159wrh.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 06:44:46 -0700 (PDT)
X-Received: by 2002:adf:fc47:0:b0:203:dda1:4311 with SMTP id
 e7-20020adffc47000000b00203dda14311mr9264199wrs.301.1648215886319; Fri, 25
 Mar 2022 06:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <1647452154-16361-1-git-send-email-quic_sbillaka@quicinc.com>
 <1647452154-16361-3-git-send-email-quic_sbillaka@quicinc.com>
 <CAD=FV=XM1njMY63SCC3yNoA9Uvu+_3xLGkC5OWoLjR-0KnmhWg@mail.gmail.com> <MW4PR02MB7186E881ABC0620E0A62154EE11A9@MW4PR02MB7186.namprd02.prod.outlook.com>
In-Reply-To: <MW4PR02MB7186E881ABC0620E0A62154EE11A9@MW4PR02MB7186.namprd02.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 25 Mar 2022 06:44:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VWaMx9UsXTktjd3Ryo3g0-XY2N9oCNz_kQoJN6gzKAoA@mail.gmail.com>
Message-ID: <CAD=FV=VWaMx9UsXTktjd3Ryo3g0-XY2N9oCNz_kQoJN6gzKAoA@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] arm64: dts: qcom: sc7280: Add support for eDP
 panel on CRD
To:     "Sankeerth Billakanti (QUIC)" <quic_sbillaka@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        quic_vproddut <quic_vproddut@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 25, 2022 at 6:41 AM Sankeerth Billakanti (QUIC)
<quic_sbillaka@quicinc.com> wrote:
>
> > -----Original Message-----
> > From: Doug Anderson <dianders@chromium.org>
> > Sent: Friday, March 18, 2022 10:51 PM
> > To: Sankeerth Billakanti (QUIC) <quic_sbillaka@quicinc.com>
> > Cc: dri-devel <dri-devel@lists.freedesktop.org>; linux-arm-msm <linux-arm-
> > msm@vger.kernel.org>; freedreno <freedreno@lists.freedesktop.org>;
> > LKML <linux-kernel@vger.kernel.org>; open list:OPEN FIRMWARE AND
> > FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; Rob Clark
> > <robdclark@gmail.com>; Sean Paul <seanpaul@chromium.org>; Stephen
> > Boyd <swboyd@chromium.org>; quic_kalyant <quic_kalyant@quicinc.com>;
> > Abhinav Kumar (QUIC) <quic_abhinavk@quicinc.com>; Kuogee Hsieh (QUIC)
> > <quic_khsieh@quicinc.com>; Andy Gross <agross@kernel.org>;
> > bjorn.andersson@linaro.org; Rob Herring <robh+dt@kernel.org>;
> > krzk+dt@kernel.org; Sean Paul <sean@poorly.run>; David Airlie
> > <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; Thierry Reding
> > <thierry.reding@gmail.com>; Sam Ravnborg <sam@ravnborg.org>;
> > dmitry.baryshkov@linaro.org; quic_vproddut <quic_vproddut@quicinc.com>
> > Subject: Re: [PATCH v5 2/9] arm64: dts: qcom: sc7280: Add support for eDP
> > panel on CRD
> >
> > Hi,
> >
> > On Wed, Mar 16, 2022 at 10:36 AM Sankeerth Billakanti
> > <quic_sbillaka@quicinc.com> wrote:
> > >
> > > Enable support for eDP interface via aux_bus on CRD platform.
> > >
> > > Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> > > ---
> > >
> > > Changes in v5:
> > >   - Change the order of patches
> > >   - Remove the backlight nodes
> > >   - Remove the bias setting
> > >   - Fix compilation issue
> > >   - Model VREG_EDP_BP for backlight power
> > >
> > > Changes in v4:
> > >   - Create new patch for name changes
> > >   - Remove output-low
> > >
> > > Changes in v3:
> > >   - Sort the nodes alphabetically
> > >   - Use - instead of _ as node names
> > >   - Place the backlight and panel nodes under root
> > >   - Change the name of edp_out to mdss_edp_out
> > >   - Change the names of regulator nodes
> > >   - Delete unused properties in the board file
> > >
> > >
> > > Changes in v2:
> > >   - Sort node references alphabetically
> > >   - Improve readability
> > >   - Move the pwm pinctrl to pwm node
> > >   - Move the regulators to root
> > >   - Define backlight power
> > >   - Remove dummy regulator node
> > >   - Cleanup pinctrl definitions
> > >
> > >  arch/arm64/boot/dts/qcom/sc7280-crd.dts | 93
> > > +++++++++++++++++++++++++++++++++
> > >  1 file changed, 93 insertions(+)
> >
> > At a high level, I'd expect your patch to be based upon Matthias's series, AKA
> > the 4 patches from:
> >
> > https://lore.kernel.org/r/20220316172814.v1.1.I2deda8f2cd6adfbb525a97d8f
> > ee008a8477b7b0e@changeid/
> >
> > I'll leave it up to you about whether you care to support eDP on the old
> > CRD1/2 or just on CRD3. Personally I'd think CRD3 would be enough.
> >
> > Then, I'd expect your patch to mostly incorporate
> > <https://crrev.com/c/3379844>, though that patch was written before aux-
> > bus support so the panel would need to go in a different place.
> >
> > Stephen already gave some comments and basing on Matthias's patches will
> > be a pretty big change, so I probably won't comment lots more.
> >
> >
>
> I rebased my change on top of Matthias's changes now. We are discussing about the qcard changes internally to understand the way ahead.
> I believe all my current changes are localized to the crd-r3 files only for the qyalcomm crd3.1
>
> I want to have a different series for c and dt changes to expedite review process. May I separate the c changes from this series?

I'd have no problems with that. They go into different trees and if it
makes it easier to get a new version of the driver out while you're
figuring out what to do about the dts then I'd say let's do it.

-Doug
