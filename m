Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF315150E7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbiD2Qdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379558AbiD2QdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:33:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8094D95FB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651249783; x=1682785783;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9JJLmBDdDaVDkWtdj2AlikPdhwkYMqvNxao/Uvuy9zc=;
  b=faSX+2gqZKNvjLaFl7gO4aws/SQ0PmHcyBFuoEznuyaQbpri350GV34h
   XMty35ZGQZdsOgN4O6398loTXecglKo5YK5ghglB2q7YFqP3iva9K881n
   OyWSY2+Wi7ubMqK+PFAGQ05eurAEb1Aj7tdGujZSDBEJ5RBV96/QLvbn+
   7Nn4KaSPUfRFuroFhZ1myOFx9Bxa56Fp3Pygh2uEBT84j/jC+nELmBFG+
   yexeRySJUdATOVMN59NSatAruEd/AmjC94BH8J8Qjztat5CQOsdyWSgEa
   +lRbVJRk3eguCV2AlM82vPSIBk7G35uonepFilzSRIxNO6PRuFo3wuZ3w
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="353120955"
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="353120955"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 09:29:43 -0700
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="685089587"
Received: from aleeshax-mobl.amr.corp.intel.com (HELO [10.212.139.246]) ([10.212.139.246])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 09:29:42 -0700
Message-ID: <e9f4001d-a9f4-fae7-521a-76f8880ba82b@linux.intel.com>
Date:   Fri, 29 Apr 2022 11:19:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH] soundwire: qcom: adjust autoenumeration timeout
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        bard.liao@intel.com,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
References: <20220429160928.24614-1-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220429160928.24614-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/29/22 11:09, Srinivas Kandagatla wrote:
> Currently timeout for autoenumeration during probe and bus reset is set to
> 2 secs which is really a big value. This can have an adverse effect on
> boot time if the slave device is not ready/reset.
> This was the case with wcd938x which was not reset yet but we spent 2
> secs waiting in the soundwire controller probe. Reduce this time to
> 1/10 of Hz which should be good enough time to finish autoenumeration
> if any slaves are available on the bus.

Can I ask why this is dependent on a software configuration you have no control on?

Why not simply:

#define TIMEOUT_MS		100

?

> 
> Reported-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/soundwire/qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index da1ad7ebb1aa..432e5cb9a4d2 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -105,7 +105,7 @@
>  
>  #define SWRM_SPECIAL_CMD_ID	0xF
>  #define MAX_FREQ_NUM		1
> -#define TIMEOUT_MS		(2 * HZ)
> +#define TIMEOUT_MS		(HZ/10)
>  #define QCOM_SWRM_MAX_RD_LEN	0x1
>  #define QCOM_SDW_MAX_PORTS	14
>  #define DEFAULT_CLK_FREQ	9600000
