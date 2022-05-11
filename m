Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E81523242
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbiEKL6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbiEKL6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:58:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E1A03B287
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 04:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652270280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ej854CR7sjtYFdE3sImjC64n7WhVCOgxuIOus5Vy29E=;
        b=HeCmakqNXK2XGhwnkqTocE1A2H4OwbHetcW9BasBJzKgbzCHKmXdc735Ni0c5VF7zFw/qo
        zehGkshs7LfPfi4/hdmZC9bIrJMGua+tzp2iwWOnT/5wTM+2Ow3UZSl2FK66G0FNh+hhGZ
        bzaIb5kF+Q6PMLSfWVQx17YCkalujbc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-NJ6SpJTvNjONdSjaUbFOSA-1; Wed, 11 May 2022 07:57:51 -0400
X-MC-Unique: NJ6SpJTvNjONdSjaUbFOSA-1
Received: by mail-wr1-f72.google.com with SMTP id u11-20020a056000038b00b0020c9ea8b64fso764638wrf.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 04:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ej854CR7sjtYFdE3sImjC64n7WhVCOgxuIOus5Vy29E=;
        b=fYPCbSLHfJX4EfeoCKesCUqYI44ur1QtKp6tMR4R36hLlPbG5VEqMpRc6ox2rdg5Ig
         DK1C6DxVOwCA29dNqIH4o/YMxLmxv8Ub8+8UHgWJkO5UZZGnEG/8LtmSYdHtYwb4ynt+
         b3GNIuqoN8325wabutDT39/5LxevjJn24J2tXZeSF4LCpUXAyFrVlzgakHlp4cn1iR1B
         NAsilCpgXFPGcPMu4eeJ8SAukdS0u8F1+j1SzZz8eZQ4GpkadgABF+2x6rmDakZOCflg
         1TKXs/3C3d/NPWNXhrFzq8i2NsWgjjiSdmy/xpkVHPzXryocgPFmLq0gPRm5SWDAldbw
         s1tw==
X-Gm-Message-State: AOAM532Dy64RoVhc9WT85LmdjO61Tmi6kMLkh8yEKkkDymhdMFs3OmtK
        LskrEsz+pn3piJtbNc6rrq364Eu1E9h4Q5zZCPBe3jCAYTjR2PrgInuHjwj88aHfMPGj9vu/ZRl
        feiUniEaYdfcrxIFqMaqyG7iC
X-Received: by 2002:a05:6000:2cc:b0:20c:5c31:1120 with SMTP id o12-20020a05600002cc00b0020c5c311120mr22951568wry.105.1652270270703;
        Wed, 11 May 2022 04:57:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwx9aLP2JJ/CLGyt+kNia9KejENyTsMYfDrJSFT3ZMYJR/pCAxu1qiLtl7C2ddCWenOmQ+cA==
X-Received: by 2002:a05:6000:2cc:b0:20c:5c31:1120 with SMTP id o12-20020a05600002cc00b0020c5c311120mr22951554wry.105.1652270270492;
        Wed, 11 May 2022 04:57:50 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t16-20020a5d49d0000000b0020c5253d8edsm1498471wrs.57.2022.05.11.04.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 04:57:50 -0700 (PDT)
Message-ID: <4727ce99-7107-d806-cbea-cd45c6ce6106@redhat.com>
Date:   Wed, 11 May 2022 13:57:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5 3/7] fbdev: Restart conflicting fb removal loop when
 unregistering devices
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220511112438.1251024-1-javierm@redhat.com>
 <20220511113039.1252432-1-javierm@redhat.com>
 <2156c28c-9c9c-555e-ce19-933cdc8d5e74@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <2156c28c-9c9c-555e-ce19-933cdc8d5e74@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 5/11/22 13:47, Thomas Zimmermann wrote:
> Hi Javier
> 
> Am 11.05.22 um 13:30 schrieb Javier Martinez Canillas:
>> Drivers that want to remove registered conflicting framebuffers prior to
>> register their own framebuffer, calls remove_conflicting_framebuffers().
>>
>> This function takes the registration_lock mutex, to prevent a races when
>> drivers register framebuffer devices. But if a conflicting framebuffer
>> device is found, the underlaying platform device is unregistered and this
>> will lead to the platform driver .remove callback to be called, which in
>> turn will call to the unregister_framebuffer() that takes the same lock.
>>
>> To prevent this, a struct fb_info.forced_out field was used as indication
>> to unregister_framebuffer() whether the mutex has to be grabbed or not.
>>
>> A cleaner solution is to drop the lock before platform_device_unregister()
>> so unregister_framebuffer() can take it when called from the fbdev driver,
>> and just grab the lock again after the device has been registered and do
>> a removal loop restart.
>>
>> Since the framebuffer devices will already be removed, the loop would just
>> finish when no more conflicting framebuffers are found.
>>
>> Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> I'd like to shrink this patchset. This looks like it can be merged 

Same. At least this version dropped a few patches that we had in v4
(related to DRM_FIRMWARE capability flag).

> immediately?
>

Yes, this one is independent of the others and could be merged already.

> Best regards
> Thomas
> 

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

