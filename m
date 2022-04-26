Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE7E50F381
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344536AbiDZITW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237082AbiDZITU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:19:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4DC37A32;
        Tue, 26 Apr 2022 01:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J7OvwflG+WFWryD1TbXk5Co3mjsn4aqXPw6H+ddoUm8=; b=KaidGjr788oUFlpZH7GAsV59Dp
        IcqDnnGcjh7cjqZI8HNHzAtePNTptwzt/5VwzQ1/fJde7I/BWyNvjMceVBgMM9XNgJ6xgEH6OBauq
        ZT1/BT/PxMIMcw9lFVZgl10nslxlnXg/sO/9qGywg+YWgBX08bBGaQSUvPPC5Td2KhIh77j3UxAUv
        Y0Wna0S0jdfLX1FuEfJ7MvX9KJ8BGgWg0kDHHoytYZURvsX9+D8jz01NxO5djMSaECNvYkd7yZZ9N
        KmAOxc0bZFR39+hQr274Jmov58SWd5etAWXIFhY10J9SlGJG/eYmN7+hgkFfZHXW4HGOVwHOHQpIH
        RLM5rrGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njGMS-008keo-Dm; Tue, 26 Apr 2022 08:15:52 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF0E39816EC; Tue, 26 Apr 2022 10:15:50 +0200 (CEST)
Date:   Tue, 26 Apr 2022 10:15:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        pbonzini@redhat.com, jmattson@google.com, like.xu.linux@gmail.com,
        eranian@google.com, ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v2 7/7] kvm: x86/cpuid: Fix CPUID leaf 0xA
Message-ID: <20220426081550.GO2731@worktop.programming.kicks-ass.net>
References: <cover.1650515382.git.sandipan.das@amd.com>
 <54bc7fe4cadf6bdef823bab1fba43d4891d2e1a9.1650515382.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54bc7fe4cadf6bdef823bab1fba43d4891d2e1a9.1650515382.git.sandipan.das@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 11:16:59AM +0530, Sandipan Das wrote:
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
> processors. If PerfMonV2 is detected, the PMU version is
> set to 2 and guest startup breaks because of an attempt to
> access a non-existent MSR. Return zeros to avoid this.
> 
> Fixes: a6c06ed1a60a ("KVM: Expose the architectural performance monitoring CPUID leaf")
> Reported-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> ---
>  arch/x86/kvm/cpuid.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 4b62d80bb22f..6bd65cad75ef 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -872,6 +872,11 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  		union cpuid10_eax eax;
>  		union cpuid10_edx edx;
>  
> +		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {

This is the obligatory question about HYGON; should they be included
here?

x86 is getting a number of me-too patches from both sides, where
behaviour has diverged for no raisin and then needs to be fixed up
again.

> +			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
> +			break;
> +		}
> +
>  		perf_get_x86_pmu_capability(&cap);
>  
>  		/*
> -- 
> 2.32.0
> 
