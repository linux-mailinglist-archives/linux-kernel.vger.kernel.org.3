Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E98B5A24CC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344050AbiHZJqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343998AbiHZJqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:46:10 -0400
Received: from smtp.smtpout.orange.fr (smtp05.smtpout.orange.fr [80.12.242.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77A643E47
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:46:06 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id RVuXoLYFLC5LCRVuXojhaU; Fri, 26 Aug 2022 11:46:04 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 26 Aug 2022 11:46:04 +0200
X-ME-IP: 90.11.190.129
Message-ID: <eba77c0f-7c1a-ad09-eca0-529e59c7f6ed@wanadoo.fr>
Date:   Fri, 26 Aug 2022 11:45:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [V13,3/7] mtk-jpegenc: support jpegenc multi-hardware
Content-Language: en-US
To:     irui.wang@mediatek.com
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, hverkuil-cisco@xs4all.nl,
        kyrie.wu@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org, maoguang.meng@mediatek.com,
        matthias.bgg@gmail.com, mchehab@kernel.org,
        nicolas.dufresne@collabora.com, robh+dt@kernel.org,
        tfiga@chromium.org, tzungbi@chromium.org, wenst@chromium.org,
        xia.jiang@mediatek.com
References: <20220826092956.10340-1-irui.wang@mediatek.com>
 <20220826092956.10340-4-irui.wang@mediatek.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220826092956.10340-4-irui.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 26/08/2022 à 11:29, Irui Wang a écrit :
> From: kyrie wu <kyrie.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> 
> support jpeg encode multi-hardware includes HW0 and HW1.
> 
> Signed-off-by: kyrie wu <kyrie.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> Signed-off-by: irui wang <irui.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>   drivers/media/platform/mediatek/jpeg/Makefile |  11 +-
>   .../platform/mediatek/jpeg/mtk_jpeg_core.c    |  67 +++----
>   .../platform/mediatek/jpeg/mtk_jpeg_core.h    |  37 ++++
>   .../platform/mediatek/jpeg/mtk_jpeg_enc_hw.c  | 163 ++++++++++++++++++
>   4 files changed, 245 insertions(+), 33 deletions(-)

[...]

> static int mtk_jpegenc_hw_init_irq(struct mtk_jpegenc_comp_dev *dev)
> +{
> +	struct platform_device *pdev = dev->plat_dev;
> +	int ret;
> +
> +	dev->jpegenc_irq = platform_get_irq(pdev, 0);
> +	if (dev->jpegenc_irq < 0) {
> +		dev_err(&pdev->dev, "Failed to get irq resource");

Hi,

Should there be a v14, this dev_err() is useless.
platform_get_irq() already prints a more informative message.

> +		return dev->jpegenc_irq;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev,
> +			       dev->jpegenc_irq,
> +			       mtk_jpegenc_hw_irq_handler,
> +			       0,
> +			       pdev->name, dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to devm_request_irq %d (%d)",
> +			dev->jpegenc_irq, ret);
> +		return -ENOENT;

Why not propagate 'ret' here?

> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_jpegenc_hw_probe(struct platform_device *pdev)
> +{
> +	struct mtk_jpegenc_clk *jpegenc_clk;
> +	struct mtk_jpeg_dev *master_dev;
> +	struct mtk_jpegenc_comp_dev *dev;
> +	int ret, i;
> +
> +	struct device *decs = &pdev->dev;
> +
> +	if (!decs->parent)
> +		return -EPROBE_DEFER;
> +
> +	master_dev = dev_get_drvdata(decs->parent);
> +	if (!master_dev)
> +		return -EPROBE_DEFER;
> +
> +	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	dev->plat_dev = pdev;
> +	dev->dev = &pdev->dev;
> +
> +	if (!master_dev->is_jpgenc_multihw) {
> +		master_dev->is_jpgenc_multihw = true;
> +		for (i = 0; i < MTK_JPEGENC_HW_MAX; i++)
> +			master_dev->enc_hw_dev[i] = NULL;
> +	}
> +
> +	jpegenc_clk = &dev->venc_clk;
> +
> +	jpegenc_clk->clk_num = devm_clk_bulk_get_all(&pdev->dev,
> +						     &jpegenc_clk->clks);
> +	if (jpegenc_clk->clk_num < 0)
> +		return dev_err_probe(&pdev->dev, jpegenc_clk->clk_num,
> +				     "Failed to get jpegenc clock count\n");
> +
> +	dev->reg_base =
> +		devm_platform_ioremap_resource(pdev, 0);

This can be written on 1 line only.

just my 2c,

CJ

> +	if (IS_ERR(dev->reg_base))
> +		return PTR_ERR(dev->reg_base);
> +
> +	ret = mtk_jpegenc_hw_init_irq(dev);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < MTK_JPEGENC_HW_MAX; i++) {
> +		if (master_dev->enc_hw_dev[i])
> +			continue;
> +
> +		master_dev->enc_hw_dev[i] = dev;
> +		master_dev->reg_encbase[i] = dev->reg_base;
> +		dev->master_dev = master_dev;
> +	}
> +
> +	platform_set_drvdata(pdev, dev);
> +	pm_runtime_enable(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +struct platform_driver mtk_jpegenc_hw_driver = {
> +	.probe = mtk_jpegenc_hw_probe,
> +	.driver = {
> +		.name = "mtk-jpegenc-hw",
> +		.of_match_table = of_match_ptr(mtk_jpegenc_drv_ids),
> +	},
> +};
> +
> +module_platform_driver(mtk_jpegenc_hw_driver);
> +
> +MODULE_DESCRIPTION("MediaTek JPEG encode HW driver");
> +MODULE_LICENSE("GPL");

