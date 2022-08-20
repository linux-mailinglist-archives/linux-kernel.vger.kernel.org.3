Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D9159AB6B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 06:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbiHTE41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 00:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiHTE4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 00:56:23 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367EB13E3B
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 21:56:21 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id t8so6807613oie.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 21:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=ss50zls7pSPvq5Fjx77XG7M5EwKouXU6x7pEaCV/iY8=;
        b=W35KIyAspiN8REuMGzeVD2SZavag3gQ2+7sTMc3A87CDfZEY66DTUgoZsxmgB1Y9eI
         r7T6S4SRPEoXORS4zKqMKzjI8BTPTRpJVE62+I5hKICqwvAYQij8AZgJJchNojOBaTZ2
         P/cfHCIX9qBZ0tTJm9ZdXq2+PQ10Lv6OXz1ScYKtM/Mt1uQ1IpLqGzUsgKcTkiSHGgMT
         /1BVf9k4QnZ3QTutp9PKC4M8xmDC6Tbx6RXXJ4dztszNNngwSufD8QG7gyStQDSY93Nq
         lfKxW3DbD8wFUb5jLByaBcHO9iK8M1TKBHCGC4DEHAtniqsv5wgzYdUjH+FeYSwtojuV
         +RXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ss50zls7pSPvq5Fjx77XG7M5EwKouXU6x7pEaCV/iY8=;
        b=xMAGVswFC77jgbmXaiK69jd2MLLa3ESurlaRhM73D6HqfPqXrkilJkIgjuld/l4EYg
         78QhW8NgIXUScrbAVSJ1v7DYHHaDPr9j7NsBfGxlVdXIoqusktISsTCZT2phkpooJ5jO
         jyAsN46TqyZpApQFLSNdK7Bv8xcxccoocbwjcqlc6zvxgf76algt0MNht4Sfjqspzc2u
         Y0M3v8kAmWGkgsJQ/Tgpg8ao9pDjClplHAjrUhZZHyTR5UhZv8xz8gleyUjRdHn0HeiL
         M662LOmdUBrW+C2UhU0tV2YkMv2hy2r84dZI3eDTwpvmLng29qxaE7VBwA2f3jvFycNE
         s+/w==
X-Gm-Message-State: ACgBeo00/aYDqJGACilzI5adHmc+LqpYVZcd9jsC/zeGV+nj60OpZyHc
        4UmFt8IQLgKoUHVWScgywuxNIEBYyRKckg==
X-Google-Smtp-Source: AA6agR55efobIMhmPBeKWL7OL5TP0WmNiu5V22hQs6e2HRcb7kKsXjMwX7o95j2PKlBvGlwrzuYWtA==
X-Received: by 2002:a05:6808:124a:b0:32c:45f0:5011 with SMTP id o10-20020a056808124a00b0032c45f05011mr4810369oiv.217.1660971380236;
        Fri, 19 Aug 2022 21:56:20 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q206-20020aca43d7000000b0033b31480f38sm1499771oia.34.2022.08.19.21.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 21:56:19 -0700 (PDT)
Date:   Fri, 19 Aug 2022 23:56:17 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>,
        Pin-yen Lin <treapking@chromium.org>
Subject: Re: [PATCH 1/2] dt-bindings: usb: Introduce GPIO-based SBU mux
Message-ID: <YwBpcY2s+T1t4elN@builder.lan>
References: <20220810204750.3672362-1-bjorn.andersson@linaro.org>
 <20220810204750.3672362-2-bjorn.andersson@linaro.org>
 <a13bce60-25b4-d075-d56a-d1283e91e3ba@linaro.org>
 <20220814210104.GA690892-robh@kernel.org>
 <Yv1y9Wjp16CstJvK@baldur>
 <CAE-0n53AjJ_G6yZoTALWpKvZUdF+8nFZ+TQh=Ch=8xgdMVqDkw@mail.gmail.com>
 <YwAACIKvNtHtyL6o@builder.lan>
 <CAE-0n527ASkKgmoUV_MnmA3qwA+KKjQeWafwRHAvY5026gdBCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n527ASkKgmoUV_MnmA3qwA+KKjQeWafwRHAvY5026gdBCw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19 Aug 22:51 CDT 2022, Stephen Boyd wrote:

> I realize I've hijacked this thread to discuss the QMP binding :-/
> 
> Quoting Bjorn Andersson (2022-08-19 14:26:32)
> > On Thu 18 Aug 20:09 CDT 2022, Stephen Boyd wrote:
> >
> > > Quoting Bjorn Andersson (2022-08-17 16:00:05)
> > > >
> > > > This is the setup that we're dealing with:
> > > >
> > > >                      +------------- - -
> > > >  USB connector       | SoC
> > > >  +-+                 |
> > > >  | |                 |   +-----+
> > > >  |*|<------- HS -----|-->| HS  |
> > > >  |*|<------- HS -----|-->| phy |<-+   +--------+
> > > >  | |                 |   +-----+   \->|        |
> > > >  | |                 |                |  dwc3  |
> > > >  | |                 |   +-----+   /->|        |
> > > >  |*|<------- SS -----|-->|     |<-+   +--------+
> > > >  |*|<------- SS -----|-->| QMP |
> > > >  |*|<------- SS -----|-->| phy |
> > > >  |*|<------- SS -----|-->|     |<-\   +------------+
> > > >  | |                 |   +-----+   \->|            |
> > > >  | |                 |                |     DP     |
> > > >  | |    +-----+      |                | controller |
> > > >  |*|<-->| SBU |<-----|--------------->|            |
> > > >  |*|<-->| mux |<-----|--------------->|            |
> > > >  | |    +----+       |                +------------+
> > > >  +-+                 |
> > > >                      +------------- - -
> > > >
> [...]
> > > I'd expect the QMP phy to physically be the only thing connected on the
> > > board. That matches the block diagram above. Inside the SoC the SS lines
> > > will be muxed through the QMP phy to the DP controller or the USB
> > > controller. Therefore, in the binding I'd expect there to be a single
> > > port@1 for the connector:
> > >
> > >       port@1 {
> > >               reg = <1>;
> > >               endpoint@0 {
> > >                       reg = <0>;
> > >                       remote-endpoint = <&qmp_phy>;
> > >               };
> > >       };
> > >
> >
> > That is correct, the 4 SS pairs in the USB connector are connected to
> > the QMP PHY pads.
> >
> >
> > The second endpoint in port@1 comes from my RFC where I suggested adding
> > a 4th port to the usb-c-connector for connecting the usb-c-connector to
> > the DP controller for passing the virtual HPD signal. Rob suggested that
> > this indication relates to the SS pins and wanted this to be part of
> > port@1. But it's not actually a definition of any electrical connection.
> 
> I suspect this is the root of the debate. Should the binding be
> describing logical connections between components or actual physical
> connections? And should the connector binding have endpoints for
> different altmodes, e.g. DP?
> 
> What do we do if thunderbolt support is yet another PHY that sits behind
> the QMP phy? Do we need to make yet another endpoint in the
> usb-c-connector to represent this connection? I hope not.
> 

It sounds like you would be comfortable with expressing the relationship
between the usb-c-connector and the QMP PHY in this design and then
express the relationship between the QMP and the thunderbolt separately,
forcing the QMP implementation to bridge any operations needed.

I've not looked enough at such design to argue for or against that, but
I can definitely see the merit of having the usb-c-connector graph be
linked to the component in the SoC that owns the pads - and not
everything behind that.

> The QMP phy is doing type-c "muxing" of different PHYs (USB and DP) onto
> the SS lanes. Other altmodes that want to use the SS lanes would
> similarly need to be routed through the QMP phy and muxed onto the lanes
> when the altmode is used, e.g. thunderbolt. While it is certainly
> convenient to have a "DP" endpoint in the usb-c-connector, I feel that
> it is wrong, primarily because the DP phy has the QMP phy in between it
> and the usb-c-connector, but also because DP is an altmode/virtual
> construct built on top of the 4 lanes in the typec pinout.
> 
> We should look at the binding from the perspective of the connector and
> figure out how the pinout can be mapped to the binding. That would allow
> board designers to ignore the internal SoC details, and stay focused on
> what is in the schematic, which is the qmp phy and the usb-c-connector
> in this case. My understanding is that two SS lanes always have to go
> together in the type-c spec, hence the two endpoints in the graph, but
> if all the SS lanes are physically wired to the same PHY then we can
> omit the second endpoint and use data-lanes if for example DP is handled
> by a different phy.
> 

There is nothing in the schematics representing how the HPD signal comes
from the Type-C controller to the DP controller - but it is a M:N
relationship, so we must represent it in some way.

I suggested a new port for describing this virtual connection, Rob asked
for it to be a separate endpoint in port@1. I'm fine with either path.

But as Benson described to us, we do muxing of the signals in one
operation and we do HPD signalling in a completely separate operation -
from the Type-C controller's PoV. As such the QMP has nothing to do with
the HPD signal.

> >
> > > Other designs only connect two lanes to the qmp phy and the other two
> > > connect to a USB hub. That's where it gets interesting because we don't
> > > know how to represent that. Do we make two endpoints in the
> > > usb-c-connector port@1 and split the SS lines into SS RX1/TX1 and SS
> > > RX2/TX2 pairs? Or do we use data-lanes to represent the SS lines? If we
> > > make two endpoints then do we need to have two endpoints all the time
> > > even though in this 4 SS line design it is redundant?
> > >
> > >       port@1 {
> > >               reg = <1>;
> > >               endpoint@0 { // Represents RX1/TX1
> > >                       reg = <0>;
> > >                       remote-endpoint = <&qmp_phy_lanes01>;
> > >               };
> > >               endpoint@1 { // Represents RX2/TX2
> > >                       reg = <1>;
> > >                       remote-endpoint = <&qmp_phy_lanes23>;
> > >               };
> > >       };
> > >
> >
> > So on the other side of that PHY we would have a multi-port USB
> > controller, or two USB controllers?
> 
> I'm thinking of a single USB+DP PHY.
> 
> > Either way, this seems like a proper
> > representation of the two different ports, but not something we can do
> > with the QMP.
> 
> This example I gave is for the usb-c-connector, hence the
> remote-endpoint pointing to the USB+DP PHY "bundled lanes" endpoints for
> 0+1 and 2+3. Sorry if that wasn't clear.
> 
> >
> > The QMP phy has certain ability to swap the signals around, so it's
> > conceivable that a data-lanes property in the outgoing port definition
> > could be used to reorder the SS lanes...
> >
> > But it would be unrelated to the USB vs DP selection in my view.
> >
> > All we want here is a connection between the usb-c-connector and the QMP
> > phy, such that the usb-c-connector's Type-C controller can inform the
> > QMP what has been negotiated.
> 
> Ok. By Type-C controller you mean the typec manager? Is that all Linux
> for you?
> 

I mean the entity that tells the remote-endpoints of the usb-c-connector
about the outcome of USB PD negotiations. This might be implemented
fully in Linux or partially in firmware.

But this something will be the thing that ultimately calls
typec_switch_set() et al.


Can you please elaborate on the operations you see that the typec
manager would perform on the remote-endpoint of endpoint@0 and
endpoint@1?

> >
> > > >
> > > >     port@2 {
> > > >       reg = <2>;
> > > >       endpoint {
> > > >         remote-endpoint = <&sbu_mux>;
> > > >       };
> > > >     };
> > > >   };
> > > > };
> > > >
> > > > This allows the USB Type-C controller to:
> > > > 1) Perform USB role switching in the dwc3 on port@0
> > > > 2) Orientation and muxing of the SuperSpeed lines in the QMP phy on
> > > >    port@1:0, implement a drm_bridge for signalling HPD back to the DP
> > > >    controller on port@1:1
> > >
> > > We may need to have a port connection from the DP controller to the QMP
> > > phy. But given that the DP controller already has a 'phys' phandle to
> > > the QMP phy I think the DP controller driver could try to link to a drm
> > > bridge created in the phy driver that mainly handles the HPD signaling
> > > and any lane muxing/routing that needs to happen when DP pin
> > > configuration is present.
> > >
> >
> > The QMP has no knowledge of HPD signalling in Type-C, it's strictly a
> > virtual thing living in the Type-C controller. The Type-C controller
> > will request mux changes from the QMP and HPD signal changes as two
> > completely independent events.
> >
> > Implementing a drm_bridge in the implementation backing the
> > usb-c-connector mimics e.g. dp-connector (implemented in
> > drivers/gpu/drm/bridge/display-connector.c) nicely.
> >
> > Implementing the drm_bridge in the QMP phy means that we just add state
> > tracking for something that it doesn't know, hence we need another
> > mechanism to the Type-C controller to inform the phy that the HPD signal
> > has changed.
> 
> Ok, so the idea is to make a drm bridge in the device registering the
> usb-c-connector? Doesn't the qmp_phy register the usb-c-connector for
> you? I'm not really following along on this part.
> 

No, it's not a part of the QMP.

We want to use the graph from the usb-c-connector to signal the provider
of HS, SS and SBU-signals about changes related to the connector. As
such we associate the usb-c-connector with the Type-C
manager/controller.

Like described here, for a single usb-c-connector:
https://lore.kernel.org/all/20220818031512.319310-2-bjorn.andersson@linaro.org/

In this case, the pmic_glink firmware will send Linux messages which can
be directly translated to a set of typec_mux_set(), typec_switch_set()
and drm_bridge_hpd_notify() calls - with the graph defining which remote
components should receive these events.

> On your design I believe the QMP phy is a mode-switch and an
> orientation-switch. The orientation-switch is implemented as some bit in
> the QMP registers to flip the SS lanes and the mode-switch is
> implemented somehow that I don't really understand. Probably the QMP can
> shut off USB for 4 lanes DP over the SS lanes? I recall some bit for the
> different modes is in the QMP registers.
> 

Correct, typec_mux_set() passes the negotiated pin assignment, which the
QMP PHY can react to and reconfigure the muxing.

Similarly the QMP can implement typec_switch_set() to flip the bit to do
the orientation switching.

> Or is the idea to make the USB (dwc3) and DP (msm_dp) controllers call
> phy framework APIs to change the qmp mode (USB, DP, or USB+DP)?
> 

No.

> >
> >
> > This is analog to the case you have today, where the QMP has no
> > knowledge of the GPIO pin that carries the HPD state in your design.
> 
> Indeed, in my design the QMP configuration is "fixed" and two lanes are
> dedicated for DP while another two lanes are dedicated to USB. The USB
> lanes go to a USB hub and the hub ports are connected to two different
> usb-c-connectors. The DP lanes go to another mux (similar to the SBU mux
> logically) and the two lanes are muxed to one of the two
> usb-c-connectors depending on what the typec manager decides. The HPD
> signal bypasses QMP and goes directly to the DP controller (msm_dp) via
> a GPIO. The HPD signal could just as easily be virtual like in your
> design, but we use a GPIO for now.
> 
> For the QMP driver to figure this out it will need to be able to parse
> the graph properties or we'll need more properties to describe the
> configuration. I was hoping we could describe this solely through the
> graph binding. We can probably do it by having reg numbered
> ports/endpoints in the QMP's ports binding to represent the USB or DP
> functionality (e.g. reg 0 is USB and reg 1 is DP) and then use
> 'data-lanes' to represent the number of lanes being used for that
> functionality (and also if they're remapped). Someone needs to write out
> all possible combinations and make sure the QMP binding can handle them
> all. If the ports binding isn't present then the driver should default
> to existing behavior (2 lanes DP, 2 lanes USB, normal orientation, no
> lane remapping). When they do this they should also consider static
> configurations that differ from the default, where the QMP doesn't flip
> the lines and/or change modes. That would allow hardware engineers to
> reroute lanes if that makes signal integrity better.
> 
> I expect that having the device registering the usb-c-connector make the
> drm bridge would work on ChromeOS. We would have the cros-ec-typec
> driver register the drm bridge(s) and notify HPD to the DP controller(s)
> through the drm bridge instead of using the GPIO path. We'd have to
> figure out how to express the connection to the dp controller in DT so
> when it searches for the next bridge it can find the one made in
> cros-ec-typec.
> 

I don't think it makes sense in your design to register a drm_bridge per
usb-c-connector, because then you need to connect the one DP controller
to both the drm_bridges and you need to spill the mux-logic from the EC
into the DP controller as well.

If you put the muxing logic in entity that does the muxing and implement
a signle drm_bridge there you will mimic the current design nicely,
where there is a single connection (GPIO) between the EC and the DP
controller for propagating the HPD signal.

You could choose to model the two usb-c-connectors there somehow as
well, perhaps just as static entities directly in /, but that would then
be a question of how to describing the link between the EC and the two
connectors.

Similarly, describing the relationship between the QMP PHY and the mux
makes sense to me (or just not describe it at all, if you're not going
to invoke any of the muxing/switching operations on the PHY)

> >
> [...]
> > >
> > > So should we explicitly have two endpoints in the usb-c-connector for
> > > the two pairs all the time, or should we represent that via data-lanes
> > > and only split up the connector's endpoint if we need to connect the
> > > usb-c-connector to two different endpoints?
> >
> > I think the endpoint of port@1 should represent the set of signals
> > connected to the other side, in our case 1:1 with the QMP. I like the
> > idea of adding data-lanes to the QMP side in order to describe any
> > swapping of the pads, but I see that as a separate thing.
> >
> > If you have a design where your usb-c-connector is wired to two
> > different PHYs and you have a Type-C controller that only negotiates the
> > 2+2 mode, then I think it makes sense to represent that as two endpoint
> > of port@1 - but the QMP side would only reference one of these
> > endpoints.
> >
> 
> Agreed. I think that means at most two endpoints are possible in port@1
> in the usb-c-connector binding. We would only use the second endpoint if
> we had two different PHYs that required it, otherwise only a single
> endpoint.

Sure.

But I do need to have a link between a DP controller and something
representing each USB-C port.

By registering a drm_bridge associated with the usb-c-connector the DP
controller implementation and binding will look identical between the
dp-connector case and the usb-c-connector case.

But the two options I see is to either add it in port@1 as a separate
logical endpoint or to add a new logical port.

The alternative to this would be to have a separate of graph outside the
multiple connectors, where each port@N implements the drm_bridge for
connector@N - but I feel we're just making things overly complicated,
just to avoid adding a logical endpoint/port in the usb-c-connector.

Regards,
Bjorn.


