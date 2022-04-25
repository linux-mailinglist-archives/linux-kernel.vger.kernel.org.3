Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1962E50E472
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbiDYPeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbiDYPeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:34:15 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BAF21E10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650900671; x=1682436671;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QmBvHFEL8jCRZp/04JCJNkoj3kFPY6FDP8vzsw7y6UI=;
  b=nEFkiNRGu6R/J+fU6DJzljwldao92uHfDZvnSuUkUcAsGFt5o+IE6upm
   bsXjlqRUMEe0SxyXKgH31TG/kCffDxRUBUP3OWRl5EBvcBpUaxrUnnrdf
   x6vz5BRfZdqWGLgomlrF0LXUMLU8fZjd+I1fv8+536f1/HOg2Fu+IiMJN
   tDuc++1cBxN+V7kNOg16DNl3mIvZjVYJATHq3Mbqv+W/5Pql2xx6E6zwV
   WaxYd7Hga2vCXpjw/frhl2AvN3iDR6IEXOw6dI/O3ti6fitR1kYaVx2t6
   jO5J7tujm7qGr6Gmpr4MDhMIqOeg6fk+wz6avjmS7FRJ/tZmT9Os/FU/t
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="247208240"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="247208240"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 08:31:07 -0700
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="579340231"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 08:31:06 -0700
Date:   Mon, 25 Apr 2022 08:34:44 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
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
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <20220425083444.00af5674@jacob-builder>
In-Reply-To: <YmavoKkVu+hd+x0M@myrica>
References: <YllADL6uMoLllzQo@fyu1.sc.intel.com>
        <YmA4pbgevqln/jSO@myrica>
        <tencent_76E043C4D1B6A21A5253579A61034107EB06@qq.com>
        <tencent_7477100F8A445C6CAFA8F13601A55134480A@qq.com>
        <YmJ/WA6KAQU/xJjA@myrica>
        <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
        <YmLOznyBF0f7COYT@myrica>
        <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
        <Yman5hLomw9/c+bi@myrica>
        <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
        <YmavoKkVu+hd+x0M@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Philippe,

On Mon, 25 Apr 2022 15:26:40 +0100, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:

> On Mon, Apr 25, 2022 at 07:18:36AM -0700, Dave Hansen wrote:
> > On 4/25/22 06:53, Jean-Philippe Brucker wrote:  
> > > On Sat, Apr 23, 2022 at 07:13:39PM +0800, zhangfei.gao@foxmail.com
> > > wrote:  
> > >>>> On 5.17
> > >>>> fops_release is called automatically, as well as
> > >>>> iommu_sva_unbind_device. On 5.18-rc1.
> > >>>> fops_release is not called, have to manually call close(fd)  
> > >>> Right that's weird  
> > >> Looks it is caused by the fix patch, via mmget, which may add
> > >> refcount of fd.  
> > > Yes indirectly I think: when the process mmaps the queue,
> > > mmap_region() takes a reference to the uacce fd. That reference is
> > > released either by explicit close() or munmap(), or by exit_mmap()
> > > (which is triggered by mmput()). Since there is an mm->fd dependency,
> > > we cannot add a fd->mm dependency, so no mmget()/mmput() in
> > > bind()/unbind().
> > > 
> > > I guess we should go back to refcounted PASIDs instead, to avoid
> > > freeing them until unbind().  
> > 
> > Yeah, this is a bit gnarly for -rc4.  Let's just make sure there's
> > nothing else simple we can do.
> > 
> > How does the IOMMU hardware know that all activity to a given PASID is
> > finished?  That activity should, today, be independent of an mm or a
> > fd's lifetime.  
> 
> In the case of uacce, it's tied to the fd lifetime: opening an accelerator
> queue calls iommu_sva_bind_device(), which sets up the PASID context in
> the IOMMU. Closing the queue calls iommu_sva_unbind_device() which
> destroys the PASID context (after the device driver stopped all DMA for
> this PASID).
> 
For VT-d, it is essentially the same flow except managed by the individual
drivers such as DSA.
If free() happens before unbind(), we deactivate the PASIDs and suppress
faults from the device. When the unbind finally comes, we finalize the
PASID teardown. It seems we have a need for an intermediate state where
PASID is "pending free"?

> Thanks,
> Jean
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu


Thanks,

Jacob
