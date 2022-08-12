Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFDD591218
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 16:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239196AbiHLOUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 10:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238926AbiHLOU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 10:20:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985BF5F90
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660314027; x=1691850027;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OkUbhSgIkeI+/eU5o8yAVjk2Zv4m5YMC7a1X0vCfvDQ=;
  b=gRBEsP7s+puLNbicmPf2X5AayD7eol6S3oGZvPhiaefyrqbsWUINBFcY
   msZiPPjI2tkVXLdA8iUusmewLW3SOCXPhRzTBSANoj5N7eaI9sjrBOmHf
   1OjWoPQaE4LKpivK1XKEOI8C0XkGFau/koX5kpz7/jEDJO54BluiTDmcr
   rHPsquNiXX03azEwAHGpJiF7w57qo5ORqeGHrf29nRU5G7prcKwxAEH4z
   zfaVsASbwN2PnwzeeNgYMoR6Or1ghaKXFrFdSdj5jBzHvf31paqxBQNaF
   bPAyjLfcTTBQNbr2brb5IU07Bvc/+T+iKAdeFI9OsA3U74BuphkgJK12X
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="278554093"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="278554093"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 07:20:26 -0700
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="634655999"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.241.73]) ([10.99.241.73])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 07:20:24 -0700
Message-ID: <2dca1704-c04b-9c42-ce1a-51a16530af38@linux.intel.com>
Date:   Fri, 12 Aug 2022 16:20:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 07/13] ASoC: amd: add acp6.2 pdm driver dma ops
Content-Language: en-US
To:     Syed Saba kareem <Syed.SabaKareem@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, mario.limonciello@amd.com,
        Vijendar.Mukunda@amd.com
References: <20220812120731.788052-1-Syed.SabaKareem@amd.com>
 <20220812120731.788052-8-Syed.SabaKareem@amd.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20220812120731.788052-8-Syed.SabaKareem@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/2022 2:07 PM, Syed Saba kareem wrote:
> This patch adds PDM driver DMA operations for Pink Sardine Platform.
> 
> Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
> ---
>   sound/soc/amd/ps/acp62.h      |  41 +++++
>   sound/soc/amd/ps/ps-pdm-dma.c | 310 ++++++++++++++++++++++++++++++++++
>   2 files changed, 351 insertions(+)
> 
> diff --git a/sound/soc/amd/ps/acp62.h b/sound/soc/amd/ps/acp62.h
> index 563252834b09..525e8bd225a2 100644
> --- a/sound/soc/amd/ps/acp62.h
> +++ b/sound/soc/amd/ps/acp62.h
> @@ -27,6 +27,31 @@
>   #define ACP_EXT_INTR_STAT_CLEAR_MASK 0xFFFFFFFF
>   #define PDM_DMA_STAT 0x10
>   
> +#define PDM_DMA_INTR_MASK	0x10000
> +#define ACP_ERROR_STAT	29
> +#define PDM_DECIMATION_FACTOR	2
> +#define ACP_PDM_CLK_FREQ_MASK	7
> +#define ACP_WOV_MISC_CTRL_MASK	0x10
> +#define ACP_PDM_ENABLE		1
> +#define ACP_PDM_DISABLE		0
> +#define ACP_PDM_DMA_EN_STATUS	2
> +#define TWO_CH		2
> +#define DELAY_US	5
> +#define ACP_COUNTER	20000
> +
> +#define ACP_SRAM_PTE_OFFSET	0x03800000
> +#define PAGE_SIZE_4K_ENABLE	2
> +#define PDM_PTE_OFFSET		0
> +#define PDM_MEM_WINDOW_START	0x4000000
> +
> +#define CAPTURE_MIN_NUM_PERIODS     4
> +#define CAPTURE_MAX_NUM_PERIODS     4
> +#define CAPTURE_MAX_PERIOD_SIZE     8192
> +#define CAPTURE_MIN_PERIOD_SIZE     4096
> +
> +#define MAX_BUFFER (CAPTURE_MAX_PERIOD_SIZE * CAPTURE_MAX_NUM_PERIODS)
> +#define MIN_BUFFER MAX_BUFFER
> +
>   enum acp_config {
>   	ACP_CONFIG_0 = 0,
>   	ACP_CONFIG_1,
> @@ -46,6 +71,22 @@ enum acp_config {
>   	ACP_CONFIG_15,
>   };
>   
> +struct pdm_stream_instance {
> +	u16 num_pages;
> +	u16 channels;
> +	dma_addr_t dma_addr;
> +	u64 bytescount;
> +	void __iomem *acp62_base;
> +};
> +
> +union acp_pdm_dma_count {
> +	struct {
> +	u32 low;
> +	u32 high;
> +	} bcount;

Fix indentation.
Also you can remove struct name, and access fields directly, so instead 
of accessing somevariable.bcount.low, you would use somevariable.low, it 
would probably be more readable.

> +	u64 bytescount;
> +};
> +
>   struct pdm_dev_data {
>   	u32 pdm_irq;
>   	void __iomem *acp62_base;
> diff --git a/sound/soc/amd/ps/ps-pdm-dma.c b/sound/soc/amd/ps/ps-pdm-dma.c
> index bca2ac3e81f5..a98a2015015d 100644

...

> +
> +static int acp62_pdm_dma_open(struct snd_soc_component *component,
> +			      struct snd_pcm_substream *substream)
> +{
> +	struct snd_pcm_runtime *runtime;
> +	struct pdm_dev_data *adata;
> +	struct pdm_stream_instance *pdm_data;
> +	int ret;
> +
> +	runtime = substream->runtime;
> +	adata = dev_get_drvdata(component->dev);
> +	pdm_data = kzalloc(sizeof(*pdm_data), GFP_KERNEL);
> +	if (!pdm_data)
> +		return -EINVAL;
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
> +		runtime->hw = acp62_pdm_hardware_capture;
> +
> +	ret = snd_pcm_hw_constraint_integer(runtime,
> +					    SNDRV_PCM_HW_PARAM_PERIODS);
> +	if (ret < 0) {
> +		dev_err(component->dev, "set integer constraint failed\n");
> +		kfree(pdm_data);
> +		return ret;
> +	}
> +
> +	acp62_enable_pdm_interrupts(adata->acp62_base);
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
> +		adata->capture_stream = substream;
> +
> +	pdm_data->acp62_base = adata->acp62_base;
> +	runtime->private_data = pdm_data;

Should probably kfree(runtime->private_data) in acp62_pdm_dma_close(), 
otherwise won't there be a memory leak?

> +	return ret;
> +}
> +

...

