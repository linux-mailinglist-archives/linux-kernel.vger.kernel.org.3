Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C316146529E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347953AbhLAQUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:20:09 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:49208 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351506AbhLAQTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:19:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F3307CE1EEF;
        Wed,  1 Dec 2021 16:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F6DC53FCC;
        Wed,  1 Dec 2021 16:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638375374;
        bh=ZaZdlBz0Xsjdgk3pyvSsIwdaF4Sv0rsJNE1v08eUN6o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eiriunlJ491shFz7LOviZlqtOEVJY7jXdOIZgEqhb6DMJ0abY+Iod1rwDlclJMME5
         ews3skWjf90TGy4bV1ddWrxfP1hK7sDf1BWbhlGwNshdOUAe3Wfv03SZ0N5AQ+2ca8
         CaVM5RuJwGRlwkEcxruAUTnbC4TxbjwXYwh7AoziGyC4avbgA9O29jfbrrwmLL0IIL
         WsksML3bv4MJv3MmHgQAkKXrNc2HN1pPOCV4hkR4ZKQ8dL/XtGiEjPp+luSzfmRfpV
         ZgUaV5yJayFphWILf9dfvcCLwNNUV/izRBZ5GW/a8MchP/8WKeuzmVSCS1Rr8kfvt2
         VBVmVdx/ChBTw==
Received: by mail-ed1-f51.google.com with SMTP id o20so103287978eds.10;
        Wed, 01 Dec 2021 08:16:14 -0800 (PST)
X-Gm-Message-State: AOAM533hDQ7f6uYGpTYZ83rtv6GYDlUF1r+kAFcnovLlfij94CBnJIES
        n5yy6nCiXpDFwEm/liF6O0B+syikszbzKUPlLQ==
X-Google-Smtp-Source: ABdhPJyp2RtLBEgnS5SuIgFKI/toxLct1YuIUSu3+c1jVNCnnv3ACnOqSAaQYMDF8oMAYqmMFLER8cAPPrhiGdxD6v0=
X-Received: by 2002:a17:907:3f24:: with SMTP id hq36mr8202073ejc.390.1638375371905;
 Wed, 01 Dec 2021 08:16:11 -0800 (PST)
MIME-Version: 1.0
References: <20211130121847.11112-1-a-govindraju@ti.com> <20211130121847.11112-2-a-govindraju@ti.com>
 <YaaGMtE6n0yZNpAI@robh.at.kernel.org> <6e1474bc-038c-43ec-4814-63ad3eca888c@axentia.se>
 <247912b5-e68a-1e97-60c7-0ba21448d3b4@ti.com>
In-Reply-To: <247912b5-e68a-1e97-60c7-0ba21448d3b4@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 1 Dec 2021 10:16:00 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKA-_svfKyeWqoGZUGbhTGmX_4BgNisURUiam7tcmGbBQ@mail.gmail.com>
Message-ID: <CAL_JsqKA-_svfKyeWqoGZUGbhTGmX_4BgNisURUiam7tcmGbBQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mux: Document mux-states property
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 10:32 PM Aswath Govindraju <a-govindraju@ti.com> wrote:
>
> Hi Rob,
>
> On 01/12/21 2:18 am, Peter Rosin wrote:
> >
> >
> > On 2021-11-30 21:14, Rob Herring wrote:
> >> On Tue, Nov 30, 2021 at 05:48:46PM +0530, Aswath Govindraju wrote:
> >>> In some cases, it is required to provide the state to which the mux
> >>> controller has be set to, from the consumer device tree node. Document the
> >>> property mux-states that can be used for adding this support.
> >>
> >> I having a hard time understanding why you need this. One consumer
> >> configures a mux one way and another consumer another way? How do you
> >> arbitrate that? Please elaborate on what 'some cases' are and why it's
> >> required.
> >>
> >> Can't you just add a cell for the 'state' allowing for 1-2 cells
> >> instead of 0-1?
> >
> > A mux controller can control several muxes. That happens e.g. when the
> > same gpio lines are connected to several mux chips in parallel. When
> > you operate one mux, the other parallel muxes just follow along. If
> > these muxes are then used orthogonally, coordination is needed. The real
> > world case I had was I2C and an analog signal connected to an ADC that
> > went through parallel/dependent muxes like this. It is simply not
> > possible to freely mux the I2C bus and the analog signal, they are tied
> > together and dependent and must coordinate their accesses.
> >
> > The addition now is that Aswath wants a mux control client to "point
> > at" a single state instead of the whole mux control, and I see that as
> > a usable addition. It seems like a natural place to specify a single mux
> > state that some driver needs in some circumstance.
> >
> > But, since a mux control is inherently a shared resource (see above),
> > one consumer might need a specific state and some other consumer might
> > need the whole mux control and manage the states as e.g. the existing
> > i2c-mux-gpmux binding is doing. So, you need to be able to specify both
> > ways to point at muxes; either to a single mux state, or to the whole mux
> > control.
> >
> > While you could make the extra cell optional, that does not work for
> > the mux/adi,adg792a binding, since it is using the #mux-control-cells
> > property to determine which mode it should operate its three muxes in.
> > Either with one common/parallel mux control, or with three independent
> > mux controls.
> >
> > So, that binding is already in the 0-1 territory, and adding an optional
> > extra cell makes it 0-1-2 with no way to determine what is intended when
> > the cell count is 1 (three independent mux controls OR one mux control
> > and a state). I see no way to add the extra state to that binding, short
> > of adding an extra property somewhere for that driver, but I simply did
> > not want to go that path because it would get inconsistent when trying
> > to add that in a backwards compatible way. Or rather, that was my
> > conclusion.
> >
> > Suggestions welcome...
> >
>
>
> In addition to what Peter has mentioned, I would like to elaborate on my
> use case for adding this feature. I am trying to implement this feature
> in the TCAN104x transceiver driver, for selecting the mux state to route
> the signals from CAN controller to transceivers on the board. The state
> of the mux line to be set, can change based on the design and this is
> needs to be provided from the device tree. Hence, I am trying to add
> this support for providing the state to be set to the driver from the
> device tree node.

Okay, please add something along the lines of what Peter said for when
you use which binding.

> Also, one more question on regarding DT check errors, may I know what
> should be the order in which the patches need to be posted in order to
> not get the error? This is because mux-states would be a new property to
> be added in the TCAN104x bindings and I thought that it would need to be
> posted after the patch for the changes in mux-controller are merged.

Looks like a circular dependency. Assuming you ran dt_binding_check on
the series, just add a note about the dependency and I won't send the
report.

Rob
