Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AD85137D9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348852AbiD1PMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbiD1PME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:12:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BDB95A22
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651158529; x=1682694529;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WjpidTVz5lUtD/efh8OlqCuRXiLpHTD6QLqjLK1bhbg=;
  b=GcMra62ua/oSD44cZrzWiySFlTAY2+ug0dWgQ7PtTrBqsGdH5NYbEI+C
   +JGNlVnjwFqydg3+Oe1zcA7WXZfLT+iZlPJ12q7P78jZee3/en89cl6ky
   pRsBfj2UALILPDyNWwK0ECwQjc9I0oh3r4OR8nVHNKeszbU5Y7QK7XMrd
   rjU/mTDhuPh88YB+Dlv9WeFEfF3ady/hCMD9AggDHXBV4LIP4tkOkCSqy
   7hgoOTlLRukHXtGC+AppyKEUsQKVBx2srzvd7+VTY0eUZbcX51oRwkvKD
   LSok7n2cHqMwzOsXwjKfNLy/Ao9cXvCeZtJaBWl1o+pu2Nwty8ezDKxyd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="329262567"
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="329262567"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 08:08:49 -0700
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="559713585"
Received: from mpoursae-mobl2.amr.corp.intel.com (HELO [10.212.0.84]) ([10.212.0.84])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 08:08:48 -0700
Message-ID: <bc18351c-27f2-17ae-e781-6b60fbb72541@intel.com>
Date:   Thu, 28 Apr 2022 08:09:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, robin.murphy@arm.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, zhangfei.gao@linaro.org,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org
References: <tencent_7477100F8A445C6CAFA8F13601A55134480A@qq.com>
 <YmJ/WA6KAQU/xJjA@myrica>
 <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica> <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica> <20220425083444.00af5674@jacob-builder>
 <YmbIjnHtibY7n4Wb@myrica> <YmdzFFx7fN586jcf@fyu1.sc.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <YmdzFFx7fN586jcf@fyu1.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/22 21:20, Fenghua Yu wrote:
>>From 84aa68f6174439d863c40cdc2db0e1b89d620dd0 Mon Sep 17 00:00:00 2001
> From: Fenghua Yu <fenghua.yu@intel.com>
> Date: Fri, 15 Apr 2022 00:51:33 -0700
> Subject: [PATCH] iommu/sva: Fix PASID use-after-free issue
> 
> A PASID might be still used on ARM after it is freed in __mmput().

Is it really just ARM?

> process:
> 	open()->sva_bind()->ioasid_alloc() = N; // Get PASID N for the mm
> 	exit();
> 	exit_mm()->__mmput()->mm_pasid_drop()->mm->pasid = -1; // PASID -1
> 	exit_files()->release(dev)->sva_unbind()->use mm->pasid; // Failure
> 
> To avoid the use-after-free issue, free the PASID after no device uses it,
> i.e. after all devices are unbound from the mm.
> 
> sva_bind()/sva_unbind() call mmgrab()/mmdrop() to track mm->mm_count.
> __mmdrop() is called only after mm->mm_count is zero. So freeing the PASID
> in __mmdrop() guarantees the PASID is safely freed only after no device
> is bound to the mm.

Does this changelog work for everyone?

==

tl;dr: The PASID is being freed too early.  It needs to stay around
until after device drivers that might be using it have had a chance to
clear it out of the hardware.

--

As a reminder:

mmget() /mmput()  refcount the mm's address space
mmgrab()/mmdrop() refcount the mm itself

The PASID is currently tied to the life of the mm's address space and
freed in __mmput().  This makes logical sense because the PASID can't be
used once the address space is gone.

But, this misses an important point: even after the address space is
gone, the PASID will still be programmed into a device.  Device drivers
might, for instance, still need to flush operations that are outstanding
and need to use that PASID.  They do this at ->release() time.

Device drivers hold a reference on the mm itself and drop it at
->release() time.  But, the device driver holds a reference mm itself,
not the address space.  The address space (and the PASID) is long gone
by the time the driver tries to clean up.  This is effectively a
use-after-free bug on the PASID.

To fix this, move the PASID free operation from __mmput() to __mmdrop().
 This ensures that the device drivers' existing mmgrab() keeps the PASID
allocated until they drop their mm reference.

>  kernel/fork.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 9796897560ab..35a3beff140b 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -792,6 +792,7 @@ void __mmdrop(struct mm_struct *mm)
>  	mmu_notifier_subscriptions_destroy(mm);
>  	check_mm(mm);
>  	put_user_ns(mm->user_ns);
> +	mm_pasid_drop(mm);
>  	free_mm(mm);
>  }
>  EXPORT_SYMBOL_GPL(__mmdrop);
> @@ -1190,7 +1191,6 @@ static inline void __mmput(struct mm_struct *mm)
>  	}
>  	if (mm->binfmt)
>  		module_put(mm->binfmt->module);
> -	mm_pasid_drop(mm);
>  	mmdrop(mm);
>  }
>  

