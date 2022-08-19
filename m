Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2649E59A7A8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 23:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352534AbiHSV0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 17:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352516AbiHSV0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 17:26:38 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0EB106FAD
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:26:35 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id t11-20020a05683014cb00b0063734a2a786so3853265otq.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=kADiGx1oy2+5PuzUoTWxzqD1xKJdD6RmP4AX7ZoLPbQ=;
        b=sbItC6IU7LKUl9rWk3yZsht9To4ZhbFLPQzBazioo7BVV/ApYngI932F4YUYf4Dwky
         lr6mKDHjem2F/EEpOYlj5tTrDI1c8PBu09xLTfs7Lslb1xY9Vjaxy/EwPZi+S/YqLUyJ
         GnmWER8AIsNlppjRvowCZOTwfxDHT/X9ihjttcmc81BtpDK1hagTQ/Vao+lslbjRDPzE
         R6K2K7MtnkG7M4seAKxS9RxoezW/T7ObcWTamPITm5zJO5XAHvlgVRVxSF4ReIQbZB6k
         0lr9gFyTbgPZAonbcg3YadgNdBm3djuKXm1RtMQowiimBR/9gIai0sga3Hcqp8DwCSad
         6HLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=kADiGx1oy2+5PuzUoTWxzqD1xKJdD6RmP4AX7ZoLPbQ=;
        b=BwE1oqCz3pMxJtgkOTrkfviqNYL3mf5Cm0vIv+w5I5xzlEZTJVnxDKhbKatGYkkbAb
         pA5N94vEt6qOmtt6JRCfNXD9uP+dIgldnWcJdJv7gW567LBywWbB7dIvmP9kH4+DB8Fu
         9DsBKwdzTrCTkKnkNTO8PwueOE0sp1/6NCm6YgAfcwQjDwhW4qKlk/IOh8o8OJ4XnQMW
         bJdw+GT2x/EG8agivn7b/Kk8t7IPFLEFNz/RrAZL2WNFu6GB3Y/1nRnjNh2sie2eFRrF
         sne9N+DE89e953AT6AXpPEtIL77/6lvCu15Lbi1ivTUXhBLdM7SZ0TCOZ7NCl0bXF7Os
         tj3Q==
X-Gm-Message-State: ACgBeo2wql3GgMZu18FzIFJL4Oyq+fhMW7ef7HYxaY9bMQgrVQh9ed36
        som+PvVATBt8vVR0VT+HfNj1lQ==
X-Google-Smtp-Source: AA6agR7s9Lj2lppRlV+NqdKyKTCPV5S00Qnv9MrivnSDUJ4yRbAXetqK0zO2RSG9itpJaTey6A884A==
X-Received: by 2002:a05:6830:449e:b0:638:c72b:68ff with SMTP id r30-20020a056830449e00b00638c72b68ffmr3661179otv.26.1660944395067;
        Fri, 19 Aug 2022 14:26:35 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id p6-20020a056870a54600b0011c47d23707sm1575474oal.54.2022.08.19.14.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 14:26:34 -0700 (PDT)
Date:   Fri, 19 Aug 2022 16:26:32 -0500
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
Message-ID: <YwAACIKvNtHtyL6o@builder.lan>
References: <20220810204750.3672362-1-bjorn.andersson@linaro.org>
 <20220810204750.3672362-2-bjorn.andersson@linaro.org>
 <a13bce60-25b4-d075-d56a-d1283e91e3ba@linaro.org>
 <20220814210104.GA690892-robh@kernel.org>
 <Yv1y9Wjp16CstJvK@baldur>
 <CAE-0n53AjJ_G6yZoTALWpKvZUdF+8nFZ+TQh=Ch=8xgdMVqDkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n53AjJ_G6yZoTALWpKvZUdF+8nFZ+TQh=Ch=8xgdMVqDkw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 18 Aug 20:09 CDT 2022, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2022-08-17 16:00:05)
> >
> > This is the setup that we're dealing with:
> >
> >                      +------------- - -
> >  USB connector       | SoC
> >  +-+                 |
> >  | |                 |   +-----+
> >  |*|<------- HS -----|-->| HS  |
> >  |*|<------- HS -----|-->| phy |<-+   +--------+
> >  | |                 |   +-----+   \->|        |
> >  | |                 |                |  dwc3  |
> >  | |                 |   +-----+   /->|        |
> >  |*|<------- SS -----|-->|     |<-+   +--------+
> >  |*|<------- SS -----|-->| QMP |
> >  |*|<------- SS -----|-->| phy |
> >  |*|<------- SS -----|-->|     |<-\   +------------+
> >  | |                 |   +-----+   \->|            |
> >  | |                 |                |     DP     |
> >  | |    +-----+      |                | controller |
> >  |*|<-->| SBU |<-----|--------------->|            |
> >  |*|<-->| mux |<-----|--------------->|            |
> >  | |    +----+       |                +------------+
> >  +-+                 |
> >                      +------------- - -
> >
> > The dwc3 controller is connected to the HS phy for HighSpeed signals and
> > QMP phy to be muxed out on 0, 2 or 4 of the SuperSpeed pins (for
> > DP-only, USB/DP combo or USB-only mode).
> >
> > The DisplayPort controller is connected to the same QMP phy, for and is
> > muxed onto the same 0, 2 or 4 of the SuperSpeed pins (for USB-only,
> > USB/DP combo or DP-only mode).
> >
> > The SuperSpeed pins can be switched around within the QMP phy, to handle
> > the case where the USB Type-C cable is flipped around.
> >
> >
> > The AUX pins of the DP controller are connected to the SBU pins in the
> > connector. These signals needs to be disconnected while DP mode is not
> > negotiated with the remote. The DP controller does not support swapping
> > the two lines.
> > The disconnecting and swapping thereby needs to be performed by an
> > external entity. For which we have a few examples already, such as
> > fcs,fsa4480.
> 
> By swapping you mean making SBU1 in the usb-c-connector be SBU2 and SBU2
> in the usb-c-connector be SBU1 to the DP controller, right? For the case
> when the cable is flipped.
> 

Correct.

> >
> > Lastly, in USB Power Delivery, the hot-plug signal found in a physical
> > DisplayPort or HDMI cable is communicated as a message. So the USB
> > Type-C controller must be able to pass this onto the DP controller.
> >
> >
> > I model the usb-c-connector as a child of the USB Type-C controller,
> > with the following representation of the connections:
> 
> 
> >
> > connector {
> >   compatible = "usb-c-connector";
> >
> >   ports {
> >     port@0 {
> >       reg = <0>;
> >       endpoint {
> >         remote-endpoint = <&dwc3>;
> >       };
> >     };
> >
> >     port@1 {
> >       reg = <1>;
> >       endpoint@0 {
> >         reg = <0>;
> >         remote-endpoint = <&qmp_phy>;
> >       };
> >       endpoint@1 {
> >         reg = <1>;
> >         remote-endpoint = <&dp_controller>;
> >     };
> 
> I'd expect the QMP phy to physically be the only thing connected on the
> board. That matches the block diagram above. Inside the SoC the SS lines
> will be muxed through the QMP phy to the DP controller or the USB
> controller. Therefore, in the binding I'd expect there to be a single
> port@1 for the connector:
> 
> 	port@1 {
> 		reg = <1>;
> 		endpoint@0 {
> 			reg = <0>;
> 			remote-endpoint = <&qmp_phy>;
> 		};
> 	};
> 

That is correct, the 4 SS pairs in the USB connector are connected to
the QMP PHY pads.


The second endpoint in port@1 comes from my RFC where I suggested adding
a 4th port to the usb-c-connector for connecting the usb-c-connector to
the DP controller for passing the virtual HPD signal. Rob suggested that
this indication relates to the SS pins and wanted this to be part of
port@1. But it's not actually a definition of any electrical connection.

> Somewhere above we would want 'data-lanes' to indicate how many SS lanes
> are connected between the connector and the phy and if any of those
> lanes need to be remapped in the phy.
> 
> 	port@1 {
> 		reg = <1>;
> 		endpoint@0 {
> 			reg = <0>;
> 			remote-endpoint = <&qmp_phy>;
> 			data-lanes = <0 1 2 3>;
> 		};
> 	};
> 
> This would be the block diagram configuration, but it doesn't seem
> right.
> 

The QMP phy will always be in control of the 4 lanes. The question
though is what those 4 lanes are allocated for, because depending on the
USB PD negotiation is might be 2 lanes DP + 2 lanes USB, or 4 lanes of
either function.

There are designs where we can only do 2 lanes DP, which today is
described in the DP controller...

> Other designs only connect two lanes to the qmp phy and the other two
> connect to a USB hub. That's where it gets interesting because we don't
> know how to represent that. Do we make two endpoints in the
> usb-c-connector port@1 and split the SS lines into SS RX1/TX1 and SS
> RX2/TX2 pairs? Or do we use data-lanes to represent the SS lines? If we
> make two endpoints then do we need to have two endpoints all the time
> even though in this 4 SS line design it is redundant?
> 
> 	port@1 {
> 		reg = <1>;
> 		endpoint@0 { // Represents RX1/TX1
> 			reg = <0>;
> 			remote-endpoint = <&qmp_phy_lanes01>;
> 		};
> 		endpoint@1 { // Represents RX2/TX2
> 			reg = <1>;
> 			remote-endpoint = <&qmp_phy_lanes23>;
> 		};
> 	};
> 

So on the other side of that PHY we would have a multi-port USB
controller, or two USB controllers? Either way, this seems like a proper
representation of the two different ports, but not something we can do
with the QMP.

> I think we may need to always have two endpoints in the usb-c-connector
> because data-lanes alone can't always handle it for us. Especially when
> you consider the hub and DP phy designs.
> 
> 	port@1 {
> 		reg = <1>;
> 		endpoint@0 { // Represents RX1/TX1
> 			reg = <0>;
> 			remote-endpoint = <&usb3_hub_portN>;
> 		};
> 		endpoint@1 { // Represents RX2/TX2
> 			reg = <1>;
> 			remote-endpoint = <&qmp_phy_lanes23>;
> 		};
> 	};
> 
> The remote-endpoint phandle is different, so data-lanes can't save us. I
> suspect putting data-lanes in the usb-c-connector is really just
> nonsense too, because the usb-c-connector is a dumb devicenode and it
> can't actively change lane routing. The endpoint that's connected should
> have the data-lanes property if for example, RX2 is connected to the
> phy's TX2 pins and TX2 is connected to the phy's RX2 pins. Then the
> driver for that endpoint can change the lane mapping at runtime to
> present the proper data on the right pins in the connector.
> 

The QMP phy has certain ability to swap the signals around, so it's
conceivable that a data-lanes property in the outgoing port definition
could be used to reorder the SS lanes...

But it would be unrelated to the USB vs DP selection in my view.

All we want here is a connection between the usb-c-connector and the QMP
phy, such that the usb-c-connector's Type-C controller can inform the
QMP what has been negotiated.

> >
> >     port@2 {
> >       reg = <2>;
> >       endpoint {
> >         remote-endpoint = <&sbu_mux>;
> >       };
> >     };
> >   };
> > };
> >
> > This allows the USB Type-C controller to:
> > 1) Perform USB role switching in the dwc3 on port@0
> > 2) Orientation and muxing of the SuperSpeed lines in the QMP phy on
> >    port@1:0, implement a drm_bridge for signalling HPD back to the DP
> >    controller on port@1:1
> 
> We may need to have a port connection from the DP controller to the QMP
> phy. But given that the DP controller already has a 'phys' phandle to
> the QMP phy I think the DP controller driver could try to link to a drm
> bridge created in the phy driver that mainly handles the HPD signaling
> and any lane muxing/routing that needs to happen when DP pin
> configuration is present.
> 

The QMP has no knowledge of HPD signalling in Type-C, it's strictly a
virtual thing living in the Type-C controller. The Type-C controller
will request mux changes from the QMP and HPD signal changes as two
completely independent events.

Implementing a drm_bridge in the implementation backing the
usb-c-connector mimics e.g. dp-connector (implemented in
drivers/gpu/drm/bridge/display-connector.c) nicely.

Implementing the drm_bridge in the QMP phy means that we just add state
tracking for something that it doesn't know, hence we need another
mechanism to the Type-C controller to inform the phy that the HPD signal
has changed.


This is analog to the case you have today, where the QMP has no
knowledge of the GPIO pin that carries the HPD state in your design.

> > 3) Orientation and muxing (connecting/disconnecting) the SBU/AUX lines
> >    in the SBU mux on port@2.
> >
> > The SBU mux in several of these designs is a component that takes a
> > power supply and two GPIOs, for enabling/disabling the connection and
> > flip the switch (which is used to swap the lines).
> 
> The SBU mux sounds OK to me. I don't think the SBU lines can be split
> up, they're a pair that has to go together, just like CC lines and SS
> pairs are in the typec spec. Of course, in DP spec we can have a single
> DP lane which corresponds to a single RX or TX differential pair, but
> with typec that isn't possible, we always have RX and TX together.
> 
> This actually brings up one final point. On the QMP phy we can reorder
> the lanes willy nilly from what I recall, so that RX1 could be RX2 and
> TX1 could be TX2. In such a design, we would have two ports in the qmp
> phy to connect to the two TX/RX pairs in the connector, but then we
> would need to tell the QMP phy that the lanes are all shifted.
> 
> 	qmp_phy {
> 		ports {
> 			port@0 {
> 				reg = <0>;
> 				endpoint@0 {
> 					reg = <0>;
> 					remote-endpoint = <&usb_c_txrx1>;
> 					data-lanes = <1 2>
> 				};
> 				endpoint@1 {
> 					reg = <1>;
> 					remote-endpoint = <&usb_c_txrx2>;
> 					data-lanes = <3 0>;
> 				};
> 			};
> 		};
> 	};
> 
> This would do that for us, but when all four lanes are connected from
> the qmp phy directly to the connector we could just as easily have done
> it with one endpoint.
> 
> 	qmp_phy {
> 		ports {
> 			port@0 {
> 				reg = <0>;
> 				endpoint@0 {
> 					reg = <0>;
> 					remote-endpoint = <&usb_c_ss>;
> 					data-lanes = <1 2 3 0>
> 				};
> 			};
> 		};
> 	};
> 
> So should we explicitly have two endpoints in the usb-c-connector for
> the two pairs all the time, or should we represent that via data-lanes
> and only split up the connector's endpoint if we need to connect the
> usb-c-connector to two different endpoints?

I think the endpoint of port@1 should represent the set of signals
connected to the other side, in our case 1:1 with the QMP. I like the
idea of adding data-lanes to the QMP side in order to describe any
swapping of the pads, but I see that as a separate thing.

If you have a design where your usb-c-connector is wired to two
different PHYs and you have a Type-C controller that only negotiates the
2+2 mode, then I think it makes sense to represent that as two endpoint
of port@1 - but the QMP side would only reference one of these
endpoints.

Regards,
Bjorn
