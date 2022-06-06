Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E6753E839
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbiFFJYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbiFFJXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:23:49 -0400
X-Greylist: delayed 485 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Jun 2022 02:23:47 PDT
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBCD6B01D;
        Mon,  6 Jun 2022 02:23:47 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 900246601F5F;
        Mon,  6 Jun 2022 10:15:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654506936;
        bh=zd8+qvjdsmsp34JFBZwd6faM6nKbL9aSsLtZSO56220=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LhOfStsHWebQlKZ3BiKGtM9N4+JcT5NsjH8/DOzSUZJVnB74ADfj0TAIIL8fYjI2Y
         sXD4DMHMvcF2i3eMtJHGq18zP07m2zma5y9CS40y4vZ5ZwfyYHwMJfbgUXJ3JLqsOY
         7U1udlsdxcXxNgeQ4f0/LoWB1DUpziOGsZ4zAZ9tb2SFFVJpaGlIiZSlDH0LvIETOR
         tGflqhmz94FQBarUEPWSQ2SEy48IosFtp8D4hLje+4VGk0NM3r8CjcButRyBVnnp+c
         2kFKinw5wOuioVwRvzcyomHgv2lM1FEFiQlZIEjyQDSu8zl2EFkJ2ibjWCZpecQQyf
         wbDcWIXcfl60g==
Message-ID: <dd12145b-bbb3-b771-b8f7-075ea20bee17@collabora.com>
Date:   Mon, 6 Jun 2022 11:15:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1 05/15] remoteproc: mediatek: Add SCP core 1 driver for
 dual-core scp
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Dustin L. Howett" <dustin@howett.net>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        chrome-platform@lists.linux.dev,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        weishunc@google.com
References: <20220601112201.15510-1-tinghan.shen@mediatek.com>
 <20220601112201.15510-6-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220601112201.15510-6-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/06/22 13:21, Tinghan Shen ha scritto:
> MT8195 SCP is a dual-core processor. The mtk_scp.c driver only controls
> SCP core 0. This patch adds a basic driver to control the another core.
> 
> Core 1 and core 0 of the SCP are housed in the same subsys.They see
> registers and memory in the same way.
> 
> Core 1 of the SCP features its own set of core configuration registers,
> interrupt controller, timers, and DMAs. The rest of the peripherals
> in this subsystem are shared by core 0 and core 1.
> 
> As for memory, core 1 has its own cache memory, and the SCP SRAM is shared
> by core 0 and core 1.
> 

Hello Tinghan,

checking all the patches that are introducing support for the secondary SCP core,
it's clear that you're practically reusing *most of* mtk_scp in mtk_scp_dual.

I don't think that adding a new configuration option for MTK_SCP_DUALCORE (nor a
new file just for that) is a good idea... the code is "short enough" so you should
really just add support for multi-core SCP in mtk_scp.c instead.

After doing so, I have a hunch that we'll be able to reduce the size of this
implementation even more, as I see literally too much common code :-)

Cheers,
Angelo


> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>   drivers/remoteproc/Makefile       |  1 +
>   drivers/remoteproc/mtk_scp_dual.c | 97 +++++++++++++++++++++++++++++++
>   2 files changed, 98 insertions(+)
>   create mode 100644 drivers/remoteproc/mtk_scp_dual.c
> 
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index 5478c7cb9e07..84cb687d28da 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_IMX_REMOTEPROC)		+= imx_rproc.o
>   obj-$(CONFIG_IMX_DSP_REMOTEPROC)	+= imx_dsp_rproc.o
>   obj-$(CONFIG_INGENIC_VPU_RPROC)		+= ingenic_rproc.o
>   obj-$(CONFIG_MTK_SCP)			+= mtk_scp.o mtk_scp_ipi.o
> +obj-$(CONFIG_MTK_SCP_DUALCORE)		+= mtk_scp_dual.o
>   obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
>   obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
>   obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
> diff --git a/drivers/remoteproc/mtk_scp_dual.c b/drivers/remoteproc/mtk_scp_dual.c
> new file mode 100644
> index 000000000000..7bc08d26f208
> --- /dev/null
> +++ b/drivers/remoteproc/mtk_scp_dual.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2022 MediaTek Inc.
> +
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +
> +#include "mtk_common.h"
> +#include "remoteproc_internal.h"
> +
> +static const struct rproc_ops scp_ops;
> +
> +static int scp_dual_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct mtk_scp *scp;
> +	struct rproc *rproc;
> +	const char *fw_name = "scp-dual.img";
> +	int ret, i;
> +	struct resource *res;
> +
> +	ret = rproc_of_parse_firmware(dev, 0, &fw_name);
> +	if (ret < 0 && ret != -EINVAL)
> +		return ret;
> +
> +	rproc = devm_rproc_alloc(dev, np->name, &scp_ops, fw_name, sizeof(*scp));
> +	if (!rproc) {
> +		dev_err(dev, "unable to allocate remoteproc\n");
> +		return -ENOMEM;
> +	}
> +
> +	scp = (struct mtk_scp *)rproc->priv;
> +	scp->rproc = rproc;
> +	scp->dev = dev;
> +	platform_set_drvdata(pdev, scp);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sram");
> +	scp->sram_base = devm_ioremap(dev, res->start, resource_size(res));
> +	if (IS_ERR(scp->sram_base))
> +		return dev_err_probe(dev, PTR_ERR(scp->sram_base),
> +				     "Failed to parse and map sram memory\n");
> +
> +	scp->sram_size = resource_size(res);
> +	scp->sram_phys = res->start;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> +	scp->reg_base = devm_ioremap(dev, res->start, resource_size(res));
> +	if (IS_ERR(scp->reg_base))
> +		return dev_err_probe(dev, PTR_ERR(scp->reg_base),
> +				     "Failed to parse and map cfg memory\n");
> +
> +	mutex_init(&scp->send_lock);
> +	for (i = 0; i < SCP_IPI_MAX; i++)
> +		mutex_init(&scp->ipi_desc[i].lock);
> +
> +	init_waitqueue_head(&scp->run.wq);
> +	init_waitqueue_head(&scp->ack_wq);
> +
> +	return 0;
> +}
> +
> +static int scp_dual_remove(struct platform_device *pdev)
> +{
> +	struct mtk_scp *scp = platform_get_drvdata(pdev);
> +	int i;
> +
> +	for (i = 0; i < SCP_IPI_MAX; i++)
> +		mutex_destroy(&scp->ipi_desc[i].lock);
> +	mutex_destroy(&scp->send_lock);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mtk_scp_dual_of_match[] = {
> +	{ .compatible = "mediatek,mt8195-scp-dual" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mtk_scp_dual_of_match);
> +
> +static struct platform_driver mtk_scp_dual_driver = {
> +	.probe = scp_dual_probe,
> +	.remove = scp_dual_remove,
> +	.driver = {
> +		.name = "mtk-scp-dual",
> +		.of_match_table = mtk_scp_dual_of_match,
> +	},
> +};
> +
> +module_platform_driver(mtk_scp_dual_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("MediaTek SCP dualcore control driver");
