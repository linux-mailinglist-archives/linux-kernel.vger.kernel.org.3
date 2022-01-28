Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212144A0096
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 20:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350759AbiA1TDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 14:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiA1TDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 14:03:15 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEE7C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 11:03:14 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id c6so21326720ybk.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 11:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3hlBZRfJeaaEMgpDJfGF4VXTiNMRL5u5A8XWDhcHgIU=;
        b=RB+iJtZRYF0dkmWtZQjZrE5l2GCNTyyleglmYgfhw2DfTccUOrvGv9t6I6Yk7N3fd1
         i90XCiFg/0xlIqHxlY0zFOXcxPwjk7qLfB9xsvV/FxdncdXC32oYUY+M/uVFIzbbRkHS
         sGAHLY2u0DS9/gwV0Bw8Llaky5XDQPsalA9CkpoF7O7nCYaGNpqK/b3tj5Zq48+wjJoe
         QMaTbI9e0mRXYA0VjJ2MYyLeZM271Ly4gVi94O4Z7JeGjWaG7KtuFAcrocfly191vqsq
         BP+/8tBvp4hnN0JJUQazPDSUO82daB1GopBf7zqzTLm5faaI3mAwSJt3f4JT1K0I7IBP
         yiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3hlBZRfJeaaEMgpDJfGF4VXTiNMRL5u5A8XWDhcHgIU=;
        b=f2WEkQqv2BmWr6/SG3EviHDclUnkZewqHlu8qAYpJY+aqfCvQ3Y0aWceqWBmnzIeW+
         9EdspyYngqqBwVmEZjBpsENBplNxAcRQrUDjNppePYRNc8BG00t4D862n1wT4oWa8kN6
         P6oIlTxXojrnHT7VqO6EoNxWxhxAkaKPHTXumO5xaBMSR4Fp21kyrDJUvzMwsWIS5D+c
         dTmwsqgD5h5sQkh9x1c+OVFAeHi3dAXZC6Ipa+Cdez9T4Bdqs5g8K5PtpQ8rqeD+8JTr
         sG2vONz8TgREpN0QIjHyglljCNY/ZepJV3c+qGmO1uHG22WtRRGTInFl+ijRj6oy/jeC
         tKdg==
X-Gm-Message-State: AOAM531TAXpfA4rWxWHGjyTbUJggXh6VkjRiJEmAYA4VW6lwJ22NVXqT
        fnevsbs8bHGurCW6ku24VsRQkEzNs3z1d0SvGqVPpYr+XWA=
X-Google-Smtp-Source: ABdhPJzzfPPKuV+kEV5XP50RjBgFVl8NGNQtLCUEqsEPQE6Z940iaylmOzR016fVVotXJrtEZoq5NTeoaKbhpkUa57Y=
X-Received: by 2002:a05:6902:704:: with SMTP id k4mr14250783ybt.355.1643396593140;
 Fri, 28 Jan 2022 11:03:13 -0800 (PST)
MIME-Version: 1.0
References: <20220126202427.3047814-1-pgwipeout@gmail.com> <20220127093307.GJ23490@pengutronix.de>
In-Reply-To: <20220127093307.GJ23490@pengutronix.de>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 28 Jan 2022 14:03:02 -0500
Message-ID: <CAMdYzYomk6_PLgkWSY9owd98vPtFGiHPmAwwnrx8vchf05uYLw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: synopsys/dw-hdmi: set cec clock rate
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Pierre-Hugues Husson <phh@phh.me>,
        Archit Taneja <architt@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 4:33 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> Hi Peter,
>
> On Wed, Jan 26, 2022 at 03:24:26PM -0500, Peter Geis wrote:
> > The hdmi-cec clock must be 32khz in order for cec to work correctly.
> > Ensure after enabling the clock we set it in order for the hardware to
> > work as expected.
> > Warn on failure, in case this is a static clock that is slighty off.
> > Fixes hdmi-cec support on Rockchip devices.
>
> You removed this sentence in v2, but I just wanted to mention that
> clk_set_rate() won't fail when the desired clock rate can't be
> archieved. Instead, you will get the best rate that actually can be
> reached. If you want to check that you are happy with the rate you'll
> have to do a clk_round_rate() before setting the rate or a
> clk_get_rate() afterwards.

Thanks, the behavior in v2 is actually what I'm looking for.
I dug into clk_set_rate while checking into its interaction with
clk_prepare and I came to this conclusion.



>
> Sascha
>
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
