Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945D859A7CB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 23:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbiHSVjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 17:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbiHSVjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 17:39:43 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E85F18396
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:39:42 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id a14-20020a0568300b8e00b0061c4e3eb52aso3897958otv.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=AGzxcMpgy1f3HMy9tWyYqtgpJAs8k+s3vJqDIzylNVA=;
        b=E51P8ViaWVLX0jvYrxKZAm3vBcmNKWYZW6dAPGUlDQroZS+kgFOq72BAJUIzo0ysnd
         LMZsX0P1+GPJob6JcSzn/efbznML58TYnNnfcjwV2Xaop0dBkMin0wxlOwhmDsL4Gj++
         MHI6OKrm2UD2vylNZLgeqOybpNb+JgsMVEokXO79/AMSY19zPlzcKuwmIej34A4jbqic
         q1FTUX84t5sz77stj2RIeOiPPu8QRceOWkk1mZrIx9kL6878ianqAjRlHHhzEJOG2q6P
         YCprk/LSMcpkreXgN9oX0ziT8CcPYnogkT6+9WGcxNcl3mx1X80F5fOfBljHN1bhY0Ks
         IERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=AGzxcMpgy1f3HMy9tWyYqtgpJAs8k+s3vJqDIzylNVA=;
        b=caExouuuApeKwDse+N1QTVeFgHiAuMKOA+Cm1YWQG7PlthG4IBkPYsUkWNVusbluDz
         OVgNdT6Xb4ctYEOIRneop4ggLpIFSRM5jRIc8T6BNN/4kN8hJH0Jd1TBZcY2RWT8QCVM
         /GtX4Rb6hdnAnLfaE5MKB+F3zofp35mLuwxYy6Fc1dL5e5DQk3Qb1pEV26MTTd4ba94l
         XJ+IXJ56p5X0lH53aiiCc/ijZb+lc+QjRVopKgpCY784H2KnQUcTCY7MJrasNX+qxboI
         h2XjI1q5qOKZ3azjpXhY4eZkDxeh2Opq/gU/4p7Rzjmpu9k/Kw0D5AIpIMMP0Iyoipam
         L9Ig==
X-Gm-Message-State: ACgBeo1VZcVTpd3nX8BkX49+IN2IMS//Kd72gu1FGJ7Un2nOavKzd8+4
        L3Jh4wO+wPBP8PT6ikJRZdyJQw==
X-Google-Smtp-Source: AA6agR4fKET4Xlnj9XFWaJpgToogMvlTL7ry/CzHPdCJ2np554jHWijse9yBvrmkpPwz9nynp46fbA==
X-Received: by 2002:a05:6830:1cc8:b0:618:ebac:c43f with SMTP id p8-20020a0568301cc800b00618ebacc43fmr3728480otg.45.1660945181376;
        Fri, 19 Aug 2022 14:39:41 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 3-20020a9d0b83000000b0063706889f89sm1409174oth.8.2022.08.19.14.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 14:39:40 -0700 (PDT)
Date:   Fri, 19 Aug 2022 16:39:38 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Prashant Malani <pmalani@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: Re: [PATCH 1/2] dt-bindings: usb: Introduce GPIO-based SBU mux
Message-ID: <YwADGgNVwtKacUBR@builder.lan>
References: <20220810204750.3672362-1-bjorn.andersson@linaro.org>
 <20220810204750.3672362-2-bjorn.andersson@linaro.org>
 <a13bce60-25b4-d075-d56a-d1283e91e3ba@linaro.org>
 <20220814210104.GA690892-robh@kernel.org>
 <Yv1y9Wjp16CstJvK@baldur>
 <CAE-0n53AjJ_G6yZoTALWpKvZUdF+8nFZ+TQh=Ch=8xgdMVqDkw@mail.gmail.com>
 <CACeCKadP-AZ8OU4A=7CrwAz7yuLvMvjvAcw7K-FORFmkMvx7cA@mail.gmail.com>
 <CAE-0n53C+D=9gdSXKsjr4KZVrb-gpeo_EyuX3DfNKp19FoicXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n53C+D=9gdSXKsjr4KZVrb-gpeo_EyuX3DfNKp19FoicXA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19 Aug 15:49 CDT 2022, Stephen Boyd wrote:

> Quoting Prashant Malani (2022-08-19 13:14:25)
> > > This would do that for us, but when all four lanes are connected from
> > > the qmp phy directly to the connector we could just as easily have done
> > > it with one endpoint.
> > >
> > >         qmp_phy {
> > >                 ports {
> > >                         port@0 {
> > >                                 reg = <0>;
> > >                                 endpoint@0 {
> > >                                         reg = <0>;
> > >                                         remote-endpoint = <&usb_c_ss>;
> > >                                         data-lanes = <1 2 3 0>
> > >                                 };
> > >                         };
> > >                 };
> > >         };
> > >
> > > So should we explicitly have two endpoints in the usb-c-connector for
> > > the two pairs all the time, or should we represent that via data-lanes
> > > and only split up the connector's endpoint if we need to connect the
> > > usb-c-connector to two different endpoints?
> >
> > I like 2 endpoints to represent the usb-c-connector, but that doesn't seem
> > to be compatible (without introducing `data-lanes`, at least) with all
> > the various
> > combinations on the remote side, if that remote side is a DRM bridge with DP
> > output capability (like it6505 or anx7625).
> > That type of DRM bridge supports 1, 2 or 4 lane DP connections.
> 
> Why can't the remote side that's a pure DP bridge (it6505) bundle
> however many lanes it wants into one endpoint? If it's a pure DP bridge
> we should design the bridge binding to have up to 4 endpoints, but
> sometimes 2 or 1 and then overlay data-lanes onto that binding so that
> we can tell the driver how to remap the lanes if it can. If the hardware
> can't support remapping lanes then data-lanes shouldn't be in the
> binding.
> 

I don't see why we would want to further complicate the of_graph by
representing each signal pair between two fixed endpoint as individual
endpoints.

Let's describe the connections between the components, not the signals.

> >
> > So, how about 4 endpoints (1 for each SS lane) in the usb-c-connector port@1?
> > That should support every conceivable configuration and bridge/PHY hardware.
> > and also allows a way to specify any lane remapping (similar to what
> > "data lanes" does)
> > if that is required.
> > Then we are consistent with what an endpoint represents, regardless of whether
> > the DRM bridge has a DP panel (1,2 or 4 lane) or Type-C connector  (2
> > or 4 lane) on its output side.
> 
> I'd like to think in terms of the usb-c-connector, where the DP altmode
> doesn't support one lane of DP and USB is only carried across two SS
> lanes. Essentially, two SS lanes are always together, hence the idea
> that we should have two endpoints in the SS port@1. In the simple case
> above it seems we can get away with only one endpoint in the SS port@1
> which is probably fine? I just don't know how that is represented in the
> schema, but I suspect making another endpoint optional in the SS port@1
> is the way to go.
> 
> Will there ever be a time when all 4 usb-c-connector remote-endpoint
> phandles point to endpoints that are child nodes of different ports
> (i.e. different qmp_phy nodes) with a 4 endpoint schema? I don't think
> that is possible, so 4 endpoints is flexible but also verbose. It also
> means we would have to walk the endpoints to figure out lane remapping,
> wheres we can simply find the endpoint in the DP bridge ports and look
> at data-lanes directly.

The existing implementation provides the interfaces usb_role_switch,
usb_typec_mux and usb_typec_switch. These works based on the concept
that the USB Type-C controller will request the endpoints connected to
the usb-c-connector about changes such as "switch to host mode", "switch
to 2+2 USB/DP combo" and "switch orientation to reverse". We use this
same operations to inform any endpoint at any port about these events
and they all react accordingly.

Perhaps I'm misunderstanding your suggestion, but if you start
representing each individual lane in the SuperSpeed interface I believe
you would have to just abandon this interface and replace it with
something like "give me USB on port@1/endpoint@0 and port@1/endpoint@1
and give me DP on port@1/endpoint@2 and port@1/endpoint@3".

I presume that such an interface would work, but I'm afraid I don't see
the merits of it and we would have to replace the Linux implementation.

Regards,
Bjorn
