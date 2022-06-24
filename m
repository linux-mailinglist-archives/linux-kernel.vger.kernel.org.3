Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC1C558D2C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 04:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiFXCOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 22:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiFXCOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 22:14:00 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B811517CC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 19:13:59 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id f10-20020a4aa68a000000b0042579cb6238so219744oom.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 19:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=/VGk8F/SGTm+nA86WQSFAF1khuATXIOmF7Nb/YW6zYU=;
        b=U/aMFLc9SlPd0ev9cbNDFUH3VZKjxLKW1usFu47cpdQVNYEfRax18X59Fi1QCls4Kz
         /m6OenxKag+dBrD6MDGaB6XsTliXs89R/ZvtHWPjrPuJ5PYveZy18cNT4Q60enrEIudb
         IcU8OWtqxoWRLS260YbgyuS9xrDef0ymfLOpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=/VGk8F/SGTm+nA86WQSFAF1khuATXIOmF7Nb/YW6zYU=;
        b=5vIHXdT2DG/aQE2VQYYj0/6a5A6uckwnPMslzAZsyX9tOOddhLCIKJJgegdq6CUrPP
         EgOKagd2Iira7rSzD8MCGu5ooMrDyccUKSznTyI0VaZp/IzeiGIMpusqnjCfKavNdmkY
         lHER8s7MmdJUl+JiIv+lQcCrXj55k9nedot3K0eJEkwcviVzrkrnd8xiWecfzIn7osCH
         zmXlF5dxDeM4qagQsrIMqtURyb+AjdFcV7ovgRt85tBIkY/Fs0+0jQyAaf4B449ndhQM
         Im9YlmksAuBJ0vIY18By1v9goKvgFStMpjctbdAOtmAgiDIJ8HWzZct3UXukcJ0ieceZ
         zz4A==
X-Gm-Message-State: AJIora8sdNW4x9+oJiHLLx9nNQ2hmFoszyEgzQO7z+dKCXv3hW9U52d5
        21cpUybJIs3jsV7sxTB2g3hzOGnDJzIAE7cBPiI6Jw==
X-Google-Smtp-Source: AGRyM1tSxFFQ/8QuvcgiN9oT0/xNSfBR6w7RlimtXUAU8niX16bpVvTWIUPp0rLiKRd3ZOPqXYv8KQj1I+iTf8xqCqs=
X-Received: by 2002:a4a:98a6:0:b0:41b:e04e:70ce with SMTP id
 a35-20020a4a98a6000000b0041be04e70cemr5013135ooj.25.1656036838607; Thu, 23
 Jun 2022 19:13:58 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 23 Jun 2022 19:13:58 -0700
MIME-Version: 1.0
In-Reply-To: <CACeCKacGZFY-_yn1R33OVcsdG47oqNTGBA43L5hrH2zyhK=cRw@mail.gmail.com>
References: <20220622173605.1168416-1-pmalani@chromium.org>
 <20220622173605.1168416-2-pmalani@chromium.org> <CAE-0n51kcr3VGdR2Kf8j1JaBbLcCmWo9GYhhvkUQ4+jn2iEKLg@mail.gmail.com>
 <CACeCKac4eL9++QwbDBKrVTpUzhes=WczqZfh+cFiVgoO4py4MQ@mail.gmail.com>
 <CAE-0n51E1TLMRNWnqiV-jU_qg15BF4D6A+0G1y1SRTu1zNs2Dg@mail.gmail.com> <CACeCKacGZFY-_yn1R33OVcsdG47oqNTGBA43L5hrH2zyhK=cRw@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 23 Jun 2022 19:13:57 -0700
Message-ID: <CAE-0n53i90ZUFSmrR=ScXtMdn_bWPY49WWTf9LXbxu_udGgP9w@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] dt-bindings: usb: Add Type-C switch binding
To:     Prashant Malani <pmalani@chromium.org>
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

Quoting Prashant Malani (2022-06-23 17:35:38)
> On Thu, Jun 23, 2022 at 4:14 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > I'm not aware of any documentation for the dos and don'ts here. Are
> > there any examples in the bindings directory that split up a device into
> > subnodes that isn't in bindings/mfd?
>
> usb-c-connector [3] and its users is an example.

What are the subnodes? The graph ports? That is not what I meant. I
meant splitting up a device functionality, like type-c and display
bridge, into subnodes. Composition of devices through DT bindings isn't
how it's done. Instead, we dump all the different functionality into the
same node. For example, look at the number of bindings that have both
#clock-cells and #reset-cells, when those are distinct frameworks in the
kernel and also different properties. We don't make subnodes to contain
the different functionality of a device.

And in this case I still don't see the point to making a subnode. The
API can simply setup a type-c switch based on a graph binding for the
toplevel node, e.g. the drm-bridge, and the driver can tell the API
which port+endpoint to use to search the graph for the usb-c-connector
to associate with the switch. We don't need to connect the graph within
the drm-bridge node to the graph within the typec-switch node to do
that. That's an internal detail of the drm-bridge that we don't expose
to DT, because the driver knows the detail. It also aligns the graph
binding for the top-level node with non-typec bindings, like drm, which
don't use a second level of graph binding to achieve essentially the
same thing when the output is connected to a DP connector.

> >
> > >
> > > > Why doesn't it work to
> > > > merge everything inside usb-switch directly into the drm-bridge node?
> > >
> > > I attempted to explain the rationale in the previous version [1], but
> > > using a dedicated sub-node means the driver doesn't haven't to
> > > inspect individual ports to determine which of them need switches
> > > registered for them. If it sees a `typec-switch`, it registers a
> > > mode-switch and/or orientation-switch. IMO it simplifies the hardware
> > > device binding too.
> >
> > How is that any harder than hard-coding that detail into the driver
> > about which port and endpoint is possibly connected to the
> > usb-c-connector (or retimer)? All of that logic could be behind some API
> > that registers a typec-switch based on a graph port number that's passed
> > in, ala drm_of_find_panel_or_bridge()'s design.
>
> If each driver has to do it (and the port specifics vary for each driver),
> it becomes an avoidable overhead for each of them.
> I prefer hard-coding such details if avoidable. I suppose both approaches
> require modifications to the binding and the driver code.

Ok, sounds like it is not any harder.

>
> >
> > Coming from a DT writer's perspective, I just want to go through the
> > list of output pins in the datasheet and match them up to the ports
> > binding for this device. If it's a pure DP bridge, where USB hardware
> > isn't an input or an output like the ITE chip, then I don't want to have
> > to describe a port graph binding for the case when it's connected to a
> > dp-connector (see dp-connector.yaml) in the top-level node and then have
> > to make an entirely different subnode for the usb-c-connector case with
> > a whole other set of graph ports.
>
> This approach still allows for that, if the driver has any use for it
> (AFAICT these drivers don't).
> Iff that driver uses it, one can (optionally) route their output
> (top-level) ports through the
> "typec-switch" sub-node (and onwards as required).
> If it's being used in a "pure-DP" configuration, the "typec-switch" just
> goes away (the top level ports can be routed as desired by the driver).
> (Again, I must reiterate that neither this driver or the anx driver
> utilizes this)
>
> >
> > How would I even know which two differential pairs correspond to port0
> > or port1 in this binding in the ITE case?
>
> Why do we need to know that? It doesn't affect this or the other
> driver or hardware's
> functioning in a perceivable way.

If the device registers allow control of the DP lane to physical pin
mapping, so that DP lane0 and DP lane1 can be swapped logically, then
we'll want to know which DP lanes we need to swap by writing some lane
remapping register in the device. Sometimes for routing purposes devices
support this lane remapping feature so the PCB can route the lines
directly to the connector instead of going in circles and destroying the
signal integrity.

>
> > Ideally we make the graph
> > binding more strict for devices by enforcing that their graph ports
> > exist. Otherwise we're not fully describing the connections between
> > devices and our dtb checkers are going to let things through where the
> > driver most likely will fail because it can't figure out what to do,
> > e.g. display DP on 4 lanes or play some DP lane rerouting games to act
> > as a mux.
>
> How is the current binding enforcing this? The typec-switch binding
> as a first step ensures that the DT is connecting the hardware(anx,ite
> etc) to something
> that at least "claims" to be a Type-C switch.

I'm simply saying that we can extend existing bindings like anx or ite
to have required properties for ports so that we know the driver will
find something on the other end of the graph. A binding that doesn't
have any ports will be invalid. I don't know if that's possible to do
in the schema.

>
> > Is that why you're proposing this binding? To
> > avoid describing a graph binding in the usb-c-connector and effectively
> > "pushing" the port count up to the mux?
>
> No, that is not the intention behind this series. The
> 'usb-c-connector' still needs the
> graph binding to the `typec-switch`. SBU, HS and SS lanes might have different
> muxes altogether (usb-c-connect has separate ports for SBU, HS and SS lanes)

If the usb-c-connector still needs a graph binding to the typec-switch
then why isn't that part of this series?
