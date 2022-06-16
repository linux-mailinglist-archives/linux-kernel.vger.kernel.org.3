Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8BF54EA71
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 21:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378458AbiFPT6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 15:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiFPT6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 15:58:09 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DC027CD5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 12:58:01 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id t1so3921569ybd.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 12:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K5Iia3KQ3GthJU/9UXq1fy46wYkvnbGu6bM6iwpwZ/w=;
        b=byQ6Jg3IG2wY8AJZ37MYWEiqoW5fQTlcQAXgCm+ic8DxR3EiNke3g1HmSrhoMWO6pQ
         ylU8JKkSoX3Zjp65CWHpEZKSK/s5kn5MnD4mybxnwwpPGSRU55K6DiQAyuXKgsnZHbds
         H47rT0kBHuABLBXJe8OrBfgRyPGSkvyygqhrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K5Iia3KQ3GthJU/9UXq1fy46wYkvnbGu6bM6iwpwZ/w=;
        b=Erk8vnrNhynG+OrAK3xuMaHo9TWqy/HwSuCnHaRS5uFJOf1GeQxsIKExLtE6np8Qvo
         GXj9byrR87OVJ8KklDiw/ZbF/2kP1OBG9mptccwHI9BASVJIrNXDIhnlheKjFTjVJMeu
         jPfReTk7AEQP+N9Ajz6cD9G5WBUI59IZWq2NehXebmLi8bKFRvsLiLCvlycj7pnSPe3T
         KYW/V8KDB5JuV2g75q0DmvJDC+3ltvjHhSsBIJjeYhgqoMVoWxycf1+VdleoPjK1o9Dy
         zAl3TsKei+b60eF60kpEy7QNI8DZipjCE8er1n+Xij7+KyWKMH9M1Lj+Wiu9lCFvl7kh
         ldNw==
X-Gm-Message-State: AJIora/uCGsxiGQc5mMx1IC9YZsaDnfcysSkILMy3GpaFEyWKzurVvIX
        MdJTHu7uhPcHGsTa80W2bUOCJTYXGa0ppBeOp+Kyjw==
X-Google-Smtp-Source: AGRyM1u2G+7uuqQPl3CPuJTbWlY1cxze2DXthubUyJ6jsETYiTPwNY3gyzKzFK4Jpb7RKV1we9iMMiiLMPviipnrS50=
X-Received: by 2002:a25:bd4c:0:b0:65d:3dca:9638 with SMTP id
 p12-20020a25bd4c000000b0065d3dca9638mr5192725ybm.196.1655409480538; Thu, 16
 Jun 2022 12:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220615172129.1314056-1-pmalani@chromium.org>
 <20220615172129.1314056-5-pmalani@chromium.org> <CAE-0n53ub30HXB325wPoMB4C3n4j_9FWnNu5AmtYgU3PBvs8mQ@mail.gmail.com>
 <CACeCKadSCXZo3E4JZiwxFn_4CH3KDfQkk=xRrxSqCEWAgYhV6Q@mail.gmail.com> <20220616193424.GA3844759-robh@kernel.org>
In-Reply-To: <20220616193424.GA3844759-robh@kernel.org>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 16 Jun 2022 12:57:49 -0700
Message-ID: <CACeCKaeH6qTTdG_huC4yw0xxG8TYEOtfPW3tiVNwYs=P4QVPXg@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] dt-bindings: drm/bridge: anx7625: Add mode-switch support
To:     Rob Herring <robh@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, bleung@chromium.org,
        heikki.krogerus@linux.intel.com,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
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
        Pin-Yen Lin <treapking@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xin Ji <xji@analogixsemi.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 12:34 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Jun 16, 2022 at 01:54:36AM -0700, Prashant Malani wrote:
> > On Thu, Jun 16, 2022 at 12:42 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Prashant Malani (2022-06-15 10:20:20)
> > > >
> > > >  .../display/bridge/analogix,anx7625.yaml      | 64 +++++++++++++++++++
> > > >  1 file changed, 64 insertions(+)
> > >
> > > Can this file get a link to the product brief[1]? It helps to quickly
> > > find the block diagram.
> >
> > Sure, but I don't really think that should be included in this patch
> > (or series).
> > I'd be happy to submit a separate patch once this series is resolved.
> >
> > >
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > > > index 35a48515836e..bc6f7644db31 100644
> > > > --- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > > > +++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > > > @@ -105,6 +105,34 @@ properties:
> > > >        - port@0
> > > >        - port@1
> > > >
> > > > +  switches:
> > > > +    type: object
> > > > +    description: Set of switches controlling DisplayPort traffic on
> > > > +      outgoing RX/TX lanes to Type C ports.
> > > > +    additionalProperties: false
> > > > +
> > > > +    properties:
> > > > +      '#address-cells':
> > > > +        const: 1
> > > > +
> > > > +      '#size-cells':
> > > > +        const: 0
> > > > +
> > > > +    patternProperties:
> > > > +      '^switch@[01]$':
> > > > +        $ref: /schemas/usb/typec-switch.yaml#
> > > > +        unevaluatedProperties: false
> > > > +
> > > > +        properties:
> > > > +          reg:
> > > > +            maxItems: 1
> > > > +
> > > > +        required:
> > > > +          - reg
> > > > +
> > > > +    required:
> > > > +      - switch@0
> > > > +
> > > >  required:
> > > >    - compatible
> > > >    - reg
> > > > @@ -167,5 +195,41 @@ examples:
> > > >                      };
> > > >                  };
> > > >              };
> > > > +            switches {
> > >
> > > Is "switches" a bus?
> >
> > No.
> >
> > >
> > > > +                #address-cells = <1>;
> > > > +                #size-cells = <0>;
> > > > +                switch@0 {
> > > > +                    compatible = "typec-switch";
> > >
> > > Is this compatible matched against a driver that's populated on this
> > > "switches" bus?
> >
> > No. Patch 6/7 has the implementation details on how the anx driver
> > performs the enumeration of switches.
> >
> > >
> > > > +                    reg = <0>;
> > > > +                    mode-switch;
> > > > +
> > > > +                    ports {
> > > > +                        #address-cells = <1>;
> > > > +                        #size-cells = <0>;
> > > > +                        port@0 {
> > > > +                            reg = <0>;
> > > > +                            anx_typec0: endpoint {
> > > > +                                remote-endpoint = <&typec_port0>;
> > > > +                            };
> > > > +                        };
> > > > +                    };
> > >
> > > I was expecting to see these simply be more ports in the existing graph
> > > binding of this device, and then have the 'mode-switch' or
> > > 'orientation-switch' properties be at the same level as the compatible
> > > string "analogix,anx7625". Here's the reasoning, based on looking at the
> > > product brief and the existing binding/implementation.
> > >
> > > Looking at the only existing implementation of this binding upstream in
> > > mt8183-kukui-jacuzzi.dtsi it looks like one of these typec ports is
> > > actually the same physically as the 'anx7625_out' endpoint (reg address
> > > of 1) that is already defined in the binding. It seems that MIPI DSI/DPI
> > > comes in and is output through 2 lanes, SSRX2 and SSTX2 according to the
> > > product brief[1], and that is connected to some eDP panel
> > > ("auo,b116xw03"). Presumably that is the same as anx_typec1 in this
> > > patch? I suspect the USB3.1 input is not connected on this board, and
> > > thus the crosspoint switch is never used, nor the SSRX1/SSTX1 pins.
> > >
> > > The existing binding defines the MIPI DSI/DPI input as port0 and two of
> > > the four lanes of output that is probably by default connected to the
> > > "DisplayPort Transmitter" as port1 because that's how the crosspoint
> > > switch comes out of reset. That leaves the USB3.1 input possibly needing
> > > a port in the ports binding, and the other two lanes of output needing a
> > > port in the ports binding to describe their connection to the downstream
> > > device. And finally information about if the crosspoint switch needs to
> > > be registered with the typec framework to do typec things, which can be
> > > achieved by the presence of the 'mode-switch' property.
> > >
> > > On a board like kukui-jacuzzi these new properties and ports wouldn't be
> > > specified, because what is there is already sufficient. If this chip is
> > > connected to a usb-c-connector then I'd expect to see a connection from
> > > the output ports in the graph binding to the connector node's ports.
> > > There aren't any ports in the usb-c-connector binding though from what I
> > > see.
> > >
> > > I believe there's also one more use case here where USB3.1 or MIPI
> > > DSI/DPI is connected on the input side and this device is used to steer
> > > USB3.1 or DP through the crosspoint switch to either of the two output
> > > pairs. This last scenario means that we have to describe both output
> > > pairs, SSRX1/SSTX1 and SSRX2/SSTX2, as different ports in the binding so
> > > they can be connected to different usb-c-connectors if the hardware
> > > engineer wired the output pins that way.
> > >
> > > TL;DR: Can we add 'mode-switch' as an optional property and two more
> > > ports at address 2 and 3 for the USB3.1 input and the SSRX1/SSTX1 pair
> > > respectively to the existing graph part of this binding?
> >
> > Sorry, but I got lost midway through the preceding explanation.
>
> Made sense to me.
>
> > The binding
> > can always add additional ports to each "switch" to accomplish the
> > graph connections
> > you are alluding to (if the driver needs/uses it, which I don't think
> > this one does at present).
>
> Why is the switch special? If I just look at this from a block diagram
> perspective, I just see a list of interfaces that need to be described
> in the graph.

Because it is specific to Type-C connectors. The anx7625.h does
contain a cross-point
switch which controls data lines coming from 1 (or more) Type-C
connectors, so it seems reasonable
to have a dedicated binding for such types of hardware sub-components,
which helps define the graph connections
in a more uniform manner. That's not to say:
- this can only be used by this hardware. The typec-switch binding is
generic enough to accommodate other hardware.
- there is only 1 way to do this. The interfaces could be described
using existing port OF graph bindings, but I don't
see that as reason enough to not include a dedicated switch binding if
it makes the overall binding more logically organized (IMO) and
makes driver registration code mode clean.

>
> > Adding extra ports to existing ports gets tricky from a mode-switch
> > enumeration perspective (which
> > ports should have the modes switches, which shouldn't? Do you follow
> > the remote end points for each port
> > and see which one is a Type C connector?
>
> The driver knows which port is which because the binding has to define
> it. So you have to check 2 of them (SSRX1/SSTX1 and SSRX2/SSTX2) to find
> usb C connectors.

Right, but with the switch binding you no longer need to check. If
there is a typec-switch, you know
it is coming from a Type-C connector, so you can just register the
switches with the Type-C framework.

>
> > What if we add an
> > intermediate switch device in the future?)
> > Having a dedicated "switch" binding makes this consistent and easy
> > (port0 will always have the end-point for the switch).
> >
> > While there may be more than 1 valid approach here, I believe the
> > current one is appropriate.
>
> To put it simply, if you want to define a generic binding, I want to see
> at least 2 users of it. What I really want to see is someone looking at
> all the Type-C related bindings and h/w possibilities, not just 1
> problem or their own h/w. IOW, a Type-C binding czar.

As I mentioned above, the typec-switch binding is generic enough to allow usage
by other hardware. I can think of at least 1 example which could
utilize this switch-binding [1], but I'd defer to the maintainer
of that binding to adopt the changes or not.

[1] https://elixir.bootlin.com/linux/v5.19-rc2/source/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml

Thanks,

>
> Rob
