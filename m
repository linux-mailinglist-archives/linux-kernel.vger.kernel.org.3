Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A90C57CDE4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiGUOkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiGUOkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:40:10 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3306E92
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:40:07 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ez10so3458040ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K8gd/m3LxS60yVx7Ft64S3I2geJNhfthrTCnHWEHH0w=;
        b=PxLxMfnPHw7C70/BqUyBmctzuSLEjBn8t9+6JFbmwTV1PD+DxOc2aU5qW7Mv9pOvTL
         g41dPI7CL0SpwaPG1W9qn4AuZyxlGo0ZAhZuhm1Rg4BRvIOdSJZ27GhSGKT6BURo+9nE
         srGoMQ7BP/A7n2MGZvMwViiTYMpGYf3A5xR8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K8gd/m3LxS60yVx7Ft64S3I2geJNhfthrTCnHWEHH0w=;
        b=68GcPkhKWI99nbGV9F3rqWbURmEShP0mt7layiMecbHbE0W8j/XgZ3nW4jYbx1+dX8
         LG+mO7OEW+XIGP21jmft8jMh09P+wlfI9mGvFnz8a0xQhuz2xrs4hssCQNJKkDIEeCip
         hFoGP/YIOz57nMC8wh3HOFoGJhaCB6erDwPocqlGNTPf7aa9JIydzffciD3iYnRwtkoN
         Gg6pvc/UwHzySlpP/bCyU1CHvSIa0f4THtse0CIKL7OtGTTuXIcCvxSLsLjBIHCCxhwY
         lQVuyqMcnabj6Te0k+g+6mRXq0Y28JjSb19CV/z9nO2njhSc9pRI+HGHS0CT+B0uJISY
         UtyA==
X-Gm-Message-State: AJIora+Ql4lurO23Wl7dfh+QjiGJC615mKfkn/vDQi1vMHAScR6ciYMF
        O+Q0kXVJxe6JVPp0ZTL4mHR5x9OYI1usA5Vi
X-Google-Smtp-Source: AGRyM1uR+s94EkGy0wBJCi7prf2aaKU6dEZTD+lT1JmSnLAzmKGXIic+O3l18O8590ekTDsR30pIdA==
X-Received: by 2002:a17:907:9619:b0:72b:4761:be19 with SMTP id gb25-20020a170907961900b0072b4761be19mr43329219ejc.20.1658414406229;
        Thu, 21 Jul 2022 07:40:06 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id jw7-20020a170906e94700b00715705dd23asm923273ejb.89.2022.07.21.07.40.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 07:40:02 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id m17so2291328wrw.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:40:00 -0700 (PDT)
X-Received: by 2002:adf:fb12:0:b0:20c:79b2:a200 with SMTP id
 c18-20020adffb12000000b0020c79b2a200mr35372536wrr.617.1658414400165; Thu, 21
 Jul 2022 07:40:00 -0700 (PDT)
MIME-Version: 1.0
References: <1657038556-2231-1-git-send-email-quic_khsieh@quicinc.com>
 <YtkrDcjTGhpaU1e0@hovoldconsulting.com> <Ytk2dxEC2n/ffNpD@sirena.org.uk>
In-Reply-To: <Ytk2dxEC2n/ffNpD@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 21 Jul 2022 07:39:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UQGXqVkew544f3RDtWb3virRHWiafBAxK3ncb5wmVYwQ@mail.gmail.com>
Message-ID: <CAD=FV=UQGXqVkew544f3RDtWb3virRHWiafBAxK3ncb5wmVYwQ@mail.gmail.com>
Subject: Re: [PATCH v16 0/3] eDP/DP Phy vdda realted function
To:     Mark Brown <broonie@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 21, 2022 at 4:20 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jul 21, 2022 at 12:31:41PM +0200, Johan Hovold wrote:
>
> If you're copying someone into a thread that's not obviously relevant
> for them it's good practice to put a note about it at the top of the
> mail to reduce the chances that it just gets deleted unread - people get
> copies of all sorts of random stuff for not great reasons (like getting
> pulled in by checkpatch due to once having done a cleanup) and are often
> quicky to delete things.
>
> > This series breaks USB and PCIe for some SC8280XP and SA540P machines
> > where the DP PHY regulators are shared with other PHYs whose drivers do
> > not request a load.
>
> > Specifically, the hard-coded vdda-phy load of 21.8 mA added by this
> > series, causes several RPMh regulators to now be put in low-power mode.
>
> > I found Doug's suggestion to handle situations like this in regulator
> > core:
> >
> >       https://lore.kernel.org/all/20180814170617.100087-1-dianders@chromium.org/
>
> > but since that was rejected, how do we deal with this generally?
>
> > In the above thread Doug mentioned adding support for load requests to
> > further drivers and Bjorn mentioned working around it by adding
> > regulator-system-load properties to DT.
>
> > It seems quite likely that changes like this one affects other systems
> > too, and the effects may be hard to debug. So a more general solution
> > than playing whack-a-mole using DT would be good to have.
>
> You could add a way to specify constant base loads in DT on either a per
> regulator or per consumer basis.

Yes, this please! ...on a per consumer basis. :-) It's been on my
wishlist for a while and would eliminate a massive amount of code /
tables in the drivers.

We could debate syntax, but I guess you'd either do it w/ two cells

vdda-phy-supply = <&vdda_mipi_dsi0_1p2 21800>;

...or with matching properties:

vdda-phy-supply = <&vdda_mipi_dsi0_1p2>;
vdda-phy-supply-base-load = <21800>;

-Doug
