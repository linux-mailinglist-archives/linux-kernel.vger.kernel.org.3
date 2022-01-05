Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C77C48590A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 20:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243451AbiAETTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 14:19:15 -0500
Received: from mga17.intel.com ([192.55.52.151]:31169 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243460AbiAETTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 14:19:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641410345; x=1672946345;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8DgziH0WFP49C0kGqzf2uBEI/O4bSOCsl5hhKmIa6O0=;
  b=mzFf7s+9g4PpgCAE7WeJro6WdfIpJ5ChyxRjdf4MbfC4OcNcgFPWj3PH
   GNmDk7q7DWooSENDGoTwNF1tEEJqJoPhdp4hcFxOpjaSRjyo/wa9t/bON
   JuqN1Xq1XvqBLkQlY5QI+wqSDF/wMfST9Bt4u+1aHkajf6mGkQXnoMWNL
   4YsU8LmEJnOwbtNIpd9V7W30dIIn0O6aVS318Q3kDsG/nA6M+5klxrZ8i
   n5ELQDlUObJfgv7NIEcsAufMweWSjsHOyhd3xz6Q8Sh3y2LCI1/OMUOsY
   ll+oNiOEe4vB8m3K+uTnSWwWjv4FuinXJWP0AHD5cPP7doGjZkIH4LXL6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="223202982"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="223202982"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 11:19:05 -0800
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="621236959"
Received: from schen9-mobl.amr.corp.intel.com ([10.212.137.150])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 11:19:04 -0800
Message-ID: <2ddaf5e732c48f74a3758484869c81195adbc47a.camel@linux.intel.com>
Subject: Re: [PATCH RESEND 1/1] x86/smpboot: check cpu_initialized_mask
 first after returning from schedule()
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        rafael.j.wysocki@intel.com, vkuznets@redhat.com,
        alison.schofield@intel.com, boris.ostrovsky@oracle.com,
        joe.jin@oracle.com, longpeng2@huawei.com, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org
Date:   Wed, 05 Jan 2022 11:19:04 -0800
In-Reply-To: <20211223210343.1116-1-dongli.zhang@oracle.com>
References: <20211223210343.1116-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-12-23 at 13:03 -0800, Dongli Zhang wrote:
> To online a new CPU, the master CPU signals the secondary and waits
> for at
> most 10 seconds until cpu_initialized_mask is set by the secondary
> CPU.
> There is a case that the master CPU fails the online when it takes
> 10+
> seconds for schedule() to return (although the cpu_initialized_mask
> is
> already set by the secondary CPU).
> 
> 1. The master CPU signals the secondary CPU in do_boot_cpu().
> 
> 2. As the cpu_initialized_mask is still not set, the master CPU
> reschedules
> via schedule().
> 
> 3. Suppose it takes 10+ seconds until schedule() returns due to
> performance
> issue. The secondary CPU sets the cpu_initialized_mask during those
> 10+
> seconds.

The patch seems reasonable. But do you know what other task got run
and caused such long delay (>10 sec), preventing switch
back to in the master CPU?  It seems like there could be some problem
causing the long delay. It is better if we understand the root cause
of that.

Tim

> 
> 4. Once the schedule() at the master CPU returns, although the
> cpu_initialized_mask is set, the time_before(jiffies, timeout) fails.
> As a
> result, the master CPU regards this as failure.
> 
> [   51.983296] smpboot: do_boot_cpu failed(-1) to wakeup CPU#4
> 
> 5. Since the secondary CPU is stuck at state CPU_UP_PREPARE, any
> further
> online operation will fail by cpu_check_up_prepare(), unless the
> below
> patch set is applied.
> 
> https://lore.kernel.org/all/20211206152034.2150770-1-bigeasy@linutronix.de/
> 
> This issue is resolved by always first checking whether the secondary
> CPU
> has set cpu_initialized_mask.
> 
> Cc: Longpeng(Mike) <longpeng2@huawei.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Joe Jin <joe.jin@oracle.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
> To resend by Cc linux-kernel@vger.kernel.org as well.
> 
>  arch/x86/kernel/smpboot.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 617012f4619f..faad4fcf67eb 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1145,7 +1145,7 @@ static int do_boot_cpu(int apicid, int cpu,
> struct task_struct *idle,
>  		 */
>  		boot_error = -1;
>  		timeout = jiffies + 10*HZ;
> -		while (time_before(jiffies, timeout)) {
> +		while (true) {
>  			if (cpumask_test_cpu(cpu,
> cpu_initialized_mask)) {
>  				/*
>  				 * Tell AP to proceed with
> initialization
> @@ -1154,6 +1154,10 @@ static int do_boot_cpu(int apicid, int cpu,
> struct task_struct *idle,
>  				boot_error = 0;
>  				break;
>  			}
> +
> +			if (time_after_eq(jiffies, timeout))
> +				break;
> +
>  			schedule();
>  		}
>  	}

