Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399954D0396
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243986AbiCGQAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbiCGQAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:00:12 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132C88118C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 07:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646668758; x=1678204758;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UIQ205em1WrlnAoEopCeQjugklgipYmQxrXTFmaWBqc=;
  b=htnSgzl3NtHF6CBXLT07Q6v4jrlWThhCt+E8KEs0aaKv1ww2Ao+/4b+4
   S0EgnGj/JMHED1TzEWFmRzc2khtlUsMh4vYUbh2sKZis3twHQ4Ex2yjdB
   1ZYCjsHyN73WLfLstHSev8lK/2c9SkGhKsSnwbXQgLyGbFG8oArbnp2rV
   VdfJz//8sknHsRid9M+Od1C914PslmQmMeg5qhFU5gNm1Zr1BEhXsAuLm
   AhVe6FVy2P82XIRVC3WWwpPcAqZf9HuToZWBT2VyCvabA18NUbjY1CWfs
   BwY7GC5T+7vW2o5+kvAdTqiQgNLtsx0SWaIIfnbE9CX31hqPDd/yJlksE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="279128044"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="279128044"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 07:59:17 -0800
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="643292226"
Received: from rhack-mobl1.amr.corp.intel.com (HELO [10.209.14.71]) ([10.209.14.71])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 07:59:17 -0800
Message-ID: <def6807f-5d5d-5d08-7705-70c907b23805@linux.intel.com>
Date:   Mon, 7 Mar 2022 09:24:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH -next] soundwire: stream: Fix error return code in
 do_bank_switch()
Content-Language: en-US
To:     Wang Wensheng <wangwensheng4@huawei.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     xuqiang36@huawei.com
References: <20220307074039.117488-1-wangwensheng4@huawei.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220307074039.117488-1-wangwensheng4@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/22 01:40, Wang Wensheng wrote:
> Fix to return a negative error code from the error handling case instead
> of 0, as done elsewhere in this function.
> 
> Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>

Thanks for the patch, sounds good to me.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   drivers/soundwire/stream.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 980f26d49b66..553131597af6 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -822,6 +822,7 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
>   		} else if (multi_link) {
>   			dev_err(bus->dev,
>   				"Post bank switch ops not implemented\n");
> +			ret = -EINVAL;
>   			goto error;
>   		}
>   
