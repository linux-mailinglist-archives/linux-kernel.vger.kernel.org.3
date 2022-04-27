Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D5A510F01
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 04:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357280AbiD0CyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 22:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357299AbiD0Cx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 22:53:57 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B1D43ED7;
        Tue, 26 Apr 2022 19:50:47 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id z5-20020a17090a468500b001d2bc2743c4so662052pjf.0;
        Tue, 26 Apr 2022 19:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=t5XJuaT4OWvlHmOcaIN/ZB13LUq7XOD/Hk33b436nUE=;
        b=GRvHzPN2grxclVd31pWuiT3Ld01HG+2JD9IEeerQqqhnsysuIQZbQN310EmdGx4qlC
         FkV8s1sD6bxYsrNWYFDdelThb3PV6tIm3g8PbchoKOS2CCM22YY6Wi7U7Fhno+p67Rkz
         R12/9CRNqC6y7jeMW8J/DfYU0ACk8rS4aLUM+oHZp/J1AyuRGX9baP817AIYU3lut6EQ
         c3NCdpgjcmpD5nAl4KDyC/0QfnFDwyeOcbvvv7NriNEjyDt8w0wXr2+jnfADt7TaMspK
         tYuQapdU4mqfndcZ7/8R1xiZ9QqIjMADwfqLIIirF3LljvxpPyJUK1GAtrr9UhUuL5DO
         wi1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t5XJuaT4OWvlHmOcaIN/ZB13LUq7XOD/Hk33b436nUE=;
        b=RXzrnd363+6SMZzHI6zpH8/Q+UEIsBGEHAVcFwvVVVdxU6wPAwOkyX/p56aLjx+jw+
         gJWSbC71VavRMvUIsAWnvboedDncJALYJG7ZP79tgpugaEonuYWgsOJJzKAd7mNPDhdv
         BiDYLHDhshNzpdZ0kGJRIJZvSLY136UB19Zk2uhrNriBPKijH63PeDUfLGKZ4tZ6JV72
         +0MgqjUjHFRQxjgi9PK8QYllbNJwgF8UmkOo6i5kZ7WAjR9hK2Hh2DLmEmwl8H8Q8uaI
         vzE2s7/fyK4fdjHRo4h0LpTKkJhahSCsARmnYNO+08wXQkNQ0xEeOQaQ+DuthEZJTRkc
         vEXA==
X-Gm-Message-State: AOAM5319THNAr0ssMJGHVewrlYvi9Dw/4xw0hZJc8wkkQXOCMfrt3Asu
        4MI9nBU4McjcaMAxS86HzQkg+Owyf/c26Q==
X-Google-Smtp-Source: ABdhPJw3uSJ5Qbs6kTLh86PlLxlSW0Wd9GY6ysXbJJ7irunc0DZtEPYrbdQV17dU8e38qEIjgtRTNQ==
X-Received: by 2002:a17:902:a710:b0:156:5650:f94a with SMTP id w16-20020a170902a71000b001565650f94amr25788659plq.86.1651027846550;
        Tue, 26 Apr 2022 19:50:46 -0700 (PDT)
Received: from [192.168.50.247] ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id h124-20020a62de82000000b0050d3020bda0sm11364538pfg.195.2022.04.26.19.50.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 19:50:46 -0700 (PDT)
Message-ID: <55c946ad-5d19-1d38-3484-1ab059a27642@gmail.com>
Date:   Wed, 27 Apr 2022 10:50:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 3/3] rpmsg: virtio: Fix the unregistration of the
 device rpmsg_ctrl
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     bjorn.andersson@linaro.org, arnaud.pouliquen@foss.st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220426060536.15594-1-hbh25y@gmail.com>
 <20220426060536.15594-4-hbh25y@gmail.com> <20220426165613.GA2007637@p14s>
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <20220426165613.GA2007637@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/27 00:56, Mathieu Poirier wrote:
> On Tue, Apr 26, 2022 at 02:05:36PM +0800, Hangyu Hua wrote:
>> Unregister the rpmsg_ctrl device instead of just freeing the
>> the virtio_rpmsg_channel structure.
>> This will properly unregister the device and call
>> virtio_rpmsg_release_device() that frees the structure.
>>
>> Fixes: c486682ae1e2 ("rpmsg: virtio: Register the rpmsg_char device")
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> Cc: Hangyu Hua <hbh25y@gmail.com>
>> Reviewed-by: Hangyu Hua <hbh25y@gmail.com>
>> ---
>>   drivers/rpmsg/virtio_rpmsg_bus.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
>> index 291fc1cfab7f..485e95f506df 100644
>> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
>> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
>> @@ -862,7 +862,7 @@ static void rpmsg_virtio_del_ctrl_dev(struct rpmsg_device *rpdev_ctrl)
>>   {
>>   	if (!rpdev_ctrl)
>>   		return;
>> -	kfree(to_virtio_rpmsg_channel(rpdev_ctrl));
>> +	device_unregister(&rpdev_ctrl->dev);
> 
> The author of this patch should have been Arnaud, something I have fixed before
> applying this set.
> 
> Thanks,
> Mathieu
> 

I get it. I'm sorry i thought Signed-off-by and a description in cover 
letter are enough to express. Do i need to do anything else?

Thanks,
Hangyu
>>   }
>>   
>>   static int rpmsg_probe(struct virtio_device *vdev)
>> -- 
>> 2.25.1
>>
