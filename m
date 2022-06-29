Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCD9560DC6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 01:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiF2Xze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 19:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiF2Xza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 19:55:30 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D3526AD1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 16:55:29 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-101cdfddfacso23582915fac.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 16:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=QIrFb0TvnpVHjaIE7mc40LIegGWl6DWKRa7QFDrhXk4=;
        b=dzXf1XH/uJtFJmyqbLVoMDMPAYAj6sb1j8kiY+8ViFmkNF6z2vJK2PUHdY7n3PdoNz
         RAthHwRiglNjYgT9bYusntOHvCjwkUiEZviNZHr48BxkUgarRJETK4O0Ba4pq/TjNLTb
         Qcrj8eD5Qk5o6AU2YL8XCYsIfhXVJo+hapNEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=QIrFb0TvnpVHjaIE7mc40LIegGWl6DWKRa7QFDrhXk4=;
        b=ulspUPCDR5nN4nlb7ixezJ3EMrfizOaNrTZf5pCw0cOntSf7qZ6cd7Q7LFDGbLm/KC
         HYjJvyZJUF9PGQ5F8uSBB5mv6oxxbNzioendWvt/0yiYXsd+59EvdxfhlB4k3hYBobje
         jwoi9Rw0nHZen7p6xz1IEW6AJHIjt2ZGcSifPnjUsOIncAkWWo+jsL3G/N7M9n4hV5dA
         yN8pm3V+RPOLt3OUbpwNULo5SUCxBVNFRJhIyS30+zOhxsNJkQ5gQaDnrpCSZK0/Atwu
         d96apnmAWwogToiEpVQ9k3MFIcPkaXAaauTmSC8DnszrmUPn/aBxQLGB0rLlU/oDiFcv
         xulg==
X-Gm-Message-State: AJIora90G0Md05RoJ6JPMbzZTlCLjQs3ec+jlBXnm2VyFB4rNyt7qfdQ
        +Hw4UXKsZCnEw+mQgDc1KE01wocSE6z69r6wI0c5BA==
X-Google-Smtp-Source: AGRyM1vpUvFCCsQzt5IbfXsbZexe5tAektMajPk2Ws67cqHCtLoPBL/N7tys7Y1E555LDoAzvPZi9JmQZ9QWlaTpjPg=
X-Received: by 2002:a05:6870:b627:b0:102:f25:a460 with SMTP id
 cm39-20020a056870b62700b001020f25a460mr3535404oab.193.1656546928082; Wed, 29
 Jun 2022 16:55:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 29 Jun 2022 16:55:27 -0700
MIME-Version: 1.0
In-Reply-To: <CACeCKacJnnk4_dXEX7XiboOWrYpfAcE=ukP63agVAYUxWR9Vbg@mail.gmail.com>
References: <20220622173605.1168416-1-pmalani@chromium.org>
 <20220622173605.1168416-2-pmalani@chromium.org> <20220627210407.GA2905757-robh@kernel.org>
 <CACeCKackdbDZrk5fk7qyMwSdTdzyTS=m1vHPFnQOj672W=2nOA@mail.gmail.com>
 <20220628182336.GA711518-robh@kernel.org> <CAEXTbpex9nxP-nyPWvSBchAW4j3C4MZfVHTb=5X0iSLY1bSAKg@mail.gmail.com>
 <CAEXTbpf_jxK-R5aA81FCbpAH4bChA2B9+8qExZUbA7Y+Ort=Gg@mail.gmail.com>
 <CAL_Jsq+C04RXLtm6Ac85Ru3EGwJbqV_UD3_dDWVrKvFSvdm7Ng@mail.gmail.com>
 <CAE-0n53ers881LOTCEmKDDxJQt+5vvXJSURs=o6TcOiR5m_EAw@mail.gmail.com> <CACeCKacJnnk4_dXEX7XiboOWrYpfAcE=ukP63agVAYUxWR9Vbg@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 29 Jun 2022 16:55:27 -0700
Message-ID: <CAE-0n50jm1ovUcBC0GCQJszk-4u+0vDQtAxHxsu9SLyn_CkQuQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] dt-bindings: usb: Add Type-C switch binding
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Pin-yen Lin <treapking@chromium.org>,
        Rob Herring <robh@kernel.org>,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Prashant Malani (2022-06-29 15:55:10)
> On Wed, Jun 29, 2022 at 2:58 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > My understanding is there are 4 DP lanes on it6505 and two lanes are
> > connected to one usb-c-connector and the other two lanes are connected
> > to a different usb-c-connector. The IT6505 driver will send DP out on
> > the associated two DP lanes depending on which usb-c-connector has DP
> > pins assigned by the typec manager.
[...]
>
> We can adopt this binding, but from what I gathered in this thread, that
> shouldn't be done, because IT6505 isn't meant to be aware of Type-C
> connections at all.

How will the driver know which usb-c-connector to route DP to without
making the binding aware of typec connections?

> >
> > I think the difficulty comes from the combinatorial explosion of
> > possible configurations. As evidenced here, hardware engineers can take
> > a DP bridge and use it as a DP mux as long as the bridge has lane
> > control. Or they can take a device like anx7625 and ignore the USB
> > aspect and use the internal crosspoint switch as a DP mux. The anx7625
> > part could be a MIPI-to-DP display bridge plus mux that is connected to
> > two dp-connectors, in which case typec isn't even involved, but we could
> > mux between two dp connectors.
>
> Each containing a single DP lane, right?

Yes.

> I think that will not be a valid configuration, since there is only 1 HPD
> pin (so it's assuming both DP lanes go to the same DP sink).

HPD can be signalled out of band, or not at all (no-hpd). I suspect it's
valid to ignore/disconnect the HPD pin here and start/stop DP when, for
example, the HPD pin toggles within a dp-connector. HPD could be
signaled directly to the kernel via an out of band gpio going from the
dp-connector to the SoC. In this case HPD for each dp-connector could be
a different gpio and the driver may be required to arbitrate between the
two dp-connectors with some 'first to signal wins' logic or something.

>
> But yes, your larger point is valid: h/w engineers can repurpose these
> bridges in ways the datasheet doesn't originally anticipate.

Yeah, I'm also trying to say that devices with typec logic may not be
used for typec purposes.

>
> >
> > Also, the typec framework would like to simply walk the graph from the
> > usb-c-connector looking for nodes that have 'mode-switch' or
> > 'orientation-switch' properties and treat those devices as the typec
> > switches for the connector. This means that we have to add these typec
> > properties like 'mode-switch' to something like the IT6505 bridge
> > binding, which is a little awkward. I wonder if those properties aren't
> > really required. Would it be sufficient if the framework could walk the
> > graph and look for registered typec switches in the kernel that have a
> > matching of_node?
>
> My interpretation of the current mode-switch search code [1] is that
> a top level property of "mode-switch" is required.

Yeah that's how it is right now, but does it have to stay that way?
Could the code search the graph and look for a matching node that's
registered with the typec framework? The goal is to avoid adding typec
properties like 'mode-switch' to bindings like bridge converters that
aren't expected to work with typec. Hopefully the binding can be written
with the output pins in mind and what modes on those pins the hardware
supports (e.g. two lanes on anx7625 can't be split apart whereas on
it6505 each pair can be used directly).
