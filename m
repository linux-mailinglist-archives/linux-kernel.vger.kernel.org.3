Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27779499831
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 22:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1451275AbiAXVWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 16:22:34 -0500
Received: from mga17.intel.com ([192.55.52.151]:34488 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358374AbiAXUwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643057570; x=1674593570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zk4FsO8id3AQmClLhfi5ct2JYeKgImL1nYfcJmgal4M=;
  b=NVgagemPeVa8SVzPZLhl/OfEFP1BQOkY0g78Jg5gIVe6UtBVOEnut4VD
   nbmhf8INY4eMt2b+IHf1M8rmm29izvDDzdVxAMVYUaoKzlQxDU6J+hH5m
   KhfxUlOlYw1gJHwfMyzjpSe+3s9eT+AAgHg5TFrOnGY102iNG1VcKeGBr
   9scEDhMJfd/LUgN6xaSkHjwWuWVU9u9sR5z7ZSweStY+ZQCYpJYChTiy7
   9X30DGCCrkgqWdEs5HWaRH4n0SpxghRXyynbXC7dy5s3dq93HwJ4T1vVs
   y0d2IJux3e516/kRCv09Phc5u8+wyUj6ZUQV+joLUqbKurZPIINNmNtbj
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="226818763"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="226818763"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 12:52:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="479226615"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 12:52:47 -0800
Date:   Mon, 24 Jan 2022 12:52:42 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <Ye8RmmKpJT8brmDE@otcwcpicx3.sc.intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
 <20211217220136.2762116-6-fenghua.yu@intel.com>
 <87ee4w6g1n.ffs@tglx>
 <87bl006fdb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bl006fdb.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas,

On Mon, Jan 24, 2022 at 09:36:00PM +0100, Thomas Gleixner wrote:
> On Mon, Jan 24 2022 at 21:21, Thomas Gleixner wrote:
> >
> > Hrm. This is odd.
> >
> >> +/* Associate a PASID with an mm_struct: */
> >> +static inline void mm_pasid_get(struct mm_struct *mm, u32 pasid)
> >> +{
> >> +	mm->pasid = pasid;
> >> +}
> >
> > This does not get anything. It sets the allocated PASID in the mm. The
> > refcount on the PASID was already taken by the allocation. So this
> > should be mm_pasid_set() or mm_pasid_install(), right?
> 
> And as a result of all this ioasid_get() is now left without users...
> 
> Thanks,

Ah. This patch should remove ioasid_get(). So I will change this patch
as follows:

1. Remove ioasid_get() because it's not used any more when IOASID's
   refcount is set to 1 once the IOASID is allocated and is freed on mm exit.
2. Change mm_pasid_get() to mm_pasid_set().

Will that work?

Thanks.

-Fenghua
