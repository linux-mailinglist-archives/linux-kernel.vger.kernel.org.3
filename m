Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF554FE4D7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357120AbiDLPiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357114AbiDLPiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:38:12 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778E1554A1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649777752; x=1681313752;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=lj9QUXdM5GCMuPvK+BqdMIEkmXMFoN2VtIV9O9lZiCQ=;
  b=iniVuKkxRvTnQUOsODUFsiEQ0X3IH9yvSxQHt5ppDlaIXHBLxV12D4f0
   lh3tPHiu740cetLhrI3kunqcdbycN0MPWA2aeReTWcZYJKBAhcQmO/ATe
   uv+ME/Np6e12UpnxeZRD4e8JrEZ04HOTDlA6rxgFyUayiBp/PX2ngpbQk
   gvDB2fgYah3/HBcHOcl1+nfJb8dLcFm7n9GHmmGp3UVJaAbFYYSL0inBF
   46t3lKTDMaEh0AygoBi8esHs92ZLMfLKZ+LjyJzC1odCEn5t7lvgvv4FO
   m6CE7olpBIQq0Yg0IP3X11YnBj8XbYGx6MFzswio/1C4OqolbKpOxgP19
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="322847209"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="322847209"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 08:35:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="551758622"
Received: from vtelkarx-mobl.amr.corp.intel.com (HELO [10.209.191.73]) ([10.209.191.73])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 08:35:50 -0700
Message-ID: <8b1e40c9-b2e8-7b73-d9ad-2c6a5a167370@intel.com>
Date:   Tue, 12 Apr 2022 08:35:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
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
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
In-Reply-To: <YlWWavIDMNpbD3Ye@larix>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/22 08:10, Jean-Philippe Brucker wrote:
>> I wonder if the Intel and ARM IOMMU code differ in the way they keep
>> references to the mm, or if this affects Intel as well, but we just
>> haven't tested the code enough.
> The Arm code was written expecting the PASID to be freed on unbind(), not
> mm exit. I missed the change of behavior, sorry (I thought your plan was
> to extend PASID lifetime, not shorten it?) but as is it seems very broken.
> For example in the iommu_sva_unbind_device(), we have
> arm_smmu_mmu_notifier_put() clearing the PASID table entry for
> "mm->pasid", which is going to end badly if the PASID has been cleared or
> reallocated. We can't clear the PASID entry in mm exit because at that
> point the device may still be issuing DMA for that PASID and we need to
> quiesce the entry rather than deactivate it.

I think we ended up flipping some of this around on the Intel side.
Instead of having to quiesce the device on mm exit, we don't let the mm
exit until the device is done.

When you program the pasid into the device, it's a lot like when you
create a thread.  We bump the reference count on the mm when we program
the page table pointer into a CPU.  We drop the thread's reference to
the mm when the thread exits and will no longer be using the page tables.

Same thing with pasids.  We bump the refcount on the mm when the pasid
is programmed into the device.  Once the device is done with the mm, we
drop the mm.

Basically, instead of recounting the pasid itself, we just refcount the mm.
