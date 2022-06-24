Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB8855A3D2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 23:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbiFXVlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 17:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiFXVls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 17:41:48 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C6A37AA4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:41:47 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id p136so432046ybg.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KwSe0AE8xuDdVckfxEZwgd9uzlK0jUKIVPL9Zhmd0sI=;
        b=mL3aqN0eV5wBA2kBnVNdsoRFGISINp70UscX6zh991Or58FaeCh+btRRuil/JCyD3i
         ysYJDXVEsBhPiHN5dGK6iWgSZrwpYIL7zt4rhKsgMT/mPH7+cXWlmb1WQ7DOlgwgu/1Y
         d7CAhVUlfuNPAFjEKg++NG+xn6IJvVE9Z+BNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KwSe0AE8xuDdVckfxEZwgd9uzlK0jUKIVPL9Zhmd0sI=;
        b=QiCNbYfZEB1YcQYcIbl2x2GioI4G46nMcjqTHjdO1gzHbYYjucdMXddpjKSCmNYbyQ
         o/qa1/o+2OoEV+wcaslXJSqUo2kmr+vxwsz2WZ48bSEWRZeMkmSVf8rkLZaBwJhT4tP6
         Skqx31L5Of3zJGq8aBXu6+rqdTUux2lWHUs544LsRQdn4jtrpDECeap7q/SxsEmB+xhv
         4AaWqbU+5QoEMrWxv4zt2RIGBR/kM3D5fuuv7MuEfsBKs76Ipq6zYKqBy2NaQVMQ5uM5
         ozUrfzsgnnTf+eMXI1vrY3WSE7dDLCv1dM87GKNoe4cb54V4LAridlA1CbtgMmuDj2O5
         JK6g==
X-Gm-Message-State: AJIora/FOIazLFI2fnSDr6SWcQ4E7gwYbKz4NulkWH+vROd0hpk759Dj
        1de0ER0ccLgkIpjbXKoFoyDzFqPGhFJ9sm2zEtEHJg==
X-Google-Smtp-Source: AGRyM1vXDzzrmcLhRzAlxrs+doDmJtuMt4h47FzgwPHxLyPsjKEcC4k0v9we/8WmGpGfyR8DVoE1utP3NYSaxg3X5EY=
X-Received: by 2002:a5b:8d1:0:b0:668:c6ca:7571 with SMTP id
 w17-20020a5b08d1000000b00668c6ca7571mr1226544ybq.445.1656106906728; Fri, 24
 Jun 2022 14:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220622173605.1168416-1-pmalani@chromium.org>
 <20220622173605.1168416-2-pmalani@chromium.org> <CAE-0n51kcr3VGdR2Kf8j1JaBbLcCmWo9GYhhvkUQ4+jn2iEKLg@mail.gmail.com>
 <CACeCKac4eL9++QwbDBKrVTpUzhes=WczqZfh+cFiVgoO4py4MQ@mail.gmail.com>
 <CAE-0n51E1TLMRNWnqiV-jU_qg15BF4D6A+0G1y1SRTu1zNs2Dg@mail.gmail.com>
 <CACeCKacGZFY-_yn1R33OVcsdG47oqNTGBA43L5hrH2zyhK=cRw@mail.gmail.com>
 <CAE-0n53i90ZUFSmrR=ScXtMdn_bWPY49WWTf9LXbxu_udGgP9w@mail.gmail.com>
 <CACeCKaffqb6v7TFji2u00VSQ=DGvRe-gcxMnAEbZCC1qtDZF6A@mail.gmail.com> <CAE-0n51AYqr4wcD-JaVaTYjFgxCj+iX+xAYKCrZCqGHE2XEUgA@mail.gmail.com>
In-Reply-To: <CAE-0n51AYqr4wcD-JaVaTYjFgxCj+iX+xAYKCrZCqGHE2XEUgA@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Fri, 24 Jun 2022 14:41:36 -0700
Message-ID: <CACeCKad_vB+cHzwkBrvi90u7mBmJbk=YuecOwsp1xexYUiq-_A@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] dt-bindings: usb: Add Type-C switch binding
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bleung@chromium.org, heikki.krogerus@linux.intel.com,
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
        Pin-Yen Lin <treapking@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
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

On Fri, Jun 24, 2022 at 12:50 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Prashant Malani (2022-06-23 19:48:04)
> > On Thu, Jun 23, 2022 at 7:13 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Prashant Malani (2022-06-23 17:35:38)
> > > > On Thu, Jun 23, 2022 at 4:14 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > > >
> > > > > I'm not aware of any documentation for the dos and don'ts here. Are
> > > > > there any examples in the bindings directory that split up a device into
> > > > > subnodes that isn't in bindings/mfd?
> > > >
> > > > usb-c-connector [3] and its users is an example.
> > >
> > > What are the subnodes? The graph ports? That is not what I meant.
> >
> > cros-ec-typec [4] uses subnodes of usb-c-connector. Chrome OS DTs
> > use the ports from the included usb-c-connector to switching hardware.
>
> Ok, got it. usb-c-connector nodes are children of the typec controller
> (in this case cros-ec-typec) because otherwise we would need to make a
> phandle link from the usb-c-connector node(s) under the root node / to
> the typec controller. The phandle link may need to be done in both
> directions, so it makes more sense to put the usb-c-connector nodes
> underneath the typec controller to express the direct relationship
> between the typec controller and the usb-c-connectors.
>
> Furthermore, the usb-c-connector is not integrated as part of the EC in
> the same package. There is a discrete part placed on the board that
> corresponds to the usb-c-connector and that is separate from the EC. The
> connectors are in essence only controllable through the EC because
> that's the typec controller.

From the perspective of the AP, the `usb-c-connector` *is* an integrated part of
the Chrome EC; there is no alternative way to control it except
through the Chrome EC.
So the above example reinforces the usage model for typec-switch (which is
also an "integrated" component).

> It's similar to how we place i2c devices as
> child nodes of the i2c controller.
>
> >
> > > I meant splitting up a device functionality, like type-c and display
> > > bridge, into subnodes. Composition of devices through DT bindings isn't
> > > how it's done. Instead, we dump all the different functionality into the
> > > same node. For example, look at the number of bindings that have both
> > > #clock-cells and #reset-cells, when those are distinct frameworks in the
> > > kernel and also different properties. We don't make subnodes to contain
> > > the different functionality of a device.
> > >
> > > And in this case I still don't see the point to making a subnode.
> >
> > I've already provided my best effort at explaining the rationale.
> >
> > > The
> > > API can simply setup a type-c switch based on a graph binding for the
> > > toplevel node, e.g. the drm-bridge, and the driver can tell the API
> > > which port+endpoint to use to search the graph for the usb-c-connector
> > > to associate with the switch.
> >
> > OK, drm-bridge uses that approach. This is another approach. I didn't fully
> > understand why we *have* to follow what drm-bridge is doing.
> >
> > > We don't need to connect the graph within
> > > the drm-bridge node to the graph within the typec-switch node to do
> > > that. That's an internal detail of the drm-bridge that we don't expose
> > > to DT, because the driver knows the detail.
> >
> > I still don't understand why we can't do that. These devices have actual
> > hardware blocks that represent the Type-C switch functionality.
> >
>
> We don't break up device functionality for an IC into different subnodes
> with different compatibles. Similarly, we don't describe internal
> connection details of device nodes. The device driver that binds to the
> compatible should know the details of the internal block diagram of the
> part.

I don't completely agree with the above. There
is scope for middle-ground where some details can be codified into
DT bindings, and the driver can have the flexibility to be able to handle them.
But this now devolves into an ideological debate which I don't want
to get involved in, so I will restrict my responses on this subject.

> The DT binding should describe the external connections of the
> part and have properties that inform the driver about how the part was
> integrated into the system (e.g. mode-switch). The unwritten DT mantra
> is "less is more".
>
> We could definitely make many subnodes and add properties for everything
> inside an IC so that the DT describes the complete block diagram of the
> part, but at that point the driver is a shell of its former self.

That is a pathological/extreme argument which is not the case here,
we're just adding 1 sub-node because it's a sub-component that interfaces
with a kernel framework (Type-C class etc). The driver should be able to deal
with varying hardware configurations for the device and I don't believe that
makes it a "shell of its former self" any more than hard-coding port
details in the driver.

> The driver will spend time parsing properties to learn details that are

This parsing only occurs 1 once at probe, so I don't consider it much
of an overhead. The alternative suggested leads to the driver using time
looking up OF ports (with the port number). I fail to see how either is
noticeably more efficient than the other, especially on modern systems.

> entirely unchanging for the lifetime of the device (e.g. that the device
> has typec switch capabilities); things that should be hard-coded in the
> driver.
>
> Of course, if the device is integrated into the system and doesn't need
> to perform typec switching, then we want a property to tell the driver
> that this device is integrated in a way that the typec switch is not
> needed/used. Basically the driver should key that functionality off of
> the presence of the 'mode-switch' or 'orientation-switch' property
> instead of off the presence of a typec-switch subnode.
>
> > > >
> > > > >
> > > > > How would I even know which two differential pairs correspond to port0
> > > > > or port1 in this binding in the ITE case?
> > > >
> > > > Why do we need to know that? It doesn't affect this or the other
> > > > driver or hardware's
> > > > functioning in a perceivable way.
> > >
> > > If the device registers allow control of the DP lane to physical pin
> > > mapping, so that DP lane0 and DP lane1 can be swapped logically, then
> > > we'll want to know which DP lanes we need to swap by writing some lane
> > > remapping register in the device. Sometimes for routing purposes devices
> > > support this lane remapping feature so the PCB can route the lines
> > > directly to the connector instead of going in circles and destroying the
> > > signal integrity.
> >
> > Then add more end-points to port@1 (for each differential pair
> > you want to describe) of the usb-c-connector and route them
> > to the typec-switch accordingly.
> > FWIW I'm not aware of h/w *that supports DP alt mode* that uses the
> > functionality
> > you're referring to.
> >
>
> The Qualcomm QMP usb+dp phy supports lane remapping.

Ok great. So we can follow the method described above for specifying these
differential pairs if required. That is not related to this patch
series (although it is compatible
with it).

>
> > >
> > > >
> > > > > Is that why you're proposing this binding? To
> > > > > avoid describing a graph binding in the usb-c-connector and effectively
> > > > > "pushing" the port count up to the mux?
> > > >
> > > > No, that is not the intention behind this series. The
> > > > 'usb-c-connector' still needs the
> > > > graph binding to the `typec-switch`. SBU, HS and SS lanes might have different
> > > > muxes altogether (usb-c-connect has separate ports for SBU, HS and SS lanes)
> > >
> > > If the usb-c-connector still needs a graph binding to the typec-switch
> > > then why isn't that part of this series?
> >
> > That's not what I meant (what I meant earlier is the intention is not
> > what you stated).
> > I simply meant that the usb-c-connectors ports should be connected to
> > the typec-switch
> > ports. There isn't any binding update required for this.
> >
>
> Ok. Got it.

This really is a limited binding change that helps describe connections
between Type-C components, helps these components integrate with
the kernel Type-C framework, and consolidates the associated properties.
I believe it works for most current use cases in the upstream kernel.

I'm happy to discuss more theoretical use cases further, but
respectfully, I prefer to do
so off-list.

If the maintainer is OK with it (Krzysztof has reviewed it, but I
don't want to presume
what the protocol is for patches in this subsystem), and we've
provided 2 users as asked for
in v4 [5], then I request its consideration for submission.
If the maintainers have further concerns, we'd be happy to address them.

Best regards,

-Prashant

[5] https://lore.kernel.org/linux-usb/20220616193424.GA3844759-robh@kernel.org/
