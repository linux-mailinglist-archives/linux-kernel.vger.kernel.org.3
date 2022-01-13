Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F9E48D052
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 03:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiAMCAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 21:00:54 -0500
Received: from mga05.intel.com ([192.55.52.43]:10404 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231528AbiAMCAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 21:00:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642039253; x=1673575253;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yKzcsErOlaAl5BAEg+mgbVtS8VvF2vEozWEkVuvjUuM=;
  b=fuHvcGK17F+6Ct+a8P2227E7qlwPBYcYgoNKWezaIwRVUv8z5hlCF+5W
   iMn4rfu0hFULblphX+HnWNymhcAtEYrYvsZIlscmAXGqwmLC1sktit/Ko
   IPYOAhzanhSs7I10Up+0o6CYkrgArq0BZT8CGX8hKQ7YXIVlpV0Ok7E4t
   geai+pkauKQTMpEmpdIpEA7CTVW6At3gSHwS01NKSLmfHh3Avdri0hSmF
   E2SFtYZHy3+xaw3BDh6MpwY8pyGwS2tcJt98OQEUcuDUYRCoN4XHUKiNu
   kaPt0gel1TuRDCCmIXWhN8wbqao2y2L7kjHTJY251X2QNZsYLddoB2NgW
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="330254991"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="330254991"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 18:00:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="576780006"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 18:00:53 -0800
Date:   Wed, 12 Jan 2022 18:00:51 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Youquan Song <youquan.song@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: Re: [PATCH] mm/hwpoison: Fix error page recovered but reported "not
 recovered"
Message-ID: <Yd+H00eSqZb+RsTv@agluck-desk2.amr.corp.intel.com>
References: <20220107194450.1687264-1-tony.luck@intel.com>
 <20220112121145.GA889650@u2004>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112121145.GA889650@u2004>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 09:11:45PM +0900, Naoya Horiguchi wrote:
> On Fri, Jan 07, 2022 at 11:44:50AM -0800, Tony Luck wrote:
> > From: Youquan Song <youquan.song@intel.com>

> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 14ae5c18e776..4c9bd1d37301 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -707,8 +707,10 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
>  			      (void *)&priv);
>  	if (ret == 1 && priv.tk.addr)
>  		kill_proc(&priv.tk, pfn, flags);
> +	else
> +		ret = 0;
>  	mmap_read_unlock(p->mm);
> -	return ret ? -EFAULT : -EHWPOISON;
> +	return ret > 0 ? -EHWPOISON : -EFAULT;
>  }
>  
>  static const char *action_name[] = {

Yes. This fixes the problem (and your explanation helped
me understand this code better).

Fell free to take any words you need from the original patch
comment and switch to:

Reported-by: Youquan Song <youquan.song@intel.com>

Thanks for looking (and fixing!)

-Tony
