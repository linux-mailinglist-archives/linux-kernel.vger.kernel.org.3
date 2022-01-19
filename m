Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241B0493EA3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 17:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346127AbiASQ4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 11:56:18 -0500
Received: from mga06.intel.com ([134.134.136.31]:18747 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243606AbiASQ4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 11:56:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642611376; x=1674147376;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=hvMNRV+46QTOBIdXa737oX1B+YE6eYwqV4rwsBUiW+k=;
  b=SUYpMvcwgm9gwMqe7eN1lsAlCQkBXGcLDQy/rmLGeWmTKtV5RKk35+d3
   G0wUqGWUIOl/kJBynyxtlllyneDMGfggLCPM+40A6Nj69HovLh8Wfw+SG
   5ozU+UBZTcG3RbHdscum2yO8Imkg395+/gs0cG6eQ5TNakmKb+GEyhIMB
   MVh3obpWYQthqJ71C4KKgOgi3+BPRuKF1U5N9EVA90Nxg53zBBiJw78x1
   q/xqBV+kZUMU2thxJya1+ll06wtWk1Bnl7aAFkUaeRh8jQQDeBF+/y3pl
   Mq0VfAQ4yD+WXfbjnfQblMzdb5SFC17HrrokBw5+zkEnPCh7lL6Xacrzk
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="305843305"
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="305843305"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 08:56:16 -0800
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="475193495"
Received: from leechri2-mobl.amr.corp.intel.com (HELO [10.209.179.248]) ([10.209.179.248])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 08:56:15 -0800
Subject: Re: [PATCH v2 2/2] ASoC: SOF: compress: Implement get_caps and
 get_codec_caps
To:     Daniel Baluta <daniel.baluta@nxp.com>,
        Daniel Baluta <daniel.baluta@oss.nxp.com>, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
        cezary.rojewski@intel.com, ranjani.sridharan@linux.intel.com,
        linux-kernel@vger.kernel.org, paul.olaru@nxp.com,
        sound-open-firmware@alsa-project.org
References: <20220118212732.281657-1-daniel.baluta@oss.nxp.com>
 <20220118212732.281657-3-daniel.baluta@oss.nxp.com>
 <41ae6093-8e27-01d4-e532-8a28fb1d9cf1@linux.intel.com>
 <8786f0c4-e60c-92ac-ba07-8244c785f75a@nxp.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <729f7a48-0f6e-0569-74a3-f28363d16857@linux.intel.com>
Date:   Wed, 19 Jan 2022 10:56:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <8786f0c4-e60c-92ac-ba07-8244c785f75a@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>   +static int sof_compr_get_caps(struct snd_soc_component *component,
>>> +                  struct snd_compr_stream *cstream,
>>> +                  struct snd_compr_caps *caps)
>>> +{
>>> +    caps->num_codecs = 3;
>>> +    caps->min_fragment_size = 3840;
>>> +    caps->max_fragment_size = 3840;
>>> +    caps->min_fragments = 2;
>>> +    caps->max_fragments = 2;
>>> +    caps->codecs[0] = SND_AUDIOCODEC_MP3;
>>> +    caps->codecs[1] = SND_AUDIOCODEC_AAC;
>>> +    caps->codecs[2] = SND_AUDIOCODEC_PCM;
>>
>> I don't think you can add this unconditionally for all
>> devices/platforms, clearly this wouldn't be true for Intel for now.
>>
>> If the information is not part of a firmware manifest or topology, then
>> it's likely we have to use an abstraction layer to add this for specific
>> platforms.
>>
>> it's really a bit odd to hard-code all of this at the kernel level, this
>> was not really what I had in mind when we come up with the concept of
>> querying capabilities. I understand though that for testing this is
>> convenient, so maybe this can become a set of fall-back properties in
>> case the firmware doesn't advertise anything.
> 
> I see your point. I think for the moment I will remove this patch
> until I will come with a better solution.
> 
> One important thing is: where do we advertise the supported parameters:
> 
> 1) topology.
> 2) codec component instance (codec adapter) inside FW.
> 3) Linux kernel side based on some info about the current running platform.

I like the topology approach because it doesn't require an IPC to
retrieve the information and it doesn't require additional tables in the
firmware - which would increase the size for no good reason.

The topology also allows to remove support for the compressed path if
there are any concerns with memory/mcps usages in a given platform. DSPs
have finite resources and designers will need to trade off fancy noise
suppression libraries, large SRAM buffers to reduce power and compressed
audio codecs.

I think we need to have something in the firmware manifest that lists
the presence of the codec component in the build or installed libraries,
so that we can verify that topology and firmware are aligned. Otherwise
this will be really error-prone.

We've had this problem for a while now that the topology can refer to
components that are not part of the build, and it's problematic IMHO to
see an IPC error as a result of a firmware/topology mistmatch.

> Unfortunately, most of the existing users of this interface really do
> hardcode supported params:
> 
> e.g
> 
> intel/atom/sst/sst_drv_interface.c
> qcom/qdsp6/q6asm-dai.c
> uniphier/aio-compress.c
> 
> But that's because I think they only support one single platform family
> which has same capabilities.

I think Qualcomm probably has the same problems as us, the firmware can
be modified, so hard-coding in the kernel is far from ideal.

The unifier case is a bit different, IIRC they only support IEC formats
which at the kernel level can be treated as PCM. I am not sure why the
compressed interface was required here, but it's not wrong to use the
compressed interface as a domain-specific transport mechanism. Others do
it was well for audio over SPI and on the Intel side the probes are
based on a custom transport format to multiplex all the PCM data on a
single 'compressed' stream.

