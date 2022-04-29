Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CCB514379
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 09:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355269AbiD2H5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 03:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355255AbiD2H5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 03:57:22 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42868B1897
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 00:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651218845; x=1682754845;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sZOMqFBA+sb3zh0RoDJhE1INTls5iHdZxwMbS5aX+wk=;
  b=mKFqM85G5rXS6U2dWlj7hsCI7U/uoFYCxcrJsK8hbpQ8xzZYGQnpHe97
   wo07Q26xJ6GCQYbcJ7v/AwNoXklGwlKk4vsNItvclT3D99M6wIdSCEvzt
   tIsFqUw2Bq5yXSIBRpohL4IDYBqm3/9oebam6yzwSs/W7P4E9GovRkuN2
   jOGE1NdIxZeGZK78ohjIjY/joPArb24zIKAOPJydhips6167I6TzI549l
   SytK6RevJogCjIm1nbNM1pv6Ps+208j+Ef/ApTNz+DmFbx3Nf1HGYNiBA
   BXwcxHujSQ+LECC/ETxmyaRnmWVT7p3bURgoMbL9GuEtOxmvYQeGSfx6g
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="291736611"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="291736611"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 00:54:04 -0700
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="581971987"
Received: from lye4-mobl.ccr.corp.intel.com (HELO [10.249.170.95]) ([10.249.170.95])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 00:53:59 -0700
Message-ID: <044595e6-e5d0-26c2-af8e-fc9d06906179@linux.intel.com>
Date:   Fri, 29 Apr 2022 15:53:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
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
References: <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica> <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica> <22b659c7-e972-7a56-2bd7-8df3b4820d4e@intel.com>
 <YmbO/l5IwfBCHrl8@myrica> <8c044e49-74bb-df56-8a60-663013c0910e@intel.com>
 <YmgiQZZyFxsJ+9um@myrica> <63582490-a794-fd11-0380-44b27cc660b7@intel.com>
 <YmpSv48aPIbVXqGi@myrica>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YmpSv48aPIbVXqGi@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/28 16:39, Jean-Philippe Brucker wrote:
> On Tue, Apr 26, 2022 at 04:31:57PM -0700, Dave Hansen wrote:
>> On 4/26/22 09:48, Jean-Philippe Brucker wrote:
>>> On Tue, Apr 26, 2022 at 08:27:00AM -0700, Dave Hansen wrote:
>>>> On 4/25/22 09:40, Jean-Philippe Brucker wrote:
>>>>> The problem is that we'd have to request the device driver to stop DMA
>>>>> before we can destroy the context and free the PASID. We did consider
>>>>> doing this in the release() MMU notifier, but there were concerns about
>>>>> blocking mmput() for too long (for example
>>>>> https://lore.kernel.org/linux-iommu/4d68da96-0ad5-b412-5987-2f7a6aa796c3@amd.com/
>>>>> though I think there was a more recent discussion). We also need to drain
>>>>> the PRI and fault queues to get rid of all references to that PASID.
>>>> Is the concern truly about blocking mmput() itself?  Or, is it about
>>>> releasing the resources associated with the mm?
>>> The latter I think, this one was about releasing pages as fast as possible
>>> if the process is picked by the OOM killer.
>>
>> We're tying the PASID to the life of the mm itself, not the mm's address
>> space.  That means the PASID should be tied to
>> mmgrab()/mmdrop()/mm->mm_count.
>>
>> The address space is what the OOM killer is after.  That gets refcounted
>> with mmget()/mmput()/mm->mm_users.  The OOM killer is satiated by the
>> page freeing done in __mmput()->exit_mmap().
>>
>> Also, all the VMAs should be gone after exit_mmap().  So, even if
>> vma->vm_file was holding a reference to a device driver, that reference
>> should be gone by the time __mmdrop() is actually freeing the PASID.
> 
> I agree with all that. The concern was about tearing down the PASID in the
> IOMMU and device from the release() MMU notifier, which would happen in
> exit_mmap(). But doing the teardown at or before __mmdrop() is fine. And
> since the IOMMU drivers need to hold mm->mm_count anyway between bind()
> and unbind(), I think Fenghua's fix works.

But I didn't find mmgrab()/mmdrop() get called in both arm and intel
IOMMU drivers.

$ git grep mmgrab drivers/iommu/
[no output]

Do we need to add these in a separated fix patch, or I missed anything
here?

Best regards,
baolu
