Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8441A50AD5D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 03:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443150AbiDVBqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 21:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244815AbiDVBqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 21:46:40 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DDB4A3E0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 18:43:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VAjQwRe_1650591824;
Received: from 30.225.28.226(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0VAjQwRe_1650591824)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Apr 2022 09:43:45 +0800
Message-ID: <39c304b4-517b-6433-767d-540407adfb08@linux.alibaba.com>
Date:   Fri, 22 Apr 2022 09:43:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH] coresight: etm4x: return 0 instead of using local ret
 variable
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220420052831.78566-1-shile.zhang@linux.alibaba.com>
 <20220421164217.GB1596562@p14s>
From:   Shile Zhang <shile.zhang@linux.alibaba.com>
In-Reply-To: <20220421164217.GB1596562@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/22 00:42, Mathieu Poirier wrote:
> Hi Shile,
> 
> On Wed, Apr 20, 2022 at 01:28:31PM +0800, Shile Zhang wrote:
>> The etm4_remove function (now it's rename to etm4_remove_dev) always
>> return 0, and it has been changed to void in commit 4fd269e74f2f
>> ("amba: Make the remove callback return void"). But its weird that the
>> changes is gone in mainline. which is remained in 5.10.y branch.
> 
> Commit 4fd269e74f2f is not valid upstream.  Changes that don't have a critical
> impact on user experience or fix a bug aren't backported to longterm kernels.
> 
Sorry, I used wrong commit id, but this patch is merged in mainline with 
3fd269e74f2fe ("amba: Make the remove callback return void")

It can be checked from here: 
https://github.com/torvalds/linux/commit/3fd269e74f2fe#diff-937c525e02a9fea8fe99b3d91b9f87ca097b3392de5fea3d4ff56cec8b08c94aL1683

>>
>> Just backport the changes of etm4_remove_dev and return 0 directly in it's
>> caller function etm4_remove_platform_dev.
> 
> I'm not sure why the work "backport" is used here since this patch is destine
> for mainline.
> 
Yes, maybe "backport" here is not OK, I'll re-work it in next version 
later. Thanks!

>>
>> Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 11 +++++------
>>   1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index 7f416a12000e..141f8209a152 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -2104,7 +2104,7 @@ static void clear_etmdrvdata(void *info)
>>   	etmdrvdata[cpu] = NULL;
>>   }
>>   
>> -static int __exit etm4_remove_dev(struct etmv4_drvdata *drvdata)
>> +static void __exit etm4_remove_dev(struct etmv4_drvdata *drvdata)
>>   {
>>   	etm_perf_symlink(drvdata->csdev, false);
>>   	/*
>> @@ -2125,8 +2125,6 @@ static int __exit etm4_remove_dev(struct etmv4_drvdata *drvdata)
>>   
>>   	cscfg_unregister_csdev(drvdata->csdev);
>>   	coresight_unregister(drvdata->csdev);
>> -
>> -	return 0;
>>   }
>>   
>>   static void __exit etm4_remove_amba(struct amba_device *adev)
>> @@ -2139,13 +2137,14 @@ static void __exit etm4_remove_amba(struct amba_device *adev)
>>   
>>   static int __exit etm4_remove_platform_dev(struct platform_device *pdev)
>>   {
>> -	int ret = 0;
>>   	struct etmv4_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
>>   
>>   	if (drvdata)
>> -		ret = etm4_remove_dev(drvdata);
>> +		etm4_remove_dev(drvdata);
>> +
>>   	pm_runtime_disable(&pdev->dev);
>> -	return ret;
>> +
>> +	return 0;
> 
> I'm fine with the code but the changelog needs to be re-worked.  The only
> rational for this patch is that the return value for function etm4_remove_dev()
> is never used and as such being removed.
> 
Thanks for your comments, I'll send V2 later.

> Thanks,
> Mathieu
> 
>>   }
>>   
>>   static const struct amba_id etm4_ids[] = {
>> -- 
>> 2.33.0.rc2
>>
