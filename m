Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B6C492C54
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347234AbiARR1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:27:52 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58604 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1347220AbiARR1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:27:48 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20IEwo2Z009619;
        Tue, 18 Jan 2022 18:27:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=66YE/3TG3VhtiMv2Yzzla3MmHYUgrOKEt7gFyNU1aBk=;
 b=vmNskqtgMKI1F9xGZiCra2/yrFeIuaMaIlRVpiIdNTgTCTm2/5+/UHwbMhqTk8mvjnqI
 AEOVz2l1qUb6s3FZ7av4mV10fw+Lz0veJNWIhYSb25IXTLS8E+1yhE0Ayj8jhXd+DZ23
 Mk6BKYeYkavXBs7XXopWEEj5ec9qK5Vx92xCUe4WCRbbrSDWMMDXtK6KJCiwclUA2CjC
 mu6zCEliB3qCOZDdfgge1K/i2mGx2d/vwknEoMGjZv7QYPImmWdpqDfMXzFtsQea7/03
 5WxlnZmki3dDgDpZoBozUqRwsjKbtejGFJKqtYek800+9W7yjbGBRQDNzNuMBxkanhP2 fQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dnkesmqhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 18:27:45 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6EDCC10002A;
        Tue, 18 Jan 2022 18:27:44 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node1.st.com [10.75.127.4])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5D67F21FE8B;
        Tue, 18 Jan 2022 18:27:44 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.48) by SFHDAG2NODE1.st.com
 (10.75.127.4) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 18 Jan
 2022 18:27:43 +0100
Subject: Re: [PATCH v8 11/13] rpmsg: char: Introduce the "rpmsg-raw" channel
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <julien.massot@iot.bzh>
References: <20211207080843.21222-1-arnaud.pouliquen@foss.st.com>
 <20211207080843.21222-12-arnaud.pouliquen@foss.st.com>
 <YeX13cUAerjCM5Li@builder.lan>
 <6db32381-6615-3916-088a-d1cd27e3443a@foss.st.com>
 <YebQhrO+l6J+w9Hj@builder.lan>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Message-ID: <96c528ff-9857-be6b-cd5b-7b5d565e1e7e@foss.st.com>
Date:   Tue, 18 Jan 2022 18:27:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YebQhrO+l6J+w9Hj@builder.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE1.st.com
 (10.75.127.4)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-18_05,2022-01-18_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/22 3:36 PM, Bjorn Andersson wrote:
> On Tue 18 Jan 05:04 CST 2022, Arnaud POULIQUEN wrote:
> 
>>
>>
>> On 1/18/22 12:03 AM, Bjorn Andersson wrote:
>>> On Tue 07 Dec 02:08 CST 2021, Arnaud Pouliquen wrote:
>>>
>>>> Allows to probe the endpoint device on a remote name service announcement,
>>>> by registering a rpmsg_driverfor the "rpmsg-raw" channel.
> 
> Thought of this after replying yesterday, I really would like this to be
> updated to include an explanation of _why_ this is a good thing. What is
> the use case etc.

Not sure to understand your point here. Do you mean that "Allows to probe the
endpoint device on a remote name service announcement" is not a sufficient
reason?
Would the following explanation address your concern?

"
For the rpmsg virtio backend, the current implementation of the rpmsg char
only allows to instantiate static(i.e. prefixed source and destination addresses)
end points, and only on the Linux user space initiative.

This patch defines the the "rpmsg-raw" channel and register it to the rpmsg bus.
This registration allows:
- To create the channel at the initiative of the remote proc initiative relying 
on the name service announcement mechanism.
- To use the channel object instead of the endpoint, thus preventing the user 
space from having the knowledge of the remote processor's endpoint addresses.
- To rely on udev to be inform when a /dev/rpmsgX is created on remote processor 
request, indicating that the remote processor is ready to communicate.
"

> 
>>>>
>>>> With this patch the /dev/rpmsgX interface can be instantiated by the remote
>>>> firmware.
> 
> It would be nice if this mentioned why you can rely on udev events and
> rpmsgexport.
> 

By rpmsgexport you mean the tool available on your github to create a endpoint?
Could you details what you have in mind? I don't see a relationship with
this patch.

>>>>
>>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>>>> ---
>>>>    drivers/rpmsg/rpmsg_char.c | 64 ++++++++++++++++++++++++++++++++++++++
>>>>    drivers/rpmsg/rpmsg_ctrl.c |  7 +++--
>>>>    2 files changed, 69 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
>>>> index cf97839f5833..92b44630e03a 100644
>>>> --- a/drivers/rpmsg/rpmsg_char.c
>>>> +++ b/drivers/rpmsg/rpmsg_char.c
>>>> @@ -435,6 +435,58 @@ int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent
>>>>    }
>>>>    EXPORT_SYMBOL(rpmsg_chrdev_eptdev_create);
>>>> +static int rpmsg_chrdev_probe(struct rpmsg_device *rpdev)
>>>> +{
>>>> +	struct rpmsg_channel_info chinfo;
>>>> +	struct rpmsg_eptdev *eptdev;
>>>> +	struct device *dev = &rpdev->dev;
>>>> +
>>>> +	memcpy(chinfo.name, rpdev->id.name, RPMSG_NAME_SIZE);
>>>> +	chinfo.src = rpdev->src;
>>>> +	chinfo.dst = rpdev->dst;
>>>> +
>>>> +	eptdev = rpmsg_chrdev_eptdev_alloc(rpdev, dev);
>>>> +	if (IS_ERR(eptdev))
>>>> +		return PTR_ERR(eptdev);
>>>> +
>>>> +	/*
>>>> +	 * Create the default endpoint associated to the rpmsg device and provide rpmsg_eptdev
>>>> +	 * structure as callback private data.
>>>
>>> If the only this the probe function does is to create a new endpoint
>>> with the same properties as the rpdev, why can't you just specify a
>>> callback on the rpmsg_chrdev_driver?
>>>
>>> As this isn't the typical way you create a default endpoint I think the
>>> reasoning behind this warrants a proper explanation in the commit
>>> message.
>>>
>>
>> As mentioned in [PATCH v8 09/13] rpmsg: Introduce rpmsg_create_default_ept function
>> "This helper function allows rpmsg drivers to create a default endpoint
>> on runtime with an associated private context."
>>
>> Here the private context is the eptdev structure. I need to create the
>> structure first, before
>> the endpoint.
>> I will add more details in the commit message as you suggest.
> 
> Okay, I think the important part to document is _why_ this has to happen
> in this order - in particular since I suspect that this reason might not
> be unique to this driver.

Right.
In the rpmsg-client-sample implementation [1], the endpoint callback uses the 
dev_get_drvdata to retrieve the device context.
If the dev->driver_data is used for some other purpose (this is the case for the 
rpmsg char) you need to use the "*priv" parameter.

The rpmsg-core seems expecting implementation based dev->driver_data use, when 
use rpmsg bus probing mechanism.

[1] 
https://elixir.bootlin.com/linux/latest/source/samples/rpmsg/rpmsg_client_sample.c#L29

> 
>>
>> An alternative could be to directly set default_ept->priv but as the
>> rpmsg_create_default_ept
>> "priv" parameter is forwarded to the rpmsg backend (using create_ept ops).
>> This could introduces unexpected side effect.
>>
> 
> I'm not sure I understand the unexpected side effect of reassigning priv
> here.

I have no concrete use case in mind just that the priv parameter is provided to
the rpmsg backend. My assumption is that, calling rpmsg_create_ept function, there
is no protection from the use of the priv parameter in backend for some other 
purpose.
As the rpmsg_dev_probe calls rpmsg_create_ept with priv = NULL, This parameter will
not be sent by the backend.
But perhaps this is some over protection?
Please just tell me if you prefer that I suppress rpmsg_create_default_ept API and
set directly the default_ept->priv field.

Regards,
Arnaud

> 
> Regards,
> Bjorn
> 
>>>> +	 * Do not allow the creation and release of an endpoint on /dev/rpmsgX open and close,
>>>> +	 * reuse the default endpoint instead
>>>
>>> This sentence doesn't tell me anything about this code snippet and
>>> doesn't indicate that it relates to the snippet added elsewhere in this
>>> file by the previous patch.
>>>
>>>> +	 */
>>>> +	eptdev->default_ept = rpmsg_create_default_ept(rpdev, rpmsg_ept_cb, eptdev, chinfo);
>>>> +	if (!eptdev->default_ept) {
>>>> +		dev_err(&rpdev->dev, "failed to create %s\n", chinfo.name);
>>>> +		put_device(dev);
>>>> +		kfree(eptdev);
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	return rpmsg_chrdev_eptdev_add(eptdev, chinfo);
>>>> +}
>>>> +
>>>> +static void rpmsg_chrdev_remove(struct rpmsg_device *rpdev)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	ret = device_for_each_child(&rpdev->dev, NULL, rpmsg_chrdev_eptdev_destroy);
>>>> +	if (ret)
>>>> +		dev_warn(&rpdev->dev, "failed to destroy endpoints: %d\n", ret);
>>>> +}
>>>> +
>>>> +static struct rpmsg_device_id rpmsg_chrdev_id_table[] = {
>>>> +	{ .name	= "rpmsg-raw" },
>>>> +	{ },
>>>> +};
>>>> +
>>>> +static struct rpmsg_driver rpmsg_chrdev_driver = {
>>>> +	.probe = rpmsg_chrdev_probe,
>>>> +	.remove = rpmsg_chrdev_remove,
>>>> +	.id_table = rpmsg_chrdev_id_table,
>>>> +	.drv.name = "rpmsg_chrdev",
>>>> +};
>>>> +
>>>>    static int rpmsg_chrdev_init(void)
>>>>    {
>>>>    	int ret;
>>>> @@ -445,12 +497,24 @@ static int rpmsg_chrdev_init(void)
>>>>    		return ret;
>>>>    	}
>>>> +	ret = register_rpmsg_driver(&rpmsg_chrdev_driver);
>>>> +	if (ret < 0) {
>>>> +		pr_err("rpmsg: failed to register rpmsg raw driver\n");
>>>> +		goto free_region;
>>>> +	}
>>>> +
>>>>    	return 0;
>>>> +
>>>> +free_region:
>>>> +	unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
>>>> +
>>>> +	return ret;
>>>>    }
>>>>    postcore_initcall(rpmsg_chrdev_init);
>>>>    static void rpmsg_chrdev_exit(void)
>>>>    {
>>>> +	unregister_rpmsg_driver(&rpmsg_chrdev_driver);
>>>>    	unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
>>>>    }
>>>>    module_exit(rpmsg_chrdev_exit);
>>>> diff --git a/drivers/rpmsg/rpmsg_ctrl.c b/drivers/rpmsg/rpmsg_ctrl.c
>>>> index 59d2bd264fdb..298e75dc7774 100644
>>>> --- a/drivers/rpmsg/rpmsg_ctrl.c
>>>> +++ b/drivers/rpmsg/rpmsg_ctrl.c
>>>> @@ -10,6 +10,9 @@
>>>>     * Based on rpmsg performance statistics driver by Michal Simek, which in turn
>>>>     * was based on TI & Google OMX rpmsg driver.
>>>>     */
>>>> +
>>>> +#define pr_fmt(fmt)		KBUILD_MODNAME ": " fmt
>>>
>>> These changes seems unrelated to above.
>>
>> I apparently broke something in my patchset here during a rebase. The previous
>> irrelevant comment you pointed out to me is also a consequence. My apologies
>> for this dirty patch...
>>
>> Thanks,
>> Arnaud
>>
>>>
>>> Regards,
>>> Bjorn
>>>
>>>> +
>>>>    #include <linux/cdev.h>
>>>>    #include <linux/device.h>
>>>>    #include <linux/fs.h>
>>>> @@ -193,13 +196,13 @@ static int rpmsg_ctrldev_init(void)
>>>>    	ret = alloc_chrdev_region(&rpmsg_major, 0, RPMSG_DEV_MAX, "rpmsg_ctrl");
>>>>    	if (ret < 0) {
>>>> -		pr_err("rpmsg: failed to allocate char dev region\n");
>>>> +		pr_err("failed to allocate char dev region\n");
>>>>    		return ret;
>>>>    	}
>>>>    	ret = register_rpmsg_driver(&rpmsg_ctrldev_driver);
>>>>    	if (ret < 0) {
>>>> -		pr_err("rpmsg ctrl: failed to register rpmsg driver\n");
>>>> +		pr_err("failed to register rpmsg driver\n");
>>>>    		unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
>>>>    	}
>>>> -- 
>>>> 2.17.1
>>>>
