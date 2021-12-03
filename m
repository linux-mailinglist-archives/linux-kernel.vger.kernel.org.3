Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91BDD467BB6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 17:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358377AbhLCQqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 11:46:54 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:40618 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S245669AbhLCQqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 11:46:53 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B3FngCP031187;
        Fri, 3 Dec 2021 17:43:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=14gU7KjU7XkjIOxmLUkvV7q1U/vPiqpUmVLR/EhFkBs=;
 b=6vWInydyU6TUtdNbEknZHfEgU5t2x+oxmwHlg8OJAv6XQjH8/IY7arCusGZPiOsjsArk
 AFCbKpGzLV0D4HuEbitbtqfG80YGccnY/bitZu71f8QQ//bHX1XW3/FIWRU5PiFXvBba
 wqEP9ZpbLr1eeSUnYltGQ3RKl/EShBbc/dYuclc/+E/ITv29QDRarlNlXNsNiq5ZAo3y
 p8y3XNWmK7pdIo0RuE8eCFTFQnGBsk0oCgJ8QKjd7xLBtwZdObb22PW93M8pMjonacMV
 jybWr3zckqw+0QX09uF2IhtPCcAxHnIJjDiKuhrVl8kQj0UvIgLeLoDnLsKQEL8KOsOF Kw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cqp7n07pk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 17:43:21 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 957AE10002A;
        Fri,  3 Dec 2021 17:43:20 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8D14220B3A2;
        Fri,  3 Dec 2021 17:43:20 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.45) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 3 Dec
 2021 17:43:19 +0100
Subject: Re: [PATCH v7 10/12] rpmsg: char: Introduce the "rpmsg-raw" channel
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <julien.massot@iot.bzh>
References: <20211108141937.13016-1-arnaud.pouliquen@foss.st.com>
 <20211108141937.13016-11-arnaud.pouliquen@foss.st.com>
 <Yal4XcCVa6GAQYkG@builder.lan>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Message-ID: <d7504c4c-ad9d-1124-6338-6da78aec9852@foss.st.com>
Date:   Fri, 3 Dec 2021 17:43:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Yal4XcCVa6GAQYkG@builder.lan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_07,2021-12-02_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/3/21 2:52 AM, Bjorn Andersson wrote:
> On Mon 08 Nov 08:19 CST 2021, Arnaud Pouliquen wrote:
> 
>> Allows to probe the endpoint device on a remote name service announcement,
>> by registering a rpmsg_driverfor the "rpmsg-raw" channel.
>>
>> With this patch the /dev/rpmsgX interface can be instantiated by the remote
>> firmware.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> ---
>>  drivers/rpmsg/rpmsg_char.c | 64 ++++++++++++++++++++++++++++++++++++++
>>  drivers/rpmsg/rpmsg_ctrl.c |  7 +++--
>>  2 files changed, 69 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
>> index 6a01e8e1c111..dd754c870ba1 100644
>> --- a/drivers/rpmsg/rpmsg_char.c
>> +++ b/drivers/rpmsg/rpmsg_char.c
>> @@ -432,6 +432,58 @@ int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent
>>  }
>>  EXPORT_SYMBOL(rpmsg_chrdev_eptdev_create);
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
>> +	 * Do not allow the creation and release of an endpoint on /dev/rpmsgX open and close,
>> +	 * reuse the default endpoint instead
>> +	 */
>> +	eptdev->default_ept = rpmsg_create_default_ept(rpdev, rpmsg_ept_cb, eptdev, chinfo);
>> +	if (!eptdev->default_ept) {
>> +		dev_err(&rpdev->dev, "failed to create %s\n", chinfo.name);
>> +		put_device(dev);
> 
> Which get_device() does this correlate to?

this is related to device_initialize [1]( and herited from the legacy
implementation of rpmsg_char)

[1]
https://elixir.bootlin.com/linux/v5.16-rc3/source/drivers/base/core.c#L2860

> 
>> +		kfree(eptdev);
> 
> After the device_initialize() in rpmsg_chrdev_eptdev_alloc() you're
> supposed to put_device() &eptdev->dev, which would kfree(eptdev)...

dev->release is set only in rpmsg_chrdev_eptdev_add. and calling
rpmsg_chrdev_eptdev_add at this level would need to handle the free of some
uninitialized parameters.

That why I directly free it here.

> 
> 
> Note though that rpmsg_eptdev_release_device() calls cdev_del(), which
> you can't do. It was however recently reported that this cdev_del()
> should be done in conjunction with the device_del() as the current
> implementation enables a race between release and fops->open.

I'm not sure to understand your point here. Is it related to your previous
comment concerning the use of put_device or do you expect something from me
specific in the around device_del and cdev_del?

Thanks,

Arnaud

> 
> Regards,
> Bjorn
> 
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
>>  static int rpmsg_chrdev_init(void)
>>  {
>>  	int ret;
>> @@ -442,12 +494,24 @@ static int rpmsg_chrdev_init(void)
>>  		return ret;
>>  	}
>>  
>> +	ret = register_rpmsg_driver(&rpmsg_chrdev_driver);
>> +	if (ret < 0) {
>> +		pr_err("rpmsg: failed to register rpmsg raw driver\n");
>> +		goto free_region;
>> +	}
>> +
>>  	return 0;
>> +
>> +free_region:
>> +	unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
>> +
>> +	return ret;
>>  }
>>  postcore_initcall(rpmsg_chrdev_init);
>>  
>>  static void rpmsg_chrdev_exit(void)
>>  {
>> +	unregister_rpmsg_driver(&rpmsg_chrdev_driver);
>>  	unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
>>  }
>>  module_exit(rpmsg_chrdev_exit);
>> diff --git a/drivers/rpmsg/rpmsg_ctrl.c b/drivers/rpmsg/rpmsg_ctrl.c
>> index 59d2bd264fdb..298e75dc7774 100644
>> --- a/drivers/rpmsg/rpmsg_ctrl.c
>> +++ b/drivers/rpmsg/rpmsg_ctrl.c
>> @@ -10,6 +10,9 @@
>>   * Based on rpmsg performance statistics driver by Michal Simek, which in turn
>>   * was based on TI & Google OMX rpmsg driver.
>>   */
>> +
>> +#define pr_fmt(fmt)		KBUILD_MODNAME ": " fmt
>> +
>>  #include <linux/cdev.h>
>>  #include <linux/device.h>
>>  #include <linux/fs.h>
>> @@ -193,13 +196,13 @@ static int rpmsg_ctrldev_init(void)
>>  
>>  	ret = alloc_chrdev_region(&rpmsg_major, 0, RPMSG_DEV_MAX, "rpmsg_ctrl");
>>  	if (ret < 0) {
>> -		pr_err("rpmsg: failed to allocate char dev region\n");
>> +		pr_err("failed to allocate char dev region\n");
>>  		return ret;
>>  	}
>>  
>>  	ret = register_rpmsg_driver(&rpmsg_ctrldev_driver);
>>  	if (ret < 0) {
>> -		pr_err("rpmsg ctrl: failed to register rpmsg driver\n");
>> +		pr_err("failed to register rpmsg driver\n");
>>  		unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
>>  	}
>>  
>> -- 
>> 2.17.1
>>
