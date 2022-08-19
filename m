Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6519859A855
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 00:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240140AbiHSWSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 18:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239974AbiHSWS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 18:18:28 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB3652FDF
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 15:18:26 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-335624d1e26so156726777b3.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 15:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=g970rHvYU+jzmjt/ipCa52Mq2yPk1D8evtOuUbEWCCc=;
        b=ocmXEsD9wtMUp2BtyAWhiufuKaIOEGosHOSfxRSr3HFM1Qrcft04gjrF4UZxdX9dHH
         gytaAiBGMkGekR5z16JQGZsEG/HcyVq8PEnRGi6/NxSo+ulnqDji9PKVXy9hSVNJjRlX
         IdmvwY+XCFyJf8Ruv6DeyT0BpJiM736Z1b58o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=g970rHvYU+jzmjt/ipCa52Mq2yPk1D8evtOuUbEWCCc=;
        b=XWjQkE+ttpHi8T8YEmAM2Ux1ANt1uUiCfGtCrsyu49Mms2UaJuDKeQyJOgiz+mnq9y
         jE4ajYwh3dOCyrTa9SCqnZQGO27B6aT0Q5AetIh8kt8H8qm5ifLMh+xeGK9iPLqDwixs
         xBbgYeBa2e8dQ6EcJjUQ0PVO8H4l7AYnxOT/xuzULzpGaSy+cQN58cTc4uHHWT/UcAK2
         I+1PNB+YfacDjCjAdSa/EtTXl9l9ktvh+9JST4BQ8Mj6l4hS0yRXvaeGCNwdzDzRAWuP
         Phhel8PVtNM2yjCAMWbFMo5+MrsFo3NArTYwAeXSBoL9JlDpubnMluAFQepoJW/eIqnm
         bZkw==
X-Gm-Message-State: ACgBeo2oi6QG/i1PlZXV79g0YHWkLayH6E28OLmyAbOTUxluH4idAsN+
        vdMxk1oeEjmi81pLn/YEqTNlXdkRqrDKv+7FbduOzQ==
X-Google-Smtp-Source: AA6agR7fSsmOLXd0g2A9PAmqngdkh9aPq8/Qdvd6Jegkja7GbS6agFmvsjzLn5OaFoEquCygqR9BgaqT+UJZmO2up0o=
X-Received: by 2002:a0d:d80b:0:b0:336:8219:8675 with SMTP id
 a11-20020a0dd80b000000b0033682198675mr9954844ywe.269.1660947505669; Fri, 19
 Aug 2022 15:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220810204750.3672362-1-bjorn.andersson@linaro.org>
 <20220810204750.3672362-2-bjorn.andersson@linaro.org> <a13bce60-25b4-d075-d56a-d1283e91e3ba@linaro.org>
 <20220814210104.GA690892-robh@kernel.org> <Yv1y9Wjp16CstJvK@baldur>
 <CAE-0n53AjJ_G6yZoTALWpKvZUdF+8nFZ+TQh=Ch=8xgdMVqDkw@mail.gmail.com>
 <CACeCKadP-AZ8OU4A=7CrwAz7yuLvMvjvAcw7K-FORFmkMvx7cA@mail.gmail.com>
 <CAE-0n53C+D=9gdSXKsjr4KZVrb-gpeo_EyuX3DfNKp19FoicXA@mail.gmail.com> <YwADGgNVwtKacUBR@builder.lan>
In-Reply-To: <YwADGgNVwtKacUBR@builder.lan>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Fri, 19 Aug 2022 15:18:15 -0700
Message-ID: <CACeCKaeXpU+AxFNAwkutMX9LT2XLgAv1XmwJRyj7Exqxg6v8rA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: usb: Introduce GPIO-based SBU mux
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, Rob Herring <robh@kernel.org>,
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

On Fri, Aug 19, 2022 at 2:39 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Fri 19 Aug 15:49 CDT 2022, Stephen Boyd wrote:
>
> > > I like 2 endpoints to represent the usb-c-connector, but that doesn't seem
> > > to be compatible (without introducing `data-lanes`, at least) with all
> > > the various
> > > combinations on the remote side, if that remote side is a DRM bridge with DP
> > > output capability (like it6505 or anx7625).
> > > That type of DRM bridge supports 1, 2 or 4 lane DP connections.
> >
> > Why can't the remote side that's a pure DP bridge (it6505) bundle
> > however many lanes it wants into one endpoint? If it's a pure DP bridge
> > we should design the bridge binding to have up to 4 endpoints, but
> > sometimes 2 or 1 and then overlay data-lanes onto that binding so that
> > we can tell the driver how to remap the lanes if it can. If the hardware
> > can't support remapping lanes then data-lanes shouldn't be in the
> > binding.

2 endpoints sounds fine to me. The overloading of the bridge-side endpoint
to mean different things depending on what it's connected to seemed odd to
me, but if that is acceptable for the bridge binding, then great.

> The existing implementation provides the interfaces usb_role_switch,
> usb_typec_mux and usb_typec_switch. These works based on the concept
> that the USB Type-C controller will request the endpoints connected to
> the usb-c-connector about changes such as "switch to host mode", "switch
> to 2+2 USB/DP combo" and "switch orientation to reverse". We use this
> same operations to inform any endpoint at any port about these events
> and they all react accordingly.

Right, but that implementation/assumption doesn't work so well when you
have 2 Type-C ports which might route to the same bridge (2 lane from each).
The other 2 lanes from the other endpoints can go to (say) a USB HUB.

>
> Perhaps I'm misunderstanding your suggestion, but if you start
> representing each individual lane in the SuperSpeed interface I believe
> you would have to just abandon this interface and replace it with
> something like "give me USB on port@1/endpoint@0 and port@1/endpoint@1
> and give me DP on port@1/endpoint@2 and port@1/endpoint@3".

I don't think that is necessary. The switch driver can register the switches (
and it can find out which end-points map to the same usb-c-connector).

From the port driver, the port driver just needs to tell each switch
registered for it's port that "I want
DP Pin assignment C/ DP Pin assignment D / Plain USB3.x" and the
switch driver(s) can figure out what to output on its pins (since
the Type-C binding will specify ep0 = A2-A3 (TX1), ep1 = B10-B11 , etc)

orientation-switch can tell the switch if the signals need to be swapped around.

The above notwithstanding, it sounds like the 2-ep approach has more support
than 4 ep-approach, so this specific example is moot.
