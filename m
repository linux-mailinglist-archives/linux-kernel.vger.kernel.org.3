Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C500B481737
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 23:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhL2WTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 17:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhL2WTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 17:19:37 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99DFC061574;
        Wed, 29 Dec 2021 14:19:36 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2DA0433F;
        Wed, 29 Dec 2021 23:19:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1640816374;
        bh=NmBuSa0Tm1XDHSFWplYPZ+GeRMcg0ZC1lIjZHsY3g84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EaozM4GcjGJY8sUUXytB4f01VixzjPgwX8wzHBFuZrsIbY382Y+h7S59oBwZ2ywXI
         Zc3hGQ7m/bL50H0HrQaefS+/d8zClr35IM6Q7ofrR2XTf8AXWPGIt3X7HjU0PW889C
         l4Tl+NywrkwKt5PjiDkG7vNktYMsqmu1guxjlGAM=
Date:   Thu, 30 Dec 2021 00:19:31 +0200
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
Message-ID: <Ycze8wzD3Qi8YVAa@pendragon.ideasonboard.com>
References: <20211224052309.1997096-1-nikita.yoush@cogentembedded.com>
 <20211224052309.1997096-3-nikita.yoush@cogentembedded.com>
 <YcyTV4fJqMHIeyYB@pendragon.ideasonboard.com>
 <87626d61-ada0-c220-bea5-5330f5256629@cogentembedded.com>
 <YcyXQxW3kRqQ2Yv0@pendragon.ideasonboard.com>
 <39f70781-831e-c86a-ec5f-68f2b4bd3d62@cogentembedded.com>
 <Ycy4AMAT53Uzf+K7@pendragon.ideasonboard.com>
 <bb6ef732-7cd2-5ba9-0eef-caf2fbfbf829@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bb6ef732-7cd2-5ba9-0eef-caf2fbfbf829@cogentembedded.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikito,

On Thu, Dec 30, 2021 at 12:12:04AM +0300, Nikita Yushchenko wrote:
>   Endpoints are meant to model a link between two ports, so an endpoint
> > shouldn't exist in isolation. The issue with creating named endpoints in
> > SoC files is that you can't tell there what remote devices may exist, so
> > the endpoint may or may not match the actual hardware design of a board.
> > I think it's better to create endpoints on both sides together in
> > overlays.
> > 
> > https://lore.kernel.org/linux-renesas-soc/20211229193135.28767-2-laurent.pinchart+renesas@ideasonboard.com/T/#t
> 
> What I don't like here is: details of particular SoC (such as "panel gets video from port@1 of &lvds1) 
> leak into per-panel DT fragment.
> 
> This limits possibilities to share DT fragments between different use cases. In the patch pointed by the 
> above URL, you have to reference both board and panel in the dts file name.
>
> I'd prefer to make each DT fragment to use only either entities defined in that fragment itself, or 
> defined "interface entities" between this and "neighbor" DT fragment.
> 
> Such as:
> - SoC's DT fragment defines a named port/endpoint to export video stream at
> - board's DT fragment defines a named panel node corresponding to panel plugged into board's physical 
> connector, and connects endpoints with SoC's video export,
> - panel's DT fragment extends the panel node from board with video mode information for this particular 
> panel.
> 
> And similar for backlight, power, and whatever else exposed on the physical panel connector.
> 
> So for the board's physical connector there is a set of board-DT-provided entities for use by DT 
> fragment of whatever component plugged to the connector, without direct references to final SoC 
> interfaces. And possibility to reuse DT fragments between boards, and probably have a library of DT 
> fragments for hardware currently available in the market, usable with different boards where that 
> hardware can be connected.

I agree it's annoying, but we'll have a similar problem, just the other
way around, with an endpoint defined in the SoC dtsi. Many R-Car SoCs
have two LVDS encoders, and you can attach a panel to either of them.
Some boards use LVDS0, some boards use LVDS1, and some boards could even
use both.

A real solution for this problem will require a new concept. The "DT
connector" proposal is related to this problem space. There's also a
proprietary implementation in the Rapsberry Pi boot loader of a
mechanism to support parametrized overlays ([2] and [3], or [4] for an
example of how a panel reset or backlight GPIO can be parametrized).

[1] https://lwn.net/Articles/689783/
[2] https://www.raspberrypi.com/documentation/computers/configuration.html#part3
[3] https://github.com/raspberrypi/firmware/blob/master/boot/overlays/README#L122
[4] https://github.com/raspberrypi/firmware/blob/master/boot/overlays/README#L312

-- 
Regards,

Laurent Pinchart
