Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80D95A1E5C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 03:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244613AbiHZBtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 21:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244269AbiHZBtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 21:49:08 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC43C7BB8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 18:49:03 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-11ba6e79dd1so376141fac.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 18:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc;
        bh=PwzZFDisk1EWvGmx0z+8zGzW5E/K5zLK7zj2AB3nbXw=;
        b=XzqvacsijdLD5gmVEjGyy7AB8aylRai918eKI9PEKsGrnAAGjPRy57m5kynQqVKL5A
         d2nDP1EE+SJ3dqHjIgL9z3aXznvsQe3WMc6+1OZbY9aIvhUocR35n9J/1bulJapXm5bH
         Z/0wnfFUtFXtg2bUd80srqvxqlZjjKzWm3zk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc;
        bh=PwzZFDisk1EWvGmx0z+8zGzW5E/K5zLK7zj2AB3nbXw=;
        b=TN8AgazBbhJAk3kiMWLtCSfwHxBA8haYof22wBejDvaC5aySE+aTNeH9iQLNdeduOh
         3yO/+VbPS28b2g+LfoKEcHXmJzVj3VwNM4qvo2j3qQ3KK3YbhD5P98op7DnC9dwKyR0k
         zBCdvKl8gmljlGQwwf0oJXFTqUvpNr0ayWqKaZWO5E+CsMywzrfVuIhbghB9cIeZlpba
         21Wm4SxhZ9cieiV8pRvAqiUm+MtetRBmxFYedF91+0bN35wqhzjKBOSS1RyuVImXDYbh
         8hHga6ErvGITXCzuXrBzxpsPl2iOZ7Oo7ZA09vrTHu8XObYghyzEsbNdju7XtLrliSBG
         Ve1A==
X-Gm-Message-State: ACgBeo0cYObZUyrprz/FYYz34/+75CHJHynwXwYj3X+CrcQ9rRKNzkqG
        8ZkVQoVgkd/pLqJdFQyeJ16As3vaM0uatOcZW4ip+g==
X-Google-Smtp-Source: AA6agR4VzTr4e33gtscsTs9XtMrvyTlpDwuYjLihuBkOy5et035VLci8MSKxsknxgwA9Q0kAtxcnTwrv6p33asrv3Ew=
X-Received: by 2002:a05:6870:a99c:b0:11c:2c37:3d03 with SMTP id
 ep28-20020a056870a99c00b0011c2c373d03mr808411oab.0.1661478542594; Thu, 25 Aug
 2022 18:49:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 25 Aug 2022 20:49:01 -0500
MIME-Version: 1.0
In-Reply-To: <YwBpcY2s+T1t4elN@builder.lan>
References: <20220810204750.3672362-1-bjorn.andersson@linaro.org>
 <20220810204750.3672362-2-bjorn.andersson@linaro.org> <a13bce60-25b4-d075-d56a-d1283e91e3ba@linaro.org>
 <20220814210104.GA690892-robh@kernel.org> <Yv1y9Wjp16CstJvK@baldur>
 <CAE-0n53AjJ_G6yZoTALWpKvZUdF+8nFZ+TQh=Ch=8xgdMVqDkw@mail.gmail.com>
 <YwAACIKvNtHtyL6o@builder.lan> <CAE-0n527ASkKgmoUV_MnmA3qwA+KKjQeWafwRHAvY5026gdBCw@mail.gmail.com>
 <YwBpcY2s+T1t4elN@builder.lan>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 25 Aug 2022 20:49:01 -0500
Message-ID: <CAE-0n52-QVeUVCB1qZzPbYyrb1drrbJf6H2DEEW9bOE6mh7egw@mail.gmail.com>
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

Quoting Bjorn Andersson (2022-08-19 21:56:17)
> On Fri 19 Aug 22:51 CDT 2022, Stephen Boyd wrote:
>
> > I realize I've hijacked this thread to discuss the QMP binding :-/
> >
> > The QMP phy is doing type-c "muxing" of different PHYs (USB and DP) onto
> > the SS lanes. Other altmodes that want to use the SS lanes would
> > similarly need to be routed through the QMP phy and muxed onto the lanes
> > when the altmode is used, e.g. thunderbolt. While it is certainly
> > convenient to have a "DP" endpoint in the usb-c-connector, I feel that
> > it is wrong, primarily because the DP phy has the QMP phy in between it
> > and the usb-c-connector, but also because DP is an altmode/virtual
> > construct built on top of the 4 lanes in the typec pinout.
> >
> > We should look at the binding from the perspective of the connector and
> > figure out how the pinout can be mapped to the binding. That would allow
> > board designers to ignore the internal SoC details, and stay focused on
> > what is in the schematic, which is the qmp phy and the usb-c-connector
> > in this case. My understanding is that two SS lanes always have to go
> > together in the type-c spec, hence the two endpoints in the graph, but
> > if all the SS lanes are physically wired to the same PHY then we can
> > omit the second endpoint and use data-lanes if for example DP is handled
> > by a different phy.
> >
>
> There is nothing in the schematics representing how the HPD signal comes
> from the Type-C controller to the DP controller - but it is a M:N
> relationship, so we must represent it in some way.
>
> I suggested a new port for describing this virtual connection, Rob asked
> for it to be a separate endpoint in port@1. I'm fine with either path.

I don't think we should be making a virtual connection. I'm not sure Rob
wants it to be a virtual connection either.

>
> But as Benson described to us, we do muxing of the signals in one
> operation and we do HPD signalling in a completely separate operation -
> from the Type-C controller's PoV. As such the QMP has nothing to do with
> the HPD signal.
>
> > >
> > > > Other designs only connect two lanes to the qmp phy and the other two
> > > > connect to a USB hub. That's where it gets interesting because we don't
> > > > know how to represent that. Do we make two endpoints in the
> > > > usb-c-connector port@1 and split the SS lines into SS RX1/TX1 and SS
> > > > RX2/TX2 pairs? Or do we use data-lanes to represent the SS lines? If we
> > > > make two endpoints then do we need to have two endpoints all the time
> > > > even though in this 4 SS line design it is redundant?
> > > >
> > > >       port@1 {
> > > >               reg = <1>;
> > > >               endpoint@0 { // Represents RX1/TX1
> > > >                       reg = <0>;
> > > >                       remote-endpoint = <&qmp_phy_lanes01>;
> > > >               };
> > > >               endpoint@1 { // Represents RX2/TX2
> > > >                       reg = <1>;
> > > >                       remote-endpoint = <&qmp_phy_lanes23>;
> > > >               };
> > > >       };
> > > >
> > >
> > > So on the other side of that PHY we would have a multi-port USB
> > > controller, or two USB controllers?
> >
> > I'm thinking of a single USB+DP PHY.
> >
> > > Either way, this seems like a proper
> > > representation of the two different ports, but not something we can do
> > > with the QMP.
> >
> > This example I gave is for the usb-c-connector, hence the
> > remote-endpoint pointing to the USB+DP PHY "bundled lanes" endpoints for
> > 0+1 and 2+3. Sorry if that wasn't clear.
> >
> > >
> > > The QMP phy has certain ability to swap the signals around, so it's
> > > conceivable that a data-lanes property in the outgoing port definition
> > > could be used to reorder the SS lanes...
> > >
> > > But it would be unrelated to the USB vs DP selection in my view.
> > >
> > > All we want here is a connection between the usb-c-connector and the QMP
> > > phy, such that the usb-c-connector's Type-C controller can inform the
> > > QMP what has been negotiated.
> >
> > Ok. By Type-C controller you mean the typec manager? Is that all Linux
> > for you?
> >
>
> I mean the entity that tells the remote-endpoints of the usb-c-connector
> about the outcome of USB PD negotiations. This might be implemented
> fully in Linux or partially in firmware.
>
> But this something will be the thing that ultimately calls
> typec_switch_set() et al.
>
>
> Can you please elaborate on the operations you see that the typec
> manager would perform on the remote-endpoint of endpoint@0 and
> endpoint@1?

Sorry, which endpoints are we talking about here?

> >
> > Ok, so the idea is to make a drm bridge in the device registering the
> > usb-c-connector? Doesn't the qmp_phy register the usb-c-connector for
> > you? I'm not really following along on this part.
> >
>
> No, it's not a part of the QMP.
>
> We want to use the graph from the usb-c-connector to signal the provider
> of HS, SS and SBU-signals about changes related to the connector. As
> such we associate the usb-c-connector with the Type-C
> manager/controller.
>
> Like described here, for a single usb-c-connector:
> https://lore.kernel.org/all/20220818031512.319310-2-bjorn.andersson@linaro.org/
>
> In this case, the pmic_glink firmware will send Linux messages which can
> be directly translated to a set of typec_mux_set(), typec_switch_set()
> and drm_bridge_hpd_notify() calls - with the graph defining which remote
> components should receive these events.

Ok, got it. The usb-c-connector is registered by the qcom,pmic-glink
driver. That is similar to the google,cros-ec-typec driver that we have
on chromeos.

>
> > >
> > >
> > > This is analog to the case you have today, where the QMP has no
> > > knowledge of the GPIO pin that carries the HPD state in your design.

Yes.

>
> I don't think it makes sense in your design to register a drm_bridge per
> usb-c-connector, because then you need to connect the one DP controller
> to both the drm_bridges and you need to spill the mux-logic from the EC
> into the DP controller as well.
>
> If you put the muxing logic in entity that does the muxing and implement
> a signle drm_bridge there you will mimic the current design nicely,
> where there is a single connection (GPIO) between the EC and the DP
> controller for propagating the HPD signal.

Yes, agreed. I believe implementing the drm_bridge in an EC driver is
the approach we will take. We will have to add a port binding to the EC
binding that accepts displayport as an input. Essentially the driver
will act as a DP connector that accepts the 2 DP lanes coming from QMP
and then muxes them onto one or the other usb-c-connector. The same
driver will need to support multiple DP input ports and USB inputs.

>
> You could choose to model the two usb-c-connectors there somehow as
> well, perhaps just as static entities directly in /, but that would then
> be a question of how to describing the link between the EC and the two
> connectors.
>
> Similarly, describing the relationship between the QMP PHY and the mux
> makes sense to me (or just not describe it at all, if you're not going
> to invoke any of the muxing/switching operations on the PHY)
>
> > >
> > [...]
> > > >
> > > > So should we explicitly have two endpoints in the usb-c-connector for
> > > > the two pairs all the time, or should we represent that via data-lanes
> > > > and only split up the connector's endpoint if we need to connect the
> > > > usb-c-connector to two different endpoints?
> > >
> > > I think the endpoint of port@1 should represent the set of signals
> > > connected to the other side, in our case 1:1 with the QMP. I like the
> > > idea of adding data-lanes to the QMP side in order to describe any
> > > swapping of the pads, but I see that as a separate thing.
> > >
> > > If you have a design where your usb-c-connector is wired to two
> > > different PHYs and you have a Type-C controller that only negotiates the
> > > 2+2 mode, then I think it makes sense to represent that as two endpoint
> > > of port@1 - but the QMP side would only reference one of these
> > > endpoints.
> > >
> >
> > Agreed. I think that means at most two endpoints are possible in port@1
> > in the usb-c-connector binding. We would only use the second endpoint if
> > we had two different PHYs that required it, otherwise only a single
> > endpoint.
>
> Sure.
>
> But I do need to have a link between a DP controller and something
> representing each USB-C port.

Do you? I think you need a link between the DP driver and the drm_bridge
driver that sends virtual hpd signals based on typec messages. That may
be the usb-c port driver, or it may be the driver implementing the
mode-switch. It doesn't need to be the usb-c-connector.

>
> By registering a drm_bridge associated with the usb-c-connector the DP
> controller implementation and binding will look identical between the
> dp-connector case and the usb-c-connector case.
>
> But the two options I see is to either add it in port@1 as a separate
> logical endpoint or to add a new logical port.
>
> The alternative to this would be to have a separate of graph outside the
> multiple connectors, where each port@N implements the drm_bridge for
> connector@N - but I feel we're just making things overly complicated,
> just to avoid adding a logical endpoint/port in the usb-c-connector.
>

In your case you have a 1:1 relationship between the QMP and the
usb-c-connector, so anything extra in the graph relationship between QMP
and the usb-c-connector looks like extra overly complicated binding. In
the chromeos trogdor case, we have a physical switch on the DP lanes to
steer DP from QMP to one of the two usb-c-connectors that are controlled
by the EC. Making a direct connection between DP and the
usb-c-connectors is impossible because DP has 1 graph output that can't
be connected to two usb-c-connectors at the same time.

The creation of a drm_bridge for a usb-c-connector doesn't work.
Connecting the QMP to the EC is a solution, or connecting the DP
controller to the EC is another solution, but the QMP path is preferred.

Here's why:

 (brace yourself for the wall of text!)

 1. QMP needs to know lane routing

We need to know which lanes coming out of QMP are for DP. Are they the
first two lanes (TX1/RX1) or the second two lanes (TX2/RX2), or all 4
lanes? The orientation bit inside QMP needs to be configured properly
too. In the 1:1 case you have this is not important until the DP pinconf
is assigned; connecting the DP controller directly to the
usb-c-connector in DT works because typec framework controls the
orientation switch inside QMP that's connected to the other port in
usb-c-connector. In the 1:N case the mapping is static, and we need a
way to express which lanes from QMP are for DP and which lanes from QMP
are for USB.

 2. DP lane remapping is controlled in the DP phy before orientation is
 controlled in the QMP phy

DP lanes coming out of the DP phy can be remapped however desired via a
register in the DP phy. The orientation control works on the TX1/RX1 and
TX2/RX2 pairs via QMP registers, so that two lanes DP and two lanes USB
can't put the two USB lanes on TX1/TX2 and the two DP lanes on RX1/RX2
when the orientation is flipped. If QMP has all four lanes wired to a DP
connector, i.e. USB is disabled, then we would use the data-lanes
property inside the DP phy's graph endpoint to figure out how to remap
the four DP lanes going to the QMP and out of the SoC to the connector.
The QMP orientation bit would need to be set to normal, so that
engineers can ignore QMP and how it flips the lanes it took from the DP
phy.

 3. QMP should have incoming and outgoing graph ports

The data-lanes property should only be inside graph endpoints, hence the
requirement to use a graph binding from the DP phy to the QMP node.
Sometimes the lanes from QMP are directly connected to a
usb-c-connector, hence the requirement to have a graph binding in QMP
that can connect to a usb-c-connector. Other times the QMP node would be
directly connected to a dp-connector. In that case we would also use a
graph binding to link the connector to QMP.

 4. Graph endpoints without a remote-endpoint property are bad style

In your design this wouldn't be the case, but in chromeos' case we would
connect the DP controller to the EC or one of the two usb-c-connectors
and then if we want to configure QMP lanes we would have to implement
the graph in QMP but omit the remote-endpoint property. That's because
we have 2 usb-c-connectors for 1 QMP. Having two endpoints in
usb-c-connector doesn't help us, because we can only connect QMP to one
of the two usb-c-connectors. We're unable to express that both
usb-c-connectors support DP from this one DP controller.

TL;DR: We have a verbose binding indeed, but it is required because
trogdor takes 2 DP lanes and muxes them to different usb-c-connectors.

To do that, we have to send the DP lanes to the thing that controls the
muxing (the EC). It's also complicated by the fact that the DP and USB
phy are split from the controllers, and put behind QMP (basically a
typec phy). I propose we make the graph binding for QMP have logically
numbered endpoints: 0 for USB+DP (most common), 1 for USB, and 2 for DP
and use data-lanes to physically map the pins while connecting the DP
and USB phys to QMP within the graph and using data-lanes again.

Here are some examples:

 - 4 lanes DP only, normal orientation of QMP, remapped DP lanes
  qmp {
    ports {
      qmp_dp_in: port@1 {
        reg = <1>;
        remote-endpoint = <&dp_phy_out>;
      };
      port@2 {
        reg = <2>;
        qmp_dp_out: endpoint@2 {
          reg = <2>;
          // data-lanes indicates how many lanes are used for DP
          // and if the lanes are flipped
          //
          // data-lanes = <0 1 2 3> == normal orientation (default)
          // data-lanes = <2 3 0 1> == flipped orientation
          // data-lanes = <0 1> == 2 lane DP, normal orientation
          // data-lanes = <2 3> == 2 lane DP, flipped orientation
          // data-lanes = <0/1/2/3> == 1 lane DP
          remote-endpoint = <&dp_connector>;
        };
      };
    };

    dp-phy {
      ports {
        dp_phy_out: port {
          remote-endpoint = <&qmp_dp_in>;
          data-lanes = <3 1 2 0>; // remap lanes
        };
      };
    };
  };

  dp-connector {
    compatible = "dp-connector";
    ports {
      dp_connector: port@0 {
        remote-endpoint = <&qmp_dp_out>;
      };
    };
  };

 - 2 lanes DP, 2 lanes USB fixed, flipped orientation of QMP
  qmp {
    ports {
      qmp_usb_in: port@0 {
        reg = <0>;
        remote-endpoint = <&usb_phy_out>;
      };
      qmp_dp_in: port@1 {
        reg = <1>;
        remote-endpoint = <&dp_phy_out>;
      };
      port@2 {
        reg = <2>;
        qmp_usb_out: endpoint@1 {
          reg = <1>;
          data-lanes = <2 3>; // SSTRX2 (flipped)
          remote-endpoint = <&usb_hub_in>;
        };
        qmp_dp_out: endpoint@2 {
          reg = <2>;
          data-lanes = <0 1>; // SSTRX1 (flipped)
          remote-endpoint = <&cros_ec_dp_in>;
        };
      };
    };

    dp-phy {
      ports {
        dp_phy_out: port {
          remote-endpoint = <&qmp_dp_in>;
          data-lanes = <0 1>; // DP phy fixed at two lanes, remap possible
        };
      };
    };

    usb-phy {
      ports {
        usb_phy_out: port {
          remote-endpoint = <&qmp_usb_in>;
          data-lanes = <0 1>; // remap lanes possibly? otherwise implicit
        };
      };
    };
  };

  usb-hub {
    compatible = "usb-hub";
    ports {
      usb_hub_in: port@0 {
        remote-endpoint = <&qmp_usb_out>;
      };
    };
  };

  ec {
    cros_ec_typec {
      ports {
        port@0 { // inputs
          reg = <1>;
          cros_ec_dp_in: endpoint@0 {
            reg = <0>;
            remote-endpoint = <&qmp_dp_out>;
          };
        };
      };

      usb-c0 {
        compatible = "usb-c-connector";
	// Do we care to connect this in the graph?
      };

      usb-c1 {
        compatible = "usb-c-connector";
      };
    };

 - 2/4 lanes DP, 2 lanes USB (i.e. USB+DP what you have)
  qmp {
    mode-switch;
    orientation-switch;
    ports {
      qmp_usb_in: port@0 {
        reg = <0>;
        remote-endpoint = <&usb_phy_out>;
      };
      qmp_dp_in: port@1 {
        reg = <1>;
        remote-endpoint = <&dp_phy_out>;
      };
      port@2 {
        reg = <2>;
        qmp_usb_dp_out: endpoint@0 {
          reg = <0>;
          // data-lanes indicates orientation if this
          // doesn't have an orientation-switch property
          //
          // data-lanes = <0 1 2 3> == normal (default)
          // data-lanes = <2 3 0 1> == flipped
          remote-endpoint = <&usb_c_connector_ss0>;
        };
      };
    };

    dp-phy {
      ports {
        dp_phy_out: port {
          remote-endpoint = <&qmp_dp_in>;
          // data-lanes can only be <0 1> or <1 0> and
          // orientation-switch can't be present in qmp
          // when data-lanes is here.
        };
      };
    };

    usb-phy {
      ports {
        usb_phy_out: port {
          remote-endpoint = <&qmp_usb_in>;
        };
      };
    };
  };

  glink {
    usb-c-connector {
      compatible = "usb-c-connector";
      ports {
        port@1 {
          reg = <1>;
          endpoint@0 {
            reg = <0>;
            remote-endpoint = <&qmp_usb_dp_out>;
          };
        };
      };
    };
  };

In your case (this last example) you don't need to have an extra graph
outside the connector in glink, because you have a direct connection
between QMP and the usb-c-connector. As I understand it, you want to add
another endpoint to usb-c-connector above, endpoint@1 in port@1, that
connects directly to the DP controller. It doesn't scale if we add
another altmode though, we'll have to add another virtual endpoint. We
can also see that DP is connected if we walk the graph to the dp phy.

------

Assuming everything is good above, the primary concern I'm left with is
how to find the drm_bridge from the DP controller driver. It would be
convenient to make a graph connection from the DP controller to the
mode-switch device. Then we could cut out the DP phy and the QMP part
and avoid walking the graph from DP phy to qmp to the next endpoint that
may or may not be a drm_bridge. In your case, the mode-switch is the
qmp, because it is used to control 2 or 4 lanes of DP. In chromeos' case
it's the EC. Either way, we're talking about a virtual link in the
binding, to make things simpler for the drm_bridge linkage code
devm_drm_of_get_bridge(). It would leave us with a parallel graph
connection from the DP controller node and the QMP node. I'm not excited
about this approach.

I wonder if drm can learn to walk from the 'phys' property to the graph
of the phy node and then search from there for a drm_bridge. Or if it's
simpler we can make a drm_bridge in the dp phy, qmp, and in
cros_ec/glink, where the dp phy and qmp would do nothing besides have a
drm_bridge_funcs::attach() function that knew which port in their graph
to search for the next bridge on. Then we could connect the port in the
DP controller's graph representing the DP output to the DP phy graph as
an input. Then the drm_bridge isn't entirely useless, just a small bit
of code to do the walk on attach.

The glink driver would make a drm_bridge for each usb-c-connector and
associate the connector of_node with the bridge. Similarly, with a cros
EC where the relationship is 1:1 we would make a drm_bridge for each
usb-c-connector and omit the graph binding outside the connector in
cros_ec_typec, directly connecting the graph from QMP to the connector.
This is because of_drm_find_bridge() looks for the parent of the graph
to find the bridge, and we would have two bridges in this case that need
different nodes.
