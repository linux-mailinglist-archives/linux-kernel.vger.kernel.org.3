Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEAF4CA4AA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241726AbiCBMTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241729AbiCBMTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:19:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 212E93F327
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 04:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646223537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CQIwtHkHzYTYJnngpsaoFGg2phTUpA1DDWldBn55VNw=;
        b=MEwr2wkZ+diNYD2WIowyuy8DBYIuN6lpd6F+GbFK8ippva2DXy5PdowREDoxl9T5lGOJt1
        Ok6s7zGpsmFpLDBH7ooMJyWet8j35aDi+adrywPrhdK8EXC0HBYnPZXSvr8Lgkogozzf+c
        uLLXHEICLOQnfy9ZjPDnyNHkQwaS1Bo=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-BwC3_va4NU-B1rB7HSByeg-1; Wed, 02 Mar 2022 07:18:56 -0500
X-MC-Unique: BwC3_va4NU-B1rB7HSByeg-1
Received: by mail-oo1-f70.google.com with SMTP id y77-20020a4a4550000000b0031be0960299so1107869ooa.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 04:18:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=CQIwtHkHzYTYJnngpsaoFGg2phTUpA1DDWldBn55VNw=;
        b=OneOwo0x48cXykvqxgMCGxODPwtTxwm55ORKzobXQt2FF8NTPMC4jNOPqVn3Beettj
         /8fjGDNc+cWTbZQsah6hocQoCpuvVT17i/+BjWkFI4wVHiQEOfHgze4FgfkWiECk+EiV
         S/VaEzCvACSx4RUvcncICaIJQT5tu/b+iB9f7nJ2vWRsN1RDDsMQgaE7BBOovP+jfgS+
         mrUlHCllijXALAvhamRYpVnvoV+B+/zsox0uVKYB8M1MqiJ9r720JTkzxX7TQ9t3Khr/
         zYeT3ISK4Q6bSTscQtWB3LQcWPWGAbrF1JQ/tAufN9AXLrasRVeNnz6NwWQfI1mPXtM9
         sj2g==
X-Gm-Message-State: AOAM532owmA/u5J29tdDf43qkzKxKHh3R9AdDsDI6hO98G1DshGMtvsM
        DT5PBEm7/6as8GmRm8/RNSOxrgB7X7K9Qo6qjcYtIJdGRgtbSr/M4J93TQIj9lKb7JxQ866S3MQ
        bv/Hi4hraYmEPFh4bIGRlCn8ZPwFjx4y23JAvQF+oLLhbk5SkctYNQIs1hmlapH1snFipC9g=
X-Received: by 2002:a05:6870:f71f:b0:d7:5f1b:534f with SMTP id ej31-20020a056870f71f00b000d75f1b534fmr3992870oab.109.1646223535202;
        Wed, 02 Mar 2022 04:18:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwwFSn9bq4J/gb3vPe90vs63pgMwy9LWUUx7VVubtpR9xkREKJT+AW/HBTh1TeSBX4HYb/3ww==
X-Received: by 2002:a05:6870:f71f:b0:d7:5f1b:534f with SMTP id ej31-20020a056870f71f00b000d75f1b534fmr3992844oab.109.1646223534882;
        Wed, 02 Mar 2022 04:18:54 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id l8-20020a4ad9c8000000b0031bec309e0asm7480117oou.6.2022.03.02.04.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 04:18:54 -0800 (PST)
Subject: Re: [PATCH] drm/panfrost: cleanup comments
To:     Steven Price <steven.price@arm.com>, robh@kernel.org,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220301124339.264544-1-trix@redhat.com>
 <5263b251-53ee-aebd-80e3-79a8d47335eb@arm.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <6c598625-ff78-0fd5-3787-e59415751f4f@redhat.com>
Date:   Wed, 2 Mar 2022 04:18:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <5263b251-53ee-aebd-80e3-79a8d47335eb@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/2/22 1:09 AM, Steven Price wrote:
> On 01/03/2022 12:43, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> For spdx
>> change tab to space delimiter
>> Use // for *.c
>>
>> Replacements
>> commited to committed, use multiline comment style
>> regsiters to registers
>> initialze to initialize
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
> Thanks, most of the changes look reasonable (although I've never
> understood the reason for using // for SPDX comments), but there's one
> below that I think needs rethinking.
>
>> ---
>>   drivers/gpu/drm/panfrost/panfrost_drv.c          | 2 +-
>>   drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c | 2 +-
>>   drivers/gpu/drm/panfrost/panfrost_issues.h       | 6 ++++--
>>   drivers/gpu/drm/panfrost/panfrost_mmu.c          | 2 +-
>>   drivers/gpu/drm/panfrost/panfrost_regs.h         | 2 +-
>>   5 files changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
>> index 96bb5a4656278..94b6f0a19c83a 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
>> @@ -562,7 +562,7 @@ static int panfrost_probe(struct platform_device *pdev)
>>   
>>   	pfdev->coherent = device_get_dma_attr(&pdev->dev) == DEV_DMA_COHERENT;
>>   
>> -	/* Allocate and initialze the DRM device. */
>> +	/* Allocate and initialize the DRM device. */
>>   	ddev = drm_dev_alloc(&panfrost_drm_driver, &pdev->dev);
>>   	if (IS_ERR(ddev))
>>   		return PTR_ERR(ddev);
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
>> index b0142341e2235..77e7cb6d1ae3b 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
>> @@ -1,4 +1,4 @@
>> -/* SPDX-License-Identifier: GPL-2.0 */
>> +// SPDX-License-Identifier: GPL-2.0
>>   /* Copyright (C) 2019 Arm Ltd.
>>    *
>>    * Based on msm_gem_freedreno.c:
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_issues.h b/drivers/gpu/drm/panfrost/panfrost_issues.h
>> index 8e59d765bf19f..4e7cf979ee67a 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_issues.h
>> +++ b/drivers/gpu/drm/panfrost/panfrost_issues.h
>> @@ -13,8 +13,10 @@
>>    * to care about.
>>    */
>>   enum panfrost_hw_issue {
>> -	/* Need way to guarantee that all previously-translated memory accesses
>> -	 * are commited */
>> +	/*
>> +	 * Need way to guarantee that all previously-translated memory accesses
>> +	 * are committed
>> +	 */
> This file has a whole load of multiline comments that don't technically
> follow the coding style. Fixing just one comment makes the file
> inconsistent. Note we recently had a discussion about this[1] and
> decided to leave the comment style as is. And I have to admit in this
> instance avoiding the extra mostly-blank lines makes the list easier to
> read. The typo fix is obviously welcomed though!

I'll switch this back in a respin.

Thanks

Tom


>
> [1] https://lore.kernel.org/r/c7331489-ad04-0f35-224e-164f144fb819%40arm.com
>
>>   	HW_ISSUE_6367,
>>   
>>   	/* On job complete with non-done the cache is not flushed */
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
>> index 39562f2d11a47..d3f82b26a631d 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
>> @@ -1,4 +1,4 @@
>> -// SPDX-License-Identifier:	GPL-2.0
>> +// SPDX-License-Identifier: GPL-2.0
>>   /* Copyright 2019 Linaro, Ltd, Rob Herring <robh@kernel.org> */
>>   
>>   #include <drm/panfrost_drm.h>
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_regs.h b/drivers/gpu/drm/panfrost/panfrost_regs.h
>> index 6c5a11ef1ee87..efe4b75149d35 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_regs.h
>> +++ b/drivers/gpu/drm/panfrost/panfrost_regs.h
>> @@ -292,7 +292,7 @@
>>   #define AS_FAULTADDRESS_LO(as)		(MMU_AS(as) + 0x20) /* (RO) Fault Address for address space n, low word */
>>   #define AS_FAULTADDRESS_HI(as)		(MMU_AS(as) + 0x24) /* (RO) Fault Address for address space n, high word */
>>   #define AS_STATUS(as)			(MMU_AS(as) + 0x28) /* (RO) Status flags for address space n */
>> -/* Additional Bifrost AS regsiters */
>> +/* Additional Bifrost AS registers */
>>   #define AS_TRANSCFG_LO(as)		(MMU_AS(as) + 0x30) /* (RW) Translation table configuration for address space n, low word */
>>   #define AS_TRANSCFG_HI(as)		(MMU_AS(as) + 0x34) /* (RW) Translation table configuration for address space n, high word */
>>   #define AS_FAULTEXTRA_LO(as)		(MMU_AS(as) + 0x38) /* (RO) Secondary fault address for address space n, low word */

