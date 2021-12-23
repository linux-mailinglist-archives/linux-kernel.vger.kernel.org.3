Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5FB47DEBB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 06:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346378AbhLWF1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 00:27:10 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55274 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhLWF1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 00:27:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA66761DBE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 05:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3948C36AE9;
        Thu, 23 Dec 2021 05:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640237227;
        bh=Sh6jpk/Rbr2ag37WBYje8V7bPWoR/w5w/sUmeauAzJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jZow9MqGsJXa294P3rt+I2VYegmI+cNC1fSO2AgctovFOIj03x8vA6pLIcK61aR80
         wzbO+i2Q3HCCcH+uQZeyiyayqsh0TQq8eZUiYImk5jBGny/fjHodzdhv71Ll/GlnjV
         kgpVSfRlLA6bIbOMR4Ff98w8PZpDmlFrTgBs/e0O3wsdn9eeYtUZ8OAUxBq5TpaLkm
         MmEqkxpquCyVc9Ayz0v091tuZSGPfFGQ2qkmXW3R40xOqZoco4fsj1pi9AcpKcQthn
         ncldgfA0UaZ/FNC9/YWEVNg2e/TTswLMW1fDmKytvr6y79ISK6cZmgqCOsWSsM55WK
         lAluvfnkXpYLQ==
Date:   Thu, 23 Dec 2021 10:57:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Li Chen <lchen@ambarella.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] Revert "phy: cadence-torrent: Do not configure SERDES if
 it's already configured"
Message-ID: <YcQIp3IJ0eki3hY2@matsya>
References: <CH2PR19MB4024BE31FB249744412071F6A0639@CH2PR19MB4024.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR19MB4024BE31FB249744412071F6A0639@CH2PR19MB4024.namprd19.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-11-21, 05:06, Li Chen wrote:
> This reverts commit
> b69d39f68419("phy: cadence-torrent: Do not configure SERDES if it's already configured")

space between commit id and open brace...

> 
> our soc will hang on any regmap field read before reset.

okay, in this case the right fix would be to keep track of reset in SW
and still skip reset if it is already configured?

> 
> Signed-off-by: Li Chen <lchen@ambarella.com>
> ---
>  drivers/phy/cadence/phy-cadence-torrent.c | 31 +++++++----------------
>  1 file changed, 9 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
> index 415ace64adc5c..e57e0b1523aff 100644
> --- a/drivers/phy/cadence/phy-cadence-torrent.c
> +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> @@ -2031,11 +2031,6 @@ static int cdns_torrent_noop_phy_on(struct phy *phy)
>  	return 0;
>  }
>  
> -static const struct phy_ops noop_ops = {
> -	.power_on	= cdns_torrent_noop_phy_on,
> -	.owner		= THIS_MODULE,
> -};
> -
>  static
>  int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
>  {
> @@ -2282,7 +2277,6 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
>  	struct device_node *child;
>  	int ret, subnodes, node = 0, i;
>  	u32 total_num_lanes = 0;
> -	int already_configured;
>  	u8 init_dp_regmap = 0;
>  	u32 phy_type;
>  
> @@ -2321,20 +2315,16 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	regmap_field_read(cdns_phy->phy_pma_cmn_ctrl_1, &already_configured);
> -
> -	if (!already_configured) {
> -		ret = cdns_torrent_reset(cdns_phy);
> -		if (ret)
> -			goto clk_cleanup;
> +	ret = cdns_torrent_reset(cdns_phy);
> +	if (ret)
> +		goto clk_cleanup;
>  
> -		ret = cdns_torrent_clk(cdns_phy);
> -		if (ret)
> -			goto clk_cleanup;
> +	ret = cdns_torrent_clk(cdns_phy);
> +	if (ret)
> +		goto clk_cleanup;
>  
>  		/* Enable APB */
> -		reset_control_deassert(cdns_phy->apb_rst);
> -	}
> +	reset_control_deassert(cdns_phy->apb_rst);
>  
>  	for_each_available_child_of_node(dev->of_node, child) {
>  		struct phy *gphy;
> @@ -2404,10 +2394,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
>  		of_property_read_u32(child, "cdns,ssc-mode",
>  				     &cdns_phy->phys[node].ssc_mode);
>  
> -		if (!already_configured)
> -			gphy = devm_phy_create(dev, child, &cdns_torrent_phy_ops);
> -		else
> -			gphy = devm_phy_create(dev, child, &noop_ops);
> +		gphy = devm_phy_create(dev, child, &cdns_torrent_phy_ops);
>  		if (IS_ERR(gphy)) {
>  			ret = PTR_ERR(gphy);
>  			goto put_child;
> @@ -2490,7 +2477,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
>  		goto put_lnk_rst;
>  	}
>  
> -	if (cdns_phy->nsubnodes > 1 && !already_configured) {
> +	if (cdns_phy->nsubnodes > 1) {
>  		ret = cdns_torrent_phy_configure_multilink(cdns_phy);
>  		if (ret)
>  			goto put_lnk_rst;
> -- 
> 2.33.1
>  
> 
> **********************************************************************
> This email and attachments contain Ambarella Proprietary and/or Confidential Information and is intended solely for the use of the individual(s) to whom it is addressed. Any unauthorized review, use, disclosure, distribute, copy, or print is prohibited. If you are not an intended recipient, please contact the sender by reply email and destroy all copies of the original message. Thank you.

Aha!!!

Okay destroyed this now!

-- 
~Vinod
