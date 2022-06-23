Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A88B557E55
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiFWO4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiFWO4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:56:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34229B5E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655996175; x=1687532175;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AT8JAPkS8YJRYuTDNqpAngPAp17BB/bvcfqew+27oho=;
  b=hCU8lBo6Ey0rGXwn8k1+doy3x/VvmX0AnQ8J3iceaOJV+4vYGuoNIhBE
   h910P+mCd5RHzq/taTBJNhnVD3RAtRZdiVjH64CN8YjgkcEJIOSZsL2Hm
   nqdbIbb7fsbCuloDxjiZ4yFf7iyIo5G0xfarHqWP1i2YnxmHfD9drBRCI
   yUNiU8hGBnyc4ehqbzxJkPzhI/F7qWjYop1L9RF4OryH5NJQuG/zFMplV
   WkkiTOnxYVgTnEsnz9tWcxzryJzs0sTIDEfiYsve2aQSAuigmoO+yjZHH
   NGkK8l4K1WPf0xHHEpi8/hZ7PSRQSFF2u8SmP3nGjiwCnuyL1q8kncGlw
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="281817793"
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="281817793"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 07:55:54 -0700
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="691055713"
Received: from rames2-mobl.amr.corp.intel.com (HELO [10.213.181.118]) ([10.213.181.118])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 07:55:53 -0700
Message-ID: <a861f3b2-dec4-982d-0939-1dfc18dd2f53@linux.intel.com>
Date:   Thu, 23 Jun 2022 09:54:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH] soundwire: bus_type: fix remove and shutdown support
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        sanyog.r.kale@intel.com, bard.liao@intel.com
References: <20220610015105.25987-1-yung-chuan.liao@linux.intel.com>
 <YrQca7YH8v6XCl02@matsya>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <YrQca7YH8v6XCl02@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/23/22 02:55, Vinod Koul wrote:
> On 10-06-22, 09:51, Bard Liao wrote:
>> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>
>> The bus sdw_drv_remove() and sdw_drv_shutdown() helpers are used
>> conditionally, if the driver provides these routines.
>>
>> These helpers already test if the driver provides a .remove or
>> .shutdown callback, so there's no harm in invoking the
>> sdw_drv_remove() and sdw_drv_shutdown() unconditionally.
> 
> Okay sounds good
> 
>> In addition, the current code is imbalanced with
>> dev_pm_domain_attach() called from sdw_drv_probe(), but
>> dev_pm_domain_detach() called from sdw_drv_remove() only if the driver
>> provides a .remove callback.
> 
> Am not sure I follow what is imbalance, pm_domain_attach/detach?

Yes, the dev_pm_domain_detach() is done conditionally, depending on the
presence of a driver .remove callback, that's not so good.

>> Fixes: 9251345dca24b ("soundwire: Add SoundWire bus type")
> 
> How is this a fix is still unclear to me. At best I think this is code
> optimization and removing checks which maybe redundant.

I think the Fixes tag is appropriate for the dev_pm_domain_detach()
problem, but if you want to drop it that's fine with me.


>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Reviewed-by: Rander Wang <rander.wang@intel.com>
>> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
>> ---
>>  drivers/soundwire/bus_type.c | 8 ++------
>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
>> index 893296f3fe39..b81e04dd3a9f 100644
>> --- a/drivers/soundwire/bus_type.c
>> +++ b/drivers/soundwire/bus_type.c
>> @@ -193,12 +193,8 @@ int __sdw_register_driver(struct sdw_driver *drv, struct module *owner)
>>  
>>  	drv->driver.owner = owner;
>>  	drv->driver.probe = sdw_drv_probe;
>> -
>> -	if (drv->remove)
>> -		drv->driver.remove = sdw_drv_remove;
>> -
>> -	if (drv->shutdown)
>> -		drv->driver.shutdown = sdw_drv_shutdown;
>> +	drv->driver.remove = sdw_drv_remove;
>> +	drv->driver.shutdown = sdw_drv_shutdown;
>>  
>>  	return driver_register(&drv->driver);
>>  }
>> -- 
>> 2.17.1
> 
