Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A8F4BF869
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiBVM4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbiBVM4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:56:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A01F128DF7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 04:56:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16BF2B81998
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2026AC340E8;
        Tue, 22 Feb 2022 12:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645534567;
        bh=oJ/w9DrjJ8UVUe7wYc1OQHhSMTw8H6h+UWV8CFaeNPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mxayw4Pqw5XPRdaAsVWmuRsbbbCslKZoiBb8FJ2oApvIJFv2jL35xShhlroFOEs2X
         JlyvhbEnkYlsVX1DVTiGtFmjmCtmTJQ0FN1S2fKvb09j99a+mieAjG3KL/gQvyhotn
         UbUbnPE3id7GMKPRIZ2pkuQ08QRucvGUXiSjl1GkmigHeQWN3WewzT+QirTa7Sejdg
         QT+NdZnzL650m9fIShnU8GmzP2rh0op5qBZEePzwT2BM1Bc5/+cBsVxLPT+4r5Oxu4
         HJtrX21OVDYaNvGZxHj9rwx9A+7MWi0FQENZ0eS+xELs9GA+8BVMtHPaqHYRMzoKVY
         uRe3dZbIto9uQ==
Date:   Tue, 22 Feb 2022 18:26:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     kishon@ti.com, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, mparab@cadence.com,
        a-govindraju@ti.com, r-ravikumar@ti.com
Subject: Re: [PATCH 1/4] phy: cadence-torrent: Add function to get PLL to be
 configured for DP
Message-ID: <YhTdY+UfIEtvDBK+@matsya>
References: <20220127142958.23465-1-sjakhade@cadence.com>
 <20220127142958.23465-2-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127142958.23465-2-sjakhade@cadence.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-01-22, 15:29, Swapnil Jakhade wrote:
> Torrent PHY PLL0 or PLL1 is used for DP depending on the single link or
> multilink protocol configuration for which PHY is configured. In multilink
> configurations with other protocols, either PLL0 or PLL1 will be used
> for DP. For single link DP, both PLLs need to be configured at POR.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---
>  drivers/phy/cadence/phy-cadence-torrent.c | 30 +++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
> index 7c4b8050485f..0e2839a6c65d 100644
> --- a/drivers/phy/cadence/phy-cadence-torrent.c
> +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> @@ -38,6 +38,9 @@
>  #define POLL_TIMEOUT_US		5000
>  #define PLL_LOCK_TIMEOUT	100000
>  
> +#define DP_PLL0			BIT(0)
> +#define DP_PLL1			BIT(1)
> +
>  #define TORRENT_COMMON_CDB_OFFSET	0x0
>  
>  #define TORRENT_TX_LANE_CDB_OFFSET(ln, block_offset, reg_offset)	\
> @@ -323,6 +326,7 @@ struct cdns_torrent_phy {
>  	void __iomem *base;	/* DPTX registers base */
>  	void __iomem *sd_base; /* SD0801 registers base */
>  	u32 max_bit_rate; /* Maximum link bit rate to use (in Mbps) */
> +	u32 dp_pll;
>  	struct reset_control *phy_rst;
>  	struct reset_control *apb_rst;
>  	struct device *dev;
> @@ -978,6 +982,30 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_100mhz(struct cdns_torrent_phy *cdns_phy,
>  	}
>  }
>  
> +/* Set PLL used for DP configuration */
> +static int cdns_torrent_dp_get_pll(struct cdns_torrent_phy *cdns_phy,
> +				   enum cdns_torrent_phy_type phy_t2)

why return an error if you are going to ignore it!

> +{
> +	switch (phy_t2) {
> +	case TYPE_PCIE:
> +	case TYPE_USB:
> +		cdns_phy->dp_pll = DP_PLL1;
> +		break;
> +	case TYPE_SGMII:
> +	case TYPE_QSGMII:
> +		cdns_phy->dp_pll = DP_PLL0;
> +		break;
> +	case TYPE_NONE:
> +		cdns_phy->dp_pll = DP_PLL0 | DP_PLL1;
> +		break;
> +	default:
> +		dev_err(cdns_phy->dev, "Unsupported PHY configuration\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * Enable or disable PLL for selected lanes.
>   */
> @@ -1640,6 +1668,8 @@ static int cdns_torrent_dp_init(struct phy *phy)
>  		return -EINVAL;
>  	}
>  
> +	cdns_torrent_dp_get_pll(cdns_phy, TYPE_NONE);
> +
>  	cdns_torrent_dp_common_init(cdns_phy, inst);
>  
>  	return cdns_torrent_dp_start(cdns_phy, inst, phy);
> -- 
> 2.34.1

-- 
~Vinod
