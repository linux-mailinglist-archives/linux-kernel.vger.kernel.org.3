Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9854A53919F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 15:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344460AbiEaNP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 09:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240097AbiEaNPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:15:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2731291562
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654002951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8g5Zs7/DxZx8xn7bN7XsCcZehoYRYs6ruSZGxdOu79k=;
        b=F78MjaMQCVZgMlorDXMz0AzKtKYEOdq01xsiXssy7NX3AQWlLmO0YgcoBCJvc7LZzIvNtE
        lCRv2rL2YXDltIA5DDn9stzaWybw6Pw/KL/QqTY0CxOE7W8IowM0Q58BZbE4VHd2WDbQQK
        WOAPC8r+9JlkjvqA6H3u7hiTTq4mvGA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-ERwLDqcZPpqpxFjZAlC0CQ-1; Tue, 31 May 2022 09:15:50 -0400
X-MC-Unique: ERwLDqcZPpqpxFjZAlC0CQ-1
Received: by mail-wm1-f69.google.com with SMTP id bg13-20020a05600c3c8d00b003974d0ff917so1282612wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=8g5Zs7/DxZx8xn7bN7XsCcZehoYRYs6ruSZGxdOu79k=;
        b=VAAWqTuco+53Lj6nb5zcJszan5pvTvM4QNCRdhgHpuTV+yl4Q05JVe/Hx/nyLPdmer
         gIblJVfj2V/NkpuH6Oqnp3ZVgbXrpTpLHNyH1JjO/f4dSkCKAzh8QW1LI7QtmfXPkfYP
         jQNaXRsWnw9bA/zNTbbNx/tCkdOrz7wagpn6RoA3ejwzgAeGEd7xmHlmBJhHyAXh1Bx0
         UPccS6B1F2sGHDLMSmPAHDhzUWYSBzIRLeI4YP0Qbg6pHLe/IeLrUynwIOiHrESW4Hi8
         hvvnQsSi2fC91r/VSy+mcn3Akv0Jc57/HSyYFpzDzA4k/gmV3HFBF8hNgWA534bpz0l2
         NbpQ==
X-Gm-Message-State: AOAM530q1ZeMG5iv2ukru++LCmCbbuayCdMOnLXoXhOt8yYnPmi5CjTl
        NPSFsdPjxmnYrP3GjXVI4naJ1YM1EZ4pbO0+CYZVodUu83TikBic0U5Ye1qllNW21OvZEorF+2M
        0Hy6NROiPogZoPq+jVa7DQIPb
X-Received: by 2002:adf:e19a:0:b0:210:157c:7b3c with SMTP id az26-20020adfe19a000000b00210157c7b3cmr18610987wrb.121.1654002948948;
        Tue, 31 May 2022 06:15:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxocEA13QBe9bbFdbsGzvpgsNP/9zh0oKWijJEwUu17Yl/O0lvSEZWZH1tu1i9qPwYnsv10NQ==
X-Received: by 2002:adf:e19a:0:b0:210:157c:7b3c with SMTP id az26-20020adfe19a000000b00210157c7b3cmr18610962wrb.121.1654002948704;
        Tue, 31 May 2022 06:15:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:f100:8096:9368:ba52:a341? (p200300cbc708f10080969368ba52a341.dip0.t-ipconnect.de. [2003:cb:c708:f100:8096:9368:ba52:a341])
        by smtp.gmail.com with ESMTPSA id q9-20020a1cf309000000b0039754d1d327sm2104386wmq.13.2022.05.31.06.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 06:15:48 -0700 (PDT)
Message-ID: <b38f4597-0d9b-5b17-0b24-13d99605fb69@redhat.com>
Date:   Tue, 31 May 2022 15:15:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v8 3/7] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-4-eric.devolder@oracle.com>
 <62089f7b-4a3e-7dc8-1cda-84583e19d6fd@redhat.com>
 <e4120abd-c3ac-ee4d-1a0d-260126914b09@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <e4120abd-c3ac-ee4d-1a0d-260126914b09@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.05.22 18:10, Eric DeVolder wrote:
> David,
> Great questions! See inline responses below.
> eric

Sorry for the late reply, travel and vacation ...

>>
>>> +
>>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>>> +void __weak arch_crash_handle_hotplug_event(struct kimage *image,
>>> +							unsigned int hp_action, unsigned int cpu)
>>> +{
>>> +	WARN(1, "crash hotplug handler not implemented");
>>
>>
>> Won't that trigger on any arch that has CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG?
>> I mean, you only implement it for x86 later in this series. Or what else stops this WARN from
>> triggering?
>>
> You're correct. What about: printk_once(KERN_DEBUG "...") ?

Why even bother about printing anything? If the feature is not
supported, there should be some way for user space to figure out that it
sill has to reload on hot(un)plug manually, no?


[...]

> 
>>
>> 2. Why can't the unprotect+reprotect not be done inside
>> arch_crash_handle_hotplug_event() ? It's all arch specific either way.
>>
>> IMHO, this code here should be as simple as
>>
>> if (kexec_crash_image)
>> 	arch_crash_handle_hotplug_event(kexec_crash_image, hp_action, cpu);
>>
> 
> The intent of this code was to be generic infrastructure. Just invoking the
> arch_crash_handle_hotplug_event() would certainly be as generic as it gets.
> But there were a series of steps that seemed to be common, so those I hoisted
> into this bit of code.

But most common parts are actually arch_* calls already? :)

Anyhow, no strong opinion.

> 
>> 3. Why do we have to forward the CPU for CPU onlining/offlining but not the
>> memory block id (or similar) when onlining/offlining a memory block?
>  From patch "kexec: exclude hot remove cpu from elfcorehdr notes" commit message:
> 
> Due to use of CPUHP_AP_ONLINE_DYN, upon CPU unplug, the CPU is
> still in the for_each_present_cpu() list when within the
> handle_hotplug_event(). Thus the CPU must be explicitly excluded
> when building the new list of CPUs.
> 
> This change identifies in handle_hotplug_event() the CPU to be
> excluded, and the check for excluding the CPU in
> crash_prepare_elf64_headers().
> 
> If there is a better CPUHP_ to use than _DYN, I'd be all for that!

Ah okay, thanks.

-- 
Thanks,

David / dhildenb

