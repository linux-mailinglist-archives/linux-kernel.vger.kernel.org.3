Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB3152DEA9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 22:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244814AbiESUrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 16:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244805AbiESUrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 16:47:22 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF4E326D2;
        Thu, 19 May 2022 13:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652993240; x=1684529240;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PhTnezSJP89wbzzIGgqvpxBM1Sff4ybKzcPyuzQ0PX8=;
  b=UqoUYLXUl67UhSCKCVeWAZ/9TrSgM+5PbewMLhhIQa/zot4llFLXIVYK
   FZAcrPoXJ5BCPkd6jkSz7DKeM8+af+HJuJyba7dZacm00CZtEq3PbjgNV
   A4ypCsRURPMuVv3BqIKylUYu6d1oykoE6s4v7r18rgerLy/j0ZhOQipcq
   CPoA+wM8wfzG/DmxlXLbO3ncdwwtYpaHD6jk8W/V6b5fNOc0PzWp/D/sQ
   8vlSpsdq0m6ZMc+k5TtRtBTedMNr2ZGO2NGKg7Ou1MkVnapbzxI4lVwl5
   R4df6GXr5gmJNjM2W1itcDPfze5YSlSa6QJ5sEj5MVP6MmIrOLNmAQOWf
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="332994965"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="332994965"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 13:47:20 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="546304620"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.212.148.227])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 13:47:19 -0700
Message-ID: <4a5b462b99b004d1cc226564d838e932e4d69a5f.camel@linux.intel.com>
Subject: Re: [PATCH] x86/sgx: Set active memcg prior to shmem allocation
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>, linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 19 May 2022 13:47:18 -0700
In-Reply-To: <e803b75e22d204b92e5496fc51eb525c24c3c3c1.camel@kernel.org>
References: <20220517164713.4610-1-kristen@linux.intel.com>
         <e803b75e22d204b92e5496fc51eb525c24c3c3c1.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-18 at 04:24 +0300, Jarkko Sakkinen wrote:
> On Tue, 2022-05-17 at 09:47 -0700, Kristen Carlson Accardi wrote:
> > When the system runs out of enclave memory, SGX can reclaim EPC
> > pages
> > by swapping to normal RAM. These backing pages are allocated via a
> > per-enclave shared memory area. Since SGX allows unlimited over
> > commit on EPC memory, the reclaimer thread can allocate a large
> > number of backing RAM pages in response to EPC memory pressure.
> > 
> > When the shared memory backing RAM allocation occurs during
> > the reclaimer thread context, the shared memory is charged to
> > the root memory control group, and the shmem usage of the enclave
> > is not properly accounted for, making cgroups ineffective at
> > limiting the amount of RAM an enclave can consume.
> > 
> > For example, when using a cgroup to launch a set of test
> > enclaves, the kernel does not properly account for 50% - 75% of
> > shmem page allocations on average. In the worst case, when
> > nearly all allocations occur during the reclaimer thread, the
> > kernel accounts less than a percent of the amount of shmem used
> > by the enclave's cgroup to the correct cgroup.
> > 
> > SGX currently stores a list of mm_structs that are associated with
> > an enclave. In order to allow the enclave's cgroup to more
> > accurately
> > reflect the shmem usage, the memory control group (struct
> > mem_cgroup)
> > of one of these mm_structs can be set as the active memory cgroup
> > prior to allocating any EPC backing pages. This will make any shmem
> > allocations be charged to a memory control group associated with
> > the
> > enclave's cgroup. This will allow memory cgroup limits to restrict
> > RAM usage more effectively.
> > 
> > This patch will create a new function - sgx_encl_alloc_backing().
> > This function will be used whenever a new backing storage page
> > needs to be allocated. Previously the same function was used for
> > page allocation as well as retrieving a previously allocated page.
> > Prior to backing page allocation, if there is a mm_struct
> > associated
> > with the enclave that is requesting the allocation, it will be set
> > as the active memory control group.
> > 
> > Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> > ---
> >  arch/x86/kernel/cpu/sgx/encl.c | 111
> > ++++++++++++++++++++++++++++++++-
> >  arch/x86/kernel/cpu/sgx/encl.h |   6 +-
> >  arch/x86/kernel/cpu/sgx/main.c |   4 +-
> >  3 files changed, 115 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/sgx/encl.c
> > b/arch/x86/kernel/cpu/sgx/encl.c
> > index 001808e3901c..c3a5e57040bc 100644
> > --- a/arch/x86/kernel/cpu/sgx/encl.c
> > +++ b/arch/x86/kernel/cpu/sgx/encl.c
> > @@ -32,7 +32,7 @@ static int __sgx_encl_eldu(struct sgx_encl_page
> > *encl_page,
> >         else
> >                 page_index = PFN_DOWN(encl->size);
> >  
> > -       ret = sgx_encl_get_backing(encl, page_index, &b);
> > +       ret = sgx_encl_lookup_backing(encl, page_index, &b);
> >         if (ret)
> >                 return ret;
> >  
> > @@ -574,7 +574,7 @@ static struct page
> > *sgx_encl_get_backing_page(struct sgx_encl *encl,
> >   *   0 on success,
> >   *   -errno otherwise.
> >   */
> > -int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long
> > page_index,
> > +static int sgx_encl_get_backing(struct sgx_encl *encl, unsigned
> > long page_index,
> >                          struct sgx_backing *backing)
> >  {
> >         pgoff_t pcmd_index = PFN_DOWN(encl->size) + 1 + (page_index
> > >> 5);
> > @@ -601,6 +601,113 @@ int sgx_encl_get_backing(struct sgx_encl
> > *encl, unsigned long page_index,
> >         return 0;
> >  }
> >  
> > +static struct mem_cgroup * sgx_encl_set_active_memcg(struct
> > sgx_encl *encl)
> > +{
> > +       struct mm_struct *mm = current->mm;
> > +       struct sgx_encl_mm *encl_mm;
> > +       struct mem_cgroup *memcg;
> > +       int idx;
> > +
> > +       /*
> > +        * If current->mm is NULL, get_mem_cgroup_from_mm() will
> > return
> > +        * the currently active mem_cgroup. This may be the root
> > mem_cgroup
> > +        * if there is no active mem_cgroup set.
> > +        */
> > +       memcg = get_mem_cgroup_from_mm(mm);
> > +
> > +       /*
> > +        * If we already have an mm, we are not in thread context
> > and the
> > +        * mem_cgroup for the enclave will be charged for any
> > allocations.
> > +        */
> 
> AFAIK CPU is always executing in some thread.
> 
> This would a lot clearer:
> 
> /*
>  * If the CPU is not inside a kthread, return the active memcg.
>  */
>  
> Please remark of not using "we" in my version. It's better to be
> explicit when you can.

Thank you for your feedback. I've incorporated it into my next version.

Kristen


