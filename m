Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC83F4F63E1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbiDFPtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237334AbiDFPsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:48:21 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8DD4781C6;
        Wed,  6 Apr 2022 06:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649250471; x=1680786471;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IHd+NLZREeqx4UE9sFXsjEcbaAa5I96BAyNN4S3AmjU=;
  b=YZTlJeQKqCxXfv/XAIX0fTwLZERgAnJvWUJ/K04tRhhYR6osg8bNvk5u
   7rQKlvhd+1OKPifbNuw3+Tg4quji5ki7GWXZ5rt1o2rBBaG90CthVGwaR
   5rFep5dp8ePPh8jwn7OhlEqNi/kBWi5UtGY3fv/nh+JN4GQ7uLm/Ct/v6
   c=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 06 Apr 2022 04:38:31 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 04:38:31 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 6 Apr 2022 04:38:30 -0700
Received: from [10.216.29.113] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 6 Apr 2022
 04:38:25 -0700
Message-ID: <d23b7674-214f-10f4-d669-5de32c82152f@quicinc.com>
Date:   Wed, 6 Apr 2022 17:08:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V1 3/3] rpmsg: glink: Add lock for ctrl device
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <swboyd@chromium.org>, <quic_clew@quicinc.com>,
        <mathieu.poirier@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        "Ohad Ben-Cohen" <ohad@wizery.com>
References: <1643223886-28170-1-git-send-email-quic_deesin@quicinc.com>
 <1643223886-28170-4-git-send-email-quic_deesin@quicinc.com>
 <Yiu3Fl/Diw5iqh24@builder.lan>
From:   Deepak Kumar Singh <quic_deesin@quicinc.com>
In-Reply-To: <Yiu3Fl/Diw5iqh24@builder.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/12/2022 2:24 AM, Bjorn Andersson wrote:
> On Wed 26 Jan 13:04 CST 2022, Deepak Kumar Singh wrote:
>
>> Race between rpmsg_eptdev_create and rpmsg_chrdev_remove
>> can sometime casue crash while accessing rpdev while new
>> endpoint is being created. Using lock ensure no new eptdev
>> is created after rpmsg_chrdev_remove has been completed.
> This patch lacks a Signed-off-by.
I will correct that in next patch.
> Isn't this solving the same problem as the previous patch? Would be nice
> with some more specifics on the race that you're seeing.
>
> Thanks,
> Bjorn

Issue was observed after having patch 2, in reboot test case.

Here observation was, user space daemon was able to create rpmsg0 device 
through

ctrl device and it was in process of rpmsg_eptdev_create() but as such 
ept creation was not yet done.

At the same time rpmsg_chrdev_remove() call happened which caused ctrl 
device to be freed.

backtrace of crash -

rpmsg_create_ept+0x40/0xa0
rpmsg_eptdev_open+0x88/0x138
chrdev_open+0xc4/0x1c8
do_dentry_open+0x230/0x378
vfs_open+0x3c/0x48
path_openat+0x93c/0xa78
do_filp_open+0x98/0x118
do_sys_openat2+0x90/0x220
do_sys_open+0x64/0x8c

>> ---
>>   drivers/rpmsg/rpmsg_char.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
>> index 2108ef8..3e5b85d 100644
>> --- a/drivers/rpmsg/rpmsg_char.c
>> +++ b/drivers/rpmsg/rpmsg_char.c
>> @@ -27,6 +27,7 @@
>>   
>>   static dev_t rpmsg_major;
>>   static struct class *rpmsg_class;
>> +struct mutex ctrl_lock;
>>   
>>   static DEFINE_IDA(rpmsg_ctrl_ida);
>>   static DEFINE_IDA(rpmsg_ept_ida);
>> @@ -396,9 +397,12 @@ static int rpmsg_eptdev_create(struct rpmsg_ctrldev *ctrldev,
>>   	struct device *dev;
>>   	int ret;
>>   
>> +	mutex_lock(&ctrl_lock);
>>   	eptdev = kzalloc(sizeof(*eptdev), GFP_KERNEL);
>> -	if (!eptdev)
>> +	if (!eptdev) {
>> +		mutex_unlock(&ctrl_lock);
>>   		return -ENOMEM;
>> +	}
>>   
>>   	dev = &eptdev->dev;
>>   	eptdev->rpdev = rpdev;
>> @@ -443,6 +447,7 @@ static int rpmsg_eptdev_create(struct rpmsg_ctrldev *ctrldev,
>>   		put_device(dev);
>>   	}
>>   
>> +	mutex_unlock(&ctrl_lock);
>>   	return ret;
>>   
>>   free_ept_ida:
>> @@ -453,6 +458,7 @@ static int rpmsg_eptdev_create(struct rpmsg_ctrldev *ctrldev,
>>   	put_device(dev);
>>   	kfree(eptdev);
>>   
>> +	mutex_unlock(&ctrl_lock);
>>   	return ret;
>>   }
>>   
>> @@ -525,6 +531,7 @@ static int rpmsg_chrdev_probe(struct rpmsg_device *rpdev)
>>   	if (!ctrldev)
>>   		return -ENOMEM;
>>   
>> +	mutex_init(&ctrl_lock);
>>   	ctrldev->rpdev = rpdev;
>>   
>>   	dev = &ctrldev->dev;
>> @@ -581,12 +588,14 @@ static void rpmsg_chrdev_remove(struct rpmsg_device *rpdev)
>>   	int ret;
>>   
>>   	/* Destroy all endpoints */
>> +	mutex_lock(&ctrl_lock);
>>   	ret = device_for_each_child(&ctrldev->dev, NULL, rpmsg_eptdev_destroy);
>>   	if (ret)
>>   		dev_warn(&rpdev->dev, "failed to nuke endpoints: %d\n", ret);
>>   
>>   	device_del(&ctrldev->dev);
>>   	put_device(&ctrldev->dev);
>> +	mutex_unlock(&ctrl_lock);
>>   }
>>   
>>   static struct rpmsg_driver rpmsg_chrdev_driver = {
>> -- 
>> 2.7.4
>>
