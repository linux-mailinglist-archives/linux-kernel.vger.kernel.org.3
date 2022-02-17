Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAFA4BA688
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240269AbiBQQ52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:57:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236325AbiBQQ50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:57:26 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02561D224F;
        Thu, 17 Feb 2022 08:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645117031; x=1676653031;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JKdF2EclpNA26WuIFliOnCyn7NalNe0ki0eY5vSfC5Y=;
  b=HNzjpWV3OjOlvWYYa2QwdSL+Mc+hAJTyb+SrW4sQP7ovtW59rbucL+/b
   4drdC2cktutHBaN8eMmV5HoqTAg7BKCCOW9Qro5CLUgmhteZ1Ggw+zUaQ
   Av109RMuaotIGqFvkgslVQWjY8rndGCPRbgufpdIbkRZTso0lAby6YoXZ
   n215h4l9jEQ+T+1TmaPoswgE1melvuaRhZMVfeysLW0eKAk/PLDRnB1T4
   MVsMJZoynykY3fA2mPkveyF38P95Yh4cIO7as6ZwZxEJLG29/aAYtvZ6l
   +kGZVaELSZI4JJV2KCzmET3g5hEDKIZOSa+9iMK6q/YpSeIo78QMbcmQI
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="251117448"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="251117448"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 08:57:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="626135809"
Received: from mnagi-mobl.amr.corp.intel.com (HELO [10.212.55.230]) ([10.212.55.230])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 08:57:11 -0800
Message-ID: <75ab6118-6ddd-5ef6-0a12-1d2fd0253f68@linux.intel.com>
Date:   Thu, 17 Feb 2022 10:57:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH] ASoC: SOF: Replace zero-length array with flexible-array
 member
Content-Language: en-US
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Stephen Kitt <steve@sk2.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org,
        linux-hardening@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <20220217132755.1786130-1-steve@sk2.org>
 <20220217164458.GA932472@embeddedor>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220217164458.GA932472@embeddedor>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/17/22 10:44, Gustavo A. R. Silva wrote:
> On Thu, Feb 17, 2022 at 02:27:55PM +0100, Stephen Kitt wrote:
>> There is a regular need in the kernel to provide a way to declare having
>> a dynamically sized set of trailing elements in a structure. Kernel code
>> should always use "flexible array members"[1] for these cases. The older
>> style of one-element or zero-length arrays should no longer be used[2].
>>
>> This helps with the ongoing efforts to globally enable -Warray-bounds
>> and get us closer to being able to tighten the FORTIFY_SOURCE routines
>> on memcpy().
>>
>> [1] https://en.wikipedia.org/wiki/Flexible_array_member
>> [2] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
>>
>> Link: https://github.com/KSPP/linux/issues/78
>> Link: https://github.com/KSPP/linux/issues/180
>> Suggested-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> Signed-off-by: Stephen Kitt <steve@sk2.org>
> 
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks for the patch

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

I just realized we have additional cases in this directory (interface
between kernel and firmware), I'll send a follow-up patch a

channel_map.h:  int32_t ch_coeffs[0];
channel_map.h:  struct sof_ipc_channel_map ch_map[0];
control.h:              struct sof_ipc_ctrl_value_chan chanv[0];
control.h:              struct sof_ipc_ctrl_value_comp compv[0];
control.h:              struct sof_abi_hdr data[0];
control.h:              struct sof_abi_hdr data[0];

> 
> Thanks!
> --
> Gustavo
> 
>> ---
>>  include/sound/sof/topology.h | 2 +-
>>  sound/soc/sof/topology.c     | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/sound/sof/topology.h b/include/sound/sof/topology.h
>> index d12736e14b69..adee6afd1490 100644
>> --- a/include/sound/sof/topology.h
>> +++ b/include/sound/sof/topology.h
>> @@ -237,7 +237,7 @@ struct sof_ipc_comp_process {
>>  	/* reserved for future use */
>>  	uint32_t reserved[7];
>>  
>> -	uint8_t data[0];
>> +	uint8_t data[];
>>  } __packed;
>>  
>>  /* frees components, buffers and pipelines
>> diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
>> index e72dcae5e7ee..1d119d1dd69d 100644
>> --- a/sound/soc/sof/topology.c
>> +++ b/sound/soc/sof/topology.c
>> @@ -2164,7 +2164,7 @@ static int sof_process_load(struct snd_soc_component *scomp, int index,
>>  	 */
>>  	if (ipc_data_size) {
>>  		for (i = 0; i < widget->num_kcontrols; i++) {
>> -			memcpy(&process->data + offset,
>> +			memcpy(&process->data[offset],
>>  			       wdata[i].pdata->data,
>>  			       wdata[i].pdata->size);
>>  			offset += wdata[i].pdata->size;
>>
>> base-commit: f71077a4d84bbe8c7b91b7db7c4ef815755ac5e3
>> -- 
>> 2.27.0
>>
