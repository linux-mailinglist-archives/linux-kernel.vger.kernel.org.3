Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC54146F7B6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 00:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbhLIX6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 18:58:04 -0500
Received: from mga12.intel.com ([192.55.52.136]:30467 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234640AbhLIX6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 18:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639094070; x=1670630070;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=+MW3HkDaIUBsZSaEtafCmC2qKsJHc0+FFJudrN28aQQ=;
  b=Oo1v3vFAyvY75AR8Nebjflqs9856wwf44n6yhVrn4ca8QG6u7jNsROJc
   o5nlbKTKvxOPu4WQ/znLRlnB7j30s1ss98tXTtWCS9lSl5VnDaME3CRxV
   1W2vjhd7m4nOBLDgUJjzvjLt7k4YTzkKdYIk0mHKhht8DUdi9A2NQA1pp
   mXP3HRxsY3w6gdYN7EDENStqXW4QRf40SX8jJltkZccbU3h48ptM0qvMP
   pVXDM4kwC0/IRhxRlcewC0CTKYcWNcXr3qNf+EyTx9KE761tOzjLsxRXn
   UeZpI+40D1521ZX9l29mMhqWO9qDdox4duEUan/CD1Vr9kLKbdhaRptHo
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="218254649"
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="218254649"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 15:54:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="601887499"
Received: from pmbutler-mobl.amr.corp.intel.com (HELO [10.212.131.7]) ([10.212.131.7])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 15:54:13 -0800
Subject: Re: [PATCH] signal: Skip the altstack update when not needed
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, dave.hansen@linux.intel.com,
        ebiederm@xmission.com, oleg@redhat.com, bp@alien8.de,
        x86@kernel.org
References: <20211209232434.3585-1-chang.seok.bae@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <64bb0617-bbba-f54d-bbf7-cdd77fa530b6@intel.com>
Date:   Thu, 9 Dec 2021 15:54:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211209232434.3585-1-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/21 3:24 PM, Chang S. Bae wrote:
> New x86 FPU features require a large signal stack for their large states.
> Instead of requiring a large stack for every process, make sure enough
> altstack both at sys_sigaltstack() and when enabling the feature in each
> process.

This is jumping into the imperative voice when describing the
background.  It's rather jarring

> The optional size check was added. It helps to reject a too-small altstack
> when the large feature is enabled. Also, the architecture code examines
> each thread's altstack large enough before enabling the feature.
> 
> But threads can be racy without a lock. So, this enforcement mechanism
> accompanies a lock to serialize altstack updates and the size check.
> 
> On the signal return path, the altstack is restored via do_sigaltstack().
> In fact, the threads without altstack ensure it is disabled there. While no
> altstack change is needed in this case, this call ends up obtaining the
> lock.
> 
> When multiple signal returns hit the lock at the same time, this
> unnecessarily increases the lock contention.
> 
> Add a new check to avoid this. Check if an altstack update is needed. If
> not, skip the lock and the update. This may help sys_sigaltstack() in
> general. So place it in the function.

How about:

== Background ==

Support for large, "dynamic" fpstates was recently merged.  This
included code to ensure that sigaltstacks are sufficiently sized for
these large states.  A new lock was added to remove races between
enabling large features and setting up sigaltstacks.

== Problem ==

The new lock (sigaltstack_lock()) is acquired in the sigreturn path
before restoring the old sigaltstack.  Unfortunately, contention on the
new lock causes a measurable signal handling performance regression[link
here].  However, the common case is that no *changes* are made to the
sigaltstack state at sigreturn.

== Solution ==

do_sigaltstack() acquires sigaltstack_lock() and is used for both
sys_sigaltstack() and restoring the sigaltstack in sys_sigreturn().
Check for changes to the sigaltstack before taking the lock.  If no
changes were made, return before acquiring the lock.

This removes lock contention from the common-case sigreturn path.


> diff --git a/kernel/signal.c b/kernel/signal.c
> index a629b11bf3e0..eeb634f954cd 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -4185,6 +4185,11 @@ do_sigaltstack (const stack_t *ss, stack_t *oss, unsigned long sp,
>  				ss_mode != 0))
>  			return -EINVAL;
>  
> +		if (t->sas_ss_sp == (unsigned long)ss_sp &&
> +		    t->sas_ss_size == ss_size &&
> +		    t->sas_ss_flags == ss_flags)
> +			return 0;

This needs something like:

		/*
		 * Return before taking any locks if no actual
		 * sigaltstack changes were requested.
		 */

>  		sigaltstack_lock();
>  		if (ss_mode == SS_DISABLE) {
>  			ss_size = 0;
> 

