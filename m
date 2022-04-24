Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB1950D024
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 08:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbiDXHAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 03:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237643AbiDXHA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 03:00:29 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF20198C71
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 23:57:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VB.PmNF_1650783445;
Received: from 30.225.28.161(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0VB.PmNF_1650783445)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 24 Apr 2022 14:57:26 +0800
Message-ID: <b1654ab7-b783-ac59-ee94-13527135f406@linux.alibaba.com>
Date:   Sun, 24 Apr 2022 14:57:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v2] coresight: etm4x: return 0 instead of using local ret
 variable
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220422020239.37186-1-shile.zhang@linux.alibaba.com>
 <20220422154558.GA1713394@p14s>
From:   Shile Zhang <shile.zhang@linux.alibaba.com>
In-Reply-To: <20220422154558.GA1713394@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/22 23:45, Mathieu Poirier wrote:
> On Fri, Apr 22, 2022 at 10:02:39AM +0800, Shile Zhang wrote:
>> The function etm4_remove_dev() always return 0, and the former function
>> etm4_remove has been changed to void in commit 3fd269e74f2fe ("amba: Make
>> the remove callback return void"). But now its changed back to int type
>> for some reason, which is different to the stable branch linux-5.10.y.
> 
> Please spend time understanding why function etm4_remove_dev()'s return value
> has been changed back to an "int".  From there you will likely come to the
> conclusion that adding the above to the changelog doesn't make sense.

Sorry, I means "some reason" here actually I cannot find out why.

1. From the git log of the file 
`drivers/hwtracing/coresight/coresight-etm4x-core.c', only log of 
etm4_remove changes to void in commit 3fd269e74f2fe. no any log record 
when it change back to int.
2. from the commit 'git log --pretty="%h %ci %cn %s" 
drivers/hwtracing/coresight/coresight-etm4x-core.c'
...
b8336ad947e19 2021-02-04 17:00:32 +0100 Greg Kroah-Hartman coresight: 
etm4x: add AMBA id for Cortex-A55 and Cortex-A75
3fd269e74f2fe 2021-02-02 14:25:50 +0100 Uwe Kleine-König amba: Make the 
remove callback return void
...

The commit 'b8336ad947e19' does not change the etm4_remove:
https://github.com/torvalds/linux/commit/b8336ad947e1913b9bb5cdf4f54b687654160d42

But the different between the commit 'b8336ad947e19' and '3fd269e74f2fe' 
contains the changes of etm4_remove back to int, as following:
---
...
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c 
b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 82787cba537d3..8c4b0c46c8f32 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1680,7 +1680,7 @@ static void clear_etmdrvdata(void *info)
         etmdrvdata[cpu] = NULL;
  }

-static void etm4_remove(struct amba_device *adev)
+static int etm4_remove(struct amba_device *adev)
  {
         struct etmv4_drvdata *drvdata = dev_get_drvdata(&adev->dev);

@@ -1703,6 +1703,8 @@ static void etm4_remove(struct amba_device *adev)
         cpus_read_unlock();

         coresight_unregister(drvdata->csdev);
+
+       return 0;
  }

  static const struct amba_id etm4_ids[] = {
@@ -1711,6 +1713,8 @@ static const struct amba_id etm4_ids[] = {
         CS_AMBA_ID(0x000bb95a),                 /* Cortex-A72 */
         CS_AMBA_ID(0x000bb959),                 /* Cortex-A73 */
         CS_AMBA_UCI_ID(0x000bb9da, uci_id_etm4),/* Cortex-A35 */
+       CS_AMBA_UCI_ID(0x000bbd05, uci_id_etm4),/* Cortex-A55 */
+       CS_AMBA_UCI_ID(0x000bbd0a, uci_id_etm4),/* Cortex-A75 */
         CS_AMBA_UCI_ID(0x000bbd0c, uci_id_etm4),/* Neoverse N1 */
         CS_AMBA_UCI_ID(0x000f0205, uci_id_etm4),/* Qualcomm Kryo */
         CS_AMBA_UCI_ID(0x000f0211, uci_id_etm4),/* Qualcomm Kryo */
...
---

I really don't know how to check which commit change it back.
Could you please help to give me some guidance?

Thanks!


> 
>>
>> Just let it return void and return 0 directly in it's caller function
>> etm4_remove_platform_dev.
> 
> The only rational for this patch is that etm4_remove_dev() always returns '0'.
> And even if it was to return anything else, the return value it not checked.
> And even if the return value was checked, there is nothing to do about an error
> condition since the driver is being removed.
> 
>>
>> Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
>> ---
>> v2: re-work the commit log from Mathieu's suggestion.
>> v1: https://lore.kernel.org/linux-arm-kernel/20220421164217.GB1596562@p14s/T/
>> ---
>>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 11 +++++------
>>   1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index 7f416a12000eb..141f8209a152a 100644
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
>>   }
>>   
>>   static const struct amba_id etm4_ids[] = {
>> -- 
>> 2.33.0.rc2
>>
