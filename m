Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485EA50EE27
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 03:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241041AbiDZBnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 21:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240787AbiDZBno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 21:43:44 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75716192B4;
        Mon, 25 Apr 2022 18:40:39 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id u6-20020a17090a1f0600b001d86bd69427so1080841pja.5;
        Mon, 25 Apr 2022 18:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hFH0E0pslzD20/GCGOdgN5SxCLuSjW6GDgQJx+W0IdQ=;
        b=kd9OGIhHJtr1iPfgw/k7akidycurc6u8IZ0uktaPT3RthJc/mRJ3Gfj1teWQZktRNs
         OV98pbRzHvYGVBARJRGtW4CPpomtKvniMTh/YzKheo628NE+oX6nlj3K6eT85ZO1vJC0
         jWBMYJMJK0TKPequnko9LzQrrDflLcXiCYRbNjqzF6+MInOmO79C0rH8X3/Dv2L3vge5
         UU80TJ0xIeapjiF7vb3GoTl4QYn9fNSa3IjNA4vNngnSnpPmEiYjyku0qa6koSiaMiX8
         7lWkvzUVHxVZfZdctJgQXBfpKWaAC7FkQfmVHtjuHEXnFTHWxen6gjMUZn6Emp+7AIRy
         Cjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hFH0E0pslzD20/GCGOdgN5SxCLuSjW6GDgQJx+W0IdQ=;
        b=wbdjPydLvmcqMi02Zx+ilRx0XwVzEMW6wRj2r1ip6lTV5FSrh7f1OB899riYNBxFic
         EYPHBiKeAOvUWh3QDF+wObTnRQfTgm1vz2KPSglKLzzeUFLn+vSYqep5gIVjH5oV2Lc4
         m5WGRv0YmvsHoI24wU1gfc2G2etE4EWmcY8QTKCGTER+F+PuyXTmV28gRvXv7bGm6tdz
         sBvJxdnfSka3FRQnb+8L7oaPU5cE7ItDzH2rgFZzwK5IMJj5ISlE2gb5Y1reW9kDl0N4
         JE59Jbd89AVU9VzTJwiyCG6JLCDH8rUSQIEeYGqlut0EnYYSuD9lviIWZv+ZLAnYUcxV
         y78A==
X-Gm-Message-State: AOAM531stg9+7d2VcU95TR1d5bqkNKOYpQSlOxat/hZJ0CZQzvxlEDfu
        WzH0sB73F5DzZgDn8z6t7vE=
X-Google-Smtp-Source: ABdhPJxjqpKHdxzZtml6ywb7wYDVkmA0BHprh64ZaZVr3QPRDpP2HsfzvB3I3AY7nCUJ/Arry7Sn4Q==
X-Received: by 2002:a17:902:bd92:b0:15c:e5ba:fb49 with SMTP id q18-20020a170902bd9200b0015ce5bafb49mr14070106pls.35.1650937238912;
        Mon, 25 Apr 2022 18:40:38 -0700 (PDT)
Received: from [192.168.50.247] ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id u3-20020a626003000000b00505a38fc90bsm13267910pfb.173.2022.04.25.18.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 18:40:38 -0700 (PDT)
Message-ID: <60d80bae-d229-0aa2-8c63-025754ab3438@gmail.com>
Date:   Tue, 26 Apr 2022 09:40:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] rpmsg: virtio: fix possible double free in rpmsg_probe()
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     bjorn.andersson@linaro.org, arnaud.pouliquen@foss.st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220418093144.40859-1-hbh25y@gmail.com>
 <20220425165552.GB1917807@p14s>
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <20220425165552.GB1917807@p14s>
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

On 2022/4/26 00:55, Mathieu Poirier wrote:
> On Mon, Apr 18, 2022 at 05:31:44PM +0800, Hangyu Hua wrote:
>> vch will be free in virtio_rpmsg_release_device() when
>> rpmsg_ns_register_device() fails. There is no need to call kfree() again.
>>
>> Fix this by changing error path from free_vch to free_ctrldev.
>>
>> Fixes: c486682ae1e2 ("rpmsg: virtio: Register the rpmsg_char device")
>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
>> ---
>>   drivers/rpmsg/virtio_rpmsg_bus.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
>> index 3ede25b1f2e4..603233f0686e 100644
>> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
>> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
>> @@ -973,7 +973,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
>>   
>>   		err = rpmsg_ns_register_device(rpdev_ns);
>>   		if (err)
>> -			goto free_vch;
> 
> Please add a comment that highlights where 'vch' will be free'd to avoid
> receiving patches that will introduce another kfree().  Same for your other
> patch.
> 
> In the next revision please use a cover letter and add Arnaud's patches to it.
> 
> Thanks,
> Mathieu
> 

Thanks! I will send a v2 later.

>> +			goto free_ctrldev;
>>   	}
>>   
>>   	/*
>> @@ -997,8 +997,6 @@ static int rpmsg_probe(struct virtio_device *vdev)
>>   
>>   	return 0;
>>   
>> -free_vch:
>> -	kfree(vch);
>>   free_ctrldev:
>>   	rpmsg_virtio_del_ctrl_dev(rpdev_ctrl);
>>   free_coherent:
>> -- 
>> 2.25.1
>>
