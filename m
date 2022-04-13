Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A634FF250
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 10:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiDMIoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 04:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbiDMIoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:44:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED69E4A3CC;
        Wed, 13 Apr 2022 01:41:39 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 11E7A1F44B82
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649839298;
        bh=VsMFErl3fUbkDNBlhEDMtj7UhHKnA4rACzxxHNzfR78=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cQZJI2NNJoEH98QbZdpA+szsNPyPCK+1jHsBugIIHcC62oajQU3IIw9NZt6a7e/+f
         ePLipA+Q3P3XFtCacGvu8z/oWU2SDiE2VTBp7MAtyaVduZgcumYwCs4MB2MK1/solf
         VrTvBIm3b8Nu3Go2kLV82hgUVmp4I2ag5xnb5iPJO38D/TgHCzZSGwXYeVic75Rjtk
         pSXyW/0ktVhsjJpHpyCz6T0I6bD11mw6VqeA2cxcY4gnMDPNl0Jj30jNxgoFUDccuU
         +WRlMMeY8axwd8TYRH+aPXYDuK12r6E/rUaF6jOF8aqfiByz3n7c4ZBw83Ft48AchM
         1djzws6N1zZoA==
Message-ID: <858afddd-c008-8a6c-c3c1-e1883e710c5e@collabora.com>
Date:   Wed, 13 Apr 2022 10:41:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v14 6/6] soc: mediatek: mutex: add functions that operate
 registers by CMDQ
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>, tfiga@chromium.org,
        drinkcat@chromium.org, pihsun@chromium.org, hsinyi@google.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        allen-kh.cheng@mediatek.com, xiandong.wang@mediatek.com,
        randy.wu@mediatek.com, jason-jh.lin@mediatek.com,
        roy-cw.yeh@mediatek.com, river.cheng@mediatek.com,
        srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220411072403.24016-1-moudy.ho@mediatek.com>
 <20220411072403.24016-7-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220411072403.24016-7-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/04/22 09:24, Moudy Ho ha scritto:
> Due to HW limitations, MDP3 is necessary to enable MUTEX in each frame
> for SOF triggering and cooperate with CMDQ control to reduce the amount
> of interrupts generated(also, reduce frame latency).
> 
> In response to the above situation, a new interface
> "mtk_mutex_enable_by_cmdq" has been added to achieve the purpose.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-mutex.c       | 42 +++++++++++++++++++++++++-
>   include/linux/soc/mediatek/mtk-mutex.h |  2 ++
>   2 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
> index fc9ba2749946..1811beaf399d 100644
> --- a/drivers/soc/mediatek/mtk-mutex.c
> +++ b/drivers/soc/mediatek/mtk-mutex.c
> @@ -7,10 +7,12 @@
>   #include <linux/iopoll.h>
>   #include <linux/module.h>
>   #include <linux/of_device.h>
> +#include <linux/of_address.h>
>   #include <linux/platform_device.h>
>   #include <linux/regmap.h>
>   #include <linux/soc/mediatek/mtk-mmsys.h>
>   #include <linux/soc/mediatek/mtk-mutex.h>
> +#include <linux/soc/mediatek/mtk-cmdq.h>
>   
>   #define MT2701_MUTEX0_MOD0			0x2c
>   #define MT2701_MUTEX0_SOF0			0x30
> @@ -176,6 +178,9 @@ struct mtk_mutex_ctx {
>   	void __iomem			*regs;
>   	struct mtk_mutex		mutex[10];
>   	const struct mtk_mutex_data	*data;
> +	phys_addr_t			addr;
> +	struct cmdq_client_reg		cmdq_reg;
> +	bool				has_gce_client_reg;
>   };
>   
>   static const unsigned int mt2701_mutex_mod[DDP_COMPONENT_ID_MAX] = {
> @@ -618,6 +623,28 @@ void mtk_mutex_enable(struct mtk_mutex *mutex)
>   }
>   EXPORT_SYMBOL_GPL(mtk_mutex_enable);
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

Is this really supposed to happen?

Reiterating: when the gce-client-reg is not set, this function should either never
be called from the principle, or it should actually fail.
If a driver relies on mtk_mutex_enable_by_cmdq() and does *not* fall back to
register write from cpu, then no change will occur at all, leading to a random
breakage with no apparent reason.

This means that - for safety - this function should return -EINVAL when it gets
called while no gce client reg is declared.
Of course, this would also mean that the dev_dbg() should be a dev_err(), and
that efforts should be done to avoid triggering this error by adding fallbacks
in the drivers that will call this.

Another option would be to keep this function void, keep the print a dev_dbg(),
but automatically fallback to mtk_mutex_enable(), so that here:

if (!mtx->has_gce_client_reg) {
	dev_dbg(mtx->dev,
		"No GCE client register found: falling back to cpu write.\n");
	mtk_mutex_enable(mutex);
	return;
}

...you're free to choose whichever of the two options, but this has to be fixed
to remove this fragility.

> +	}
> +
> +	cmdq_pkt_write(cmdq_pkt, mtx->cmdq_reg.subsys,
> +		       mtx->addr + DISP_REG_MUTEX_EN(mutex->id), 1);
> +#else
> +	dev_err(mtx->dev, "Not support for enable MUTEX by CMDQ");

...obviously, if mtk_cmdq not reachable, instead of simply letting drivers break,
you should, also here, fall back to the less performant and very suboptimal (for
the specific case of mdp3 and some others) mtk_mutex_enable().


Thanks,
Angelo
