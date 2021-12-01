Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E42464DA0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 13:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349293AbhLAMNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 07:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349244AbhLAMMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 07:12:46 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAF4C061574;
        Wed,  1 Dec 2021 04:09:24 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 5CCE21F458EB
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638360563; bh=rCjZemHgp8YdilJSAGYArkazXCfBQoMPdSUkBR6ygY4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=U1ZAV/6AmG3uMhzxoeiV/9hNJypxkX2EH+SbKCwoKaZhMRkMn4i0nxhlwEGrkUFb1
         Ty3YY2TP0P/HL7/Y3lbd2ZYOrkfpojN2RU+5yJsWDydKgbK78JiTPHBQcyeWsblmnx
         AotTg2K++4eiJ6apRr5V200ShDEZbUI9cDipZVredxEC7sOEMHVIqan4JoYZRivIfV
         r+wibvuq4K0cP8UMMtfch4dBjfD3KrW+d7PrUVsDvogffOX/IOqRKQHUQ9Hj5HGNNs
         WeKqWuJm4N+mp9rJhUyDDPKFWTBYmR1R0RzovkRLLxTQYTYsBmsjAqRSLUnWQUuSL4
         j4wYP5UQ10mrA==
Subject: Re: [PATCH v11, 11/19] media: mtk-vcodec: Generalize power and clock
 on/off interfaces
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20211129034201.5767-1-yunfei.dong@mediatek.com>
 <20211129034201.5767-12-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <e2d69f74-0c3f-5e17-1ee4-57ab801c7aad@collabora.com>
Date:   Wed, 1 Dec 2021 13:09:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211129034201.5767-12-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/11/21 04:41, Yunfei Dong ha scritto:
> Generalizes power and clock on/off interfaces to support different hardware.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>   .../platform/mtk-vcodec/mtk_vcodec_dec_drv.c  |  6 +-
>   .../platform/mtk-vcodec/mtk_vcodec_dec_hw.c   |  2 +-
>   .../platform/mtk-vcodec/mtk_vcodec_dec_hw.h   |  4 +
>   .../platform/mtk-vcodec/mtk_vcodec_dec_pm.c   | 76 +++++++++++++++++--
>   .../platform/mtk-vcodec/mtk_vcodec_dec_pm.h   |  8 +-
>   .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  2 +
>   .../platform/mtk-vcodec/mtk_vcodec_util.c     | 60 ++++++++++++---
>   .../platform/mtk-vcodec/mtk_vcodec_util.h     |  8 +-
>   .../media/platform/mtk-vcodec/vdec_drv_if.c   | 21 ++---
>   9 files changed, 147 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
> index ac279c2a3f8a..001cdf447ab8 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
> @@ -75,7 +75,7 @@ static irqreturn_t mtk_vcodec_dec_irq_handler(int irq, void *priv)
>   	void __iomem *vdec_misc_addr = dev->reg_base[VDEC_MISC] +
>   					VDEC_IRQ_CFG_REG;
>   
> -	ctx = mtk_vcodec_get_curr_ctx(dev);
> +	ctx = mtk_vcodec_get_curr_ctx(dev, MTK_VDEC_CORE);
>   
>   	/* check if HW active or not */
>   	cg_status = readl(dev->reg_base[0]);
> @@ -224,7 +224,7 @@ static int fops_vcodec_open(struct file *file)
>   	mtk_vcodec_dec_set_default_params(ctx);
>   
>   	if (v4l2_fh_is_singular(&ctx->fh)) {
> -		ret = mtk_vcodec_dec_pw_on(&dev->pm);
> +		ret = mtk_vcodec_dec_pw_on(dev, MTK_VDEC_LAT0);
>   		if (ret < 0)
>   			goto err_load_fw;
>   		/*
> @@ -284,7 +284,7 @@ static int fops_vcodec_release(struct file *file)
>   	mtk_vcodec_dec_release(ctx);
>   
>   	if (v4l2_fh_is_singular(&ctx->fh))
> -		mtk_vcodec_dec_pw_off(&dev->pm);
> +		mtk_vcodec_dec_pw_off(dev, MTK_VDEC_LAT0);
>   	v4l2_fh_del(&ctx->fh);
>   	v4l2_fh_exit(&ctx->fh);
>   	v4l2_ctrl_handler_free(&ctx->ctrl_hdl);
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_hw.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_hw.c
> index 8bd23504cf4c..389a17eb4085 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_hw.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_hw.c
> @@ -42,7 +42,7 @@ static irqreturn_t mtk_vdec_hw_irq_handler(int irq, void *priv)
>   	void __iomem *vdec_misc_addr = dev->reg_base[VDEC_HW_MISC] +
>   					VDEC_IRQ_CFG_REG;
>   
> -	ctx = mtk_vcodec_get_curr_ctx(dev->main_dev);
> +	ctx = mtk_vcodec_get_curr_ctx(dev->main_dev, dev->hw_idx);
>   
>   	/* check if HW active or not */
>   	cg_status = readl(dev->reg_base[VDEC_HW_SYS]);
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_hw.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_hw.h
> index f7f36790629d..fdf1435fc932 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_hw.h
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_hw.h
> @@ -34,6 +34,8 @@ enum mtk_vdec_hw_reg_idx {
>    * @main_dev: main device
>    * @reg_base: Mapped address of MTK Vcodec registers.
>    *
> + * @curr_ctx: the context that is waiting for codec hardware
> + *
>    * @dec_irq: decoder irq resource
>    * @pm: power management control
>    * @hw_idx: each hardware index
> @@ -43,6 +45,8 @@ struct mtk_vdec_hw_dev {
>   	struct mtk_vcodec_dev *main_dev;
>   	void __iomem *reg_base[VDEC_HW_MAX];
>   
> +	struct mtk_vcodec_ctx *curr_ctx;
> +
>   	int dec_irq;
>   	struct mtk_vcodec_pm pm;
>   	int hw_idx;
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
> index 221cf60e9fbf..4cf03d38d141 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
> @@ -5,11 +5,13 @@
>    */
>   
>   #include <linux/clk.h>
> +#include <linux/interrupt.h>
>   #include <linux/of_address.h>
>   #include <linux/of_platform.h>
>   #include <linux/pm_runtime.h>
>   #include <soc/mediatek/smi.h>
>   
> +#include "mtk_vcodec_dec_hw.h"
>   #include "mtk_vcodec_dec_pm.h"
>   #include "mtk_vcodec_util.h"
>   
> @@ -86,10 +88,23 @@ void mtk_vcodec_release_dec_pm(struct mtk_vcodec_pm *pm)
>   }
>   EXPORT_SYMBOL_GPL(mtk_vcodec_release_dec_pm);
>   
> -int mtk_vcodec_dec_pw_on(struct mtk_vcodec_pm *pm)
> +int mtk_vcodec_dec_pw_on(struct mtk_vcodec_dev *vdec_dev, int hw_idx)
>   {
> +	struct mtk_vdec_hw_dev *subdev_dev;
> +	struct mtk_vcodec_pm *pm;
>   	int ret;
>   
> +	if (vdec_dev->vdec_pdata->is_subdev_supported) {
> +		subdev_dev = mtk_vcodec_get_hw_dev(vdec_dev, hw_idx);
> +		if (!subdev_dev) {
> +			mtk_v4l2_err("Failed to get hw dev\n");
> +			return -EINVAL;
> +		}
> +		pm = &subdev_dev->pm;
> +	} else {
> +		pm = &vdec_dev->pm;
> +	}
> +
>   	ret = pm_runtime_resume_and_get(pm->dev);
>   	if (ret)
>   		mtk_v4l2_err("pm_runtime_resume_and_get fail %d", ret);
> @@ -98,21 +113,50 @@ int mtk_vcodec_dec_pw_on(struct mtk_vcodec_pm *pm)
>   }
>   EXPORT_SYMBOL_GPL(mtk_vcodec_dec_pw_on);
>   
> -void mtk_vcodec_dec_pw_off(struct mtk_vcodec_pm *pm)
> +void mtk_vcodec_dec_pw_off(struct mtk_vcodec_dev *vdec_dev, int hw_idx)
>   {
> +	struct mtk_vdec_hw_dev *subdev_dev;
> +	struct mtk_vcodec_pm *pm;
>   	int ret;
>   
> +	if (vdec_dev->vdec_pdata->is_subdev_supported) {
> +		subdev_dev = mtk_vcodec_get_hw_dev(vdec_dev, hw_idx);
> +		if (!subdev_dev) {
> +			mtk_v4l2_err("Failed to get hw dev\n");
> +			return;
> +		}
> +		pm = &subdev_dev->pm;
> +	} else {
> +		pm = &vdec_dev->pm;
> +	}
> +
>   	ret = pm_runtime_put_sync(pm->dev);
>   	if (ret)
>   		mtk_v4l2_err("pm_runtime_put_sync fail %d", ret);
>   }
>   EXPORT_SYMBOL_GPL(mtk_vcodec_dec_pw_off);
>   
> -void mtk_vcodec_dec_clock_on(struct mtk_vcodec_pm *pm)
> +void mtk_vcodec_dec_clock_on(struct mtk_vcodec_dev *vdec_dev, int hw_idx)
>   {
> -	struct mtk_vcodec_clk *dec_clk = &pm->vdec_clk;
> -	int ret, i = 0;
> +	struct mtk_vdec_hw_dev *subdev_dev;
> +	struct mtk_vcodec_pm *pm;
> +	struct mtk_vcodec_clk *dec_clk;
> +	int ret, i;
> +
> +	if (vdec_dev->vdec_pdata->is_subdev_supported) {
> +		subdev_dev = mtk_vcodec_get_hw_dev(vdec_dev, hw_idx);
> +		if (!subdev_dev) {
> +			mtk_v4l2_err("Failed to get hw dev\n");
> +			return;
> +		}
> +		pm = &subdev_dev->pm;
> +		enable_irq(subdev_dev->dec_irq);
> +	} else {
> +		pm = &vdec_dev->pm;
> +		enable_irq(vdec_dev->dec_irq);
> +	}
>   
> +	dec_clk = &pm->vdec_clk;
>   	for (i = 0; i < dec_clk->clk_num; i++) {
>   		ret = clk_prepare_enable(dec_clk->clk_info[i].vcodec_clk);
>   		if (ret) {
> @@ -135,11 +179,27 @@ void mtk_vcodec_dec_clock_on(struct mtk_vcodec_pm *pm)
>   }
>   EXPORT_SYMBOL_GPL(mtk_vcodec_dec_clock_on);
>   
> -void mtk_vcodec_dec_clock_off(struct mtk_vcodec_pm *pm)
> +void mtk_vcodec_dec_clock_off(struct mtk_vcodec_dev *vdec_dev, int hw_idx)
>   {
> -	struct mtk_vcodec_clk *dec_clk = &pm->vdec_clk;
> -	int i = 0;
> +	struct mtk_vdec_hw_dev *subdev_dev;
> +	struct mtk_vcodec_pm *pm;
> +	struct mtk_vcodec_clk *dec_clk;
> +	int i;
>   
> +	if (vdec_dev->vdec_pdata->is_subdev_supported) {
> +		subdev_dev = mtk_vcodec_get_hw_dev(vdec_dev, hw_idx);
> +		if (!subdev_dev) {
> +			mtk_v4l2_err("Failed to get hw dev\n");
> +			return;
> +		}
> +		pm = &subdev_dev->pm;
> +		disable_irq(subdev_dev->dec_irq);
> +	} else {
> +		pm = &vdec_dev->pm;
> +		disable_irq(vdec_dev->dec_irq);
> +	}
> +
> +	dec_clk = &pm->vdec_clk;
>   	mtk_smi_larb_put(pm->larbvdec);
>   	for (i = dec_clk->clk_num - 1; i >= 0; i--)
>   		clk_disable_unprepare(dec_clk->clk_info[i].vcodec_clk);
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.h
> index a3df6aef6cb9..6ae29fea4e7f 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.h
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.h
> @@ -13,9 +13,9 @@ int mtk_vcodec_init_dec_pm(struct platform_device *pdev,
>   	struct mtk_vcodec_pm *pm);
>   void mtk_vcodec_release_dec_pm(struct mtk_vcodec_pm *pm);
>   
> -int mtk_vcodec_dec_pw_on(struct mtk_vcodec_pm *pm);
> -void mtk_vcodec_dec_pw_off(struct mtk_vcodec_pm *pm);
> -void mtk_vcodec_dec_clock_on(struct mtk_vcodec_pm *pm);
> -void mtk_vcodec_dec_clock_off(struct mtk_vcodec_pm *pm);
> +int mtk_vcodec_dec_pw_on(struct mtk_vcodec_dev *vdec_dev, int hw_idx);
> +void mtk_vcodec_dec_pw_off(struct mtk_vcodec_dev *vdec_dev, int hw_idx);
> +void mtk_vcodec_dec_clock_on(struct mtk_vcodec_dev *vdec_dev, int hw_idx);
> +void mtk_vcodec_dec_clock_off(struct mtk_vcodec_dev *vdec_dev, int hw_idx);
>   
>   #endif /* _MTK_VCODEC_DEC_PM_H_ */
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> index 610b0af13879..5d5376fcf0a7 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> @@ -284,6 +284,7 @@ struct vdec_pic_info {
>    * @decoded_frame_cnt: number of decoded frames
>    * @lock: protect variables accessed by V4L2 threads and worker thread such as
>    *	  mtk_video_dec_buf.
> + * @hw_id: hardware index used to identify different hardware.
>    *
>    * @msg_queue: msg queue used to store lat buffer information.
>    */
> @@ -328,6 +329,7 @@ struct mtk_vcodec_ctx {
>   
>   	int decoded_frame_cnt;
>   	struct mutex lock;
> +	int hw_id;
>   
>   	struct vdec_msg_queue msg_queue;
>   };
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c
> index ac5973b6735f..145bebf4506e 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c
> @@ -6,7 +6,10 @@
>   */
>   
>   #include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>   
> +#include "mtk_vcodec_dec_hw.h"
>   #include "mtk_vcodec_drv.h"
>   #include "mtk_vcodec_util.h"
>   
> @@ -81,25 +84,60 @@ void mtk_vcodec_mem_free(struct mtk_vcodec_ctx *data,
>   }
>   EXPORT_SYMBOL(mtk_vcodec_mem_free);
>   
> -void mtk_vcodec_set_curr_ctx(struct mtk_vcodec_dev *dev,
> -	struct mtk_vcodec_ctx *ctx)
> +void *mtk_vcodec_get_hw_dev(struct mtk_vcodec_dev *dev, int hw_idx)
>   {
> -	unsigned long flags;
> +	if (hw_idx >= MTK_VDEC_HW_MAX || hw_idx < 0 ||
> +		!dev->subdev_dev[hw_idx]) {

Please don't break this line. 83 columns is fine.

Apart from that,
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
