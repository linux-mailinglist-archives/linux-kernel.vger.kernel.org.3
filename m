Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995964AA519
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 01:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378799AbiBEAdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 19:33:19 -0500
Received: from mga03.intel.com ([134.134.136.65]:14907 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238078AbiBEAdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 19:33:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644021198; x=1675557198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aJYy2vf0HRnoLnCXkWAcUv8uWypmISO27TeIxy+WR4A=;
  b=O17IQto5nuUcBPq6QoyohHFQ6WAfXi7yKr1P9ptA3eAxz99+DffuMS8O
   TPQHUlvQWWknkfGSGGbAivrbldfBrLreMoymlRhhl+gAXc1doqZMAgEWd
   b8vcPGddJd50hRpXwOBYqxUU08tdvYIUL2utSB/OVC5JOvc1/o3jqF4Ou
   VVNY83srmyOqiAkHONvvb9qdcQRg+G3I4BTovoItk0xjK6xU4zbq4fFZ8
   js1aDAAksXtJb5ZX5kAAJWJC6rZIFXu2u2QlVCy9zOvVvWFSDShHMDN7h
   VfV9M4K66zcM2jXdBAqlcn5dnumxiWkUtMwOcI7LqENUoSC75DFowhE+e
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="248416524"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="248416524"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 16:33:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="535684857"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 16:33:17 -0800
Date:   Fri, 4 Feb 2022 16:33:16 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <Yf3FzOUSRpFUdM/q@otcwcpicx3.sc.intel.com>
References: <20220128202905.2274672-1-fenghua.yu@intel.com>
 <20220128202905.2274672-6-fenghua.yu@intel.com>
 <87r18ib2zz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r18ib2zz.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2022 at 12:56:00AM +0100, Thomas Gleixner wrote:
> On Fri, Jan 28 2022 at 12:28, Fenghua Yu wrote:
> > To avoid complexity of updating each thread's PASID status (e.g. sending
> > IPI to update IA32_PASID MSR) on allocating and freeing PASID, once
> > allocated and assigned to an mm, the PASID stays with the mm for the
> > rest of the mm's lifetime. A reference to the PASID is taken on
> > allocating the PASID. Binding/unbinding the PASID won't change refcount.
> > The reference is dropped on mm exit and thus the PASID is freed.
> >
> > Two helpers mm_pasid_set() and mm_pasid_drop() are defined in mm because
> > the PASID operations handle the pasid member in mm_struct and should be
> > part of mm operations. Because IOASID's reference count is not used any
> > more and removed, unused ioasid_get() and iommu_sva_free_pasid()
> > are deleted and ioasid_put() is renamed to ioasid_free().
> >
> > 20-bit PASID allows up to 1M processes bound to PASIDs at the same time.
> > With cgroups and other controls that might limit the number of process
> > creation, the limited number of PASIDs is not a realistic issue for
> > lazy PASID free.
> 
> Please take a step back and think hard about it whether that changelog
> makes sense to you a year from now.
> 
> Let me walk you through:
> 
> > To avoid complexity of updating each thread's PASID status (e.g. sending
> > IPI to update IA32_PASID MSR) on allocating and freeing PASID, once
> > allocated and assigned to an mm, the PASID stays with the mm for the
> > rest of the mm's lifetime.
> 
> You are missing the oportunity to tell a story about the history of this
> decision here:
> 
>   PASIDs are process wide. It was attempted to use refcounted PASIDs to
>   free them when the last thread drops the refcount. This turned out to
>   be complex and error prone. Given the fact that the PASID space is 20
>   bits, which allows up to 1M processes to have a PASID associated
>   concurrently, PASID resource exhaustion is not a realistic concern.
> 
>   Therefore it was decided to simplify the approach and stick with lazy
>   on demand PASID allocation, but drop the eager free approach and make
>   a allocated PASID lifetime bound to the life time of the process.
> 
> > A reference to the PASID is taken on allocating the
> > PASID. Binding/unbinding the PASID won't change refcount.  The
> > reference is dropped on mm exit and thus the PASID is freed.
> 
> There is no refcount in play anymore, right? So how does this part of
> the changelog make any sense?
> 
> This is followed by:
> 
> > Two helpers mm_pasid_set() and mm_pasid_drop() are defined in mm because
> > the PASID operations handle the pasid member in mm_struct and should be
> > part of mm operations. Because IOASID's reference count is not used any
> > more and removed, unused ioasid_get() and iommu_sva_free_pasid()
> > are deleted and ioasid_put() is renamed to ioasid_free().
> 
> which does not provide much rationale and just blurbs about _what_ the
> patch is doing and not about the why and the connection to the
> above. And the refcount removal section contradicts the stale text
> above.
> 
> So this paragraph should be something like this:
> 
>   Get rid of the refcounting mechanisms and replace/rename the
>   interfaces to reflect this new approach.
> 
> Hmm?

Sure. I will update the commit message with your comments.

Thanks.

-Fenghua
