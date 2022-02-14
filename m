Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92A64B541F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355575AbiBNPCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:02:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236741AbiBNPCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:02:48 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EE83A8;
        Mon, 14 Feb 2022 07:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644850961; x=1676386961;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=b/l9XhxmWJuwJXbtAqLZh8lubtMHIPj4MEt7ZPXbeeA=;
  b=jOZlljZnR78wtUogngMqYxfSbVMIyKVKU7G5N8yZXYDASYL7ws9wfbTW
   ZvvHDIz4zjUP7PqCNi1oq6pW/dAsw2AmymoiUluxTuuftRlBG9ZXM+lrZ
   F69HkgjHQRZK6Or+2BUmoEL/2WUwLgNjTJ7BW97An5O2Lwy1+FI10sOk6
   0=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Feb 2022 07:02:40 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 07:02:40 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Feb 2022 07:02:40 -0800
Received: from [10.216.24.89] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 14 Feb
 2022 07:02:36 -0800
Subject: Re: [PATCH V1 1/3] rpmsg: glink: Free device context only when cdev
 not in use
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <bjorn.andersson@linaro.org>, <swboyd@chromium.org>,
        <quic_clew@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        "Ohad Ben-Cohen" <ohad@wizery.com>
References: <1643223886-28170-1-git-send-email-quic_deesin@quicinc.com>
 <1643223886-28170-2-git-send-email-quic_deesin@quicinc.com>
 <20220203173510.GA2982815@p14s>
From:   Deepak Kumar Singh <quic_deesin@quicinc.com>
Message-ID: <613d6852-f307-40f5-ccf0-7a73f1df8fb4@quicinc.com>
Date:   Mon, 14 Feb 2022 20:32:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220203173510.GA2982815@p14s>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/3/2022 11:05 PM, Mathieu Poirier wrote:
> Hi Deepak,
>
> On Thu, Jan 27, 2022 at 12:34:44AM +0530, Deepak Kumar Singh wrote:
>> Struct device holding cdev should not be freed unless cdev
>> is not in use. It is possible that user space has opened
>> char device while kernel has freed the associated struct
>> device context.
>>
>> Mark dev kobj as parent of cdev, so that chardev_add gets
>> an extra reference to dev. This ensures device context is not
>> freed until cdev is is not in uses.
>> ---
>>   drivers/rpmsg/rpmsg_char.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
>> index c03a118..72ee101 100644
>> --- a/drivers/rpmsg/rpmsg_char.c
>> +++ b/drivers/rpmsg/rpmsg_char.c
>> @@ -417,6 +417,7 @@ static int rpmsg_eptdev_create(struct rpmsg_ctrldev *ctrldev,
>>   	dev->id = ret;
>>   	dev_set_name(dev, "rpmsg%d", ret);
>>   
>> +	cdev_set_parent(&eptdev->cdev, &dev->kobj);
>>   	ret = cdev_add(&eptdev->cdev, dev->devt, 1);
> This issue should have been fixed when cdev_add() was replaced by
> cdev_device_add(), something you will find on v5.17-rc2.
>
> Also, this set is generating checkpatch warnings and as such I will not review
> the other patches in it.
>
> Thanks,
> Mathieu

Thank you Mathieu for info!! i will recheck other 2 patches for 
checkpatch warnings.

Thanks,

Deepak

>>   	if (ret)
>>   		goto free_ept_ida;
>> @@ -533,6 +534,7 @@ static int rpmsg_chrdev_probe(struct rpmsg_device *rpdev)
>>   	dev->id = ret;
>>   	dev_set_name(&ctrldev->dev, "rpmsg_ctrl%d", ret);
>>   
>> +	cdev_set_parent(&ctrldev->cdev, &dev->kobj);
>>   	ret = cdev_add(&ctrldev->cdev, dev->devt, 1);
>>   	if (ret)
>>   		goto free_ctrl_ida;
>> -- 
>> 2.7.4
>>
