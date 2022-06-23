Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB91955890E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiFWTfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiFWTeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:34:46 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B11467E5C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 12:15:54 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id d5so714166yba.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 12:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=icBv02YthTFvrtUFWz0nh/9bhPVkmRsemm78ezrfeog=;
        b=O+7rr+XqABJcGtIev7QuTB6drGNOp0FepFlPL9QPhSNPXGIt3f7U4DTmMg9xIEHhKZ
         uTsyrzAeqt3Tu0JjNpXw1NwLXmH8BI895ef+JPO5kn8Lr2RsyoARbK33Ko1ZYta+uF3e
         VkUFUxb84/ecefpxjKQWFURfIRjRbjiFwBW6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=icBv02YthTFvrtUFWz0nh/9bhPVkmRsemm78ezrfeog=;
        b=6gn8ttPqf2BjyB9JrxjwrZsvIC5rd/z7U3G5gc6atdL6h+kJFXRUiQh8okOKEf/sgS
         L4J65LF7ryonlFYa2o9GKsWkTRK02yAaNaP3rnHHms/t3inWCCl5KgRf4EpVMnYCWJ9s
         TGlPBmtBNUUguGxbgw9eQgbO2H4l/AG/edTpVMgstayQu5ZS8oFCK+NahMBM4ugHu/hI
         Im3hCLbVsv5kSbMOD01H2phvVq9lqcZr9MN2oAgmEmFIYZ4WnZhA5pYx6EGlUoR/1KR9
         TUoish/wyprSRYN2SgWv/XpKvD71UpkI4xB3TtuhtudIrmjln2GygLIpLBaQAdH9bwHr
         sAHQ==
X-Gm-Message-State: AJIora+/lIAPvDYKm+P6h/zq6fw7fU4Ow5AUhPahwLxFtw2ufeeB7nn3
        /7a+rorf7DlNchuoDWjRpVbnw9vPgQ0eSDjiaY7yRw==
X-Google-Smtp-Source: AGRyM1vo9eclvYKWlnI8Z1IzhZDtiALcpS4DTk5sKAvdnhcBIHH5/5ayi+8XWmysWgoIxmF1Fz9B2bQ3stMqDTeW3yQ=
X-Received: by 2002:a25:540a:0:b0:669:b4cb:41d7 with SMTP id
 i10-20020a25540a000000b00669b4cb41d7mr3084875ybb.196.1656011753251; Thu, 23
 Jun 2022 12:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220622173605.1168416-1-pmalani@chromium.org>
 <20220622173605.1168416-7-pmalani@chromium.org> <CAE-0n51d4S3T+_f+YXsu3es7AMxuyFORSXFQe2LTSkZB4C56Ng@mail.gmail.com>
 <CACeCKaduttgNfxyzE2_7eD1N4NLNp_8J1EaWTnn+eqp+_P-i1A@mail.gmail.com> <CAE-0n53Y4pe3TvNQVKZsqLU4cA-Vs4zH3HHV5U97W_6qCNsEow@mail.gmail.com>
In-Reply-To: <CAE-0n53Y4pe3TvNQVKZsqLU4cA-Vs4zH3HHV5U97W_6qCNsEow@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 23 Jun 2022 12:15:42 -0700
Message-ID: <CACeCKaem-b5ePtkeR2njS9ZgX3Ez1GViArPxS92fk7eF0=NmFA@mail.gmail.com>
Subject: Re: [PATCH v5 6/9] dt/bindings: drm/bridge: it6505: Add mode-switch support
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bleung@chromium.org, heikki.krogerus@linux.intel.com,
        Pin-Yen Lin <treapking@chromium.org>,
        Allen Chen <allen.chen@ite.com.tw>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
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
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Robert Foss <robert.foss@linaro.org>,
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

On Thu, Jun 23, 2022 at 12:08 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Prashant Malani (2022-06-23 11:37:08)
> > On Thu, Jun 23, 2022 at 11:24 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Prashant Malani (2022-06-22 10:34:35)
> > > > From: Pin-Yen Lin <treapking@chromium.org>
> > > >
> > > > ITE IT6505 can be used in systems to switch USB Type-C DisplayPort
> > > > alternate mode lane traffic between 2 Type-C ports.
> > >
> > > How does it work? From what I can tell from the information I find when
> > > googling this part[1] and looking at the existing binding doc is that
> > > this device is a DPI to DP bridge, and it outputs DP (probably 4 lanes
> > > of it?). Does the 2 type-c port design work by transmitting DP on two
> > > lanes of DP for one type-c port and another two lanes of DP for the
> > > other type-c port?
> > >
> > > DP could be one lane, so if this device is able to output one lane on
> > > any output differential pair then I suspect it could support 4 type-c
> > > ports if the hardware engineer connected it that way. Can you confirm my
> > > suspicion?
> >
> > I will let Pin-Yen comment re: this hardware, but 1-lane DP is not a
> > supported Type-C Pin assignment
> > (as per VESA DP Alternate Mode Spec version 2.0 [2]), so the H/W
>
> Some missing link?

My bad. I tried to find a publicly accessible link to the DP altmode
spec, but it
seems like one needs to be a VESA member to access it :/

>
> > configuration you are suggesting shouldn't be possible.
> >
>
> Alright, cool. But it is possible in the DP spec. So it seems like if
> this is connected to 4 DP connectors it could be used to mux between DP
> on 4 DP ports.

Ack. In that case, no "typec-switches" should be added to the DT.
