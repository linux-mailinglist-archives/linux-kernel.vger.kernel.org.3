Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AE949243D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238498AbiARLEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:04:21 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52652 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238467AbiARLES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:04:18 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20I93Idc009646;
        Tue, 18 Jan 2022 12:04:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=RnzBcJkwn9+YhSqc0hY7vDRWf1fQflevXV2FqDpbpEM=;
 b=uNACs/CFWZr8UrsclxSvYEfM+tWpOkhLB4h5osJ/cboEtbhDb12mTcdcVNSN/X3v++jR
 tntX7O2AuJXk7oz3A5X9CtDt6/oHoGv8VB2Xh/u9IiZYiay2KP1F/cYo/8jKG3Pj8Jhq
 CUJHiKUa139ABHiQa7F+S3X6gRcLYPCVi6+u7CBByzkzZXm2uRhHcVn+TW4dlDhlZhOd
 rwvUTOyBu60cExxM/LAiSyfQvS8pnWvTmagTlPCvWFZjxlk5w6n2isqVdxo/thL0gt4s
 c1Fg2ECRIbzuLKqhFtVQGsVPFrmQEebdUnoTLPxEMoWDUFB2rE8g3Y1UskQOr5Nc9XeL iQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dnkesjs07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 12:04:14 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5BC8810002A;
        Tue, 18 Jan 2022 12:04:14 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node1.st.com [10.75.127.4])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5278321279B;
        Tue, 18 Jan 2022 12:04:14 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.51) by SFHDAG2NODE1.st.com
 (10.75.127.4) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 18 Jan
 2022 12:04:13 +0100
Subject: Re: [PATCH v8 11/13] rpmsg: char: Introduce the "rpmsg-raw" channel
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <julien.massot@iot.bzh>
References: <20211207080843.21222-1-arnaud.pouliquen@foss.st.com>
 <20211207080843.21222-12-arnaud.pouliquen@foss.st.com>
 <YeX13cUAerjCM5Li@builder.lan>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Message-ID: <6db32381-6615-3916-088a-d1cd27e3443a@foss.st.com>
Date:   Tue, 18 Jan 2022 12:04:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YeX13cUAerjCM5Li@builder.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE1.st.com
 (10.75.127.4)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-18_03,2022-01-18_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/22 12:03 AM, Bjorn Andersson wrote:
> On Tue 07 Dec 02:08 CST 2021, Arnaud Pouliquen wrote:
> 
>> Allows to probe the endpoint device on a remote name service announcement,
>> by registering a rpmsg_driverfor the "rpmsg-raw" channel.
>>
>> With this patch the /dev/rpmsgX interface can be instantiated by the remote
>> firmware.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> ---
>>   drivers/rpmsg/rpmsg_char.c | 64 ++++++++++++++++++++++++++++++++++++++
>>   drivers/rpmsg/rpmsg_ctrl.c |  7 +++--
>>   2 files changed, 69 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
>> index cf97839f5833..92b44630e03a 100644
>> --- a/drivers/rpmsg/rpmsg_char.c
>> +++ b/drivers/rpmsg/rpmsg_char.c
>> @@ -435,6 +435,58 @@ int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent
>>   }
>>   EXPORT_SYMBOL(rpmsg_chrdev_eptdev_create);
>>   
>> +static int rpmsg_chrdev_probe(struct rpmsg_device *rpdev)
>> +{
>> +	struct rpmsg_channel_info chinfo;
>> +	struct rpmsg_eptdev *eptdev;
>> +	struct device *dev = &rpdev->dev;
>> +
>> +	memcpy(chinfo.name, rpdev->id.name, RPMSG_NAME_SIZE);
>> +	chinfo.src = rpdev->src;
>> +	chinfo.dst = rpdev->dst;
>> +
>> +	eptdev = rpmsg_chrdev_eptdev_alloc(rpdev, dev);
>> +	if (IS_ERR(eptdev))
>> +		return PTR_ERR(eptdev);
>> +
>> +	/*
>> +	 * Create the default endpoint associated to the rpmsg device and provide rpmsg_eptdev
>> +	 * structure as callback private data.
> 
> If the only this the probe function does is to create a new endpoint
> with the same properties as the rpdev, why can't you just specify a
> callback on the rpmsg_chrdev_driver?
> 
> As this isn't the typical way you create a default endpoint I think the
> reasoning behind this warrants a proper explanation in the commit
> message.
> 

As mentioned in [PATCH v8 09/13] rpmsg: Introduce rpmsg_create_default_ept function
"This helper function allows rpmsg drivers to create a default endpoint
on runtime with an associated private context."

Here the private context is the eptdev structure. I need to create the structure 
first, before
the endpoint.
I will add more details in the commit message as you suggest.

An alternative could be to directly set default_ept->priv but as the 
rpmsg_create_default_ept
"priv" parameter is forwarded to the rpmsg backend (using create_ept ops).
This could introduces unexpected side effect.

>> +	 * Do not allow the creation and release of an endpoint on /dev/rpmsgX open and close,
>> +	 * reuse the default endpoint instead
> 
> This sentence doesn't tell me anything about this code snippet and
> doesn't indicate that it relates to the snippet added elsewhere in this
> file by the previous patch.
> 
>> +	 */
>> +	eptdev->default_ept = rpmsg_create_default_ept(rpdev, rpmsg_ept_cb, eptdev, chinfo);
>> +	if (!eptdev->default_ept) {
>> +		dev_err(&rpdev->dev, "failed to create %s\n", chinfo.name);
>> +		put_device(dev);
>> +		kfree(eptdev);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return rpmsg_chrdev_eptdev_add(eptdev, chinfo);
>> +}
>> +
>> +static void rpmsg_chrdev_remove(struct rpmsg_device *rpdev)
>> +{
>> +	int ret;
>> +
>> +	ret = device_for_each_child(&rpdev->dev, NULL, rpmsg_chrdev_eptdev_destroy);
>> +	if (ret)
>> +		dev_warn(&rpdev->dev, "failed to destroy endpoints: %d\n", ret);
>> +}
>> +
>> +static struct rpmsg_device_id rpmsg_chrdev_id_table[] = {
>> +	{ .name	= "rpmsg-raw" },
>> +	{ },
>> +};
>> +
>> +static struct rpmsg_driver rpmsg_chrdev_driver = {
>> +	.probe = rpmsg_chrdev_probe,
>> +	.remove = rpmsg_chrdev_remove,
>> +	.id_table = rpmsg_chrdev_id_table,
>> +	.drv.name = "rpmsg_chrdev",
>> +};
>> +
>>   static int rpmsg_chrdev_init(void)
>>   {
>>   	int ret;
>> @@ -445,12 +497,24 @@ static int rpmsg_chrdev_init(void)
>>   		return ret;
>>   	}
>>   
>> +	ret = register_rpmsg_driver(&rpmsg_chrdev_driver);
>> +	if (ret < 0) {
>> +		pr_err("rpmsg: failed to register rpmsg raw driver\n");
>> +		goto free_region;
>> +	}
>> +
>>   	return 0;
>> +
>> +free_region:
>> +	unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
>> +
>> +	return ret;
>>   }
>>   postcore_initcall(rpmsg_chrdev_init);
>>   
>>   static void rpmsg_chrdev_exit(void)
>>   {
>> +	unregister_rpmsg_driver(&rpmsg_chrdev_driver);
>>   	unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
>>   }
>>   module_exit(rpmsg_chrdev_exit);
>> diff --git a/drivers/rpmsg/rpmsg_ctrl.c b/drivers/rpmsg/rpmsg_ctrl.c
>> index 59d2bd264fdb..298e75dc7774 100644
>> --- a/drivers/rpmsg/rpmsg_ctrl.c
>> +++ b/drivers/rpmsg/rpmsg_ctrl.c
>> @@ -10,6 +10,9 @@
>>    * Based on rpmsg performance statistics driver by Michal Simek, which in turn
>>    * was based on TI & Google OMX rpmsg driver.
>>    */
>> +
>> +#define pr_fmt(fmt)		KBUILD_MODNAME ": " fmt
> 
> These changes seems unrelated to above.

I apparently broke something in my patchset here during a rebase. The previous
irrelevant comment you pointed out to me is also a consequence. My apologies for 
this dirty patch...

Thanks,
Arnaud

> 
> Regards,
> Bjorn
> 
>> +
>>   #include <linux/cdev.h>
>>   #include <linux/device.h>
>>   #include <linux/fs.h>
>> @@ -193,13 +196,13 @@ static int rpmsg_ctrldev_init(void)
>>   
>>   	ret = alloc_chrdev_region(&rpmsg_major, 0, RPMSG_DEV_MAX, "rpmsg_ctrl");
>>   	if (ret < 0) {
>> -		pr_err("rpmsg: failed to allocate char dev region\n");
>> +		pr_err("failed to allocate char dev region\n");
>>   		return ret;
>>   	}
>>   
>>   	ret = register_rpmsg_driver(&rpmsg_ctrldev_driver);
>>   	if (ret < 0) {
>> -		pr_err("rpmsg ctrl: failed to register rpmsg driver\n");
>> +		pr_err("failed to register rpmsg driver\n");
>>   		unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
>>   	}
>>   
>> -- 
>> 2.17.1
>>
