Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F378F4FF587
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 13:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiDMLQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 07:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiDMLQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:16:29 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB1948888
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649848448; x=1681384448;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=l2uizx05vRTt4iq6ZJGY0xJd73c67KAOG1q/jwxX0qY=;
  b=Lrinb+/WWlD+rgy/4uXRGDV8F8xhUlbW0UVjuuO7OCH9ewl1CbmeaOT7
   kRWKXbw5h0Phh5SINu0GLhzC1RGOBTztWaf7Bat+RK8EgE3+Ix91tK/YH
   ZFlU91fOu4ljS56q1an9oRfwFRyM7Ckdg3Oqjgi2LURyV17UxOd0rYPg5
   R6ysrx8OYjxIuv7IaSs/iGF7mk5Kk23SfZX2wmR9JNwGQEVoA6VU7bPc3
   j3v+i85yf2msRj3nFnLOWgOh7T8eBgUcQ+2Uy/Wdg6sKA81+yZVHeYEw9
   mN2LucqITk+hC1sUg3E0EkGu/y1rkIjl0FQLxJUJrfZBR+MfNAA7UBRfu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="349075057"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="349075057"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 04:14:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="573224127"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.67]) ([10.254.215.67])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 04:14:03 -0700
Message-ID: <5588a772-3875-7733-aae1-36a036b91c3b@linux.intel.com>
Date:   Wed, 13 Apr 2022 19:14:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     baolu.lu@linux.intel.com, Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220207230254.3342514-6-fenghua.yu@intel.com>
 <Ygt4h0PgYzKOiB38@8bytes.org>
 <tencent_F6830A1196DB4C6A904D7C691F0D961D1108@qq.com>
 <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
 <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <41ed3405-66d9-0cde-fc01-b3eacb85a081@intel.com> <YlWWavIDMNpbD3Ye@larix>
 <8b1e40c9-b2e8-7b73-d9ad-2c6a5a167370@intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
In-Reply-To: <8b1e40c9-b2e8-7b73-d9ad-2c6a5a167370@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 2022/4/12 23:35, Dave Hansen wrote:
> On 4/12/22 08:10, Jean-Philippe Brucker wrote:
>>> I wonder if the Intel and ARM IOMMU code differ in the way they keep
>>> references to the mm, or if this affects Intel as well, but we just
>>> haven't tested the code enough.
>> The Arm code was written expecting the PASID to be freed on unbind(), not
>> mm exit. I missed the change of behavior, sorry (I thought your plan was
>> to extend PASID lifetime, not shorten it?) but as is it seems very broken.
>> For example in the iommu_sva_unbind_device(), we have
>> arm_smmu_mmu_notifier_put() clearing the PASID table entry for
>> "mm->pasid", which is going to end badly if the PASID has been cleared or
>> reallocated. We can't clear the PASID entry in mm exit because at that
>> point the device may still be issuing DMA for that PASID and we need to
>> quiesce the entry rather than deactivate it.
> 
> I think we ended up flipping some of this around on the Intel side.
> Instead of having to quiesce the device on mm exit, we don't let the mm
> exit until the device is done.

The Intel IOMMU code doesn't quiesce the device on mm exit. It only
tears down the PASID entry so that the subsequent device accesses to mm
is dropped silently.

Just like ARM, Intel IOMMU code also expects that PASID should be freed
and reused after device is done (i.e. after iommu_sva_unbind_device())
so that the PASID could be drained in both hardware and software before
reusing it for other purpose.

> 
> When you program the pasid into the device, it's a lot like when you
> create a thread.  We bump the reference count on the mm when we program
> the page table pointer into a CPU.  We drop the thread's reference to
> the mm when the thread exits and will no longer be using the page tables.
> 
> Same thing with pasids.  We bump the refcount on the mm when the pasid
> is programmed into the device.  Once the device is done with the mm, we
> drop the mm.
> 
> Basically, instead of recounting the pasid itself, we just refcount the mm.

Above makes sense to me. It guarantees that the mm->pasid could only be
freed and reused after the device is done.

Best regards,
baolu
