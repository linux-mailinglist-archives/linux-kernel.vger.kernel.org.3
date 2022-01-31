Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A8F4A4845
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 14:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378120AbiAaNgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 08:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377496AbiAaNgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 08:36:15 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D49C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 05:36:14 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id b5so11365393qtq.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 05:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PEer8tHTGOMBB45BNBliWIb1NwPck3iboeLwpq12AUQ=;
        b=GAZFseV/rySaS1H2s/o7SLuHE6htq36AAAz2Gg5dLp+rLpPCZJ8owShGHKizWzYrfK
         lj4d2iowhMaamMT6sMCIyVDaAvAYhVAOwKj9VoTMWDbf7fYPRcekJyVouJgxocp4hSyN
         ASGbJDEm6ZyQgGb7g1OiLCdKOXrscvCkhaLtDsLYVCdER06z5XbrCJYLJ7/C1Tcadi6j
         lSI4ACyvSzq0dpW/CdWeg4yMIDOE6QdCcEfHuYZWS4U58Ig3Dr3IKuEWAHiSyBa20eRD
         j93VpppgeW+YfpZxFPoyFc141sSMloI9rS+8prqata9kfhkNfBWkZf3xkKNuFX2rJYNL
         cvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PEer8tHTGOMBB45BNBliWIb1NwPck3iboeLwpq12AUQ=;
        b=BgyCX7dw+dpHrmnWzHzuyzTUQQ6pv466d6I38HI1TWf+gBF/269EexSluUdzxBPj5l
         VtMaUDfDRmm1XUouv3aGbXE5fM3YB6ERdRTtO31PUAhHltiTewglZKK+D1p0RqmHv3z8
         7MqwFdNZWqZPnpDhfooXpO+Zj+RBqXOQo4/HBSF4rbtkEzfHtu7A0Ij1X4TOxBrl7tMO
         zDLhbOTtamt73MEuuJbZRMGmvAg7Xj9HeadWDeRj2a9uprREeolDtYCVOLuvvR8yj4Xv
         +hFaJ+73hGC0qcavaxsEYHGg14IVqWJbhFeIfJW2SETWUJ38u//RgGy+UuG5dRvsdH2F
         AZBg==
X-Gm-Message-State: AOAM530hCVC0s5YC6W7etrQK5mwrTbzgJ7KFxjHB5YrydYXB1dyeEBLK
        X5R8V+v6w8t70Ctp4BB2oMKSS56bxARRdg==
X-Google-Smtp-Source: ABdhPJwF3X98hpIKB/fiNvdtbcy0R31qGPlzKjuu4Xpol+RF/9z+GewqMbOrv/sUSLPFKbaWj56Kxw==
X-Received: by 2002:a05:622a:13ca:: with SMTP id p10mr14925312qtk.294.1643636173870;
        Mon, 31 Jan 2022 05:36:13 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id 22sm8132398qtw.75.2022.01.31.05.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 05:36:13 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nEWqq-009WAO-6O; Mon, 31 Jan 2022 09:36:12 -0400
Date:   Mon, 31 Jan 2022 09:36:12 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH 4/4] mm/gup: remove get_user_pages_locked()
Message-ID: <20220131133612.GW8034@ziepe.ca>
References: <20220131051752.447699-1-jhubbard@nvidia.com>
 <20220131051752.447699-5-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131051752.447699-5-jhubbard@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 09:17:52PM -0800, John Hubbard wrote:

> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 028e8dd82b44..040d88354cfa 100644
> +++ b/mm/mempolicy.c
> @@ -907,17 +907,15 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
>  static int lookup_node(struct mm_struct *mm, unsigned long addr)
>  {
>  	struct page *p = NULL;
> -	int err;
> +	int ret;
>  
> -	int locked = 1;
> -	err = get_user_pages_locked(addr & PAGE_MASK, 1, 0, &p, &locked);
> -	if (err > 0) {
> -		err = page_to_nid(p);
> +	mmap_assert_locked(mm);
> +	ret = get_user_pages(addr & PAGE_MASK, 1, 0, &p, NULL);
> +	if (ret > 0) {
> +		ret = page_to_nid(p);
>  		put_page(p);
>  	}
> -	if (locked)
> -		mmap_read_unlock(mm);
> -	return err;
> +	return ret;
>  }
>  
>  /* Retrieve NUMA policy */
> @@ -968,15 +966,15 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
>  	if (flags & MPOL_F_NODE) {
>  		if (flags & MPOL_F_ADDR) {
>  			/*
> -			 * Take a refcount on the mpol, lookup_node()
> -			 * will drop the mmap_lock, so after calling
> -			 * lookup_node() only "pol" remains valid, "vma"
> -			 * is stale.
> +			 * Take a refcount on the mpol, because we are about to
> +			 * drop the mmap_lock, after which only "pol" remains
> +			 * valid, "vma" is stale.
>  			 */
>  			pol_refcount = pol;
>  			vma = NULL;
>  			mpol_get(pol);
>  			err = lookup_node(mm, addr);
> +			mmap_read_unlock(mm);

How about move the mmap_read_unlock up one line and then use
get_user_pages_fast()

I'm guessing in most cases here the PTE will be present so that should
be a net win?

Jason
