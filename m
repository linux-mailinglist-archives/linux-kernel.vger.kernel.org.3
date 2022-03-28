Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811244E9F2F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 20:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245319AbiC1SyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 14:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245316AbiC1SyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 14:54:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9919864700
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 11:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648493551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/94bw1qjM0lMWge1L3gum4ton9oKMWjb4mcP1lwtmdA=;
        b=Faf596APA+qfoWg3wxFnZ+PBQxfIQWV6F66TE6Knpjs5cXy4CUb5xHAFVMm5+kC0nCwRMb
        M9ZEWZhomdyCwB66OTQT0FOi2biEB1+QgNJIIZHHosdfLejZ+sX+Z/PVnQgu4eD8oDh/K1
        QDwZ/oKExnQ4a/l6IQcgI3oP47g2zD4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-399--HDXrs77OZG-4eGJTjlpDg-1; Mon, 28 Mar 2022 14:52:29 -0400
X-MC-Unique: -HDXrs77OZG-4eGJTjlpDg-1
Received: by mail-qt1-f199.google.com with SMTP id cb11-20020a05622a1f8b00b002e06f729debso12956909qtb.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 11:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/94bw1qjM0lMWge1L3gum4ton9oKMWjb4mcP1lwtmdA=;
        b=ne8Jlt/nfeJYUbQSivEDe8SnpUd4tK7wb28sbhaBuOFPUbkUZqZs0prSXfmmSm37SW
         jFq3t3ckp2iRsKrElH4/xSuqW0jSgnkFnIYiqxDNJPtR8ytHYo6kyQaW9YeLtysr1oGl
         NItNlVZa/tbr6EQiWMj6A9ioObq8fCj9F32ow722o+mEM7nIh+bUD7i0ncmj13id/nkP
         7Arw71RlS/qj8awlPCq25VIXgu0CdhyVFnCCQaVgoXiwtxIdtg/OaxdyZuD7/Pc42toe
         nKqIkaMVJLYMWyXk8fh5Yx78Zc1HHuh/3w2OgQQjcQu7s1deI/kowCwr5oDX5q57QlHU
         P98w==
X-Gm-Message-State: AOAM532oTYoqOK/pWVmjjVt7RmVT4fF9h4RSqmQxEIKueLEh5iEykPSY
        EnOSdDl/Z+JPvKS9P3Qt7mgBcp+31DEXJLXgi2FuSfC4loqHw8Yj80VoL6Br5FJi27/fYHGLgWJ
        /zzT9BR33xSlkIRi8/pSfKHun
X-Received: by 2002:ac8:578b:0:b0:2e2:324a:7b6c with SMTP id v11-20020ac8578b000000b002e2324a7b6cmr23264899qta.267.1648493549280;
        Mon, 28 Mar 2022 11:52:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZTKxIbzpp5qa8P0LQcumByH8HEqK/Fl6cvW4Mq1Q/q2xzMgZHVpq4S7vx2d27rkS54YD5ow==
X-Received: by 2002:ac8:578b:0:b0:2e2:324a:7b6c with SMTP id v11-20020ac8578b000000b002e2324a7b6cmr23264861qta.267.1648493548936;
        Mon, 28 Mar 2022 11:52:28 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id b26-20020a05620a119a00b0067e5a092d45sm8380998qkk.11.2022.03.28.11.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 11:52:28 -0700 (PDT)
Subject: Re: [RESEND PATCH v1 1/8] firmware_loader: Clear data and size in
 fw_free_paged_buf
To:     Russ Weight <russell.h.weight@intel.com>, mcgrof@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com, basheer.ahmed.muddebihal@intel.com,
        tianfei.zhang@intel.com
References: <20220323233331.155121-1-russell.h.weight@intel.com>
 <20220323233331.155121-2-russell.h.weight@intel.com>
 <5ec3e671-53aa-b8cc-1360-c454f3db277d@redhat.com>
 <2bd89743-78b8-0e1a-bbda-10d2fedb863f@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <16f93247-3af2-e9cb-b7f6-c8305fa1db33@redhat.com>
Date:   Mon, 28 Mar 2022 11:52:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <2bd89743-78b8-0e1a-bbda-10d2fedb863f@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/28/22 11:09 AM, Russ Weight wrote:
> Hi Tom,
>
> On 3/28/22 06:27, Tom Rix wrote:
>> On 3/23/22 4:33 PM, Russ Weight wrote:
>>> The fw_free_paged_buf() function resets the paged buffer information in
>>> the fw_priv data structure. Additionally, clear the data and size members
>>> of fw_priv in order to facilitate the reuse of fw_priv. This is being
>>> done in preparation for enabling userspace to initiate multiple firmware
>>> uploads using this sysfs interface.
>>>
>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>>> ---
>>> v1:
>>>     - No change from RFC patch
>>> ---
>>>    drivers/base/firmware_loader/main.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
>>> index 94d1789a233e..2cc11d93753a 100644
>>> --- a/drivers/base/firmware_loader/main.c
>>> +++ b/drivers/base/firmware_loader/main.c
>>> @@ -253,6 +253,8 @@ void fw_free_paged_buf(struct fw_priv *fw_priv)
>> Why isn't a vfree needed or realloc done?

I am looking at the use of this function in __free_fw_priv

       if (fw_is_paged_buf(fw_priv))
           fw_free_paged_buf(fw_priv);
       else if (!fw_priv->allocated_size)
           vfree(fw_priv->data);

Where it seems like there is another way to set data, so it needs 
another way to unset.

The vfree here looks suspect because the pointer comes in from 
request_firmware_info_buf with a hope that it was allocated by vmalloc.

Tom

> The free and realloc support was present prior to my changes. The page
> buffer support was designed such that if a firmware write was cancelled, the
> existing fw_priv structure could be re-used for another write in the context
> of the same firmware upload. However, there was no prior case for completing
> a write and then reusing the fw_priv structure for subsequent firmware writes;
> fw_priv previously had a one-time use. The changes I have made are to enable
> the re-use of the fw_priv structure.
>
> Initially, fw_priv->data is NULL. The "realloc" functionality happens during
> the write of the data binary attribute here:
>
> https://github.com/torvalds/linux/blob/ae085d7f9365de7da27ab5c0d16b12d51ea7fca9/drivers/base/firmware_loader/fallback.c#L426
>
> The fw_priv->data pointer remains NULL until all data is written and the
> user writes '0' to the loading attribute. The fw_priv->data pointer is set in
> fw_map_paged_buf() which is called here:
>
> https://github.com/torvalds/linux/blob/ae085d7f9365de7da27ab5c0d16b12d51ea7fca9/drivers/base/firmware_loader/fallback.c#L274
>
> In the unmodified code, the fw_priv->data pointer is never cleared. My changes
> reset the pointer to NULL after the memory is released so that the fw_priv can
> be resused.
>
> The new firmware-upload happens in the context of a kernel worker thread and the work
> function is fw_upload_main(). At the end of fw_upload_main(), fw_free_paged_buf()
> is called to do the free. This is the function that is being modified by the lines
> below. This function calls "__free_page(fw_priv->pages[i])" in a loop to free the
> memory pages. It also calls "vunmap(fw_priv->data)" to free the virtual mapping.
> You can see the unmodified implementation of this function here:
>
> https://github.com/torvalds/linux/blob/ae085d7f9365de7da27ab5c0d16b12d51ea7fca9/drivers/base/firmware_loader/main.c#L241
>
> - Russ
>
>> Tom
>>
>>>        fw_priv->pages = NULL;
>>>        fw_priv->page_array_size = 0;
>>>        fw_priv->nr_pages = 0;
>>> +    fw_priv->data = NULL;
>>> +    fw_priv->size = 0;
>>>    }
>>>      int fw_grow_paged_buf(struct fw_priv *fw_priv, int pages_needed)

