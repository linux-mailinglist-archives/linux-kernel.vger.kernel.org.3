Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245274DC587
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbiCQMJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbiCQMJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:09:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606FDDE5;
        Thu, 17 Mar 2022 05:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0JZzfJAkTdkGYNpH8EJT14kCI2Y7nlW8c2dvT/x1SJQ=; b=L339elo/cKbp2I0HS6N/130ZB2
        JkkYmfQByyATHDcgmq1Zbs/NFaX74OihhNAOULMYUV/Yn/yUCpgPlrBPrqlYo/AwqmSTZCjGLz5QI
        2wwwkhEf7s2XHAXfY1ODgh2PX0blYCz9GTVYK33v8tN/OGJihmXHSQ0ziO/DHdo2NxkQjOYFmA1wr
        VbiVyCK2KX4JxBMXWKKygUZWm5on8IsKdVTc6bQRfDGbEVpA03y85o48REyF7QNct+Ywx2sDadX9Y
        p2kgeFUeH6l1bnGw4JaQNAOz4eAQ4NqUi73VTW/XX7kSrEtAyUBLjs5eG5Kif2iipFZcLImBpBd5K
        +ceMxmkA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUouy-001sm0-Ql; Thu, 17 Mar 2022 12:07:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EE0753001EA;
        Thu, 17 Mar 2022 13:07:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D6F002B3B2766; Thu, 17 Mar 2022 13:07:47 +0100 (CET)
Date:   Thu, 17 Mar 2022 13:07:47 +0100
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
Subject: Re: [PATCH 7/7] kvm: x86/cpuid: Fix Architectural Performance
 Monitoring support
Message-ID: <YjMkk/O1UqaKpFja@hirez.programming.kicks-ass.net>
References: <cover.1647498015.git.sandipan.das@amd.com>
 <bc58ac02d642ea1fcbd04a525046dfe978e9f323.1647498015.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc58ac02d642ea1fcbd04a525046dfe978e9f323.1647498015.git.sandipan.das@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 11:58:36AM +0530, Sandipan Das wrote:
> CPUID 0xA provides information on Architectural Performance
> Monitoring features on some x86 processors. It advertises a
> PMU version which Qemu uses to determine the availability of
> additional MSRs to manage the PMCs.
> 
> Upon receiving a KVM_GET_SUPPORTED_CPUID ioctl request for
> the same, the kernel constructs return values based on the
> x86_pmu_capability irrespective of the vendor.
> 
> This CPUID function and additional MSRs are not supported on
> AMD processors. If PerfMonV2 is detected, the PMU version is
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
> index b8f8d268d058..1d9ca5726167 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -865,6 +865,11 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  		union cpuid10_eax eax;
>  		union cpuid10_edx edx;
>  
> +		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
> +			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
> +			break;
> +		}
> +

Because actually implementing perfmon-v2 would've been too convenient,
right? IIRC you're very close to actually supporing perfmon-v2
capability wise here.
