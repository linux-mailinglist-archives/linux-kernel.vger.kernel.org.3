Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A67522487
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 21:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbiEJTLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 15:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239684AbiEJTLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 15:11:32 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AB32532C0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 12:11:30 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id f5so11986906ilj.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 12:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yhVqDTExWoz6ItXB09D+IajghtNf4zxV3xnD5/jJ9ho=;
        b=YtU3JpNg0d4+TwtvZUMQoB8QGjkNFayCqDkhoy5HhfzjqkvZZlaHweYW4LZr2tevSq
         oCP8b4Eu6Rhjr4a9IsQ6QbKdW4YPgjDXS9PEBJ0wuOgnusmSUohF2R5oEnWBfjA/dOTI
         b9vz3uqPUeogLKXkrjlqdzTmz3x95hKu4QjZoyuBnSfMBwN3f0G5F4ezPCB19pUXACmi
         tKzg+22dP+rnB7n+MLTiuats9FGitXRL2rll2xmvQi9dDkXUjOIVsC9AYs83X661WEah
         Bz8AfZo1A9pbr3pIEhwqi/MhLrQxH/PYAIolC6+sbgz11qo94NcLkQzfTbdN+rJW0iyp
         +AKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yhVqDTExWoz6ItXB09D+IajghtNf4zxV3xnD5/jJ9ho=;
        b=Zgjoq8lUPdELH9BM03qZmcLi2whpVXt8UlR1K2WBM43+XKoN7XSIP/eRj+YlO/ayr0
         Ts7Z5Z6FfkT81yX+GQPDjpWuN+vRzeQUmrfgZdcHx2ur45VvdKQ3WdPS1lxaBn3l6jBL
         SF9T2Zccc6RJ+h/EZ4sxP1Mls+B04/7rSmSVaG3dLDvtZTATp8ZKyLJyKs988AlbRHgo
         4y2BkJ5kLdSMAWXK5wyA5Fmm7SO7alWSIhhtpylxvE+tzAXzKGjAISjXBsRWMmolQ7ci
         /m10M9BccVTnsUW75ImEfZDpUNWYEuAUua0LYfSuM2QY5W+gGhp+UOwSx1GJJGYR9j3M
         6uZg==
X-Gm-Message-State: AOAM532pmBrB/R1sL5JxXk83AtBA8tKLQUb4tULoc8ZbjsaMUL6jJzC6
        /bcvP7eEwA/0uumLUNexEzc=
X-Google-Smtp-Source: ABdhPJyEe7vsMfxtz+RpPpQUxfNa88KUwRB9L4IzhYDNUJAxw8k/QcypoXOVNbbisU9OXdmbPRGz2Q==
X-Received: by 2002:a92:7309:0:b0:2ca:8c9c:752d with SMTP id o9-20020a927309000000b002ca8c9c752dmr10040741ilc.151.1652209890213;
        Tue, 10 May 2022 12:11:30 -0700 (PDT)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id g100-20020a02856d000000b0032dba44218asm994547jai.166.2022.05.10.12.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 12:11:29 -0700 (PDT)
Date:   Tue, 10 May 2022 12:11:27 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Alexei Starovoitov' <alexei.starovoitov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matti Vaittinen <Matti.Vaittinen@fi.rohmeurope.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>
Subject: Re: [PATCH 08/22] bitops: introduce MANY_BITS() macro
Message-ID: <Ynq43wlPezrRzur8@yury-laptop>
References: <20220510154750.212913-1-yury.norov@gmail.com>
 <20220510154750.212913-9-yury.norov@gmail.com>
 <CAADnVQKcX2xEWCHu-DX0Cy_mvCL6E0aE_BF1Wo+U-vy_Bi2-3w@mail.gmail.com>
 <3be064fe804845e4aeaca8b1d45ddf0a@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3be064fe804845e4aeaca8b1d45ddf0a@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 05:54:13PM +0000, David Laight wrote:
> From: Alexei Starovoitov
> > Sent: 10 May 2022 17:51
> ...
> > +/* Return: nonzero if 2 or more bits are set */
> > +#define MANY_BITS(n)           ((n) & ((n) - 1))
> 
> You can't have a macro that expands its argument twice.

Yes, I'll fix it.
 
> ...
> > >  static inline __attribute__((const))
> > >  bool is_power_of_2(unsigned long n)
> > >  {
> > > -       return (n != 0 && ((n & (n - 1)) == 0));
> > > +       return n != 0 && !MANY_BITS(n);
> > >  }
> > 
> > Please don't. Open coded version is much easier to read.

To me the human-readable version is easier to read. Still, if you thing
that n & (n - 1) is simpler, what for this function is needed at all?

> Especially if you remove all the spare parenthesis.
> 	return n && !(n & (n - 1));
> 
> I bet a lot of callers know the value is non-zero.
> 
> I suspect you'll find at least one caller that uses
> is_power_of_2() assuming it is !(n & (n - 1)) and
> so is wrong for zero.
 
Another thing is that despite __attribute__(const), gcc sometimes doesn't
recognize it as constant expression, and people have to workaround it.
XTENSA is the example for 1st case, and for the 2nd:

arch/powerpc/mm/init-common.c:
        unsigned long minalign = max(MAX_PGTABLE_INDEX_SIZE + 1,
                                                     HUGEPD_SHIFT_MASK + 1);

        /* It would be nice if this was a BUILD_BUG_ON(), but at the
         * moment, gcc doesn't seem to recognize is_power_of_2
         * as a constant expression, so so much for that. */
        BUG_ON(!is_power_of_2(minalign));

This convinced me that we need a simple macro that is decoupled with
pow_2 semantics and can be used in another macros like BUILD_BUG_ON().

Thanks,
Yury
