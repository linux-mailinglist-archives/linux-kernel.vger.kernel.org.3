Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75764A04B6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351855AbiA1X55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 18:57:57 -0500
Received: from mga01.intel.com ([192.55.52.88]:58319 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351805AbiA1X54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:57:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643414276; x=1674950276;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=tz7e0tzVR/4hFqtXh/0q9PQknw+tZiR4F+jHhGqqpME=;
  b=CPxfO7o9pFbGauMZgMf8OmNCva5VuD38wja0reAnKyzHmQRLoJqRTsXf
   w7NuK8AwWjNlkO5FB/qrZbA5mnM9KXVVl5xAzTlsCHEx8u2p5lznlYwGO
   HKEV3Gpx8QK//gwcbkytzekHDfJIl9Ze8Pr9CsI+qwHT/Ph4A+UOA4uJC
   0jeiOC7+4fNeGw1EFn8uQHodQsGBSa/6DgIhd3LofeqIn+zRl0JTZXjHL
   x9h/ml+cz3Sk5JtXbhiD/CPvZqVlqp4dcjZaZ50b659qaZ0cNpfLEgutP
   WYVbTaKrWU6qrG4/ZCqfCG7AkrhLqIVh/Z+JYlH6NK4xBGE03CHcjvY7+
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="271681558"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="271681558"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 15:57:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="697256247"
Received: from zhenkuny-mobl2.amr.corp.intel.com (HELO [10.209.84.59]) ([10.209.84.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 15:57:55 -0800
Message-ID: <49195bef-1a3f-447b-3de5-daaefbed8561@intel.com>
Date:   Fri, 28 Jan 2022 15:57:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.2
Content-Language: en-US
To:     ira.weiny@intel.com, Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-11-ira.weiny@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH V8 10/44] Documentation/pkeys: Add initial PKS
 documentation
In-Reply-To: <20220127175505.851391-11-ira.weiny@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 09:54, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Add initial overview and configuration information about PKS.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  Documentation/core-api/protection-keys.rst | 57 ++++++++++++++++++++--
>  1 file changed, 53 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
> index 12331db474aa..58670e3ee39e 100644
> --- a/Documentation/core-api/protection-keys.rst
> +++ b/Documentation/core-api/protection-keys.rst
> @@ -12,6 +12,9 @@ PKeys Userspace (PKU) is a feature which is found on Intel's Skylake "Scalable
>  Processor" Server CPUs and later.  And it will be available in future
>  non-server Intel parts and future AMD processors.
>  
> +Protection Keys for Supervisor pages (PKS) is available in the SDM since May
> +2020.

I'd just remove this.  Folks don't need to know the SDM history.  I'd
only talk about it here if they would have a hard time finding it
somehow.  Seeing as its in the main SDM, I can't see how that's a problem.

>  pkeys work by dedicating 4 previously Reserved bits in each page table entry to
>  a "protection key", giving 16 possible keys.
>  
> @@ -22,13 +25,20 @@ and Write Disable) for each of 16 keys.
>  Being a CPU register, PKRU is inherently thread-local, potentially giving each
>  thread a different set of protections from every other thread.
>  
> -There are two instructions (RDPKRU/WRPKRU) for reading and writing to the
> -register.  The feature is only available in 64-bit mode, even though there is
> +For Userspace (PKU), there are two instructions (RDPKRU/WRPKRU) for reading and
> +writing to the register.
> +
> +For Supervisor (PKS), the register (MSR_IA32_PKRS) is accessible only to the
> +kernel through rdmsr and wrmsr.
> +
> +The feature is only available in 64-bit mode, even though there is
>  theoretically space in the PAE PTEs.  These permissions are enforced on data
>  access only and have no effect on instruction fetches.
>  
> -Syscalls
> -========
> +
> +
> +Syscalls for user space keys
> +============================
>  
>  There are 3 system calls which directly interact with pkeys::
>  
> @@ -95,3 +105,42 @@ with a read()::
>  The kernel will send a SIGSEGV in both cases, but si_code will be set
>  to SEGV_PKERR when violating protection keys versus SEGV_ACCERR when
>  the plain mprotect() permissions are violated.
> +
> +
> +Kernel API for PKS support
> +==========================
> +
> +Overview
> +--------
> +
> +Similar to user space pkeys, supervisor pkeys allow additional protections to
> +be defined for a supervisor mappings.  Unlike user space pkeys, violations of
> +these protections result in a kernel oops.
> +
> +Supervisor Memory Protection Keys (PKS) is a feature which is found on Intel's
> +Sapphire Rapids (and later) "Scalable Processor" Server CPUs.  It will also be
> +available in future non-server Intel parts.

This is a little weird.  You've already talked about PKRS and then later
introduce the feature?

Also, perhaps this CPU model bit should just be next to the CPU model
bit about PKU.

> +Also qemu has support as well: https://www.qemu.org/2021/04/30/qemu-6-0-0/
> +
> +Kconfig
> +-------
> +Kernel users intending to use PKS support should depend on
> +ARCH_HAS_SUPERVISOR_PKEYS, and select ARCH_ENABLE_SUPERVISOR_PKEYS to turn on
> +this support within the core.

Maybe this should talk about the Kconfig options a bit more.  Maybe even
an example:

config MY_NEW_FEATURE
	depends on ARCH_HAS_SUPERVISOR_PKEYS
	select ARCH_ENABLE_SUPERVISOR_PKEYS

This will make "MY_NEW_FEATURE" unavailable unless the architecture sets
ARCH_HAS_SUPERVISOR_PKEYS.  It also makes it possible for multiple
independent features to  "select ARCH_ENABLE_SUPERVISOR_PKEYS".  PKS
support will not be compiled into the kernel unless one or more features
selects ARCH_ENABLE_SUPERVISOR_PKEYS.

> +MSR details
> +-----------
> +
> +It should be noted that the underlying WRMSR(MSR_IA32_PKRS) is not serializing
> +but still maintains ordering properties similar to WRPKRU.

s/It should be noted that the underlying //

I'd probably say:

	WRMSR is typically an architecturally serializing instruction.
	However, WRMSR(MSR_IA32_PKRS) is an exceptions.  It is not a
	serializing instruction and instead maintains ordering
	properties similar to WRPKRU.

and maybe:

	Check the WRPKRU documentation in the latest version of the SDM
	for details.

> +Older versions of the SDM on PKRS may be wrong with regard to this
> +serialization.  The text should be the same as that of WRPKRU.  From the WRPKRU
> +text:
> +
> +	WRPKRU will never execute transiently. Memory accesses
> +	affected by PKRU register will not execute (even transiently)
> +	until all prior executions of WRPKRU have completed execution
> +	and updated the PKRU register.

I wouldn't go over this.  Software has bugs.  Documentation has bugs.  I
expect folks to use the most recent version.

BTW, there are still a few places in SDM 076 that miss mentioning the
non-serializing properties of PKRS.  I also don't see anything
specifically about the speculative behavior.  There might be fixes on
the way, but can you double-check?
