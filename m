Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837654CBAE8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 11:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbiCCKCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 05:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiCCKCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 05:02:52 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B0B178687;
        Thu,  3 Mar 2022 02:02:05 -0800 (PST)
X-UUID: 0b0048544c294cfeadcfd0240e5d25c5-20220303
X-UUID: 0b0048544c294cfeadcfd0240e5d25c5-20220303
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 912777949; Thu, 03 Mar 2022 18:02:00 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 3 Mar 2022 18:02:00 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 3 Mar
 2022 18:01:59 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 3 Mar 2022 18:01:58 +0800
Message-ID: <710af1457bd59a017a62ecb8028dae0b94b809b3.camel@mediatek.com>
Subject: Re: [PATCH v12 4/4] soc: mediatek: mutex: add functions that
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
        Alexandre Courbot <acourbot@chromium.org>,
        <tfiga@chromium.org>, <drinkcat@chromium.org>,
        <pihsun@chromium.org>, <hsinyi@google.com>,
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
Date:   Thu, 3 Mar 2022 18:01:58 +0800
In-Reply-To: <20220301100246.2153-5-moudy.ho@mediatek.com>
References: <20220301100246.2153-1-moudy.ho@mediatek.com>
         <20220301100246.2153-5-moudy.ho@mediatek.com>
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

On Tue, 2022-03-01 at 18:02 +0800, Moudy Ho wrote:
> Considering that some functions have timing requirements
> in specific situation, this patch adds several interface that
> operate registers by CMDQ.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> ---
>  drivers/soc/mediatek/mtk-mutex.c       | 72
> +++++++++++++++++++++++++-
>  include/linux/soc/mediatek/mtk-mutex.h |  6 +++
>  2 files changed, 76 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-mutex.c
> b/drivers/soc/mediatek/mtk-mutex.c
> index a6268ecde240..a45864183cd1 100644
> --- a/drivers/soc/mediatek/mtk-mutex.c
> +++ b/drivers/soc/mediatek/mtk-mutex.c
> @@ -7,10 +7,14 @@
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
>  
>  #define MT2701_MUTEX0_MOD0			0x2c
>  #define MT2701_MUTEX0_SOF0			0x30
> @@ -173,6 +177,7 @@ struct mtk_mutex_data {
>  	const unsigned int mutex_mdp_mod_mask;
>  	const unsigned int mutex_mdp_sof_mask;
>  	const bool no_clk;
> +	const bool has_gce_client_reg;
>  };
>  
>  struct mtk_mutex_ctx {
> @@ -181,6 +186,8 @@ struct mtk_mutex_ctx {
>  	void __iomem			*regs;
>  	struct mtk_mutex		mutex[10];
>  	const struct mtk_mutex_data	*data;
> +	phys_addr_t			addr;
> +	struct cmdq_client_reg		cmdq_reg;
>  };
>  
>  static const unsigned int mt2701_mutex_mod[DDP_COMPONENT_ID_MAX] = {
> @@ -374,6 +381,7 @@ static const struct mtk_mutex_data
> mt8183_mutex_driver_data = {
>  	.mutex_mdp_mod_mask = MT8183_MUTEX_MDP_MOD_MASK,
>  	.mutex_mdp_sof_mask = MT8183_MUTEX_MDP_SOF_MASK,
>  	.no_clk = true,
> +	.has_gce_client_reg = true,
>  };
>  
>  static const struct mtk_mutex_data mt8186_mutex_driver_data = {
> @@ -553,6 +561,25 @@ u32 mtk_mutex_get_mdp_mod(struct mtk_mutex
> *mutex, enum mtk_mdp_comp_id id)
>  }
>  EXPORT_SYMBOL_GPL(mtk_mutex_get_mdp_mod);
>  
> +void mtk_mutex_add_mod_by_cmdq(struct mtk_mutex *mutex, u32 mod,
> +			       struct mmsys_cmdq_cmd *cmd)
> +{
> +	struct mtk_mutex_ctx *mtx = container_of(mutex, struct
> mtk_mutex_ctx,
> +						 mutex[mutex->id]);
> +	unsigned int offset;
> +
> +	WARN_ON(&mtx->mutex[mutex->id] != mutex);
> +
> +	offset = DISP_REG_MUTEX_MOD(mtx->data->mutex_mod_reg, mutex-
> >id);
> +	cmdq_pkt_write_mask(cmd->pkt, mtx->cmdq_reg.subsys, mtx->addr +
> offset,
> +			    mod, mtx->data->mutex_mdp_mod_mask);
> +
> +	offset = DISP_REG_MUTEX_SOF(mtx->data->mutex_sof_reg, mutex-
> >id);
> +	cmdq_pkt_write_mask(cmd->pkt, mtx->cmdq_reg.subsys, mtx->addr +
> offset,
> +			    0, mtx->data->mutex_mdp_sof_mask);
> +}
> +EXPORT_SYMBOL_GPL(mtk_mutex_add_mod_by_cmdq);
> +
>  void mtk_mutex_enable(struct mtk_mutex *mutex)
>  {
>  	struct mtk_mutex_ctx *mtx = container_of(mutex, struct
> mtk_mutex_ctx,
> @@ -564,6 +591,20 @@ void mtk_mutex_enable(struct mtk_mutex *mutex)
>  }
>  EXPORT_SYMBOL_GPL(mtk_mutex_enable);
>  
> +void mtk_mutex_enable_by_cmdq(struct mtk_mutex *mutex,
> +			      struct mmsys_cmdq_cmd *cmd)

There are 10 mutex and you could bind each pipeline to one mutex and
always enable it. I think it's not necessary to frequently
enable/disable mutex.

> +{
> +	struct mtk_mutex_ctx *mtx = container_of(mutex, struct
> mtk_mutex_ctx,
> +						 mutex[mutex->id]);
> +
> +	WARN_ON(&mtx->mutex[mutex->id] != mutex);
> +
> +	cmdq_pkt_write_mask(cmd->pkt, mtx->cmdq_reg.subsys,
> +			    mtx->addr + DISP_REG_MUTEX_EN(mutex->id),
> +			    MTK_MUTEX_ENABLE, MTK_MUTEX_ENABLE);
> +}
> +EXPORT_SYMBOL_GPL(mtk_mutex_enable_by_cmdq);
> +
>  void mtk_mutex_disable(struct mtk_mutex *mutex)
>  {
>  	struct mtk_mutex_ctx *mtx = container_of(mutex, struct
> mtk_mutex_ctx,
> @@ -575,6 +616,20 @@ void mtk_mutex_disable(struct mtk_mutex *mutex)
>  }
>  EXPORT_SYMBOL_GPL(mtk_mutex_disable);
>  
> +void mtk_mutex_disable_by_cmdq(struct mtk_mutex *mutex,
> +			       struct mmsys_cmdq_cmd *cmd)
> +{
> +	struct mtk_mutex_ctx *mtx = container_of(mutex, struct
> mtk_mutex_ctx,
> +						 mutex[mutex->id]);
> +
> +	WARN_ON(&mtx->mutex[mutex->id] != mutex);
> +
> +	cmdq_pkt_write_mask(cmd->pkt, mtx->cmdq_reg.subsys,
> +			    mtx->addr + DISP_REG_MUTEX_EN(mutex->id),
> +			    0x0, MTK_MUTEX_ENABLE);
> +}
> +EXPORT_SYMBOL_GPL(mtk_mutex_disable_by_cmdq);
> +
>  void mtk_mutex_acquire(struct mtk_mutex *mutex)
>  {
>  	struct mtk_mutex_ctx *mtx = container_of(mutex, struct
> mtk_mutex_ctx,
> @@ -602,8 +657,8 @@ static int mtk_mutex_probe(struct platform_device
> *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct mtk_mutex_ctx *mtx;
> -	struct resource *regs;
> -	int i;
> +	struct resource *regs, addr;
> +	int i, ret;
>  
>  	mtx = devm_kzalloc(dev, sizeof(*mtx), GFP_KERNEL);
>  	if (!mtx)
> @@ -623,6 +678,19 @@ static int mtk_mutex_probe(struct
> platform_device *pdev)
>  		}
>  	}
>  
> +	if (of_address_to_resource(dev->of_node, 0, &addr) < 0)
> +		mtx->addr = 0L;
> +	else
> +		mtx->addr = addr.start;
> +
> +	if (mtx->data->has_gce_client_reg) {
> +		ret = cmdq_dev_get_client_reg(dev, &mtx->cmdq_reg, 0);

Add gce client reg in binding document [1]

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.yaml?h=next-20220302

Regards,
CK

> +		if (ret) {
> +			dev_err(dev, "No mediatek,gce-client-reg!\n");
> +			return ret;
> +		}
> +	}
> +
>  	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	mtx->regs = devm_ioremap_resource(dev, regs);
>  	if (IS_ERR(mtx->regs)) {
> diff --git a/include/linux/soc/mediatek/mtk-mutex.h
> b/include/linux/soc/mediatek/mtk-mutex.h
> index b2608f4220ee..05de7ad4a124 100644
> --- a/include/linux/soc/mediatek/mtk-mutex.h
> +++ b/include/linux/soc/mediatek/mtk-mutex.h
> @@ -17,8 +17,14 @@ int mtk_mutex_prepare(struct mtk_mutex *mutex);
>  void mtk_mutex_add_comp(struct mtk_mutex *mutex,
>  			enum mtk_ddp_comp_id id);
>  u32 mtk_mutex_get_mdp_mod(struct mtk_mutex *mutex, enum
> mtk_mdp_comp_id id);
> +void mtk_mutex_add_mod_by_cmdq(struct mtk_mutex *mutex, u32 mod,
> +			       struct mmsys_cmdq_cmd *cmd);
>  void mtk_mutex_enable(struct mtk_mutex *mutex);
> +void mtk_mutex_enable_by_cmdq(struct mtk_mutex *mutex,
> +			      struct mmsys_cmdq_cmd *cmd);
>  void mtk_mutex_disable(struct mtk_mutex *mutex);
> +void mtk_mutex_disable_by_cmdq(struct mtk_mutex *mutex,
> +			       struct mmsys_cmdq_cmd *cmd);
>  void mtk_mutex_remove_comp(struct mtk_mutex *mutex,
>  			   enum mtk_ddp_comp_id id);
>  void mtk_mutex_unprepare(struct mtk_mutex *mutex);

