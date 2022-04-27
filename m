Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA98051163D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiD0LDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbiD0LC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:02:59 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B863FBA95;
        Wed, 27 Apr 2022 03:43:48 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id m14so1279412vsp.11;
        Wed, 27 Apr 2022 03:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=mUxyvNhw8WOz4AnMY4MCjfkWROBHShr4sY5p+gR6VSc=;
        b=oFYaMCXtHGQcZ9ME8vMm4BiCzb8QLkyFvbRnwGyry+kBqYwEb87C4VWsYTGUQFPqTU
         Hib6iapsGkX49ee6mn/ocm0tE+q9VExuQtWZpPy9pKiD/R1jixkDYeXoAaDCBLVYIbD9
         ChjezrvqowchRH1zTyf78eD1P2ttNYjFRpK0V0zQAR+6JrEgw7p0fDgxMV30tO391Pg9
         CrAsL4L4SjtIAIXMIASiGvloafM7yfRFgvNqlISBB0i7mnuOutcfCBxha5jSgArNtz01
         M6GXiU1SJ/PUmAlPAAJLx36YLgflckt7FaCxItNBM/dF0ji24lyYcMvgGwjWvwHNoB+F
         kuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=mUxyvNhw8WOz4AnMY4MCjfkWROBHShr4sY5p+gR6VSc=;
        b=Q9H1Y6fx2tZR7JZG5aIQht/rv3EBVnNiXVV+4H4P2mIerPgVf+ju1Dbv+NTxe5j9fP
         sl7if4s+wWxBo9nYCgFj09IMu/XHbttKwm87bLog1Nqf82CSO5CJDcFTAYYe52t/c3cE
         RFG4eWiTQtvMQv0deiQzgqgdsK4ceQtIT4sZSAlYuIlJLO0XwWhddwTXjE07OD/2DQVe
         Llb/Drmmtqvkzx8G6oVvQOUYniLzzLjcUUJOQ9fiiSP6O0cxE9pMyFS32s7gE4WTnhLJ
         v8uOj0hZdWIuejc/qlDWq6o3MtMrtbZp/rTcTDkhck4XbRU+nssU3Cxyfx/ULNIDq2Bb
         OApQ==
X-Gm-Message-State: AOAM532b7LbRXHLyrPV6YxM/k6ZfAp6iPzzb0jTgfE1lZVllUzVp+Ivx
        6KCBwucHXreVAV/2CK9IEI1LMKLEiQw=
X-Google-Smtp-Source: ABdhPJyxYzwCq1uDHdjgt2isejxNcwWLbFn7lXEIErjaGYlcD6Ha5M5WNAXoBC6h4fwzjZgzojOUTw==
X-Received: by 2002:a17:902:da81:b0:15d:37b9:70df with SMTP id j1-20020a170902da8100b0015d37b970dfmr7428157plx.34.1651051938953;
        Wed, 27 Apr 2022 02:32:18 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.118])
        by smtp.gmail.com with ESMTPSA id o34-20020a634e62000000b0039cc4376415sm15359587pgl.63.2022.04.27.02.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 02:32:18 -0700 (PDT)
Message-ID: <da7e8eb6-e473-84ff-1c7b-4214a5233a9b@gmail.com>
Date:   Wed, 27 Apr 2022 17:32:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v3 7/7] kvm: x86/cpuid: Fix CPUID leaf 0xA
Content-Language: en-US
To:     Sandipan Das <sandipan.das@amd.com>,
        Vasant Hegde <vasant.hegde@amd.com>
Cc:     peterz@infradead.org, bp@alien8.de, dave.hansen@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        pbonzini@redhat.com, jmattson@google.com, eranian@google.com,
        puwen@hygon.cn, ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1650977962.git.sandipan.das@amd.com>
 <476a0d6feef8016ed19e4911ac25abdd20aabeb3.1650977962.git.sandipan.das@amd.com>
From:   Like Xu <like.xu.linux@gmail.com>
Organization: Tencent
In-Reply-To: <476a0d6feef8016ed19e4911ac25abdd20aabeb3.1650977962.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/4/2022 9:05 pm, Sandipan Das wrote:
> On some x86 processors, CPUID leaf 0xA provides information
> on Architectural Performance Monitoring features. It
> advertises a PMU version which Qemu uses to determine the
> availability of additional MSRs to manage the PMCs.
> 
> Upon receiving a KVM_GET_SUPPORTED_CPUID ioctl request for
> the same, the kernel constructs return values based on the
> x86_pmu_capability irrespective of the vendor.
> 
> This leaf and the additional MSRs are not supported on AMD
> and Hygon processors. If AMD PerfMonV2 is detected, the PMU

So, why not:

		if (!static_cpu_has(X86_FEATURE_ARCH_PERFMON))
			break;
?

> version is set to 2 and guest startup breaks because of an
> attempt to access a non-existent MSR. Return zeros to avoid
> this.
> 
> Fixes: a6c06ed1a60a ("KVM: Expose the architectural performance monitoring CPUID leaf")
> Reported-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> ---
>   arch/x86/kvm/cpuid.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 4b62d80bb22f..d27d6a8f601a 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -872,6 +872,12 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>   		union cpuid10_eax eax;
>   		union cpuid10_edx edx;
>   
> +		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
> +		    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
> +			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
> +			break;
> +		}
> +
>   		perf_get_x86_pmu_capability(&cap);
>   
>   		/*
