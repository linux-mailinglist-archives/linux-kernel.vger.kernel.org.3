Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66721479901
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 06:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhLRFkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 00:40:40 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41020 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbhLRFkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 00:40:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 994F7609E9;
        Sat, 18 Dec 2021 05:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3A8C36AE1;
        Sat, 18 Dec 2021 05:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639806038;
        bh=8PwU8JnJ3B8cePkcOaBKJEl1j91VuSYiaMCafx/h3oM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BB/UOpuc1LzBv475V/Vwv9HX/lRpnLtK6hR/Q6gbDwf8Qm92+NgV/51uoR10QUz/I
         R2fV3AxIgMJg1edPOYlbXtypOWx/GeeZQ7OfyR0TkL4vmeEycvyED7myg1bbDx/XJu
         Ig3Uo9ft+z/J39XXiPdmc1oJyRF8iQAHn91xippJDaWehKU2qqRCenDJXBTf7c2Bmf
         qnF8sxTSzgAUH1039f5Cc6YjOh8otM7lfrL4o1Zk64nuffbMZOkV1ubpKmifXwvICM
         Gr1WU1Rr05AUXhYjZthzGL7EhsqUAWts05K7iS840wWsnG0eul0p3DCRyZh/Gqsymz
         ijD4SRjm68+5Q==
Date:   Sat, 18 Dec 2021 13:40:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 0/9] arm64: imx8mn: Enable more imx8m Nano functions
Message-ID: <20211218054030.GA25610@dragon>
References: <20211215004626.2241839-1-aford173@gmail.com>
 <20211217031305.GP4216@dragon>
 <CAHCN7xLqE_JWNt0L0KD-MMK-3pSKpCRrQtA+azPntM80vEfrNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7xLqE_JWNt0L0KD-MMK-3pSKpCRrQtA+azPntM80vEfrNg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 10:58:40AM -0600, Adam Ford wrote:
> On Thu, Dec 16, 2021 at 9:13 PM Shawn Guo <shawnguo@kernel.org> wrote:
> >
> > On Tue, Dec 14, 2021 at 06:46:17PM -0600, Adam Ford wrote:
> > > The i.MX8M Nano is similar to the i.MX8M Mini in some ways, but very
> > > different in others.  With the blk-ctrl driver for Mini in place,
> > > this series expands the blk-ctrl driver to support the Nano which
> > > opens the door for additional functions in the future.  As part of
> > > this series, it also addresses some issues in the GPCv2 driver and
> > > finally adds support for enabling USB and GPU.
> > >
> > > V5:  Clean up the GPU clock assignments.
> > > V4:  Rebase on top of [1] which fixes hangs caused from CSI and DSI reset
> > >      and add the same fixes for CSI and DSI to the Nano
> > > V3:  Fixes an the yaml example
> > > V2:  Fixes the clock count in the blk-ctrl
> > >
> > > [1] - https://www.spinics.net/lists/arm-kernel/msg936266.html
> > >
> > > Adam Ford (9):
> > >   soc: imx: gpcv2: keep i.MX8MN gpumix bus clock enabled
> > >   soc: imx: gpcv2: Add dispmix and mipi domains to imx8mn
> > >   dt-bindings: power: imx8mn: add defines for DISP blk-ctrl domains
> > >   dt-bindings: soc: add binding for i.MX8MN DISP blk-ctrl
> > >   soc: imx: imx8m-blk-ctrl: add i.MX8MN DISP blk-ctrl
> > >   arm64: dts: imx8mn: add GPC node
> > >   arm64: dts: imx8mn: put USB controller into power-domains
> > >   arm64: dts: imx8mn: add DISP blk-ctrl
> > >   arm64: dts: imx8mn: Enable GPU
> >
> > The series introduces hard dependency between different branches.  To
> > ease the merge process, let's postpone the DTS patches to the next
> > cycle.
> 
> That's fine.
> Do I need to resubmit later, or will you take care of it when the next
> merge window opens?

I will take care of it.

Shawn
