Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B804D3146
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 15:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbiCIOwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 09:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiCIOwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:52:14 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A092917DBBF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 06:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646837475; x=1678373475;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mQpK9Al/CtmcglF/+fe/dahXKGKv7EP/7LIopBJNDQs=;
  b=Zn37Ck8txnR1DsPGb0Vz/23+fDhclkAZAtYYxUNg66c/3XPriqgzH6EK
   VR+nfz37fH0AKkuguVpsFUW8Czr8CLp5dgmaRkbO42CtqT2SnJjkwpfzg
   6NrPqlY+t06jhITkcTJWuuc1MkdeNMaa0/gAYYk3FIt/qh3TdPaKcU3Up
   8SKwAjpALqce4dQ8Ye00hvdcqU2+KZBYKQ8UPDqwZwhj6/yP0uePw3aRf
   /2Hlzh4yIES7kWWC8Ysnlz/yVgg/2suIYSHXSwOkakw+7aMqq/nskNK2D
   0b8YONhaJeIb72zhcgSk5kE8NRwEOWrhaeKCl3eyVRV6GHg83BFNFkEay
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="235597360"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="235597360"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 06:51:14 -0800
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="513543953"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.241.241]) ([10.99.241.241])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 06:51:12 -0800
Message-ID: <37933410-1bc7-3e27-50e8-3da03e8b5603@linux.intel.com>
Date:   Wed, 9 Mar 2022 15:51:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V0 1/1] ASoC: msm: fix integer overflow for long duration
 offload playback
Content-Language: en-US
To:     Raghu Bankapur <quic_rbankapu@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krishna Jha <quic_kkishorj@quicinc.com>,
        Raghu Bankapur <quic_rbankapu@quiinc.com>
References: <cover.1646835508.git.quic_rbankapu@quicinc.com>
 <b906dbaf772d0152a3af52d639b090d15fe8c362.1646835508.git.quic_rbankapu@quicinc.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <b906dbaf772d0152a3af52d639b090d15fe8c362.1646835508.git.quic_rbankapu@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/2022 3:22 PM, Raghu Bankapur wrote:
> From: Raghu Bankapur <quic_rbankapu@quiinc.com>
> 
> 32 bit variable is used for storing number of bytes copied to DSP,
> which can overflow when playback duration goes beyond 24 hours.
> Change data type for this variable to uint64_t to prevent overflow
> and related playback anomaly.
> 
> Signed-off-by: Raghu Bankapur <quic_rbankapu@quicinc.com>
> ---
>   include/uapi/sound/compress_offload.h | 2 +-
>   sound/core/compress_offload.c         | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/sound/compress_offload.h b/include/uapi/sound/compress_offload.h
> index 9555f31c8425..57d24d89b2f4 100644
> --- a/include/uapi/sound/compress_offload.h
> +++ b/include/uapi/sound/compress_offload.h
> @@ -67,7 +67,7 @@ struct snd_compr_params {
>    */
>   struct snd_compr_tstamp {
>   	__u32 byte_offset;
> -	__u32 copied_total;
> +	__u64 copied_total;
>   	__u32 pcm_frames;
>   	__u32 pcm_io_frames;
>   	__u32 sampling_rate;

I don't think this patch should be merged as is. It changes UAPI header, 
most likely breaking existing user space tools. Can't overflow be 
handled somehow instead?

Although having looked around, it makes a bit of sense, as 
snd_compr_update_tstamp() copies tstamp->copied_total to 64 bit variables...

Perhaps raise protocol version? ( 
https://elixir.bootlin.com/linux/latest/source/include/uapi/sound/compress_offload.h#L34 
)

> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> index de514ec8c83d..068376b586be 100644
> --- a/sound/core/compress_offload.c
> +++ b/sound/core/compress_offload.c
> @@ -169,7 +169,7 @@ static int snd_compr_update_tstamp(struct snd_compr_stream *stream,
>   	if (!stream->ops->pointer)
>   		return -ENOTSUPP;
>   	stream->ops->pointer(stream, tstamp);
> -	pr_debug("dsp consumed till %d total %d bytes\n",
> +	pr_debug("dsp consumed till %d total %llu bytes\n",
>   		tstamp->byte_offset, tstamp->copied_total);
>   	if (stream->direction == SND_COMPRESS_PLAYBACK)
>   		stream->runtime->total_bytes_transferred = tstamp->copied_total;

