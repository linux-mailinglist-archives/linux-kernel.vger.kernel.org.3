Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F0D5839E6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 09:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbiG1H6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 03:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234591AbiG1H6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 03:58:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6773C50738;
        Thu, 28 Jul 2022 00:58:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00DCF61B86;
        Thu, 28 Jul 2022 07:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2121C433D6;
        Thu, 28 Jul 2022 07:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658995089;
        bh=jnct55bmzXdelVLg1xsIDz7SDnIpXp89LvUV1J9k/CE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mVyoMkaquVmF2QBR3/DNjFlU6wBY3cQieT9DZvjasHjuJ1zhkV2x1V7/iKtKP3PMU
         pCsHLTMetvCjPqTsHfwfKnO9DqcwmWsx+HsdInNUllRjT6kx5q9JncsFWslhl0Dary
         Sf614nOjbUmHcGjO4vgQ0sf1i95h0mpjBw6ukXvqOGmAwrC6mdN5Es/zLGdKHJhrEz
         hFJI3tpFotisWs9MKfHac8xx1vLn/59urWocqmsuVM5SGRwCbSeJLk+e2ic00NxbBq
         qJUmN5vSD7Tk1/RqrTwGcsDnrVBaGlyzaUC+yKvxsJKlXZV9DoFB+WgcpgnC05Zd6T
         rYzVJWnbNMeLQ==
Date:   Thu, 28 Jul 2022 10:58:06 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-sgx@vger.kernel.org
Subject: Re: [PATCH] x86/sgx: Improve comments for
 sgx_encl_lookup/alloc_backing()
Message-ID: <YuJBjq/4dALm//rf@kernel.org>
References: <20220720182120.1160956-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720182120.1160956-1-kristen@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 11:21:19AM -0700, Kristen Carlson Accardi wrote:
> Modify the comments for sgx_encl_lookup_backing() and for
> sgx_encl_alloc_backing() to indicate that they take a reference
> which must be dropped with a call to sgx_encl_put_backing().
> Make sgx_encl_lookup_backing() static for now, and change the
> name of sgx_encl_get_backing() to __sgx_encl_get_backing() to
> make it more clear that sgx_encl_get_backing() is an internal
> function.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>

The rename is unnecessary.

> ---
>  arch/x86/kernel/cpu/sgx/encl.c | 21 ++++++++++++++-------
>  arch/x86/kernel/cpu/sgx/encl.h |  2 --
>  2 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> index 19876ebfb504..325c2d59e6b4 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -12,6 +12,9 @@
>  #include "encls.h"
>  #include "sgx.h"
>  
> +static int sgx_encl_lookup_backing(struct sgx_encl *encl, unsigned long page_index,
> +			    struct sgx_backing *backing);
> +
>  #define PCMDS_PER_PAGE (PAGE_SIZE / sizeof(struct sgx_pcmd))
>  /*
>   * 32 PCMD entries share a PCMD page. PCMD_FIRST_MASK is used to
> @@ -706,7 +709,7 @@ static struct page *sgx_encl_get_backing_page(struct sgx_encl *encl,
>  }
>  
>  /**
> - * sgx_encl_get_backing() - Pin the backing storage
> + * __sgx_encl_get_backing() - Pin the backing storage
>   * @encl:	an enclave pointer
>   * @page_index:	enclave page index
>   * @backing:	data for accessing backing storage for the page
> @@ -718,7 +721,7 @@ static struct page *sgx_encl_get_backing_page(struct sgx_encl *encl,
>   *   0 on success,
>   *   -errno otherwise.
>   */
> -static int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
> +static int __sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
>  			 struct sgx_backing *backing)
>  {
>  	pgoff_t page_pcmd_off = sgx_encl_get_backing_page_pcmd_offset(encl, page_index);
> @@ -794,7 +797,7 @@ static struct mem_cgroup *sgx_encl_get_mem_cgroup(struct sgx_encl *encl)
>  }
>  
>  /**
> - * sgx_encl_alloc_backing() - allocate a new backing storage page
> + * sgx_encl_alloc_backing() - create a new backing storage page
>   * @encl:	an enclave pointer
>   * @page_index:	enclave page index
>   * @backing:	data for accessing backing storage for the page
> @@ -802,7 +805,9 @@ static struct mem_cgroup *sgx_encl_get_mem_cgroup(struct sgx_encl *encl)
>   * When called from ksgxd, sets the active memcg from one of the
>   * mms in the enclave's mm_list prior to any backing page allocation,
>   * in order to ensure that shmem page allocations are charged to the
> - * enclave.
> + * enclave.  Create a backing page for loading data back into an EPC page with
> + * ELDU.  This function takes a reference on a new backing page which
> + * must be dropped with a corresponding call to sgx_encl_put_backing().
>   *
>   * Return:
>   *   0 on success,
> @@ -815,7 +820,7 @@ int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long page_index,
>  	struct mem_cgroup *memcg = set_active_memcg(encl_memcg);
>  	int ret;
>  
> -	ret = sgx_encl_get_backing(encl, page_index, backing);
> +	ret = __sgx_encl_get_backing(encl, page_index, backing);
>  
>  	set_active_memcg(memcg);
>  	mem_cgroup_put(encl_memcg);
> @@ -833,15 +838,17 @@ int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long page_index,
>   * It is the caller's responsibility to ensure that it is appropriate to use
>   * sgx_encl_lookup_backing() rather than sgx_encl_alloc_backing(). If lookup is
>   * not used correctly, this will cause an allocation which is not accounted for.
> + * This function takes a reference on an existing backing page which must be
> + * dropped with a corresponding call to sgx_encl_put_backing().
>   *
>   * Return:
>   *   0 on success,
>   *   -errno otherwise.
>   */
> -int sgx_encl_lookup_backing(struct sgx_encl *encl, unsigned long page_index,
> +static int sgx_encl_lookup_backing(struct sgx_encl *encl, unsigned long page_index,
>  			   struct sgx_backing *backing)
>  {
> -	return sgx_encl_get_backing(encl, page_index, backing);
> +	return __sgx_encl_get_backing(encl, page_index, backing);
>  }
>  
>  /**
> diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
> index 332ef3568267..d731ef53f815 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.h
> +++ b/arch/x86/kernel/cpu/sgx/encl.h
> @@ -106,8 +106,6 @@ int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
>  bool current_is_ksgxd(void);
>  void sgx_encl_release(struct kref *ref);
>  int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm);
> -int sgx_encl_lookup_backing(struct sgx_encl *encl, unsigned long page_index,
> -			    struct sgx_backing *backing);
>  int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long page_index,
>  			   struct sgx_backing *backing);
>  void sgx_encl_put_backing(struct sgx_backing *backing);
> -- 
> 2.36.1
> 

BR, JArkko
