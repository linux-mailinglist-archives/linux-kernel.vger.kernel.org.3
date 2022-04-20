Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503BF508FFC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 21:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381652AbiDTTKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 15:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381646AbiDTTKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:10:48 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965FB40E4E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 12:08:00 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x17so4650763lfa.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 12:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sj1hpM6fhreP1iTRqHBcccNvHMl3eVbILQpQDiy86Bg=;
        b=QzUWblAxmNFHwz7gBQ5mv2wfEez79gBQE22yrImImPbRmppWXhJuGUEA8GG1SwIb2j
         3AdwbIwtIqCat62TgPw/zqu47T4G6DhQjMSnw6HF3XQ6764iEgGyB3DSLZHYoAKHv0cF
         GshykrSLOxfylLxpl4kmvX8+DgY1hj+x80djs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sj1hpM6fhreP1iTRqHBcccNvHMl3eVbILQpQDiy86Bg=;
        b=MqbPrYDMJFexWbA6GtjYZn68nRV7xNAtRAeQTLemLkf475s3AgIzjl+2YgcWPLZLPN
         2ypMvMNLHcnAhYlYK1DKEuvFrnHFhlKai9PYzt5YlVwhyuEx5ho7wWYRi+Hbdz/N+ZQn
         nFj1oNkAJqipk0BcfjsTJu5Edg72N72Qth24ufQAA0MUmjDEi68H9q3qD4wutewnDWoJ
         QHcJLrBZPfD+F47exrYmVIrmiCzXyHTEH5uyDIbqxhC4J2j9GJLEK3BDxst1OA437Fpg
         oKAq7qFEGvcst3kdVP/ncS72plsXcoX1nBKSisPg4CiW3Xc1nAgmJroduF0cMQEX6e7I
         5qQw==
X-Gm-Message-State: AOAM531ymL5swozP52F4yHzfLVjxKXyWnkiUUl4zSKIjtCq+N45NcYU5
        nuZiXWJXs1M5iD881XSthjKXooUZOzL3ACjTuas=
X-Google-Smtp-Source: ABdhPJxNvGYagDj6ozb8C82j95aa319LBtTvXNRCsP6BpL7WQzUXkrBPiAI1QZy4NpD1GgHnBl70VA==
X-Received: by 2002:a05:6512:10c5:b0:471:a703:bca4 with SMTP id k5-20020a05651210c500b00471a703bca4mr6797389lfg.581.1650481678625;
        Wed, 20 Apr 2022 12:07:58 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id a3-20020a195f43000000b0044a997dea6bsm1911014lfj.288.2022.04.20.12.07.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 12:07:56 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id t25so4669773lfg.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 12:07:56 -0700 (PDT)
X-Received: by 2002:a05:6512:b12:b0:44a:ba81:f874 with SMTP id
 w18-20020a0565120b1200b0044aba81f874mr15978126lfu.449.1650481676314; Wed, 20
 Apr 2022 12:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220420073717.GD16310@xsang-OptiPlex-9020>
In-Reply-To: <20220420073717.GD16310@xsang-OptiPlex-9020>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Apr 2022 12:07:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi6pJhsWLd7t9wEtq5tWh_2O61cSLk-wCgLwFrjW6+jbw@mail.gmail.com>
Message-ID: <CAHk-=wi6pJhsWLd7t9wEtq5tWh_2O61cSLk-wCgLwFrjW6+jbw@mail.gmail.com>
Subject: Re: [fs/pipe] 5a519c8fe4: WARNING:at_mm/page_alloc.c:#__alloc_pages
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 12:37 AM kernel test robot
<oliver.sang@intel.com> wrote:
>
> commit: 5a519c8fe4d6 ("fs/pipe: use kvcalloc to allocate a pipe_buffer array")
>
> [   32.170781][ T3729] WARNING: The mand mount option has been deprecated and
> [   32.170781][ T3729]          and is ignored by this kernel. Remove the mand
> [   32.170781][ T3729]          option from the mount to silence this warning.

Heh. Not that warning.

This warning:

> [ 224.552771][ T3730] WARNING: CPU: 1 PID: 3730 at mm/page_alloc.c:5364 __alloc_pages (mm/page_alloc.c:5364)

That's just the

  5363          if (unlikely(order >= MAX_ORDER)) {
  5364                  WARN_ON_ONCE(!(gfp & __GFP_NOWARN));
  5365                  return NULL;
  5366          }

so somebody is doing a big allocation that will fail, and doesn't use
__GFP_NOWARN.

That someone being iter_file_splice_write():

> [ 224.567299][ T3730] kmalloc_order (include/linux/gfp.h:572 include/linux/gfp.h:595 include/linux/gfp.h:609 mm/slab_common.c:944)
> [ 224.567707][ T3730] kmalloc_order_trace (mm/slab_common.c:960)
> [ 224.568173][ T3730] __kmalloc (include/linux/slab.h:510 mm/slub.c:4413)
> [ 224.568571][ T3730] iter_file_splice_write (include/linux/slab.h:? include/linux/slab.h:652 fs/splice.c:628)
> [ 224.570060][ T3730] do_splice (fs/splice.c:767 fs/splice.c:1079)
> [ 224.572386][ T3730] __ia32_sys_splice (fs/splice.c:1144 fs/splice.c:1350 fs/splice.c:1332 fs/splice.c:1332)

and that's the

        int nbufs = pipe->max_usage;
        struct bio_vec *array = kcalloc(nbufs, sizeof(struct bio_vec),
                                        GFP_KERNEL);

thing, and no, using __GFP_NOWARN here isn't what we'd want to do,
because the code in question has no fallback (it will just return
-ENOMEM).

Now, technically, returning -ENOMEM is a "fallback", but not really.
It just means the kernel won't crash, it doesn't mean that this is
acceptable behavior.

Basically, that commit 5a519c8fe4d6 made it possible to create a pipe
that is effectively "too large to be used". It used to be that such a
pipe could never be created before, because the 'pipe->bufs' resizing
allocation used to be

        bufs = kcalloc(nr_slots, sizeof(*bufs),
                       GFP_KERNEL_ACCOUNT | __GFP_NOWARN);

and 'sizeof(struct pipe_buffer)' is bigger than 'sizeof(struct
bio_vec)', so if the resizing was successful, then the pipe buffer
count was guaranteed to be smaller than what that file_splice code
would use.

So it really does look like this whole "allow the pipe size to grow
almost unlimited" change was a fundamental mistake. It has these kinds
of subtle issues.

I'm inclined to revert commit 5a519c8fe4d6 - doing multiple iterations
really shouldn't be so expensive, and this shows that the whole "try
to do it in one big go" is fundamentally broken.

Could 'iter_file_splice_write()' be changed to limit it some way? Yes.

Could it be changed to use kvcalloc() too? Yes again.

But I'm not convinced that some odd corner-case CRIU optimization is
worth this kind of pain.

                      Linus
