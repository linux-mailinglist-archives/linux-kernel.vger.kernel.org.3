Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323F74AA57C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 02:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378938AbiBEBzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 20:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378667AbiBEBzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 20:55:49 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBE3C061346
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 17:55:48 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o16-20020a17090aac1000b001b62f629953so14681964pjq.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 17:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=hGTVW+01e4GIAkWOjoFjzjXZ+1intL+wDAwZzXY0atY=;
        b=MKyUMfHjlP5/X/3UuWqXNYJLGgIfTcrMciakaNzzdl5lJSqfrUaaYEygfM0LRmxhOs
         fw6VQzFRdQQS9LGthD5la6HPu7wjOr4eBuXNeuQpQiSy7Zi0S3mhtvRyxIuOgvEBueGQ
         Cyjl//36hjg0rLX6YXFubWfp0VLeNtiZQ26SqNw7w6wDFYbS/sOQrz4rLh5iSiAIq87l
         ntU2ZymE3/eEO7ZdR6Gn5814oVCx0HsotkhlahfaX6mPky2zND6sXRtO6M3meyMvQ2q4
         dZxORk6lg4X98K8vzE0i6JFArp4i+tI82K/464s+Z74VIpUSuEOF8rplAqWyeuYcG7h8
         U5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hGTVW+01e4GIAkWOjoFjzjXZ+1intL+wDAwZzXY0atY=;
        b=RT109szqRxE+ZmTSPvbdxKeMu0kXXlOBx8o4PZ/fDkdo+oCiG2fJcrz0NpT6+1T3Cm
         Ld1c+OMqPO120fz7zzK3LdUpx2BG/V5vCIHiijowg9e/CfHVPp4JODD9bAGCMBrd1Rzn
         H5UH0NgRe4K4Hvb7yAp6Qipqo2oHMhwXNYM7Pdyp2p13jd0GyOmY8vE82IeMYgNrR5Uh
         zqk39+ROGe4IHQhHefjAMGnOX39ObyE3fHq2dN8sqAT0RPoeP1o5Eud+4eHrS0nOp0CS
         r34Z5nI+betXW1DKHM05miK67P4sgrpf7SJ0V3SwhE2eEjeax+Yu2Mt8Kp++RiAYqZPc
         8q5w==
X-Gm-Message-State: AOAM5332pNdqHaehVGzwrLddGjBaqqAZ8ESCatK49D9Mb4KLxzSl406E
        dCrFPv91f+g+APFQ8dcEfbI=
X-Google-Smtp-Source: ABdhPJzkj9ah/MKJt0tBrGU4CnDflWStMfgavXmyxNOSvps0iRQxrimCRm86/5KuVkfVZjtIIJTnPw==
X-Received: by 2002:a17:902:e803:: with SMTP id u3mr5800746plg.41.1644026147342;
        Fri, 04 Feb 2022 17:55:47 -0800 (PST)
Received: from [10.200.0.18] ([85.203.23.14])
        by smtp.gmail.com with ESMTPSA id y41sm3913585pfa.213.2022.02.04.17.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 17:55:46 -0800 (PST)
Message-ID: <8fa82beb-468c-afb0-3eed-4240200395a3@gmail.com>
Date:   Sat, 5 Feb 2022 09:55:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [BUG] gpu: drm: radeon: two possible deadlocks involving locking
 and waiting
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        alexander.deucher@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <d5e4460f-7e26-81d2-2efe-6f47760b78d2@gmail.com>
 <7cdc2d3f-df52-f7a9-15bf-fe4bc01d3c4f@amd.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
In-Reply-To: <7cdc2d3f-df52-f7a9-15bf-fe4bc01d3c4f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

Thanks for the reply :)

On 2022/2/1 15:56, Christian König wrote:
> Hi Jia-Ju,
>
> interesting that you have found those issues with an automated tool.
>
> And yes that is a well design flaw within the radeon driver which can 
> happen on hardware faults, e.g. when radeon_ring_backup() needs to be 
> called.

In fact, my tool finds dozens of similar possible deadlocks caused by 
wait_event_timeout() in radeon_fence_wait_seq_timeout().
There are three other examples in Linux 5.16:

#BUG 1
radeon_dpm_change_power_state_locked()
   mutex_lock(&rdev->ring_lock); --> Line 1133 (Lock A)
   radeon_fence_wait_empty()
     radeon_fence_wait_seq_timeout()
       wait_event_timeout(rdev->fence_queue, ...) --> Line 504 (Wait X)

radeon_fence_driver_fini()
   mutex_lock(&rdev->ring_lock); --> Line 917 (Lock A)
   wake_up_all(&rdev->fence_queue); --> Line 927 (Wake X)

#BUG 2
radeon_set_pm_profile()
   mutex_lock(&rdev->pm.mutex); --> Line 382 (Lock A)
   radeon_pm_set_clocks()
     radeon_fence_wait_empty()
       radeon_fence_wait_seq_timeout()
         wait_event_timeout(rdev->fence_queue, ...) --> Line 504 (Wait X)

radeon_dynpm_idle_work_handler()
   mutex_lock(&rdev->pm.mutex); --> Line 1861 (Lock A)
   radeon_fence_count_emitted()
     radeon_fence_process()
       wake_up_all(&rdev->fence_queue); --> Line 323 (Wake X)

#BUG 3
radeon_pm_fini_old()
   mutex_lock(&rdev->pm.mutex); --> Line 1642 (Lock A)
   radeon_pm_set_clocks()
     radeon_fence_wait_empty()
       radeon_fence_wait_seq_timeout()
         wait_event_timeout(rdev->fence_queue, ...) --> Line 504 (Wait X)

radeon_dynpm_idle_work_handler()
   mutex_lock(&rdev->pm.mutex); --> Line 1861 (Lock A)
   radeon_fence_count_emitted()
     radeon_fence_process()
       wake_up_all(&rdev->fence_queue); --> Line 323 (Wake X)

Thus, to fix these possible deadlocks, we could moditify the code 
related to radeon_fence_wait_seq_timeout().
But I am not quite familar with the radeon driver, so I am not sure how 
to moditify the code properly.

>
> But that happens so rarely and the driver is not developed further 
> that we decided to not address this any more.

Ah, okay.

>
> Regards,
> Christian.
>
> Am 01.02.22 um 08:40 schrieb Jia-Ju Bai:
>> Hello,
>>
>> My static analysis tool reports a possible deadlock in the radeon 
>> driver in Linux 5.16:
>>
>> #BUG 1
>> radeon_dpm_change_power_state_locked()
>>   mutex_lock(&rdev->ring_lock); --> Line 1133 (Lock A)
>>   radeon_fence_wait_empty()
>>     radeon_fence_wait_seq_timeout()
>>       wait_event_timeout(rdev->fence_queue, ...) --> Line 504 (Wait X)
>>
>> radeon_ring_backup()
>>   mutex_lock(&rdev->ring_lock); --> Line 289(Lock A)
>>   radeon_fence_count_emitted()
>>     radeon_fence_process()
>>       wake_up_all(&rdev->fence_queue); --> Line 323 (Wake X)
>>
>> When radeon_dpm_change_power_state_locked() is executed, "Wait X" is 
>> performed by holding "Lock A". If radeon_ring_backup() is executed at 
>> this time, "Wake X" cannot be performed to wake up "Wait X" in 
>> radeon_dpm_change_power_state_locked(), because "Lock A" has been 
>> already hold by radeon_dpm_change_power_state_locked(), causing a 
>> possible deadlock.
>> I find that "Wait X" is performed with a timeout 
>> MAX_SCHEDULE_TIMEOUT, to relieve the possible deadlock; but I think 
>> this timeout can cause inefficient execution.
>>
>> #BUG 2
>> radeon_ring_lock()
>>   mutex_lock(&rdev->ring_lock); --> Line 147 (Lock A)
>>   radeon_ring_alloc()
>>     radeon_fence_wait_next()
>>       radeon_fence_wait_seq_timeout()
>>         wait_event_timeout(rdev->fence_queue, ...) --> Line 504 (Wait X)
>>
>> radeon_ring_backup()
>>   mutex_lock(&rdev->ring_lock); --> Line 289(Lock A)
>>   radeon_fence_count_emitted()
>>     radeon_fence_process()
>>       wake_up_all(&rdev->fence_queue); --> Line 323 (Wake X)
>>
>> When radeon_ring_lock() is executed, "Wait X" is performed by holding 
>> "Lock A". If radeon_ring_backup() is executed at this time, "Wake X" 
>> cannot be performed to wake up "Wait X" in radeon_ring_lock(), 
>> because "Lock A" has been already hold by radeon_ring_lock(), causing 
>> a possible deadlock.
>> I find that "Wait X" is performed with a timeout 
>> MAX_SCHEDULE_TIMEOUT, to relieve the possible deadlock; but I think 
>> this timeout can cause inefficient execution.
>>
>> I am not quite sure whether these possible problems are real and how 
>> to fix them if they are real.
>> Any feedback would be appreciated, thanks :)
>>
>>
>> Best wishes,
>> Jia-Ju Bai
>>
>

