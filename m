Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C26467840
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381023AbhLCNct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381004AbhLCNcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:32:47 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0C0C061758
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 05:29:23 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id u1so5667194wru.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 05:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lZAJRTTgqmvVZ9uC+yTIsPzDRzkdEcdtzUS0sNflocA=;
        b=NF/kdZXuMJcQ/C0BWQvZi620UcGgTfL5lk8A5YqSFqFvCJg+NuFb3qgHoEUfdh5Jzw
         +dyGa8wDAgRVfJMx1i1ZV76qB0guwDrdojG2T96Mwj9bNFDViVZjBWOd8qb80ygbfYpr
         denHHNfi7GMi8aSOp3qpWfFtNvBKILfQEvXc2ayuKiD+1ExyNT71HeXV+/LKrqzoIru0
         +rsEGfpLjK/vDWt3mlyUrTfha+4KNr8zcqwhmclHnMMIfRRrEYhQsiGY2iDynU3lj9xx
         x4nit280nqzE686QHNR93aVIkPUIplHMfF0kry9FIzXvKWAR0MF6A5wpInaEY0jLnfpm
         3YKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lZAJRTTgqmvVZ9uC+yTIsPzDRzkdEcdtzUS0sNflocA=;
        b=IMCsMpxtdVsSF7uL+sNJj/JgEh/PpKrFgT9X3yg7LcGazkJls+T2T9cBUZnOLOLBxf
         S95CncvngkBgHivibaDYkDtJMJKGxdLNuoHM2MEl2We1CvbQL7t+e4L+Q5+mw7Ef1a9D
         A5ATNydLV0xWosqDDdBNpz2etAHhllyu9KeipGpBiAy4Ur5/7kL3uoeBaX7yfueapVOX
         r+VQej9EWe78/fZHMNuO2cIJa2eGp9jV6iX7R7zFg8Ng9j5uPeyrjhDWnxkdgGXYtd6q
         tHQL8UYYwSskP5MuRkYXypasKWomCE0a4hobR0osydHseKGaRmjdTNkui4LhLqB6sx95
         bdyQ==
X-Gm-Message-State: AOAM532lHetoMr/nQPpNovi4ChMcW5smai9Lguf3eCfT5s3q0E1JAe3P
        hbWX32a5WEEzEjCJNIBtz7mVJw==
X-Google-Smtp-Source: ABdhPJyjzr2jYtJtPZBX2IihBdqk1/sZovUePRqug9URP0D6B18KSFa+28BHFthtSUotI4Pfa7zlHw==
X-Received: by 2002:adf:9bdb:: with SMTP id e27mr21999145wrc.417.1638538161831;
        Fri, 03 Dec 2021 05:29:21 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id m36sm2691670wms.25.2021.12.03.05.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 05:29:21 -0800 (PST)
Subject: Re: [PATCH v7 07/10] ASoC: qcom: Add regmap config support for codec
 dma driver
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.com>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org
Cc:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        Venkata Prasad Potturu <potturu@codeaurora.org>
References: <1638459806-27600-1-git-send-email-srivasam@codeaurora.com>
 <1638459806-27600-8-git-send-email-srivasam@codeaurora.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <ae65e6f4-a7ca-6b4e-6376-9af01eaa97f8@linaro.org>
Date:   Fri, 3 Dec 2021 13:29:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1638459806-27600-8-git-send-email-srivasam@codeaurora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/12/2021 15:43, Srinivasa Rao Mandadapu wrote:
> From: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> 
> Update regmap configuration for supporting headset playback and
> capture and DMIC capture using codec dma interface
> 
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> Co-developed-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>


LGTM,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   sound/soc/qcom/lpass-cpu.c | 185 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 185 insertions(+)
> 
> diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
> index 81818f0..a5a46bc 100644
> --- a/sound/soc/qcom/lpass-cpu.c
> +++ b/sound/soc/qcom/lpass-cpu.c
> @@ -28,6 +28,8 @@
>   #define LPASS_CPU_I2S_SD2_3_MASK	GENMASK(3, 2)
>   #define LPASS_CPU_I2S_SD0_1_2_MASK	GENMASK(2, 0)
>   #define LPASS_CPU_I2S_SD0_1_2_3_MASK	GENMASK(3, 0)
> +#define LPASS_REG_READ 1
> +#define LPASS_REG_WRITE 0
>   
>   /*
>    * Channel maps for Quad channel playbacks on MI2S Secondary
> @@ -798,6 +800,189 @@ static struct regmap_config lpass_hdmi_regmap_config = {
>   	.cache_type = REGCACHE_FLAT,
>   };
>   
> +static bool __lpass_rxtx_regmap_accessible(struct device *dev, unsigned int reg, bool rw)
> +{
> +	struct lpass_data *drvdata = dev_get_drvdata(dev);
> +	struct lpass_variant *v = drvdata->variant;
> +	int i;
> +
> +	for (i = 0; i < v->rxtx_irq_ports; ++i) {
> +		if (reg == LPAIF_RXTX_IRQCLEAR_REG(v, i))
> +			return true;
> +		if (reg == LPAIF_RXTX_IRQEN_REG(v, i))
> +			return true;
> +		if (reg == LPAIF_RXTX_IRQSTAT_REG(v, i))
> +			return true;
> +	}
> +
> +	for (i = 0; i < v->rxtx_rdma_channels; ++i) {
> +		if (reg == LPAIF_CDC_RXTX_RDMACTL_REG(v, i, LPASS_CDC_DMA_RX0))
> +			return true;
> +		if (reg == LPAIF_CDC_RXTX_RDMABASE_REG(v, i, LPASS_CDC_DMA_RX0))
> +			return true;
> +		if (reg == LPAIF_CDC_RXTX_RDMABUFF_REG(v, i, LPASS_CDC_DMA_RX0))
> +			return true;
> +		if (rw == LPASS_REG_READ) {
> +			if (reg == LPAIF_CDC_RXTX_RDMACURR_REG(v, i, LPASS_CDC_DMA_RX0))
> +				return true;
> +		}
> +		if (reg == LPAIF_CDC_RXTX_RDMAPER_REG(v, i, LPASS_CDC_DMA_RX0))
> +			return true;
> +		if (reg == LPAIF_CDC_RXTX_RDMA_INTF_REG(v, i, LPASS_CDC_DMA_RX0))
> +			return true;
> +	}
> +
> +	for (i = 0; i < v->rxtx_wrdma_channels; ++i) {
> +		if (reg == LPAIF_CDC_RXTX_WRDMACTL_REG(v, i + v->rxtx_wrdma_channel_start,
> +							LPASS_CDC_DMA_TX3))
> +			return true;
> +		if (reg == LPAIF_CDC_RXTX_WRDMABASE_REG(v, i + v->rxtx_wrdma_channel_start,
> +							LPASS_CDC_DMA_TX3))
> +			return true;
> +		if (reg == LPAIF_CDC_RXTX_WRDMABUFF_REG(v, i + v->rxtx_wrdma_channel_start,
> +							LPASS_CDC_DMA_TX3))
> +			return true;
> +		if (rw == LPASS_REG_READ) {
> +			if (reg == LPAIF_CDC_RXTX_WRDMACURR_REG(v, i, LPASS_CDC_DMA_RX0))
> +				return true;
> +		}
> +		if (reg == LPAIF_CDC_RXTX_WRDMAPER_REG(v, i + v->rxtx_wrdma_channel_start,
> +							LPASS_CDC_DMA_TX3))
> +			return true;
> +		if (reg == LPAIF_CDC_RXTX_WRDMA_INTF_REG(v, i + v->rxtx_wrdma_channel_start,
> +							LPASS_CDC_DMA_TX3))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static bool lpass_rxtx_regmap_writeable(struct device *dev, unsigned int reg)
> +{
> +	return __lpass_rxtx_regmap_accessible(dev, reg, LPASS_REG_WRITE);
> +}
> +
> +static bool lpass_rxtx_regmap_readable(struct device *dev, unsigned int reg)
> +{
> +	return __lpass_rxtx_regmap_accessible(dev, reg, LPASS_REG_READ);
> +}
> +
> +static bool lpass_rxtx_regmap_volatile(struct device *dev, unsigned int reg)
> +{
> +	struct lpass_data *drvdata = dev_get_drvdata(dev);
> +	struct lpass_variant *v = drvdata->variant;
> +	int i;
> +
> +	for (i = 0; i < v->rxtx_irq_ports; ++i) {
> +		if (reg == LPAIF_RXTX_IRQCLEAR_REG(v, i))
> +			return true;
> +		if (reg == LPAIF_RXTX_IRQSTAT_REG(v, i))
> +			return true;
> +	}
> +
> +	for (i = 0; i < v->rxtx_rdma_channels; ++i)
> +		if (reg == LPAIF_CDC_RXTX_RDMACURR_REG(v, i, LPASS_CDC_DMA_RX0))
> +			return true;
> +
> +	for (i = 0; i < v->rxtx_wrdma_channels; ++i)
> +		if (reg == LPAIF_CDC_RXTX_WRDMACURR_REG(v, i + v->rxtx_wrdma_channel_start,
> +							LPASS_CDC_DMA_TX3))
> +			return true;
> +
> +	return false;
> +}
> +
> +static bool __lpass_va_regmap_accessible(struct device *dev, unsigned int reg, bool rw)
> +{
> +	struct lpass_data *drvdata = dev_get_drvdata(dev);
> +	struct lpass_variant *v = drvdata->variant;
> +	int i;
> +
> +	for (i = 0; i < v->va_irq_ports; ++i) {
> +		if (reg == LPAIF_VA_IRQCLEAR_REG(v, i))
> +			return true;
> +		if (reg == LPAIF_VA_IRQEN_REG(v, i))
> +			return true;
> +		if (reg == LPAIF_VA_IRQSTAT_REG(v, i))
> +			return true;
> +	}
> +
> +	for (i = 0; i < v->va_wrdma_channels; ++i) {
> +		if (reg == LPAIF_CDC_VA_WRDMACTL_REG(v, i + v->va_wrdma_channel_start,
> +							LPASS_CDC_DMA_VA_TX0))
> +			return true;
> +		if (reg == LPAIF_CDC_VA_WRDMABASE_REG(v, i + v->va_wrdma_channel_start,
> +							LPASS_CDC_DMA_VA_TX0))
> +			return true;
> +		if (reg == LPAIF_CDC_VA_WRDMABUFF_REG(v, i + v->va_wrdma_channel_start,
> +							LPASS_CDC_DMA_VA_TX0))
> +			return true;
> +		if (rw == LPASS_REG_READ) {
> +			if (reg == LPAIF_CDC_VA_WRDMACURR_REG(v, i + v->va_wrdma_channel_start,
> +							LPASS_CDC_DMA_VA_TX0))
> +				return true;
> +		}
> +		if (reg == LPAIF_CDC_VA_WRDMAPER_REG(v, i + v->va_wrdma_channel_start,
> +							LPASS_CDC_DMA_VA_TX0))
> +			return true;
> +		if (reg == LPAIF_CDC_VA_WRDMA_INTF_REG(v, i + v->va_wrdma_channel_start,
> +							LPASS_CDC_DMA_VA_TX0))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static bool lpass_va_regmap_writeable(struct device *dev, unsigned int reg)
> +{
> +	return __lpass_va_regmap_accessible(dev, reg, LPASS_REG_WRITE);
> +}
> +
> +static bool lpass_va_regmap_readable(struct device *dev, unsigned int reg)
> +{
> +	return __lpass_va_regmap_accessible(dev, reg, LPASS_REG_READ);
> +}
> +
> +static bool lpass_va_regmap_volatile(struct device *dev, unsigned int reg)
> +{
> +	struct lpass_data *drvdata = dev_get_drvdata(dev);
> +	struct lpass_variant *v = drvdata->variant;
> +	int i;
> +
> +	for (i = 0; i < v->va_irq_ports; ++i) {
> +		if (reg == LPAIF_VA_IRQCLEAR_REG(v, i))
> +			return true;
> +		if (reg == LPAIF_VA_IRQSTAT_REG(v, i))
> +			return true;
> +	}
> +
> +	for (i = 0; i < v->va_wrdma_channels; ++i) {
> +		if (reg == LPAIF_CDC_VA_WRDMACURR_REG(v, i + v->va_wrdma_channel_start,
> +							LPASS_CDC_DMA_VA_TX0))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static struct regmap_config lpass_rxtx_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.writeable_reg = lpass_rxtx_regmap_writeable,
> +	.readable_reg = lpass_rxtx_regmap_readable,
> +	.volatile_reg = lpass_rxtx_regmap_volatile,
> +	.cache_type = REGCACHE_FLAT,
> +};
> +
> +static struct regmap_config lpass_va_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.writeable_reg = lpass_va_regmap_writeable,
> +	.readable_reg = lpass_va_regmap_readable,
> +	.volatile_reg = lpass_va_regmap_volatile,
> +	.cache_type = REGCACHE_FLAT,
> +};
> +
>   static unsigned int of_lpass_cpu_parse_sd_lines(struct device *dev,
>   						struct device_node *node,
>   						const char *name)
> 
