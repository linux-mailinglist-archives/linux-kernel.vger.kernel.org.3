Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B869D48165A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 20:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhL2TdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 14:33:25 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:35582 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhL2TdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 14:33:24 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7EE1333F;
        Wed, 29 Dec 2021 20:33:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1640806402;
        bh=AvVOW/VzJLPZoRVlXYRH6EcfoDj+T0NUJNrTU0jp7sQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AB6EY0hnFY1MxcmBjTMUlxlb/eFVF/zYrGYEwCtz9unMqJENiVU7+YsIb/eKuLCdy
         2AB/HL2iN8blqpYcCPsEYVUyUfoX/mODjSyyARd1shiusctaI0UsuAgIlYnRNPurcW
         jTMa5HpDIKFxPRbpuuu9SrwzbuXOHGhP5U52rvjU=
Date:   Wed, 29 Dec 2021 21:33:20 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: renesas: r8a77961: Add lvds0 device node
Message-ID: <Ycy4AMAT53Uzf+K7@pendragon.ideasonboard.com>
References: <20211224052309.1997096-1-nikita.yoush@cogentembedded.com>
 <20211224052309.1997096-3-nikita.yoush@cogentembedded.com>
 <YcyTV4fJqMHIeyYB@pendragon.ideasonboard.com>
 <87626d61-ada0-c220-bea5-5330f5256629@cogentembedded.com>
 <YcyXQxW3kRqQ2Yv0@pendragon.ideasonboard.com>
 <39f70781-831e-c86a-ec5f-68f2b4bd3d62@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39f70781-831e-c86a-ec5f-68f2b4bd3d62@cogentembedded.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

On Wed, Dec 29, 2021 at 08:19:10PM +0300, Nikita Yushchenko wrote:
> >> If this approach is not appropriate, then perhaps need to fix it in
> >> files for all SoCs, to make it possible for extension board dtsi to be
> >> compatible with all of them.
> > 
> > I'm writing a patch to drop those right now :-) I'll CC you.

And of course I hit the send button too fast, sorry :-S

https://lore.kernel.org/linux-renesas-soc/20211229191838.27922-1-laurent.pinchart+renesas@ideasonboard.com/T/#t

> Ok.
> 
> But, are you sure that empty nodes like these are that bad?
> 
> I was going to suggest a movement in opposite direction - adding more such nodes, so they could form a 
> sort of API for dts plugins describing e.g. displays connectable to boards based on different SoCs.

Endpoints are meant to model a link between two ports, so an endpoint
shouldn't exist in isolation. The issue with creating named endpoints in
SoC files is that you can't tell there what remote devices may exist, so
the endpoint may or may not match the actual hardware design of a board.
I think it's better to create endpoints on both sides together in
overlays.

https://lore.kernel.org/linux-renesas-soc/20211229193135.28767-2-laurent.pinchart+renesas@ideasonboard.com/T/#t

-- 
Regards,

Laurent Pinchart
