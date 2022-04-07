Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266B44F8562
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345899AbiDGRAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbiDGRAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:00:41 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CA816BCE1;
        Thu,  7 Apr 2022 09:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649350719; x=1680886719;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lChw7ZZ4f2hLuY+s+NBoCPVu6Fj9AVLboT3sRkPZWA4=;
  b=BPJO2K8DOCpvtx5uHPFidvlHSoJUmh7KkAyNs44uDO4YLTU40Sq2qZlr
   l8p6xyunhfaF6103bVhGy0fdQq+mdAyuae4H+Bzoily3r+RFoYEfhydEl
   kdO8VIurz/iOpE5yvFJHdoAV7eb18nYE8z1mNKFCjC+2Wr0paRjWNIo0/
   I=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 07 Apr 2022 09:58:39 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 09:58:38 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Apr 2022 09:58:38 -0700
Received: from [10.216.58.168] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 7 Apr 2022
 09:58:32 -0700
Message-ID: <fef7733c-deb6-71a6-1b4f-3452257bc662@quicinc.com>
Date:   Thu, 7 Apr 2022 22:28:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V1 2/3] rpmsg: glink: Add lock to avoid race when rpmsg
 device is released
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <swboyd@chromium.org>, <quic_clew@quicinc.com>,
        <mathieu.poirier@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        "Ohad Ben-Cohen" <ohad@wizery.com>
References: <1643223886-28170-1-git-send-email-quic_deesin@quicinc.com>
 <1643223886-28170-3-git-send-email-quic_deesin@quicinc.com>
 <Yiu2nawUPxWYaIY3@builder.lan>
From:   Deepak Kumar Singh <quic_deesin@quicinc.com>
In-Reply-To: <Yiu2nawUPxWYaIY3@builder.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/12/2022 2:22 AM, Bjorn Andersson wrote:
> On Wed 26 Jan 13:04 CST 2022, Deepak Kumar Singh wrote:
>
>> When remote host goes down glink char device channel is freed,
>> At the same time user space apps can still try to open rpmsg_char
>> device which will result in calling rpmsg_create_ept. This may cause
>> reference to already freed context of glink chardev channel.
>>
> Hi Deepak,
>
> Could you please be a little bit more specific on the details of where
> you're seeing this race? Perhaps I'm just missing something obvious?

Crash is observed in reboot test case.

Log prints suggested that ept was destroyed just before crash in 
rpmsg_eptdev_create().

Below code was executed before crash -

static int rpmsg_eptdev_destroy(struct device *dev, void *data)
{
     struct rpmsg_eptdev *eptdev = dev_to_eptdev(dev);

     mutex_lock(&eptdev->ept_lock);
     if (eptdev->ept) {
         rpmsg_destroy_ept(eptdev->ept);
         eptdev->ept = NULL;
     }
     mutex_unlock(&eptdev->ept_lock);

     /* wake up any blocked readers */
     wake_up_interruptible(&eptdev->readq);

     device_del(&eptdev->dev);
     put_device(&eptdev->dev);

     return 0;
}

one crash was observed in rpmsg_eptdev_create() and other in 
rpmsg_eptdev_poll() -

1)

rpmsg_create_ept+0x40/0xa0
rpmsg_eptdev_open+0x88/0x138
chrdev_open+0xc4/0x1c8
do_dentry_open+0x230/0x378
vfs_open+0x3c/0x48
path_openat+0x93c/0xa78
do_filp_open+0x98/0x118
do_sys_openat2+0x90/0x220
do_sys_open+0x64/0x8c

2)

rpmsg_poll+0x5c/0x80
rpmsg_eptdev_poll+0x84/0xa4
do_sys_poll+0x22c/0x5c8

>> Use per ept lock to avoid race between rpmsg_destroy_ept and
>> rpmsg_destory_ept.
> I presume one of these should say rpmsg_eptdev_open().
yes, i will correct this in next patch.
> Regards,
> Bjorn
>
>> ---
>>   drivers/rpmsg/rpmsg_char.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
>> index 72ee101..2108ef8 100644
>> --- a/drivers/rpmsg/rpmsg_char.c
>> +++ b/drivers/rpmsg/rpmsg_char.c
>> @@ -85,6 +85,7 @@ static int rpmsg_eptdev_destroy(struct device *dev, void *data)
>>   	struct rpmsg_eptdev *eptdev = dev_to_eptdev(dev);
>>   
>>   	mutex_lock(&eptdev->ept_lock);
>> +	eptdev->rpdev = NULL;
>>   	if (eptdev->ept) {
>>   		rpmsg_destroy_ept(eptdev->ept);
>>   		eptdev->ept = NULL;
>> @@ -145,15 +146,24 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
>>   
>>   	get_device(dev);
>>   
>> +	mutex_lock(&eptdev->ept_lock);
>> +	if (!eptdev->rpdev) {
>> +		put_device(dev);
>> +		mutex_unlock(&eptdev->ept_lock);
>> +		return -ENETRESET;
>> +	}
>> +
>>   	ept = rpmsg_create_ept(rpdev, rpmsg_ept_cb, eptdev, eptdev->chinfo);
>>   	if (!ept) {
>>   		dev_err(dev, "failed to open %s\n", eptdev->chinfo.name);
>> +		mutex_unlock(&eptdev->ept_lock);
>>   		put_device(dev);
>>   		return -EINVAL;
>>   	}
>>   
>>   	ept->sig_cb = rpmsg_sigs_cb;
>>   	eptdev->ept = ept;
>> +	mutex_unlock(&eptdev->ept_lock);
>>   	filp->private_data = eptdev;
>>   
>>   	return 0;
>> @@ -285,7 +295,9 @@ static __poll_t rpmsg_eptdev_poll(struct file *filp, poll_table *wait)
>>   	if (eptdev->sig_pending)
>>   		mask |= EPOLLPRI;
>>   
>> +	mutex_lock(&eptdev->ept_lock);
>>   	mask |= rpmsg_poll(eptdev->ept, filp, wait);
>> +	mutex_unlock(&eptdev->ept_lock);
>>   
>>   	return mask;
>>   }
>> -- 
>> 2.7.4
>>
