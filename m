Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EDC49416D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357250AbiASUEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:04:39 -0500
Received: from smtp1.de.opalstack.com ([46.165.236.26]:50990 "EHLO
        smtp1.de.opalstack.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiASUEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:04:31 -0500
Received: from jason.localnet (host-37-191-188-128.lynet.no [37.191.188.128])
        by smtp1.de.opalstack.com (Postfix) with ESMTPSA id 315A1597BF;
        Wed, 19 Jan 2022 20:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=boddie.org.uk;
        s=dkim; t=1642622668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=po9hq9rmhf2YbTEj2O10FmEatAdhCMfHcJA0LgFOME4=;
        b=ZKQVjxa+3edL+tX+24evaOXUuzyb1vQVd1rSbZh7q2vZTz9GfkW/k9w+a/SFXQ0UvOg8sF
        OnH9xYrbzWReaJjVwX5HzqGC/nj8U0VnMtVR3PafaVpPEmJ5uuoku1NVAxDiYOFSsN8Mzr
        nxqy4rzH1A1xzUs+YQhm4VDa9MFGF28=
From:   Paul Boddie <paul@boddie.org.uk>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-mips <linux-mips@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Robert Foss <robert.foss@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans Verku il <hverkuil-cisco@xs4all.nl>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH v5 2/7] drm/ingenic: Add support for JZ4780 and HDMI output
Date:   Wed, 19 Jan 2022 21:04:22 +0100
Message-ID: <4681844.iUxLBkU96p@jason>
In-Reply-To: <D0989ACA-F6DB-4E16-8D95-5ACBAD90AACD@goldelico.com>
References: <cover.1633436959.git.hns@goldelico.com> <13356060.GkHXLIg068@jason> <D0989ACA-F6DB-4E16-8D95-5ACBAD90AACD@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=0.85
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 19 January 2022 07:40:22 CET H. Nikolaus Schaller wrote:
> Hi Paul,
> 
> > Am 18.01.2022 um 23:59 schrieb Paul Boddie <paul@boddie.org.uk>:
> > 
> > On Tuesday, 18 January 2022 17:58:58 CET Paul Cercueil wrote:
> >>
> >> Why is this JZ_LCD_OSDC_ALPHAEN bit needed now? I remember it working
> >> fine last time I tried, and now I indeed get a black screen unless this
> >> bit is set. The PM doesn't make it obvious that the bit is required,
> >> but that wouldn't be surprising.
> > 
> > It isn't actually needed. If the DMA descriptors are set up appropriately,
> > the OSD alpha bit seems to be set as a consequence. In my non-Linux
> > testing environment I don't even set any OSD registers explicitly, but
> > the OSD alpha and enable flags become set when the display is active.
> 
> Is it set by DMA descriptors or by explicit code?

The descriptors will cause it to be set when the peripheral is enabled, as far 
as I can tell.

> We did have an explicit setting of JZ_LCD_OSDC_ALPHAEN
> 
> https://www.spinics.net/lists/devicetree/msg438447.html
> 
> but that was postponed for further discussion. And now if we
> add it (from basic functionality) back, it is fine again.

It may be set in various versions of the Linux driver, but my observation was 
that in a non-Linux environment where nothing else is setting anything in the 
register concerned, initialising the descriptors seems to enable OSD and the 
OSD alpha enable bit.

Yesterday, I did consider what might be done to avoid the alpha bit being set, 
but I didn't immediately see anything in the descriptor fields that would 
offer such an alternative. The bit in question seems to be a global alpha 
enable setting, and so choosing per-pixel alpha would probably also result in 
it being set, although I didn't fire up the CI20 to check.

Paul


