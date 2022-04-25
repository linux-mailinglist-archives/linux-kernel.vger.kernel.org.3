Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B7850DD78
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 12:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241401AbiDYKEK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Apr 2022 06:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241547AbiDYKDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 06:03:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1C7766B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 03:00:32 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nivVw-0001AZ-Kr; Mon, 25 Apr 2022 12:00:16 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nivVv-0057YD-Bh; Mon, 25 Apr 2022 12:00:13 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nivVt-0005AB-9C; Mon, 25 Apr 2022 12:00:13 +0200
Message-ID: <0e642da615b8f52fb36cd1248f8a124ea4e4b7b8.camel@pengutronix.de>
Subject: Re: [PATCH v17 14/21] drm/mediatek: add ETHDR support for MT8195
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     "Nancy.Lin" <nancy.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        wim@linux-watchdog.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, linux@roeck-us.net
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org, llvm@lists.linux.dev,
        singo.chang@mediatek.com, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Date:   Mon, 25 Apr 2022 12:00:13 +0200
In-Reply-To: <20220416020749.29010-15-nancy.lin@mediatek.com>
References: <20220416020749.29010-1-nancy.lin@mediatek.com>
         <20220416020749.29010-15-nancy.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sa, 2022-04-16 at 10:07 +0800, Nancy.Lin wrote:
> ETHDR is a part of ovl_adaptor.
> ETHDR is designed for HDR video and graphics conversion in the external
> display path. It handles multiple HDR input types and performs tone
> mapping, color space/color format conversion, and then combine
> different layers, output the required HDR or SDR signal to the
> subsequent display path.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
[...]
> +static int mtk_ethdr_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mtk_ethdr *priv;
> +	int ret;
> +	int i;
> +
> +	dev_info(dev, "%s+\n", __func__);

Left-over debug statements?

> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < ETHDR_ID_MAX; i++) {
> +		priv->ethdr_comp[i].dev = dev;
> +		priv->ethdr_comp[i].regs = of_iomap(dev->of_node, i);
> +#if IS_REACHABLE(CONFIG_MTK_CMDQ)
> +		ret = cmdq_dev_get_client_reg(dev,
> +					      &priv->ethdr_comp[i].cmdq_base, i);
> +		if (ret)
> +			dev_dbg(dev, "get mediatek,gce-client-reg fail!\n");
> +#endif
> +		dev_dbg(dev, "[DRM]regs:0x%p, node:%d\n", priv->ethdr_comp[i].regs, i);
> +	}
> +
> +	for (i = 0; i < ETHDR_CLK_NUM; i++)
> +		priv->ethdr_clk[i].id = ethdr_clk_str[i];
> +	ret = devm_clk_bulk_get_optional(dev, ETHDR_CLK_NUM, priv->ethdr_clk);
> +	if (ret)
> +		return ret;
> +
> +	priv->irq = platform_get_irq(pdev, 0);
> +	if (priv->irq < 0)
> +		priv->irq = 0;
> +
> +	if (priv->irq) {
> +		ret = devm_request_irq(dev, priv->irq, mtk_ethdr_irq_handler,
> +				       IRQF_TRIGGER_NONE, dev_name(dev), priv);
> +		if (ret < 0) {
> +			dev_err(dev, "Failed to request irq %d: %d\n", priv->irq, ret);
> +			return ret;
> +		}
> +	}
> +
> +	priv->reset_ctl = devm_reset_control_array_get_optional_exclusive(dev);

This is missing error handling. You could use dev_err_probe() here.

regards
Philipp
