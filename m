Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E6055EB8F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 19:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbiF1R5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 13:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbiF1R5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:57:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F0B64E4;
        Tue, 28 Jun 2022 10:57:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E44C619FA;
        Tue, 28 Jun 2022 17:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16210C3411D;
        Tue, 28 Jun 2022 17:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656439063;
        bh=1JjIFtMxSAjXxKXlrad51iQP0xJ0nZGZHeaMFImOkzY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WnhADcWq8IE1VbtDiU1HIgW/N4NCgUk8ASDoRNgqDK2Yy3wEgQwA90Wsd4jh1n2gR
         GIn6urs2oxsxNfo1siBgV895ZuaJ1wkaNM7lpFLRSjHsUz/19nGoLJrOPFeGMH99kp
         BGObeKo5gUWbc2ZUhbVwMExSWbZEXpzu9zhItXjDHryAKq03Xa0/dg4sPCKoZyqkE7
         PPzAjhkvsSTVgzUhknswoTAqpPo/ykbdVYmSo+wfNZV8rHg8YSnFkX5FuHQeD/duQx
         IwYPbcFcXxPN1vbOFJIJkA7c+2HYh9FjixrAsib4gPfzaePW1biRiTH99GyTd+FUdh
         ZB49EgKXm2aFw==
Message-ID: <ae4b19a2-0315-a748-d048-6eb3ed2cc65a@kernel.org>
Date:   Tue, 28 Jun 2022 20:57:36 +0300
MIME-Version: 1.0
Subject: Re: [PATCH V2 8/9] interconnect: imx: configure NoC
 mode/prioriry/ext_control
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@nxp.com,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        abelvesa@kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20220616073320.2203000-1-peng.fan@oss.nxp.com>
 <20220616073320.2203000-9-peng.fan@oss.nxp.com>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20220616073320.2203000-9-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On 16.06.22 10:33, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Introduce imx_icc_noc_setting structure to describe a master port setting
> Pass imx_icc_noc_setting as a parameter from specific driver
> Set priority level, mode, ext control in imx_icc_node_set
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/interconnect/imx/imx.c    | 43 ++++++++++++++++++++++++++----
>   drivers/interconnect/imx/imx.h    | 44 ++++++++++++++++++++++++++++++-
>   drivers/interconnect/imx/imx8mm.c |  2 +-
>   drivers/interconnect/imx/imx8mn.c |  2 +-
>   drivers/interconnect/imx/imx8mq.c |  2 +-
>   5 files changed, 84 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
> index 78557fe6da2c..bd728caf2b85 100644

[..]

> @@ -37,8 +40,24 @@ static int imx_icc_node_set(struct icc_node *node)
>   {
>   	struct device *dev = node->provider->dev;
>   	struct imx_icc_node *node_data = node->data;
> +	void __iomem *base;
> +	u32 prio;
>   	u64 freq;
>   
> +	if (node_data->setting && !node_data->setting->ignore && node->peak_bw) {
> +		base = node_data->setting->reg + node_data->imx_provider->noc_base;
> +		if (node_data->setting->mode == IMX_NOC_MODE_FIXED) {
> +			prio = node_data->setting->prio_level;
> +			prio = PRIORITY_COMP_MARK | (prio << 8) | prio;
> +			writel(prio, base + IMX_NOC_PRIO_REG);
> +			writel(node_data->setting->mode, base + IMX_NOC_MODE_REG);
> +			writel(node_data->setting->ext_control, base + IMX_NOC_EXT_CTL_REG);
> +		} else {
> +			dev_info(dev, "mode: %d not supported\n", node_data->setting->mode);
> +			return -ENOTSUPP;

Nit: I believe that -EOPNOTSUPP is the preferred error code.

> +		}
> +	}
> +
>   	if (!node_data->qos_dev)
>   		return 0;
>   

[..]

> @@ -237,7 +263,8 @@ static int get_max_node_id(struct imx_icc_node_desc *nodes, int nodes_count)
>   }
>   
>   int imx_icc_register(struct platform_device *pdev,
> -		     struct imx_icc_node_desc *nodes, int nodes_count)
> +		     struct imx_icc_node_desc *nodes, int nodes_count,
> +		     struct imx_icc_noc_setting *settings)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct icc_onecell_data *data;
> @@ -267,13 +294,19 @@ int imx_icc_register(struct platform_device *pdev,
>   	provider->dev->of_node = dev->parent->of_node;
>   	platform_set_drvdata(pdev, imx_provider);
>   
> +	if (settings) {
> +		imx_provider->noc_base = devm_of_iomap(dev, provider->dev->of_node, 0, NULL);
> +		if (!imx_provider->noc_base)

devm_of_iomap() returns ERR_PTR(). So we should check it with IS_ERR().

Thanks,
Georgi

> +			return PTR_ERR(imx_provider->noc_base);
> +	}
> +
>   	ret = icc_provider_add(provider);
>   	if (ret) {
>   		dev_err(dev, "error adding interconnect provider: %d\n", ret);
>   		return ret;
>   	}
>   
> -	ret = imx_icc_register_nodes(imx_provider, nodes, nodes_count);
> +	ret = imx_icc_register_nodes(imx_provider, nodes, nodes_count, settings);
>   	if (ret)
>   		goto provider_del;
>   
