Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1952B50BBB2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449457AbiDVPa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449022AbiDVPaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:30:21 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116325BE59;
        Fri, 22 Apr 2022 08:27:26 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23MAS3Yl031297;
        Fri, 22 Apr 2022 17:27:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=nZHtT3YPV+o+qn98wXnsCHgW87blnKp+/OLF4y7h31c=;
 b=mgrQTr+F5KvZLi/8vTsMKxc+XL+H35wBs3L/3i/fZ6Xo9RtRclV1Oytn7iGnzoTG1ZUd
 P9sO0S5Ut4JUQ4uJ1E09xquIXdvKJKaVbc4EKXi90hko6b7eU+IdiKrXDqp05qPjKfX2
 iEJY3lPedtWG23GcPjh1tOtwsO8398arhwQ89lypbXfESN2PHUMgfahL7ucKopV3w3m0
 MYAsBGI6+O/zzdIDl6A5VYkN8h3j7GUgAttubLaPyKfUAQI6RemBdqfAEAr0fpnYTdIH
 uYlURhUgNT9f+qe2/k8q/HTtW5lyoSAgLQ0yDJ61rlIdhyap6fqnyq74wOPSw5JK2F9U 6Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ffpqe9xmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 17:27:24 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5F0AB10002A;
        Fri, 22 Apr 2022 17:27:23 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 576BE233C76;
        Fri, 22 Apr 2022 17:27:23 +0200 (CEST)
Received: from [10.201.20.246] (10.75.127.46) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 22 Apr
 2022 17:27:22 +0200
Message-ID: <6ee9254b-9481-be0e-1bb3-4d65b461f791@foss.st.com>
Date:   Fri, 22 Apr 2022 17:27:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] rpmsg: virtio: fix possible double free in
 rpmsg_virtio_add_ctrl_dev()
Content-Language: en-US
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
To:     Hangyu Hua <hbh25y@gmail.com>, <bjorn.andersson@linaro.org>,
        <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220418101724.42174-1-hbh25y@gmail.com>
 <64aed5f4-bc6b-b8ea-f599-b2c43e35d9bd@foss.st.com>
In-Reply-To: <64aed5f4-bc6b-b8ea-f599-b2c43e35d9bd@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_04,2022-04-22_01,2022-02-23_01
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/22/22 17:16, Arnaud POULIQUEN wrote:
> Hi Hangyu,
> 
> On 4/18/22 12:17, Hangyu Hua wrote:
>> vch will be free in virtio_rpmsg_release_device() when
>> rpmsg_ctrldev_register_device() fails. There is no need to call
>> kfree() again.
>>
>> Fixes: c486682ae1e2 ("rpmsg: virtio: Register the rpmsg_char device")
>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
>> ---
>>  drivers/rpmsg/virtio_rpmsg_bus.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
>> index 603233f0686e..3b7b47f785cf 100644
>> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
>> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
>> @@ -851,7 +851,6 @@ static struct rpmsg_device *rpmsg_virtio_add_ctrl_dev(struct virtio_device *vdev
>>  
>>  	err = rpmsg_ctrldev_register_device(rpdev_ctrl);
>>  	if (err) {
>> -		kfree(vch);
>>  		return ERR_PTR(err);
>>  	}
>>  
> 
> Good catch! I confirmed by testing the error case. There is a double free.
> 
> That said this highlight a quite more complex issue as
> rpmsg_virtio_del_ctrl_dev[1] and rpmsg_ns_register_device(rpdev_ns)error
> case[2] need also some improvements.
> 
> [1]
> https://elixir.bootlin.com/linux/v5.18-rc3/source/drivers/rpmsg/virtio_rpmsg_bus.c#L861
> [2]https://elixir.bootlin.com/linux/v5.18-rc3/source/drivers/rpmsg/virtio_rpmsg_bus.c#L974
> 
> Please find at the end of my mail a V2 patch that should fix more error
> cases.
> As you initiate the fix, do you want to send the V2 or do you prefer
> that I send the fix?


My apologies, I just saw your second patch[1], so what I have to do is to send a new one to fix
rpmsg_virtio_del_ctrl_dev()

[1]https://patchwork.kernel.org/project/linux-remoteproc/patch/20220418093144.40859-1-hbh25y@gmail.com/

For this one:
 Tested-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>

Regards
Arnaud

> 
> Thanks,
> Arnaud
> 
> Subject: [PATCH V2] rpmsg: virtio: fix possible double free in rpmsg_probe()
> 
> the virtio_rpmsg_channel structure will be free in
> virtio_rpmsg_release_device() when the device_register() fails or
> when device_unregister is called.
> There is no need to call kfree() again.
> 
> Fixes: c486682ae1e2 ("rpmsg: virtio: Register the rpmsg_char device")
> 
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/rpmsg/virtio_rpmsg_bus.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c
> b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 3ede25b1f2e4..a65c8be9b11f 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -850,10 +850,8 @@ static struct rpmsg_device
> *rpmsg_virtio_add_ctrl_dev(struct virtio_device *vdev
>  	rpdev_ctrl->little_endian = virtio_is_little_endian(vrp->vdev);
> 
>  	err = rpmsg_ctrldev_register_device(rpdev_ctrl);
> -	if (err) {
> -		kfree(vch);
> +	if (err)
>  		return ERR_PTR(err);
> -	}
> 
>  	return rpdev_ctrl;
>  }
> @@ -862,7 +860,7 @@ static void rpmsg_virtio_del_ctrl_dev(struct
> rpmsg_device *rpdev_ctrl)
>  {
>  	if (!rpdev_ctrl)
>  		return;
> -	kfree(to_virtio_rpmsg_channel(rpdev_ctrl));
> +	device_unregister(&rpdev_ctrl->dev);
>  }
> 
>  static int rpmsg_probe(struct virtio_device *vdev)
> @@ -973,7 +971,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
> 
>  		err = rpmsg_ns_register_device(rpdev_ns);
>  		if (err)
> -			goto free_vch;
> +			goto free_ctrldev;
>  	}
> 
>  	/*
> @@ -997,8 +995,6 @@ static int rpmsg_probe(struct virtio_device *vdev)
> 
>  	return 0;
> 
> -free_vch:
> -	kfree(vch);
>  free_ctrldev:
>  	rpmsg_virtio_del_ctrl_dev(rpdev_ctrl);
>  free_coherent:
