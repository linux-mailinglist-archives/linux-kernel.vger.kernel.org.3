Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E5055EC87
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 20:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbiF1SXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 14:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiF1SXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 14:23:41 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CC920F68;
        Tue, 28 Jun 2022 11:23:40 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id 9so8723471ill.5;
        Tue, 28 Jun 2022 11:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=L8dLhWtyP9bNEnDeqAVxELfE92uyIseUX2/6UItTECE=;
        b=Qwhq3o8IUIDFSOtksKehPoloqk+eMlkHSqnDO1uNr3XkvK9wkeAhGLrsBfdrXa/JuL
         8gAnWZyVLs/WuGnFsS71+uqPFEo6/d2QYv8oQl1P1f0gcX33iEC16Bm8nhD+EjdN87wB
         bONqp5TWDBVZukoXW5BOlg6buZDCSLxtc+gp/I8q6ePmg6L8BJLESRO+Xof/qA7eOkFh
         eGgegOflFWqj2faPs+IEx8dNdwXxldVElZp9EuprWjHYBUmIe6tJfhDR0AGjHMx7/NnB
         qeILTl/NyM3l8kgqhadXot6Su+Sj653a53ISwIwYCM8bU6nXBS0W3IGKvpO6IhPi63nG
         z4IQ==
X-Gm-Message-State: AJIora93t2v2RQlalEa8PnbK3xQ7R62XzwsJ+GR037Ea6WcuEf8RGbRT
        IX91tDj8b8G9yoLk3BItAQ==
X-Google-Smtp-Source: AGRyM1tXG8m32MD61k1cJ7tHSHABYN3CwZrRXoFc256eZb145SpZpYocyNn4hj/9uDJtyfBZfDaJrg==
X-Received: by 2002:a92:ccc6:0:b0:2d9:445b:4f2f with SMTP id u6-20020a92ccc6000000b002d9445b4f2fmr11230557ilq.32.1656440619931;
        Tue, 28 Jun 2022 11:23:39 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id h19-20020a056638063300b00339dc6d8f9bsm6575938jar.50.2022.06.28.11.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 11:23:39 -0700 (PDT)
Received: (nullmailer pid 742574 invoked by uid 1000);
        Tue, 28 Jun 2022 18:23:36 -0000
Date:   Tue, 28 Jun 2022 12:23:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bleung@chromium.org, swboyd@chromium.org,
        heikki.krogerus@linux.intel.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Allen Chen <allen.chen@ite.com.tw>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
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
Subject: Re: [PATCH v5 1/9] dt-bindings: usb: Add Type-C switch binding
Message-ID: <20220628182336.GA711518-robh@kernel.org>
References: <20220622173605.1168416-1-pmalani@chromium.org>
 <20220622173605.1168416-2-pmalani@chromium.org>
 <20220627210407.GA2905757-robh@kernel.org>
 <CACeCKackdbDZrk5fk7qyMwSdTdzyTS=m1vHPFnQOj672W=2nOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACeCKackdbDZrk5fk7qyMwSdTdzyTS=m1vHPFnQOj672W=2nOA@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 02:43:39PM -0700, Prashant Malani wrote:
> Hello Rob,
> 
> On Mon, Jun 27, 2022 at 2:04 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, Jun 22, 2022 at 05:34:30PM +0000, Prashant Malani wrote:
> > > Introduce a binding which represents a component that can control the
> > > routing of USB Type-C data lines as well as address data line
> > > orientation (based on CC lines' orientation).
> > >
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > > Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > > ---
> > >
> > > Changes since v4:
> > > - Added Reviewed-by tags.
> > > - Patch moved to 1/9 position (since Patch v4 1/7 and 2/7 were
> > >   applied to usb-next)
> > >
> > > Changes since v3:
> > > - No changes.
> > >
> > > Changes since v2:
> > > - Added Reviewed-by and Tested-by tags.
> > >
> > > Changes since v1:
> > > - Removed "items" from compatible.
> > > - Fixed indentation in example.
> > >
> > >  .../devicetree/bindings/usb/typec-switch.yaml | 74 +++++++++++++++++++
> > >  1 file changed, 74 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/usb/typec-switch.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/usb/typec-switch.yaml b/Documentation/devicetree/bindings/usb/typec-switch.yaml
> > > new file mode 100644
> > > index 000000000000..78b0190c8543
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/usb/typec-switch.yaml
> > > @@ -0,0 +1,74 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/usb/typec-switch.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: USB Type-C Switch
> > > +
> > > +maintainers:
> > > +  - Prashant Malani <pmalani@chromium.org>
> > > +
> > > +description:
> > > +  A USB Type-C switch represents a component which routes USB Type-C data
> > > +  lines to various protocol host controllers (e.g USB, VESA DisplayPort,
> > > +  Thunderbolt etc.) depending on which mode the Type-C port, port partner
> > > +  and cable are operating in. It can also modify lane routing based on
> > > +  the orientation of a connected Type-C peripheral.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: typec-switch
> > > +
> > > +  mode-switch:
> > > +    type: boolean
> > > +    description: Specify that this switch can handle alternate mode switching.
> > > +
> > > +  orientation-switch:
> > > +    type: boolean
> > > +    description: Specify that this switch can handle orientation switching.
> > > +
> > > +  ports:
> > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > +    description: OF graph binding modelling data lines to the Type-C switch.
> > > +
> > > +    properties:
> > > +      port@0:
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +        description: Link between the switch and a Type-C connector.
> > > +
> > > +    required:
> > > +      - port@0
> > > +
> > > +required:
> > > +  - compatible
> > > +  - ports
> > > +
> > > +anyOf:
> > > +  - required:
> > > +      - mode-switch
> > > +  - required:
> > > +      - orientation-switch
> > > +
> > > +additionalProperties: true
> > > +
> > > +examples:
> > > +  - |
> > > +    drm-bridge {
> > > +        usb-switch {
> > > +            compatible = "typec-switch";
> >
> > Unless this child is supposed to represent what the parent output is
> > connected to, this is just wrong as, at least for the it6505 chip, it
> > doesn't know anything about Type-C functionality. The bridge is
> > just a protocol converter AFAICT.
> 
> I'll let Pin-Yen comment on the specifics of the it6505 chip.

We're all waiting...

> > If the child node represents what the output is connected to (like a
> > bus), then yes that is a pattern we have used.
> 
> For the anx7625 case, the child node does represent what the output is connected
> to (the usb-c-connector via the switch). Does that not qualify? Or do you mean
> the child node should be a usb-c-connector itself?
> 
> > For example, a panel
> > represented as child node of a display controller. However, that only
> > works for simple cases, and is a pattern we have gotten away from in
> > favor of using the graph binding.
> 
> The child node will still use a OF graph binding to connect to the
> usb-c-connector.
> Is that insufficient to consider a child node usage here?
> By "using the graph binding", do you mean "only use the top-level ports" ?
> I'm trying to clarify this, so that it will inform future versions and patches.

What I want to see is block diagrams of possible h/w with different 
scenarios and then what the binding looks like in those cases. The 
switching/muxing could be in the SoC, a bridge chip, a Type C 
controller, a standalone mux chip, or ????. If you want a somewhat 
genericish binding, then you need to consider all of these.

I don't really have the b/w to work thru all this (and switch/mux is 
just one part of dealing with Type-C). This is just one of about a 
hundred patches I get to review a week.

Rob
