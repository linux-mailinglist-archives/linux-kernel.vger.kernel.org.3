Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF79E5691B1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbiGFS0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiGFS0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:26:33 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5332CCCE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:26:30 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-31c89111f23so98388747b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 11:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AKNzyuxVbT+auUhZLi3IyFDil3epaFKjcWDvpCGicX8=;
        b=Uxpv0YELVEct5DKRBFz2Fhk7QOvnqJthA8Ckw5wBsDZGh8wJXJiOrindJG/RdyVU2K
         5kOY4qIummQC7LrVENX11WZTxRSqjS7URB43qjRq8OGIZqeDgCN81GIPSiMWTmCOOup2
         QQdGRwejIFzn0MvwrWJWBomzFz7wDHAU+ejoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AKNzyuxVbT+auUhZLi3IyFDil3epaFKjcWDvpCGicX8=;
        b=R727dVksDPJfuz8WxpkrjNDNfAJGTZ2pQ+QY3SAZipp6TCNh4/LFut8HmXyrIoR+sI
         LV7Dzx44SdB3Xe+2PXpwEj7EqPiWlb776vk66pDzPHJEDvvu5OMHzJeA/zCdKGLyfT+B
         ReAnZxqhJiEtui0WQWRKJ5XPd9c7kh46hSaiWa3Mqo3NeXcrD4LDQGR3yGBI9yxRObLK
         p0iU/K1n+XgsU2jzjykD4ooEexz/uFTriHurmCEGxHQPRFkSouhXyjDIjt3VgYZsowB5
         omWqwziKXnk8eZMCJqfuOtCObqRP16i5lGvegk5LjHhGKy64cN0iVHap4AZOcB8P2aCJ
         rX2w==
X-Gm-Message-State: AJIora9QOyX7jYXz7NrdH/4sHPH/SYhx//hO0dvE3GIbDjwmw1GDtQyJ
        q3iCV917toa5TM3ICzqlWzZNd1cWZbVN2iQJJAG8KA==
X-Google-Smtp-Source: AGRyM1udr5yyAZaFO4FJIEc1fs4jCrlvFfgCL6OO6ePlgo7ORdpuX2cwPgLlDUrByF02oMjAX082RxZNAQZV1iQkw1A=
X-Received: by 2002:a0d:c787:0:b0:31b:a963:e1de with SMTP id
 j129-20020a0dc787000000b0031ba963e1demr47186325ywd.283.1657131989488; Wed, 06
 Jul 2022 11:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220622173605.1168416-1-pmalani@chromium.org>
 <20220622173605.1168416-6-pmalani@chromium.org> <CAE-0n517BB8YbN5AZG6M3ZrZGOJDV=+t0R9d8wD+gVqO1aD1Xg@mail.gmail.com>
 <CACeCKafR8hFke_tc2=1VGDNF-CFrZoAG1aUKuxGJG-6pd37hbg@mail.gmail.com>
 <CAE-0n50XbO5Wu4-429Ao05A4QrbSXoi1wBjTpGFjKm3pZj1Ybg@mail.gmail.com>
 <CACeCKafzB0wW_B2TOEWywLMyB+UhYCpXYDVBV=UbyxBiGnv1Rw@mail.gmail.com>
 <CAE-0n50Akd8QikGhaAQgxLkJBhE-7KQf5aJ_P2ajOmCjLk555g@mail.gmail.com> <CACeCKafQT_RBrkHJNE2ezahSsHLPrbnS69QbfnjxBoUhi6hjwQ@mail.gmail.com>
In-Reply-To: <CACeCKafQT_RBrkHJNE2ezahSsHLPrbnS69QbfnjxBoUhi6hjwQ@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Wed, 6 Jul 2022 11:26:19 -0700
Message-ID: <CACeCKafya_XA+C3eJUvT4vjQSgsjdewVkCb+Jr2tA1605jjfjg@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] drm/bridge: anx7625: Add typec_mux_set callback function
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bleung@chromium.org, heikki.krogerus@linux.intel.com,
        Pin-Yen Lin <treapking@chromium.org>,
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
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 4:38 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> On Thu, Jun 30, 2022 at 4:21 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Prashant Malani (2022-06-28 13:56:22)
> > > On Tue, Jun 28, 2022 at 1:40 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > >
> > > > I suppose none of those things matter though as long as there is some
> > > > typec switch registered here so that the driver can be informed of the
> > > > pin assignment. Is it right that the "mode-switch" property is only
> > > > required in DT if this device is going to control the mode of the
> > > > connector, i.e. USB+DP, or just DP? Where this device can't do that
> > > > because it doesn't support only DP.
> > >
> > > If the anx7625 is used just to route all lanes from 1 usb-c-connector (i.e
> > > the USB+DP case), a mode-switch wouldn't be of much use, since one
> > > would also route the CC lines to the built-in PD controller; so it will
> > > already have knowledge of what mode the switch is in.
> > >
> > > The mode-switch is likely only relevant for this hardware configuration(
> > > it's "DP only" in the sense that the USB pins to the SoC never go anywhere).
> > > One only has 2 SS lanes each (from each usb-c-connector).
> > >
> > > Since there is no CC-line, the anx7625 needs to know which one has DP
> > > enabled on it.
> >
> > Can the CC line be "captured" and not actually sent to the anx7625?
>
> That's what happens on Chrome OS. The cc line goes to the EC (and is "consumed"
> by the TCPM (Type C Port Manager)) and signals are then sent to the AP
> over the Host command interface to `cros-ec-typec`. The signals here being all
> the PD messages communicated between the peripheral and the port.
>
> > I imagine if that is possible, maybe the CC lines would go to some
> > micro-controller or something that did more typec management things and
> > then the anx7625 driver would need to do software control of the mode
> > and orientation control.
>
> I _guess_ that is possible (though it would seem odd to not use all the PD
> control hardware in that configuration)? If an system implements it in
> such a way
> then:
> 1. mode-switch: Can be updated to do something when num_typec_switches == 1 (
> in the mux_set function imp.l I haven't looked into what registers
> need to be configured, since we
> don't have this hardware implementation.
> 2. orientation-switch: This should be registered, and then flip the
> lanes when the port
> driver tells it the orientation is one way or another.
>
> So, if someone uses it that way, I think the driver needs only minor
> updates to support it.

Stephen, any pending concerns?
If not,I will post a v6 series with the suggested changes:
- Drop typec-switch binding; instead add a new top-level port with
end-points for each Type-C connector's switch.
- Drop it6505 patches.
- Squash anx7625 driver patches into one patch.
- Add a comment mentioning that we aren't registering the orientation-switch.
