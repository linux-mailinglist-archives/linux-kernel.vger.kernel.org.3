Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489F24AEE75
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbiBIJvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237766AbiBIJvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:51:00 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB96BE073E0C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 01:50:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D25BF1FB;
        Wed,  9 Feb 2022 01:42:31 -0800 (PST)
Received: from [10.57.88.251] (unknown [10.57.88.251])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A38703F73B;
        Wed,  9 Feb 2022 01:42:30 -0800 (PST)
Message-ID: <5fbadc11-0371-7dec-3189-ef5908fb3122@arm.com>
Date:   Wed, 9 Feb 2022 09:42:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v2 RESEND 1/4] coresight: etm4x: Add lock for reading
 virtual context ID comparator
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220204152403.71775-1-leo.yan@linaro.org>
 <20220204152403.71775-2-leo.yan@linaro.org>
 <6b91293a-1149-2c77-04a4-421a45d4e1e0@arm.com>
 <20220209093304.GA334894@leoy-ThinkPad-X240s>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220209093304.GA334894@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo

On 09/02/2022 09:33, Leo Yan wrote:
> Hi Suzuki,
> 
> On Wed, Feb 09, 2022 at 05:47:24AM +0000, Suzuki Kuruppassery Poulose wrote:
>> Hi Leo
>>
>> On 04/02/2022 15:24, Leo Yan wrote:
>>> Updates to the values and the index are protected via the spinlock.
>>> Ensure we use the same lock to read the value safely.
>>>
>>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> ---
>>>    drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
>>> index 10ef2a29006e..2f3b4eef8261 100644
>>> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
>>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
>>> @@ -2111,7 +2111,9 @@ static ssize_t vmid_val_show(struct device *dev,
>>>    	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>>    	struct etmv4_config *config = &drvdata->config;
>>> +	spin_lock(&drvdata->spinlock);
>>>    	val = (unsigned long)config->vmid_val[config->vmid_idx];
>>> +	spin_unlock(&drvdata->spinlock);
>>>    	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
>>>    }
>>
>>
>> I have queued this patch.
> 
> Thanks!
> 
>> For the rest, we would need to wait until the helper lands in the rc.

Sorry, that was not the exact argument, see below.

> 
> The helper function patch has been landed on the mainline kernel,
> it would be safe to merge the rest patches.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d7e4f8545b497b3f5687e592f1c355cbaee64c8c

The coresight queue is based on rc1 and we already created a stable
tag for TRBE erratas, which was pulled into arm64. So, (correct me
if I am wrong), AFAIU, we cannot rebase the queue on to rc2 where
the patch landed. But happy to proceed, if there is a solution.

Mathieu, what do you think ?

Cheers
Suzuki
