Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90914596FE2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239355AbiHQNVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240000AbiHQNUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:20:47 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95102616B
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660742445; x=1692278445;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4tTqwnbMV60vIGCw59Sd7GtuA5stS91mwE9n0lEKMgU=;
  b=BJGdRAxutNUCr44l7haQlqyw9GgFx2idCLp7Vv8I9gWmm8UggH+IXQQz
   1rWukIwghDoiyIMcFYjDNEwAkQe9Z+BUcmzWjPgfrz37yOODe5ALi6WXl
   8NnM0H5SitRg87vczB4KuJQhRKa7ItUWd5Ve8zcT/cuQ0cjW45ffCP6QH
   I+8B9UarJYFw8OhqTuW8PzbQZstDO/GH36ZatzvXNrFQAgDUCw/FbbkOk
   8Iw22HPNsCrX4LchJ590P5miMxIAH0BukQDhw80eiY5VewrqhiM3uAjF6
   liWKejNCEKJFrGDSaJ50JGlf8HxwV6lQ9IIfeQTkI0uKXljpClwOcNdwB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="275541170"
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="275541170"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 06:20:45 -0700
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="749703691"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.249.169]) ([10.99.249.169])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 06:20:43 -0700
Message-ID: <2888a74f-eb9c-cfef-1b1f-8bd81ab4bd1a@linux.intel.com>
Date:   Wed, 17 Aug 2022 15:20:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/4] ALSA: hda: Rework snd_hdac_stream_reset() to use
 macros
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
References: <20220817131137.3978523-1-amadeuszx.slawinski@linux.intel.com>
 <20220817131137.3978523-3-amadeuszx.slawinski@linux.intel.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20220817131137.3978523-3-amadeuszx.slawinski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/2022 3:11 PM, Amadeusz Sławiński wrote:
> We can use existing macros to poll and update register values instead of
> open coding the functionality.
> 
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> ---
>   sound/hda/hdac_stream.c | 27 +++++++--------------------
>   1 file changed, 7 insertions(+), 20 deletions(-)
> 
> diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
> index f3582012d22f..ce6a2f270445 100644
> --- a/sound/hda/hdac_stream.c
> +++ b/sound/hda/hdac_stream.c
> @@ -10,6 +10,7 @@
>   #include <sound/core.h>
>   #include <sound/pcm.h>
>   #include <sound/hdaudio.h>
> +#include <sound/hdaudio_ext.h>

Eh... and this include addition should not be necessary after I moved 
macros in previous patch. I will wait if there are any other comments 
and send v2 tomorrow.

>   #include <sound/hda_register.h>
>   #include "trace.h"
>   
> @@ -165,7 +166,6 @@ EXPORT_SYMBOL_GPL(snd_hdac_stop_streams_and_chip);
>   void snd_hdac_stream_reset(struct hdac_stream *azx_dev)
>   {
>   	unsigned char val;
> -	int timeout;
>   	int dma_run_state;
>   
>   	snd_hdac_stream_clear(azx_dev);
> @@ -173,30 +173,17 @@ void snd_hdac_stream_reset(struct hdac_stream *azx_dev)
>   	dma_run_state = snd_hdac_stream_readb(azx_dev, SD_CTL) & SD_CTL_DMA_START;
>   
>   	snd_hdac_stream_updateb(azx_dev, SD_CTL, 0, SD_CTL_STREAM_RESET);
> -	udelay(3);
> -	timeout = 300;
> -	do {
> -		val = snd_hdac_stream_readb(azx_dev, SD_CTL) &
> -			SD_CTL_STREAM_RESET;
> -		if (val)
> -			break;
> -	} while (--timeout);
> +
> +	/* wait for hardware to report that the stream entered reset */
> +	snd_hdac_stream_readb_poll(azx_dev, SD_CTL, val, (val & SD_CTL_STREAM_RESET), 3, 300);
>   
>   	if (azx_dev->bus->dma_stop_delay && dma_run_state)
>   		udelay(azx_dev->bus->dma_stop_delay);
>   
> -	val &= ~SD_CTL_STREAM_RESET;
> -	snd_hdac_stream_writeb(azx_dev, SD_CTL, val);
> -	udelay(3);
> +	snd_hdac_stream_updateb(azx_dev, SD_CTL, SD_CTL_STREAM_RESET, 0);
>   
> -	timeout = 300;
> -	/* waiting for hardware to report that the stream is out of reset */
> -	do {
> -		val = snd_hdac_stream_readb(azx_dev, SD_CTL) &
> -			SD_CTL_STREAM_RESET;
> -		if (!val)
> -			break;
> -	} while (--timeout);
> +	/* wait for hardware to report that the stream is out of reset */
> +	snd_hdac_stream_readb_poll(azx_dev, SD_CTL, val, !(val & SD_CTL_STREAM_RESET), 3, 300);
>   
>   	/* reset first position - may not be synced with hw at this time */
>   	if (azx_dev->posbuf)

