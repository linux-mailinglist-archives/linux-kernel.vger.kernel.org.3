Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9825520387
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 19:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239567AbiEIR2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 13:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbiEIR16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 13:27:58 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BFC277358;
        Mon,  9 May 2022 10:24:03 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1156D1EC03AD;
        Mon,  9 May 2022 19:23:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652117038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=V1LS1QEiQOXk1nD6e3KIIjZzOsEIXZHmrzx+BN61lQA=;
        b=SziSu/EtPEM5gpBQSwowNcxKDpdeyMTKKBMlEZSkxGwEUEjpbd6FS4Ew4OlpuuprwWpq02
        lRb7j+63DqIDqAaGIdxDrx2N5L0W2ODNvwEH0YNqFQsm4ZD01iZOO0OQjFGBfoRNBSC3en
        lCgfmD4XZOyke3R6Fi/l/0FfY+2d4Mo=
Date:   Mon, 9 May 2022 19:24:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-tip-commits@vger.kernel.org,
        Vasant Hegde <vasant.hegde@amd.com>,
        Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [tip: perf/core] kvm: x86/cpuid: Fix CPUID leaf 0xA
Message-ID: <YnlOMDv5lMw2kGVb@zn.tnic>
References: <165126412838.4207.9648561218200979307.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <165126412838.4207.9648561218200979307.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 08:28:48PM -0000, tip-bot2 for Sandipan Das wrote:
> The following commit has been merged into the perf/core branch of tip:
> 
> Commit-ID:     fafd15ab6dc1fdfff66908e6d9231b124e1875cf
> Gitweb:        https://git.kernel.org/tip/fafd15ab6dc1fdfff66908e6d9231b124e1875cf
> Author:        Sandipan Das <sandipan.das@amd.com>
> AuthorDate:    Thu, 21 Apr 2022 11:16:59 +05:30
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Fri, 29 Apr 2022 11:06:27 +02:00
> 
> kvm: x86/cpuid: Fix CPUID leaf 0xA
> 
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
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/54bc7fe4cadf6bdef823bab1fba43d4891d2e1a9.1650515382.git.sandipan.das@amd.com
> ---
>  arch/x86/kvm/cpuid.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index b24ca7f..ae1d963 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -887,6 +887,12 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  		union cpuid10_eax eax;
>  		union cpuid10_edx edx;
>  
> +		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
> +		    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
> +			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
> +			break;
> +		}
> +

This is all fine and dandy but this patch in tip conflicts with the very
similar patch of yours:

  5a1bde46f98b ("kvm: x86/cpuid: Only provide CPUID leaf 0xA if host has architectural PMU")

which is already upstream.

So which is it? Should we zap this version in tip instead?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
