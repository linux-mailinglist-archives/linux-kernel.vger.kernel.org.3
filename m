Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B4A51C8AE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244263AbiEETJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 15:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244319AbiEETJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 15:09:53 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFF54A918
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 12:06:12 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id l203so5330770oif.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 12:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=D0hIIaQCI/Dh7yD1DKDpvDpYdxU4Kww1YfWBC7PJ66o=;
        b=Y5TZ8gwH28OUdcotbTOTVpcbR4pDhTI/YaqLz24TF+cgaEBsGrcHfKJ6FBpz5fI8YD
         0ZQoF6vw49X7WRHB1KNIwNnaHPbGRAeoDQ27rWR0fcMzDbA4qQ8IRsYiuu1tu/cgCh6i
         7ztBLJfvDKa2BhXMW2eS+XrHhX8up86RwTwaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=D0hIIaQCI/Dh7yD1DKDpvDpYdxU4Kww1YfWBC7PJ66o=;
        b=BN+3xGYR5/mtWZsbhUjknpWu11eGBGZCV7x+5VZCZA8aVj6fqdGnCOuBu7lgGVp0j6
         Kua6BBbthpRxaw9IIFxvm3o//HlCnLNlbPVA999rDIugenrjTn8HYdJ5+Jza30tzGSB2
         6x53ajq6M7i7pNu3/cFB0KopG04eTGM+7skS5oqn/P7Ha/kUtY7LNeuuuBuPflrWK9gE
         XBbQAmpPHGjhhyujiQWHTNL6WMc4K7tRPBwpjbMlAVduNLv0qwV0yRrDacFyYpFk6uFY
         WnF5qYpOWmBQJxBVHXO2wWC7Qy8d0tSgr9Xqj+EdxdMaCznyT5xvaaY/JNH56HprVA+N
         7G9Q==
X-Gm-Message-State: AOAM533EOAOUsI1JCaWIU7YnGtM6iJo1IUT6F4/xPP2d7TRdJmmDka4q
        7Hi2BRv1YP4dGjQno9uZOpk17UmFd5OzVVCYie7WFA==
X-Google-Smtp-Source: ABdhPJynlWjxd2luIxa71ND0gePgQJv4YZ4ySZIIn/1gXDonkO41PQ/jE3q3+0goFTuJnjQr8o6y5FLtPhweRHmec9s=
X-Received: by 2002:aca:bd41:0:b0:2ec:ff42:814f with SMTP id
 n62-20020acabd41000000b002ecff42814fmr3286599oif.63.1651777571605; Thu, 05
 May 2022 12:06:11 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 May 2022 15:06:10 -0400
MIME-Version: 1.0
In-Reply-To: <MW4PR02MB71867A18732B266DE8FA2040E1C29@MW4PR02MB7186.namprd02.prod.outlook.com>
References: <20220425210643.2420919-1-dianders@chromium.org>
 <20220425140619.1.Ibfde5a26a7182c4b478d570c23d2649823ac2cce@changeid>
 <CAE-0n51eZpAKprRQ0HqjLciF_BVQHBDN8SMFNVmmOd=B9UBEzg@mail.gmail.com>
 <CAD=FV=WmVK3wTQf_EAxSi0WPXedSFGCsKdyqRnHsskmMYTHDQA@mail.gmail.com>
 <MW4PR02MB718610FAA14F966ADE1B1585E1C29@MW4PR02MB7186.namprd02.prod.outlook.com>
 <CAE-0n51Q=cGwrMec3JEQENqWHV3pAUjLPT6RwZLA5xV080sgxQ@mail.gmail.com> <MW4PR02MB71867A18732B266DE8FA2040E1C29@MW4PR02MB7186.namprd02.prod.outlook.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 5 May 2022 15:06:10 -0400
Message-ID: <CAE-0n53MEBYhyRtGWOCmjj923UQU_iVE_SEBQw6_FUci8NLz3w@mail.gmail.com>
Subject: RE: [PATCH 1/2] dt-bindings: msm/dp: List supplies in the bindings
To:     Doug Anderson <dianders@chromium.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Cc:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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

Quoting Sankeerth Billakanti (QUIC) (2022-05-05 11:47:20)
> >Quoting Sankeerth Billakanti (2022-05-05 11:02:36)
> >>
> >> Our internal power grid documents list the regulators as VDD_A_*_1P2
> >> and VDD_A_*_0P9 for all the platforms.
> >
> >Do your internal power grid documents indicate what these supplies are
> >powering? The question is if these supplies power any of the logic inside the
> >eDP controller or if they only supply power to the analog circuits in the eDP
> >phy. If it's the eDP phy only then the regulator usage in the eDP driver should
> >be removed. I would suspect this is the case because the controller is
> >probably all digital logic and runs at the typical 1.8V that the rest of the SoC
> >uses. Similarly, these are voltage references which sound like a PLL reference
> >voltage.
> >
> >Please clarify this further.
> >
>
> For the DP driver using the usb-dp combo phy, there were cases where the usb driver
> was turning off the phy and pll regulators whenever usb-dp concurrent mode need not be supported.
> This caused phy and pll to be powered down causing aux transaction failures and display blankouts.
> From then on, it became a practice for the controller driver to vote for the phy and pll regulators also.
>

That sounds like USB-DP combo phy driver had improper regulator power
management where aux transactions from DP didn't keep the power on to
the phy. Where does the power physically go? If the power isn't
physically going to the DP controller it shouldn't be controlled from
the DP controller driver. If the aux bus needs the DP phy enabled, the
DP controller driver should enable the phy power (via phy_power_on()?).
