Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF94F46BD62
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237677AbhLGOUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbhLGOUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:20:23 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B1EC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 06:16:53 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mubGp-0001MK-F4; Tue, 07 Dec 2021 15:16:39 +0100
Message-ID: <3723dba86bc8c4ac4147d766787c926af486103f.camel@pengutronix.de>
Subject: Re: [RFC V2 5/6] media: hantro: split i.MX8MQ G1 and G2 code
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-media <linux-media@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:HANTRO VPU CODEC DRIVER" 
        <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>
Date:   Tue, 07 Dec 2021 15:16:37 +0100
In-Reply-To: <CAHCN7xKtD+ROTM5_bCr0EgC+vyoAAgEW11SkCvpPQ5wHO3bWBA@mail.gmail.com>
References: <20211207015446.1250854-1-aford173@gmail.com>
         <20211207015446.1250854-6-aford173@gmail.com> <Ya9V7Kwa8MICeS34@eze-laptop>
         <CAHCN7xJ9kTdTmhbSwwNCCivRdTULO494CEj0eVkfPfqbPqNPvA@mail.gmail.com>
         <d82868b7dbc2953c6022165488e822699f7240c5.camel@pengutronix.de>
         <CAHCN7xL3JgmEf=H9UueFLYpnGqraRYUu3yYSTqn_JNi8tPnOfQ@mail.gmail.com>
         <6e41beec102951ea057ba1af02ef4aaad40bd0dc.camel@pengutronix.de>
         <CAHCN7xKtD+ROTM5_bCr0EgC+vyoAAgEW11SkCvpPQ5wHO3bWBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, dem 07.12.2021 um 08:07 -0600 schrieb Adam Ford:
> > > > > > 
[...]
> > > > > > I think it's important to clarify that you are breaking support
> > > > > > for the previous device-tree binding. Not only because of the compatible
> > > > > > string change, but because the binding is now quite different.
> > > > > > 
> > > > > > Note that in the past Benjamin tried to avoid this.
> > > > > > IIRC, his proposal was backwards compatible.
> > > > > 
> > > > > I was looking at how to do this, but the stand-alone vpu bindings did
> > > > > the reset and the fuses manually, it causes issues.  When the block
> > > > > control is enabled those memory locations for the resets and fuses are
> > > > > assigned to the blk-ctrl driver, so attempting to access them from a
> > > > > different driver was a violation.
> > > > > 
> > > > > When I started looking at this, the stand-alone VPU was trying to be
> > > > > both G1 and G2, but when I was testing it before I made changes, I
> > > > > didn't see the G2 function at all. When I was done the G2 seemed to
> > > > > work, so it seems like this is an improvement.  If you want me to keep
> > > > > the previous compatible flag, I could rename the nxp,imx8mq-vpu-g1
> > > > > back to nxp,imx8mq-vpu and remove the reset/fuse controls, but I'd
> > > > > have to add the blk-ctrl reference, so it seemed to me like a better
> > > > > alternative to deprecate the old binding/driver and replace it with
> > > > > the new one because of the significant changes.  Since I'd like to
> > > > > rebase the i.MX8M Mini I did on this work, it seemed weird to have
> > > > > nxp,imx8mq-vpu, nxp,imx8mq-vpu-g2, nxp,imx8mm-vpu-g1, and
> > > > > nxp,imx8mm-vpu-g2 where the only one without a Gx name was the
> > > > > original 8MQ binding but limited to G1 functionality and the G2
> > > > > stripped out.
> > > > 
> > > > I would very much appreciate if we could keep the driver code for the
> > > > old binding. It does not need to have any new additional functionality,
> > > > but just keep the existing G1 h.264 decode when booted on a old DT with
> > > > the old VPU description and no blk-ctrl, so we don't regress
> > > > functionality when a new kernel is booted with a old DT.
> > > > 
> > > > New functionality with the G2 can depend on the new VPU binding and the
> > > > blk-ctrl driver.
> > > 
> > > How does that work when both the original VPU and the blk-ctrl attempt
> > > to manipulate the reset and clock lines?  The original binding for the
> > > vpu was assigned:
> > > 
> > > reg = <0x38300000 0x10000>,
> > >           <0x38310000 0x10000>,
> > >           <0x38320000 0x10000>;
> > > reg-names = "g1", "g2", "ctrl";
> > > 
> > > If G2 is going to run from 38310000 and vpu-blk-ctrl run from
> > > 38320000, they'll collide.
> > > 
> > It's not going to work, but it also doesn't have to. Either you have a
> > old DT where the VPU driver will poke the blk-ctrl registers, but no
> > blk-ctrl driver, or you have a new DT where the VPU driver leaves the
> > blk-ctrl region alone and the blk-ctrl driver needs to handle it.
> > 
> > Just don't support mixing the old VPU DT binding with the new blk-ctrl
> > way of doing things. The only thing that needs to keep working is a
> > unchannged old DT, where the VPU uses the old binding, but no blk-ctrl
> > is present as a separate node.
> 
> I think I understand.  I'll leave the old code for the old binding in
> the driver and add the new code for the new bindings with blk-ctrl.
> Once the device tree is migrated to the new bindings, the old one
> becomes harmless, but still works with old device trees lacking the
> blk-ctrl.  That makes sense.  In my head, I wasn't thinking about
> mixing older device trees.

Exactly. While most people don't use it this way, the kernel and DT are
supposed to be independent, e.g. the DTB could be included in the
device firmware, while the kernel could be updated via a distro.

To not break this use-case without a good reason, new kernels should
try to not regress functionality with a existing binary DT. We can
mandate DT updates for new functionality (like being able to use the G2
core only with the new blk-ctrl + split VPU binding), but we shouldn't
break existing features if there isn't a very good reason to do so.
Keeping the bit of code in the VPU driver to keep the old G1 only
decoding working with a new kernel isn't much of a burden IMHO, so we
should try to keep it alive.

Regards,
Lucas

