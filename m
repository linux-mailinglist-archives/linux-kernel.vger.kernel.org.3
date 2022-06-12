Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220DF547C6C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 23:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235892AbiFLVVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 17:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiFLVVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 17:21:47 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6521146F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 14:21:46 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 72911825;
        Sun, 12 Jun 2022 23:21:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1655068904;
        bh=ltDVV/FNzrC9IY/lw+6fQdMuSHJmmwoYyLRASzOYSs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rbpmSsi5y28tyLJ+Zls/lTdm/TvvlymFVLz1bQBc32std4ExoNtt0IyBYkzXMP9b9
         80s8rV2wtK/SSa6HdPY0iRXdRWIFUSSmwdEF1qahIOsHL5xqdoJEsL3mlldCY0rpp7
         M2PESCRnq01p5sSc74azeG/XRk+aqYZ7p6Qk6Rto=
Date:   Mon, 13 Jun 2022 00:21:37 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Venkateshwar Rao Gannavarapu 
        <venkateshwar.rao.gannavarapu@xilinx.com>, airlied@linux.ie,
        vgannava@xilinx.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [LINUX PATCH 2/2] drm: xlnx: dsi: driver for Xilinx DSI Tx
 subsystem
Message-ID: <YqZY4QMAkGiFOOWE@pendragon.ideasonboard.com>
References: <1652363593-45799-1-git-send-email-venkateshwar.rao.gannavarapu@xilinx.com>
 <1652363593-45799-3-git-send-email-venkateshwar.rao.gannavarapu@xilinx.com>
 <Yn47YsSH4fn/wjKN@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yn47YsSH4fn/wjKN@ravnborg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On Fri, May 13, 2022 at 01:05:06PM +0200, Sam Ravnborg wrote:
> On Thu, May 12, 2022 at 07:23:13PM +0530, Venkateshwar Rao Gannavarapu wrote:
> > The Xilinx MIPI DSI Tx Subsystem soft IP is used to display video
> > data from AXI-4 stream interface.
> > 
> > It supports upto 4 lanes, optional register interface for the DPHY
> > and multiple RGB color formats.
> > This is a MIPI-DSI host driver and provides DSI bus for panels.
> > This driver also helps to communicate with its panel using panel
> > framework.
> 
> Thanks for submitting this driver. I have added a few comments in the
> following that I hope you will find useful to improve the driver.
> 
> > Signed-off-by: Venkateshwar Rao Gannavarapu <venkateshwar.rao.gannavarapu@xilinx.com>
> > ---
> >  drivers/gpu/drm/xlnx/Kconfig    |  14 ++
> >  drivers/gpu/drm/xlnx/Makefile   |   1 +
> >  drivers/gpu/drm/xlnx/xlnx_dsi.c | 456 ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 471 insertions(+)
> >  create mode 100644 drivers/gpu/drm/xlnx/xlnx_dsi.c

[snip]

> > diff --git a/drivers/gpu/drm/xlnx/xlnx_dsi.c b/drivers/gpu/drm/xlnx/xlnx_dsi.c
> > new file mode 100644
> > index 0000000..a5291f3
> > --- /dev/null
> > +++ b/drivers/gpu/drm/xlnx/xlnx_dsi.c

[snip]

> > +static inline void xlnx_dsi_writel(void __iomem *base, int offset, u32 val)
> > +{
> > +	writel(val, base + offset);
> > +}
> > +
> > +static inline u32 xlnx_dsi_readl(void __iomem *base, int offset)
> > +{
> > +	return readl(base + offset);
> > +}
> 
> When I see implementations like this I wonder if a regmap would be
> beneficial?

regmap often seems overkill to me when the driver only needs plain
32-bit mmio read/write, given the overhead it adds at runtime. Is it
just me ?

[snip]

-- 
Regards,

Laurent Pinchart
