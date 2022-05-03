Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104B351873E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237416AbiECOzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiECOzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:55:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D6CB28E15
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 07:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651589486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MOZQR3NgpnivklRl2WE+IkvBWljH5ijZ+KhrlyE76Oo=;
        b=JulomJUYvjPu6FoQlmk9RI+7bwf8urduy5LBvhyzl65EA0vSlFkStxLVUIHFK6JdqK9w2v
        lhfIBA5MmxucknJdFwT1ZMib64wsCtQHSW/+4HnSNjhLBqLPSPwnBUBVn3DRsJVUBs3Lko
        SboApF4C5FAxxhoqS1BGkys3A/ynuGk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-Pbs9yc4aNGeMWmaXlMgvRg-1; Tue, 03 May 2022 10:51:15 -0400
X-MC-Unique: Pbs9yc4aNGeMWmaXlMgvRg-1
Received: by mail-qv1-f69.google.com with SMTP id kl11-20020a056214518b00b0045a9af67efbso2625368qvb.18
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 07:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MOZQR3NgpnivklRl2WE+IkvBWljH5ijZ+KhrlyE76Oo=;
        b=PGg/t0fIrTk8Z4HVML4BM35VMiQY3FS1OiHvh2p6WfZc04rM/za4UBDYq/5J2JtU5r
         pztA2TuCfAQOfn0H8RZkHimMVLPqut+46rAXHAIMfapb8IsKtrLb+8oxdKNiuRwNJCGb
         eng54a/0U6AWwQOTSJka4ouP7nzGyApwXdE0t1WAB/gQImJa/5mBBmAUg050UesgQGsF
         G8OfgKeODzOljrKx2TM+IKlK5CNneWqYZqRjKhliNloDHkm9UaIDkaXnHxGVfAh93Q8/
         JGfJJiFV1xLaqAmxHyjxX1Jmpio2zu3o/O00WMcVfQ5SHorCgXeEfEJVVQmJt7bb2M0L
         Rsuw==
X-Gm-Message-State: AOAM530QjCE6CyCMTP0aGsD686s1te9lyhq0czc5QpHUN1ELM+fews13
        3a/1Bf4Lw2rClVMeCXxLbHBMWyQWjFMEh036HV3LDy35vXVZ/HwsGZ4QS6HTJvjOdji+dioLd9B
        qVLdr3Z9aDJudXegKLW9yPPxv
X-Received: by 2002:a05:620a:1a04:b0:69f:e7f3:187 with SMTP id bk4-20020a05620a1a0400b0069fe7f30187mr5880477qkb.184.1651579284440;
        Tue, 03 May 2022 05:01:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzC/8kQQ52ivaf4XcEzs5fZ/zZdcgmA1eHs6x4CXVw9nobVuQf45WCIWHqdlFql/e8rZ8Fe2A==
X-Received: by 2002:a05:620a:1a04:b0:69f:e7f3:187 with SMTP id bk4-20020a05620a1a0400b0069fe7f30187mr5880433qkb.184.1651579284037;
        Tue, 03 May 2022 05:01:24 -0700 (PDT)
Received: from [10.32.181.74] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.googlemail.com with ESMTPSA id b9-20020a05620a04e900b0069fc13ce20bsm5788682qkh.60.2022.05.03.05.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 05:01:22 -0700 (PDT)
Message-ID: <f97cb2e3-9b53-6206-4523-8b15b0ee83e4@redhat.com>
Date:   Tue, 3 May 2022 14:01:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 7/7] kvm: x86/cpuid: Fix CPUID leaf 0xA
Content-Language: en-US
To:     Jim Mattson <jmattson@google.com>,
        Sandipan Das <sandipan.das@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, peterz@infradead.org, bp@alien8.de,
        dave.hansen@linux.intel.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        like.xu.linux@gmail.com, eranian@google.com, puwen@hygon.cn,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
References: <cover.1651058600.git.sandipan.das@amd.com>
 <3fef83d9c2b2f7516e8ff50d60851f29a4bcb716.1651058600.git.sandipan.das@amd.com>
 <CALMp9eSdUW6et2Us1if-j2Do6cv9ssyT4C2KPiyomFd7i_Dc1Q@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CALMp9eSdUW6et2Us1if-j2Do6cv9ssyT4C2KPiyomFd7i_Dc1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/22 01:50, Jim Mattson wrote:
> On Wed, Apr 27, 2022 at 4:34 AM Sandipan Das <sandipan.das@amd.com> wrote:
>>
>> On some x86 processors, CPUID leaf 0xA provides information
>> on Architectural Performance Monitoring features. It
>> advertises a PMU version which Qemu uses to determine the
>> availability of additional MSRs to manage the PMCs.
>>
>> Upon receiving a KVM_GET_SUPPORTED_CPUID ioctl request for
>> the same, the kernel constructs return values based on the
>> x86_pmu_capability irrespective of the vendor.
>>
>> This leaf and the additional MSRs are not supported on AMD
>> and Hygon processors. If AMD PerfMonV2 is detected, the PMU
>> version is set to 2 and guest startup breaks because of an
>> attempt to access a non-existent MSR. Return zeros to avoid
>> this.
>>
>> Fixes: a6c06ed1a60a ("KVM: Expose the architectural performance monitoring CPUID leaf")
>> Reported-by: Vasant Hegde <vasant.hegde@amd.com>
>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>> ---
>>   arch/x86/kvm/cpuid.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index 4b62d80bb22f..e66ebb747084 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -872,6 +872,11 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>>                  union cpuid10_eax eax;
>>                  union cpuid10_edx edx;
>>
>> +               if (!static_cpu_has(X86_FEATURE_ARCH_PERFMON)) {
> 
> Should this be checking kvm_cpu_cap_has(X86_FEATURE_ARCH_PERFMON) instead?

Yes, it should.  I have queued this patch for 5.18.

Paolo

