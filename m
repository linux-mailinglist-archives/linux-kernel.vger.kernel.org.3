Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78D1571734
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiGLKW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiGLKWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:22:54 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEA2AD869
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:22:53 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 9-20020a1c0209000000b003a2dfdebe47so3680028wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rYt9mJQXaGbahl8QZrYNjHB9pJ9eAjTgp/ns4Eb/t8M=;
        b=C5cPOGc9EqUsoFUWmrc7jVCibS5iN0UUoBC/PfD22KAgo7wUifuge6eKtWgdHhTmhK
         fvpH/mXMm0hRgT9dWl3DZZDJL93EODM9jrUcKm7gjTFh/xMon7EdLXhbB2YK122pbx73
         rwuP0BAxkambkdp1i6kemqXPccg0rBuRv2ni0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rYt9mJQXaGbahl8QZrYNjHB9pJ9eAjTgp/ns4Eb/t8M=;
        b=lfazmK+zzrmgQL91vdDoiBe9jjhFVHjxDJUd+ciIejqlvoI3hlVnQx5LGuWAAx6oUT
         S1wf+Lm9i4F/7P7yVz2f3pDBcD76/dTt72jVKpENJhYzwkhqwu8HeF6khH8VFUK2jbqq
         VPr97Bi/zlKamLKh12DoGhs3UG9bZ98p9wdwyOHewdbEvflKMRiH4WlZkZFcQTff5TKK
         WglVc4cgz5bErfE2lM53tiSAYlKieowU3xlYyJIlJTlQA90Cw5+qwY20WYT2T9GWZzw0
         BF1LFqykzdBwzlNy3paNRYzab1ncWaV4rNHvzHVn7bolFB/e+d7Tw7p7tBvnRrYL7KWY
         75+A==
X-Gm-Message-State: AJIora/Nyzd41oFSXyhB8KgGzrnK8xIM4NqpzQpABaSmNXPQ/Zeqy5mC
        8DlanMrZ7f0qd7jiCJ1W51eWXAU53CyosuRgu9a+kg==
X-Google-Smtp-Source: AGRyM1svSmDLIfSSDkmMhxcC2NCCDtQdNFo2Jmf8Eb2S0Zy+X9IE/1D5IMRYMtZUefJka9rOnNuo/87dPKq7cEDP4jA=
X-Received: by 2002:a05:600c:3d13:b0:3a2:cb5f:87e7 with SMTP id
 bh19-20020a05600c3d1300b003a2cb5f87e7mr3008291wmb.178.1657621371850; Tue, 12
 Jul 2022 03:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220622173605.1168416-1-pmalani@chromium.org>
 <20220622173605.1168416-6-pmalani@chromium.org> <CAE-0n517BB8YbN5AZG6M3ZrZGOJDV=+t0R9d8wD+gVqO1aD1Xg@mail.gmail.com>
 <CACeCKafR8hFke_tc2=1VGDNF-CFrZoAG1aUKuxGJG-6pd37hbg@mail.gmail.com>
 <CAE-0n50XbO5Wu4-429Ao05A4QrbSXoi1wBjTpGFjKm3pZj1Ybg@mail.gmail.com>
 <CACeCKafzB0wW_B2TOEWywLMyB+UhYCpXYDVBV=UbyxBiGnv1Rw@mail.gmail.com>
 <CAE-0n50Akd8QikGhaAQgxLkJBhE-7KQf5aJ_P2ajOmCjLk555g@mail.gmail.com>
 <CACeCKafQT_RBrkHJNE2ezahSsHLPrbnS69QbfnjxBoUhi6hjwQ@mail.gmail.com>
 <CACeCKafya_XA+C3eJUvT4vjQSgsjdewVkCb+Jr2tA1605jjfjg@mail.gmail.com> <CAE-0n53kujMrzFG++5kaS4QKj2YrzLJEu5R76W887rCW_S592g@mail.gmail.com>
In-Reply-To: <CAE-0n53kujMrzFG++5kaS4QKj2YrzLJEu5R76W887rCW_S592g@mail.gmail.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Tue, 12 Jul 2022 18:22:40 +0800
Message-ID: <CAEXTbpdVr07Ur2L1NQjk8Vn=yUK=70K0sgbfTxsMJEvGd7CD2A@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] drm/bridge: anx7625: Add typec_mux_set callback function
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bleung@chromium.org, heikki.krogerus@linux.intel.com,
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
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xin Ji <xji@analogixsemi.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 7, 2022 at 8:17 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Prashant Malani (2022-07-06 11:26:19)
> >
> > Stephen, any pending concerns?
>
> No more pending concerns.
>
> > If not,I will post a v6 series with the suggested changes:
> > - Drop typec-switch binding; instead add a new top-level port with
> > end-points for each Type-C connector's switch.
> > - Drop it6505 patches.
> > - Squash anx7625 driver patches into one patch.
> > - Add a comment mentioning that we aren't registering the orientation-switch.

We've been working on these changes, and the new DT node looks like this:

```
    anx_bridge_dp: anx7625-dp@58 {
        [...]
        mode-switch;
        ports {
            [...]
            typec_switches: port@2 {
                #adderss-cells = <1>;
                #size-cells = <0>;
                reg = <2>;

                anx_typec0: endpoint@0 {
                    reg = <0>;
                    remote-endpoint = <&typec_port0>;
                };
                anx_typec1: endpoint@1 {
                    reg = <1>;
                    remote-endpoint = <&typec_port1>;
                };
            };
        };
```

However we found some issues with that approach:
1. The current typec mux API does not allow us to put muxes into
`ports` directly.
`fwnode_typec_mux_get` searches for the parent node behind the port(s)
nodes, so we cannot register the muxes with the port nodes unless we
change the interface.
2. We need a compatible string between the `endpoint` nodes and the
parent node (anx7625-dp@58).
This is because when the driver core builds the device links, they
only add links on nodes with a compatible string for `remote-endpoint`
properties[1].
Without a compatible string, the parent node of `typec_port0`
(cros-ec-typec in our case) has to be probed before anx7625, but this
leads to a deadlock because cros-ec-typec requires anx7625 to register
the typec_mux drivers first. I'm not sure if this is cros-ec-typec
specific, though.
*Any* compatible string fixes this issue, and it doesn't have to be
"typec-switch".

--

Alternatively, can we split the two muxes into two sub-nodes, like the
following snippet?

```
    anx_bridge_dp: anx7625-dp@58 {
        [...]
        mode-switch;

        anx_mux0 {
            compatible = "typec-switch";
            reg = <0>;

            port {
                anx_typec0: endpoint {
                    remote-endpoint = <&typec_port0>;
                };
            };
        };

        anx_mux1 {
            compatible = "typec-switch";
            reg = <1>;

            port {
                anx_typec1: endpoint {
                    remote-endpoint = <&typec_port1>;
                };
            };
        };
```

This eliminates the additional "switches" node in the devicetree. The
sub-nodes also describe our hardware design, which split the DP lanes
of anx7625 to two type-c ports.

[1]: The `node_not_dev` property searches for a node with a compatible
string: https://elixir.bootlin.com/linux/latest/source/drivers/of/property.c#L1390



>
> Ok. I'll take a look on v6.
