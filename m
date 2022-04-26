Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4B050EFFE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 06:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244156AbiDZEjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 00:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244109AbiDZEjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 00:39:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990EA6B08A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 21:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650947766; x=1682483766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HoSgYXIAQU+NGqckIO+BRiklpNR9Ayr8HUcEmJ0UHcE=;
  b=kiG/hpzgmN0jivIdOA+8rKuPdv/BUGBz4ygC662lxKSW6yJxliBHf3vM
   +sJOgoPJt5j3acAGBPfG4fQCsRk9GZzXZwVV8EiR0Q9Hj8hPGvJBunSz7
   C6qqG9UFDiNnLqw3ArJM8E1zat/w05qyKgRByg/ugWcq+aB4PuUGtKmkd
   Mn4Z3slTCSlGSZzvw+3AoOY7wJZHqP+ithHb7DGY8gXkRdceKfzO8w9Tg
   gwyijJKggdSpI88f7dGqxsHud7iivWfPNu87g3aIqmfG1hjaxKAR55klz
   gw7D3nuVaA1B8DAcuUlB2sBLLoK7uQNstyo679LUVyUtG9vuVRpM4cslG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="290590897"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="290590897"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 21:35:44 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="595563703"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 21:35:43 -0700
Date:   Mon, 25 Apr 2022 21:36:19 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
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
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <Ymd2w30dkiKX1VfL@fyu1.sc.intel.com>
References: <YmJ/WA6KAQU/xJjA@myrica>
 <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica>
 <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica>
 <20220425083444.00af5674@jacob-builder>
 <YmbIjnHtibY7n4Wb@myrica>
 <cf27bf82-ca68-86f1-ac8f-a138713edd5f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf27bf82-ca68-86f1-ac8f-a138713edd5f@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 12:28:00PM +0800, Zhangfei Gao wrote:
> Hi, Jean
> 
> On 2022/4/26 上午12:13, Jean-Philippe Brucker wrote:
> > Hi Jacob,
> > 
> > On Mon, Apr 25, 2022 at 08:34:44AM -0700, Jacob Pan wrote:
> > > Hi Jean-Philippe,
> > > 
> > > On Mon, 25 Apr 2022 15:26:40 +0100, Jean-Philippe Brucker
> > > <jean-philippe@linaro.org> wrote:
> > > 
> > > > On Mon, Apr 25, 2022 at 07:18:36AM -0700, Dave Hansen wrote:
> > > > > On 4/25/22 06:53, Jean-Philippe Brucker wrote:
> > > > > > On Sat, Apr 23, 2022 at 07:13:39PM +0800, zhangfei.gao@foxmail.com
> > > > > > wrote:
> > > > > > > > > On 5.17
> > > > > > > > > fops_release is called automatically, as well as
> > > > > > > > > iommu_sva_unbind_device. On 5.18-rc1.
> > > > > > > > > fops_release is not called, have to manually call close(fd)
> > > > > > > > Right that's weird
> > > > > > > Looks it is caused by the fix patch, via mmget, which may add
> > > > > > > refcount of fd.
> > > > > > Yes indirectly I think: when the process mmaps the queue,
> > > > > > mmap_region() takes a reference to the uacce fd. That reference is
> > > > > > released either by explicit close() or munmap(), or by exit_mmap()
> > > > > > (which is triggered by mmput()). Since there is an mm->fd dependency,
> > > > > > we cannot add a fd->mm dependency, so no mmget()/mmput() in
> > > > > > bind()/unbind().
> > > > > > 
> > > > > > I guess we should go back to refcounted PASIDs instead, to avoid
> > > > > > freeing them until unbind().
> > > > > Yeah, this is a bit gnarly for -rc4.  Let's just make sure there's
> > > > > nothing else simple we can do.
> > > > > 
> > > > > How does the IOMMU hardware know that all activity to a given PASID is
> > > > > finished?  That activity should, today, be independent of an mm or a
> > > > > fd's lifetime.
> > > > In the case of uacce, it's tied to the fd lifetime: opening an accelerator
> > > > queue calls iommu_sva_bind_device(), which sets up the PASID context in
> > > > the IOMMU. Closing the queue calls iommu_sva_unbind_device() which
> > > > destroys the PASID context (after the device driver stopped all DMA for
> > > > this PASID).
> > > > 
> > > For VT-d, it is essentially the same flow except managed by the individual
> > > drivers such as DSA.
> > > If free() happens before unbind(), we deactivate the PASIDs and suppress
> > > faults from the device. When the unbind finally comes, we finalize the
> > > PASID teardown. It seems we have a need for an intermediate state where
> > > PASID is "pending free"?
> > Yes we do have that state, though I'm not sure we need to make it explicit
> > in the ioasid allocator.
> > 
> > Could we move mm_pasid_drop() to __mmdrop() instead of __mmput()?  For Arm
> > we do need to hold the mm_count until unbind(), and mmgrab()/mmdrop() is
> > also part of Lu's rework [1].
> 
> Move mm_pasid_drop to __mmdrop looks workable.
> 
> The nginx works since ioasid is not freed when master exit until nginx stop.
> 
> The ioasid does not free immediately when fops_release->unbind finished.
> Instead, __mmdrop happens a bit lazy,  which has no issue though
> I passed 10000 times exit without unbind test, the pasid allocation is ok.
> 
> Thanks
> 
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 9796897560ab..60f417f69367 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -792,6 +792,8 @@ void __mmdrop(struct mm_struct *mm)
>         mmu_notifier_subscriptions_destroy(mm);
>         check_mm(mm);
>         put_user_ns(mm->user_ns);
> +       mm_pasid_drop(mm);
>         free_mm(mm);
>  }
>  EXPORT_SYMBOL_GPL(__mmdrop);
> @@ -1190,7 +1192,6 @@ static inline void __mmput(struct mm_struct *mm)
>         }
>         if (mm->binfmt)
>                 module_put(mm->binfmt->module);
> -       mm_pasid_drop(mm);
>         mmdrop(mm);
>  }

Thank you very much, Zhangfei!

I just now sent out an identical patch. It works on X86 as well.

So seems the patch is the right fix.

Either you can send out the patch or I add your Signed-off-by? Either way
is OK for me.

Thanks.

-Fenghua
