Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD6851FF85
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237172AbiEIO26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237152AbiEIO2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:28:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3951E3EF0
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 07:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652106301; x=1683642301;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RmFKKHm/zNxF176Uu6i/9T/WV9+GLqHLCIUqgV5ZDXQ=;
  b=FW2EfRSr1gWaMAzUrY7Jhxsff1ZuEqjz9veq0fyEMASq1ek41Twk64xY
   KQflcXFef/kesj1RdYCKcBU8gEZtzIPml+VJdaaUxrHkPxIpcQsOFvANa
   ArDoZB4fzPAR5th57wcNnR8gOos5KWXLsDEQlsu9wJ0MlSP0Uyrendop2
   gX0tXdW+l7wvE1KyvzKlxPJxn0kK2jM8mbRyNmu+WxWxhd7R/8rj03s2Z
   ZEHZt/2sDtJWf0n2qz1/pRP8GW3+JANUuVNeVCp3S5PgIMT/OrViEugSq
   qmm1k5VpuGo/GzzbkPzQkAYNfF6jcGZEOLx7bkeotUmasD2TSSbhKxSEU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="248967063"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="248967063"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 07:25:00 -0700
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="592510983"
Received: from gfgerman-mobl1.amr.corp.intel.com (HELO [10.209.80.95]) ([10.209.80.95])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 07:25:00 -0700
Message-ID: <97cd6566-e686-e1f2-fe91-4b4ba9d95f12@linux.intel.com>
Date:   Mon, 9 May 2022 09:24:59 -0500
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
 <d9646029-29b1-d71b-d1f5-b33267888e3c@linux.intel.com>
 <fd355232-c5e3-ba1b-801d-526ee6f04946@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <fd355232-c5e3-ba1b-801d-526ee6f04946@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> You could say why do we need wait itself in the first place.
>>>
>>> The reason we need wait in first place is because, there is a danger of
>>> codec accessing registers even before enumeration is finished. Because
>>> most of the ASoC codec registration happens as part of codec/component
>>> driver probe function rather than status callback.
>>>
>>> I hope this answers your questions.
>>
>>
>> Humm, not really.
>>
>> First, you're using this TIMEOUT_MS value in 3 unrelated places, and
>> using 2 different struct completion, which means there are side effects
>> beyond autoenumeration.
> 
> 2 of these 3 are autoenum ones, one is in probe path and other in bus
> reset path during pm.
> 
> The final one is broadcast timeout, new timeout value should be okay for
> that too, given that we need 10ms timeout.

probably better to make things explicit with a different timeout value
for the broadcast case.

100ms for a broadcast is really eons, it's supposed to be immediate really.

>> And then I don't get what you do on a timeout. in the enumeration part,
> 
> We can't do much on the timeout.
> 
>> the timeout value is not checked for, so I guess enumeration proceeds
>> without the hardware being available? That seems to contradict the
>> assertion that you don't want to access registers before the hardware is
>> properly initialized.
> 
> Even if enumeration timeout, we will not access the registers because
> the ASoC codec is not registered yet from WCD938x component master.

What happens when the codec is registered then? the autoenumeration
still didn't complete, so what prevents the read/writes from failing then?

>> And then on broadcast you have this error handling:
>>
>>         ret = wait_for_completion_timeout(&swrm->broadcast,
>>                           msecs_to_jiffies(TIMEOUT_MS));
>>         if (!ret)
>>             ret = SDW_CMD_IGNORED;
>>         else
>>             ret = SDW_CMD_OK;
>>
>> Which is equally confusing since SDW_CMD_IGNORED is really an error, and
>> the bus layer does not really handle it well - not to mention that I
>> vaguely recall the qcom hardware having its own definition of IGNORED?
> QCom hardware alteast the version based on which this driver was written
> did not have any support to report errors type back on register
> read/writes.
> 
> In this case a broad cast read or write did not generate a complete
> interrupt its assumed that its ignored, as there is no way to say if its
> error or ignored.

ok, that should be fine.

The code in bus.c mostly ignores -ENODATA for the suspend cases. For the
bank switch, I forgot that we also ignore it, Bard added a patch in
2021. The only case where we abort a transfer is on a real error.



