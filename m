Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C62515B02
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 09:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382291AbiD3Hgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 03:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346476AbiD3Hgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 03:36:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AC1CE139
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 00:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651304004; x=1682840004;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R2jqEuLVanUhC0qbR2y40hAg+OH/oqq58hrMD8YsY64=;
  b=HGhbcXLvAyqVMMbj8+ls2Snpty1lTm1dSdlOb1OGi3cZ+jJDTKPf8RB6
   rga21jw8o9jCodUhkO/atqjEtt1MCb9ixsWddaFPnJgQ1n4alU3KgULLJ
   N8naZ8Wj4K/eV1dMOGhEMhsSO5wvqg1c5ZkiAWKkbt69Ks4bjSlELFSFg
   0fUjqpYOe3h3rqfLnPlCt+X36QS7Y6HPZZ0PKojLPMVAYTmQVWcf9FbXq
   m3DyfVFK8qDyLaMmtpxbeHNdpCybQEnV+OyXl/oQr8LIzgi6crQp1WXG7
   3N3s3PuqpWJgrVjkfDoB9lUjPHxHkS/Pn8YsuQA8N1N48HQcOjEB7rR99
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="266683588"
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="266683588"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 00:33:24 -0700
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="582650317"
Received: from aliu1-mobl.ccr.corp.intel.com (HELO [10.255.30.71]) ([10.255.30.71])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 00:33:19 -0700
Message-ID: <3ea91623-97ea-f318-70db-55f08922d7ce@linux.intel.com>
Date:   Sat, 30 Apr 2022 15:33:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
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
References: <YmavoKkVu+hd+x0M@myrica>
 <22b659c7-e972-7a56-2bd7-8df3b4820d4e@intel.com> <YmbO/l5IwfBCHrl8@myrica>
 <8c044e49-74bb-df56-8a60-663013c0910e@intel.com> <YmgiQZZyFxsJ+9um@myrica>
 <63582490-a794-fd11-0380-44b27cc660b7@intel.com> <YmpSv48aPIbVXqGi@myrica>
 <044595e6-e5d0-26c2-af8e-fc9d06906179@linux.intel.com>
 <YmvtVRlwVJjStXc0@fyu1.sc.intel.com> <Ymv3fC4xXqe+oMRK@myrica>
 <Ymxke+ihgwNy3BCE@fyu1.sc.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Ymxke+ihgwNy3BCE@fyu1.sc.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/30 06:19, Fenghua Yu wrote:
> Hi, Jean and Baolu,
> 
> On Fri, Apr 29, 2022 at 03:34:36PM +0100, Jean-Philippe Brucker wrote:
>> On Fri, Apr 29, 2022 at 06:51:17AM -0700, Fenghua Yu wrote:
>>> Hi, Baolu,
>>>
>>> On Fri, Apr 29, 2022 at 03:53:57PM +0800, Baolu Lu wrote:
>>>> On 2022/4/28 16:39, Jean-Philippe Brucker wrote:
>>>>>> The address space is what the OOM killer is after.  That gets refcounted
>>>>>> with mmget()/mmput()/mm->mm_users.  The OOM killer is satiated by the
>>>>>> page freeing done in __mmput()->exit_mmap().
>>>>>>
>>>>>> Also, all the VMAs should be gone after exit_mmap().  So, even if
>>>>>> vma->vm_file was holding a reference to a device driver, that reference
>>>>>> should be gone by the time __mmdrop() is actually freeing the PASID.
>>>>>
>>>>> I agree with all that. The concern was about tearing down the PASID in the
>>>>> IOMMU and device from the release() MMU notifier, which would happen in
>>>>> exit_mmap(). But doing the teardown at or before __mmdrop() is fine. And
>>>>> since the IOMMU drivers need to hold mm->mm_count anyway between bind()
>>>>> and unbind(), I think Fenghua's fix works.
>>>>
>>>> But I didn't find mmgrab()/mmdrop() get called in both arm and intel
>>>> IOMMU drivers.
>>>>
>>>> $ git grep mmgrab drivers/iommu/
>>>> [no output]
>>>>
>>>> Do we need to add these in a separated fix patch, or I missed anything
>>>> here?
>>>
>>> On both ARM and X86, sva_bind() calls mmu_notifier_register()->mmgrab() and
>>> sva_unbind() calls mmu_notifier_unregister()/mmu_notifier_put()->mmdrop().
>>
>> Yes, although for Arm I realized the mmu_notifier grab wasn't sufficient
>> so I sent a separate fix that should go in 5.18 as well
>> https://lore.kernel.org/linux-iommu/20220426130444.300556-1-jean-philippe@linaro.org/
>> The Arm driver still touches the arch mm context after mmu_notifier_put().
>> I don't think X86 has that problem.
> 
> I think so too. On X86, the mm is not used after mmu_notifier_unregister().
> 
> In case of supervisor mode SVM (i.e. svm is bound to init_mm), the code
> is right too because init_mm and its PASID cannot be dropped and
> mmu_notifier_register()/mmu_notifier_unregister() are not called.
> 
> So I think no extra fix patch is needed on X86.

Thanks, Fenghua and Jean. It's clear to me now.

Jean, another quick question about the iommu_sva_bind_device()

/**
  * iommu_sva_bind_device() - Bind a process address space to a device
  * @dev: the device
  * @mm: the mm to bind, caller must hold a reference to it
  * @drvdata: opaque data pointer to pass to bind callback

This interface requires the caller to take a reference to mm. Which
reference should it take, mm->mm_count or mm->mm_users? It's better to
make it explicit in this comment.

Best regards,
baolu
