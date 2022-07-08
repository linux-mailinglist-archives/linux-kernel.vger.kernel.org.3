Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD6856BC62
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 17:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238055AbiGHOij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbiGHOih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:38:37 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBCE17046
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 07:38:36 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id s16-20020a0568301c7000b0061c283d6c37so1374165otg.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 07:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jzhpCqh+Xn1+gXpi3kqOG96KCWE5A2eFiSKTN7tBjLo=;
        b=Gs0V9VjgliuX8I571Q0l4ucdJ9eA2538iLkVuuYNziG8X94hqHrU/8Gksc/luQg2WG
         kFlCXLU9tp8HvM98nUK+8QO22KuUOLhM7BIfTKR9FMlT1QpI8YLtg/IDJtOSQKhDGsc9
         50D8Fmrn+ysmVSpvPXVvfoSjTw/j4BMxdAkOtZMUO0MT2ocwGbc1z8hHWYFNeb35sVOW
         ziy4XBQx588hLe+PVw48WKKXYhkGHMGZ1w5HTx3UXyUmuIms7JN050cnZmtPyC+mBkyN
         91tgE3d7bnlZ8EX2QE3QlOeZU9OJ00wYZ6E88nzQ6Ci2Lh4gQHjqoHrZl/xZDv3wd6yJ
         z1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jzhpCqh+Xn1+gXpi3kqOG96KCWE5A2eFiSKTN7tBjLo=;
        b=LyXBHu3ucAhotMR3yH/xHV/BkXVLDUZ/LdyuY3rAYJlu/28Z2VNB81+k8Em7/uwf8e
         6gjzOBJXg5HWHpPRP1teh5PxZ3iNc89UYwXJe3/8lcrQDLpoeaEJ+/Kh2KNO6UvDPIbo
         BI7eEiA33v93rimkpD/Bs3UJHRwHbSIi8x25UN3o7WAeOyqbS9EUQ2pAwvn1RjFIF9iv
         HiPHvECQA2MjQdDYv8s24JP+LASCGnYxsh1nfqhnwGCTsBNZxAUao7xbWdbvp9dhxk60
         CsIYcgogSq7toSC82lbKw8EQ13CM7DSd4r8ZtK7n+4pxF25bM4kAJym4BPYWDn7IMCLz
         KALA==
X-Gm-Message-State: AJIora8Te7CgD9fZpAaksDLnIsj+OfJAWgZr8z2eNVy979ndZ9O+bD5X
        BEYZuQJi2SaBGc3SnKRks+iy81nysEfGew==
X-Google-Smtp-Source: AGRyM1sCJC5ARnj2EK3Cdme1qxyNVBiyvFcfMlbwxAjiEaijAj9HPgpq9WcmALbTCUntGJKHz6k6qw==
X-Received: by 2002:a05:6830:4422:b0:616:ef53:918c with SMTP id q34-20020a056830442200b00616ef53918cmr1708725otv.151.1657291115941;
        Fri, 08 Jul 2022 07:38:35 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id b132-20020aca348a000000b003357568e39fsm12492522oia.57.2022.07.08.07.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 07:38:35 -0700 (PDT)
Date:   Fri, 8 Jul 2022 07:38:35 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lib/bitmap: Make parameter len unsigned
Message-ID: <YshBa/87hSAZwIP3@yury-laptop>
References: <20220708075239.9057-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708075239.9057-1-pmenzel@molgen.mpg.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 09:52:40AM +0200, Paul Menzel wrote:
> The length is non-negative, so make it unsigned.
> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

Hi Paul,

Can you please tell more about your motivation for fixing
__bitmap_set? The following __bitmap_clear has the same problem,
and bitmap_parse{,_user}, and bitmap_print_to_pagebuf, and
bitmap_parselist...

Is there a particular problem that is resolved after fixing
__bitmap_set()?

I'm OK if this is a single patch, but for a cleanup work it would 
be more logical to clean everything in a single patch/series...

Thanks,
Yury

> ---
> v2: Update signature in header file
> 
>  include/linux/bitmap.h | 2 +-
>  lib/bitmap.c           | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 2e6cd5681040..feaf84cbc487 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -164,7 +164,7 @@ bool __bitmap_intersects(const unsigned long *bitmap1,
>  bool __bitmap_subset(const unsigned long *bitmap1,
>  		     const unsigned long *bitmap2, unsigned int nbits);
>  int __bitmap_weight(const unsigned long *bitmap, unsigned int nbits);
> -void __bitmap_set(unsigned long *map, unsigned int start, int len);
> +void __bitmap_set(unsigned long *map, unsigned int start, unsigned int len);
>  void __bitmap_clear(unsigned long *map, unsigned int start, int len);
>  
>  unsigned long bitmap_find_next_zero_area_off(unsigned long *map,
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index b18e31ea6e66..0746beb336df 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -348,14 +348,14 @@ int __bitmap_weight(const unsigned long *bitmap, unsigned int bits)
>  }
>  EXPORT_SYMBOL(__bitmap_weight);
>  
> -void __bitmap_set(unsigned long *map, unsigned int start, int len)
> +void __bitmap_set(unsigned long *map, unsigned int start, unsigned int len)
>  {
>  	unsigned long *p = map + BIT_WORD(start);
>  	const unsigned int size = start + len;
>  	int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
>  	unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
>  
> -	while (len - bits_to_set >= 0) {
> +	while (len >= bits_to_set) {
>  		*p |= mask_to_set;
>  		len -= bits_to_set;
>  		bits_to_set = BITS_PER_LONG;
> -- 
> 2.36.1
