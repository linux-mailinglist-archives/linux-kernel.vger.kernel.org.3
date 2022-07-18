Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62058578117
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 13:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbiGRLk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 07:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiGRLk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:40:58 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297C0B4E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 04:40:57 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h17so16670274wrx.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 04:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OtDWofZTy1qmKuvBDY8yr9mvFOFtQYbwQaCoI3ka5GY=;
        b=TJd8MU6tXuWiaQeLz1k7kxgk75viXfVDjqKS2cuGI25ZYB964+bhrQqtboTyyWlNls
         DVxqcuAWXgzsaxgVrTOW+kgbZNh5CA0cylRsceGZsUvLLIdxB9F6wx987KC6TAvryxaN
         h1zzphjZJoLdF6rZHei1WS0VjxxE62ciiHF3oezxbxoPOndAGtOsBq2JOrMBDMvN5UGl
         y/fC6Yr8E5Rdw2CAka8m5ImYupNOyL8F7dwi8M2e0fyCNZ0nUE2tCoEwtMz9xImzQMcN
         FssLqh9q329hWQa/aqD+eLCzabsmmsSsM8esLgyC4VXfaPtZ4k9sz5esOUQ4Q/F6LaQd
         ak7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OtDWofZTy1qmKuvBDY8yr9mvFOFtQYbwQaCoI3ka5GY=;
        b=HE1xAbz6NhEQUVsRdaeARucBLtVZQ2T4jyxg0KGBJlDf6+BRTiLxJ3fl5fd02NoPXB
         bKg/DbPA6EFDNqjKDEbw83+amcWU2XHKhtgpNkrLi7k5pZ0ZoNI011qmzl9cPq9MOi+x
         AhpIU6vuhCeY6zz9M3TZyM9qU1iBVB+4NHPuA4TucVCVWMzN51LmgAbQOup2j4Ut731U
         TF/235CsBDFd72jGATWLvVExp+/Hl0Eu01YcJYNIdH8hxeT/Hg2MX9UxFd6uYqEl/4lW
         8nitqImBTF2q/NqBTHDGugM5LQTOn41lbyU32cfyaAPeTmtGbfHMppYPgry50qZW7wTK
         iHqg==
X-Gm-Message-State: AJIora/lUsR9wpehNp7eMqwFduWJQDHXZcvY3TmQHvWnEoZwIG3L7TNG
        7AxPyc5FEhP9/jeRdd9PHa7aXg==
X-Google-Smtp-Source: AGRyM1u7DbY7c6IJjYVD2ncrk34adCppra4JnZ17sKsvadoDIiTb1u9m7aYXB1xAGgT1BCLKrfGETA==
X-Received: by 2002:a5d:47a8:0:b0:21d:b690:9273 with SMTP id 8-20020a5d47a8000000b0021db6909273mr21300789wrb.242.1658144455677;
        Mon, 18 Jul 2022 04:40:55 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id l14-20020adff48e000000b0021d7ad6b9fdsm10615226wro.57.2022.07.18.04.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 04:40:55 -0700 (PDT)
Message-ID: <595e0169-fe87-0477-fbe4-ff89387605df@linaro.org>
Date:   Mon, 18 Jul 2022 12:40:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next] nvmem: core: Fix memleak in nvmem_register()
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     linux-kernel@vger.kernel.org, gongruiqi1@huawei.com,
        wangweiyang2@huawei.com
References: <20220716075352.2622809-1-cuigaosheng1@huawei.com>
 <YtJ1mthCP+4laqOn@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <YtJ1mthCP+4laqOn@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/07/2022 09:23, Greg KH wrote:
> On Sat, Jul 16, 2022 at 03:53:52PM +0800, Gaosheng Cui wrote:
>> dev_set_name will alloc memory for nvmem->dev.kobj.name in
>> nvmem_register, when nvmem_validate_keepouts failed, nvmem's
>> memory will be freed and return, but nobody will free memory
>> for nvmem->dev.kobj.name, there will be memleak, so using
>> kfree_const(nvmem->dev.kobj.name) to fix it.
>>
>> Fixes: de0534df9347 ("nvmem: core: fix error handling while validating keepout regions")
>> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
>> ---
>>   drivers/nvmem/core.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>> index 1e3c754efd0d..6c75c9afa5f3 100644
>> --- a/drivers/nvmem/core.c
>> +++ b/drivers/nvmem/core.c
>> @@ -833,6 +833,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>>   		rval = nvmem_validate_keepouts(nvmem);
>>   		if (rval) {
>>   			ida_free(&nvmem_ida, nvmem->id);
>> +			kfree_const(nvmem->dev.kobj.name);
>>   			kfree(nvmem);
> 
> Something is really wrong, you should never be touching the name pointer
> of a kobject directly like this.  Also the device structure itself
> should be cleaning up the memory, not a kfree.  So this feels wrong...

The problem is that at this point we have not device_intialize() the dev 
yet, so there is no refcount setup for kobject yet.

I see two drivers (drivers/nvme/core.c and drivers/base/node.c)  doing 
something similar.

Most common (99.99%) usage pattern is

dev_set_name(...)
ret = device_register(..);
if (ret < 0)
	put_device(..)

but in this particular case we have:

dev_set_name(...)
..
ret = do_some_error_checks()
if (ret < 0)
	return ret;
...
ret = device_register(..);
if (ret < 0)
	put_device(..)

One solution is to follow the most used pattern and move the checks 
after device register and let device core take care of freeing this 
kobj.name as part of its cleanup routine.

--srini

> 
> greg k-h
