Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F111A49821D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238382AbiAXO1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:27:33 -0500
Received: from mga01.intel.com ([192.55.52.88]:61621 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238295AbiAXO1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643034452; x=1674570452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j2z/GmNDeCOiVJHcgh+l/bMe+jvLITsYaovOpxRgCec=;
  b=hlMfD539qiMfRLYrQACYhf0nWfRfNUkr2TAb4mw/30hHw4H7POe4RZbb
   mcTXVS5UtoVaMXJbz7KCDoUjKMi5WRpaYVf0lwYT69RbEzoE8kQWqwIK/
   7vgKlLnzoX+fbO26sOhd9C3nQFtUgv73O242b34cu1tI4SbxnATe/YRji
   x70OrswNfHKkPZD5EXJGKfiKC+u2shFeXCZGJ0mV5szoluBpIWItmS5ZY
   dtiRZLzIkgCSfUVqKVPqtUg69i9zvRYqe7WMiG0MZJB3F2jz6FEMYjMlO
   raN5BRBMOTDk1WIH4DUPzDcTX17TeVbA1aAAyrvopF9SiMXWVeIjJpUAa
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="270491672"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="270491672"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 06:27:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="532093032"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 06:27:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1nC0IZ-00DvFO-6W;
        Mon, 24 Jan 2022 16:26:23 +0200
Date:   Mon, 24 Jan 2022 16:26:22 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] lib/string_helpers: Use the given gfp flag when
 allocating memory
Message-ID: <Ye63DkOZkBd2j+8+@smile.fi.intel.com>
References: <1ec96b6e4f2e35599931d7516c6938c4a8845bf0.1642337606.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ec96b6e4f2e35599931d7516c6938c4a8845bf0.1642337606.git.christophe.jaillet@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2022 at 01:53:37PM +0100, Christophe JAILLET wrote:
> kstrdup_quotable_cmdline() and kstrdup_quotable_file() are given a gfp flag
> that is passed and used for memory allocation in kstrdup_quotable() just a
> few lines below.
> 
> It looks reasonable to use this gfp value for the buffer allocated and
> freed in these functions as well.

Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>

> Fixes: 0ee931c4e31a ("mm: treewide: remove GFP_TEMPORARY allocation flag")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> According to what I've found in 5.16, all callers use GFP_KERNEL, so this
> patch should be a no-op.
> But who knows how it will be used in the future. Better safe than sorry.
> 
> v2: Add the change for kstrdup_quotable_file()
> ---
>  lib/string_helpers.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/string_helpers.c b/lib/string_helpers.c
> index 90f9f1b7afec..4433e486b725 100644
> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -624,7 +624,7 @@ char *kstrdup_quotable_cmdline(struct task_struct *task, gfp_t gfp)
>  	char *buffer, *quoted;
>  	int i, res;
>  
> -	buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	buffer = kmalloc(PAGE_SIZE, gfp);
>  	if (!buffer)
>  		return NULL;
>  
> @@ -660,7 +660,7 @@ char *kstrdup_quotable_file(struct file *file, gfp_t gfp)
>  		return kstrdup("<unknown>", gfp);
>  
>  	/* We add 11 spaces for ' (deleted)' to be appended */
> -	temp = kmalloc(PATH_MAX + 11, GFP_KERNEL);
> +	temp = kmalloc(PATH_MAX + 11, gfp);
>  	if (!temp)
>  		return kstrdup("<no_memory>", gfp);
>  
> -- 
> 2.32.0
> 

-- 
With Best Regards,
Andy Shevchenko


