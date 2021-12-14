Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E3F474034
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 11:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbhLNKPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 05:15:44 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:42008 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232910AbhLNKPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:15:44 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BE90PHA021201;
        Tue, 14 Dec 2021 11:15:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=nlbvaCpQQU3d8rdYZzHfsFBdcktl3fiaFrosAYYj4j8=;
 b=fEv2GzUAik9hz064aPegO+BHjhT79pdXStLPJSl73C6z0+mLA5o76esXkhCq4jDSDdCk
 RdXa6qG4tC+YHcB1w+gJYGxVIwXh5iCNnSpX3+GLnwN7LcBbWbR8lAX1Zvf7Kuwz8H+7
 bgDzYBypk1HN5aa5JJmQTfyYL++Y/UGQc9bQfBtq3xcTckh+LSCuAMNt3Nz4ACDOBI9/
 gRbycwczmUfrhe1/n36gBhQPwnHKwnO+wU6xtHdKY4Kk+E7mj06+26hN1YY3kz9qyWX0
 BrZsrRvP5N+87plQxCu9Wkc4Qfk3d6FouUCQ/xd7gpK8HQi44hgdfPoZ+BiEqIiLVsUS 6w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cxr8r8gy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 11:15:30 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4777910002A;
        Tue, 14 Dec 2021 11:15:28 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2B41222C8A9;
        Tue, 14 Dec 2021 11:15:28 +0100 (CET)
Received: from lmecxl0993.lme.st.com (10.75.127.48) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 14 Dec
 2021 11:15:27 +0100
Subject: Re: [PATCH] drm/stm: remove conflicting framebuffers
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20211206134735.13537-1-yannick.fertre@foss.st.com>
 <10c5672d-a228-ed9e-2f32-1ce9ae86dbcc@suse.de>
From:   Philippe CORNU <philippe.cornu@foss.st.com>
Message-ID: <58cc264b-7b46-7869-1c38-f6d79a4daafe@foss.st.com>
Date:   Tue, 14 Dec 2021 11:15:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <10c5672d-a228-ed9e-2f32-1ce9ae86dbcc@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-14_05,2021-12-14_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/21 3:23 PM, Thomas Zimmermann wrote:
> Hi
> 
> Am 06.12.21 um 14:47 schrieb Yannick Fertre:
>> In case of using simplefb or another conflicting framebuffer,
>> call drm_aperture_remove_framebuffers() to remove memory allocated.
>>
>> Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
> 
> The patch should have contained a note that this is version 2 of the 
> change with a short changelog. Anyway
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> Best regards
> Thomas
> 
>> ---
>>   drivers/gpu/drm/stm/drv.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
>> index 222869b232ae..9f441aadf2d5 100644
>> --- a/drivers/gpu/drm/stm/drv.c
>> +++ b/drivers/gpu/drm/stm/drv.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/of_platform.h>
>>   #include <linux/pm_runtime.h>
>> +#include <drm/drm_aperture.h>
>>   #include <drm/drm_atomic.h>
>>   #include <drm/drm_atomic_helper.h>
>>   #include <drm/drm_drv.h>
>> @@ -183,6 +184,10 @@ static int stm_drm_platform_probe(struct 
>> platform_device *pdev)
>>       DRM_DEBUG("%s\n", __func__);
>> +    ret = drm_aperture_remove_framebuffers(false, &drv_driver);
>> +    if (ret)
>> +        return ret;
>> +

Hi Yannick,
and many thanks for your patch.
Acked-by: Philippe Cornu <philippe.cornu@foss.st.com>
Philippe :-)


>>       dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
>>       ddev = drm_dev_alloc(&drv_driver, dev);
>>
> 
