Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71DD522492
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 21:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243855AbiEJTRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 15:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiEJTRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 15:17:01 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0E72608F3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 12:16:59 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id i5so33924ilv.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 12:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KQbaG/uNayn0MvP5ZcG3kEKMtXIrQTLtyOWN/V1ZKEQ=;
        b=SmHRlvDV4tZDjXY+KbUw8jmDD9jgLhF6z8RTkYgz9M84hje9NC+xkoLeeOEcuYLURC
         uu0S7Ndi7zHqsHkchf/gkxav760GNAbm+XhMDbKlng6seeYjX7mE1kOvlOFKFb8FtThi
         j+/5hLVyOAqSW3Q3P72aUouuYBbQ+N0y8OAQIb8ydv+zGMcAIyByBd/PaPn7wO3PlHCz
         i1IF5t0uWlFclnXVGtbIQS1R/Qwwl+2U3XTcL6Raun81TKp3kw/PVxJ8Am7pVtQ/xQrB
         HgaaT+qPKH4IUIOr1vTTbf3k9jxVbryi9yc4zAlEG9Z0jwcYV+UVKhuMkjvnEQUi3S2x
         4+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KQbaG/uNayn0MvP5ZcG3kEKMtXIrQTLtyOWN/V1ZKEQ=;
        b=oyWIQplCQVKppJWHMbQ99q5LnFnoIaMcjWyohouzKzEK1GatN/8ROLDYLsEe1jdi+J
         ptFlWZP/NrMAMpTybCgmUhjLORhlpPL2QkpLn/901pK2dOt41aJnuMgQ7XhM8TMUqH36
         pMxudAy2RbW3onV+hKMUA1mwP8CVZnOs+A6DwivSjMDk2V7iSgRNzOMFxEf3zIwNpgSx
         e6w6LrMrYGhEbOfp1lOYwZUmmusjzHD88jugIXYLzowaPCIyWe0VhRHFlYMjNxrxn+Cl
         90etSeVp1zHHqgHVjXdtWW6MYPbKDz1ImqUirPb2x7A2yA4fNqY6PGAqjfXriqXjCoA+
         oWrA==
X-Gm-Message-State: AOAM5302KgBjes7qPfuGmGkZIgqL1kQb5to2mCYOdTqdMq6EG+wIKDMQ
        jsOAilW/eopMDetDt6ShGrg=
X-Google-Smtp-Source: ABdhPJwZrM/ym9SWyM6BjPeFoAv9e5oGkyIsX52jni5N0NNIfDGtsbEzziEUuCbfnGfp4dWr4yxN8A==
X-Received: by 2002:a05:6e02:1e08:b0:2cf:1c31:15ec with SMTP id g8-20020a056e021e0800b002cf1c3115ecmr10607722ila.133.1652210218459;
        Tue, 10 May 2022 12:16:58 -0700 (PDT)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id o9-20020a92a809000000b002cdfeead6basm49951ilh.63.2022.05.10.12.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 12:16:57 -0700 (PDT)
Date:   Tue, 10 May 2022 12:16:55 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@aculab.com>,
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
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Subject: Re: [PATCH 08/22] bitops: introduce MANY_BITS() macro
Message-ID: <Ynq6JxyfBKK4SMZj@yury-laptop>
References: <20220510154750.212913-1-yury.norov@gmail.com>
 <20220510154750.212913-9-yury.norov@gmail.com>
 <CAMo8Bf+JiyKD=g00whNOYGynx_0KjC_wJtpEBCB2ynFZ3U+e_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMo8Bf+JiyKD=g00whNOYGynx_0KjC_wJtpEBCB2ynFZ3U+e_Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

On Tue, May 10, 2022 at 10:57:25AM -0700, Max Filippov wrote:
> Hi Yury,
> 
> On Tue, May 10, 2022 at 8:48 AM Yury Norov <yury.norov@gmail.com> wrote:
> > arch/xtensa/kernel/traps.c and include/linux/log2.h define very similar
> > functions with different behaviour. XTENSA defines IS_POW2(), and
> > log2.h defines is_power_of_2(). The difference is that IS_POW2()
> > considers 0 as power of 2, while is_power_of_2() - does not.
> 
> IS_POW2 is constructed this way because we know that there is at least
> one non-zero bit in the value that it tests.
> 
> > This discrepancy may confuse reader. From mathematical point of view,
> > 0 is not a power of 2.
> 
> If it would reduce the confusion we can add a check that the value is
> non-zero in the IS_POW2 macro.
> 
> I'd really like to not introduce the local macro and just use something
> standard,

This patch introduces a macro MANY_BITS() in include/linux/bitops.h, which
is a full analogue of IS_POW2(). Would it work for you to switch to
MANY_BITS()? 

> but I can't use is_power_of_2 in a preprocessor condition, can I?

I believe you can't.

Thanks,
Yury
