Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADE95448DC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242896AbiFIK10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242762AbiFIK1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:27:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E0E202D2F;
        Thu,  9 Jun 2022 03:27:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECEF661D3A;
        Thu,  9 Jun 2022 10:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EABAC34114;
        Thu,  9 Jun 2022 10:27:07 +0000 (UTC)
Message-ID: <ca006530-b20b-f97c-af68-5f0191478f96@xs4all.nl>
Date:   Thu, 9 Jun 2022 12:27:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] media: imx-jpeg: Disable slot interrupt when frame done
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        mirela.rabulea@oss.nxp.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220607072315.23209-1-ming.qian@nxp.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220607072315.23209-1-ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming Qian,

On 6/7/22 09:23, Ming Qian wrote:
> The interrupt STMBUF_HALF may be triggered after frame done.
> It may led to system hang if driver try to access the register after
> power off.
> 
> Disable the slot interrupt when frame done.
> 
> Fixes: 2db16c6ed72ce ("media: imx-jpeg: Add V4L2 driver for i.MX8 JPEG Encoder/Decoder")
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>  drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c |  5 +++++
>  drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h |  1 +
>  drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 11 ++---------
>  3 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
> index c482228262a3..9418fcf740a8 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
> @@ -79,6 +79,11 @@ void mxc_jpeg_enable_irq(void __iomem *reg, int slot)
>  	writel(0xFFFFFFFF, reg + MXC_SLOT_OFFSET(slot, SLOT_IRQ_EN));
>  }
>  
> +void mxc_jpeg_disable_irq(void __iomem *reg, int slot)
> +{
> +	writel(0x0, reg + MXC_SLOT_OFFSET(slot, SLOT_IRQ_EN));
> +}
> +
>  void mxc_jpeg_sw_reset(void __iomem *reg)
>  {
>  	/*
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
> index 07655502f4bd..ecf3b6562ba2 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
> @@ -126,6 +126,7 @@ u32 mxc_jpeg_get_offset(void __iomem *reg, int slot);
>  void mxc_jpeg_enable_slot(void __iomem *reg, int slot);
>  void mxc_jpeg_set_l_endian(void __iomem *reg, int le);
>  void mxc_jpeg_enable_irq(void __iomem *reg, int slot);
> +void mxc_jpeg_disable_irq(void __iomem *reg, int slot);
>  int mxc_jpeg_set_input(void __iomem *reg, u32 in_buf, u32 bufsize);
>  int mxc_jpeg_set_output(void __iomem *reg, u16 out_pitch, u32 out_buf,
>  			u16 w, u16 h);
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> index 965021d3c7ef..b1f48835398e 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> @@ -592,15 +592,7 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
>  	dev_dbg(dev, "Irq %d on slot %d.\n", irq, slot);
>  
>  	ctx = v4l2_m2m_get_curr_priv(jpeg->m2m_dev);
> -	if (!ctx) {
> -		dev_err(dev,
> -			"Instance released before the end of transaction.\n");
> -		/* soft reset only resets internal state, not registers */
> -		mxc_jpeg_sw_reset(reg);
> -		/* clear all interrupts */
> -		writel(0xFFFFFFFF, reg + MXC_SLOT_OFFSET(slot, SLOT_STATUS));
> -		goto job_unlock;
> -	}
> +	WARN_ON(!ctx);

This looks very scary, since if this happens,

>  
>  	if (slot != ctx->slot) {

then it will crash here when it attempts to access ctx.

Shouldn't this be better?

	if (WARN_ON(!ctx))
		goto job_unlock;

It's certainly a lot more robust.

Regards,

	Hans

>  		/* TODO investigate when adding multi-instance support */
> @@ -673,6 +665,7 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
>  	buf_state = VB2_BUF_STATE_DONE;
>  
>  buffers_done:
> +	mxc_jpeg_disable_irq(reg, ctx->slot);
>  	jpeg->slot_data[slot].used = false; /* unused, but don't free */
>  	mxc_jpeg_check_and_set_last_buffer(ctx, src_buf, dst_buf);
>  	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
