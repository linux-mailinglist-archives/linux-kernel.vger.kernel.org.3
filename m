Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B566248EF5E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 18:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243918AbiANRvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 12:51:18 -0500
Received: from mga02.intel.com ([134.134.136.20]:24959 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbiANRvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 12:51:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642182677; x=1673718677;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oA7p8R5TuXBUb23c1P3IgwuuI4bHsWSCIwT6D7uo+GM=;
  b=lesRs14LN48luz9W2pXyLpliKHa6W1sInG/omZA95IgSIQguYmUp0Z/L
   H+ZBhxz1iHwk6+3rKFGeizySWQmaKI4SqAFazEoEKYwT8Q0roGaVFq0NY
   n8mdbiXYIBq7/YdgZiV85DUxfNzPlBxZ+osov3XAxLfulFywkql36ECnV
   t/bAEsPqUqswNyxcSgZV2rhykpfPz/uoo94vs4nhyWsuM6MoyOm4lew79
   E6NDz2AJ1bZli0UigOWvuiAm1u711tgyF+jZKzUwjCVFv5F5tLsnIQJiK
   mVNczIWQAPqTx2TxXgm8yf8+dTJTBwAUfBBepJQ0fNZx1dFNJemyPp7z7
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="231644316"
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="231644316"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 09:51:16 -0800
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="670922797"
Received: from agonz1-mobl3.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.212.237.206])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 09:51:15 -0800
Message-ID: <fda3bb7bd557a37112a4f7c6c205871addda1bd3.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/2] x86/sgx: account backing pages
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 14 Jan 2022 09:51:14 -0800
In-Reply-To: <Ydm2Qk8JFwgdueZa@iki.fi>
References: <20220107181618.6597-1-kristen@linux.intel.com>
         <20220107181618.6597-3-kristen@linux.intel.com> <Ydm2Qk8JFwgdueZa@iki.fi>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-01-08 at 18:05 +0200, Jarkko Sakkinen wrote:
> On Fri, Jan 07, 2022 at 10:16:17AM -0800, Kristen Carlson Accardi
> wrote:
> > SGX may allow EPC pages to be overcommitted. If the system is
> > out of enclave memory, EPC pages are swapped to normal RAM via
> > a per enclave shared memory area. This shared memory is not
> > charged to the enclave or the task mapping it, making it hard
> > to account for using normal methods.
> > 
> > In order to avoid unlimited usage of normal RAM, enclaves must be
> > charged for each new page used for backing storage, and uncharged
> > when they are no longer using a backing page.
> > 
> > Modify the existing flow for requesting backing pages to reduce the
> > available backing page counter and confirm that the limit has not
> > been exceeded. Backing page usage for loading EPC pages back out of
> > the shared memory do not incur a charge.
> > 
> > When a backing page is released from usage, increment the available
> > backing page counter.
> > 
> > When swapping EPC pages to RAM, in addition to storing the page
> > contents, SGX must store some additional metadata to protect
> > against a malicious kernel when the page is swapped back in. This
> > additional metadata is called Paging Crypto MetaData. PCMD is
> > allocated from the same shared memory area as the backing page
> > contents and consumes RAM the same way.
> > 
> > PCMD is 128 bytes in size, and there is one PCMD structure per
> > page written to shared RAM. The page index for the PCMD page is
> > calculated from the page index of the backing page, so it is
> > possible
> > that the PCMD structures are not packed into the minimum number of
> > pages possible. If 32 PCMDs can fit onto a single page, then PCMD
> > usage is 1/32 of total EPC pages. In the worst case, PCMD can
> > consume the same amount of RAM as EPC backing pages (1:1). For
> > simplicity, this implementation does not account for PCMD page
> > usage.
> > 
> > Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> > ---
> >  arch/x86/kernel/cpu/sgx/encl.c | 76
> > ++++++++++++++++++++++++++++++++--
> >  arch/x86/kernel/cpu/sgx/encl.h |  6 ++-
> >  arch/x86/kernel/cpu/sgx/main.c |  6 +--
> >  3 files changed, 80 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/sgx/encl.c
> > b/arch/x86/kernel/cpu/sgx/encl.c
> > index 001808e3901c..8be6f0592bdc 100644
> > --- a/arch/x86/kernel/cpu/sgx/encl.c
> > +++ b/arch/x86/kernel/cpu/sgx/encl.c
> > @@ -32,7 +32,7 @@ static int __sgx_encl_eldu(struct sgx_encl_page
> > *encl_page,
> >  	else
> >  		page_index = PFN_DOWN(encl->size);
> >  
> > -	ret = sgx_encl_get_backing(encl, page_index, &b);
> > +	ret = sgx_encl_lookup_backing(encl, page_index, &b);
> >  	if (ret)
> >  		return ret;
> >  
> > @@ -407,6 +407,12 @@ void sgx_encl_release(struct kref *ref)
> >  			sgx_encl_free_epc_page(entry->epc_page);
> >  			encl->secs_child_cnt--;
> >  			entry->epc_page = NULL;
> > +		} else {
> > +			/*
> > +			 * If there is no epc_page, it means it has
> > been
> > +			 * swapped out. Uncharge the backing storage.
> > +			 */
> > +			sgx_uncharge_mem();
> >  		}
> >  
> >  		kfree(entry);
> > @@ -574,8 +580,8 @@ static struct page
> > *sgx_encl_get_backing_page(struct sgx_encl *encl,
> >   *   0 on success,
> >   *   -errno otherwise.
> >   */
> > -int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long
> > page_index,
> > -			 struct sgx_backing *backing)
> > +static int sgx_encl_get_backing(struct sgx_encl *encl, unsigned
> > long page_index,
> > +				struct sgx_backing *backing)
> >  {
> >  	pgoff_t pcmd_index = PFN_DOWN(encl->size) + 1 + (page_index >>
> > 5);
> >  	struct page *contents;
> > @@ -601,6 +607,62 @@ int sgx_encl_get_backing(struct sgx_encl
> > *encl, unsigned long page_index,
> >  	return 0;
> >  }
> >  
> > +/**
> > + * sgx_encl_alloc_backing() - allocate a new backing storage page
> > + * @encl:	an enclave pointer
> > + * @page_index:	enclave page index
> > + * @backing:	data for accessing backing storage for the page
> > + *
> > + * Confirm that the global overcommit limit has not been reached
> > before
> > + * requesting a new backing storage page for storing the encrypted
> > contents
> > + * and Paging Crypto MetaData (PCMD) of an enclave page. This is
> > called when
> > + * there is no existing backing page, just before writing to the
> > backing
> > + * storage with EWB.
> > + *
> > + * Return:
> > + *   0 on success,
> > + *   -errno otherwise.
> > + */
> > +int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long
> > page_index,
> > +			   struct sgx_backing *backing)
> > +{
> > +	int ret;
> > +
> > +	if (sgx_charge_mem())
> > +		return -ENOMEM;
> > +
> > +	ret = sgx_encl_get_backing(encl, page_index, backing);
> > +	if (ret)
> > +		sgx_uncharge_mem();
> > +
> > +	return ret;
> > +}
> > +
> > +/**
> > + * sgx_encl_lookup_backing() - retrieve an existing backing
> > storage page
> > + * @encl:	an enclave pointer
> > + * @page_index:	enclave page index
> > + * @backing:	data for accessing backing storage for the page
> > + *
> > + * Retrieve a backing page for loading data back into an EPC page
> > with ELDU.
> > + * This call does not cause a charge to the overcommit limit
> > because a page
> > + * has already been allocated, but has been swapped out or is in
> > RAM
> > + *
> > + * It is the caller's responsibility to ensure that it is
> > appropriate to
> > + * use sgx_encl_lookup_backing() rather than
> > sgx_encl_alloc_backing(). If
> > + * lookup is not used correctly, this will cause an allocation
> > that is
> > + * not accounted for.
> > + *
> > + * Return:
> > + *   0 on success,
> > + *   -errno otherwise.
> > + */
> > +int sgx_encl_lookup_backing(struct sgx_encl *encl, unsigned long
> > page_index,
> > +			    struct sgx_backing *backing)
> > +{
> > +	return sgx_encl_get_backing(encl, page_index, backing);
> > +}
> 
> IMHO, sgx_encl_backing() should be open-coded here.

I can understand your hesitation, but I agree with Dave here that
wrapping the function makes the code more clear. I would prefer to keep
this the way it is.


