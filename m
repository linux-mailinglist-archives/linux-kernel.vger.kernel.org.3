Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19B4510AB2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355099AbiDZUqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350152AbiDZUqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:46:03 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D172D101182
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:42:52 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 79so2388418qkk.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aqCcCPy2TTed30QLn8GHBHjPh9iFg8qH41wvxMqtQq0=;
        b=KjxRbSwY7PmOZF72y1flS56BnwIhmKs7vJ5c8UyGGoeIBKBZzN9bth6k0mA1/zvWaJ
         kSWVEV0wFZ7KdyMzMFqd2ZypRfHQuW2JA5WWLW+5vOuh8hN+ep6752OqoQ2vVuPbOIJ0
         33p/GSzxvD9DXJDOVOayIndIwxCRIvuhF7bStivsRJXOKZen45TJVl9caD5Vq+jPbizU
         4//FSuGSxp7AwWNVpRTGaf6OhRyRiIRG0XH7b63cDMuRHheErtyBeMZ7+5ssAcQeI9kh
         hKqpVxqMwSJvyBg4NUEsECscDq8ZyNuIs4VTF7rKSNSCChsKJITllFyKC/13/3ZcBt7h
         5M3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aqCcCPy2TTed30QLn8GHBHjPh9iFg8qH41wvxMqtQq0=;
        b=tAbvHM5Ojo2u58XhE9jliSmUrPyeABIsPDkttTC+bt7HS97MUF4TwvQr+YgLDgtbj6
         tUMDrUmVfBvfOgkMPEiVfqSJA5vF2WzGmEOCGi123TU/616N52meDd25I38ceGK1B69a
         rmxvWjFmozOgxCLfczwohV22pJgpUb701UoTMATRBvenGT9DrjiN+cXz4zWNteNGsjm0
         DRmx+Zl4pCm5cBOZnqrkx015UscEnR5n0ZVyg6UaHaw+XfpepO3Hs7ey6XafWGDxbjwr
         aGPlrW3HEO6b2C5YrEcyuesaw0E23A+4KRNHkVW9pHv9Ea0ip5UritR1zHppsb28e7p0
         Xxbw==
X-Gm-Message-State: AOAM5333Xp88ewqe3KbdfEw/lu6bKBsoGA+NW4mhdUhcPppljij79d1d
        UV/8GbYeoub50gBa1dFYrY8=
X-Google-Smtp-Source: ABdhPJxUnfKJYzMFarhjolTfZCwBsFQOSo8RPgKG9GA+1KlQQLExQbXP2nrwBTmBQD5PuSwffdJCEg==
X-Received: by 2002:a05:620a:4625:b0:69f:6a9a:ccd5 with SMTP id br37-20020a05620a462500b0069f6a9accd5mr5330210qkb.626.1651005771686;
        Tue, 26 Apr 2022 13:42:51 -0700 (PDT)
Received: from localhost ([2601:c4:c432:bf1:e227:a1a1:faa3:ec7e])
        by smtp.gmail.com with ESMTPSA id y7-20020a05620a0e0700b00699a30d6d10sm6734033qkm.111.2022.04.26.13.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:42:50 -0700 (PDT)
Date:   Tue, 26 Apr 2022 13:42:49 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, gcc@gcc.gnu.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: Re: [PATCH] linux/find: ignore -Wtype-limits to reduce W=2 warnings
 by 34% tree-wide
Message-ID: <YmhZSZWg9YZZLRHA@yury-laptop>
References: <20220426161658.437466-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426161658.437466-1-mailhol.vincent@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ gcc@gcc.gnu.org
+ Rikard Falkeborn <rikard.falkeborn@gmail.com>

On Wed, Apr 27, 2022 at 01:16:58AM +0900, Vincent Mailhol wrote:
> find_first_bit(), find_first_and_bit(), find_first_and_bit() and
> find_first_and_bit() all invokes GENMASK(size - 1, 0).
> 
> This triggers below warning when compiled with W=2.
> 
> | ./include/linux/find.h: In function 'find_first_bit':
> | ./include/linux/bits.h:25:36: warning: comparison of unsigned
> | expression in '< 0' is always false [-Wtype-limits]
> |    25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
> |       |                                    ^
> | ./include/linux/build_bug.h:16:62: note: in definition of macro
> | 'BUILD_BUG_ON_ZERO'
> |    16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> |       |                                                              ^
> | ./include/linux/bits.h:25:17: note: in expansion of macro '__is_constexpr'
> |    25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
> |       |                 ^~~~~~~~~~~~~~
> | ./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> |    38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> |       |          ^~~~~~~~~~~~~~~~~~~
> | ./include/linux/find.h:119:45: note: in expansion of macro 'GENMASK'
> |   119 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
> |       |                                             ^~~~~~~
> 
> linux/find.h being a widely used header file, above warning show up in
> thousand of files which include this header (either directly on
> indirectly).
> 
> Because it is a false positive, we just silence -Wtype-limits flag
> locally to remove the spam. clang does not warn about it, so we just
> apply the diag_ignore() directive to gcc.
> 
> By doing so, the warnings for a W=2 build are reduced by
> 34%. Benchmark was done with gcc 11.2.1 on Linux v5.17 x86_64
> allyesconfig (except CONFIG_WERROR). Beforethe patch: 515496 warnings
> and after: 340097.
> 
> For reference, past proposal to modify GENMASK_INPUT_CHECK() was
> rejected in:
> https://lore.kernel.org/all/20220304124416.1181029-1-mailhol.vincent@wanadoo.fr/

So, here is nothing wrong with the kernel code and we have an alternative
compiler (clang) that doesn't throw Wtype-limits. It sounds to me like an
internal GCC problem, and I don't understand how hiding broken Wtype-limits
on kernel side would help people to improve GCC.

On the thread you mentioned above:

> > > > Have you fixed W=1 warnings?
> > > > Without fixing W=1 (which makes much more sense, when used with
> > > > WERROR=y && COMPILE_TEST=y) this has no value.
> > >
> > > How is this connected?
> >
> > By priorities.
> > I don't see much value in fixing W=2 per se if the code doesn't compile for W=1.
> 
> *My code* compiles for W=1. For me, fixing this W=2 in the next in line
> if speaking of priorities.
> 
> I do not understand why I should be forbidden to fix a W=2 in the
> file which I am maintaining on the grounds that some code to which
> I do not care still has some W=1.

If you are concerned about a particular driver - why don't you silence
the warning in there? Or alternatively build it with clang?

With all that, I think that the right way to go is to fix the root
cause of this churn - broken Wtype-limits in GCC, and after that move
Wtype-limits to W=1. Anything else looks hacky to me.

Thanks,
Yury

> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
>  include/linux/find.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/find.h b/include/linux/find.h
> index 5bb6db213bcb..efd4b3f7dd17 100644
> --- a/include/linux/find.h
> +++ b/include/linux/find.h
> @@ -103,6 +103,10 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
>  }
>  #endif
>  
> +__diag_push();
> +__diag_ignore(GCC, 8, "-Wtype-limits",
> +	      "GENMASK(size - 1, 0) yields 'comparison of unsigned expression in < 0 is always false' which is OK");
> +
>  #ifndef find_first_bit
>  /**
>   * find_first_bit - find the first set bit in a memory region
> @@ -193,6 +197,8 @@ unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
>  }
>  #endif
>  
> +__diag_pop(); /* ignore -Wtype-limits */
> +
>  /**
>   * find_next_clump8 - find next 8-bit clump with set bits in a memory region
>   * @clump: location to store copy of found clump
> -- 
> 2.35.1
