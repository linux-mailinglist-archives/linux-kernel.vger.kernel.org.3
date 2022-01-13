Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0703448DDC4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 19:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237580AbiAMSip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 13:38:45 -0500
Received: from mga14.intel.com ([192.55.52.115]:35394 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237575AbiAMSip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 13:38:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642099125; x=1673635125;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=iL2fgWOOuJEzuniZ3WuPssSOffY8aRg6eYScK3p39JQ=;
  b=YB//WWw8SE2zsKvIEOCasb8Ah5FlhF154xAzXs4G8MflA5CRHNDmJPV/
   OyS9ZQntZn+vu+Ou6+KvF52m5D8e176tK5kftE4mwzAIen1gj4Q87C3bZ
   VWtuAjB4JK92oVJDixMhz8s68FdNAYirFyYTefgJEzsixW02QWOlzpZqO
   NwKJ7IxyJ+X2bBmaGKjeLya3LX/dRKZIGtmV7aDrPiYWYSEkZzQ881az+
   ebP9plf4JCuBXxX7o081go5vSqW07t0mRrACZE02qksdYEwFOFYM6RYWr
   126Zcby++IolbgAdAMfudurpjREFd83ihgjowM9+oIPJqBFJs0ETHucHA
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="244290415"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="244290415"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 10:38:44 -0800
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="620699902"
Received: from ypchen-mobl.amr.corp.intel.com (HELO [10.212.66.70]) ([10.212.66.70])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 10:38:44 -0800
Subject: Re: [PATCH v2 1/6] ASoC: amd: acp: Add generic support for PDM
 controller on ACP
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        V sujith kumar Reddy <vsujithkumar.reddy@amd.com>,
        Arnd Bergmann <arnd@arndb.de>, Vijendar.Mukunda@amd.com,
        Alexander.Deucher@amd.com
References: <20220113163348.434108-1-AjitKumar.Pandey@amd.com>
 <20220113163348.434108-2-AjitKumar.Pandey@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7d79a8a7-b9b5-8a0c-a140-810bc647927c@linux.intel.com>
Date:   Thu, 13 Jan 2022 12:34:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220113163348.434108-2-AjitKumar.Pandey@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

couple of nit-picks:


> diff --git a/sound/soc/amd/acp/acp-pdm.c b/sound/soc/amd/acp/acp-pdm.c
> new file mode 100644
> index 000000000000..cb9bbd795eee
> --- /dev/null
> +++ b/sound/soc/amd/acp/acp-pdm.c
> @@ -0,0 +1,181 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> +//
> +// This file is provided under a dual BSD/GPLv2 license. When using or
> +// redistributing this file, you may do so under either license.
> +//
> +// Copyright(c) 2021 Advanced Micro Devices, Inc.

2022?

> +//
> +// Authors: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
> +//	    Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> +//
> +
> +/*
> + * Generic Hardware interface for ACP Audio PDM controller
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dai.h>
> +#include <linux/dma-mapping.h>

alphabetical order?

> +
> +#include "amd.h"
> +
> +#define DRV_NAME "acp-pdm"
> +
> +#define PDM_DMA_STAT		0x10
> +#define PDM_DMA_INTR_MASK	0x10000
> +#define PDM_DEC_64		0x2
> +#define PDM_CLK_FREQ_MASK	0x07
> +#define PDM_MISC_CTRL_MASK	0x10
> +#define PDM_ENABLE		0x01
> +#define PDM_DISABLE		0x00
> +#define DMA_EN_MASK		0x02
> +#define DELAY_US		5
> +#define PDM_TIMEOUT		1000
> +
> +static int acp_dmic_dai_trigger(struct snd_pcm_substream *substream,
> +			       int cmd, struct snd_soc_dai *dai)
> +{
> +	struct acp_stream *stream = substream->runtime->private_data;
> +	struct device *dev = dai->component->dev;
> +	struct acp_dev_data *adata = dev_get_drvdata(dev);
> +	u32 physical_addr, size_dmic, period_bytes;
> +	unsigned int dma_enable;
> +	int ret = 0;
> +
> +	period_bytes = frames_to_bytes(substream->runtime,
> +			substream->runtime->period_size);
> +	size_dmic = frames_to_bytes(substream->runtime,
> +			substream->runtime->buffer_size);
> +
> +	physical_addr = stream->reg_offset + MEM_WINDOW_START;
> +
> +	/* Init DMIC Ring buffer */
> +	writel(physical_addr, adata->acp_base + ACP_WOV_RX_RINGBUFADDR);
> +	writel(size_dmic, adata->acp_base + ACP_WOV_RX_RINGBUFSIZE);
> +	writel(period_bytes, adata->acp_base + ACP_WOV_RX_INTR_WATERMARK_SIZE);
> +	writel(0x01, adata->acp_base + ACPAXI2AXI_ATU_CTRL);

could this be done in a .prepare step?

> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		dma_enable = readl(adata->acp_base + ACP_WOV_PDM_DMA_ENABLE);
> +		if (!(dma_enable & DMA_EN_MASK)) {
> +			writel(PDM_ENABLE, adata->acp_base + ACP_WOV_PDM_ENABLE);
> +			writel(PDM_ENABLE, adata->acp_base + ACP_WOV_PDM_DMA_ENABLE);
> +		}
> +
> +		ret = readl_poll_timeout_atomic(adata->acp_base + ACP_WOV_PDM_DMA_ENABLE,
> +						dma_enable, (dma_enable & DMA_EN_MASK),
> +						DELAY_US, PDM_TIMEOUT);
> +		break;
> +	case SNDRV_PCM_TRIGGER_STOP:
> +	case SNDRV_PCM_TRIGGER_SUSPEND:
> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +		dma_enable = readl(adata->acp_base + ACP_WOV_PDM_DMA_ENABLE);
> +		if ((dma_enable & DMA_EN_MASK)) {
> +			writel(PDM_DISABLE, adata->acp_base + ACP_WOV_PDM_ENABLE);
> +			writel(PDM_DISABLE, adata->acp_base + ACP_WOV_PDM_DMA_ENABLE);
> +
> +		}
> +
> +		ret = readl_poll_timeout_atomic(adata->acp_base + ACP_WOV_PDM_DMA_ENABLE,
> +						dma_enable, !(dma_enable & DMA_EN_MASK),
> +						DELAY_US, PDM_TIMEOUT);

is the _atomic needed?

> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int acp_dmic_hwparams(struct snd_pcm_substream *substream,
> +	struct snd_pcm_hw_params *hwparams, struct snd_soc_dai *dai)
> +{
> +	struct device *dev = dai->component->dev;
> +	struct acp_dev_data *adata = dev_get_drvdata(dev);
> +	unsigned int dmic_ctrl, channels, ch_mask;
> +
> +	/* Enable default DMIC clk */
> +	writel(PDM_CLK_FREQ_MASK, adata->acp_base + ACP_WOV_CLK_CTRL);
> +	dmic_ctrl = readl(adata->acp_base + ACP_WOV_MISC_CTRL);
> +	dmic_ctrl |= PDM_MISC_CTRL_MASK;
> +	writel(dmic_ctrl, adata->acp_base + ACP_WOV_MISC_CTRL);

.hw_params can be called multiple times, should this clock handling be
done in a .prepare step?

Or alternatively in .startup - this doesn't seem to depend on hardware
parameters?

> +
> +	channels = params_channels(hwparams);
> +	switch (channels) {
> +	case 2:
> +		ch_mask = 0;
> +		break;
> +	case 4:
> +		ch_mask = 1;
> +		break;
> +	case 6:
> +		ch_mask = 2;
> +		break;
> +	default:
> +		dev_err(dev, "Invalid channels %d\n", channels);
> +		return -EINVAL;
> +	}
> +
> +	if (params_format(hwparams) != SNDRV_PCM_FORMAT_S32_LE) {
> +		dev_err(dai->dev, "Invalid format:%d\n", params_format(hwparams));
> +		return -EINVAL;
> +	}
> +
> +	writel(ch_mask, adata->acp_base + ACP_WOV_PDM_NO_OF_CHANNELS);
> +	writel(PDM_DEC_64, adata->acp_base + ACP_WOV_PDM_DECIMATION_FACTOR);
> +
> +	return 0;
> +}

> +MODULE_LICENSE("GPL v2");

"GPL" is enough


