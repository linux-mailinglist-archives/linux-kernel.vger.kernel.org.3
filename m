Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5DD4CE69D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 20:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbiCETyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 14:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiCETyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 14:54:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2193E6FA08
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 11:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646510032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BVchXvU8CyzA6t7mtwadynJ08CJYubxgp033WpFjd8Q=;
        b=PbWtuO/bCE5o98Z6mgkXRWv7tPimgIYk3hyr9xAShHS8shjFR68xN9vZGDe+4eCOPm3kI2
        lKBaqY0A0wBdJm3+RgKQfXe1NW/KWeXqFgxtClPdDfIZLH69TOZqQtrQAt5g01ov9nG7pf
        2Md8DTSVfF9SSwbSNdMB6RQeZUFBq2c=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-vI-cY_eiPMyYrVLNR7yomg-1; Sat, 05 Mar 2022 14:53:48 -0500
X-MC-Unique: vI-cY_eiPMyYrVLNR7yomg-1
Received: by mail-ej1-f72.google.com with SMTP id m12-20020a1709062acc00b006cfc98179e2so5938506eje.6
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 11:53:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BVchXvU8CyzA6t7mtwadynJ08CJYubxgp033WpFjd8Q=;
        b=mAxM0LZl42M86x1+uGjMPLqzroN0FxhABqb7s9n1UF0xs6mnXNrvevRipkCb9YgRff
         BB3vwW240v6rifiW268qD6OB4QO9W4NBnk8haxG8SQT2j6LWYSfUQVtDnNTOf8OFSVb9
         oF1ME6GxRjzJEv8eBWFVe23I16lYkEIwTXjZpuYPl2+h4gc2EPpUva9CHlYqnN2VDwgq
         4uDZYvLAQw6iMQOLt9umYCAUafXy7Dy+UzO3cQOLJzcY/efcJabK3NRMhTLGzGDmp8ET
         nk85S0F/BY+DVmUQbSF2s4NAl6rfNVk2wyv7QQ4ClqHoi71r/DV6b3UBn/L3/z5nMjFy
         0aew==
X-Gm-Message-State: AOAM532cu4A6fCqpQUVfB+D6d/YSPLuLMn59NVXRG8hnbAvMXcYhlORc
        pGtMSWisohJn0donw2Z1r+W4Pexmd+g5spB1oaZYGXNI4aEhSEK5M7/2aDMcZAEsukMYP6M6AlA
        DBaXMJiDjNPMFR+mXbw3RHkKN
X-Received: by 2002:a05:6402:354c:b0:412:b2f2:f8e4 with SMTP id f12-20020a056402354c00b00412b2f2f8e4mr4190418edd.269.1646510027571;
        Sat, 05 Mar 2022 11:53:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzR1kMrFEG9G+BY+Arx/NW6nRN0BXh8in+Ws1YdhtEkp+kc8r+5IjVmJvhhJXoJcsqlEweHg==
X-Received: by 2002:a05:6402:354c:b0:412:b2f2:f8e4 with SMTP id f12-20020a056402354c00b00412b2f2f8e4mr4190402edd.269.1646510027294;
        Sat, 05 Mar 2022 11:53:47 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id n9-20020a05640205c900b00415fbbdabbbsm2628407edx.9.2022.03.05.11.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Mar 2022 11:53:46 -0800 (PST)
Message-ID: <20497464-0606-7ea5-89b8-8f5cd56a1a68@redhat.com>
Date:   Sat, 5 Mar 2022 20:53:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 21/30] KVM: x86/mmu: Zap invalidated roots via
 asynchronous worker
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Hildenbrand <david@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Mingwei Zhang <mizhang@google.com>
References: <20220303193842.370645-1-pbonzini@redhat.com>
 <20220303193842.370645-22-pbonzini@redhat.com> <YiExLB3O2byI4Xdu@google.com>
 <YiEz3D18wEn8lcEq@google.com>
 <eeac12f0-0a18-8c63-1987-494a2032fa9d@redhat.com>
 <YiI4AmYkm2oiuiio@google.com>
 <8b8c28cf-cf54-f889-be7d-afc9f5430ecd@redhat.com>
 <YiKwFznqqiB9VRyn@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YiKwFznqqiB9VRyn@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 3/5/22 01:34, Sean Christopherson wrote:
> On Fri, Mar 04, 2022, Paolo Bonzini wrote:
>> On 3/4/22 17:02, Sean Christopherson wrote:
>>> On Fri, Mar 04, 2022, Paolo Bonzini wrote:
>>>> On 3/3/22 22:32, Sean Christopherson wrote:
>>>> I didn't remove the paragraph from the commit message, but I think it's
>>>> unnecessary now.  The workqueue is flushed in kvm_mmu_zap_all_fast() and
>>>> kvm_mmu_uninit_tdp_mmu(), unlike the buggy patch, so it doesn't need to take
>>>> a reference to the VM.
>>>>
>>>> I think I don't even need to check kvm->users_count in the defunct root
>>>> case, as long as kvm_mmu_uninit_tdp_mmu() flushes and destroys the workqueue
>>>> before it checks that the lists are empty.
>>>
>>> Yes, that should work.  IIRC, the WARN_ONs will tell us/you quite quickly if
>>> we're wrong :-)  mmu_notifier_unregister() will call the "slow" kvm_mmu_zap_all()
>>> and thus ensure all non-root pages zapped, but "leaking" a worker will trigger
>>> the WARN_ON that there are no roots on the list.
>>
>> Good, for the record these are the commit messages I have:

I'm seeing some hangs in ~50% of installation jobs, both Windows and 
Linux.  I have not yet tried to reproduce outside the automated tests, 
or to bisect, but I'll try to push at least the first part of the series 
for 5.18.

Paolo

>>      KVM: x86/mmu: Zap invalidated roots via asynchronous worker
>>      Use the system worker threads to zap the roots invalidated
>>      by the TDP MMU's "fast zap" mechanism, implemented by
>>      kvm_tdp_mmu_invalidate_all_roots().
>>      At this point, apart from allowing some parallelism in the zapping of
>>      roots, the workqueue is a glorified linked list: work items are added and
>>      flushed entirely within a single kvm->slots_lock critical section.  However,
>>      the workqueue fixes a latent issue where kvm_mmu_zap_all_invalidated_roots()
>>      assumes that it owns a reference to all invalid roots; therefore, no
>>      one can set the invalid bit outside kvm_mmu_zap_all_fast().  Putting the
>>      invalidated roots on a linked list... erm, on a workqueue ensures that
>>      tdp_mmu_zap_root_work() only puts back those extra references that
>>      kvm_mmu_zap_all_invalidated_roots() had gifted to it.
>>
>> and
>>
>>      KVM: x86/mmu: Zap defunct roots via asynchronous worker
>>      Zap defunct roots, a.k.a. roots that have been invalidated after their
>>      last reference was initially dropped, asynchronously via the existing work
>>      queue instead of forcing the work upon the unfortunate task that happened
>>      to drop the last reference.
>>      If a vCPU task drops the last reference, the vCPU is effectively blocked
>>      by the host for the entire duration of the zap.  If the root being zapped
>>      happens be fully populated with 4kb leaf SPTEs, e.g. due to dirty logging
>>      being active, the zap can take several hundred seconds.  Unsurprisingly,
>>      most guests are unhappy if a vCPU disappears for hundreds of seconds.
>>      E.g. running a synthetic selftest that triggers a vCPU root zap with
>>      ~64tb of guest memory and 4kb SPTEs blocks the vCPU for 900+ seconds.
>>      Offloading the zap to a worker drops the block time to <100ms.
>>      There is an important nuance to this change.  If the same work item
>>      was queued twice before the work function has run, it would only
>>      execute once and one reference would be leaked.  Therefore, now that
>>      queueing items is not anymore protected by write_lock(&kvm->mmu_lock),
>>      kvm_tdp_mmu_invalidate_all_roots() has to check root->role.invalid and
>>      skip already invalid roots.  On the other hand, kvm_mmu_zap_all_fast()
>>      must return only after those skipped roots have been zapped as well.
>>      These two requirements can be satisfied only if _all_ places that
>>      change invalid to true now schedule the worker before releasing the
>>      mmu_lock.  There are just two, kvm_tdp_mmu_put_root() and
>>      kvm_tdp_mmu_invalidate_all_roots().
> 
> Very nice!
> 

