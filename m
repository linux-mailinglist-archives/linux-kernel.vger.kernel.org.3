Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21660560C01
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiF2V6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiF2V63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:58:29 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FA714D1A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 14:58:27 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-101b4f9e825so23285470fac.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 14:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=QHiM66D3M2tpDcYMSSpjLBMHEzCkbRn+H9VYDFcjiT8=;
        b=T3/L7xfXl/BV+/qp3+kcvf1bnriI/OW03MnpfNHHuAbDHSZQsZr8tY32ZfO/Djk4s7
         GsAWC5dbGtpl9NMQopKbaEfwsqlTZfy1DofpOLPas5qsVuu/tAdslByLG4ctgV+DBoKN
         p6SkCyRE3YlbvmZchOxNnyBQek+gpjFFaNbCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=QHiM66D3M2tpDcYMSSpjLBMHEzCkbRn+H9VYDFcjiT8=;
        b=4z1Tus2lIQZV4tczSiWmEhF1/Z2BJN5Wg7HfoWUjVTQBnpmeTlKm21zxZNwB5IKiox
         WbfZQdAXzbHpHmISSoVc0DouMeXrzyH0m23JcDH2tzz/KFXd+L1MoxoFVuQV7fHJ6Wne
         TaYvCn8FBHSFLp6ZEZrihWq894YgKDZOsYrK6+/XCdFC+Ocy0hVOvQJ61PVYgqV1Gc0u
         Yv3xNkqjB318PUS8oNO13JxB0is1YpP9BVTui/quIBxhT2ok63iKAYvxBMwpLwcifHKU
         rmyoknZyjuQa/3HqsCq4bXpYoeeLwXpIc2NRemkUfzxW6AWG9avKoSktFbwwt8B8HSOu
         /NXQ==
X-Gm-Message-State: AJIora8fC5j0dto5dh+dhLPw8Max8VZqghDWx3aX/VZQJJnnqGdXZkmL
        9Adtei7U1tTmLJ9Kak9PXiq0Lw65kqNZWWpzUSuf1Q==
X-Google-Smtp-Source: AGRyM1voWxorwNlr4+6PVRAFOXGgMhzrQC0t2Ey2i93QF32C3J6M09MBh4ktpy4po0N/vKrgO+AO4yP4oVZjaFELLvc=
X-Received: by 2002:a05:6870:b627:b0:102:f25:a460 with SMTP id
 cm39-20020a056870b62700b001020f25a460mr3272546oab.193.1656539907115; Wed, 29
 Jun 2022 14:58:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 29 Jun 2022 16:58:26 -0500
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+C04RXLtm6Ac85Ru3EGwJbqV_UD3_dDWVrKvFSvdm7Ng@mail.gmail.com>
References: <20220622173605.1168416-1-pmalani@chromium.org>
 <20220622173605.1168416-2-pmalani@chromium.org> <20220627210407.GA2905757-robh@kernel.org>
 <CACeCKackdbDZrk5fk7qyMwSdTdzyTS=m1vHPFnQOj672W=2nOA@mail.gmail.com>
 <20220628182336.GA711518-robh@kernel.org> <CAEXTbpex9nxP-nyPWvSBchAW4j3C4MZfVHTb=5X0iSLY1bSAKg@mail.gmail.com>
 <CAEXTbpf_jxK-R5aA81FCbpAH4bChA2B9+8qExZUbA7Y+Ort=Gg@mail.gmail.com> <CAL_Jsq+C04RXLtm6Ac85Ru3EGwJbqV_UD3_dDWVrKvFSvdm7Ng@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 29 Jun 2022 16:58:26 -0500
Message-ID: <CAE-0n53ers881LOTCEmKDDxJQt+5vvXJSURs=o6TcOiR5m_EAw@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] dt-bindings: usb: Add Type-C switch binding
To:     Pin-yen Lin <treapking@chromium.org>, Rob Herring <robh@kernel.org>
Cc:     Prashant Malani <pmalani@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Allen Chen <allen.chen@ite.com.tw>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xin Ji <xji@analogixsemi.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2022-06-29 10:58:52)
> On Wed, Jun 29, 2022 at 9:01 AM Pin-yen Lin <treapking@chromium.org> wrote:
> > >
> > > Yes it6505 is just a protocol converter. But in our use case, the output DP
> > > lines are connected to the Type-C ports and the chip has to know which
> > > port has DP Alt mode enabled. Does this justify a child node here?
> > >
> > > Does it make more sense if we we eliminate the usb-switch node here
> > > and list the ports in the top level?
>
> In the it6505 node? No, the it6505 h/w knows nothing about Type-C
> switching so neither should its binding.
>
> What device controls the switching in this case? Again, block diagrams
> please if you want advice on what the binding should look like.

My understanding is there are 4 DP lanes on it6505 and two lanes are
connected to one usb-c-connector and the other two lanes are connected
to a different usb-c-connector. The IT6505 driver will send DP out on
the associated two DP lanes depending on which usb-c-connector has DP
pins assigned by the typec manager.

        					     +-------+
        					     |       |
          +--------+                            /----+ usb-c |
          | IT6505 |                           / /---+       |
          |        +------------ lane 0 ------/ /    |       |
          |        +------------ lane 1 -------/     +-------+
 DPI -----+        |
          |        |                                 +-------+
          |        |                                 |       |
          |        +------------ lane 2 -------------+ usb-c |
          |        +------------ lane 3 -------------+       |
          |        |                                 |       |
          +--------+                                 +-------+

The bridge is a mux that steers DP to one or the other usb-c-connector
based on what the typec manager decides.

I would expect this to be described with the existing port binding in
the it6505 node. The binding would need to be extended to describe the
output side.

        bridge@5c {
            compatible = "ite,it6505";
	    ...

            ports {
                #address-cells = <1>;
                #size-cells = <0>;

                port@0 {
                    reg = <0>;
                    it6505_in: endpoint {
                        remote-endpoint = <&dpi_out>;
                    };
                };

                port@1 {
                    #address-cells = <1>;
                    #size-cells = <0>;
                    reg = <1>;

                    it6505_out_lanes_01: endpoint@0 {
                        reg = <0>
                        data-lanes = <0 1>;
                        remote-endpoint = <&typec0>;
                    };

                    it6505_out_lanes_23: endpoint@1 {
                        reg = <1>
                        data-lanes = <2 3>;
                        remote-endpoint = <&typec1>;
                    };
                };
            };
        };

        usb-c-connector {
            compatible = "usb-c-connector";
            ....
            ports {
                #address-cells = <1>;
                #size-cells = <0>;

                port@1 {
                    reg = <1>;
                    typec0: endpoint {
                        remote-endpoint = <&it6505_out_lanes_01>;
                    };
                };
            };
        };

Note: port@1 in usb-c-connector above is for superspeed lines, which
technically DP reuses. But we can also shove USB3 superspeed lines over
the other two superspeed pins in the usb-c-connector pinout. Probably
port@1 should have two endpoints so we can connect usb superspeed lines
there in addition to DP lines.

Another use case would be to have the IT6505 send 4 lanes of DP to a
dp-connector. Or send one lane of DP to 4 dp-connectors? Sounds awful but
possible if this bridge can drive one lane DP out on any DP output lane.

        bridge@5c {
            compatible = "ite,it6505";
	    ...

            ports {
                #address-cells = <1>;
                #size-cells = <0>;

                port@0 {
                    reg = <0>;
                    it6505_in: endpoint {
                        remote-endpoint = <&dpi_out>;
                    };
                };

                port@1 {
                    #address-cells = <1>;
                    #size-cells = <0>;
                    reg = <1>;

                    it6505_out_lane_0: endpoint@0 {
                        reg = <0>
                        data-lanes = <0>;
                        remote-endpoint = <&dp0>;
                    };

                    it6505_out_lane_1: endpoint@1 {
                        reg = <1>
                        data-lanes = <1>;
                        remote-endpoint = <&dp1>;
                    };

                    it6505_out_lane_2: endpoint@2 {
                        reg = <2>
                        data-lanes = <2>;
                        remote-endpoint = <&dp1>;
                    };

                    it6505_out_lane_3: endpoint@3 {
                        reg = <3>
                        data-lanes = <3>;
                        remote-endpoint = <&dp1>;
                    };
                };
            };
        };


Or we could send 4 lanes of DP to a typec redriver that's controlled by
firmware outside of the kernel where the redriver takes in 4 lanes DP
and USB3 and muxes USB or USB+DP or just DP.

        bridge@5c {
            compatible = "ite,it6505";
	    ...

            ports {
                #address-cells = <1>;
                #size-cells = <0>;

                port@0 {
                    reg = <0>;
                    it6505_in: endpoint {
                        remote-endpoint = <&dpi_out>;
                    };
                };

                port@1 {
                    #address-cells = <1>;
                    #size-cells = <0>;
                    reg = <1>;

                    it6505_out: endpoint@0 {
                        reg = <0>
                        data-lanes = <0 1 2 3>;
                        remote-endpoint = <&cros_ec_typec_dp_in>;
                    };
                };
            };
        };

	cros_ec@0 {
	    compatible = "google,cros-ec-spi";
	    ...

	    cros_ec_typec: typec {
	         compatible = "google,cros-ec-typec";
		 ports {
                     #address-cells = <1>;
                     #size-cells = <0>;

                     port@0 {
		         cros_ec_typec_dp_in: endpoint {
			     remote-endpoint = <&it6505_out>;
			 };
                     };
		 };
	    };
	};

In this case we would want to have cros_ec_typec describe some sort of
input graph binding to accept DP. I imagine the EC as a dp-bridge in
this scenario, where it takes in DP and muxes it along with USB onto a
usb-c-connector. If the EC is managing multiple usb-c-connectors then
the typec framework may need help determining which port DP is going to,
especially in the case that two DP bridges are used and they're both
sent to the EC so that the EC can mux them onto a usb-c-connector along
with USB.

(I can draw more block diagrams if you prefer)

>
> > > > > > If the child node represents what the output is connected to (like a
> > > > > > bus), then yes that is a pattern we have used.
> > > > >
> > > > > For the anx7625 case, the child node does represent what the output is connected
> > > > > to (the usb-c-connector via the switch). Does that not qualify? Or do you mean
> > > > > the child node should be a usb-c-connector itself?
> > > > >
> > > > > > For example, a panel
> > > > > > represented as child node of a display controller. However, that only
> > > > > > works for simple cases, and is a pattern we have gotten away from in
> > > > > > favor of using the graph binding.
> > > > >
> > > > > The child node will still use a OF graph binding to connect to the
> > > > > usb-c-connector.
> > > > > Is that insufficient to consider a child node usage here?
> > > > > By "using the graph binding", do you mean "only use the top-level ports" ?
> > > > > I'm trying to clarify this, so that it will inform future versions and patches.
> > > >
> > > > What I want to see is block diagrams of possible h/w with different
> > > > scenarios and then what the binding looks like in those cases. The
> > > > switching/muxing could be in the SoC, a bridge chip, a Type C
> > > > controller, a standalone mux chip, or ????. If you want a somewhat
> > > > genericish binding, then you need to consider all of these.
> >
> > Then, is it suitable to put the switch binding into the drivers own bindings
> > (i.e., the bindings for it6505 and anx7625), and introduce some helper
> > functions to eliminate the duplication in the code?
>
> Only for h/w devices that have switch h/w.
>
> > Though we will have two similar bindings in two drivers with this approach.
>
> While the anx7625 driver having Type-C awareness makes sense given it
> has a switch and a type-C controller, that doesn't make sense for
> it6505 (and every other bridge driver that's just providing DP
> output).
>

I don't see the benefit to making a genericish binding for typec
switches, even if the hardware has typec awareness like anx7625. It
looks like the graph binding can already handle what we need. By putting
it in the top-level ports node we have one way to describe the
input/output of the device instead of describing it in the top-level in
the display connector case and the child typec switch node in the usb c
connector case.

I think the difficulty comes from the combinatorial explosion of
possible configurations. As evidenced here, hardware engineers can take
a DP bridge and use it as a DP mux as long as the bridge has lane
control. Or they can take a device like anx7625 and ignore the USB
aspect and use the internal crosspoint switch as a DP mux. The anx7625
part could be a MIPI-to-DP display bridge plus mux that is connected to
two dp-connectors, in which case typec isn't even involved, but we could
mux between two dp connectors.

Also, the typec framework would like to simply walk the graph from the
usb-c-connector looking for nodes that have 'mode-switch' or
'orientation-switch' properties and treat those devices as the typec
switches for the connector. This means that we have to add these typec
properties like 'mode-switch' to something like the IT6505 bridge
binding, which is a little awkward. I wonder if those properties aren't
really required. Would it be sufficient if the framework could walk the
graph and look for registered typec switches in the kernel that have a
matching of_node?
