Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B65E4EFA5B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 21:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbiDAT1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 15:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiDAT1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 15:27:14 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F082143469
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 12:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648841124; x=1680377124;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=1qdcczlKX4Qjv3s3lopzGh1+3WgMrjU6pxzvv7DskMU=;
  b=eI01janHOsQDF+Og23x5JZVO6xC5SmAEfhEox0A0SeU+Jvi1inFJMl/W
   JNLFWVy1BewXlbHr/Ae9sx6SXAn5YJP7T1CYT259w0YY+I1BAwCBZA3HW
   Fz2oXvY0wv6+x4bLLDBY3oLfyGTukr6UNLfH1bPTiJvXHjQzgFQLr6bXv
   7JduJQMsRCy7O7SZFNSk26f8Ioukw5xDF4Df6gSox5mot/YAAOXFqEngD
   84oazZslNmBg5U5E1JjXCb6Gu+0T94dsc1osbpuGXmNWHNNyb0nPsxWMV
   3LGVFAUmVHRNSt76w4xgsv1Tw3p6faRmGsC9wFsJYPKt1jzrgJnOKCi/D
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="240151866"
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="240151866"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 12:25:24 -0700
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="567739894"
Received: from dajones-mobl.amr.corp.intel.com (HELO [10.212.134.9]) ([10.212.134.9])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 12:25:22 -0700
Message-ID: <db4e00d5-0cec-d50a-7dae-2ca9808bc187@intel.com>
Date:   Fri, 1 Apr 2022 12:25:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Bharata B Rao <bharata@amd.com>, Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-mm@kvack.org, the arch/x86 maintainers <x86@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, shuah@kernel.org,
        Oleg Nesterov <oleg@redhat.com>, ananth.narayan@amd.com
References: <20220310111545.10852-1-bharata@amd.com>
 <6a5076ad-405e-4e5e-af55-fe2a6b01467d@www.fastmail.com>
 <b0861376-e628-06bd-713e-8837e0dc9d0b@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH v0 0/6] x86/AMD: Userspace address tagging
In-Reply-To: <b0861376-e628-06bd-713e-8837e0dc9d0b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/22 00:48, Bharata B Rao wrote:
> Ok got that. However can you point to me a few instances in the current
> kernel code where such assumption of high bit being user/kernel address
> differentiator exists so that I get some idea of what it takes to
> audit all such cases?

Look around for comparisons against TASK_SIZE_MAX.
arch/x86/lib/putuser.S or something like arch_check_bp_in_kernelspace()
come to mind.

> Also wouldn't the problem of high bit be solved by using only the
> 6 out of 7 available bits in UAI and leaving the 63rd bit alone?
> The hardware will still ignore the top bit, but this should take
> care of the requirement of high bit being 0/1 for user/kernel in the
> x86_64 kernel. Wouldn't that work?

I don't think so.

The kernel knows that a dereference of a pointer that looks like a
kernel address that get kernel data.  Userspace must be kept away from
things that look like kernel addresses.

Let's say some app does:

	void *ptr = (void *)0xffffffffc038d130;
	read(fd, ptr, 1);

and inside the kernel, that boils down to:

	put_user('x', 0xffffffffc038d130);

Today the kernels knows that 0xffffffffc038d130 is >=TASK_SIZE_MAX, so
this is obviously naughty userspace trying to write to the kernel.  But,
it's not obviously wrong if the high bits are ignored.

Like you said, we could, as a convention, check for the highest bit
being set and use *that* to indicate a kernel address.  But, the sneaky
old userspace would just do:

	put_user('x', 0x7fffffffc038d130);

It would pass the "high bit" check since that bit is clear, but it still
accesses kernel memory because UAI ignores the bit userspace just cleared.

I think the only way to get around this is to go find every single place
in the kernel that does a userspace address check and ensure that it
fully untags the pointer first.

...
> However given that without a hardware feature like ARM64 MTE, this would
> primarily be used in non-production environments. Hence I wonder if MSR
> write cost could be tolerated?

It would be great of the mysterious folks who asked both Intel and AMD
for this feature could weigh in on this thread.  But, I've been assuming
that these features will be used to accelerate address sanitizers which
used heavily today in non-production environments but are (generally)
too slow for production.

I'd be very surprised if folks wanted this snazzy new hardware feature
from every CPU vendor on the planet just to speed up their
non-production environments.

I'd be less surprised if they wanted to expand the use of pointer
tagging into more production environments.
