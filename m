Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468D54D3188
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 16:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiCIPQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 10:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiCIPQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:16:34 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DA41712B8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 07:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646838935; x=1678374935;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MxZDzUlCIaHYoZJmhfTEyLOV6jdwo3rvEMya55hMUPU=;
  b=U11QpmSh/I5QHRy4joHdFfTErOSecbiDKXgk55eBygmOyBemUiCLug0W
   AQ5F3I3lLCy5dyqodfJheQPvLjKKTT0SwHt6Ien6btf+gWleAz0dFFOQc
   UvMHhdE3q53zP++HOOe/FLWudRtPskA2UAW5ImyOCLz4frKJKn0fC5gu7
   BxiN0b0W9Eawi2Eu7V6+T0tqvcp80A+mJUo5R1ROEiHAQpbH+6BjSYOCp
   DmARMZJhdGuCMHn+hWxH7Kvyj/YVbpQ6nFi41EjJpockz5PHyyQ5vut4M
   a2gEn0lRt5WlWIHS8B9BehKpYICFVbe14rqtHdyIoQuBogpSX7GRFqKDh
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="315713101"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="315713101"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 07:15:34 -0800
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="632633186"
Received: from byoshina-mobl.amr.corp.intel.com (HELO [10.212.156.250]) ([10.212.156.250])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 07:15:32 -0800
Message-ID: <2e6b7905-4b9f-8615-a7f2-6b3d66e6386e@linux.intel.com>
Date:   Wed, 9 Mar 2022 09:15:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH V0 1/1] ASoC: msm: fix integer overflow for long duration
 offload playback
Content-Language: en-US
To:     =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Raghu Bankapur <quic_rbankapu@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krishna Jha <quic_kkishorj@quicinc.com>,
        Raghu Bankapur <quic_rbankapu@quiinc.com>
References: <cover.1646835508.git.quic_rbankapu@quicinc.com>
 <b906dbaf772d0152a3af52d639b090d15fe8c362.1646835508.git.quic_rbankapu@quicinc.com>
 <37933410-1bc7-3e27-50e8-3da03e8b5603@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <37933410-1bc7-3e27-50e8-3da03e8b5603@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/9/22 08:51, Amadeusz Sławiński wrote:
> On 3/9/2022 3:22 PM, Raghu Bankapur wrote:
>> From: Raghu Bankapur <quic_rbankapu@quiinc.com>
>>
>> 32 bit variable is used for storing number of bytes copied to DSP,
>> which can overflow when playback duration goes beyond 24 hours.
>> Change data type for this variable to uint64_t to prevent overflow
>> and related playback anomaly.
>>
>> Signed-off-by: Raghu Bankapur <quic_rbankapu@quicinc.com>
>> ---
>>   include/uapi/sound/compress_offload.h | 2 +-
>>   sound/core/compress_offload.c         | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/uapi/sound/compress_offload.h 
>> b/include/uapi/sound/compress_offload.h
>> index 9555f31c8425..57d24d89b2f4 100644
>> --- a/include/uapi/sound/compress_offload.h
>> +++ b/include/uapi/sound/compress_offload.h
>> @@ -67,7 +67,7 @@ struct snd_compr_params {
>>    */
>>   struct snd_compr_tstamp {
>>       __u32 byte_offset;
>> -    __u32 copied_total;
>> +    __u64 copied_total;
>>       __u32 pcm_frames;
>>       __u32 pcm_io_frames;
>>       __u32 sampling_rate;
> 
> I don't think this patch should be merged as is. It changes UAPI header, 
> most likely breaking existing user space tools. Can't overflow be 
> handled somehow instead?
> 
> Although having looked around, it makes a bit of sense, as 
> snd_compr_update_tstamp() copies tstamp->copied_total to 64 bit 
> variables...
> 
> Perhaps raise protocol version? ( 
> https://elixir.bootlin.com/linux/latest/source/include/uapi/sound/compress_offload.h#L34 
> )

This change sounded familiar, and sure enough we've already discussed 
this in 2019. I thought we did change things but unfortunately no, the 
problem is still there.

https://lore.kernel.org/alsa-devel/1560843846-4631-1-git-send-email-bgoswami@codeaurora.org/

we really want to change all the copied_total, pcm_frames and 
pcm_io_frames to u64 and add a new IOCTL.

