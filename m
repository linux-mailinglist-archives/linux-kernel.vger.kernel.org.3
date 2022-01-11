Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CD448B0C9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343551AbiAKP0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:26:37 -0500
Received: from mga07.intel.com ([134.134.136.100]:53936 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240435AbiAKP0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641914795; x=1673450795;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jOLbgfZSuQO/JXbSatBk3doMgFNqseXIhCh73KqcL5U=;
  b=jrNNZq1mFWsboJLeTAKQflwFYxwwczGoXnwQYFELFHfYHqqifJwuJG/G
   2eJcx/1rr1cXtanZLwT9fNIcIrpVYrag61DI5MEHLVJk5xI5pYOBzROrt
   HeCsD3oeb66zXI8HhDvi4q7XpThXZgGyHLMmrVLlj02Y80zoPMaax+ucU
   29EoKknwNygXt4I5zoG6JDiQpBiU2vPb4VUsjm8WqK67qF2jAefeW0CRb
   hzLusSD10r6FJxurSR8zgXElI7vblgTVQDz5YhOthK6C5uoINEKJeUZII
   FcLQ+Tpo/zxmvsvcfq4/bDsjagGPmi2NCkOOOex66qemsiutZccmq/NpG
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="306861019"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="306861019"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 07:26:35 -0800
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="613249401"
Received: from padhika1-mobl.amr.corp.intel.com (HELO [10.209.13.65]) ([10.209.13.65])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 07:26:34 -0800
Message-ID: <cd46f836-7d81-2178-c5ab-64db0be17e0e@intel.com>
Date:   Tue, 11 Jan 2022 07:26:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: kmemleak detects leak in msr_build_context
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <94e48fcd-1dbd-ebd2-4c91-f39941735909@molgen.mpg.de>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <94e48fcd-1dbd-ebd2-4c91-f39941735909@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/22 23:49, Paul Menzel wrote:
> Running Linux from commit bf4eebf8cfa2 (Merge tag 
> 'linux-kselftest-kunit-5.17-rc1' of 
> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest), 
> kmemleak reported the leak below:
> 
> ```
> unreferenced object 0xffff8914823de500 (size 64):
>    comm "swapper/0", pid 1, jiffies 4294667581 (age 1253.406s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 04 10 01 c0 00 00 00 00  ................
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<000000007f3b05e9>] __kmalloc+0x177/0x330
>      [<0000000008104cca>] msr_build_context.constprop.0+0x32/0xbe
>      [<00000000012bab4e>] msr_save_cpuid_features+0x28/0x2f
>      [<00000000b7a2262e>] pm_check_save_msr+0x2e/0x40
>      [<00000000cbe9d92d>] do_one_initcall+0x44/0x200
>      [<0000000094deab7b>] kernel_init_freeable+0x1fc/0x273
>      [<00000000d3dbaa56>] kernel_init+0x16/0x160
>      [<0000000058c4a8b3>] ret_from_fork+0x22/0x30

Thanks for the report.

I've taken a look through arch/x86/power/cpu.c, and nothing obvious 
jumped out at me.  msr_build_context() could probably be cleaned up by 
using kvrealloc(), but it hasn't been touched recently in a way that I 
would expect things to leak.

I suspect this is a false positive from kmemleak.

If you could share your full dmesg, it might help spot something.  But, 
I didn't see anything.
