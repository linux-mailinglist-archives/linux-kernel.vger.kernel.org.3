Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9108648F342
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 00:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiANXwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 18:52:24 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58014 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiANXwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 18:52:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24D676209D;
        Fri, 14 Jan 2022 23:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28D1C36AE7;
        Fri, 14 Jan 2022 23:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642204342;
        bh=7PDj+yXIqW75tDIH32v35vasVHzE+sVih5sXdX46aKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VLnUg12DA5Esu4L1rEFind65gH1URH44Q/gRgh/Zit47orImOkVhoTXZl5cgYAaqM
         V/FcRuIjikhKOPm4wHGfC9rn9ilxBVWaW3ZR1ewhIv2d2kvLUowzuhRfiI1gWxoQoT
         F34oxDhXci6V8WH7Brgs0zDL4RnE7zRaHncThNmj0CdAgkFyLdoslZp3UfP7ekm2OU
         yENscleZ/HajD/ZOZFjdn3K/t3dd9aihcv8aBVE6X+wgFFgLQkkvh/qQN1+YDiSbRb
         BeCAzAwDp71EvKm/0k4weKoyT76/MbaGIv6xzZqVgbZDWnmJGCgXO4OItMMfjc1UgV
         cMO5HneXq3Z1w==
Date:   Sat, 15 Jan 2022 01:52:09 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] x86/sgx: account backing pages
Message-ID: <YeIMqd+o//M3vB6e@iki.fi>
References: <20220107181618.6597-1-kristen@linux.intel.com>
 <20220107181618.6597-3-kristen@linux.intel.com>
 <Ydm2Qk8JFwgdueZa@iki.fi>
 <fda3bb7bd557a37112a4f7c6c205871addda1bd3.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fda3bb7bd557a37112a4f7c6c205871addda1bd3.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 09:51:14AM -0800, Kristen Carlson Accardi wrote:
> On Sat, 2022-01-08 at 18:05 +0200, Jarkko Sakkinen wrote:
> > On Fri, Jan 07, 2022 at 10:16:17AM -0800, Kristen Carlson Accardi
> > wrote:
> > > SGX may allow EPC pages to be overcommitted. If the system is
> > > out of enclave memory, EPC pages are swapped to normal RAM via
> > > a per enclave shared memory area. This shared memory is not
> > > charged to the enclave or the task mapping it, making it hard
> > > to account for using normal methods.
> > > 
> > > In order to avoid unlimited usage of normal RAM, enclaves must be
> > > charged for each new page used for backing storage, and uncharged
> > > when they are no longer using a backing page.
> > > 
> > > Modify the existing flow for requesting backing pages to reduce the
> > > available backing page counter and confirm that the limit has not
> > > been exceeded. Backing page usage for loading EPC pages back out of
> > > the shared memory do not incur a charge.
> > > 
> > > When a backing page is released from usage, increment the available
> > > backing page counter.
> > > 
> > > When swapping EPC pages to RAM, in addition to storing the page
> > > contents, SGX must store some additional metadata to protect
> > > against a malicious kernel when the page is swapped back in. This
> > > additional metadata is called Paging Crypto MetaData. PCMD is
> > > allocated from the same shared memory area as the backing page
> > > contents and consumes RAM the same way.
> > > 
> > > PCMD is 128 bytes in size, and there is one PCMD structure per
> > > page written to shared RAM. The page index for the PCMD page is
> > > calculated from the page index of the backing page, so it is
> > > possible
> > > that the PCMD structures are not packed into the minimum number of
> > > pages possible. If 32 PCMDs can fit onto a single page, then PCMD
> > > usage is 1/32 of total EPC pages. In the worst case, PCMD can
> > > consume the same amount of RAM as EPC backing pages (1:1). For
> > > simplicity, this implementation does not account for PCMD page
> > > usage.
> > > 
> > > Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> > > ---
> > >  arch/x86/kernel/cpu/sgx/encl.c | 76
> > > ++++++++++++++++++++++++++++++++--
> > >  arch/x86/kernel/cpu/sgx/encl.h |  6 ++-
> > >  arch/x86/kernel/cpu/sgx/main.c |  6 +--
> > >  3 files changed, 80 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/arch/x86/kernel/cpu/sgx/encl.c
> > > b/arch/x86/kernel/cpu/sgx/encl.c
> > > index 001808e3901c..8be6f0592bdc 100644
> > > --- a/arch/x86/kernel/cpu/sgx/encl.c
> > > +++ b/arch/x86/kernel/cpu/sgx/encl.c
> > > @@ -32,7 +32,7 @@ static int __sgx_encl_eldu(struct sgx_encl_page
> > > *encl_page,
> > >  	else
> > >  		page_index = PFN_DOWN(encl->size);
> > >  
> > > -	ret = sgx_encl_get_backing(encl, page_index, &b);
> > > +	ret = sgx_encl_lookup_backing(encl, page_index, &b);
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > @@ -407,6 +407,12 @@ void sgx_encl_release(struct kref *ref)
> > >  			sgx_encl_free_epc_page(entry->epc_page);
> > >  			encl->secs_child_cnt--;
> > >  			entry->epc_page = NULL;
> > > +		} else {
> > > +			/*
> > > +			 * If there is no epc_page, it means it has
> > > been
> > > +			 * swapped out. Uncharge the backing storage.
> > > +			 */
> > > +			sgx_uncharge_mem();
> > >  		}
> > >  
> > >  		kfree(entry);
> > > @@ -574,8 +580,8 @@ static struct page
> > > *sgx_encl_get_backing_page(struct sgx_encl *encl,
> > >   *   0 on success,
> > >   *   -errno otherwise.
> > >   */
> > > -int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long
> > > page_index,
> > > -			 struct sgx_backing *backing)
> > > +static int sgx_encl_get_backing(struct sgx_encl *encl, unsigned
> > > long page_index,
> > > +				struct sgx_backing *backing)
> > >  {
> > >  	pgoff_t pcmd_index = PFN_DOWN(encl->size) + 1 + (page_index >>
> > > 5);
> > >  	struct page *contents;
> > > @@ -601,6 +607,62 @@ int sgx_encl_get_backing(struct sgx_encl
> > > *encl, unsigned long page_index,
> > >  	return 0;
> > >  }
> > >  
> > > +/**
> > > + * sgx_encl_alloc_backing() - allocate a new backing storage page
> > > + * @encl:	an enclave pointer
> > > + * @page_index:	enclave page index
> > > + * @backing:	data for accessing backing storage for the page
> > > + *
> > > + * Confirm that the global overcommit limit has not been reached
> > > before
> > > + * requesting a new backing storage page for storing the encrypted
> > > contents
> > > + * and Paging Crypto MetaData (PCMD) of an enclave page. This is
> > > called when
> > > + * there is no existing backing page, just before writing to the
> > > backing
> > > + * storage with EWB.
> > > + *
> > > + * Return:
> > > + *   0 on success,
> > > + *   -errno otherwise.
> > > + */
> > > +int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long
> > > page_index,
> > > +			   struct sgx_backing *backing)
> > > +{
> > > +	int ret;
> > > +
> > > +	if (sgx_charge_mem())
> > > +		return -ENOMEM;
> > > +
> > > +	ret = sgx_encl_get_backing(encl, page_index, backing);
> > > +	if (ret)
> > > +		sgx_uncharge_mem();
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +/**
> > > + * sgx_encl_lookup_backing() - retrieve an existing backing
> > > storage page
> > > + * @encl:	an enclave pointer
> > > + * @page_index:	enclave page index
> > > + * @backing:	data for accessing backing storage for the page
> > > + *
> > > + * Retrieve a backing page for loading data back into an EPC page
> > > with ELDU.
> > > + * This call does not cause a charge to the overcommit limit
> > > because a page
> > > + * has already been allocated, but has been swapped out or is in
> > > RAM
> > > + *
> > > + * It is the caller's responsibility to ensure that it is
> > > appropriate to
> > > + * use sgx_encl_lookup_backing() rather than
> > > sgx_encl_alloc_backing(). If
> > > + * lookup is not used correctly, this will cause an allocation
> > > that is
> > > + * not accounted for.
> > > + *
> > > + * Return:
> > > + *   0 on success,
> > > + *   -errno otherwise.
> > > + */
> > > +int sgx_encl_lookup_backing(struct sgx_encl *encl, unsigned long
> > > page_index,
> > > +			    struct sgx_backing *backing)
> > > +{
> > > +	return sgx_encl_get_backing(encl, page_index, backing);
> > > +}
> > 
> > IMHO, sgx_encl_backing() should be open-coded here.
> 
> I can understand your hesitation, but I agree with Dave here that
> wrapping the function makes the code more clear. I would prefer to keep
> this the way it is.

What if sgx_encl_get_backing() was changed as "static inline", if the
only motivation is encapsulation?

/Jarkko
