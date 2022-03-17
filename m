Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596A74DD12E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 00:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiCQXcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 19:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiCQXcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 19:32:31 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757AC185954;
        Thu, 17 Mar 2022 16:31:09 -0700 (PDT)
X-UUID: eadd4605dd4c432cbd1d673845e65d8a-20220318
X-UUID: eadd4605dd4c432cbd1d673845e65d8a-20220318
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1820036475; Fri, 18 Mar 2022 07:31:06 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 18 Mar 2022 07:31:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Mar 2022 07:31:04 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <moudy.ho@mediatek.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <acourbot@chromium.org>, <allen-kh.cheng@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <chunkuang.hu@kernel.org>, <daoyuan.huang@mediatek.com>,
        <devicetree@vger.kernel.org>, <drinkcat@chromium.org>,
        <geert+renesas@glider.be>, <hsinyi@google.com>,
        <hverkuil-cisco@xs4all.nl>, <jason-jh.lin@mediatek.com>,
        <jernej.skrabec@siol.net>, <laurent.pinchart@ideasonboard.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <maoguang.meng@mediatek.com>,
        <matthias.bgg@gmail.com>, <mchehab@kernel.org>,
        <menghui.lin@mediatek.com>, <pihsun@chromium.org>,
        <ping-hsun.wu@mediatek.com>, <randy.wu@mediatek.com>,
        <river.cheng@mediatek.com>, <rob@landley.net>,
        <robh+dt@kernel.org>, <roy-cw.yeh@mediatek.com>,
        <sj.huang@mediatek.com>, <srv_heupstream@mediatek.com>,
        <tfiga@chromium.org>
Subject: Re: [PATCH v14 6/6] soc: mediatek: mutex: add functions that operate registers by CMDQ
Date:   Fri, 18 Mar 2022 07:31:04 +0800
Message-ID: <20220317233104.5994-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220317143926.15835-7-moudy.ho@mediatek.com>
References: <20220317143926.15835-7-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Moudy,

>  #define MT2701_MUTEX0_MOD0			0x2c
>  #define MT2701_MUTEX0_SOF0			0x30
> @@ -180,6 +184,9 @@ struct mtk_mutex_ctx {
>  	void __iomem			*regs;
>  	struct mtk_mutex		mutex[10];
>  	const struct mtk_mutex_data	*data;
> +	phys_addr_t			addr;
> +	struct cmdq_client_reg		cmdq_reg;
> +	bool				has_gce_client_reg;
>  };
>

...snip...

>  static const unsigned int mt2701_mutex_mod[DDP_COMPONENT_ID_MAX] = {
> @@ -638,6 +645,29 @@ void mtk_mutex_enable(struct mtk_mutex *mutex)
>  }
>  EXPORT_SYMBOL_GPL(mtk_mutex_enable);
>  
> +void mtk_mutex_enable_by_cmdq(struct mtk_mutex *mutex, void *pkt)
> +{
> +#if IS_REACHABLE(CONFIG_MTK_CMDQ)
> +	struct mtk_mutex_ctx *mtx = container_of(mutex, struct mtk_mutex_ctx,
> +						 mutex[mutex->id]);
> +	struct cmdq_pkt *cmdq_pkt = (struct cmdq_pkt *)pkt;
> +
> +	WARN_ON(&mtx->mutex[mutex->id] != mutex);
> +
> +	if (!mtx->has_gce_client_reg) {
> +		dev_dbg(mtx->dev, "mediatek,gce-client-reg hasn't been set in dts");
> +		return;
> +	}
> +
> +	cmdq_pkt_write_mask(cmdq_pkt, mtx->cmdq_reg.subsys,
> +			    mtx->addr + DISP_REG_MUTEX_EN(mutex->id),
> +			    MTK_MUTEX_ENABLE, MTK_MUTEX_ENABLE);

We do not check if mtx->addr is valid.

> +#else
> +	dev_dbg(mtx->dev, "Not support for enable MUTEX by CMDQ");
> +#endif
> +}
> +EXPORT_SYMBOL_GPL(mtk_mutex_enable_by_cmdq);
> +
>  void mtk_mutex_disable(struct mtk_mutex *mutex)
>  {
>  	struct mtk_mutex_ctx *mtx = container_of(mutex, struct mtk_mutex_ctx,
> @@ -676,7 +706,7 @@ static int mtk_mutex_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct mtk_mutex_ctx *mtx;
> -	struct resource *regs;
> +	struct resource *regs, addr;
>  	int i;
>  
>  	mtx = devm_kzalloc(dev, sizeof(*mtx), GFP_KERNEL);
> @@ -697,6 +727,19 @@ static int mtk_mutex_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	if (of_address_to_resource(dev->of_node, 0, &addr) < 0)
> +		mtx->addr = 0L;

addr is phys_addr_t, which means that it holds a physical address.
0 may be a valid address in some platforms, so I think
we should not set mtx->addr = 0L when of_address_to_resource fails.
Maybe probe fail by returning dev_err_probe()?

Thanks,
Miles
