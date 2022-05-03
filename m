Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25C55185F8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 15:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbiECN55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 09:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbiECN54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 09:57:56 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2411DA4D
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 06:54:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id CC0FD1F429C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651586062;
        bh=60swnXhouY6PcOi5RAAWpQb5+gqiaMIVdjfxOdCzA8w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ecw4pkZJpi0xotAJ+xOHs9Rrnrn6BlJAx4V2ioTkFTjfVj+Hj/W5GC39c6T5FfLYb
         JY7NlM6EkH/GvJyCApvCJxn9fyZ5+P6cUYUo+IzxR1v85HEZGa0MMm6++G+piVdu1X
         gYFxGBsi582miZ6WMTht2yN9vMYU9LXza2+UBQCvc5pcli05uTrr2HUrfuefRfM3tw
         3spbmXGsuF+euVVGx4LOxhG7TDS0HJAQFoC5OGGvEUkHLEOSjXiKixPMxikuP1hgIy
         Wg/gSOTWngwe7z2he2dBqCXTPdjj/FZbPi0MgKL0r08ygkGPDe6jkveogodbXQAKXA
         aus7uEcW72Q1Q==
Message-ID: <df85d52f-569b-69a6-4310-e38631b533f5@collabora.com>
Date:   Tue, 3 May 2022 15:54:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] mtd: nand: ecc-mtk: add external ecc engine support
Content-Language: en-US
To:     Chuanhong Guo <gch981213@gmail.com>, linux-mtd@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220430164021.537668-1-gch981213@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220430164021.537668-1-gch981213@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/04/22 18:40, Chuanhong Guo ha scritto:
> This adds support for using ecc-mtk as an external ECC engine.
> 
> The implemented OOB layout follows the convention to put all ECC data
> at the end of OOB. As a result, the data layout is incompatible with
> MTK NFI piplined ECC mode.
> 
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
>   drivers/mtd/nand/ecc-mtk.c | 335 ++++++++++++++++++++++++++++++++++++-
>   1 file changed, 331 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/ecc-mtk.c b/drivers/mtd/nand/ecc-mtk.c
> index 9f9b201fe706..998276ada671 100644
> --- a/drivers/mtd/nand/ecc-mtk.c
> +++ b/drivers/mtd/nand/ecc-mtk.c
> @@ -15,6 +15,7 @@
>   #include <linux/of.h>
>   #include <linux/of_platform.h>
>   #include <linux/mutex.h>
> +#include <linux/mtd/nand.h>
>   #include <linux/mtd/nand-ecc-mtk.h>
>   
>   #define ECC_IDLE_MASK		BIT(0)
> @@ -26,12 +27,14 @@
>   #define ECC_ENCCON		(0x00)
>   #define ECC_ENCCNFG		(0x04)
>   #define		ECC_MS_SHIFT		(16)
> +#define		ECC_MAX_MS		(8191)
>   #define ECC_ENCDIADDR		(0x08)
>   #define ECC_ENCIDLE		(0x0C)
>   #define ECC_DECCON		(0x100)
>   #define ECC_DECCNFG		(0x104)
>   #define		DEC_EMPTY_EN		BIT(31)
>   #define		DEC_CNFG_CORRECT	(0x3 << 12)
> +#define ECC_DECDIADDR		(0x108)
>   #define ECC_DECIDLE		(0x10C)
>   #define ECC_DECENUM0		(0x114)
>   
> @@ -59,11 +62,23 @@ struct mtk_ecc {
>   
>   	struct completion done;
>   	struct mutex lock;
> +	struct nand_ecc_engine ecc_eng;
>   	u32 sectors;
> +	u32 refcnt;

Please always use signed values for refcounts.

>   
>   	u8 *eccdata;
>   };
>   
> +struct mtk_ecc_host_ctx {
> +	struct mtk_ecc_config cfg;
> +	struct nand_ecc_req_tweak_ctx req_ctx;
> +	u8 *buf;
> +	dma_addr_t buf_dma;
> +	u32 free_len;
> +	u32 parity_len;
> +	u32 steps;
> +};
> +
>   /* ecc strength that each IP supports */
>   static const u8 ecc_strength_mt2701[] = {
>   	4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 28, 32, 36,
> @@ -75,6 +90,8 @@ static const u8 ecc_strength_mt2712[] = {
>   	40, 44, 48, 52, 56, 60, 68, 72, 80
>   };
>   
> +static const u8 ecc_strength_mt7621[] = { 4 };
Please remove this one.

> +
>   static const u8 ecc_strength_mt7622[] = {
>   	4, 6, 8, 10, 12
>   };
> @@ -115,6 +132,13 @@ static int mt7622_ecc_regs[] = {
>   	[ECC_DECIRQ_STA] =      0x144,
>   };
>   

..snip..

> @@ -239,8 +268,14 @@ EXPORT_SYMBOL(mtk_ecc_get_stats);
>   
>   void mtk_ecc_release(struct mtk_ecc *ecc)
>   {
> -	clk_disable_unprepare(ecc->clk);
> -	put_device(ecc->dev);
> +	mutex_lock(&ecc->lock);
> +
> +	ecc->refcnt--;
> +	if (!ecc->refcnt) {

For the sake of readability, be explicit here.

	if (ecc->refcnt == 0)

...also, for safety (since we're talking about data here) it may be worth to add a

	WARN((ecc->refcnt < 0), "sensible warning message here");
		

> +		clk_disable_unprepare(ecc->clk);
> +		put_device(ecc->dev);
> +	}
> +	mutex_unlock(&ecc->lock);
>   }
>   EXPORT_SYMBOL(mtk_ecc_release);
>   


> +
> +static int mtk_ecc_host_init_ctx(struct nand_device *nand)
> +{
> +	struct mtk_ecc *ecc = nand_to_mtk_ecc(nand);
> +	struct nand_ecc_props *conf = &nand->ecc.ctx.conf;
> +	struct nand_ecc_props *reqs = &nand->ecc.requirements;
> +	struct nand_ecc_props *user = &nand->ecc.user_conf;
> +	struct mtd_info *mtd = nanddev_to_mtd(nand);
> +	const u8 *ecc_strength = ecc->caps->ecc_strength;

struct mtk_ecc_host_ctx *ctx; belongs here.

> +	int step_size = 0, strength = 0;
> +	int ret = 0;
> +	struct mtk_ecc_host_ctx *ctx;

...not here.

> +	int steps, parity_len;
> +	int i;
> +	u32 parity_bits;
> +

..snip..

> +
> +	dev_info(ecc->dev, "OOB: free: %u bytes, ECC: %u bytes", ctx->free_len,
> +		 ctx->parity_len * ctx->steps);
> +	dev_info(ecc->dev, "ECC strength: %d bits per %d bytes\n", strength,
> +		 step_size);

I'm not sure that this should really be a dev_info(), or at least not both.. as
I don't think that this is that much informative anyway.

I'd go for dev_dbg() instead.

> +	return 0;
> +free_buf:
> +	dma_free_coherent(ecc->dev, step_size + parity_len, ctx->buf,
> +			  ctx->buf_dma);
> +free_ctx:
> +	kfree(ctx);
> +	return ret;
> +}
> +

..snip..

> +static int mtk_ecc_host_prepare_io_req(struct nand_device *nand,
> +				       struct nand_page_io_req *req)
> +{
> +	struct mtk_ecc *ecc = nand_to_mtk_ecc(nand);
> +	struct mtd_info *mtd = nanddev_to_mtd(nand);
> +	struct mtk_ecc_host_ctx *ctx = nand_to_ecc_ctx(nand);
> +	int ret, step;
> +
> +	if (req->mode == MTD_OPS_RAW)
> +		return 0;
> +
> +	nand_ecc_tweak_req(&ctx->req_ctx, req);
> +
> +	if (req->type == NAND_PAGE_READ)
> +		return 0;
> +
> +	ctx->cfg.op = ECC_ENCODE;
> +
> +	for (step = 0; step < ctx->steps; step++) {
> +		ctx->cfg.addr = dma_map_single(
> +			ecc->dev, (u8 *)req->databuf.out + step * ctx->cfg.len,
> +			ctx->cfg.len, DMA_TO_DEVICE);
> +		ret = dma_mapping_error(ecc->dev, ctx->cfg.addr);
> +		if (ret) {
> +			dev_err(ecc->dev, "DMA mapping failed.\n");
> +			return ret;
> +		}
> +		ret = mtk_ecc_enable(ecc, &ctx->cfg);
> +		if (ret) {
> +			dma_unmap_single(ecc->dev, ctx->cfg.addr, ctx->cfg.len,
> +					 DMA_TO_DEVICE);
> +			return ret;
> +		}
> +
> +		ret = mtk_ecc_wait_done(ecc, ECC_ENCODE);
> +		if (ret) {
> +			mtk_ecc_disable(ecc);
> +			dma_unmap_single(ecc->dev, ctx->cfg.addr, ctx->cfg.len,
> +					 DMA_TO_DEVICE);
> +			return ret;
> +		}
> +
> +		mtk_ecc_wait_idle(ecc, ECC_ENCODE);
> +		dma_unmap_single(ecc->dev, ctx->cfg.addr, ctx->cfg.len,
> +				 DMA_TO_DEVICE);
> +		__ioread32_copy(ecc->eccdata,
> +				ecc->regs + ecc->caps->ecc_regs[ECC_ENCPAR00],
> +				round_up(ctx->parity_len, 4));
> +		mtd_ooblayout_set_eccbytes(mtd, ecc->eccdata,
> +					   (void *)req->oobbuf.out,
> +					   ctx->parity_len * step,
> +					   ctx->parity_len);
> +		mtk_ecc_disable(ecc);
> +	}
> +
> +	return ret;

You have addressed all of the error conditions, so return 0 here.

> +}
> +
> +static int mtk_ecc_host_finish_io_req(struct nand_device *nand,
> +				      struct nand_page_io_req *req)
> +{
> +	struct mtk_ecc *ecc = nand_to_mtk_ecc(nand);
> +	struct mtd_info *mtd = nanddev_to_mtd(nand);
> +	struct mtk_ecc_host_ctx *ctx = nand_to_ecc_ctx(nand);
> +	u32 bitflips = 0, failed = 0;
> +	int ret, step, i;

> +	u32 err;

It would be more appropriate to call this variable "val" or "regval".

Also, please reorder the variables, you can do it by name...

struct mtk_ecc_host_ctx *ctx = nand_to_ecc_ctx(nand);
struct mtk_ecc *ecc = nand_to_mtk_ecc(nand);
struct mtd_info *mtd = nanddev_to_mtd(nand);
u32 bitflips = 0, failed = 0, regval;
int ret, step, i;

Please also do the same for the other instances of that.

> +
> +	/* Nothing to do for a raw operation */
> +	if (req->mode == MTD_OPS_RAW)
> +		return 0;
> +
> +	/* This engine does not provide BBM/free OOB bytes protection */
> +	if (!req->datalen)
> +		return 0;
> +
> +	/* No more preparation for page write */
> +	if (req->type == NAND_PAGE_WRITE) {
> +		nand_ecc_restore_req(&ctx->req_ctx, req);
> +		return 0;
> +	}
> +
> +	ctx->cfg.op = ECC_DECODE;
> +	ctx->cfg.addr = ctx->buf_dma;
> +
> +	for (step = 0; step < ctx->steps; step++) {
> +		memcpy(ctx->buf, req->databuf.in + step * ctx->cfg.len,
> +		       ctx->cfg.len);
> +		mtd_ooblayout_get_eccbytes(mtd, ctx->buf + ctx->cfg.len,
> +					   req->oobbuf.in,
> +					   ctx->parity_len * step,
> +					   ctx->parity_len);
> +
> +		ret = mtk_ecc_enable(ecc, &ctx->cfg);
> +		if (ret)
> +			break;
> +
> +		ret = mtk_ecc_wait_done(ecc, ECC_DECODE);
> +		if (ret)

I think that you forgot to revert the enablement here; translation:
you probably forgot to call mtk_ecc_disable(ecc).
Or is there any particular and valid reason to not do that here?

If there is, you should add a comment explaining why.

> +			break;
> +
> +		mtk_ecc_wait_idle(ecc, ECC_DECODE);
> +
> +		memcpy(req->databuf.in + step * ctx->cfg.len, ctx->buf,
> +		       ctx->cfg.len);

You can avoid breaking this line, as this results in 87 cols, which is fine.
Same for the other memcpy before that one, and all other instances.

> +		mtd_ooblayout_set_eccbytes(mtd, ctx->buf + ctx->cfg.len,
> +					   req->oobbuf.in,
> +					   ctx->parity_len * step,
> +					   ctx->parity_len);
> +		err = readl(ecc->regs + ECC_DECENUM0);
> +		err &= ecc->caps->err_mask;
> +		if (err == ecc->caps->err_mask) {
> +			// skip empty page

C-style comments please. /* */


Regards,
Angelo
