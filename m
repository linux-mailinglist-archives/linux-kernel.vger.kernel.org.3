Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356454923FA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 11:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237989AbiARKon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 05:44:43 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39418 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237931AbiARKom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 05:44:42 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20I97GDu009658;
        Tue, 18 Jan 2022 11:44:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=8tSOi6hFO4mBG1V3W8bMA0J9PppE7RMIf5SisFC//CI=;
 b=2rCtH5QP/v8r3GgsSoY6Pq3pXO6qXE4aw1ZZ0RrQW4IAynpj+Bo85F9ip/XsEgq/flNg
 7hQpCHpIon9MYzLQPpP+P6T+E38l6qM5l/FUo3QkYtb+icyvkRCNbxt5B0E6Fm/SEH9Q
 2rjVHQtzvmutThtVNwrmSlrR04YnfdBlodDAruT3tulCjOhgWAHUiaHcnDLlmw212XU2
 YvrOSGIVKRAMMk/rHzakdmqojXD+vkH5g7rIXRaFzkuk1V5RgWk0wanLgftTH0JOzbFO
 uqDFNidLjygE9+RCaKVZPIM4rNSNdYFZFP2hCr7G9ZIlMMquIw2J9ZFBieJ2orP+W+E4 tA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dnkesjnu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 11:44:33 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7D5BA10002A;
        Tue, 18 Jan 2022 11:44:32 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node1.st.com [10.75.127.4])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6A797211F15;
        Tue, 18 Jan 2022 11:44:32 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.50) by SFHDAG2NODE1.st.com
 (10.75.127.4) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 18 Jan
 2022 11:44:31 +0100
Subject: Re: [PATCH v8 03/13] rpmsg: Move the rpmsg control device from
 rpmsg_char to rpmsg_ctrl
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <julien.massot@iot.bzh>
References: <20211207080843.21222-1-arnaud.pouliquen@foss.st.com>
 <20211207080843.21222-4-arnaud.pouliquen@foss.st.com>
 <YeXz2SFqYr+eUvnw@builder.lan>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Message-ID: <cffe6884-2059-d1e7-7dfd-37c852924959@foss.st.com>
Date:   Tue, 18 Jan 2022 11:44:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YeXz2SFqYr+eUvnw@builder.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE1.st.com
 (10.75.127.4)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-18_03,2022-01-18_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bjorn,

On 1/17/22 11:55 PM, Bjorn Andersson wrote:
> On Tue 07 Dec 02:08 CST 2021, Arnaud Pouliquen wrote:
>> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> [..]
>> -static void rpmsg_ctrldev_release_device(struct device *dev)
>> -{
>> -	struct rpmsg_ctrldev *ctrldev = dev_to_ctrldev(dev);
>> -
>> -	ida_simple_remove(&rpmsg_ctrl_ida, dev->id);
>> -	ida_simple_remove(&rpmsg_minor_ida, MINOR(dev->devt));
>> -	cdev_del(&ctrldev->cdev);
>> -	kfree(ctrldev);
>> -}
>> -
>> -static int rpmsg_chrdev_probe(struct rpmsg_device *rpdev)
>> -{
>> -	struct rpmsg_ctrldev *ctrldev;
>> -	struct device *dev;
>> -	int ret;
>> -
>> -	ctrldev = kzalloc(sizeof(*ctrldev), GFP_KERNEL);
>> -	if (!ctrldev)
>> -		return -ENOMEM;
>> -
>> -	ctrldev->rpdev = rpdev;
>> -
>> -	dev = &ctrldev->dev;
>> -	device_initialize(dev);
>> -	dev->parent = &rpdev->dev;
>> -	dev->class = rpmsg_class;
>> -
>> -	cdev_init(&ctrldev->cdev, &rpmsg_ctrldev_fops);
>> -	ctrldev->cdev.owner = THIS_MODULE;
>> -
>> -	ret = ida_simple_get(&rpmsg_minor_ida, 0, RPMSG_DEV_MAX, GFP_KERNEL);
>> -	if (ret < 0)
>> -		goto free_ctrldev;
>> -	dev->devt = MKDEV(MAJOR(rpmsg_major), ret);
>> -
>> -	ret = ida_simple_get(&rpmsg_ctrl_ida, 0, 0, GFP_KERNEL);
>> -	if (ret < 0)
>> -		goto free_minor_ida;
>> -	dev->id = ret;
>> -	dev_set_name(&ctrldev->dev, "rpmsg_ctrl%d", ret);
>> -
>> -	ret = cdev_add(&ctrldev->cdev, dev->devt, 1);
> 
> This turns out to be incomplete and the cdev_del above is in the wrong
> place. This, and the same for eptdev, is being corrected in:
> 
> https://lore.kernel.org/linux-remoteproc/164245960510.1698571.4998090450663669237.b4-ty@linaro.org/T/#t

I will rebase on next branch including this patchset

Thanks,
Arnaud

> 
> Regards,
> Bjorn
> 
