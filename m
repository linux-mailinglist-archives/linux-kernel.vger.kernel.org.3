Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1930359FB82
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238295AbiHXNiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238389AbiHXNht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:37:49 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13C87E007
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:37:48 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id b2so12633874qkh.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=gCNFptM6elh6PO/H9+n154kovwITjCqB473Jl6226Nc=;
        b=BIc3mq+Ss3xu0f/jkjoSeVoya+rG9CJUWWoaNmXmPBYKIU0fHrvYNLVko9EfRJrPUB
         aDTGNaIvMtFDfuzOyiYEbnmaoVFVsubnvkUd3qZWo2vZs1kiyvKW+1crX97HL0jSnNEF
         gR9a/cJf9Ts9N9Zsriyf82PWjIvqSczeBrzDHHyVdo5c0GQE7EHEv17e4nA9mHqnf4Wg
         wDHCBZjkpNpf38MUqwsM7ijS+kFsacON2nGTN05uDFmhozNFZCi7L6wqQtdAjfozSKOT
         GU4+GoCS8m+cWZ+SAm+1JW5nEDjKQ6nvFOglm3t2bYJQ4uGijKp6KiVaQWIk0rFGxFRl
         se+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=gCNFptM6elh6PO/H9+n154kovwITjCqB473Jl6226Nc=;
        b=OHh8GmaTHeTL3qXbF1g/kGYwE7I1hjxA+6lVd/NMMHsWOrPLi+UxlGQnjVvNgrM6LN
         3HG0yu5kXx3JteHsaUatyb+J5V6W6OTFwMOIvHwb68UxeLI6D6b/oJWGe6LsbbwTgQzV
         T/9z5H8t2xX60HVo4DHrx8j9SdZHiQSBpHgxdFrKPoU66gqgd8pmom19nVmzopG/zGs8
         ivFyqB56AgZABeKisGfa/CMl51WOrAaTMyPrFcwQ2CAlXTKnigCMImT4VSWnBXytH4fW
         +2gM8p0zMNzVSow16mrtcCwW9mPZ+Qyy+5hoOYgqymieBBdbaZ2mpQk2Ya0xj3CD4M4L
         fEnQ==
X-Gm-Message-State: ACgBeo0kUNMs9TEPb5ZLOuefinHHztqth0/lbKp/5PpfnOTWTjF3XUts
        WcFNoQPE3jNeEMzYqshZYxs=
X-Google-Smtp-Source: AA6agR5Cned9qAoi0/zgqRGNeUJ0ki+uQAqIiXqjtXnwEiIyTPpjoVOcSOsK/AGgmDAxCkc/ton8rQ==
X-Received: by 2002:a05:620a:f03:b0:6b6:6513:af63 with SMTP id v3-20020a05620a0f0300b006b66513af63mr19402650qkl.312.1661348267753;
        Wed, 24 Aug 2022 06:37:47 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:5a54:d9d9:c2a4:527e])
        by smtp.gmail.com with ESMTPSA id q66-20020ae9dc45000000b006bba6c614casm14722465qkf.13.2022.08.24.06.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 06:37:46 -0700 (PDT)
Date:   Wed, 24 Aug 2022 06:37:45 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dennis Zhou <dennis@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexey Klimov <aklimov@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Whitcroft <apw@canonical.com>
Subject: Re: [PATCH v2 2/3] lib/find_bit: create find_first_zero_bit_le()
Message-ID: <YwYpqRZxCe9NLZyk@yury-laptop>
References: <20220824012624.2826445-1-yury.norov@gmail.com>
 <20220824012624.2826445-3-yury.norov@gmail.com>
 <CAHp75VdgXBFH_vxUNYZLc2ahOrC8oBj0x=2GWXZr+CLGX1qyTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdgXBFH_vxUNYZLc2ahOrC8oBj0x=2GWXZr+CLGX1qyTg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 12:22:33PM +0300, Andy Shevchenko wrote:
> On Wed, Aug 24, 2022 at 5:17 AM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > find_first_zero_bit_le() is an alias to find_next_zero_bit_le(),
> > despite that 'next' is known to be slower than the 'first' version.
> >
> > Now that we have a common FIND_FIRST_BIT() macro helper, it's trivial
> > to implement find_first_zero_bit_le() as a real function.
> >
> > Moving find_*_le() to a separate file helps to fit the FIND_FIRST_BIT()
> > to the _le needs by wiring word_op to swab.
> >
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> > Like other find_*_le() functions, the new one takes void *addr, instead
> > of unsigned long *. This should be fixed for all in a separate series.
> 
> From this comment it is unclear to me why we can't fix them first and
> then apply this with the correct type?

Because there is a codebase that relies on existing types, mostly in
filesystem code. And those fs fixes would require 5 or 6 patches.

This would triple the length of this series, and is completely
unrelated. That's why I think that:
        > > This should be fixed for all in a separate series.

> ...
> 
> > +#define word_op swab
> > +#include "find_bit.h"
> 
> Looking at this, I would rather always require to define __ffs_word_op
> (or whatever name) in the user and replace #ifndef in the find_bit.h
> with
> #error "The __ffs_word_op must be defined before including find_bit.h!"

This is a local header which is not intended to be included anywhere
except lib/find_bit{,_be}.c. I don't expect someone else would want to
include it, even in lib. So what you suggest is a bit overthinking to
me. But if you insist, I can do that.

Thanks,
Yury
