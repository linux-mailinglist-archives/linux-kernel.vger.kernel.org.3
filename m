Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CC059AB13
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 05:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242642AbiHTDvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 23:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239183AbiHTDvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 23:51:40 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA55A1D37
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 20:51:38 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id h20-20020a056830165400b00638ac7ddba5so4274940otr.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 20:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc;
        bh=L4LQq9ZiQUaroimGlzeoUFjuhdTUOaqqkmWPHnxseFY=;
        b=BPGZDmIPe1jPuPONKIj7gLIRcIvNFGGBHb45LeaQIzMAaGJ1QJKjs2VMOSKhwWY+uH
         RBifVtNJquYr2gURTzcEPoZb4NrFEaCqr90n/+z6un0nK2YqJMwarlxmLOhJMBfuXg8s
         eydV8DQEnfXf2TD2ZNlnTrPULryp0aO5lCzOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc;
        bh=L4LQq9ZiQUaroimGlzeoUFjuhdTUOaqqkmWPHnxseFY=;
        b=gcuMrvRj0/9Bu1o0sadS5Vp3MT8Df1PTdqdS1O63a84SHJDVNDJ06dz77nVl3u4Xcu
         ysi4+HUnPtyLJFwHD0fIEr+Uumc6qD4I3lfyoBxIgoMSAzXg3VsLkyGSooYQrMTZL0aZ
         E3kt+MMcEOb6OKQSmc3gGHo44wetpPV+VeynZraURXqtSc3LNhLfC8wFkFRr3ek9TcoZ
         1WxhOeYZIO47rPKnQvm1xfCeJOzzn/fQVrralKNI5zt4AnlN0atqq/ZskBfDv3T6YbYN
         CjTU4QTQNQ6thg9etHLx9Zgdva6tZLcZ+QlqF6s0Mdlr4JpXoUELH4KGTW46vn9Zt3QC
         pUtw==
X-Gm-Message-State: ACgBeo3h9Dg8OkP4Y7S72pQZrVzDYVFYrG19sej2hbBp347aINij/tj+
        1aoP487Ub+IeOMK8qMEyL3h+FFV6x7W5XtlO6CeWPg==
X-Google-Smtp-Source: AA6agR5I2uMwZ82br710X0015NqATxm2krDBvum/SN0SQ7s/TD5SOFz5gjyD8uKE2vhdnbtp/oyK59c9NEaj+wqETcQ=
X-Received: by 2002:a9d:738c:0:b0:638:9962:8cb6 with SMTP id
 j12-20020a9d738c000000b0063899628cb6mr4081543otk.73.1660967497646; Fri, 19
 Aug 2022 20:51:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 Aug 2022 22:51:36 -0500
MIME-Version: 1.0
In-Reply-To: <YwAACIKvNtHtyL6o@builder.lan>
References: <20220810204750.3672362-1-bjorn.andersson@linaro.org>
 <20220810204750.3672362-2-bjorn.andersson@linaro.org> <a13bce60-25b4-d075-d56a-d1283e91e3ba@linaro.org>
 <20220814210104.GA690892-robh@kernel.org> <Yv1y9Wjp16CstJvK@baldur>
 <CAE-0n53AjJ_G6yZoTALWpKvZUdF+8nFZ+TQh=Ch=8xgdMVqDkw@mail.gmail.com> <YwAACIKvNtHtyL6o@builder.lan>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 19 Aug 2022 22:51:36 -0500
Message-ID: <CAE-0n527ASkKgmoUV_MnmA3qwA+KKjQeWafwRHAvY5026gdBCw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: usb: Introduce GPIO-based SBU mux
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>,
        Pin-yen Lin <treapking@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I realize I've hijacked this thread to discuss the QMP binding :-/

Quoting Bjorn Andersson (2022-08-19 14:26:32)
> On Thu 18 Aug 20:09 CDT 2022, Stephen Boyd wrote:
>
> > Quoting Bjorn Andersson (2022-08-17 16:00:05)
> > >
> > > This is the setup that we're dealing with:
> > >
> > >                      +------------- - -
> > >  USB connector       | SoC
> > >  +-+                 |
> > >  | |                 |   +-----+
> > >  |*|<------- HS -----|-->| HS  |
> > >  |*|<------- HS -----|-->| phy |<-+   +--------+
> > >  | |                 |   +-----+   \->|        |
> > >  | |                 |                |  dwc3  |
> > >  | |                 |   +-----+   /->|        |
> > >  |*|<------- SS -----|-->|     |<-+   +--------+
> > >  |*|<------- SS -----|-->| QMP |
> > >  |*|<------- SS -----|-->| phy |
> > >  |*|<------- SS -----|-->|     |<-\   +------------+
> > >  | |                 |   +-----+   \->|            |
> > >  | |                 |                |     DP     |
> > >  | |    +-----+      |                | controller |
> > >  |*|<-->| SBU |<-----|--------------->|            |
> > >  |*|<-->| mux |<-----|--------------->|            |
> > >  | |    +----+       |                +------------+
> > >  +-+                 |
> > >                      +------------- - -
> > >
[...]
> > I'd expect the QMP phy to physically be the only thing connected on the
> > board. That matches the block diagram above. Inside the SoC the SS lines
> > will be muxed through the QMP phy to the DP controller or the USB
> > controller. Therefore, in the binding I'd expect there to be a single
> > port@1 for the connector:
> >
> >       port@1 {
> >               reg = <1>;
> >               endpoint@0 {
> >                       reg = <0>;
> >                       remote-endpoint = <&qmp_phy>;
> >               };
> >       };
> >
>
> That is correct, the 4 SS pairs in the USB connector are connected to
> the QMP PHY pads.
>
>
> The second endpoint in port@1 comes from my RFC where I suggested adding
> a 4th port to the usb-c-connector for connecting the usb-c-connector to
> the DP controller for passing the virtual HPD signal. Rob suggested that
> this indication relates to the SS pins and wanted this to be part of
> port@1. But it's not actually a definition of any electrical connection.

I suspect this is the root of the debate. Should the binding be
describing logical connections between components or actual physical
connections? And should the connector binding have endpoints for
different altmodes, e.g. DP?

What do we do if thunderbolt support is yet another PHY that sits behind
the QMP phy? Do we need to make yet another endpoint in the
usb-c-connector to represent this connection? I hope not.

The QMP phy is doing type-c "muxing" of different PHYs (USB and DP) onto
the SS lanes. Other altmodes that want to use the SS lanes would
similarly need to be routed through the QMP phy and muxed onto the lanes
when the altmode is used, e.g. thunderbolt. While it is certainly
convenient to have a "DP" endpoint in the usb-c-connector, I feel that
it is wrong, primarily because the DP phy has the QMP phy in between it
and the usb-c-connector, but also because DP is an altmode/virtual
construct built on top of the 4 lanes in the typec pinout.

We should look at the binding from the perspective of the connector and
figure out how the pinout can be mapped to the binding. That would allow
board designers to ignore the internal SoC details, and stay focused on
what is in the schematic, which is the qmp phy and the usb-c-connector
in this case. My understanding is that two SS lanes always have to go
together in the type-c spec, hence the two endpoints in the graph, but
if all the SS lanes are physically wired to the same PHY then we can
omit the second endpoint and use data-lanes if for example DP is handled
by a different phy.

>
> > Other designs only connect two lanes to the qmp phy and the other two
> > connect to a USB hub. That's where it gets interesting because we don't
> > know how to represent that. Do we make two endpoints in the
> > usb-c-connector port@1 and split the SS lines into SS RX1/TX1 and SS
> > RX2/TX2 pairs? Or do we use data-lanes to represent the SS lines? If we
> > make two endpoints then do we need to have two endpoints all the time
> > even though in this 4 SS line design it is redundant?
> >
> >       port@1 {
> >               reg = <1>;
> >               endpoint@0 { // Represents RX1/TX1
> >                       reg = <0>;
> >                       remote-endpoint = <&qmp_phy_lanes01>;
> >               };
> >               endpoint@1 { // Represents RX2/TX2
> >                       reg = <1>;
> >                       remote-endpoint = <&qmp_phy_lanes23>;
> >               };
> >       };
> >
>
> So on the other side of that PHY we would have a multi-port USB
> controller, or two USB controllers?

I'm thinking of a single USB+DP PHY.

> Either way, this seems like a proper
> representation of the two different ports, but not something we can do
> with the QMP.

This example I gave is for the usb-c-connector, hence the
remote-endpoint pointing to the USB+DP PHY "bundled lanes" endpoints for
0+1 and 2+3. Sorry if that wasn't clear.

>
> The QMP phy has certain ability to swap the signals around, so it's
> conceivable that a data-lanes property in the outgoing port definition
> could be used to reorder the SS lanes...
>
> But it would be unrelated to the USB vs DP selection in my view.
>
> All we want here is a connection between the usb-c-connector and the QMP
> phy, such that the usb-c-connector's Type-C controller can inform the
> QMP what has been negotiated.

Ok. By Type-C controller you mean the typec manager? Is that all Linux
for you?

>
> > >
> > >     port@2 {
> > >       reg = <2>;
> > >       endpoint {
> > >         remote-endpoint = <&sbu_mux>;
> > >       };
> > >     };
> > >   };
> > > };
> > >
> > > This allows the USB Type-C controller to:
> > > 1) Perform USB role switching in the dwc3 on port@0
> > > 2) Orientation and muxing of the SuperSpeed lines in the QMP phy on
> > >    port@1:0, implement a drm_bridge for signalling HPD back to the DP
> > >    controller on port@1:1
> >
> > We may need to have a port connection from the DP controller to the QMP
> > phy. But given that the DP controller already has a 'phys' phandle to
> > the QMP phy I think the DP controller driver could try to link to a drm
> > bridge created in the phy driver that mainly handles the HPD signaling
> > and any lane muxing/routing that needs to happen when DP pin
> > configuration is present.
> >
>
> The QMP has no knowledge of HPD signalling in Type-C, it's strictly a
> virtual thing living in the Type-C controller. The Type-C controller
> will request mux changes from the QMP and HPD signal changes as two
> completely independent events.
>
> Implementing a drm_bridge in the implementation backing the
> usb-c-connector mimics e.g. dp-connector (implemented in
> drivers/gpu/drm/bridge/display-connector.c) nicely.
>
> Implementing the drm_bridge in the QMP phy means that we just add state
> tracking for something that it doesn't know, hence we need another
> mechanism to the Type-C controller to inform the phy that the HPD signal
> has changed.

Ok, so the idea is to make a drm bridge in the device registering the
usb-c-connector? Doesn't the qmp_phy register the usb-c-connector for
you? I'm not really following along on this part.

On your design I believe the QMP phy is a mode-switch and an
orientation-switch. The orientation-switch is implemented as some bit in
the QMP registers to flip the SS lanes and the mode-switch is
implemented somehow that I don't really understand. Probably the QMP can
shut off USB for 4 lanes DP over the SS lanes? I recall some bit for the
different modes is in the QMP registers.

Or is the idea to make the USB (dwc3) and DP (msm_dp) controllers call
phy framework APIs to change the qmp mode (USB, DP, or USB+DP)?

>
>
> This is analog to the case you have today, where the QMP has no
> knowledge of the GPIO pin that carries the HPD state in your design.

Indeed, in my design the QMP configuration is "fixed" and two lanes are
dedicated for DP while another two lanes are dedicated to USB. The USB
lanes go to a USB hub and the hub ports are connected to two different
usb-c-connectors. The DP lanes go to another mux (similar to the SBU mux
logically) and the two lanes are muxed to one of the two
usb-c-connectors depending on what the typec manager decides. The HPD
signal bypasses QMP and goes directly to the DP controller (msm_dp) via
a GPIO. The HPD signal could just as easily be virtual like in your
design, but we use a GPIO for now.

For the QMP driver to figure this out it will need to be able to parse
the graph properties or we'll need more properties to describe the
configuration. I was hoping we could describe this solely through the
graph binding. We can probably do it by having reg numbered
ports/endpoints in the QMP's ports binding to represent the USB or DP
functionality (e.g. reg 0 is USB and reg 1 is DP) and then use
'data-lanes' to represent the number of lanes being used for that
functionality (and also if they're remapped). Someone needs to write out
all possible combinations and make sure the QMP binding can handle them
all. If the ports binding isn't present then the driver should default
to existing behavior (2 lanes DP, 2 lanes USB, normal orientation, no
lane remapping). When they do this they should also consider static
configurations that differ from the default, where the QMP doesn't flip
the lines and/or change modes. That would allow hardware engineers to
reroute lanes if that makes signal integrity better.

I expect that having the device registering the usb-c-connector make the
drm bridge would work on ChromeOS. We would have the cros-ec-typec
driver register the drm bridge(s) and notify HPD to the DP controller(s)
through the drm bridge instead of using the GPIO path. We'd have to
figure out how to express the connection to the dp controller in DT so
when it searches for the next bridge it can find the one made in
cros-ec-typec.

>
[...]
> >
> > So should we explicitly have two endpoints in the usb-c-connector for
> > the two pairs all the time, or should we represent that via data-lanes
> > and only split up the connector's endpoint if we need to connect the
> > usb-c-connector to two different endpoints?
>
> I think the endpoint of port@1 should represent the set of signals
> connected to the other side, in our case 1:1 with the QMP. I like the
> idea of adding data-lanes to the QMP side in order to describe any
> swapping of the pads, but I see that as a separate thing.
>
> If you have a design where your usb-c-connector is wired to two
> different PHYs and you have a Type-C controller that only negotiates the
> 2+2 mode, then I think it makes sense to represent that as two endpoint
> of port@1 - but the QMP side would only reference one of these
> endpoints.
>

Agreed. I think that means at most two endpoints are possible in port@1
in the usb-c-connector binding. We would only use the second endpoint if
we had two different PHYs that required it, otherwise only a single
endpoint.
