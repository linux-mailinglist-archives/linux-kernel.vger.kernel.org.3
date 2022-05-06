Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC6351DB60
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442592AbiEFPGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237627AbiEFPGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:06:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246F4396B6
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 08:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651849349; x=1683385349;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JtteZAMTQXi+wE2QvFf74UIXeiYI3rgZRBcRNFpRR2c=;
  b=XyRP9eRqV/+kXBgHrrHwrxitfdrPwQoYajscJHEI6gfh5uH+ooqOffve
   XWL/vYLMl2VaNwH4AuEnWcCzu4Ex+NwlUrL7bIAA2QR3K58FlY37vN0Rq
   XX3NVHb00zm0IVBqzn49907AaMgrxlELXTspqeT+VsvbfxAl59hYPNafO
   PWufM3t/dfzic5hmqmYBTOZrYbsGMRQ8NIfGnl1p3tR8eXnMWCCnoOJB0
   sizU3Vi/09BHBESJYV34GsAOIVo4O+nRClbyRd8OU4elpxxljqiUa/6IK
   ImJyFujt+xV+GXHn2H0MKFKeAyP0xs0iWZB/xqZo03bUKCsZqCSeuj5dm
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="268092547"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="268092547"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 08:02:24 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="654729242"
Received: from ysomasun-mobl1.amr.corp.intel.com (HELO [10.209.0.67]) ([10.209.0.67])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 08:02:23 -0700
Message-ID: <725af523-d144-e373-e09b-fb48b3afb9ed@linux.intel.com>
Date:   Fri, 6 May 2022 09:13:00 -0500
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
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220506084705.18525-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/6/22 03:47, Srinivas Kandagatla wrote:
> Currently timeout for autoenumeration during probe and bus reset is set to
> 2 secs which is really a big value. This can have an adverse effect on
> boot time if the slave device is not ready/reset.
> This was the case with wcd938x which was not reset yet but we spent 2
> secs waiting in the soundwire controller probe. Reduce this time to
> 1/10 of Hz which should be good enough time to finish autoenumeration
> if any slaves are available on the bus.

Humm, now that I think of it I am not sure what reducing the timeout does.

It's clear that autoenumeration should be very fast, but if there is
nothing to enumerate what would happen then? It seems that reducing the
timeout value only forces an inconsistent configuration to be exposed
earlier, but that would not result in a functional change where the
missing device would magically appear, would it? Is this change mainly
to make the tests fail faster? If the 'slave device is not ready/reset',
is there a recovery mechanism to recheck later?

Would you mind clarifying what happens after the timeout, and why the
timeout would happen in the first place?

Thanks!

> 
> Reported-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> 
> Changes since v1:
> 	replaced HZ/10 with 100 as suggested by Pierre
> 
>  drivers/soundwire/qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 7367aa88b8ac..d6111f69d320 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -105,7 +105,7 @@
>  
>  #define SWRM_SPECIAL_CMD_ID	0xF
>  #define MAX_FREQ_NUM		1
> -#define TIMEOUT_MS		(2 * HZ)
> +#define TIMEOUT_MS		100
>  #define QCOM_SWRM_MAX_RD_LEN	0x1
>  #define QCOM_SDW_MAX_PORTS	14
>  #define DEFAULT_CLK_FREQ	9600000
