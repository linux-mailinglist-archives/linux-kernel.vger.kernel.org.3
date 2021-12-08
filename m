Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF6346D727
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbhLHPnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236175AbhLHPnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:43:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875DAC0617A2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 07:39:32 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1muz2N-0000ft-SH; Wed, 08 Dec 2021 16:39:19 +0100
Message-ID: <7bbcee7d8d52cab00635037c35c81b43ce34ec76.camel@pengutronix.de>
Subject: Re: [RFC V2 0/6] media: Hantro: Split iMX8MQ VPU into G1 and G2
 with blk-ctrl support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     linux-media <linux-media@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
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
Date:   Wed, 08 Dec 2021 16:39:16 +0100
In-Reply-To: <CAHCN7xJJfBXdK6B1tHXjmja4Lr=Q-Uony+QWcvVqoQp36RLY=w@mail.gmail.com>
References: <20211207015446.1250854-1-aford173@gmail.com>
         <f85da774-ccb3-85de-edd6-5333ed8d0503@collabora.com>
         <5a8b84e91bd8e7670a0d0108e4affe9b964202cb.camel@pengutronix.de>
         <4cc3404b-7f8a-6c87-8c1c-ace399f9edd3@collabora.com>
         <CAHCN7xJJfBXdK6B1tHXjmja4Lr=Q-Uony+QWcvVqoQp36RLY=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, dem 08.12.2021 um 09:13 -0600 schrieb Adam Ford:
> On Wed, Dec 8, 2021 at 7:36 AM Benjamin Gaignard
> <benjamin.gaignard@collabora.com> wrote:
> > 
> > 
> > Le 08/12/2021 à 11:32, Lucas Stach a écrit :
> > > Am Mittwoch, dem 08.12.2021 um 10:32 +0100 schrieb Benjamin Gaignard:
> > > > Le 07/12/2021 à 02:54, Adam Ford a écrit :
> > > > 
> > > > > Currently, the VPU in the i.MQ8MQ is appearing as one codec, but in
> > > > > reality, it's two IP blocks called G1 and G2.  There is initialization
> > > > > code in VPU code to pull some clocks, resets and other features which
> > > > > has been integrated into the vpu-blk-ctrl for the i.MX8M Mini and a
> > > > > similar method can be used to make the VPU codec's operate as
> > > > > stand-alone cores without having to know the details of each other
> > > > > or the quirks unique to the i.MX8MQ, so the remaining code can be
> > > > > left more generic.
> > > > > 
> > > > > This series was started by Lucas Stach with one by Benjamin Gaignard.
> > > > > Most patches have been modified slightly by me.  It's in an RFC state
> > > > > because I wasn't sure how to best handle the signatures and wasn't sure
> > > > > if I could base it off the branch I did.
> > > > > 
> > > > > Since the g-streamer and media trees are in a constant state of
> > > > > change, this series is based on
> > > > > 
> > > > > git://linuxtv.org/hverkuil/media_tree.git for-v5.17e
> > > > > 
> > > > > The downstream code from NXP shows the G1 and G2 clocks running
> > > > > at 600MHz, but between the TRM and the datasheet, there is some
> > > > > discrepancy.  Because the NXP reference code used 600MHz, that is
> > > > > what was chosen here.  Users who need to adjust their G1 and G2
> > > > > clocks can do so in their board files.
> > > > Hi Adam,
> > > > 
> > > > Thanks for your patches, I have been able to reproduce VP9 results on my side (Fluster 147/303).
> > > > In past I have notice spurious errors when using 600MHz clock on HEVC decode but not with 300MHz.
> > 
> > The results for Fluster HEVC are 77/147 so no regressions :-)
> > 
> > Regards,
> > Benjamin
> > 
> > > > The max supported G2 clock frequency is 660MHz but needs a higher
> > > > voltage. The maximum supported  frequency at the default 0.9V is
> > > > 550MHz. We should not configure the clocks for the higher than that, as
> > > > long as there is no support in the VPU driver to scale the voltage
> > > > along with the frequency. Same as with the GPU we should stick to base
> > > > frequency levels for the nominal operating mode.
> 
> Lucas,
> 
> After reviewing the comments from Benjamin, I re-ran the VP9 tests
> with the G2 running at 300MHz,and the number of passing VP9 tests
> increased to 148 from 144 with an increase of time to 250.502 secs
> from 162.665 secs.
> 
> While the datasheet reads that the G2 can run faster, the i.MX 8M
> Dual/8M QuadLite/8M Quad Applications Processors Reference Manual,
> Rev. 3.1, 06/2021, table 5-1  shows the VPU_G2_CLK_ROOT has a max
> clock of 300MHz.  I might be inclined to agree with Benjamin on the
> 300MHz and let people who want to push their hardware overwrite the
> default clocks since it increases functionality.
> 
I'm quite surprised that the G2 codec should have such a much lower max
frequency compared with the G1. While the table from the RM hasn't been
obviously incorrect for any other clock, I'm still inclined to believe
the frequencies stated in the datasheet.

> I wonder if someone from NXP can comment
> 
Yea, not sure how to proceed here. 300MHz is the safe bet, but we are
leaving quite some performance on the table if the datasheet is
correct. Without some help from NXP it's probably hard to validate 
which max frequency statement is correct. It doesn't really help that
the NXP downstream kernel seems to drive the G2 at 600MHz, which is
neither the 550MHz nominal mode max, nor the 660MHz overdrive mode max.

Regards,
Lucas

