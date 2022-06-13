Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8059E549E32
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245419AbiFMT5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346056AbiFMT4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:56:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A25A5015;
        Mon, 13 Jun 2022 11:27:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A83F61295;
        Mon, 13 Jun 2022 18:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7195FC34114;
        Mon, 13 Jun 2022 18:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655144873;
        bh=4acUEF/GtiroxdkX0QUJJTf/NNYdtRPoMippfdF+Tbs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aEcS3c5PuXqEnaTpZNKg40R3God3d+LK8yPhQQejAGjRW1qBwC32okVmksKg2N2+z
         yofbKTOOIypSFItFnYzAA1W79a9xS2NBzZLYopWs2Nr4x8FhfqjGrfTXjFKP5hPHPc
         SAD1t6ahlh9v5DCGkHYm629+mfQETe8iketrGHBBTGoxehe9P2+H/DRZdJsGBGxJ9b
         /DIXDBa6qIdjJ8jkJ6iNWbzHMGV3fBBub3ItPHhQEAhcnE3kcwKfWRFPCFSvozpIck
         /Ot+ri4rcFjzH0npaiOlzwZ0zY/ajcIScCJTpHOwdu69UtJeEtA2PpBlOMUrJU66gw
         SCYoOfOmuqNHQ==
Message-ID: <d933f30b-4d53-eb97-d029-1c321ba84b62@kernel.org>
Date:   Mon, 13 Jun 2022 21:27:45 +0300
MIME-Version: 1.0
Subject: Re: [PATCH 2/8] interconnect: add device managed bulk API
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
        Peng Fan <peng.fan@nxp.com>
References: <20220601094156.3388454-1-peng.fan@oss.nxp.com>
 <20220601094156.3388454-3-peng.fan@oss.nxp.com>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20220601094156.3388454-3-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

Thanks for the patches!

On 1.06.22 12:41, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add device managed bulk API to simplify driver.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/interconnect/bulk.c  | 34 ++++++++++++++++++++++++++++++++++
>   include/linux/interconnect.h |  6 ++++++
>   2 files changed, 40 insertions(+)
> 
> diff --git a/drivers/interconnect/bulk.c b/drivers/interconnect/bulk.c
> index 448cc536aa79..4918844bfe0d 100644
> --- a/drivers/interconnect/bulk.c
> +++ b/drivers/interconnect/bulk.c
> @@ -115,3 +115,37 @@ void icc_bulk_disable(int num_paths, const struct icc_bulk_data *paths)
>   		icc_disable(paths[num_paths].path);
>   }
>   EXPORT_SYMBOL_GPL(icc_bulk_disable);
> +
> +struct icc_bulk_devres {
> +	struct icc_bulk_data *paths;
> +	int num_paths;
> +};
> +
> +static void devm_icc_bulk_release(struct device *dev, void *res)
> +{
> +	struct icc_bulk_devres *devres = res;
> +
> +	icc_bulk_put(devres->num_paths, devres->paths);
> +}
> +
> +int devm_of_icc_bulk_get(struct device *dev, int num_paths, struct icc_bulk_data *paths)

Adding a kerneldoc would be nice.

> +{
> +	struct icc_bulk_devres *devres;
> +	int ret;
> +
> +	devres = devres_alloc(devm_icc_bulk_release, sizeof(*devres), GFP_KERNEL);
> +	if (!devres)
> +		return -ENOMEM;
> +
> +	ret = of_icc_bulk_get(dev, num_paths, paths);
> +	if (!ret) {
> +		devres->paths = paths;
> +		devres->num_paths = num_paths;
> +		devres_add(dev, devres);
> +	} else {
> +		devres_free(devres);
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(devm_of_icc_bulk_get);
> diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
> index f685777b875e..1a5fdf049edd 100644
> --- a/include/linux/interconnect.h
> +++ b/include/linux/interconnect.h
> @@ -44,6 +44,7 @@ struct icc_path *icc_get(struct device *dev, const int src_id,
>   			 const int dst_id);
>   struct icc_path *of_icc_get(struct device *dev, const char *name);
>   struct icc_path *devm_of_icc_get(struct device *dev, const char *name);
> +int devm_of_icc_bulk_get(struct device *dev, int num_paths, struct icc_bulk_data *paths);
>   struct icc_path *of_icc_get_by_index(struct device *dev, int idx);
>   void icc_put(struct icc_path *path);
>   int icc_enable(struct icc_path *path);
> @@ -116,6 +117,11 @@ static inline int of_icc_bulk_get(struct device *dev, int num_paths, struct icc_
>   	return 0;
>   }
>   
> +int devm_of_icc_bulk_get(struct device *dev, int num_paths, struct icc_bulk_data *paths)

Please make this static inline. The rest looks good!

Thanks,
Georgi

> +{
> +	return 0;
> +}
> +
>   static inline void icc_bulk_put(int num_paths, struct icc_bulk_data *paths)
>   {
>   }

