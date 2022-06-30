Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9081C56272B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 01:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbiF3Xil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 19:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiF3Xik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 19:38:40 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB97340CE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 16:38:35 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id l11so1096580ybu.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 16:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=btsdDzLHXuWyocFwUf8WNzReTu4AL/b5BRU/bdo9QNM=;
        b=QOsAKew+rQrtATgi/aVrHtrYo0c9mo88CuuEuMw27xXWshXhNOAidEZC/YjJi3Ijye
         +2muzrOzD1F4SqvFLSn3pe55M9pPTjfIQML3+Th30czA6dXsDHlK5h02z55Nycg4hTUw
         0lQh/dXd6gqtU7ucvGY2iqqBBCrGm1uVOrfqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=btsdDzLHXuWyocFwUf8WNzReTu4AL/b5BRU/bdo9QNM=;
        b=cVtBYZXZ4wXuBJ6+ZDOxxlTgwjk2blHQLd8+6+Yg1axO6kHzUwbmbFLHM4d/+fI5vN
         6VIn2raYaHvGbqM0Mf3zmyJL/68ocbVAAdY8lsw5GZMW3FZQV3Jlc8q61ggUTbp8H2mG
         f6Chd7xB4iD7/XOz1lyIzI/yJLWFHtKC1O872VNKFjtdb0Bkhgaubl20jI+40Xmhn3kp
         yFlEz+0KStwQmlGnT19IWD6ltoear0pWn8g3Of3wCMYEzOogVKEEd+E1Ju9lBCK6PVsC
         zrjCyvPsYW3wrXpUyCg078MD5iYMuHqwjaBSbS6Mm7vqWIyhli0cotQy8Ebzq0cjRY88
         NArw==
X-Gm-Message-State: AJIora9jiKGiPRzkkuE9KvDx+bRdHdZT/c307mm029A65/8UQYnwxiNs
        y206d/M2LG7OaOgVIWDvvGY1zKdNU1ePtCKnIOHXkg==
X-Google-Smtp-Source: AGRyM1uxVdFc9o6L6ctk+dneyKFL7RlsqngXci+gacBBkyMNQ/h1aAr1e/Yp6tzP84ZsRnw16tUSA7B3BTpSiAnOakQ=
X-Received: by 2002:a25:df15:0:b0:66c:8c2d:7897 with SMTP id
 w21-20020a25df15000000b0066c8c2d7897mr12028962ybg.445.1656632314516; Thu, 30
 Jun 2022 16:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220622173605.1168416-1-pmalani@chromium.org>
 <20220622173605.1168416-6-pmalani@chromium.org> <CAE-0n517BB8YbN5AZG6M3ZrZGOJDV=+t0R9d8wD+gVqO1aD1Xg@mail.gmail.com>
 <CACeCKafR8hFke_tc2=1VGDNF-CFrZoAG1aUKuxGJG-6pd37hbg@mail.gmail.com>
 <CAE-0n50XbO5Wu4-429Ao05A4QrbSXoi1wBjTpGFjKm3pZj1Ybg@mail.gmail.com>
 <CACeCKafzB0wW_B2TOEWywLMyB+UhYCpXYDVBV=UbyxBiGnv1Rw@mail.gmail.com> <CAE-0n50Akd8QikGhaAQgxLkJBhE-7KQf5aJ_P2ajOmCjLk555g@mail.gmail.com>
In-Reply-To: <CAE-0n50Akd8QikGhaAQgxLkJBhE-7KQf5aJ_P2ajOmCjLk555g@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 30 Jun 2022 16:38:24 -0700
Message-ID: <CACeCKafQT_RBrkHJNE2ezahSsHLPrbnS69QbfnjxBoUhi6hjwQ@mail.gmail.com>
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
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 4:21 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Prashant Malani (2022-06-28 13:56:22)
> > On Tue, Jun 28, 2022 at 1:40 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > I suppose none of those things matter though as long as there is some
> > > typec switch registered here so that the driver can be informed of the
> > > pin assignment. Is it right that the "mode-switch" property is only
> > > required in DT if this device is going to control the mode of the
> > > connector, i.e. USB+DP, or just DP? Where this device can't do that
> > > because it doesn't support only DP.
> >
> > If the anx7625 is used just to route all lanes from 1 usb-c-connector (i.e
> > the USB+DP case), a mode-switch wouldn't be of much use, since one
> > would also route the CC lines to the built-in PD controller; so it will
> > already have knowledge of what mode the switch is in.
> >
> > The mode-switch is likely only relevant for this hardware configuration(
> > it's "DP only" in the sense that the USB pins to the SoC never go anywhere).
> > One only has 2 SS lanes each (from each usb-c-connector).
> >
> > Since there is no CC-line, the anx7625 needs to know which one has DP
> > enabled on it.
>
> Can the CC line be "captured" and not actually sent to the anx7625?

That's what happens on Chrome OS. The cc line goes to the EC (and is "consumed"
by the TCPM (Type C Port Manager)) and signals are then sent to the AP
over the Host command interface to `cros-ec-typec`. The signals here being all
the PD messages communicated between the peripheral and the port.

> I imagine if that is possible, maybe the CC lines would go to some
> micro-controller or something that did more typec management things and
> then the anx7625 driver would need to do software control of the mode
> and orientation control.

I _guess_ that is possible (though it would seem odd to not use all the PD
control hardware in that configuration)? If an system implements it in
such a way
then:
1. mode-switch: Can be updated to do something when num_typec_switches == 1 (
in the mux_set function imp.l I haven't looked into what registers
need to be configured, since we
don't have this hardware implementation.
2. orientation-switch: This should be registered, and then flip the
lanes when the port
driver tells it the orientation is one way or another.

So, if someone uses it that way, I think the driver needs only minor
updates to support it.
