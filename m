Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B7559A71F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 22:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352098AbiHSUuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 16:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351880AbiHSUuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 16:50:10 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6D8B7EC5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:49:51 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 24so4562065pgr.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc;
        bh=PPiqvueW9Mr9csrtspssYoA1WIlf7ZX7tJOeDyZQ9tM=;
        b=d4KS4ML+RNRPOvg7UNyebEdVPo5fGPxid064KFuNlXVLSpF9hMYkFXTQjvSUsslu5k
         Zvz/5iAHxFn//NdXt3Aris0JqbPxcNfezauhbYIbsSsv/m+nxXRMkiFwpFpuYMAOCyuQ
         kWDN7If/J8DIFI21Fwa57T4ls25uer1S9Wk8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc;
        bh=PPiqvueW9Mr9csrtspssYoA1WIlf7ZX7tJOeDyZQ9tM=;
        b=7xDgIEnUAh49LGbl46vtxOOtcVHDlGETzgV75qNOUcPsMlyohZGfmqBag9trYt2FNA
         f0P9hhQMIT12OugveqzQUMAV1LyGTVjBdm8mmYGssuOVZ1pyBwv8+s3QLx7Brzi0Va4w
         gS0UjvgEBykTXGufKcChG9WZ+rgfW7+tp+QKt6GDMvea7Jq063ocyK8a0yWJ3Esq0M27
         ZX+1msXNWV8LlFoWpiAQaTDyenPzLGRm0bFglKYT9G12TxQB9gzjlTpmwVyDZtFBVwee
         M1yCCBbRXBPnbkrvsmt2FAFzg3dfzTJTs/zLxmfp8R8T6caJfnkX0DcPrfJ3JsJcb9yL
         TIaA==
X-Gm-Message-State: ACgBeo3jNyJj0lGOxxVhn/JvSTTBitvVMq9nrUg9Uqki1eGgsMHaamwy
        PLfrQEE9R2jLTG2rrdqqY7OgVdWh0fuYOBbi6W0KbYZEvR8=
X-Google-Smtp-Source: AA6agR7KU4/1crUAnBR6DlUKTnq77ERwkcpQDM3bl8Mebz7jky9KMRw9EJflpPgbZMi1DOrcz72WAs4V0LG8PaL2tME=
X-Received: by 2002:a65:490e:0:b0:41c:5b91:e845 with SMTP id
 p14-20020a65490e000000b0041c5b91e845mr7688094pgs.436.1660942189992; Fri, 19
 Aug 2022 13:49:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 Aug 2022 13:49:49 -0700
MIME-Version: 1.0
In-Reply-To: <CACeCKadP-AZ8OU4A=7CrwAz7yuLvMvjvAcw7K-FORFmkMvx7cA@mail.gmail.com>
References: <20220810204750.3672362-1-bjorn.andersson@linaro.org>
 <20220810204750.3672362-2-bjorn.andersson@linaro.org> <a13bce60-25b4-d075-d56a-d1283e91e3ba@linaro.org>
 <20220814210104.GA690892-robh@kernel.org> <Yv1y9Wjp16CstJvK@baldur>
 <CAE-0n53AjJ_G6yZoTALWpKvZUdF+8nFZ+TQh=Ch=8xgdMVqDkw@mail.gmail.com> <CACeCKadP-AZ8OU4A=7CrwAz7yuLvMvjvAcw7K-FORFmkMvx7cA@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 19 Aug 2022 13:49:49 -0700
Message-ID: <CAE-0n53C+D=9gdSXKsjr4KZVrb-gpeo_EyuX3DfNKp19FoicXA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: usb: Introduce GPIO-based SBU mux
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Pin-yen Lin <treapking@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Prashant Malani (2022-08-19 13:14:25)
> > This would do that for us, but when all four lanes are connected from
> > the qmp phy directly to the connector we could just as easily have done
> > it with one endpoint.
> >
> >         qmp_phy {
> >                 ports {
> >                         port@0 {
> >                                 reg = <0>;
> >                                 endpoint@0 {
> >                                         reg = <0>;
> >                                         remote-endpoint = <&usb_c_ss>;
> >                                         data-lanes = <1 2 3 0>
> >                                 };
> >                         };
> >                 };
> >         };
> >
> > So should we explicitly have two endpoints in the usb-c-connector for
> > the two pairs all the time, or should we represent that via data-lanes
> > and only split up the connector's endpoint if we need to connect the
> > usb-c-connector to two different endpoints?
>
> I like 2 endpoints to represent the usb-c-connector, but that doesn't seem
> to be compatible (without introducing `data-lanes`, at least) with all
> the various
> combinations on the remote side, if that remote side is a DRM bridge with DP
> output capability (like it6505 or anx7625).
> That type of DRM bridge supports 1, 2 or 4 lane DP connections.

Why can't the remote side that's a pure DP bridge (it6505) bundle
however many lanes it wants into one endpoint? If it's a pure DP bridge
we should design the bridge binding to have up to 4 endpoints, but
sometimes 2 or 1 and then overlay data-lanes onto that binding so that
we can tell the driver how to remap the lanes if it can. If the hardware
can't support remapping lanes then data-lanes shouldn't be in the
binding.

>
> So, how about 4 endpoints (1 for each SS lane) in the usb-c-connector port@1?
> That should support every conceivable configuration and bridge/PHY hardware.
> and also allows a way to specify any lane remapping (similar to what
> "data lanes" does)
> if that is required.
> Then we are consistent with what an endpoint represents, regardless of whether
> the DRM bridge has a DP panel (1,2 or 4 lane) or Type-C connector  (2
> or 4 lane) on its output side.

I'd like to think in terms of the usb-c-connector, where the DP altmode
doesn't support one lane of DP and USB is only carried across two SS
lanes. Essentially, two SS lanes are always together, hence the idea
that we should have two endpoints in the SS port@1. In the simple case
above it seems we can get away with only one endpoint in the SS port@1
which is probably fine? I just don't know how that is represented in the
schema, but I suspect making another endpoint optional in the SS port@1
is the way to go.

Will there ever be a time when all 4 usb-c-connector remote-endpoint
phandles point to endpoints that are child nodes of different ports
(i.e. different qmp_phy nodes) with a 4 endpoint schema? I don't think
that is possible, so 4 endpoints is flexible but also verbose. It also
means we would have to walk the endpoints to figure out lane remapping,
wheres we can simply find the endpoint in the DP bridge ports and look
at data-lanes directly.
