Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A3E47E3AB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 13:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348384AbhLWMoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 07:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbhLWMog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:44:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE247C061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 04:44:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E62961E56
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 12:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6250C36AE9;
        Thu, 23 Dec 2021 12:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640263475;
        bh=wf2Q5Z8Tn40GLZE7d2G7aovZuItbu1aPQM8ANQTfrr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rzeFX8nLeFG53dNA0OMoD+SQ9bKo0YRW7sYdQlJMJLkVM1vWu9k9phtL64NPjSoqG
         LCwmSV2pWGxL8Go1ODKLPqrtVDc5tDGf96cJmDr0+1ObszHjhSXOGRrRexAE/Hb/x/
         upnXURepmNI5+450Mg95sjYuvrXG9eedwCY8YkqI8CzjiC2FMAcvzzzVh28rldLrZV
         jKViuDWkFWkxcAwThLhi11jFhkgrq4yKvd8iV7blCVZuqqo3KH/XcuDmmNFqn7mFjc
         Y6F3/tsIuc7D4GfRrp7QDrxx64c1USgb0EEV3+UOvgzO1u8BS1ANrdFhykBt1WPpfj
         bV7UoqoNqAL0g==
Date:   Thu, 23 Dec 2021 18:14:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Li Chen <lchen@ambarella.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [EXT] Re: [PATCH] Revert "phy: cadence-torrent: Do not configure
 SERDES if it's already configured"
Message-ID: <YcRvL85x9Q1dkvRn@matsya>
References: <CH2PR19MB4024BE31FB249744412071F6A0639@CH2PR19MB4024.namprd19.prod.outlook.com>
 <YcQIp3IJ0eki3hY2@matsya>
 <CH2PR19MB4024714657D84812E6F16A77A07E9@CH2PR19MB4024.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR19MB4024714657D84812E6F16A77A07E9@CH2PR19MB4024.namprd19.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-12-21, 06:27, Li Chen wrote:
> Hi, Vinod
> 
> > -----Original Message-----
> > From: Vinod Koul [mailto:vkoul@kernel.org]
> > Sent: Thursday, December 23, 2021 1:27 PM
> > To: Li Chen
> > Cc: Kishon Vijay Abraham I; Philipp Zabel; Swapnil Jakhade; linux-
> > phy@lists.infradead.org; linux-kernel@vger.kernel.org; Dan Carpenter
> > Subject: [EXT] Re: [PATCH] Revert "phy: cadence-torrent: Do not configure
> > SERDES if it's already configured"
> > 
> > On 26-11-21, 05:06, Li Chen wrote:
> > > This reverts commit
> > > b69d39f68419("phy: cadence-torrent: Do not configure SERDES if it's already
> > configured")
> > 
> > space between commit id and open brace...
> > 
> > >
> > > our soc will hang on any regmap field read before reset.
> > 
> > okay, in this case the right fix would be to keep track of reset in SW
> > and still skip reset if it is already configured?
> > 
> 
> I should be grateful if you would give me more details of reset in SW.

Store the reset state in a driver variable reset and use that for
finding already_configured rather than reading a hw value

> 
> > >
> > > Signed-off-by: Li Chen <lchen@ambarella.com>
> > > ---
> > >  drivers/phy/cadence/phy-cadence-torrent.c | 31 +++++++----------------
> > >  1 file changed, 9 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/drivers/phy/cadence/phy-cadence-torrent.c
> > b/drivers/phy/cadence/phy-cadence-torrent.c
> > > index 415ace64adc5c..e57e0b1523aff 100644
> > > --- a/drivers/phy/cadence/phy-cadence-torrent.c
> > > +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> > > @@ -2031,11 +2031,6 @@ static int cdns_torrent_noop_phy_on(struct phy
> > *phy)
> > >  	return 0;
> > >  }
> > >
> > > -static const struct phy_ops noop_ops = {
> > > -	.power_on	= cdns_torrent_noop_phy_on,
> > > -	.owner		= THIS_MODULE,
> > > -};
> > > -
> > >  static
> > >  int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
> > >  {
> > > @@ -2282,7 +2277,6 @@ static int cdns_torrent_phy_probe(struct
> > platform_device *pdev)
> > >  	struct device_node *child;
> > >  	int ret, subnodes, node = 0, i;
> > >  	u32 total_num_lanes = 0;
> > > -	int already_configured;
> > >  	u8 init_dp_regmap = 0;
> > >  	u32 phy_type;
> > >
> > > @@ -2321,20 +2315,16 @@ static int cdns_torrent_phy_probe(struct
> > platform_device *pdev)
> > >  	if (ret)
> > >  		return ret;
> > >
> > > -	regmap_field_read(cdns_phy->phy_pma_cmn_ctrl_1,
> > &already_configured);
> > > -
> > > -	if (!already_configured) {
> > > -		ret = cdns_torrent_reset(cdns_phy);
> > > -		if (ret)
> > > -			goto clk_cleanup;
> > > +	ret = cdns_torrent_reset(cdns_phy);
> > > +	if (ret)
> > > +		goto clk_cleanup;
> > >
> > > -		ret = cdns_torrent_clk(cdns_phy);
> > > -		if (ret)
> > > -			goto clk_cleanup;
> > > +	ret = cdns_torrent_clk(cdns_phy);
> > > +	if (ret)
> > > +		goto clk_cleanup;
> > >
> > >  		/* Enable APB */
> > > -		reset_control_deassert(cdns_phy->apb_rst);
> > > -	}
> > > +	reset_control_deassert(cdns_phy->apb_rst);
> > >
> > >  	for_each_available_child_of_node(dev->of_node, child) {
> > >  		struct phy *gphy;
> > > @@ -2404,10 +2394,7 @@ static int cdns_torrent_phy_probe(struct
> > platform_device *pdev)
> > >  		of_property_read_u32(child, "cdns,ssc-mode",
> > >  				     &cdns_phy->phys[node].ssc_mode);
> > >
> > > -		if (!already_configured)
> > > -			gphy = devm_phy_create(dev, child,
> > &cdns_torrent_phy_ops);
> > > -		else
> > > -			gphy = devm_phy_create(dev, child, &noop_ops);
> > > +		gphy = devm_phy_create(dev, child, &cdns_torrent_phy_ops);
> > >  		if (IS_ERR(gphy)) {
> > >  			ret = PTR_ERR(gphy);
> > >  			goto put_child;
> > > @@ -2490,7 +2477,7 @@ static int cdns_torrent_phy_probe(struct
> > platform_device *pdev)
> > >  		goto put_lnk_rst;
> > >  	}
> > >
> > > -	if (cdns_phy->nsubnodes > 1 && !already_configured) {
> > > +	if (cdns_phy->nsubnodes > 1) {
> > >  		ret = cdns_torrent_phy_configure_multilink(cdns_phy);
> > >  		if (ret)
> > >  			goto put_lnk_rst;
> > > --
> > > 2.33.1
> > >
> > >
> > >
> > **************************************************************
> > ********
> > > This email and attachments contain Ambarella Proprietary and/or Confidential
> > Information and is intended solely for the use of the individual(s) to whom it is
> > addressed. Any unauthorized review, use, disclosure, distribute, copy, or print is
> > prohibited. If you are not an intended recipient, please contact the sender by
> > reply email and destroy all copies of the original message. Thank you.

You do realize this is not OK in public emails... Pls fix

> > 
> > Aha!!!
> > 
> > Okay destroyed this now!
> > 
> > --
> > ~Vinod
> > 
> > ##############################################################
> > ########
> > This EXTERNAL email has been scanned by Proofpoint Email Protect service.
> 
> Regards,
> Li

-- 
~Vinod
