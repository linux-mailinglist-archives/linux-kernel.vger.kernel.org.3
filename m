Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880B955EB96
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 19:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbiF1R6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 13:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbiF1R6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:58:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9299DB80;
        Tue, 28 Jun 2022 10:58:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30FB1619FD;
        Tue, 28 Jun 2022 17:58:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E458C341C6;
        Tue, 28 Jun 2022 17:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656439111;
        bh=MSx95T8wk6hIGQguOGzuWr3N8RUGtzUumdkk9KklXOY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RuKDnC/INZxED7Zwh8uh6bH5n5RUyeqluFiJFqUETDvSiQ17xNAA0RSCDdM6XeTyh
         Lbd2NnCLLlYkQ4Umxwn/rkCSihbbKNv6Z2zZ10qESul2JXlp19JeB0UDR/4in6bBR0
         jRTKr5VFHqYsz2AoBKN3JjLXZ8Ho0fC6mN+lLyof5wm5fbcNhcCvLZZbqsA60Yj+X7
         EOLtYKZ+dZdRCvVABVmpt/1mYgA6fZXESTeIPjRPCDB064Jbz3GMDyxSj7v31/ID+x
         nxjceBZKCSeDT/e00yLVZH4IQARqJXePYkT8f51NqI0JVKBxG9s/k5wbZ4zxAoas78
         OtPdzFKnPmSNg==
Message-ID: <685adda2-e76f-e2c4-2f58-04fb4b06c8cf@kernel.org>
Date:   Tue, 28 Jun 2022 20:58:24 +0300
MIME-Version: 1.0
Subject: Re: [PATCH V2 9/9] interconnect: imx: Add platform driver for imx8mp
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
 <20220616073320.2203000-10-peng.fan@oss.nxp.com>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20220616073320.2203000-10-peng.fan@oss.nxp.com>
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


On 16.06.22 10:33, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add a platform driver for the i.MX8MP SoC describing bus topology, based
> on internal documentation.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/interconnect/imx/Kconfig  |   4 +
>   drivers/interconnect/imx/Makefile |   2 +
>   drivers/interconnect/imx/imx8mp.c | 259 ++++++++++++++++++++++++++++++
>   3 files changed, 265 insertions(+)
>   create mode 100644 drivers/interconnect/imx/imx8mp.c
> 
[..]
> +static int imx8mp_icc_probe(struct platform_device *pdev)
> +{
> +	return imx_icc_register(pdev, nodes, ARRAY_SIZE(nodes), noc_setting_nodes);
> +}
> +
> +static int imx8mp_icc_remove(struct platform_device *pdev)
> +{
> +	return imx_icc_unregister(pdev);
> +}
> +
> +static struct platform_driver imx8mp_icc_driver = {
> +	.probe = imx8mp_icc_probe,
> +	.remove = imx8mp_icc_remove,
> +	.driver = {
> +		.name = "imx8mp-interconnect",
> +	},
> +};
> +
> +module_platform_driver(imx8mp_icc_driver);
> +MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
> +MODULE_LICENSE("GPL v2");

Nit: According to Documentation/process/license-rules.rst this should be just "GPL".

> +MODULE_ALIAS("platform:imx8mp-interconnect");

Thanks,
Georgi
