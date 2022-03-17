Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0DB4DBE6E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 06:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiCQFfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 01:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiCQFfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 01:35:33 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E2123C077;
        Wed, 16 Mar 2022 22:03:26 -0700 (PDT)
X-UUID: 27f09bafc99445cc815384fc067381c1-20220317
X-UUID: 27f09bafc99445cc815384fc067381c1-20220317
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1492094900; Thu, 17 Mar 2022 11:39:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Mar 2022 11:39:07 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Mar 2022 11:39:07 +0800
Message-ID: <e5b33e4be119c3dc425b9d2810df4556240861c3.camel@mediatek.com>
Subject: Re: [PATCH v13 6/6] soc: mediatek: mutex: add functions that
 operate registers by CMDQ
From:   CK Hu <ck.hu@mediatek.com>
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Jernej Skrabec" <jernej.skrabec@siol.net>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Alexandre Courbot" <acourbot@chromium.org>, <tfiga@chromium.org>,
        <drinkcat@chromium.org>, <pihsun@chromium.org>,
        <hsinyi@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        <menghui.lin@mediatek.com>, <sj.huang@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, <randy.wu@mediatek.com>,
        <jason-jh.lin@mediatek.com>, <roy-cw.yeh@mediatek.com>,
        <river.cheng@mediatek.com>, <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 17 Mar 2022 11:39:07 +0800
In-Reply-To: <20220315061031.21642-7-moudy.ho@mediatek.com>
References: <20220315061031.21642-1-moudy.ho@mediatek.com>
         <20220315061031.21642-7-moudy.ho@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Moudy:

On Tue, 2022-03-15 at 14:10 +0800, Moudy Ho wrote:
> Due to hardware limitations, MDP3 is necessary to enable MUTEX in
> each frame for SOF triggering and cooperate with CMDQ control to
> reduce the amount of interrupts generated(also, reduce frame
> latency).
> 
> In response to the above situation, a new interface
> "mtk_mutex_enable_by_cmdq" has been added to achieve the purpose.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-mutex.c       | 42
> +++++++++++++++++++++++++-
>  include/linux/soc/mediatek/mtk-mutex.h |  2 ++
>  2 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-mutex.c
> b/drivers/soc/mediatek/mtk-mutex.c
> index 88fb4fc8f216..0d85111cfbe2 100644
> --- a/drivers/soc/mediatek/mtk-mutex.c
> +++ b/drivers/soc/mediatek/mtk-mutex.c
> @@ -7,10 +7,16 @@
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> +#include <linux/of_address.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/soc/mediatek/mtk-mmsys.h>
>  #include <linux/soc/mediatek/mtk-mutex.h>
> +#include <linux/soc/mediatek/mtk-cmdq.h>
> +
> +#define MTK_MUTEX_ENABLE			BIT(0)

This is not related to cmdq. Separate this to another patch and apply
to mtk_mutex_enable() also.

> +#define MTK_MUTEX_MOD_MASK			0x07FFFFFF

Useless, remove.

> +#define MTK_MUTEX_SOF_MASK			0x00000007

Ditto.

>  
>  #define MT2701_MUTEX0_MOD0			0x2c
>  #define MT2701_MUTEX0_SOF0			0x30
> @@ -167,6 +173,7 @@ struct mtk_mutex_data {
>  	const unsigned int mutex_sof_reg;
>  	const unsigned long long *mutex_table_mod;
>  	const bool no_clk;
> +	const bool has_gce_client_reg;
>  };
>  
>  struct mtk_mutex_ctx {
> @@ -175,6 +182,8 @@ struct mtk_mutex_ctx {
>  	void __iomem			*regs;
>  	struct mtk_mutex		mutex[10];
>  	const struct mtk_mutex_data	*data;
> +	phys_addr_t			addr;
> +	struct cmdq_client_reg		cmdq_reg;
>  };
>  
>  static const unsigned int mt2701_mutex_mod[DDP_COMPONENT_ID_MAX] = {
> @@ -357,6 +366,7 @@ static const struct mtk_mutex_data
> mt8183_mutex_driver_data = {
>  	.mutex_sof_reg = MT8183_MUTEX0_SOF0,
>  	.mutex_table_mod = mt8183_mutex_table_mod,
>  	.no_clk = true,
> +	.has_gce_client_reg = true,
>  };
>  
>  static const struct mtk_mutex_data mt8186_mutex_driver_data = {
> @@ -639,6 +649,22 @@ void mtk_mutex_enable(struct mtk_mutex *mutex)
>  }
>  EXPORT_SYMBOL_GPL(mtk_mutex_enable);
>  
> +void mtk_mutex_enable_by_cmdq(struct mtk_mutex *mutex,
> +			      struct cmdq_pkt *pkt)
> +{
> +#if IS_REACHABLE(CONFIG_MTK_CMDQ)
> +	struct mtk_mutex_ctx *mtx = container_of(mutex, struct
> mtk_mutex_ctx,
> +						 mutex[mutex->id]);
> +
> +	WARN_ON(&mtx->mutex[mutex->id] != mutex);
> +
> +	cmdq_pkt_write_mask(pkt, mtx->cmdq_reg.subsys,
> +			    mtx->aaddr + DISP_REG_MUTEX_EN(mutex->id),
> +			    MTK_MUTEX_ENABLE, MTK_MUTEX_ENABLE);

#else
/* show some error message here */


> +#endif
> +}
> +EXPORT_SYMBOL_GPL(mtk_mutex_enable_by_cmdq);
> +
>  void mtk_mutex_disable(struct mtk_mutex *mutex)
>  {
>  	struct mtk_mutex_ctx *mtx = container_of(mutex, struct
> mtk_mutex_ctx,
> @@ -677,7 +703,7 @@ static int mtk_mutex_probe(struct platform_device
> *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct mtk_mutex_ctx *mtx;
> -	struct resource *regs;
> +	struct resource *regs, addr;
>  	int i;
>  
>  	mtx = devm_kzalloc(dev, sizeof(*mtx), GFP_KERNEL);
> @@ -698,6 +724,20 @@ static int mtk_mutex_probe(struct
> platform_device *pdev)
>  		}
>  	}
>  
> +	if (of_address_to_resource(dev->of_node, 0, &addr) < 0)
> +		mtx->addr = 0L;
> +	else
> +		mtx->addr = addr.start;
> +
> +#if IS_REACHABLE(CONFIG_MTK_CMDQ)
> +	if (mtx->data->has_gce_client_reg) {

In current upstreamed mt8183.dtsi [1], mutex device node has no
mediatek,gce-client-reg property and display maybe work (?). So I think
this should be backward-compatible.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/mediatek/mt8183.dtsi?h=v5.17-rc8#n1510

Regards,
CK

> +		if (cmdq_dev_get_client_reg(dev, &mtx->cmdq_reg, 0)) {
> +			dev_err(dev, "No mediatek,gce-client-reg!\n");
> +			return ret;
> +		}
> +	}
> +#endif
> +
>  	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	mtx->regs = devm_ioremap_resource(dev, regs);
>  	if (IS_ERR(mtx->regs)) {
> diff --git a/include/linux/soc/mediatek/mtk-mutex.h
> b/include/linux/soc/mediatek/mtk-mutex.h
> index c8355bb0e6d6..18a4b1dc3773 100644
> --- a/include/linux/soc/mediatek/mtk-mutex.h
> +++ b/include/linux/soc/mediatek/mtk-mutex.h
> @@ -45,6 +45,8 @@ void mtk_mutex_set_mod(struct mtk_mutex *mutex,
>  void mtk_mutex_set_sof(struct mtk_mutex *mutex,
>  		       enum mtk_mutex_table_index idx);
>  void mtk_mutex_enable(struct mtk_mutex *mutex);
> +void mtk_mutex_enable_by_cmdq(struct mtk_mutex *mutex,
> +			      struct cmdq_pkt *pkt);
>  void mtk_mutex_disable(struct mtk_mutex *mutex);
>  void mtk_mutex_remove_comp(struct mtk_mutex *mutex,
>  			   enum mtk_ddp_comp_id id);

