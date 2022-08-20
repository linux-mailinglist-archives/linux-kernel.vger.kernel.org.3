Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B9559AB1A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 06:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241822AbiHTEEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 00:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236400AbiHTEEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 00:04:34 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187BA786FC
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 21:04:32 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-11c896b879bso7269869fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 21:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=J4ges1QP1SvDqTj0E1gs1t7/f2sDDibppIBG9MQZ7oc=;
        b=z8nkR8XdE/UXRaPfqEBXyfJnSbkyZr4N7vE72kmnKaHfkPToXd173sO4H228973FXM
         o6HNDEUPJ6OU6DwzgEb3w5V6SwEYL40JBO+UiOmfLd6vFNFig6ZJ96ocX4VAiOm+Xs1y
         PsA8ELmayCzgAVfppGFnDkf18BaIabUg/xyLred17wh3BDNm1nI4XNlBWffnmnl34m7Y
         gZMvNNgzrVn2RAc48Y6lfEmd9agvuKKI8ZM4lzXU6DIGcMnuHIHMoabjrWVXbkdCf+BW
         x19+Uwi4zl8axvOCJWIoJtQxnmIqnrWAfK8zM3U/+4t1w0Grgv66w9V7sIH6ReYacdw3
         8XnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=J4ges1QP1SvDqTj0E1gs1t7/f2sDDibppIBG9MQZ7oc=;
        b=mrXAL0RP5gUVCXdq5Z6sDg8CZSPOnzZab0TgSvyLWV/L9dsBdbk++setbuO2GdiGLn
         5yfj5+87FougcABwrRoxOctG8x00/H7ak6dtWoKOKkE/pgnq8CbXIlMqrZ6QyjRbts5F
         qAWS/mVa7AcM/sqcy/HN5bgyU8zrdq5wD4qlGIoSAWYUT0WXNuklSjaG07Tyxcc0gLOC
         Ql7REi5/xdoAZbt3UBhgYtvqjT4HYrcXyH7gEUiooDyGP4EghRyH4BkVHH1SNWcDikpQ
         z7zCQnuV71TcUG9wCkI8ylm2hBuqy7bURsv2T9eLQ1CmcnAsuWHRNiTGp2/NoiKTEgeB
         miNQ==
X-Gm-Message-State: ACgBeo12+2oE34HGbq1LrnyYA8diz1JQwOnKkMwHV8eWmk1BHFJP0iME
        BSFHBNPiBYG1sUz4hErZO/Xd9g==
X-Google-Smtp-Source: AA6agR52x2MudBpZMlptyzqQwvA4mYMSCx5OStuX0uPhcge8aAm9KvjZWXEibFzzqjDCmVHM8tungg==
X-Received: by 2002:a05:6870:e313:b0:10e:757c:d388 with SMTP id z19-20020a056870e31300b0010e757cd388mr5163145oad.280.1660968271399;
        Fri, 19 Aug 2022 21:04:31 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s16-20020a056808209000b00339c7af0e8esm1457851oiw.51.2022.08.19.21.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 21:04:30 -0700 (PDT)
Date:   Fri, 19 Aug 2022 23:04:28 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: Re: [PATCH 1/2] dt-bindings: usb: Introduce GPIO-based SBU mux
Message-ID: <YwBdTAIqFbedC6Oa@builder.lan>
References: <20220810204750.3672362-1-bjorn.andersson@linaro.org>
 <20220810204750.3672362-2-bjorn.andersson@linaro.org>
 <a13bce60-25b4-d075-d56a-d1283e91e3ba@linaro.org>
 <20220814210104.GA690892-robh@kernel.org>
 <Yv1y9Wjp16CstJvK@baldur>
 <CAE-0n53AjJ_G6yZoTALWpKvZUdF+8nFZ+TQh=Ch=8xgdMVqDkw@mail.gmail.com>
 <CACeCKadP-AZ8OU4A=7CrwAz7yuLvMvjvAcw7K-FORFmkMvx7cA@mail.gmail.com>
 <CAE-0n53C+D=9gdSXKsjr4KZVrb-gpeo_EyuX3DfNKp19FoicXA@mail.gmail.com>
 <YwADGgNVwtKacUBR@builder.lan>
 <CACeCKaeXpU+AxFNAwkutMX9LT2XLgAv1XmwJRyj7Exqxg6v8rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACeCKaeXpU+AxFNAwkutMX9LT2XLgAv1XmwJRyj7Exqxg6v8rA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19 Aug 17:18 CDT 2022, Prashant Malani wrote:

> On Fri, Aug 19, 2022 at 2:39 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Fri 19 Aug 15:49 CDT 2022, Stephen Boyd wrote:
> >
> > > > I like 2 endpoints to represent the usb-c-connector, but that doesn't seem
> > > > to be compatible (without introducing `data-lanes`, at least) with all
> > > > the various
> > > > combinations on the remote side, if that remote side is a DRM bridge with DP
> > > > output capability (like it6505 or anx7625).
> > > > That type of DRM bridge supports 1, 2 or 4 lane DP connections.
> > >
> > > Why can't the remote side that's a pure DP bridge (it6505) bundle
> > > however many lanes it wants into one endpoint? If it's a pure DP bridge
> > > we should design the bridge binding to have up to 4 endpoints, but
> > > sometimes 2 or 1 and then overlay data-lanes onto that binding so that
> > > we can tell the driver how to remap the lanes if it can. If the hardware
> > > can't support remapping lanes then data-lanes shouldn't be in the
> > > binding.
> 
> 2 endpoints sounds fine to me. The overloading of the bridge-side endpoint
> to mean different things depending on what it's connected to seemed odd to
> me, but if that is acceptable for the bridge binding, then great.
> 
> > The existing implementation provides the interfaces usb_role_switch,
> > usb_typec_mux and usb_typec_switch. These works based on the concept
> > that the USB Type-C controller will request the endpoints connected to
> > the usb-c-connector about changes such as "switch to host mode", "switch
> > to 2+2 USB/DP combo" and "switch orientation to reverse". We use this
> > same operations to inform any endpoint at any port about these events
> > and they all react accordingly.
> 
> Right, but that implementation/assumption doesn't work so well when you
> have 2 Type-C ports which might route to the same bridge (2 lane from each).
> The other 2 lanes from the other endpoints can go to (say) a USB HUB.
> 

Are you saying that two of your SS-lanes in connector A are connected to
directly to the QMP PHY at the same time as two SS-lanes from connector
B are connected to the same two pads on the QMP PHY - without any
mux etc inbetween?

I.e. that there are a set of pins in connector A which is directly
connected to a set of pins in connector B?


I was under the impression that in your hardware there's some component
muxing the single DP output to one of the connectors. If so there should
be no graph-link directly connecting the two usb-c-connectors and the
one QMP PHY.

Is this not the case?

> >
> > Perhaps I'm misunderstanding your suggestion, but if you start
> > representing each individual lane in the SuperSpeed interface I believe
> > you would have to just abandon this interface and replace it with
> > something like "give me USB on port@1/endpoint@0 and port@1/endpoint@1
> > and give me DP on port@1/endpoint@2 and port@1/endpoint@3".
> 
> I don't think that is necessary. The switch driver can register the switches (
> and it can find out which end-points map to the same usb-c-connector).
> 
> From the port driver, the port driver just needs to tell each switch
> registered for it's port that "I want
> DP Pin assignment C/ DP Pin assignment D / Plain USB3.x" and the
> switch driver(s) can figure out what to output on its pins (since
> the Type-C binding will specify ep0 = A2-A3 (TX1), ep1 = B10-B11 , etc)
> 
> orientation-switch can tell the switch if the signals need to be swapped around.
> 

In a typical Qualcomm design the QMP PHY is directly connected to the
usb-c-connector and as such it is the component that implements
usb_typec_mux and usb_typec_switch.

Regards,
Bjorn

> The above notwithstanding, it sounds like the 2-ep approach has more support
> than 4 ep-approach, so this specific example is moot.
