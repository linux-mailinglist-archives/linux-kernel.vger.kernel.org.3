Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DBD50695C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349044AbiDSLFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiDSLFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:05:13 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D214140CB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:02:31 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id h1so945281pfv.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HPfHlnZW/J0QTwj9E3rSjp2CIkBFwM3rHUP6G621yX8=;
        b=iNT0C27iILY9yMw5fp4m8wrEpS19RdildApUUoPCMPAggfUSWjI1IBVhyVlsj70CLT
         L6utqZiifJMNTICWPPPHkUgizjX90tPr2zB5nu5K+9NmjVyYf1isJUD4lltfeoMMH0ni
         w+2p5Mp7SlPaWD7g+dvinXp0qtpW1YfIqFjcf1yXGYxmiWV2pYuDgydI5EtEnxa/eTYn
         q6nBgoXFRO5EdNI3PRrAv9w8euU/aAOiB0cCwokJBoAn1jwn2eqjQ/RDHEQQaV22zeGM
         fcT4jHPZP0e7NSi2CDpJ9TgGVjAfzWAXYIanuvR8OIkbRlckhD5OhuGPXRrBV1fdNl1f
         KrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HPfHlnZW/J0QTwj9E3rSjp2CIkBFwM3rHUP6G621yX8=;
        b=VK8Wt2TQUBKe7re5IjwVe9xCuuMddQRn7cD71YnHNUTFrNVev+VpDpwQB6q8L59Bv5
         rcsnIdeJPA+3lTJenS+dn9fWSLrCLNRkzKl+9ut+QMaG6b4GEdV3Oh4iVAJotJ1hcual
         sx+7TLT2UVa2aHAre3vA0S9Y7pvdhbXbvdgcSnh2SrDjn/E30mOv677OpEVI4zLU+bJQ
         jEdwg9nq+DFBWKXKP96HelA3810nYVZvLJ/v9Y61aYN1fmwmg4w7/r3rjfFKI6ReIfii
         xl6oXbWbvsddgFyU98m29pIymkR6rc6uohN6aat1BMUCZfDo6d9sZtDSnh7erswK8JQe
         ZI6Q==
X-Gm-Message-State: AOAM531VIYYhUU3f9HOIWw5cs7HmzE8jJgEtTHO0Cpcrfs2FGzSdBldF
        w57MJDDgJxESiBMbcgm3mVA=
X-Google-Smtp-Source: ABdhPJw2iYD4KBeGw1t2OjioGfEiU3FCIpVJNOBj87m8tve6GdGwt06U40Bh5rLvaoS3a/5BfnkHrw==
X-Received: by 2002:a63:1510:0:b0:39d:7212:8500 with SMTP id v16-20020a631510000000b0039d72128500mr13534063pgl.377.1650366150920;
        Tue, 19 Apr 2022 04:02:30 -0700 (PDT)
Received: from [192.168.50.247] ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id ch10-20020a056a00288a00b0050a51a95e91sm10386370pfb.201.2022.04.19.04.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 04:02:30 -0700 (PDT)
Message-ID: <0da7b5da-6fab-ab73-5748-ae270d77b4d0@gmail.com>
Date:   Tue, 19 Apr 2022 19:02:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] misc: ocxl: fix possible double free in
 ocxl_file_register_afu
Content-Language: en-US
To:     Frederic Barrat <fbarrat@linux.ibm.com>, ajd@linux.ibm.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, mpe@ellerman.id.au,
        alastair@d-silva.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20220418085758.38145-1-hbh25y@gmail.com>
 <e18a4b58-4551-aa68-ed52-baeeeaab56bb@linux.ibm.com>
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <e18a4b58-4551-aa68-ed52-baeeeaab56bb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/19 17:09, Frederic Barrat wrote:
> 
> 
> On 18/04/2022 10:57, Hangyu Hua wrote:
>> info_release() will be called in device_unregister() when info->dev's
>> reference count is 0. So there is no need to call ocxl_afu_put() and
>> kfree() again.
>>
>> Fix this by adding free_minor() and return to err_unregister error path.
>>
>> Fixes: 75ca758adbaf ("ocxl: Create a clear delineation between ocxl 
>> backend & frontend")
>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
>> ---
> 
> 
> Thanks for fixing that error path!
> I'm now thinking it would be cleaner to have the call to free_minor() in 
> the info_release() callback but that would be another patch.
> In any case:
> Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>
> 
>    Fred
> 

I think it is a good idea to use callbacks to handle all garbage 
collections. And free_minor is used only in ocxl_file_register_afu() 
andocxl_file_unregister_afu(). So this should only require minor changes.

Thanks.

> 
>>   drivers/misc/ocxl/file.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
>> index d881f5e40ad9..6777c419a8da 100644
>> --- a/drivers/misc/ocxl/file.c
>> +++ b/drivers/misc/ocxl/file.c
>> @@ -556,7 +556,9 @@ int ocxl_file_register_afu(struct ocxl_afu *afu)
>>   err_unregister:
>>       ocxl_sysfs_unregister_afu(info); // safe to call even if 
>> register failed
>> +    free_minor(info);
>>       device_unregister(&info->dev);
>> +    return rc;
>>   err_put:
>>       ocxl_afu_put(afu);
>>       free_minor(info);
