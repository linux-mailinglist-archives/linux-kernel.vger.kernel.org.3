Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E155546797E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 15:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381497AbhLCOiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 09:38:05 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57166 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1381466AbhLCOiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 09:38:04 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B3Cqcfi015449;
        Fri, 3 Dec 2021 15:34:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=VI2K8c0oDwm8vA1Za0Lg2QSYKD+dzfliBMxPDI725T4=;
 b=a3PBruJoaZ3xQ/99ImlBWmGtb5GcC+ckCtiEAN+uLKl2eSfnT48kNg1dXWsGjuT3daLM
 d3aDEMh0DF0fBuxhksHqu1dvACCq5S+IQwxRRb80X1sNghrH5QmZUZmvUmw+jpL74Qte
 KEFCvBcJ9vOv5Vc4h3zRmALrbLhEbRxcyHnFTyJrExqKnSkPnUCDTZihsE4m08xGKfP+
 E4lc6N20W6vxovjpi5jrClVG7zGzZEMiI85yykKU0DuNzH1cIWwtnuS+eiyR4+h2ob0m
 DtCct+MJz6BJleAOExGGo/F3lzWFEmYGTOZSzQ+mRZT2zkBBJ+xdMuKp3lu+ZUv6x7U/ CA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cqkmj0p9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 15:34:35 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CCBE510002A;
        Fri,  3 Dec 2021 15:34:34 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B186822E852;
        Fri,  3 Dec 2021 15:34:34 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.44) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 3 Dec
 2021 15:34:33 +0100
Subject: Re: [PATCH v2] rpmsg: virtio: don't let virtio core to validate used
 length
To:     Jason Wang <jasowang@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     "Michael S. Tsirkin" <mst@redhat.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        <linux-remoteproc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20211124162045.25983-1-arnaud.pouliquen@foss.st.com>
 <20211124161055-mutt-send-email-mst@kernel.org>
 <CACGkMEvQoUcPFgOTvEDGkZHMXhjhPrk0xq-Zq3+G20_Lp-hu8A@mail.gmail.com>
 <20211202170011.GA900071@p14s>
 <CACGkMEs5DWPT76U8KYdr385e0Y6EUQQRSfRMfR3ZZz34HBdVKA@mail.gmail.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Message-ID: <638350d2-9695-413d-a508-6b852a70f472@foss.st.com>
Date:   Fri, 3 Dec 2021 15:34:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CACGkMEs5DWPT76U8KYdr385e0Y6EUQQRSfRMfR3ZZz34HBdVKA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_07,2021-12-02_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/3/21 3:07 AM, Jason Wang wrote:
> On Fri, Dec 3, 2021 at 1:00 AM Mathieu Poirier
> <mathieu.poirier@linaro.org> wrote:
>>
>> Hey guys,
>>
>> On Thu, Nov 25, 2021 at 10:15:44AM +0800, Jason Wang wrote:
>>> On Thu, Nov 25, 2021 at 5:12 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>
>>>> On Wed, Nov 24, 2021 at 05:20:45PM +0100, Arnaud Pouliquen wrote:
>>>>> Using OpenAMP library on remote side, when the rpmsg framework tries to
>>>>> reuse the buffer the following error message is displayed in
>>>>> the virtqueue_get_buf_ctx_split function:
>>>>> "virtio_rpmsg_bus virtio0: output:used len 28 is larger than in buflen 0"
>>>>>
>>>>> As described in virtio specification:
>>>>> "many drivers ignored the len value, as a result, many devices set len
>>>>> incorrectly. Thus, when using the legacy interface, it is generally
>>>>> a good idea to ignore the len value in used ring entries if possible."
>>>>>
>>>>> To stay in compliance with the legacy libraries, this patch prevents the
>>>>> virtio core from validating used length.
>>>>>
>>>>> Fixes: 939779f5152d ("virtio_ring: validate used buffer length")
>>>>>
>>>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>>>>> Cc: Jason Wang <jasowang@redhat.com>
>>>>> Cc: Michael S. Tsirkin <mst@redhat.com>
>>>>> ---
>>>>
>>>> Arnaud, thanks a lot for the analysis.
>>>>
>>>> Jason, I think this is another good point. We really should not
>>>> validate input for legacy devices at all.
>>>
>>> I agree. Will do that in the next version.
>>
>> I'm a little unclear about the "next version" in the above comment - is this
>> something I should wait for?  Should I move forward with Arnaud's patch?
> 
> Just to make it clear. If my understanding is correct, my series was
> reverted so this patch is not needed.

Indeed your patchset is no longer in the v5.16-rc3

Thanks,
Arnaud

> 
> For "next version", I meant I will resend the new version of used
> length validation that
> 
> - only do the validation when it was explicitly enabled
> - warn instead of bug
> - do not validate legacy device
> 
> Thanks
> 
>>
>> Thanks,
>> Mathieu
>>
>>>
>>> Thanks
>>>
>>>>
>>>>
>>>>> Update vs v1[1]: update commit message to clarify the context.
>>>>>
>>>>> base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
>>>>>
>>>>> [1]https://lore.kernel.org/lkml/20211122160812.25125-1-arnaud.pouliquen@foss.st.com/T/
>>>>> ---
>>>>>  drivers/rpmsg/virtio_rpmsg_bus.c | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
>>>>> index 9c112aa65040..5f73f19c2c38 100644
>>>>> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
>>>>> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
>>>>> @@ -1054,6 +1054,7 @@ static struct virtio_driver virtio_ipc_driver = {
>>>>>       .feature_table_size = ARRAY_SIZE(features),
>>>>>       .driver.name    = KBUILD_MODNAME,
>>>>>       .driver.owner   = THIS_MODULE,
>>>>> +     .suppress_used_validation = true,
>>>>>       .id_table       = id_table,
>>>>>       .probe          = rpmsg_probe,
>>>>>       .remove         = rpmsg_remove,
>>>>> --
>>>>> 2.17.1
>>>>
>>>
>>
> 
