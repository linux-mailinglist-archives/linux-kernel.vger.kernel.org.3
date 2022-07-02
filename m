Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2026556423B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 21:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiGBTAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 15:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiGBS77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 14:59:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F4C63CA;
        Sat,  2 Jul 2022 11:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656788399; x=1688324399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=liQng1oi5pVFzQvSZ7Grrfdjo3Vt/r0DpAmqCyflPt8=;
  b=GmiEvPpzcgwd2MUqXiZa4kz9Kq0uAoz3/6ccp4S8NcAtv6n30wQqxuYQ
   9KqNdccACtUVdgUxtX78PWGgcRjdGCnY/788BTV2hQohRxbu4IYwMUAF1
   xcz5Rxm2oqvr2FXxHX1SqCIlHeBm76AiZ52KVSXL6HG45a+XmcM/Rfw6I
   MKs//01fJLWV44xJQZZqnWrjBKEbqN9VPaAfVQ+sQk9t7Li+eoDV5K7uA
   8ajf3ffUwGKhZ/Tv3+eFiFFgP9Nx/ObsKKXLru8L2uwlO2ksy6KMaMWI2
   1vuoFEWY+cbweK8oB2G1/7wuJm9nd1cmUbXavHKRM0uc0l/NhXa2UPMDn
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="282893153"
X-IronPort-AV: E=Sophos;i="5.92,240,1650956400"; 
   d="scan'208";a="282893153"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 11:59:58 -0700
X-IronPort-AV: E=Sophos;i="5.92,240,1650956400"; 
   d="scan'208";a="718968459"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 11:59:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o7iLP-0013q3-0M;
        Sat, 02 Jul 2022 21:59:51 +0300
Date:   Sat, 2 Jul 2022 21:59:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        vneethv@linux.ibm.com, oberpar@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        almaz.alexandrovich@paragon-software.com, yury.norov@gmail.com,
        linux@rasmusvillemoes.dk, linux-s390@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 3/4] bitmap: Introduce bitmap_size()
Message-ID: <YsCVpifccOebP3Ot@smile.fi.intel.com>
References: <cover.1656785856.git.christophe.jaillet@wanadoo.fr>
 <98f5d3d855a9c687ccc035edf62016b02a6876b7.1656785856.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98f5d3d855a9c687ccc035edf62016b02a6876b7.1656785856.git.christophe.jaillet@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 02, 2022 at 08:29:36PM +0200, Christophe JAILLET wrote:
> The new bitmap_size() function returns the size, in bytes, of a bitmap.
> 
> Remove the already existing bitmap_size() functions and macro in some
> files.
> These files already use the bitmap API and will use the new function
> in bitmap.h automatically.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/md/dm-clone-metadata.c | 5 -----
>  include/linux/bitmap.h         | 6 ++++++
>  lib/math/prime_numbers.c       | 2 --
>  3 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/md/dm-clone-metadata.c b/drivers/md/dm-clone-metadata.c
> index c43d55672bce..47c1fa7aad8b 100644
> --- a/drivers/md/dm-clone-metadata.c
> +++ b/drivers/md/dm-clone-metadata.c
> @@ -465,11 +465,6 @@ static void __destroy_persistent_data_structures(struct dm_clone_metadata *cmd)
>  
>  /*---------------------------------------------------------------------------*/
>  
> -static size_t bitmap_size(unsigned long nr_bits)
> -{
> -	return BITS_TO_LONGS(nr_bits) * sizeof(long);
> -}
> -
>  static int __dirty_map_init(struct dirty_map *dmap, unsigned long nr_words,
>  			    unsigned long nr_regions)
>  {
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index f091a1664bf1..f66fb98a4126 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -48,6 +48,7 @@ struct device;
>   *  bitmap_equal(src1, src2, nbits)             Are *src1 and *src2 equal?
>   *  bitmap_intersects(src1, src2, nbits)        Do *src1 and *src2 overlap?
>   *  bitmap_subset(src1, src2, nbits)            Is *src1 a subset of *src2?
> + *  bitmap_size(nbits)                          Size, in bytes, of a bitmap
>   *  bitmap_empty(src, nbits)                    Are all bits zero in *src?
>   *  bitmap_full(src, nbits)                     Are all bits set in *src?
>   *  bitmap_weight(src, nbits)                   Hamming Weight: number set bits
> @@ -124,6 +125,11 @@ unsigned long *bitmap_alloc_node(unsigned int nbits, gfp_t flags, int node);
>  unsigned long *bitmap_zalloc_node(unsigned int nbits, gfp_t flags, int node);
>  void bitmap_free(const unsigned long *bitmap);
>  
> +static __always_inline size_t bitmap_size(unsigned long nbits)
> +{
> +	return BITS_TO_LONGS(nbits) * sizeof(unsigned long);
> +}
> +
>  /* Managed variants of the above. */
>  unsigned long *devm_bitmap_alloc(struct device *dev,
>  				 unsigned int nbits, gfp_t flags);
> diff --git a/lib/math/prime_numbers.c b/lib/math/prime_numbers.c
> index d42cebf7407f..d3b64b10da1c 100644
> --- a/lib/math/prime_numbers.c
> +++ b/lib/math/prime_numbers.c
> @@ -6,8 +6,6 @@
>  #include <linux/prime_numbers.h>
>  #include <linux/slab.h>
>  
> -#define bitmap_size(nbits) (BITS_TO_LONGS(nbits) * sizeof(unsigned long))
> -
>  struct primes {
>  	struct rcu_head rcu;
>  	unsigned long last, sz;
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko


