Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10825A0A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236544AbiHYHlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238407AbiHYHlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:41:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA809DB49;
        Thu, 25 Aug 2022 00:41:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 417C5B81B80;
        Thu, 25 Aug 2022 07:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C68DC433D6;
        Thu, 25 Aug 2022 07:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661413273;
        bh=EwLtF7Ll569WJXe3QBAw8qXcrqcWWwzmCYQVUys5f3g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=i9S9a14wLF2qoPD/dIYJPxZQm7g2DqB/1vkxonc6Rd01ZBezywZG8CuD2QbcVU6al
         hfT5Y9e2dOu4d7eiuXoR4YlpL5D6ojTCeTQjGBqF206ENQ8+2iS/sk74GAFqub7sz/
         GGihpewv2YDpsDPxJgGddO48v7okxn2UgPG0hB5L6GndJw4E81OM9irLpGN00plWyH
         ye4qO94ouEDEcfnEVQmStI2fjRe0KxwCM1HoFtacerZ4LfT+65Vklzvr3YTeaNhcAy
         mx/QrARj9F8rZ2QFV+a+tncyo6rQSThipu/bq9MuRQwS698VMFHFtHuvtKR5qA7WPo
         8p+OAHe+HrzjA==
Message-ID: <655c39a3-cf5f-6dd7-3c1a-61ebeae915bd@kernel.org>
Date:   Thu, 25 Aug 2022 10:41:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/2] phy: ti: gmii-sel: Add support for CPSW5G GMII SEL
 in J7200
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, robh+dt@kernel.org,
        lee.jones@linaro.org, krzysztof.kozlowski@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, kishon@ti.com, vkoul@kernel.org,
        dan.carpenter@oracle.com, grygorii.strashko@ti.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20220822065631.27933-1-s-vadapalli@ti.com>
 <20220822065631.27933-3-s-vadapalli@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20220822065631.27933-3-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Siddharth,

On 22/08/2022 09:56, Siddharth Vadapalli wrote:
> Each of the CPSW5G ports in J7200 support additional modes like QSGMII.
> Add a new compatible for J7200 to support the additional modes.
> 
> In TI's J7200, each of the CPSW5G ethernet interfaces can act as a
> QSGMII or QSGMII-SUB port. The QSGMII interface is responsible for
> performing auto-negotiation between the MAC and the PHY while the rest of
> the interfaces are designated as QSGMII-SUB interfaces, indicating that
> they will not be taking part in the auto-negotiation process.
> 
> To indicate the interface which will serve as the main QSGMII interface,
> add a property "ti,qsgmii-main-ports", whose value indicates the
> port number of the interface which shall serve as the main QSGMII
> interface. The rest of the interfaces are then assigned QSGMII-SUB mode by
> default.

Can you please describe here why you are using "ti,qsgmii-main-ports" instead
of "ti,qsgmii-main-port" as there can be only one main port per PHY instance?

> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  drivers/phy/ti/phy-gmii-sel.c | 40 ++++++++++++++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
> index d0ab69750c6b..270083606b14 100644
> --- a/drivers/phy/ti/phy-gmii-sel.c
> +++ b/drivers/phy/ti/phy-gmii-sel.c
> @@ -22,6 +22,12 @@
>  #define AM33XX_GMII_SEL_MODE_RMII	1
>  #define AM33XX_GMII_SEL_MODE_RGMII	2
>  
> +/* J72xx SoC specific definitions for the CONTROL port */
> +#define J72XX_GMII_SEL_MODE_QSGMII	4
> +#define J72XX_GMII_SEL_MODE_QSGMII_SUB	6
> +
> +#define PHY_GMII_PORT(n)	BIT((n) - 1)
> +
>  enum {
>  	PHY_GMII_SEL_PORT_MODE = 0,
>  	PHY_GMII_SEL_RGMII_ID_MODE,
> @@ -43,6 +49,7 @@ struct phy_gmii_sel_soc_data {
>  	u32 features;
>  	const struct reg_field (*regfields)[PHY_GMII_SEL_LAST];
>  	bool use_of_data;
> +	u64 extra_modes;
>  };
>  
>  struct phy_gmii_sel_priv {
> @@ -53,6 +60,7 @@ struct phy_gmii_sel_priv {
>  	struct phy_gmii_sel_phy_priv *if_phys;
>  	u32 num_ports;
>  	u32 reg_offset;
> +	u32 qsgmii_main_ports;
>  };
>  
>  static int phy_gmii_sel_mode(struct phy *phy, enum phy_mode mode, int submode)
> @@ -88,10 +96,17 @@ static int phy_gmii_sel_mode(struct phy *phy, enum phy_mode mode, int submode)
>  		gmii_sel_mode = AM33XX_GMII_SEL_MODE_MII;
>  		break;
>  
> +	case PHY_INTERFACE_MODE_QSGMII:
> +		if (!(soc_data->extra_modes & BIT(PHY_INTERFACE_MODE_QSGMII)))
> +			goto unsupported;
> +		if (if_phy->priv->qsgmii_main_ports & BIT(if_phy->id - 1))
> +			gmii_sel_mode = J72XX_GMII_SEL_MODE_QSGMII;
> +		else
> +			gmii_sel_mode = J72XX_GMII_SEL_MODE_QSGMII_SUB;
> +		break;
> +
>  	default:
> -		dev_warn(dev, "port%u: unsupported mode: \"%s\"\n",
> -			 if_phy->id, phy_modes(submode));
> -		return -EINVAL;
> +		goto unsupported;
>  	}
>  
>  	if_phy->phy_if_mode = submode;
> @@ -123,6 +138,11 @@ static int phy_gmii_sel_mode(struct phy *phy, enum phy_mode mode, int submode)
>  	}
>  
>  	return 0;
> +
> +unsupported:
> +	dev_warn(dev, "port%u: unsupported mode: \"%s\"\n",
> +		 if_phy->id, phy_modes(submode));
> +	return -EINVAL;
>  }
>  
>  static const
> @@ -188,6 +208,13 @@ struct phy_gmii_sel_soc_data phy_gmii_sel_soc_am654 = {
>  	.regfields = phy_gmii_sel_fields_am654,
>  };
>  
> +static const
> +struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw5g_soc_j7200 = {
> +	.use_of_data = true,
> +	.regfields = phy_gmii_sel_fields_am654,
> +	.extra_modes = BIT(PHY_INTERFACE_MODE_QSGMII),
> +};
> +
>  static const struct of_device_id phy_gmii_sel_id_table[] = {
>  	{
>  		.compatible	= "ti,am3352-phy-gmii-sel",
> @@ -209,6 +236,10 @@ static const struct of_device_id phy_gmii_sel_id_table[] = {
>  		.compatible	= "ti,am654-phy-gmii-sel",
>  		.data		= &phy_gmii_sel_soc_am654,
>  	},
> +	{
> +		.compatible	= "ti,j7200-cpsw5g-phy-gmii-sel",
> +		.data		= &phy_gmii_sel_cpsw5g_soc_j7200,
> +	},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, phy_gmii_sel_id_table);
> @@ -350,6 +381,7 @@ static int phy_gmii_sel_probe(struct platform_device *pdev)
>  	struct device_node *node = dev->of_node;
>  	const struct of_device_id *of_id;
>  	struct phy_gmii_sel_priv *priv;
> +	u32 main_ports = 1;
>  	int ret;
>  
>  	of_id = of_match_node(phy_gmii_sel_id_table, pdev->dev.of_node);
> @@ -363,6 +395,8 @@ static int phy_gmii_sel_probe(struct platform_device *pdev)
>  	priv->dev = &pdev->dev;
>  	priv->soc_data = of_id->data;
>  	priv->num_ports = priv->soc_data->num_ports;
> +	of_property_read_u32_array(node, "ti,qsgmii-main-ports", &main_ports, 1);

of_property_read_u32_array can return error and you are not doing any sanity checks.
This should fail if "ti,qsgmii-main-ports" is not present or out of bounds if port mode is QSGMII.

How is this going to scale if you are going to have multiple main ports?
Let's say you increase it to 2 in the future. won't this break with -EOVERFLOW for older
DTs where you had only 1 u32.

> +	priv->qsgmii_main_ports = PHY_GMII_PORT(main_ports);
>  
>  	priv->regmap = syscon_node_to_regmap(node->parent);
>  	if (IS_ERR(priv->regmap)) {

cheers,
-roger
