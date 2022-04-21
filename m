Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CEC50950E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 04:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381828AbiDUCit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 22:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiDUCir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 22:38:47 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2188BB1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 19:35:59 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id bx5so3668883pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 19:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IrhWV0WvnvdN0AqkWEqS5qhXYtbPighIk1/AK3wHmas=;
        b=DsVujEj0uC+oXeZSfY5cyX1nLVjeP/PjUe36tLLfpg3luvTT235pogMSlTH7Yhr9D+
         F7PfYAAOzFLZ5D12RlzbDz6thKV3k3GTO5xGrCy1wAjY+MekBPpTyxQ4qt28o2cSNMBc
         aVknI12yjiYUH2qfFjCMS90qNbiGy3qfJakiBbwmGaUyTtgEjQni0TSyIT2v7iDI5ei+
         12FbT3nNZJlA52QSYxtAFDC8jm+VrjUqNso9SgNr2jj9lSjHlC8iij5qvqKfDgQFPvrx
         aYyMpWwEs2muHV0RdHRQrc6giAKvEv4JDgDNRAKLGO/9rsrx1Zb6XEwpUmygcRkx9QD2
         60uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IrhWV0WvnvdN0AqkWEqS5qhXYtbPighIk1/AK3wHmas=;
        b=2SJpKdnqrWVZiDhTQJ1pxOtf0lcFezFNiVe71uwqK3jDVChtW5tz3lhTkK89KX5yUX
         JWioNFrJDpTPWyePhrLX8T0NX9X4++grqxt4xrVVZbra6n0Go1tHRjUoo82xVSLvuZIy
         CtyHFzAGxU5xwy1p3Zy8cDS6b9cCoJBLZrMNQ5ae/f1CRpRT2m0uWiwjpVji4VNtW1e1
         d4WSXgSVkjhU9UoQwG5KVPDbchThhi0LLsSW11HXEVoEJRUaMnGhLsufyOc/xMoB107c
         +o/O9Ixil2IsuxU0n2dXzathGMsAS6YYptSEn8w3RSUs2JZKMw16FHbz4EAByeQVXP1I
         NjIA==
X-Gm-Message-State: AOAM532XQZjV+wIqW5wTtviIwAfxMc5UQr8ErSY0Gfp9H5dt228ma6jl
        eDLm9OIKnbwgNhNueFPvdkI=
X-Google-Smtp-Source: ABdhPJx3VPSjcobxyqQu/p9+0x0/o+dKc7ZUHB2DUXmyrp/qBrXx94K3exy/JjPjGIgUk3RwwuPHwA==
X-Received: by 2002:a17:90a:4813:b0:1c9:e5c3:5abf with SMTP id a19-20020a17090a481300b001c9e5c35abfmr7854676pjh.139.1650508558460;
        Wed, 20 Apr 2022 19:35:58 -0700 (PDT)
Received: from [192.168.50.247] ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id x2-20020aa79182000000b00505a61ec387sm20972531pfa.138.2022.04.20.19.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 19:35:58 -0700 (PDT)
Message-ID: <8aa3b0c0-cb38-8cbe-9499-9ec016c51e95@gmail.com>
Date:   Thu, 21 Apr 2022 10:35:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] misc: ocxl: fix possible double free in
 ocxl_file_register_afu
Content-Language: en-US
To:     Michael Ellerman <mpe@ellerman.id.au>, fbarrat@linux.ibm.com,
        ajd@linux.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        alastair@d-silva.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20220418085758.38145-1-hbh25y@gmail.com>
 <87czhbfjsj.fsf@mpe.ellerman.id.au>
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <87czhbfjsj.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/21 06:54, Michael Ellerman wrote:
> Hangyu Hua <hbh25y@gmail.com> writes:
>> info_release() will be called in device_unregister() when info->dev's
>> reference count is 0. So there is no need to call ocxl_afu_put() and
>> kfree() again.
> 
> Double frees are often exploitable. But it looks to me like this error
> path is not easily reachable by an attacker.
> 
> ocxl_file_register_afu() is only called from ocxl_probe(), and we only
> go to err_unregister if the sysfs or cdev initialisation fails, which
> should only happen if we hit ENOMEM, or we have a duplicate device which
> would be a device-tree/hardware error. But maybe Fred can check more
> closely, I don't know the driver that well.
> 
> cheers
> 

Hi Michael,

You are right. It is hard to exploit at least in my understanding. 
That's why I didn't give this to security@. But it still need to be fix 
out. By the way, if you are interesting in this kind of bug, you can 
check out the other three patches I submitted recently.

rpmsg: virtio: fix possible double free in rpmsg_virtio_add_ctrl_dev()
https://lore.kernel.org/all/20220418101724.42174-1-hbh25y@gmail.com/

rpmsg: virtio: fix possible double free in rpmsg_probe()
https://lore.kernel.org/all/20220418093144.40859-1-hbh25y@gmail.com/

hwtracing: stm: fix possible double free in stm_register_device()
https://lore.kernel.org/all/20220418081632.35121-1-hbh25y@gmail.com/

They are all the similar bugs i could find in the kernel.

Thanks.

> 
>> Fix this by adding free_minor() and return to err_unregister error path.
>>
>> Fixes: 75ca758adbaf ("ocxl: Create a clear delineation between ocxl backend & frontend")
>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
>> ---
>>   drivers/misc/ocxl/file.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
>> index d881f5e40ad9..6777c419a8da 100644
>> --- a/drivers/misc/ocxl/file.c
>> +++ b/drivers/misc/ocxl/file.c
>> @@ -556,7 +556,9 @@ int ocxl_file_register_afu(struct ocxl_afu *afu)
>>   
>>   err_unregister:
>>   	ocxl_sysfs_unregister_afu(info); // safe to call even if register failed
>> +	free_minor(info);
>>   	device_unregister(&info->dev);
>> +	return rc;
>>   err_put:
>>   	ocxl_afu_put(afu);
>>   	free_minor(info);
>> -- 
>> 2.25.1
