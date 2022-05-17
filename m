Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4B252A9BB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 19:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350016AbiEQR5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 13:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351704AbiEQR5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 13:57:13 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98F2506C9;
        Tue, 17 May 2022 10:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652810230; x=1684346230;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yaao91EAvwMNuSxCu2awE1Nh3gBqy+6a5hIC5exiRRU=;
  b=MsdDheJ3pIv7EYqHHy/XWvr351FyJX8S7gPzY3tfxJrJWqFFkRC/NPyC
   4222qJxooMnp+8Jt7f/HMxy6yo/CzTVYEJnjF0SPOPZMmfg1k+pHc1Sdu
   oAH+qVITpzLpfyfxX2iX/3LtUnXeIPJ8w7K9oZ9KVRpNGcur6IMX/cFX5
   HkFl4Wp33dsoMCD3XrWzaNV98qfiYubh0BxsiIZMH6PQwQMc3qQUunsxx
   QjJ+PhQP5DKkzRRguN+aZE1XeHHaRd5QOhFuD+sUFiFBq2ZkeeVOQ2HC5
   ixRmeo2l5IjaBgu0Yuao3nBC9X2Zy69ZieG1w3b23F+qK24zOmQToLSFl
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="270093300"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="270093300"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 10:57:10 -0700
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="672969935"
Received: from danielga-mobl.amr.corp.intel.com (HELO [10.212.245.96]) ([10.212.245.96])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 10:57:09 -0700
Message-ID: <9c269c70-35fe-a1a4-34c9-b1e62ab3bb3b@intel.com>
Date:   Tue, 17 May 2022 10:57:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] x86/sgx: Set active memcg prior to shmem allocation
Content-Language: en-US
To:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-sgx@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Johannes Weiner <hannes@cmpxchg.org>, roman.gushchin@linux.dev,
        Shakeel Butt <shakeelb@google.com>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org
References: <20220517164713.4610-1-kristen@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220517164713.4610-1-kristen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... also adding the same folks that mhocko did in the other post

On 5/17/22 09:47, Kristen Carlson Accardi wrote:
> When the system runs out of enclave memory, SGX can reclaim EPC pages
> by swapping to normal RAM. These backing pages are allocated via a
> per-enclave shared memory area. Since SGX allows unlimited over
> commit on EPC memory, the reclaimer thread can allocate a large
> number of backing RAM pages in response to EPC memory pressure.

A few bits of info that the folks not deeply familiar with SGX might
care about: SGX "enclave memory" is RAM, but it is marked reserved by
the BIOS and not managed by the core mm.  The SGX "driver" manages the
memory and has its own little mm subsystem, including a reclaimer.

( Aside: If you haven't encountered SGX before, as core mm folks, your
  first reaction is going to be to recoil in disgust.  This is an
  appropriate reaction.  In order to mitigate attacks from the OS, the
  SGX architecture partially duplicates a ton of existing x86
  architectural structures.  For instance, SGX has its own page
  permissions which are separate from the page tables.  SGX is weird. )

> When the shared memory backing RAM allocation occurs during
> the reclaimer thread context, the shared memory is charged to
> the root memory control group, and the shmem usage of the enclave
> is not properly accounted for, making cgroups ineffective at
> limiting the amount of RAM an enclave can consume.

One more bit of context:

Just like the core mm, SGX has both a direct and an indirect reclaim
path.  The direct reclaim path properly accounts shared memory
allocations to the cgroup of the task doing the reclaim.  The problem
here is with the SGX indirect reclaim path.

> For example, when using a cgroup to launch a set of test
> enclaves, the kernel does not properly account for 50% - 75% of
> shmem page allocations on average. In the worst case, when
> nearly all allocations occur during the reclaimer thread, the

				s/during the/in/

> kernel accounts less than a percent of the amount of shmem used
> by the enclave's cgroup to the correct cgroup.
> 
> SGX currently stores a list of mm_structs that are associated with
> an enclave. In order to allow the enclave's cgroup to more accurately
> reflect the shmem usage, the memory control group (struct mem_cgroup)
> of one of these mm_structs can be set as the active memory cgroup
> prior to allocating any EPC backing pages. This will make any shmem
> allocations be charged to a memory control group associated with the
> enclave's cgroup. This will allow memory cgroup limits to restrict
> RAM usage more effectively.

Let's make this a bit more imperative:

	SGX stores a list of mm_structs that are associated with an
	enclave.  Pick one of them during reclaim and charge that mm's
 	memcg with the shmem allocation.  The one that gets picked is
	arbitrary, but this list almost always only has one mm.  The
	cases where there is more than one mm with *different memcg's
	are not even worth considering.

> This patch will create a new function - sgx_encl_alloc_backing().

No "this patch"'s, please.  Replace:

	This patch will create a new function -

With:

	Create a new function -

> This function will be used whenever a new backing storage page
> needs to be allocated. Previously the same function was used for
> page allocation as well as retrieving a previously allocated page.
> Prior to backing page allocation, if there is a mm_struct associated
> with the enclave that is requesting the allocation, it will be set
> as the active memory control group.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> ---
>  arch/x86/kernel/cpu/sgx/encl.c | 111 ++++++++++++++++++++++++++++++++-
>  arch/x86/kernel/cpu/sgx/encl.h |   6 +-
>  arch/x86/kernel/cpu/sgx/main.c |   4 +-
>  3 files changed, 115 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> index 001808e3901c..c3a5e57040bc 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -32,7 +32,7 @@ static int __sgx_encl_eldu(struct sgx_encl_page *encl_page,
>  	else
>  		page_index = PFN_DOWN(encl->size);
>  
> -	ret = sgx_encl_get_backing(encl, page_index, &b);
> +	ret = sgx_encl_lookup_backing(encl, page_index, &b);
>  	if (ret)
>  		return ret;
>  
> @@ -574,7 +574,7 @@ static struct page *sgx_encl_get_backing_page(struct sgx_encl *encl,
>   *   0 on success,
>   *   -errno otherwise.
>   */
> -int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
> +static int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
>  			 struct sgx_backing *backing)
>  {
>  	pgoff_t pcmd_index = PFN_DOWN(encl->size) + 1 + (page_index >> 5);
> @@ -601,6 +601,113 @@ int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
>  	return 0;
>  }
>  
> +static struct mem_cgroup * sgx_encl_set_active_memcg(struct sgx_encl *encl)

			     ^ stray whitespace

A comment saying what this returns would be nice too.

Could this maybe be named something like:

	set_active_memcg_from_encl()

This otherwise makes it sound like it's setting an *enclave's* memcg.

> +{
> +	struct mm_struct *mm = current->mm;
> +	struct sgx_encl_mm *encl_mm;
> +	struct mem_cgroup *memcg;
> +	int idx;
> +
> +	/*
> +	 * If current->mm is NULL, get_mem_cgroup_from_mm() will return
> +	 * the currently active mem_cgroup. This may be the root mem_cgroup
> +	 * if there is no active mem_cgroup set.
> +	 */
> +	memcg = get_mem_cgroup_from_mm(mm);
> +
> +	/*
> +	 * If we already have an mm, we are not in thread context and the
> +	 * mem_cgroup for the enclave will be charged for any allocations.
> +	 */
> +	if (mm)
> +		return memcg;

Can we just be more direct about this?

	/*
	 * If being called from normal task context, just use
	 * the task's normal memcg.  The remainder of the handling
	 * is for ksgxd.
	 */
	if (!current_is_ksgxd())
		return get_mem_cgroup_from_mm(mm);

It will mean adding that helper, but it's a *lot* more obvious what is
going on.

> +	/*
> +	 * If there is no mm, it means that we are in thread context,
> +	 * and any backing RAM allocations would be charged to the root
> +	 * mem_cgroup unless the active mem_cgroup is set. Search the
> +	 * enclave's mm_list to find any mm associated with this enclave.
> +	 */
> +	idx = srcu_read_lock(&encl->srcu);
> +
> +	list_for_each_entry_rcu(encl_mm, &encl->mm_list, list) {
> +		if (encl_mm->mm == NULL)
> +			continue;
> +
> +		mm = encl_mm->mm;
> +		break;
> +
> +	}
> +
> +	srcu_read_unlock(&encl->srcu, idx);
> +
> +	/*
> +	 * If an associated mm was not found, the allocation will just
> +	 * need to be charged to the root mem_cgroup.
> +	 */
> +	if (!mm)
> +		return memcg;
> +
> +	memcg = get_mem_cgroup_from_mm(mm);

What keeps the mm around between the srcu_read_unlock() and here?  Do
you need a mmget_not_zero() like sgx_reclaimer_block() uses?

> +	/*
> +	 * set_active_memcg() returns the previous active memcg.
> +	 */
> +	return set_active_memcg(memcg);
> +}
> +
> +/**
> + * sgx_encl_alloc_backing() - allocate a new backing storage page
> + * @encl:	an enclave pointer
> + * @page_index:	enclave page index
> + * @backing:	data for accessing backing storage for the page
> + *
> + * If this function is called from the kernel thread, it will set
> + * the active memcg to one of the enclaves mm's in order to ensure

				"enclave's"


