Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4947E513856
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349159AbiD1Pb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346122AbiD1Pb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:31:26 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C4FAFAC4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651159691; x=1682695691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4JLBXpO7OFugdq0TzzwsqFbdF4JGMEv8lqRHVUp7dVA=;
  b=cX9SO6472Fho/2KsZZjmWaUc70zb4Egx2rxbVrjKogXRjyy8wHX5rr42
   AKT5/i/czr0rbm4yroUF7dbl7PeEMkF2hJRmt4BKbxAGXsTqbDf+24rMt
   sKBpMLSx6hrMsn/1UWBWfYIPr0hVuCrzcD6qOICTkLP17me4dAH2sgwg9
   9PLar2dcPBaL6bloX4U7RH0HRmesDMDxAj3jDJbmTZPRO+piXkRVnISLj
   1X6jWLBQ+vG9ViMwNvotkfvdkKclwQrM4cyI2lk3rIYYwsyt3zLF4+Bdi
   Ts4VYeG4Jcjw492KxfzRsXc/mQYbfhA1ULWoMLS+86D3OzmoeXY5hrAOH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="263911791"
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="263911791"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 08:28:11 -0700
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="651263724"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 08:28:10 -0700
Date:   Thu, 28 Apr 2022 08:28:41 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
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
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YmqyeBfCuDXAMDlZ@fyu1.sc.intel.com>
References: <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica>
 <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica>
 <20220425083444.00af5674@jacob-builder>
 <YmbIjnHtibY7n4Wb@myrica>
 <YmdzFFx7fN586jcf@fyu1.sc.intel.com>
 <bc18351c-27f2-17ae-e781-6b60fbb72541@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc18351c-27f2-17ae-e781-6b60fbb72541@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dave,

On Thu, Apr 28, 2022 at 08:09:04AM -0700, Dave Hansen wrote:
> On 4/25/22 21:20, Fenghua Yu wrote:
> >>From 84aa68f6174439d863c40cdc2db0e1b89d620dd0 Mon Sep 17 00:00:00 2001
> > From: Fenghua Yu <fenghua.yu@intel.com>
> > Date: Fri, 15 Apr 2022 00:51:33 -0700
> > Subject: [PATCH] iommu/sva: Fix PASID use-after-free issue
> > 
> > A PASID might be still used on ARM after it is freed in __mmput().
> 
> Is it really just ARM?

Actually it should happen on X86 as well. I will remove "on ARM" in the
changelog.

> 
> > process:
> > 	open()->sva_bind()->ioasid_alloc() = N; // Get PASID N for the mm
> > 	exit();
> > 	exit_mm()->__mmput()->mm_pasid_drop()->mm->pasid = -1; // PASID -1
> > 	exit_files()->release(dev)->sva_unbind()->use mm->pasid; // Failure
> > 
> > To avoid the use-after-free issue, free the PASID after no device uses it,
> > i.e. after all devices are unbound from the mm.
> > 
> > sva_bind()/sva_unbind() call mmgrab()/mmdrop() to track mm->mm_count.
> > __mmdrop() is called only after mm->mm_count is zero. So freeing the PASID
> > in __mmdrop() guarantees the PASID is safely freed only after no device
> > is bound to the mm.
> 
> Does this changelog work for everyone?
> 
> ==
> 
> tl;dr: The PASID is being freed too early.  It needs to stay around
> until after device drivers that might be using it have had a chance to
> clear it out of the hardware.
> 

Do you want me to change the changlog to add both this paragraph and the
following paragraph?

> --
> 
> As a reminder:
> 
> mmget() /mmput()  refcount the mm's address space
> mmgrab()/mmdrop() refcount the mm itself
> 
> The PASID is currently tied to the life of the mm's address space and
> freed in __mmput().  This makes logical sense because the PASID can't be
> used once the address space is gone.
> 
> But, this misses an important point: even after the address space is
> gone, the PASID will still be programmed into a device.  Device drivers
> might, for instance, still need to flush operations that are outstanding
> and need to use that PASID.  They do this at ->release() time.
> 
> Device drivers hold a reference on the mm itself and drop it at
> ->release() time.  But, the device driver holds a reference mm itself,
> not the address space.  The address space (and the PASID) is long gone
> by the time the driver tries to clean up.  This is effectively a
> use-after-free bug on the PASID.
> 
> To fix this, move the PASID free operation from __mmput() to __mmdrop().
>  This ensures that the device drivers' existing mmgrab() keeps the PASID
> allocated until they drop their mm reference.
> 

Thank you very much!

-Fenghua
