Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECEF523C65
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 20:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346197AbiEKSW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 14:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237718AbiEKSWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:22:20 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECFA14C74D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:22:18 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l18so5704001ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uiYBAkZ/K7TON78jcHgwLk8yR9bWm2DLv+jXS6/7A90=;
        b=TysY5PPYSJqqGGSP17kFdgyVAcXW0GiDdLa8+M1+Q0ojkz+YMGJOdGZ1g7kkbPZOu6
         yt+IrWP6PXRoXVf3HH1RNxijEEEziatsJwBR8ffnixgRhgmDKQimGHpCgltyrkDtU5pd
         QyBownI7LpEYTX9O9gVL+tE6Wpia3KSKpa7tY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uiYBAkZ/K7TON78jcHgwLk8yR9bWm2DLv+jXS6/7A90=;
        b=0RnDr8yO+HVcD+McB+kunL9cx6MPYp7R4NYFKu6z4YNoevB2WznND3IXLSbNgZiJv5
         dj8XxstLo3ie0l4OuwhIUb+6M3/+w/U1ZLbrLb3JBNjBpN6LRaJk/tFzx3V0AzQlZgxb
         7YJdsSIIY5irPIZ2COwfVGMZPIQoN8mkhoSC0OdQcvj5ETsjTeJHifoeivgX89nZuqMj
         avlHuR5PsMOyI5JsZ1t+NLaMZBrLPEVTtnPHZ5lvDQAtZZzRsTvyuvfF4vk9ZAPSrtQg
         AWyBF6ZWYNOSlJ1eB/11u41CvGo9+/A9NaRYWfJ88LRzGdDWQNYZkdbekYgCttybh4+s
         SSZw==
X-Gm-Message-State: AOAM5307xUsvdLT+EqZZNqNjOHQ5GdDAPCO+P1IIiRs+Z0x2Yvqa9KIr
        dFR/EdKoe43m4OEYQu86in6Wm1Bb8hqnRu/oQfY=
X-Google-Smtp-Source: ABdhPJxXr6+UC5PPEhQOvzMTW//LPETEvUur7ckkkLCcozstyA8vXKbGrBUWVTzV4eqIOZRjVrDxPA==
X-Received: by 2002:a17:907:80c8:b0:6f4:3177:a0c9 with SMTP id io8-20020a17090780c800b006f43177a0c9mr27555002ejc.188.1652293336779;
        Wed, 11 May 2022 11:22:16 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id be20-20020a0564021a3400b004288c4f3582sm1511475edb.23.2022.05.11.11.22.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 11:22:16 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id l38-20020a05600c1d2600b00395b809dfbaso1425593wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:22:16 -0700 (PDT)
X-Received: by 2002:a05:600c:3c99:b0:392:b49c:7b79 with SMTP id
 bg25-20020a05600c3c9900b00392b49c7b79mr6101308wmb.199.1652293325498; Wed, 11
 May 2022 11:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220425210643.2420919-1-dianders@chromium.org>
 <20220425140619.1.Ibfde5a26a7182c4b478d570c23d2649823ac2cce@changeid>
 <CAE-0n51eZpAKprRQ0HqjLciF_BVQHBDN8SMFNVmmOd=B9UBEzg@mail.gmail.com>
 <CAD=FV=WmVK3wTQf_EAxSi0WPXedSFGCsKdyqRnHsskmMYTHDQA@mail.gmail.com>
 <MW4PR02MB718610FAA14F966ADE1B1585E1C29@MW4PR02MB7186.namprd02.prod.outlook.com>
 <CAE-0n51Q=cGwrMec3JEQENqWHV3pAUjLPT6RwZLA5xV080sgxQ@mail.gmail.com>
 <MW4PR02MB71867A18732B266DE8FA2040E1C29@MW4PR02MB7186.namprd02.prod.outlook.com>
 <CAE-0n53MEBYhyRtGWOCmjj923UQU_iVE_SEBQw6_FUci8NLz3w@mail.gmail.com> <MW4PR02MB71866E59B844A0842DF7570EE1C59@MW4PR02MB7186.namprd02.prod.outlook.com>
In-Reply-To: <MW4PR02MB71866E59B844A0842DF7570EE1C59@MW4PR02MB7186.namprd02.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 11 May 2022 11:21:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WeTK8LBJmc6AkjPyPLVS+2sSRNEFuEOZrWGJr3Kpq58Q@mail.gmail.com>
Message-ID: <CAD=FV=WeTK8LBJmc6AkjPyPLVS+2sSRNEFuEOZrWGJr3Kpq58Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: msm/dp: List supplies in the bindings
To:     "Sankeerth Billakanti (QUIC)" <quic_sbillaka@quicinc.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Kalyan Thota (QUIC)" <quic_kalyant@quicinc.com>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 6, 2022 at 6:36 AM Sankeerth Billakanti (QUIC)
<quic_sbillaka@quicinc.com> wrote:
>
> >> >> Our internal power grid documents list the regulators as
> >> >> VDD_A_*_1P2 and VDD_A_*_0P9 for all the platforms.
> >> >
> >> >Do your internal power grid documents indicate what these supplies
> >> >are powering? The question is if these supplies power any of the
> >> >logic inside the eDP controller or if they only supply power to the
> >> >analog circuits in the eDP phy. If it's the eDP phy only then the
> >> >regulator usage in the eDP driver should be removed. I would suspect
> >> >this is the case because the controller is probably all digital logic
> >> >and runs at the typical 1.8V that the rest of the SoC uses.
> >> >Similarly, these are voltage references which sound like a PLL reference
> >voltage.
> >> >
> >> >Please clarify this further.
> >> >
> >>
> >> For the DP driver using the usb-dp combo phy, there were cases where
> >> the usb driver was turning off the phy and pll regulators whenever usb-dp
> >concurrent mode need not be supported.
> >> This caused phy and pll to be powered down causing aux transaction failures
> >and display blankouts.
> >> From then on, it became a practice for the controller driver to vote for the
> >phy and pll regulators also.
> >>
> >
> >That sounds like USB-DP combo phy driver had improper regulator power
> >management where aux transactions from DP didn't keep the power on to
> >the phy. Where does the power physically go? If the power isn't physically
> >going to the DP controller it shouldn't be controlled from the DP controller
> >driver. If the aux bus needs the DP phy enabled, the DP controller driver
> >should enable the phy power (via phy_power_on()?).
>
> Yes, it was limitation earlier when we did not have proper interface to interact
> with the combo phy.
>
> In this case, the power from the regulators go to the combo phy.
>
> Now that there is an interface for the controller to interact with the
> combo phy, the proposal to drop the phy regulator voting from the controller
> driver seems reasonable to me.
>
> The phy_power_on() is used for getting the phy out of low power state or getting
> it ready for data transfer.
>
> The controller driver needs to enable the phy power via the phy_init() before
> any interaction with the sink like the aux transactions or before sending the data.
> The controller can disable the regulators via the phy_exit() call.

I can confirm that if I stop providing these regulators to the DP
controller that the screen still comes up. ...but also there are lots
of other things (including the PHY) that power these regulators up...

From offline discussion with folks:

1. It sounds like maybe the code for handling the regulators in the DP
controller leaked in from downstream where the DP driver itself
controls more stuff.

2. We should probably remove these regulators from the DP controller.

3. When we remove this from the DP controller, we'll have to make sure
that the PHY driver calls regulator_set_load() as needed.

Kuogee has volunteered to own this issue and send out patches fixing
the stuff up. So for now, please consider ${SUBJECT} patch abandoned.

-Doug
