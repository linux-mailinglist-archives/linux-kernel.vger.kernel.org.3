Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3062751FE55
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbiEINfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbiEINfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:35:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4B922BC8
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 06:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652103105; x=1683639105;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GEnD1FBDizIqwkOcLdZXmPV+SgRq64ykgBvQxT7zusI=;
  b=oKYdMdoIPz08o8h/O/tGENRHPobr+eAvlgKTSdBo+m4v1OGGzBvh7TVm
   y21qUhCNmTMqwwgS2iKs5bm3ZGYpFLvk7c5JYal+0pNYMyPdWwmrwb1tb
   O3PsmszKiTexbE1AF4ChPCerLzrSKeKkhjzfC72XEjjdlmAMzuXNXX7V9
   LP41959mrh9yKIJAV/0aMnVVewbPQsbdcNpuX0dSoeTQRQXnu1DwU8YWO
   8tthYxESrTVPtPUwn8iZqWe6KtW3cRZZ2JPVOT71zmCt/9itzUxlW7u/9
   PHodVKEiLKqdkf1H1LVGS72s/Z0GXqqEiYjZ+hP+vMhAz5hzsNAubDUWq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="268715479"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="268715479"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 06:31:44 -0700
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="696536444"
Received: from bjsmith1-mobl2.amr.corp.intel.com (HELO [10.212.144.50]) ([10.212.144.50])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 06:31:44 -0700
Message-ID: <d9646029-29b1-d71b-d1f5-b33267888e3c@linux.intel.com>
Date:   Mon, 9 May 2022 08:31:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v2] soundwire: qcom: adjust autoenumeration timeout
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        bard.liao@intel.com,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
References: <20220506084705.18525-1-srinivas.kandagatla@linaro.org>
 <725af523-d144-e373-e09b-fb48b3afb9ed@linux.intel.com>
 <8643d266-7108-2440-43e1-c51b829ba481@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <8643d266-7108-2440-43e1-c51b829ba481@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/7/22 01:52, Srinivas Kandagatla wrote:
> Thanks Pierre,
> 
> On 06/05/2022 15:13, Pierre-Louis Bossart wrote:
>>
>>
>> On 5/6/22 03:47, Srinivas Kandagatla wrote:
>>> Currently timeout for autoenumeration during probe and bus reset is
>>> set to
>>> 2 secs which is really a big value. This can have an adverse effect on
>>> boot time if the slave device is not ready/reset.
>>> This was the case with wcd938x which was not reset yet but we spent 2
>>> secs waiting in the soundwire controller probe. Reduce this time to
>>> 1/10 of Hz which should be good enough time to finish autoenumeration
>>> if any slaves are available on the bus.
>>
>> Humm, now that I think of it I am not sure what reducing the timeout
>> does.
>>
>> It's clear that autoenumeration should be very fast, but if there is
>> nothing to enumerate what would happen then? It seems that reducing the
>> timeout value only forces an inconsistent configuration to be exposed
>> earlier, but that would not result in a functional change where the
>> missing device would magically appear, would it? Is this change mainly
>> to make the tests fail faster? If the 'slave device is not ready/reset',
>> is there a recovery mechanism to recheck later?
>>
>> Would you mind clarifying what happens after the timeout, and why the
>> timeout would happen in the first place?
> 
> This issue is mostly present/seen with WCD938x codec due to its Linux
> device model.
> WCD938x Codec has 3 Linux component drivers
> 1. TX Component (A soundwire device connected to TX Soundwire Master)
> 2. RX Component (A soundwire device connected to RX Soundwire Master)
> 3. Master Component (Linux component framework master for (1) and  (2)
> and registers ASoC codec)
> 
> Also we have only one reset for (1) and (2).
> 
> reset line is handled by (3)
> There are two possibilities when the WCD938x reset can happen,
> 
> 1. If reset happens earlier than probing (1) and (2) which is best case.
> 
> 
> 2. if reset happens after (1) and (2) are probed then SoundWire TX and
> RX master will have spend 2 + 2 secs waiting, Which is a long time out
> Hence the patch.
> 
> TBH, the 2 sec timeout value was just a random number which I added at
> the start, we had to come up with some sensible value over the time
> anyway for that.
> 
> You could say why do we need wait itself in the first place.
> 
> The reason we need wait in first place is because, there is a danger of
> codec accessing registers even before enumeration is finished. Because
> most of the ASoC codec registration happens as part of codec/component
> driver probe function rather than status callback.
> 
> I hope this answers your questions.


Humm, not really.

First, you're using this TIMEOUT_MS value in 3 unrelated places, and
using 2 different struct completion, which means there are side effects
beyond autoenumeration.

qcom.c-         /*

qcom.c-          * sleep for 10ms for MSM soundwire variant to allow
broadcast

qcom.c-          * command to complete.

qcom.c-          */

qcom.c-         ret = wait_for_completion_timeout(&swrm->broadcast,

qcom.c:                                   msecs_to_jiffies(TIMEOUT_MS));

--

qcom.c-         goto err_clk;

qcom.c- }

qcom.c-

qcom.c- qcom_swrm_init(ctrl);

qcom.c- wait_for_completion_timeout(&ctrl->enumeration,

qcom.c:                             msecs_to_jiffies(TIMEOUT_MS));

--

qcom.c-         if (!swrm_wait_for_frame_gen_enabled(ctrl))

qcom.c-                 dev_err(ctrl->dev, "link failed to connect\n");

qcom.c-

qcom.c-         /* wait for hw enumeration to complete */

qcom.c-         wait_for_completion_timeout(&ctrl->enumeration,

qcom.c:                                   msecs_to_jiffies(TIMEOUT_MS));


And then I don't get what you do on a timeout. in the enumeration part,
the timeout value is not checked for, so I guess enumeration proceeds
without the hardware being available? That seems to contradict the
assertion that you don't want to access registers before the hardware is
properly initialized.

And then on broadcast you have this error handling:

		ret = wait_for_completion_timeout(&swrm->broadcast,
						  msecs_to_jiffies(TIMEOUT_MS));
		if (!ret)
			ret = SDW_CMD_IGNORED;
		else
			ret = SDW_CMD_OK;

Which is equally confusing since SDW_CMD_IGNORED is really an error, and
the bus layer does not really handle it well - not to mention that I
vaguely recall the qcom hardware having its own definition of IGNORED?

