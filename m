Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746BC55A2DA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 22:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiFXUiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 16:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiFXUiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 16:38:01 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F26F1F610
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 13:37:58 -0700 (PDT)
Received: from p57b77c73.dip0.t-ipconnect.de ([87.183.124.115] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1o4q3s-0003j9-0C; Fri, 24 Jun 2022 22:37:52 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sandy Huang <hjc@rock-chips.com>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH] drm/rockchip: vop: Don't crash for invalid duplicate_state()
Date:   Fri, 24 Jun 2022 22:37:50 +0200
Message-ID: <4134988.X513TT2pbd@phil>
In-Reply-To: <CA+ASDXOzhoooDDJUWV7rKpz-7GkMR5v=3gKQt4XazTSgnY51WQ@mail.gmail.com>
References: <20220617172623.1.I62db228170b1559ada60b8d3e1637e1688424926@changeid> <4196825.8hzESeGDPO@phil> <CA+ASDXOzhoooDDJUWV7rKpz-7GkMR5v=3gKQt4XazTSgnY51WQ@mail.gmail.com>
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

Am Freitag, 24. Juni 2022, 19:57:53 CEST schrieb Brian Norris:
> On Fri, Jun 24, 2022 at 12:23 AM Heiko Stuebner <heiko@sntech.de> wrote:
> > The interesting question would be, do we want some fixes tag for it?
> 
> I'm not aware of any currently-upstream code that will hit this [1].
> I've hit it in out-of-tree code (or, code that I submitted to
> dri-devel, but wasn't accepted as-is), and this is the "belt and
> braces" part -- the primary fix is that we should avoid calling things
> like drm_atomic_get_crtc_state() at inappropriate times.
> 
> So, is the "extra safety" check really something that should go to
> -stable? (Because let's be honest, everything with a Fixes tag goes
> there.) Maybe?
> 
> Anyway, if you want to "blame" anything, this commit actually dropped
> the safety check:
> 
> 4e257d9eee23 drm/rockchip: get rid of rockchip_drm_crtc_mode_config

I tend to think, if we know that connection we should also include it :-) .
I wouldn't include a cc-stable for the reason you mentioned, but to me
it makes sense if someone reading the git history in the future can easily
know that information - so it doesn't hurt :-) .

So I'll add that when applying.

Thanks for supplying the origin commit
Heiko

> 
> Brian
> 
> [1] But I'm not omniscient. So maybe it's good to have anyway.
> 




