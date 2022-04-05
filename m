Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D374F50C7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1843214AbiDFBkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356223AbiDEKXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:23:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2284AE15
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 03:07:52 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nbg62-00035f-JM; Tue, 05 Apr 2022 12:07:34 +0200
Message-ID: <48c9a0feb6e7b06c448308114245e165cf329661.camel@pengutronix.de>
Subject: Re: [PATCH] soc: imx: gpcv2: keep i.MX8MM VPU-H1 bus clock active
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 05 Apr 2022 12:07:32 +0200
In-Reply-To: <CAHCN7xKShNswT2JDZFZ9vSQ9_Kk1T+Ow3+=9as8sZ7mDQ6E1Vg@mail.gmail.com>
References: <20211120193916.1309236-1-aford173@gmail.com>
         <319e976acb0a686e596b88520dbcda59c78afe9e.camel@pengutronix.de>
         <CAHCN7x+5HXJEdRKbm80trpNwxZRAMhX12+FQ0JeVvrqKpKf+BA@mail.gmail.com>
         <20220405064458.GA129381@dragon>
         <CAHCN7xKShNswT2JDZFZ9vSQ9_Kk1T+Ow3+=9as8sZ7mDQ6E1Vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, dem 05.04.2022 um 04:55 -0500 schrieb Adam Ford:
> On Tue, Apr 5, 2022 at 1:45 AM Shawn Guo <shawnguo@kernel.org> wrote:
> > 
> > On Thu, Mar 31, 2022 at 06:32:13AM -0500, Adam Ford wrote:
> > > On Thu, Mar 31, 2022 at 4:28 AM Lucas Stach <l.stach@pengutronix.de> wrote:
> > > > 
> > > > Hi Adam, hi Shawn,
> > > > 
> > > > Am Samstag, dem 20.11.2021 um 13:39 -0600 schrieb Adam Ford:
> > > > > Enable the vpu-h1 clock when the domain is active because reading
> > > > > or writing to the VPU-H1 IP block cause the system to hang.
> > > > > 
> > > > > Fixes: 656ade7aa42a ("soc: imx: gpcv2: keep i.MX8M* bus clocks enabled")
> > > > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > > > 
> > > > > diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> > > > > index b8d52d8d29db..7b6dfa33dcb9 100644
> > > > > --- a/drivers/soc/imx/gpcv2.c
> > > > > +++ b/drivers/soc/imx/gpcv2.c
> > > > > @@ -734,6 +734,7 @@ static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
> > > > >                       .map = IMX8MM_VPUH1_A53_DOMAIN,
> > > > >               },
> > > > >               .pgc   = BIT(IMX8MM_PGC_VPUH1),
> > > > > +             .keep_clocks = true,
> > > > >       },
> > > > > 
> > > > I missed this patch and just stumbled across it when looking at the git
> > > > history. I don't think this patch is correct. The H1 GPC domain does
> > > > not even have clocks assigned in the DT, so there is nothing to keep
> > > > active. Also H1 is not a MIX domain, so it should not keep any bus
> > > > clocks active, that is the job of the VPUMIX domain.
> > > > 
> > > > While this patch is a no-op, as far as I can see, it still seems wrong
> > > > and I think it should be reverted.
> > > 
> > > At the time I sent this, I was working with some people in the media
> > > group to split the G1 and G2 up in the imx8mq and add G1 and G2
> > > support in the imx8mm.  I had inquired about the feasibility of using
> > > the H1 encoder on the imx8mm, but I needed to read some registers from
> > > the IP block to see which features were fused out.  I tried several
> > > different options to get the H1 to not hang when reading registers,
> > > and that was the only solution I found that worked.  I thought it odd
> > > as well since the G1 and G2 decoders didn't appear to need this.
> > > However, during the course of my investigation, I learned that the
> > > JPEG encoder was fused out of the imx8mm, and there wasn't a plan to
> > > add VP8 or H.264 encodering any time soon.   Since it is, as you put
> > > it, a no-op, I have no objections to reverting it.
> > 
> > I do not quite follow.  You claimed that the change fixes a system hang.
> > Are we getting the hang back if we revert the change?
> 
> It was hanging when I has trying to use the H1 VPU, and this did fix
> it, but it seemed weird to me.  Unfortunately, Hantro H1 driver that
> is currently in Linux only supports JPEG, and the H1 VPU in the imx8mm
> has JPEG fused out.  As of right now, there is no H1 VPU consumer, so
> there is nobody attempting to enable the H1 power domain, so it
> remains a no-op.  If it's reverted, we'll have to revisit the issue in
> the future to prevent the hanging, but that will also require a new
> Hantro driver.

The H1 clock is not a bus clock, so there is nothing else that depends
on this clock than the H1 encoder peripheral, which is why it should be
handled by the future driver and not the power domain.

Regards,
Lucas

