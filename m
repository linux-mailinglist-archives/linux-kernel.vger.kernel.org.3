Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2431467DF2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 20:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353443AbhLCTTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 14:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353268AbhLCTTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 14:19:44 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2883C061751;
        Fri,  3 Dec 2021 11:16:19 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id d2so4471730qki.12;
        Fri, 03 Dec 2021 11:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8+quDEBJRdJI/Z6t29sUnr7gPjN+HY0Tch32C7+so7w=;
        b=W1qLwwc+3sdyplUMLfSyxoZULmzJJ/iki1m423ixJL0CvRNm2jDtZLEI5iSHbBJA4z
         AbyLJahHiJ5mB7RiCYf8rfxm0w9pPdFnNu6cenVt3WhROObR5UCPaQ8ITneQHWT1TzWv
         oz+M0jak7tiFDuHp3jDO6ldzyxgAdFADchNWzqGbBIhzVepFKE/NF2e5GjUCv6hAZvOn
         C5BJ8Rhkj7H0nzOnGc4h7h+KTDKCxsZ2+a1sz2OmTTX6VEVvl6DMnAXgu+ld3Mszfx8U
         6ky+3o7dWaKYdGV9+Gm5VgjZZBY8lwg8JlwOZxA1UnSMYQ7ikVBnCsc3UnGiCNzEhuBq
         Ub6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8+quDEBJRdJI/Z6t29sUnr7gPjN+HY0Tch32C7+so7w=;
        b=CYyK6E3mXBxXpUaXnyPeWVWkGQaMXCNAABp8JCfjzLKQl/FlcuOkq8LN93wlCMdILn
         stN8T0rAbYcIW/Bd+s7NlkYKwbPfHYRk7L2Xg3vR+2RUBfQaCZVdiA3WkixG7e7x3rrO
         3hSkOdUUIQJFKENnKXRpAhR8opITVT13ImUfhyFBAVNkG0UPo0dBx449do9l62udadgk
         8DkSiZl6DWc3NcryMUnxqmnfHe1uY9YPbN6DjmIU4gCFJykZbpihALWh53+2jprMIzCd
         Lvz3r/EBixG0l19kJFnaAl0bXjObXnH5tEqTWbUppQySVUfR827EC2qiEgzRyOLYMH0P
         l6UQ==
X-Gm-Message-State: AOAM531Pkmcms9ZzOGZGeI0Giq3El7rGJv+QTyJ4KTdZeu66amLTyqhl
        gnOORjSAVsRAehq607xLMxVdnhZir5U=
X-Google-Smtp-Source: ABdhPJxztxxvRjgB117a1KLd833IB7xR8BZL5C9+gd6w5ILGqNxKwGfz9VcX5tbAPKDZ4S+b6ZYe5A==
X-Received: by 2002:a05:620a:ed0:: with SMTP id x16mr19175929qkm.750.1638558978883;
        Fri, 03 Dec 2021 11:16:18 -0800 (PST)
Received: from localhost ([66.216.211.25])
        by smtp.gmail.com with ESMTPSA id i14sm2671167qko.9.2021.12.03.11.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 11:16:18 -0800 (PST)
Date:   Fri, 3 Dec 2021 11:16:11 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH] find: Do not read beyond variable boundaries on small
 sizes
Message-ID: <20211203191611.GB450223@lapt>
References: <20211203100846.3977195-1-keescook@chromium.org>
 <YaoN6wnNezMvyyd5@smile.fi.intel.com>
 <E1A4953A-8801-48FA-A744-63DA548C5924@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1A4953A-8801-48FA-A744-63DA548C5924@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 08:37:59AM -0800, Kees Cook wrote:
> 
> 
> On December 3, 2021 4:30:35 AM PST, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >On Fri, Dec 03, 2021 at 02:08:46AM -0800, Kees Cook wrote:
> >> It's common practice to cast small variable arguments to the find_*_bit()
> >
> >It's a bad practice and should be fixed accordingly, no?
> 
> There's an argument to be made that the first arg should be void * but that's a pretty invasive change at this point (and orthogonal to this fix).

What for? To save at most 7 bytes of alignment overhead for bitmaps
like char bitmap[sizeof(unsigned long) + 1]?
 
> I'd be happy to send a treewide change for that too, if folks wanted?

For small arrays of bits that are fraction of machine word we have
ffs/fls/ffz. For long bitmaps, the alignment overhead is not that
important - at least nobody complained.

If we convert bitmaps to void*, it would mean that we'd handle tails
just like you did in this patch. The __find_bits_deref()-style function
should be also called from each lib/bitmap.c function together with
store() analogue, and overall impact would barely be positive.

Char-aligned bitmaps would be traversed less efficient than word-aligned
on most architectures, and we'll have the same problems that memcpy() has. 

Thanks,
Yury

> >> helpers to unsigned long and then use a size argument smaller than
> >> sizeof(unsigned long):
> >> 
> >> 	unsigned int bits;
> >> 	...
> >> 	out = find_first_bit((unsigned long *)&bits, 32);
> >> 
> >> This leads to the find helper dereferencing a full unsigned long,
> >> regardless of the size of the actual variable. The unwanted bits
> >> get masked away, but strictly speaking, a read beyond the end of
> >> the target variable happens. Builds under -Warray-bounds complain
> >> about this situation, for example:
> >> 
> >> In file included from ./include/linux/bitmap.h:9,
> >>                  from drivers/iommu/intel/iommu.c:17:
> >> drivers/iommu/intel/iommu.c: In function 'domain_context_mapping_one':
> >> ./include/linux/find.h:119:37: error: array subscript 'long unsigned int[0]' is partly outside array bounds of 'int[1]' [-Werror=array-bounds]
> >>   119 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
> >>       |                                     ^~~~~
> >> drivers/iommu/intel/iommu.c:2115:18: note: while referencing 'max_pde'
> >>  2115 |         int pds, max_pde;
> >>       |                  ^~~~~~~
> >> 
> >> Instead, just carefully read the correct variable size, all of which
> >> happens at compile time since small_const_nbits(size) has already
> >> determined that arguments are constant expressions.
> >
> >What is the performance impact?
> 
> There should be none. It's entirely using constant expressions, so all of it gets reduce at compile time to a single path without conditionals. The spot checks I did on the machine code showed no differences either (since I think optimization was doing the masking vis smaller width dereference).
> 
> 
> >
> 
> -- 
> Kees Cook
