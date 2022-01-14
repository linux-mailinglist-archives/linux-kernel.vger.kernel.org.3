Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCB448EF5B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 18:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbiANRrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 12:47:33 -0500
Received: from mga07.intel.com ([134.134.136.100]:28612 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbiANRra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 12:47:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642182450; x=1673718450;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QKLok4O8gbmxxCS7GWWlHZnGROUrPQjA9Bmw8BFFUUs=;
  b=L+mlIwGi3F/yrLeEMVMbpWGr8cIUIeI3CqfwseyYEP5tzxlCfQv5LT0t
   C1roUnZ13v1itcbJKHc+3ofv6DYRLcVms/LKZkjIRTzU05Ff2rXdnsQAR
   LgBB1UjORa01LE3ikA/CCMUVXyMpEwKdLopHEqA6qHIKHFcseK0eaR9Bs
   9ljUbTKItW3bi2gOmtLGslottww7XfqWsiOSpg4/mfc1BihSOR401swHU
   6HX+H+FlHON0n+vejy0msxjnzMiBr8OivnpFzDE6Oaxj4ywgdV8R/LnOI
   x2M4t6e2J3/ag3l7XVi0MldXOnFydDQy4U3WDzCPsqy6JMxPaMPwmDYxe
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="307635721"
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="307635721"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 09:47:29 -0800
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="692291399"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.212.237.206])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 09:47:28 -0800
Message-ID: <280c234da5678ae8d38fd27fe36559f8d5921a48.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/2] x86/sgx: Add accounting for tracking overcommit
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 14 Jan 2022 09:47:24 -0800
In-Reply-To: <Ydm08b9+gPnJoQgF@iki.fi>
References: <20220107181618.6597-1-kristen@linux.intel.com>
         <20220107181618.6597-2-kristen@linux.intel.com> <Ydm08b9+gPnJoQgF@iki.fi>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-01-08 at 17:59 +0200, Jarkko Sakkinen wrote:
> On Fri, Jan 07, 2022 at 10:16:16AM -0800, Kristen Carlson Accardi
> wrote:
> > When the system runs out of enclave memory, SGX can reclaim EPC
> > pages
> > by swapping to normal RAM. This normal RAM is allocated via a
> > per-enclave shared memory area. The shared memory area is not
> > mapped
> > into the enclave or the task mapping it, which makes its memory use
> > opaque (including to the OOM killer). Having lots of hard to find
> > memory around is problematic, especially when there is no limit.
> > 
> > Introduce a global counter that can be used to limit the number of
> > pages
> > that enclaves are able to consume for backing storage.  This
> > parameter
> > is a percentage value that is used in conjunction with the number
> > of
> > EPC pages in the system to set a cap on the amount of backing RAM
> > that
> > can be consumed.
> > 
> > The overcommit percentage value is 150, which limits the total
> > number of
> > shared memory pages that may be consumed by all enclaves as backing
> > pages
> > to 1.5X of EPC pages on the system.
> > 
> > For example, on an SGX system that has 128MB of EPC, this would
> > cap the amount of normal RAM that SGX consumes for its shared
> > memory
> > areas at 192MB.
> > 
> > The SGX overcommit percent works differently than the core VM
> > overcommit
> > limit. Enclaves request backing pages one page at a time, and the
> > number
> > of in use backing pages that are allowed is a global resource that
> > is
> > limited for all enclaves.
> > 
> > Introduce a pair of functions which can be used by callers when
> > requesting
> > backing RAM pages. These functions are responsible for accounting
> > the
> > page charges. A request may return an error if the request will
> > cause the
> > counter to exceed the backing page cap.
> > 
> > Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> > ---
> >  arch/x86/kernel/cpu/sgx/main.c | 46
> > ++++++++++++++++++++++++++++++++++
> >  arch/x86/kernel/cpu/sgx/sgx.h  |  2 ++
> >  2 files changed, 48 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/cpu/sgx/main.c
> > b/arch/x86/kernel/cpu/sgx/main.c
> > index 2857a49f2335..8a7bfe0d9023 100644
> > --- a/arch/x86/kernel/cpu/sgx/main.c
> > +++ b/arch/x86/kernel/cpu/sgx/main.c
> > @@ -43,6 +43,45 @@ static struct sgx_numa_node *sgx_numa_nodes;
> >  
> >  static LIST_HEAD(sgx_dirty_page_list);
> >  
> > +/*
> > + * Limits the amount of normal RAM that SGX can consume for EPC
> > + * overcommit to the total EPC pages * sgx_overcommit_percent /
> > 100
> > + */
> > +static int sgx_overcommit_percent = 150;
> > +
> > +/* The number of pages that can be allocated globally for backing
> > storage. */
> > +static atomic_long_t sgx_nr_available_backing_pages;
> > +
> > +/**
> > + * sgx_charge_mem() - charge for a page used for backing storage
> > + *
> > + * Backing storage usage is capped by the
> > sgx_nr_available_backing_pages.
> > + * If the backing storage usage is over the overcommit limit,
> > + * return an error.
> > + *
> > + * Return:
> > + * 0:		The page requested does not exceed the limit
> > + * -ENOMEM:	The page requested exceeds the overcommit limit
> > + */
> > +int sgx_charge_mem(void)
> > +{
> > +	if (!atomic_long_add_unless(&sgx_nr_available_backing_pages,
> > -1, 0))
> > +		return -ENOMEM;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * sgx_uncharge_mem() - uncharge a page previously used for
> > backing storage
> > + *
> > + * When backing storage is no longer in use, increment the
> > + * sgx_nr_available_backing_pages counter.
> > + */
> > +void sgx_uncharge_mem(void)
> > +{
> > +	atomic_long_inc(&sgx_nr_available_backing_pages);
> > +}
> > +
> >  /*
> >   * Reset post-kexec EPC pages to the uninitialized state. The
> > pages are removed
> >   * from the input list, and made available for the page allocator.
> > SECS pages
> > @@ -786,6 +825,8 @@ static bool __init sgx_page_cache_init(void)
> >  	u64 pa, size;
> >  	int nid;
> >  	int i;
> > +	u64 total_epc_bytes = 0;
> > +	u64 available_backing_bytes;
> 
> Use reverse-christmas-tree declaration order here. This was required
> for
> the original patch set, so I expect this to still hold.

sure.

> 
> >  
> >  	sgx_numa_nodes = kmalloc_array(num_possible_nodes(),
> > sizeof(*sgx_numa_nodes), GFP_KERNEL);
> >  	if (!sgx_numa_nodes)
> > @@ -830,6 +871,7 @@ static bool __init sgx_page_cache_init(void)
> >  
> >  		sgx_epc_sections[i].node =  &sgx_numa_nodes[nid];
> >  		sgx_numa_nodes[nid].size += size;
> > +		total_epc_bytes += size;
> >  
> >  		sgx_nr_epc_sections++;
> >  	}
> > @@ -839,6 +881,10 @@ static bool __init sgx_page_cache_init(void)
> >  		return false;
> >  	}
> >  
> > +	available_backing_bytes = total_epc_bytes *
> > (sgx_overcommit_percent / 100);
> > +
> 
> IMHO this empty line could be removed, and group these statements
> together.

ok.

> 
> > +	atomic_long_set(&sgx_nr_available_backing_pages,
> > available_backing_bytes >> PAGE_SHIFT);
> > +
> >  	return true;
> >  }
> >  
> > diff --git a/arch/x86/kernel/cpu/sgx/sgx.h
> > b/arch/x86/kernel/cpu/sgx/sgx.h
> > index 0f17def9fe6f..3507a9983fc1 100644
> > --- a/arch/x86/kernel/cpu/sgx/sgx.h
> > +++ b/arch/x86/kernel/cpu/sgx/sgx.h
> > @@ -89,6 +89,8 @@ void sgx_free_epc_page(struct sgx_epc_page
> > *page);
> >  void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
> >  int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
> >  struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool
> > reclaim);
> > +int sgx_charge_mem(void);
> > +void sgx_uncharge_mem(void);
> >  
> >  #ifdef CONFIG_X86_SGX_KVM
> >  int __init sgx_vepc_init(void);
> > -- 
> > 2.20.1
> > 
> 
> Other than that, looks good to me.

thanks for taking another look. I will incorporate your suggestions
into the next revision.


