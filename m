Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326C24C2DEC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 15:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbiBXOJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 09:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbiBXOJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 09:09:19 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145BE247771;
        Thu, 24 Feb 2022 06:08:47 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21OC4AkA029958;
        Thu, 24 Feb 2022 15:08:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=OZyEljsP9pa68/pPXqNDTjzClhBC6YqXLqS4/jt+DlY=;
 b=QVOE3nmH7IfGHnfLIk1uU7JMsu2HiYBdUthmICcfdnDXbAXCK3b/kF12S4KJ5DBX41pO
 +j/2oPi7WsQRQ3tDcpFPjdS/haPjTHLeegEZTrz1LBiHprHUNbp2mAP32n/SWxJm/AQ3
 voGbC77v5Z9pEuc49IsWtBs6vLQ6nXH2XkCbqZD9CoQ6vZcwjdBYXPjICjohlmjqFF8z
 iuyskU87JcD4CPKYJKG3XDUHg86EX6G3LJzPqJgK3+4udVmfYfq2yczn+tMhNpXoh7pu
 lbXZPSLBJS9vNMhoyS0ZC5YjlGw+yBaPJa0qyavmciNR92lEAJDwLhxPoFKB+NllG3cn iw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ee5pajk28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Feb 2022 15:08:29 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 88FA110002A;
        Thu, 24 Feb 2022 15:08:28 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7581122ECDC;
        Thu, 24 Feb 2022 15:08:28 +0100 (CET)
Received: from [10.211.2.44] (10.75.127.46) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 24 Feb
 2022 15:08:27 +0100
Message-ID: <da6bee63-6a79-2341-e099-d26b53fb557f@foss.st.com>
Date:   Thu, 24 Feb 2022 15:08:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2] remoteproc: support self recovery after rproc crash
Content-Language: en-US
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Peng Fan <peng.fan@nxp.com>
References: <20220126085120.3397450-1-peng.fan@oss.nxp.com>
 <67ddf940-6f87-d8cc-8dc6-29a39a022265@foss.st.com>
In-Reply-To: <67ddf940-6f87-d8cc-8dc6-29a39a022265@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-24_02,2022-02-24_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On 2/14/22 19:41, Arnaud POULIQUEN wrote:
> Hi Peng,
> 
> On 1/26/22 09:51, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> Current logic only support main processor to stop/start the remote
>> processor after rproc crash. However to SoC, such as i.MX8QM/QXP, the
>> remote processor could do self recovery after crash and trigger watchdog
>> reboot. It does not need main processor to load image, stop/start M4
>> core.
> 
> 
> On stm32mp1 platform the remote processor watchdog generates an early interrupt
> that could be used to detach and reattach before the reset of the remote processor.
> I need to test race condition,but I suppose that this should works if the resource
> table is not reinitialized by the remote processor firmware.
> 
> Another option for the stm32mp1 is that remoteproc manages the reset of the 
> remote processor.
> For instance this allows to save a core-dump before manually resetting the remote
> processor.
> But looks like this use case can be handled later, as mentioned below. 
> 
>>
>> This patch add a new flag to indicate whether the SoC has self recovery
>> capability. And introduce two functions: rproc_self_recovery,
>> rproc_assisted_recovery for the two cases. Assisted recovery is as
>> before, let main processor to help recovery, while self recovery is
>> recover itself withou help. To self recovery, we only do detach and
>> attach.
> 
> 
>>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>
>> V2:
>>  Nothing change in V2.
>>  Only move this patch out from
>>  https://patchwork.kernel.org/project/linux-remoteproc/list/?series=604364
>>
>>  drivers/remoteproc/remoteproc_core.c | 66 ++++++++++++++++++++--------
>>  include/linux/remoteproc.h           |  2 +
>>  2 files changed, 49 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>> index 69f51acf235e..4bd5544dab8f 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -1887,6 +1887,49 @@ static int __rproc_detach(struct rproc *rproc)
>>  	return 0;
>>  }
>>  
>> +static int rproc_self_recovery(struct rproc *rproc)
>> +{
>> +	int ret;
>> +
>> +	mutex_unlock(&rproc->lock);
>> +	ret = rproc_detach(rproc);
>> +	mutex_lock(&rproc->lock);
>> +	if (ret)
>> +		return ret;
> 
> Here we would want to perform a core dump and manually reset the
> co-processor.
> I suppose that a new rproc ops could be called here in a next step.
> 
>> +
>> +	if (atomic_inc_return(&rproc->power) > 1)
>> +		return 0;
> 
> Do you identify a use case that needs to test rproc->power to
> skip the attach?
> If yes could you add a comment to describe it?
> 
>> +	return rproc_attach(rproc);
>> +}
>> +
>> +static int rproc_assisted_recovery(struct rproc *rproc)
>> +{
>> +	const struct firmware *firmware_p;
>> +	struct device *dev = &rproc->dev;
>> +	int ret;
>> +
>> +	ret = rproc_stop(rproc, true);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* generate coredump */
>> +	rproc->ops->coredump(rproc);
>> +
>> +	/* load firmware */
>> +	ret = request_firmware(&firmware_p, rproc->firmware, dev);
>> +	if (ret < 0) {
>> +		dev_err(dev, "request_firmware failed: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* boot the remote processor up again */
>> +	ret = rproc_start(rproc, firmware_p);
>> +
>> +	release_firmware(firmware_p);
>> +
>> +	return ret;
>> +}
>> +
>>  /**
>>   * rproc_trigger_recovery() - recover a remoteproc
>>   * @rproc: the remote processor
>> @@ -1901,7 +1944,6 @@ static int __rproc_detach(struct rproc *rproc)
>>   */
>>  int rproc_trigger_recovery(struct rproc *rproc)
>>  {
>> -	const struct firmware *firmware_p;
>>  	struct device *dev = &rproc->dev;
>>  	int ret;
>>  
>> @@ -1915,24 +1957,10 @@ int rproc_trigger_recovery(struct rproc *rproc)
>>  
>>  	dev_err(dev, "recovering %s\n", rproc->name);
>>  
>> -	ret = rproc_stop(rproc, true);
>> -	if (ret)
>> -		goto unlock_mutex;
>> -
>> -	/* generate coredump */
>> -	rproc->ops->coredump(rproc);
>> -
>> -	/* load firmware */
>> -	ret = request_firmware(&firmware_p, rproc->firmware, dev);
>> -	if (ret < 0) {
>> -		dev_err(dev, "request_firmware failed: %d\n", ret);
>> -		goto unlock_mutex;
>> -	}
>> -
>> -	/* boot the remote processor up again */
>> -	ret = rproc_start(rproc, firmware_p);
>> -
>> -	release_firmware(firmware_p);
>> +	if (rproc->self_recovery)
>> +		ret = rproc_self_recovery(rproc);
> 
> If some platforms have to manually reset the remote processor (without
> reloading the firmware) the name could not be relevant...
> 
> Following comments are only suggestions that needs to be commented by maintainers
> 
> What about rproc_attach_recovery ?
> 
>> +	else
>> +		ret = rproc_assisted_recovery(rproc);
> 
> and rproc_firmware_recovery ?
> 
> 
>>  
>>  unlock_mutex:
>>  	mutex_unlock(&rproc->lock);
>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>> index e0600e1e5c17..b32ef46f8aa4 100644
>> --- a/include/linux/remoteproc.h
>> +++ b/include/linux/remoteproc.h
>> @@ -529,6 +529,7 @@ struct rproc_dump_segment {
>>   * @elf_machine: firmware ELF machine
>>   * @cdev: character device of the rproc
>>   * @cdev_put_on_release: flag to indicate if remoteproc should be shutdown on @char_dev release
>> + * @self_recovery: flag to indicate if remoteproc support self recovery
>>   */
>>  struct rproc {
>>  	struct list_head node;
>> @@ -568,6 +569,7 @@ struct rproc {
>>  	u16 elf_machine;
>>  	struct cdev cdev;
>>  	bool cdev_put_on_release;
>> +	bool self_recovery;
> 
> This bool seems needed because we have lost the previous state before crash. 
> I wonder if a new rproc->state such as RPROC_REBOOT could avoid this boolean.
> 
> 
> I will try to test you patch on stm32mp1 next week

I performed few tests on the stm32mp1 with your patch.
Thanks to the resetting of the resource tables on detachment, this works quite well.

Regards,
Arnaud

> 
> Regards,
> Arnaud
> 
>>  };
>>  
>>  /**
