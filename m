Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410B94F8C60
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiDHCBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 22:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiDHCBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 22:01:40 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4835ED49;
        Thu,  7 Apr 2022 18:59:38 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f3so7176558pfe.2;
        Thu, 07 Apr 2022 18:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wahOeVHRHrdA6vkH13T44RAxm+omTMPbzwFhKmHyLQk=;
        b=jcV7y+xiLLCvM1AEcseI1xxoIe3qUhIHIgfmnWtTFOcYWmg6IFbaeqUtUxHwjo1Z9i
         aC5mS3qtLOLlgwgHYaIjf/xZ649ZcWYMB/aC2pmWXej6JZoBU3q5vE4bDB9YTcusjpBd
         KAZaUZO+OE56Kg54IVcuU7JssRPwmXYQ6PvjoAhssdCZZsnxNH7d/k4+8Qe/U5XwZqFd
         Ta3FTosT2mhdT/a4/RJhiIzMqlTJICq0WBWCzuqc8L+MUVmGV5j9qXIPVMIK1+fTrs4x
         pnJYcSul2pXHdtwfmXrcJYsrZh85nMpPiLrOwYAPGthHDgnT/GVlpwCu5mQHO2tYO5q4
         vZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wahOeVHRHrdA6vkH13T44RAxm+omTMPbzwFhKmHyLQk=;
        b=IwvsGrbXJIX+c++WLl9sAPC3CEdX3koH+oHX1Ip1on02rSeOZKVUw2rCVW08icDolO
         1CIQD2o9aAYnvVfZmv2Fx1lKNFh9ZGNluDaAGPwyEh729HcmK26WvKhzcM8pwKuc6lru
         jQaBayBk8enVLRnv4sKE+uarM7QXGhdYgqm+QE3aV5yUr9kF90nvnxCv84WtxYjak88k
         7uc0SsZhlSg1KVSYeDk5MqBovTAHI7z8LmqPw3jsfzXAGhUEmiqAGuXUiP1FcdX2lLI8
         3P0GNWXAkq1v9qaUP+kA3i2j6uwdYEB3Mbs3yMzIW4O9Y8BqHOZyVLDz779/hYH3FCAV
         C0pA==
X-Gm-Message-State: AOAM5301VxdAaIpF6vRsaUNfid0684EuITiCtXhLrw1Gui5/EEMdOuhA
        zUTH/2E8Hrh8VE1RIwbdYzw=
X-Google-Smtp-Source: ABdhPJywb8SsI8kAwfnUiqYIks8RBbkl1PL1Z+wumrMhQwCJ58Nt37zaFMtJFMAyh9AR61/myIcuoQ==
X-Received: by 2002:a63:e147:0:b0:39c:d177:c01f with SMTP id h7-20020a63e147000000b0039cd177c01fmr3857427pgk.81.1649383177810;
        Thu, 07 Apr 2022 18:59:37 -0700 (PDT)
Received: from [10.11.37.162] ([103.84.139.54])
        by smtp.gmail.com with ESMTPSA id q3-20020a63ae03000000b003820cc3a451sm20449691pgf.45.2022.04.07.18.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 18:59:37 -0700 (PDT)
Message-ID: <d40cb8cf-a92d-3f87-3af1-0422f8d8264f@gmail.com>
Date:   Fri, 8 Apr 2022 09:59:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] usb: usbip: fix a refcount leak in stub_probe()
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org, khoroshilov@ispras.ru
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220407022204.10730-1-hbh25y@gmail.com>
 <7c584e2d-1c23-3df9-7e4e-c4d9a9014224@linuxfoundation.org>
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <7c584e2d-1c23-3df9-7e4e-c4d9a9014224@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

I find this by code review. Do i really need to add this to commit log? 
This look like a little weird.

Thanks

On 2022/4/8 00:31, Shuah Khan wrote:
> On 4/6/22 8:22 PM, Hangyu Hua wrote:
>> usb_get_dev() is called in stub_device_alloc(). When stub_probe() fails
>> after that, usb_put_dev() needs to be called to release the reference.
>>
>> Fix this by moving usb_put_dev() to sdev_free error path handling.
>>
>> Fixes: 3ff67445750a ("usbip: fix error handling in stub_probe()")
>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
>> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>
>> v2: add more description of this patch.
> 
> Still missing details on how this problem was found. Please add them
> to the commit log.
> 
> thanks,
> -- Shuah
