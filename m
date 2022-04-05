Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2671B4F2384
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 08:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiDEGr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 02:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiDEGrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 02:47:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56991193C2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 23:45:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F222EB8180F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE323C340F3;
        Tue,  5 Apr 2022 06:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649141105;
        bh=jaRGetbQ2s3ZlsHzZOV4e30zP3uvS93CzT4nFqJ6LTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QXqVyolFovvtyoe4QyT8L5O/aljf5lAjYTjxj/H7N8rh4052dO8y31QGb86WyJ3uA
         mhWc+8kpGg2N5ohm7Ka5l5wNVFHi+e6aiiKBpSm1BQwVJt3kFd0qC1H37QxxrwecIX
         T9cEETcRA2MmSDmwdSZsCPN2xdRkNvThQKiEabdU6MkSU+blvsn5OEm/PZ1CDOAhmJ
         JcK1Yi3PWkKIXaNdtdpPQle0BbNCjWOWNFRI3uE8NpIK9iX0hRU/kevj0DxAZ0O5su
         l4SaiT3rLtTY7+2V+z5/fCPGjjqAMPRsdmNmiaX2MA6fw+w+4tZgT1M7cjm4i/MHWI
         vRE4A/bERervg==
Date:   Tue, 5 Apr 2022 14:44:58 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: imx: gpcv2: keep i.MX8MM VPU-H1 bus clock active
Message-ID: <20220405064458.GA129381@dragon>
References: <20211120193916.1309236-1-aford173@gmail.com>
 <319e976acb0a686e596b88520dbcda59c78afe9e.camel@pengutronix.de>
 <CAHCN7x+5HXJEdRKbm80trpNwxZRAMhX12+FQ0JeVvrqKpKf+BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7x+5HXJEdRKbm80trpNwxZRAMhX12+FQ0JeVvrqKpKf+BA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 06:32:13AM -0500, Adam Ford wrote:
> On Thu, Mar 31, 2022 at 4:28 AM Lucas Stach <l.stach@pengutronix.de> wrote:
> >
> > Hi Adam, hi Shawn,
> >
> > Am Samstag, dem 20.11.2021 um 13:39 -0600 schrieb Adam Ford:
> > > Enable the vpu-h1 clock when the domain is active because reading
> > > or writing to the VPU-H1 IP block cause the system to hang.
> > >
> > > Fixes: 656ade7aa42a ("soc: imx: gpcv2: keep i.MX8M* bus clocks enabled")
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > >
> > > diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> > > index b8d52d8d29db..7b6dfa33dcb9 100644
> > > --- a/drivers/soc/imx/gpcv2.c
> > > +++ b/drivers/soc/imx/gpcv2.c
> > > @@ -734,6 +734,7 @@ static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
> > >                       .map = IMX8MM_VPUH1_A53_DOMAIN,
> > >               },
> > >               .pgc   = BIT(IMX8MM_PGC_VPUH1),
> > > +             .keep_clocks = true,
> > >       },
> > >
> > I missed this patch and just stumbled across it when looking at the git
> > history. I don't think this patch is correct. The H1 GPC domain does
> > not even have clocks assigned in the DT, so there is nothing to keep
> > active. Also H1 is not a MIX domain, so it should not keep any bus
> > clocks active, that is the job of the VPUMIX domain.
> >
> > While this patch is a no-op, as far as I can see, it still seems wrong
> > and I think it should be reverted.
> 
> At the time I sent this, I was working with some people in the media
> group to split the G1 and G2 up in the imx8mq and add G1 and G2
> support in the imx8mm.  I had inquired about the feasibility of using
> the H1 encoder on the imx8mm, but I needed to read some registers from
> the IP block to see which features were fused out.  I tried several
> different options to get the H1 to not hang when reading registers,
> and that was the only solution I found that worked.  I thought it odd
> as well since the G1 and G2 decoders didn't appear to need this.
> However, during the course of my investigation, I learned that the
> JPEG encoder was fused out of the imx8mm, and there wasn't a plan to
> add VP8 or H.264 encodering any time soon.   Since it is, as you put
> it, a no-op, I have no objections to reverting it.

I do not quite follow.  You claimed that the change fixes a system hang.
Are we getting the hang back if we revert the change?

Shawn
