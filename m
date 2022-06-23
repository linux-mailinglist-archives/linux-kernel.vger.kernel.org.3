Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3998D557013
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 03:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiFWBpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 21:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358657AbiFWBpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 21:45:51 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1451343AC8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 18:45:51 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k12-20020a17090a404c00b001eaabc1fe5dso1087611pjg.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 18:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=XBccRW3f809STZYPXXYOmdRu7QvxDSYP9NM/SprVkxQ=;
        b=hLQCWBlBMI7cXx2E87+ADwS9i4fRnadmJHUVnCjL+L3Ew5SWwQ755AeopCCQWXLrwZ
         sE+R9hJmUQKThtWQSBQJw4uiHGHVi/JLX9hl/ararv01AKc/kQZ6W3wOOAPGmtSKQLwM
         jYIcZu0muVb8lsmUyAJBZVVrpp4MpfMUZuOFbgqotSVOH3M4IViviOjqa7BTeEwA0FY8
         mIBhuf3H12Ffp/NZ89ITdv0Duv8uFapXEdLawLEbXbkYGN1xzl14Wm4z/pPQNZesyB8L
         KDJu7GHEWHSQiG5qmCgGcCLdKY6Aoev2zmpDTHJjY6ODKYyZlHpW7SR0f94HNG1/Hvbk
         AVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=XBccRW3f809STZYPXXYOmdRu7QvxDSYP9NM/SprVkxQ=;
        b=aT4lUALJ5Git7NGipESJDHoRx/COPX7eTE7qJmYl/G3pw23UmO6ZcypK12cD38Kl1V
         74i5S3gMCwKhUBKVrtBVm/Fr9Zxta0KqN/lJKvqjYNAjhBHiAnmGaAIPry+ZUQIye8Gg
         fjkScqd8ksvDV/Fswy7NUkVQaMCak+Zlch2vmcDGpJY/7/ehBi+jQhAeP29CWZR8kUfc
         4fIgQCncDCcPIX4oYM1XYfN2dfqi0QMFgKJNUDN6k367FtfVjIduaA2j225dY9gRiVZk
         4MSMTUsvCkfChezRLZALywq3losZ/YmqKM8u3KMZxd30Suzwj1YlB1O7j1JkKiC5dANG
         Xorg==
X-Gm-Message-State: AJIora+bOBCQ6S+TygNNHf5TZkbKZv4u4hdkNHJtTlXdXv/eMwHaMiX2
        6Oq9CH7/1t7TFqJTj4IeogA=
X-Google-Smtp-Source: AGRyM1v79HHyCnNn6RyfKdzxg4cWNNvw6QTiaNpLe4NjJnmtnDArzRRTbD21t8VWNjkFTXBN2iSwSw==
X-Received: by 2002:a17:90a:e7c8:b0:1e6:961f:999d with SMTP id kb8-20020a17090ae7c800b001e6961f999dmr1359069pjb.23.1655948750578;
        Wed, 22 Jun 2022 18:45:50 -0700 (PDT)
Received: from [192.168.50.247] ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id d26-20020a63735a000000b0040cba7ef9b9sm6901613pgn.9.2022.06.22.18.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 18:45:49 -0700 (PDT)
Message-ID: <b0d778de-9be7-f1a0-9356-9daa398edf5e@gmail.com>
Date:   Thu, 23 Jun 2022 09:45:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] gpu: drm: fix possible memory leak in drm_addmap_core()
Content-Language: en-US
From:   Hangyu Hua <hbh25y@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220509054441.17282-1-hbh25y@gmail.com>
 <ea67fa6b-0fcd-4b59-861f-360e74a4d70a@gmail.com>
In-Reply-To: <ea67fa6b-0fcd-4b59-861f-360e74a4d70a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/23 09:57, Hangyu Hua wrote:
> On 2022/5/9 13:44, Hangyu Hua wrote:
>> map->handle need to be handled correctly when map->type is _DRM_SHM or
>> _DRM_CONSISTENT just like map->type is _DRM_REGISTERS.
>>
>> Fixes: 8d153f7107ff ("drm: update user token hashing and map handles")
>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
>> ---
>>   drivers/gpu/drm/drm_bufs.c | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_bufs.c b/drivers/gpu/drm/drm_bufs.c
>> index fcca21e8efac..2b3f504c5f9c 100644
>> --- a/drivers/gpu/drm/drm_bufs.c
>> +++ b/drivers/gpu/drm/drm_bufs.c
>> @@ -344,6 +344,15 @@ static int drm_addmap_core(struct drm_device 
>> *dev, resource_size_t offset,
>>       if (!list) {
>>           if (map->type == _DRM_REGISTERS)
>>               iounmap(map->handle);
>> +        else if (map->type == _DRM_SHM) {
>> +            dev->sigdata.lock = dev->master->lock.hw_lock = NULL;
>> +            vfree(map->handle);
>> +        } else if (map->type == _DRM_CONSISTENT) {
>> +            dma_free_coherent(dev->dev,
>> +                      map->size,
>> +                      map->handle,
>> +                      map->offset);
>> +        }
>>           kfree(map);
>>           return -EINVAL;
>>       }
>> @@ -361,6 +370,15 @@ static int drm_addmap_core(struct drm_device 
>> *dev, resource_size_t offset,
>>       if (ret) {
>>           if (map->type == _DRM_REGISTERS)
>>               iounmap(map->handle);
>> +        else if (map->type == _DRM_SHM) {
>> +            dev->sigdata.lock = dev->master->lock.hw_lock = NULL;
>> +            vfree(map->handle);
>> +        } else if (map->type == _DRM_CONSISTENT) {
>> +            dma_free_coherent(dev->dev,
>> +                      map->size,
>> +                      map->handle,
>> +                      map->offset);
>> +        }
>>           kfree(map);
>>           kfree(list);
>>           mutex_unlock(&dev->struct_mutex);
> 
> Gentel ping.

Gentel ping.
