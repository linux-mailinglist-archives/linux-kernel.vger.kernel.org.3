Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE5949DE14
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238643AbiA0Jdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238644AbiA0JdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:33:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC594C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 01:33:24 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nD19U-0006rQ-9d; Thu, 27 Jan 2022 10:33:12 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nD19P-0007xU-Bi; Thu, 27 Jan 2022 10:33:07 +0100
Date:   Thu, 27 Jan 2022 10:33:07 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Peter Geis <pgwipeout@gmail.com>
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
        linux-rockchip@lists.infradead.org,
        Heiko =?iso-8859-15?Q?St=FCbner?= <heiko@sntech.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: synopsys/dw-hdmi: set cec clock rate
Message-ID: <20220127093307.GJ23490@pengutronix.de>
References: <20220126202427.3047814-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126202427.3047814-1-pgwipeout@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:29:35 up 47 days, 18:15, 84 users,  load average: 0.21, 0.33,
 0.29
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, Jan 26, 2022 at 03:24:26PM -0500, Peter Geis wrote:
> The hdmi-cec clock must be 32khz in order for cec to work correctly.
> Ensure after enabling the clock we set it in order for the hardware to
> work as expected.
> Warn on failure, in case this is a static clock that is slighty off.
> Fixes hdmi-cec support on Rockchip devices.

You removed this sentence in v2, but I just wanted to mention that
clk_set_rate() won't fail when the desired clock rate can't be
archieved. Instead, you will get the best rate that actually can be
reached. If you want to check that you are happy with the rate you'll
have to do a clk_round_rate() before setting the rate or a
clk_get_rate() afterwards.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
