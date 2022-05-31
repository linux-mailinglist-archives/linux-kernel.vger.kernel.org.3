Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7395391A7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 15:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343518AbiEaNTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 09:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237966AbiEaNTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:19:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51C438CCC4
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654003139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3OFpdDpvEH0d1RcZocJscEHOIR3cQWbgW26biloJ57w=;
        b=MkKUGMi5Lwit/lDl6IBGjG2+04XpKFRR+mWf0vd3cY9X7W/dN/y722ftX+QUC94B4ohTOB
        h37cxB73QaQ7Xl4PxBP6VDcaBmKIT66/5d9zOyIUY5WLjfYvqFHiziu4GlfNuFD8xDPiS4
        SGNHfu+Bji/f8PC8lm5/tINmYkMOkfU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-206-vo2iNCStPBOAGVGwBL6L5Q-1; Tue, 31 May 2022 09:18:58 -0400
X-MC-Unique: vo2iNCStPBOAGVGwBL6L5Q-1
Received: by mail-wm1-f71.google.com with SMTP id v126-20020a1cac84000000b00396fe5959d2so6012986wme.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=3OFpdDpvEH0d1RcZocJscEHOIR3cQWbgW26biloJ57w=;
        b=Yza1QGwfQSSPQMGQNhxnzbkkftHBqRQIk5M52qr2CEFXYXMUNHX9/s1InWZIeQHWTg
         Xa+o3O1HW4oRNULdtpeaNzO2VX0QW4SpzpjI5Q1f3tnNY9WScuJFhA6b4cuscTsAkCb6
         RF7zNpy1dEFgbph7zjqfYhNkvWQaDOshE/icTeXx053bhYTVPkyQrJDk1vO0pom6bBzP
         7Ezt49J1cNSW+rnoqaV8r8P2PVz+DsB9WFL4YScm8+E3pmoQ+zLaxdVxeJ+2Ud7tQD9V
         ENhliCfAbA3QnTJp9BHDHC5HFpNlXidCkZn+LW8nBTRIxXJY8wEKS9cZv9Yu+/YIlAk4
         GMNA==
X-Gm-Message-State: AOAM533PdvZGSS6diNDzGwLMEXRiH3D/bjrtr7URZbJkhFZ4rtk40LXa
        7eSJWvGmRTpTvauJYi2rxEhZAdPLK3sZxecepYz+0537siGhQy8nupkCdYPLJz/7FBmwceauuut
        vnKiVV7kbtk2xv8K+xwg52lHb
X-Received: by 2002:a5d:59a5:0:b0:20e:6fee:80ea with SMTP id p5-20020a5d59a5000000b0020e6fee80eamr49164769wrr.373.1654003137141;
        Tue, 31 May 2022 06:18:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkSDDreHSj0TjEpjT91bOhnb2JqpvkYSQ9iUyRMnuCSTf+SXFvnAgWB4MqXLRn75E7nnPoMQ==
X-Received: by 2002:a5d:59a5:0:b0:20e:6fee:80ea with SMTP id p5-20020a5d59a5000000b0020e6fee80eamr49164751wrr.373.1654003136893;
        Tue, 31 May 2022 06:18:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:f100:8096:9368:ba52:a341? (p200300cbc708f10080969368ba52a341.dip0.t-ipconnect.de. [2003:cb:c708:f100:8096:9368:ba52:a341])
        by smtp.gmail.com with ESMTPSA id k18-20020a05600c055200b003974a00697esm2047607wmc.38.2022.05.31.06.18.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 06:18:56 -0700 (PDT)
Message-ID: <5358be66-e545-4482-bad6-00d3d53aac8a@redhat.com>
Date:   Tue, 31 May 2022 15:18:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v8 0/7] crash: Kernel handling of CPU and memory hot
 un/plug
Content-Language: en-US
To:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <311b0834-c675-fd15-8184-82b122f4a9cc@linux.ibm.com>
 <bffb3d9e-1946-f4b6-d58c-9c44bc0bee26@oracle.com>
 <94fba107-a425-7cf6-2a7b-0562c2dcfce4@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <94fba107-a425-7cf6-2a7b-0562c2dcfce4@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.05.22 15:39, Sourabh Jain wrote:
> Hello Eric,
> 
> On 26/05/22 18:46, Eric DeVolder wrote:
>>
>>
>> On 5/25/22 10:13, Sourabh Jain wrote:
>>> Hello Eric,
>>>
>>> On 06/05/22 00:15, Eric DeVolder wrote:
>>>> When the kdump service is loaded, if a CPU or memory is hot
>>>> un/plugged, the crash elfcorehdr (for x86), which describes the CPUs
>>>> and memory in the system, must also be updated, else the resulting
>>>> vmcore is inaccurate (eg. missing either CPU context or memory
>>>> regions).
>>>>
>>>> The current solution utilizes udev to initiate an unload-then-reload
>>>> of the kdump image (e. kernel, initrd, boot_params, puratory and
>>>> elfcorehdr) by the userspace kexec utility. In previous posts I have
>>>> outlined the significant performance problems related to offloading
>>>> this activity to userspace.
>>>>
>>>> This patchset introduces a generic crash hot un/plug handler that
>>>> registers with the CPU and memory notifiers. Upon CPU or memory
>>>> changes, this generic handler is invoked and performs important
>>>> housekeeping, for example obtaining the appropriate lock, and then
>>>> invokes an architecture specific handler to do the appropriate
>>>> updates.
>>>>
>>>> In the case of x86_64, the arch specific handler generates a new
>>>> elfcorehdr, and overwrites the old one in memory. No involvement
>>>> with userspace needed.
>>>>
>>>> To realize the benefits/test this patchset, one must make a couple
>>>> of minor changes to userspace:
>>>>
>>>>   - Disable the udev rule for updating kdump on hot un/plug changes.
>>>>     Add the following as the first two lines to the udev rule file
>>>>     /usr/lib/udev/rules.d/98-kexec.rules:
>>>
>>> If we can have a sysfs attribute to advertise this feature then 
>>> userspace
>>> utilities (kexec tool/udev rules) can take action accordingly. In 
>>> short, it will
>>> help us maintain backward compatibility.
>>>
>>> kexec tool can use the new sysfs attribute and allocate additional 
>>> buffer space
>>> for elfcorehdr accordingly. Similarly, the checksum-related changes 
>>> can come
>>> under this check.
>>>
>>> Udev rule can use this sysfs file to decide kdump service reload is 
>>> required or not.
>>
>> Great idea. I've been working on the corresponding udev and 
>> kexec-tools changes and your input/idea here is quite timely.
>>
>> I have boolean "crash_hotplug" as a core_param(), so it will show up as:
>>
>> # cat /sys/module/kernel/parameters/crash_hotplug
>> N
> 
> How about using 0-1 instead Y/N?
> 0 = crash hotplug not supported
> 1 = crash hotplug supported
> 
> Also how about keeping sysfs here instead?
> /sys/kernel/kexec_crash_hotplug

It's not only about hotplug, though. And actually we care about
onlining/offlining. Hmm, I wonder if there is a better name for this
automatic handling of cpu and memory devices.

-- 
Thanks,

David / dhildenb

