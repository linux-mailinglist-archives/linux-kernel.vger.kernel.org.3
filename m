Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7493353E7C4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240184AbiFFO6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240160AbiFFO6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:58:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9137D30412A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654527518; x=1686063518;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZNGIvjqpmlDYzUKrh1+1a2On//tfYpryieh9Ca4FwWk=;
  b=HfBPmxAFFNdH6i+/9jht4FoWX+/73t4jDUcwuSryPA2bSukfuNYlFxqg
   9NJ+kO0INSjDqXEPNo9UKHgEkmuJcRao3nxLQoIVvxayw7mkA0FyWN5kL
   2vKVP5O5tW1WOWlmIs9CV04T97YtO7ZQmEmsCh31Eq87+0CdekUeURH2T
   /S0ydxrzMdNk+IZJ403xfqHTDCVmfefNuneKKnq5KJGpbHRVS88PZ+OH7
   /3AJEJyv2Fs22EJOHnTZJ+NvrMnqRk69a7NIWLKGFWcxsNVtnS12A+3z9
   Wu4c/9CxxHRQxZeyTpE6BjbpgrRPPYDGHICTmnmKFHVMgaYPy0FwtQNlb
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="276705415"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="276705415"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 07:58:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635637630"
Received: from ypchen-mobl.amr.corp.intel.com (HELO localhost) ([10.213.189.170])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 07:58:37 -0700
Date:   Mon, 6 Jun 2022 07:58:37 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm/highmem: Delete memmove_page()
Message-ID: <Yp4WHZpaiU9XiVuk@iweiny-desk3>
References: <20220606141533.555-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606141533.555-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 04:15:33PM +0200, Fabio M. De Francesco wrote:
> Matthew Wilcox reported that, while he was looking at memmove_page(), he
> realized that it can't actually work.
> 
> The reasons are hidden in its implementation, which makes use of
> memmove() on logical addresses provided by kmap_local_page(). memmove()
> does the wrong thing when it tests "if (dest <= src)".
> 
> Therefore, delete memmove_page().
> 
> No need to change any other code because we have no call sites of
> memmove_page() across the whole kernel.
> 
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Cc: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  include/linux/highmem.h | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 3af34de54330..fee9835e3793 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -336,19 +336,6 @@ static inline void memcpy_page(struct page *dst_page, size_t dst_off,
>  	kunmap_local(dst);
>  }
>  
> -static inline void memmove_page(struct page *dst_page, size_t dst_off,
> -			       struct page *src_page, size_t src_off,
> -			       size_t len)
> -{
> -	char *dst = kmap_local_page(dst_page);
> -	char *src = kmap_local_page(src_page);
> -
> -	VM_BUG_ON(dst_off + len > PAGE_SIZE || src_off + len > PAGE_SIZE);
> -	memmove(dst + dst_off, src + src_off, len);
> -	kunmap_local(src);
> -	kunmap_local(dst);
> -}
> -
>  static inline void memset_page(struct page *page, size_t offset, int val,
>  			       size_t len)
>  {
> -- 
> 2.36.1
> 
