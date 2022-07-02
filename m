Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A085642D7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 23:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiGBVJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 17:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGBVJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 17:09:50 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E097CCE11;
        Sat,  2 Jul 2022 14:09:48 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id ay10so4604776qtb.1;
        Sat, 02 Jul 2022 14:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sMAa2iLeQqiv/ZzIKaEzdmiyv2BKPN4LO2LUx74OXts=;
        b=m18PMx31hmpb4aT7yth5E3CbYLi3DwmkYIRaW47Wq3NEoZczWpELX64VbD8MhDBcX+
         muWK9mmb3aSQCO0DanD5EDnguObkhZo4aowDnd2lhQwjTOaK25PhnzDMGQf5pB/7tRol
         wCNTF6SWXp+7A8W3wg0FR0VyrLmn1nPJlT8sVJHw9n2EI5SPtPSqUNbm5L3BkgXLRrwr
         a5hbqN6den7jWyKCoYewy3gPVp/wLfv+cxUnR7CIbUXrvxxWEmGHXOoVu2FhkzYuQ4n1
         An8JgxJcPJjzAK4m0bov1KpkSNlskFq5K0BqaK2APPJwq02qj+cMgu68CJGyp5x04H46
         E2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sMAa2iLeQqiv/ZzIKaEzdmiyv2BKPN4LO2LUx74OXts=;
        b=Vui61bX8YkgCfrTr05Cbs8cnR1PsnTYBuASOde77vVZTBQS4CAPPn3symi4RJ71z1E
         gdorBuMm6S3RD90Zy4TPQp+hNd4WK452nBTzdQOQzD9GBms3VykWEAfplG1kyfsf9Wqu
         wrhX5D9YidKn7Idc25alzQOMcfZOoIfbXyoTjonYLP7Fmb8E1Jf9O0rnoQVavpTdgShn
         XFYVqrhouK0UQpgaxIkAPH20OQH3RZUFXjCJNNwC+pO4ot83OkjNCfjWY3Py/7mv1U/A
         f57RBsOQT1rpE8JqfEZxPqB29XOExB3fKq18O61qhwQV4EzZarJKIXid+eprIcfJ4lua
         Bfkg==
X-Gm-Message-State: AJIora9HGJchihZ6XXjlRO154aYQ7uT3uqI9siLGpkAvT8W9p5zNa81q
        oHpQJypz2h7TCQlSzZpWtaw=
X-Google-Smtp-Source: AGRyM1vI0vuCSLmgu6ot91FWxWNvpuMeLByWm6OnSRKXaOezOBQwCg2H7Y1rdlq+T8yiEhPqf1YmXg==
X-Received: by 2002:a05:622a:1104:b0:31d:2a1c:a4fb with SMTP id e4-20020a05622a110400b0031d2a1ca4fbmr14927580qty.327.1656796187972;
        Sat, 02 Jul 2022 14:09:47 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:e838:b1c2:b125:986a])
        by smtp.gmail.com with ESMTPSA id c3-20020ac84e03000000b00304f55e56e4sm17032646qtw.40.2022.07.02.14.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 14:09:47 -0700 (PDT)
Date:   Sat, 2 Jul 2022 14:09:46 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        vneethv@linux.ibm.com, oberpar@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        almaz.alexandrovich@paragon-software.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        linux-s390@vger.kernel.org, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 3/4] bitmap: Introduce bitmap_size()
Message-ID: <YsC0GpltMVaCPhkJ@yury-laptop>
References: <cover.1656785856.git.christophe.jaillet@wanadoo.fr>
 <98f5d3d855a9c687ccc035edf62016b02a6876b7.1656785856.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98f5d3d855a9c687ccc035edf62016b02a6876b7.1656785856.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
> 
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

This should be dropped, for sure, and kmalloc() at line 128 should be
replaced with bitmap_alloc().

For the driver, we need to introduce bitmap_kvmalloc/bitmap_kvfree etc. 

>  struct primes {
>  	struct rcu_head rcu;
>  	unsigned long last, sz;
> -- 
> 2.34.1
