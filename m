Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8AB510CA6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 01:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356095AbiDZXcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 19:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240844AbiDZXcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 19:32:16 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB75BC88
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 16:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651015746; x=1682551746;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J8JmQdIC2PvJ9tfgakqcAYqNpk0tOSg7F3URbm6mlRk=;
  b=lUfBO0gTdyjS7LgZe7/sG8gv0amoDEm8+fUuwkw5A+J6Al5B/n1L2L9g
   y2b+tE5sHeZBrRcZkhbFasmA86KX35n5Fzp+Xq/K2r80x93pzOApVvlVH
   TMdqDGI8GbUBxluPQEByaxZEr6tb1CpaxzHYl0Ng++yWfVB3wjZPeKaCF
   md5GCSSWwqcKU3ChNQMEe67r0aSjrEzUuo2IIsLu1D4QCm7vCD1pAopgi
   3EmbWlgMkbOXmFQ0oLa6zoZwoKPOr0MsRYorN7B588Rz9adbWtAl4DASP
   1W+AekNuwKKzBQCw2ZnIa3KRwHSrkJVtd8QXyXAqT95mxPbymPES+YT2v
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="263345433"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="263345433"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 16:29:06 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="580226562"
Received: from dsocek-mobl2.amr.corp.intel.com (HELO [10.212.69.119]) ([10.212.69.119])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 16:29:04 -0700
Message-ID: <63582490-a794-fd11-0380-44b27cc660b7@intel.com>
Date:   Tue, 26 Apr 2022 16:31:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
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
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        robin.murphy@arm.com, zhangfei.gao@linaro.org
References: <YmJ/WA6KAQU/xJjA@myrica>
 <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica> <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica> <22b659c7-e972-7a56-2bd7-8df3b4820d4e@intel.com>
 <YmbO/l5IwfBCHrl8@myrica> <8c044e49-74bb-df56-8a60-663013c0910e@intel.com>
 <YmgiQZZyFxsJ+9um@myrica>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <YmgiQZZyFxsJ+9um@myrica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/22 09:48, Jean-Philippe Brucker wrote:
> On Tue, Apr 26, 2022 at 08:27:00AM -0700, Dave Hansen wrote:
>> On 4/25/22 09:40, Jean-Philippe Brucker wrote:
>>> The problem is that we'd have to request the device driver to stop DMA
>>> before we can destroy the context and free the PASID. We did consider
>>> doing this in the release() MMU notifier, but there were concerns about
>>> blocking mmput() for too long (for example
>>> https://lore.kernel.org/linux-iommu/4d68da96-0ad5-b412-5987-2f7a6aa796c3@amd.com/
>>> though I think there was a more recent discussion). We also need to drain
>>> the PRI and fault queues to get rid of all references to that PASID.
>> Is the concern truly about blocking mmput() itself?  Or, is it about
>> releasing the resources associated with the mm?
> The latter I think, this one was about releasing pages as fast as possible
> if the process is picked by the OOM killer. 

We're tying the PASID to the life of the mm itself, not the mm's address
space.  That means the PASID should be tied to
mmgrab()/mmdrop()/mm->mm_count.

The address space is what the OOM killer is after.  That gets refcounted
with mmget()/mmput()/mm->mm_users.  The OOM killer is satiated by the
page freeing done in __mmput()->exit_mmap().

Also, all the VMAs should be gone after exit_mmap().  So, even if
vma->vm_file was holding a reference to a device driver, that reference
should be gone by the time __mmdrop() is actually freeing the PASID.
