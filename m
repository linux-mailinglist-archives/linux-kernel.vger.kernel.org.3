Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBBA463420
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241537AbhK3MYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241536AbhK3MXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:23:54 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E9CC061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 04:20:35 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id j14so40798834uan.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 04:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1ujyhkOvhZ/kn/EYuuMP69Y9Kl5Rfhh28pCEODUUTUw=;
        b=TDL1Jnm+i7rMI3JPan6whzMZuH9BqyfVzBTAbtrBjHjMsn4/bmlYsdCHDFZ32kCYKW
         Hs7pfxAPXtX72xorhXY6u7BfaRMG/F5q3IeylpBtakiOlsqxQZd2AbLZMEzSgBjOzd1E
         kiHMT3PKUuLn+ocVUTbdCB7WCRy/uV+L8su/Wrr+x+jTyhAxEpK3Hmd0wpREVKoJAip3
         V6WdhBdnqc1uE3dKDxP8GlVjLfFxsHqCkhnfYOOXgviLAAkPUlvpp7jAPdOhYHuIto54
         UQVk6FEXAhZSHfuBS2bqACxYf0ZQLdNjSJqB1W4MLmGE4D5QVBsHpRsp9/VVV2trxk6r
         GzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1ujyhkOvhZ/kn/EYuuMP69Y9Kl5Rfhh28pCEODUUTUw=;
        b=D3RT+sYhBcGjft50ojIGgNgb16LkeqwNR9oKiBXHPrfo9i1zOVxWU1G7+r7qwE7MQm
         c6nA09m67Nm6/pd+y6YLWXToweKyOfaiVJyCfJNhY/z5shgavCljUo91bvJQltu9B6pO
         dA8OPWB02jn+D6t8ysB6Si0UEixKHvJxYoqKZWH87YnmWsNRLrKuvVirdUpDH1kzlFp3
         aRIxF31RCSmZeXsw/D6T4Ve3oct9/MTngGWeXSMiB6yPBL1tluBg8ZnC+cFeiNynj6AL
         l093pdB5QPPolwqLERwx5Xd7mkWomL4zri7Ie45WPDTTBmTMge9nRk83jMRLTiHr16pP
         NZPw==
X-Gm-Message-State: AOAM533tG2sfF0or7HK5WWhBwdo6f+1zQjyfO8jPBc37L7wwlDa4Fx6h
        RBbTnDn4CLLKBX5JoQx3zpu7wg==
X-Google-Smtp-Source: ABdhPJx5S2Jj7XzelHbH7Z+x2bLpGTgFk4TmBKFZ6CJekTj133gVTp88B6hZSlYFXqAP+Yth7WSoRQ==
X-Received: by 2002:a05:6102:ec6:: with SMTP id m6mr39022285vst.50.1638274834536;
        Tue, 30 Nov 2021 04:20:34 -0800 (PST)
Received: from eze-laptop (host208.201-253-22.telecom.net.ar. [201.253.22.208])
        by smtp.gmail.com with ESMTPSA id e13sm9804329vkd.21.2021.11.30.04.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 04:20:33 -0800 (PST)
Date:   Tue, 30 Nov 2021 09:20:28 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     linux-media@vger.kernel.org, nicolas.dufresne@collabora.com,
        mchehab@kernel.org, robh+dt@kernel.org, mripard@kernel.org,
        wens@csie.org, p.zabel@pengutronix.de, andrzej.p@collabora.com,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 6/9] media: hantro: Convert imx8m_vpu_g2_irq to helper
Message-ID: <YaYXDLumCr7BfzMR@eze-laptop>
References: <20211129182633.480021-1-jernej.skrabec@gmail.com>
 <20211129182633.480021-7-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129182633.480021-7-jernej.skrabec@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 07:26:30PM +0100, Jernej Skrabec wrote:
> It turns out that imx8m_vpu_g2_irq() doesn't depend on any platform
> specifics and can be used with other G2 platform drivers too.
> 
> Move it to common code.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Thanks!

> ---
>  drivers/staging/media/hantro/hantro_g2.c    | 18 ++++++++++++++++++
>  drivers/staging/media/hantro/hantro_hw.h    |  1 +
>  drivers/staging/media/hantro/imx8m_vpu_hw.c | 20 +-------------------
>  3 files changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/staging/media/hantro/hantro_g2.c b/drivers/staging/media/hantro/hantro_g2.c
> index 6f3e1f797f83..ee5f14c5f8f2 100644
> --- a/drivers/staging/media/hantro/hantro_g2.c
> +++ b/drivers/staging/media/hantro/hantro_g2.c
> @@ -24,3 +24,21 @@ void hantro_g2_check_idle(struct hantro_dev *vpu)
>  		}
>  	}
>  }
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
>  int hantro_vp9_dec_init(struct hantro_ctx *ctx);
>  void hantro_vp9_dec_exit(struct hantro_ctx *ctx);
>  void hantro_g2_check_idle(struct hantro_dev *vpu);
> +irqreturn_t hantro_g2_irq(int irq, void *dev_id);
>  
>  #endif /* HANTRO_HW_H_ */
> diff --git a/drivers/staging/media/hantro/imx8m_vpu_hw.c b/drivers/staging/media/hantro/imx8m_vpu_hw.c
> index 1a43f6fceef9..f5991b8e553a 100644
> --- a/drivers/staging/media/hantro/imx8m_vpu_hw.c
> +++ b/drivers/staging/media/hantro/imx8m_vpu_hw.c
> @@ -191,24 +191,6 @@ static irqreturn_t imx8m_vpu_g1_irq(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
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
>  static int imx8mq_vpu_hw_init(struct hantro_dev *vpu)
>  {
>  	vpu->ctrl_base = vpu->reg_bases[vpu->variant->num_regs - 1];
> @@ -280,7 +262,7 @@ static const struct hantro_irq imx8mq_irqs[] = {
>  };
>  
>  static const struct hantro_irq imx8mq_g2_irqs[] = {
> -	{ "g2", imx8m_vpu_g2_irq },
> +	{ "g2", hantro_g2_irq },
>  };
>  
>  static const char * const imx8mq_clk_names[] = { "g1", "g2", "bus" };
> -- 
> 2.34.1
> 
