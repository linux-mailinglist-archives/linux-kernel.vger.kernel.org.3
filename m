Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663E859924D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 03:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239896AbiHSBJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 21:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbiHSBJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 21:09:19 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC5F57233
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 18:09:16 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id bb16so3317598oib.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 18:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc;
        bh=GNhB5J0ko1oUFK0gy/BPz1z35lJvCOTWmtD1LPStEv8=;
        b=ObTiVxspPo/Kkfg/KFWffoOlxCK9/0+GXP894iZwoA2WDPdgbvoADPbTeCRWAF3WsR
         nNu2aiXuCEC9sADsOHJLXVafWf/m0F+WBltOd5R3ty1F8rnMxlv0s0dKEeeChQ6ZAU7D
         sHsQYOR6GXCOD4q6ZVnFSgWRZAYIFE3FphG64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc;
        bh=GNhB5J0ko1oUFK0gy/BPz1z35lJvCOTWmtD1LPStEv8=;
        b=6Qn8nZcwB/60ET13FTdCvpjxj3kC5HiMLxR+Stp9AbZR6q45e/6eGFC8h4YDsz9sg3
         ZUmDiaDrQx1bo/hnDpxgjDTFG8KxXi7AqsbXU9ZEUUnaGDt7y8y27lfp0bQbda7vaBCP
         pDVbMXOiacwpPMOSrDrarjwZqxsKgTynDH7HSuOqZQEp6T/gfvFAur3ZBlgrGaCDaRg4
         yc6K3OwId7i7plJ2LBKfh9mcBEw/b8L5HzcSovhCYNSVjRaR60U/hIrJUoQvFHH2XEuM
         5s5alzceMxWZ7bSRqin0QfWVSmFhjoMfobYZOtPqp5WfrtEEQAUb5ZnBJLx3J0/rAZcz
         Vrfw==
X-Gm-Message-State: ACgBeo0Dvk0bWmQXIkHO56yeo3XPjzcgnXY3chjHGoMePrDSvh1PY62F
        nGw+zJgDzd9kdXZ1WDgb5siVmq1+PKRYuBAjbAlc2g==
X-Google-Smtp-Source: AA6agR60zBCVnhbEc263bMhy8/wqm/PRBTXgdNUDzL0zANTP72ntps8PNqsYF3huFOtFBcm6vC0cutaQ2LezCgyzvG4=
X-Received: by 2002:a05:6808:bca:b0:344:ef42:930f with SMTP id
 o10-20020a0568080bca00b00344ef42930fmr2351993oik.0.1660871355864; Thu, 18 Aug
 2022 18:09:15 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 18 Aug 2022 20:09:15 -0500
MIME-Version: 1.0
In-Reply-To: <Yv1y9Wjp16CstJvK@baldur>
References: <20220810204750.3672362-1-bjorn.andersson@linaro.org>
 <20220810204750.3672362-2-bjorn.andersson@linaro.org> <a13bce60-25b4-d075-d56a-d1283e91e3ba@linaro.org>
 <20220814210104.GA690892-robh@kernel.org> <Yv1y9Wjp16CstJvK@baldur>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 18 Aug 2022 20:09:15 -0500
Message-ID: <CAE-0n53AjJ_G6yZoTALWpKvZUdF+8nFZ+TQh=Ch=8xgdMVqDkw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: usb: Introduce GPIO-based SBU mux
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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

Quoting Bjorn Andersson (2022-08-17 16:00:05)
>
> This is the setup that we're dealing with:
>
>                      +------------- - -
>  USB connector       | SoC
>  +-+                 |
>  | |                 |   +-----+
>  |*|<------- HS -----|-->| HS  |
>  |*|<------- HS -----|-->| phy |<-+   +--------+
>  | |                 |   +-----+   \->|        |
>  | |                 |                |  dwc3  |
>  | |                 |   +-----+   /->|        |
>  |*|<------- SS -----|-->|     |<-+   +--------+
>  |*|<------- SS -----|-->| QMP |
>  |*|<------- SS -----|-->| phy |
>  |*|<------- SS -----|-->|     |<-\   +------------+
>  | |                 |   +-----+   \->|            |
>  | |                 |                |     DP     |
>  | |    +-----+      |                | controller |
>  |*|<-->| SBU |<-----|--------------->|            |
>  |*|<-->| mux |<-----|--------------->|            |
>  | |    +----+       |                +------------+
>  +-+                 |
>                      +------------- - -
>
> The dwc3 controller is connected to the HS phy for HighSpeed signals and
> QMP phy to be muxed out on 0, 2 or 4 of the SuperSpeed pins (for
> DP-only, USB/DP combo or USB-only mode).
>
> The DisplayPort controller is connected to the same QMP phy, for and is
> muxed onto the same 0, 2 or 4 of the SuperSpeed pins (for USB-only,
> USB/DP combo or DP-only mode).
>
> The SuperSpeed pins can be switched around within the QMP phy, to handle
> the case where the USB Type-C cable is flipped around.
>
>
> The AUX pins of the DP controller are connected to the SBU pins in the
> connector. These signals needs to be disconnected while DP mode is not
> negotiated with the remote. The DP controller does not support swapping
> the two lines.
> The disconnecting and swapping thereby needs to be performed by an
> external entity. For which we have a few examples already, such as
> fcs,fsa4480.

By swapping you mean making SBU1 in the usb-c-connector be SBU2 and SBU2
in the usb-c-connector be SBU1 to the DP controller, right? For the case
when the cable is flipped.

>
> Lastly, in USB Power Delivery, the hot-plug signal found in a physical
> DisplayPort or HDMI cable is communicated as a message. So the USB
> Type-C controller must be able to pass this onto the DP controller.
>
>
> I model the usb-c-connector as a child of the USB Type-C controller,
> with the following representation of the connections:


>
> connector {
>   compatible = "usb-c-connector";
>
>   ports {
>     port@0 {
>       reg = <0>;
>       endpoint {
>         remote-endpoint = <&dwc3>;
>       };
>     };
>
>     port@1 {
>       reg = <1>;
>       endpoint@0 {
>         reg = <0>;
>         remote-endpoint = <&qmp_phy>;
>       };
>       endpoint@1 {
>         reg = <1>;
>         remote-endpoint = <&dp_controller>;
>     };

I'd expect the QMP phy to physically be the only thing connected on the
board. That matches the block diagram above. Inside the SoC the SS lines
will be muxed through the QMP phy to the DP controller or the USB
controller. Therefore, in the binding I'd expect there to be a single
port@1 for the connector:

	port@1 {
		reg = <1>;
		endpoint@0 {
			reg = <0>;
			remote-endpoint = <&qmp_phy>;
		};
	};

Somewhere above we would want 'data-lanes' to indicate how many SS lanes
are connected between the connector and the phy and if any of those
lanes need to be remapped in the phy.

	port@1 {
		reg = <1>;
		endpoint@0 {
			reg = <0>;
			remote-endpoint = <&qmp_phy>;
			data-lanes = <0 1 2 3>;
		};
	};

This would be the block diagram configuration, but it doesn't seem
right.

Other designs only connect two lanes to the qmp phy and the other two
connect to a USB hub. That's where it gets interesting because we don't
know how to represent that. Do we make two endpoints in the
usb-c-connector port@1 and split the SS lines into SS RX1/TX1 and SS
RX2/TX2 pairs? Or do we use data-lanes to represent the SS lines? If we
make two endpoints then do we need to have two endpoints all the time
even though in this 4 SS line design it is redundant?

	port@1 {
		reg = <1>;
		endpoint@0 { // Represents RX1/TX1
			reg = <0>;
			remote-endpoint = <&qmp_phy_lanes01>;
		};
		endpoint@1 { // Represents RX2/TX2
			reg = <1>;
			remote-endpoint = <&qmp_phy_lanes23>;
		};
	};

I think we may need to always have two endpoints in the usb-c-connector
because data-lanes alone can't always handle it for us. Especially when
you consider the hub and DP phy designs.

	port@1 {
		reg = <1>;
		endpoint@0 { // Represents RX1/TX1
			reg = <0>;
			remote-endpoint = <&usb3_hub_portN>;
		};
		endpoint@1 { // Represents RX2/TX2
			reg = <1>;
			remote-endpoint = <&qmp_phy_lanes23>;
		};
	};

The remote-endpoint phandle is different, so data-lanes can't save us. I
suspect putting data-lanes in the usb-c-connector is really just
nonsense too, because the usb-c-connector is a dumb devicenode and it
can't actively change lane routing. The endpoint that's connected should
have the data-lanes property if for example, RX2 is connected to the
phy's TX2 pins and TX2 is connected to the phy's RX2 pins. Then the
driver for that endpoint can change the lane mapping at runtime to
present the proper data on the right pins in the connector.

>
>     port@2 {
>       reg = <2>;
>       endpoint {
>         remote-endpoint = <&sbu_mux>;
>       };
>     };
>   };
> };
>
> This allows the USB Type-C controller to:
> 1) Perform USB role switching in the dwc3 on port@0
> 2) Orientation and muxing of the SuperSpeed lines in the QMP phy on
>    port@1:0, implement a drm_bridge for signalling HPD back to the DP
>    controller on port@1:1

We may need to have a port connection from the DP controller to the QMP
phy. But given that the DP controller already has a 'phys' phandle to
the QMP phy I think the DP controller driver could try to link to a drm
bridge created in the phy driver that mainly handles the HPD signaling
and any lane muxing/routing that needs to happen when DP pin
configuration is present.

> 3) Orientation and muxing (connecting/disconnecting) the SBU/AUX lines
>    in the SBU mux on port@2.
>
> The SBU mux in several of these designs is a component that takes a
> power supply and two GPIOs, for enabling/disabling the connection and
> flip the switch (which is used to swap the lines).

The SBU mux sounds OK to me. I don't think the SBU lines can be split
up, they're a pair that has to go together, just like CC lines and SS
pairs are in the typec spec. Of course, in DP spec we can have a single
DP lane which corresponds to a single RX or TX differential pair, but
with typec that isn't possible, we always have RX and TX together.

This actually brings up one final point. On the QMP phy we can reorder
the lanes willy nilly from what I recall, so that RX1 could be RX2 and
TX1 could be TX2. In such a design, we would have two ports in the qmp
phy to connect to the two TX/RX pairs in the connector, but then we
would need to tell the QMP phy that the lanes are all shifted.

	qmp_phy {
		ports {
			port@0 {
				reg = <0>;
				endpoint@0 {
					reg = <0>;
					remote-endpoint = <&usb_c_txrx1>;
					data-lanes = <1 2>
				};
				endpoint@1 {
					reg = <1>;
					remote-endpoint = <&usb_c_txrx2>;
					data-lanes = <3 0>;
				};
			};
		};
	};

This would do that for us, but when all four lanes are connected from
the qmp phy directly to the connector we could just as easily have done
it with one endpoint.

	qmp_phy {
		ports {
			port@0 {
				reg = <0>;
				endpoint@0 {
					reg = <0>;
					remote-endpoint = <&usb_c_ss>;
					data-lanes = <1 2 3 0>
				};
			};
		};
	};

So should we explicitly have two endpoints in the usb-c-connector for
the two pairs all the time, or should we represent that via data-lanes
and only split up the connector's endpoint if we need to connect the
usb-c-connector to two different endpoints?
