Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFF4559420
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 09:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiFXHXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 03:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFXHXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 03:23:36 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E71B4D61E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 00:23:32 -0700 (PDT)
Received: from p508fdadf.dip0.t-ipconnect.de ([80.143.218.223] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1o4df4-00074z-Ip; Fri, 24 Jun 2022 09:23:26 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Brian Norris <briannorris@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sandy Huang <hjc@rock-chips.com>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH] drm/rockchip: vop: Don't crash for invalid duplicate_state()
Date:   Fri, 24 Jun 2022 09:23:24 +0200
Message-ID: <4196825.8hzESeGDPO@phil>
In-Reply-To: <CAD=FV=Wsp6GA=L4GsEVjMqazgtw4qG40gtLq1HT++5e9eRrvTw@mail.gmail.com>
References: <20220617172623.1.I62db228170b1559ada60b8d3e1637e1688424926@changeid> <CAD=FV=Wsp6GA=L4GsEVjMqazgtw4qG40gtLq1HT++5e9eRrvTw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 24. Juni 2022, 01:44:52 CEST schrieb Doug Anderson:
> Hi,
> 
> On Fri, Jun 17, 2022 at 5:27 PM Brian Norris <briannorris@chromium.org> wrote:
> >
> > It's possible for users to try to duplicate the CRTC state even when the
> > state doesn't exist. drm_atomic_helper_crtc_duplicate_state() (and other
> > users of __drm_atomic_helper_crtc_duplicate_state()) already guard this
> > with a WARN_ON() instead of crashing, so let's do that here too.
> >
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> >
> >  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> I'm not an expert in this area, but it makes sense to me to match
> drm_atomic_helper_crtc_duplicate_state() in this way. Thus:
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> I would tend to assume that this would be landed in drm-misc by Heiko
> if he's good with it. After several weeks of silence, however, I'll
> commit it myself.

I do tend to batch up drm-misc patches, as that is always a different
workflow but I'll pick that up :-)

The interesting question would be, do we want some fixes tag for it?


Heiko


