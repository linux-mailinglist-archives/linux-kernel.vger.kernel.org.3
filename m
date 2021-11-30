Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEDAA46317C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbhK3KtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:49:19 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51744 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236057AbhK3KtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:49:18 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id B354B1F44F2D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638269158; bh=/RU/bGA0G+1VSMjZzfteTmOKhmey5jYlUnzg1C33/vY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZfqxTcNUU33RZqcVcJm1vLEobPNkx0lNf3/6QQg7TM481dUYWTKDAqgYV7wrtXiOH
         Q55F6e94R96b69VQ5M2gxQYlUSAyastL35cgW0R1I0+cSyW3PSk9VfvnO5diq7s5Ry
         tK5eQAopwYynipX5C+P7E89Ch/Lg0BKGP/A6TasmEZyCxak4iLWW039lC0oITGK090
         1KUwwGOlVLtE5ZHXJcIhVY9yvhy5P2sYoD6xbrzAwNS0V0yR/3ZYMjMNQvY3FH7B29
         Q1+XQOta+a/JDYjJoJCjWdzUDgefPCG8IruradVCLlONA7W2g2uhLRnWen2Bs1+Nt1
         p9xXSuYlfHJiA==
Subject: Re: [PATCH v2 6/9] media: hantro: Convert imx8m_vpu_g2_irq to helper
To:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-media@vger.kernel.org
Cc:     ezequiel@vanguardiasur.com.ar, nicolas.dufresne@collabora.com,
        mchehab@kernel.org, robh+dt@kernel.org, mripard@kernel.org,
        wens@csie.org, p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
References: <20211129182633.480021-1-jernej.skrabec@gmail.com>
 <20211129182633.480021-7-jernej.skrabec@gmail.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Message-ID: <eed931f4-a556-bcf2-d275-f57f6354cb28@collabora.com>
Date:   Tue, 30 Nov 2021 11:45:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211129182633.480021-7-jernej.skrabec@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

W dniu 29.11.2021 o 19:26, Jernej Skrabec pisze:
> It turns out that imx8m_vpu_g2_irq() doesn't depend on any platform
> specifics and can be used with other G2 platform drivers too.
> 
> Move it to common code.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

> ---
>   drivers/staging/media/hantro/hantro_g2.c    | 18 ++++++++++++++++++
>   drivers/staging/media/hantro/hantro_hw.h    |  1 +
>   drivers/staging/media/hantro/imx8m_vpu_hw.c | 20 +-------------------
>   3 files changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/staging/media/hantro/hantro_g2.c b/drivers/staging/media/hantro/hantro_g2.c
> index 6f3e1f797f83..ee5f14c5f8f2 100644
> --- a/drivers/staging/media/hantro/hantro_g2.c
> +++ b/drivers/staging/media/hantro/hantro_g2.c
> @@ -24,3 +24,21 @@ void hantro_g2_check_idle(struct hantro_dev *vpu)
>   		}
>   	}
>   }
> +
> +irqreturn_t hantro_g2_irq(int irq, void *dev_id)
> +{
> +	struct hantro_dev *vpu = dev_id;
> +	enum vb2_buffer_state state;
> +	u32 status;
> +
> +	status = vdpu_read(vpu, G2_REG_INTERRUPT);
> +	state = (status & G2_REG_INTERRUPT_DEC_RDY_INT) ?
> +		 VB2_BUF_STATE_DONE : VB2_BUF_STATE_ERROR;
> +
> +	vdpu_write(vpu, 0, G2_REG_INTERRUPT);
> +	vdpu_write(vpu, G2_REG_CONFIG_DEC_CLK_GATE_E, G2_REG_CONFIG);
> +
> +	hantro_irq_done(vpu, state);
> +
> +	return IRQ_HANDLED;
> +}
> diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
> index dbe51303724b..c33b1f5df37b 100644
> --- a/drivers/staging/media/hantro/hantro_hw.h
> +++ b/drivers/staging/media/hantro/hantro_hw.h
> @@ -413,5 +413,6 @@ void hantro_g2_vp9_dec_done(struct hantro_ctx *ctx);
>   int hantro_vp9_dec_init(struct hantro_ctx *ctx);
>   void hantro_vp9_dec_exit(struct hantro_ctx *ctx);
>   void hantro_g2_check_idle(struct hantro_dev *vpu);
> +irqreturn_t hantro_g2_irq(int irq, void *dev_id);
>   
>   #endif /* HANTRO_HW_H_ */
> diff --git a/drivers/staging/media/hantro/imx8m_vpu_hw.c b/drivers/staging/media/hantro/imx8m_vpu_hw.c
> index 1a43f6fceef9..f5991b8e553a 100644
> --- a/drivers/staging/media/hantro/imx8m_vpu_hw.c
> +++ b/drivers/staging/media/hantro/imx8m_vpu_hw.c
> @@ -191,24 +191,6 @@ static irqreturn_t imx8m_vpu_g1_irq(int irq, void *dev_id)
>   	return IRQ_HANDLED;
>   }
>   
> -static irqreturn_t imx8m_vpu_g2_irq(int irq, void *dev_id)
> -{
> -	struct hantro_dev *vpu = dev_id;
> -	enum vb2_buffer_state state;
> -	u32 status;
> -
> -	status = vdpu_read(vpu, G2_REG_INTERRUPT);
> -	state = (status & G2_REG_INTERRUPT_DEC_RDY_INT) ?
> -		 VB2_BUF_STATE_DONE : VB2_BUF_STATE_ERROR;
> -
> -	vdpu_write(vpu, 0, G2_REG_INTERRUPT);
> -	vdpu_write(vpu, G2_REG_CONFIG_DEC_CLK_GATE_E, G2_REG_CONFIG);
> -
> -	hantro_irq_done(vpu, state);
> -
> -	return IRQ_HANDLED;
> -}
> -
>   static int imx8mq_vpu_hw_init(struct hantro_dev *vpu)
>   {
>   	vpu->ctrl_base = vpu->reg_bases[vpu->variant->num_regs - 1];
> @@ -280,7 +262,7 @@ static const struct hantro_irq imx8mq_irqs[] = {
>   };
>   
>   static const struct hantro_irq imx8mq_g2_irqs[] = {
> -	{ "g2", imx8m_vpu_g2_irq },
> +	{ "g2", hantro_g2_irq },
>   };
>   
>   static const char * const imx8mq_clk_names[] = { "g1", "g2", "bus" };
> 

