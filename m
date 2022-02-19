Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791F24BC4E9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 03:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241116AbiBSCfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 21:35:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241082AbiBSCfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 21:35:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15D8D5677B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 18:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645238087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dLSRXD4oabvT1hZcyTh/jopmei8mV6oK1K/s3P1srU8=;
        b=GHmwdxhFtA5RB9nqjxqHCv7jaEl7dw9yUZNNex57//r75TSXkG+V4NPldYfolJsZqQNcOR
        avtJuivosnJojI4xvvjyVlPFWceBn7Ed516zOc8lDWLeTVXWxl/q0dK+HxCBOqysL51Nzk
        jfLZNdVGBCVx++m7SbqmtzdL5b62lX8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-228-EtZauZ8UOgmGSaugsWlrLw-1; Fri, 18 Feb 2022 21:34:45 -0500
X-MC-Unique: EtZauZ8UOgmGSaugsWlrLw-1
Received: by mail-qk1-f198.google.com with SMTP id 2-20020a370a02000000b0060df1ac78baso5007293qkk.20
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 18:34:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dLSRXD4oabvT1hZcyTh/jopmei8mV6oK1K/s3P1srU8=;
        b=LIt21kJ9ZrpY8EgpX89uRgRFHAJvV6exiuLNVaWcfoqmu6jjBuKqWhs/Q/ypB8e/7W
         zJo5Yf3r4c3ATeVZMaxr1OWBEOL5zGBizKfkdx9r79DzLREiZaSFSleo9kMN3mG/ZSM8
         gq6or2MuUVBdcv4GGbkT5FAArErPQ/UrDTJ3Rzd0rDF4cQQPr4VzGjE3ed9ZS7NeGfzU
         yCIqx4tiiftCg1IUdOncGf+rGcRbF5R5OgA1xjgC1jCGNRmT+GR0b3cKiv64Yjfk9WZA
         cw98cexUS+YY04vD5IXP4GJNToZaEo0Hcn3iqizOVBWfCCulgHdHw83Eq+T4povV7L8v
         KHzw==
X-Gm-Message-State: AOAM533RbpCxVc+JCfSQpKZcpoz5Sgq2dBymHpsjqSt/Ya8O8CVUPWtU
        FRZwkWe5sUgS+qhQj075/gZ+E11vCpZzfli+Zb/oGEt4UHdFER6fMufXu7n7XIb9nrpr52mwrbL
        QOxL41JABd/bB/YFhI9LxcDQj
X-Received: by 2002:a05:622a:255:b0:2dd:2295:e6cc with SMTP id c21-20020a05622a025500b002dd2295e6ccmr9237071qtx.399.1645238085426;
        Fri, 18 Feb 2022 18:34:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJycI8i/Dj3TSf78qpp+mi+i6jw4nt8X0/VpHah9pqOsogHlS9ItFFm2kFqJ/p1eOKjjqDzKmw==
X-Received: by 2002:a05:622a:255:b0:2dd:2295:e6cc with SMTP id c21-20020a05622a025500b002dd2295e6ccmr9237062qtx.399.1645238085204;
        Fri, 18 Feb 2022 18:34:45 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id f14sm23160886qko.117.2022.02.18.18.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 18:34:44 -0800 (PST)
Subject: Re: [PATCH] drm/amdkfd: rework criu_restore_bos error handling
To:     Felix Kuehling <felix.kuehling@amd.com>, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, nathan@kernel.org, ndesaulniers@google.com,
        david.yatsin@amd.com, rajneesh.bhardwaj@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20220218173913.3376948-1-trix@redhat.com>
 <b98981f4-358b-ebdd-dade-4027c57a1a7e@amd.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <4ca24c08-9014-3380-b8cc-dc0ed9a01a73@redhat.com>
Date:   Fri, 18 Feb 2022 18:34:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <b98981f4-358b-ebdd-dade-4027c57a1a7e@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/18/22 10:35 AM, Felix Kuehling wrote:
> Am 2022-02-18 um 12:39 schrieb trix@redhat.com:
>> From: Tom Rix <trix@redhat.com>
>>
>> Clang static analysis reports this problem
>> kfd_chardev.c:2327:2: warning: 1st function call argument
>>    is an uninitialized value
>>    kvfree(bo_privs);
>>    ^~~~~~~~~~~~~~~~
>>
>> If the copy_from_users(bo_buckets, ...) fails, there is a jump to
>> the generic error handler at exit:.  The freeing of bo_privs and
>> unwinding of the dmabuf_fd loop do not need to be done.
>>
>> Add some specific labels for the early failures.
>> Reorder the frees to be the reverse of their allocs.
>>
>> Move the initialize of 'i' back to the loop.
>> The problem with the early frees predates the loop
>> unwinding problem.
>
> I think the existing error handling strategy in this function is fine. 
> Having only one exit label avoids potential issues when using the 
> wrong label. Freeing NULL pointers is not a problem. The loop becomes 
> a noop if i==0 (this was fixed by you in a previous patch). The only 
> real problem I see is that bo_privs is not initialized. So this should 
> really be a one-line or maybe two-line fix:
>
>     struct kfd_criu_bo_bucket *bo_buckets = NULL;
>     struct kfd_criu_bo_priv_data *bo_privs = NULL;

This is the other way I considered to fix the problem. So it will work.

Tom

>
> Regards,
>   Felix
>
>
>>
>> Fixes: 73fa13b6a511 ("drm/amdkfd: CRIU Implement KFD restore ioctl")
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 15 +++++++++------
>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 965af2a08bc0..1d5f41ac3832 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -2102,7 +2102,7 @@ static int criu_restore_bos(struct kfd_process *p,
>>       const bool criu_resume = true;
>>       bool flush_tlbs = false;
>>       int ret = 0, j = 0;
>> -    uint32_t i = 0;
>> +    uint32_t i;
>>         if (*priv_offset + (args->num_bos * sizeof(*bo_privs)) > 
>> max_priv_data_size)
>>           return -EINVAL;
>> @@ -2119,13 +2119,13 @@ static int criu_restore_bos(struct 
>> kfd_process *p,
>>       if (ret) {
>>           pr_err("Failed to copy BOs information from user\n");
>>           ret = -EFAULT;
>> -        goto exit;
>> +        goto free_buckets;
>>       }
>>         bo_privs = kvmalloc_array(args->num_bos, sizeof(*bo_privs), 
>> GFP_KERNEL);
>>       if (!bo_privs) {
>>           ret = -ENOMEM;
>> -        goto exit;
>> +        goto free_buckets;
>>       }
>>         ret = copy_from_user(bo_privs, (void __user *)args->priv_data 
>> + *priv_offset,
>> @@ -2133,12 +2133,12 @@ static int criu_restore_bos(struct 
>> kfd_process *p,
>>       if (ret) {
>>           pr_err("Failed to copy BOs information from user\n");
>>           ret = -EFAULT;
>> -        goto exit;
>> +        goto free_privs;
>>       }
>>       *priv_offset += args->num_bos * sizeof(*bo_privs);
>>         /* Create and map new BOs */
>> -    for (; i < args->num_bos; i++) {
>> +    for (i = 0; i < args->num_bos; i++) {
>>           struct kfd_criu_bo_bucket *bo_bucket;
>>           struct kfd_criu_bo_priv_data *bo_priv;
>>           struct kfd_dev *dev;
>> @@ -2323,8 +2323,11 @@ static int criu_restore_bos(struct kfd_process 
>> *p,
>>           if (bo_buckets[i].alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
>>               close_fd(bo_buckets[i].dmabuf_fd);
>>       }
>> -    kvfree(bo_buckets);
>> +free_privs:
>>       kvfree(bo_privs);
>> +free_buckets:
>> +    kvfree(bo_buckets);
>> +
>>       return ret;
>>   }
>

