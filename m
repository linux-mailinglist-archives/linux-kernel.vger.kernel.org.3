Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA4B511E7B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243930AbiD0RQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243939AbiD0RQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:16:41 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A778C42A29
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:13:29 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id q14so3489773ljc.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BkjJC3atGNZLbDtpxaTEoGR+ldCQ7Vj1pUM/H8AnDYM=;
        b=GgsK/vod/0h6Z3q/viJfHLTa/y3ItPCOjt4m7HT1PGJwZ2zLilClTKdELGxGN4UhXm
         GfZvOi7Q+W7/fcfcblmu06c4NqVRSsiY5riv6RbowCpEqC/2d+fBtAEJlu4H65Cpao8E
         wA+7jQFmJYEawrv7bfULBOVaxxz3nkm6pCEkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BkjJC3atGNZLbDtpxaTEoGR+ldCQ7Vj1pUM/H8AnDYM=;
        b=XfcNV79tCKBzOlLWglxKPZUhGOFb63bmogV0P2zhRzO80UyuNBl1x3+aMtXGAx66Q5
         DILC9xsxdourxZ0FRKD9itBjZcHBjy6FzI8Nk1D6QZQcFI7kR/ZFBxT4enb9/y97FZHJ
         lQ5gVcAJebIiQhI0hKptZ9G7ZxKMvGL7JB6Paul1UN28CMvB2N4FInMxuZvKKKcYo/Hu
         u+RvQZ7/HtLM0O9GMmjBFA4gOsFw0zXGrTZgIIaxtd8hrc/uFdk0wC2tdsCB7jkmEqxh
         8sbmVsqBt87nXf0WUNT2GXlvHMBil6JgdFIPsljQUFZp7AHDl6/EpFD1XBWiESjmdhXN
         kD3g==
X-Gm-Message-State: AOAM530e5+d+m7ihJd5h7aTvfiUfySTPzAR6rvKbSEr8OOVjEdYbXmaA
        xjefU3yAqxD32oJUKkH5v+/MiG3WPdPyn5OVPqI=
X-Google-Smtp-Source: ABdhPJyTq7CwlYlCv2LwgXv+vCkIheQCtYXM1yLX3GyMGDlvzCBTuvnq8ZPuZE5E6a9fnxjZkqc4Vg==
X-Received: by 2002:a05:651c:1a09:b0:24f:199c:9d1a with SMTP id by9-20020a05651c1a0900b0024f199c9d1amr6759722ljb.173.1651079607683;
        Wed, 27 Apr 2022 10:13:27 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id b11-20020ac2410b000000b004457116a575sm2100971lfi.273.2022.04.27.10.13.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 10:13:26 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 17so3559241lji.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:13:26 -0700 (PDT)
X-Received: by 2002:a2e:b8d4:0:b0:24f:2cc3:2c51 with SMTP id
 s20-20020a2eb8d4000000b0024f2cc32c51mr1706392ljp.176.1651079606302; Wed, 27
 Apr 2022 10:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220426145445.2282274-1-agruenba@redhat.com> <CAHk-=wi7o+fHYBTuCQQdHD112YHQtO21Y3+wxNYypjdo8feKFg@mail.gmail.com>
 <CAHc6FU48681X8aUK+g7UUN7q5b6rkVBzTP7h_zbE4XqZYAiw3g@mail.gmail.com>
 <CAHk-=wjMB1-xCOCBtsSMmQuFV9G+vNyCY1O_LsoqOd=0QS4yYg@mail.gmail.com> <CAHc6FU5Bag5W2t79+WzUq=NibtEF+7z6=jyNCkLMMp9Yqvpmqw@mail.gmail.com>
In-Reply-To: <CAHc6FU5Bag5W2t79+WzUq=NibtEF+7z6=jyNCkLMMp9Yqvpmqw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Apr 2022 10:13:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=whaz-g_nOOoo8RRiWNjnv2R+h6_xk2F1J4TuSRxk1MtLw@mail.gmail.com>
Message-ID: <CAHk-=whaz-g_nOOoo8RRiWNjnv2R+h6_xk2F1J4TuSRxk1MtLw@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 fix
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Apr 27, 2022 at 5:29 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> Regular (buffered) reads and writes are expected to be atomic with
> respect to each other.

Linux has actually never honored that completely broken POSIX
requirement, although I think some filesystems (notably XFS) have
tried.

It's a completely broken concept. It's not possible to honor atomicity
with mmap(), and nobody has *ever* cared.

And it causes huge amounts of problems and basically makes any sane
locking entirely impossible.

The fact that you literally broke regular file writes in ways that are
incompatible with (much MUCH more important) POSIX file behavior to
try to get that broken read/write atomicity is only one example among
many for why that alleged rule just has to be ignored.

We do honor the PIPE_BUF atomicity on pipes, which is a completely
different kind of atomicity wrt read/write, and doesn't have the
fundamental issues that arbitrary regular file reads/writes have.

There is absolutely no sane way to do that file atomicity wrt
arbitrary read/write calls (*), and you shouldn't even try.

That rule needs to be forgotten about, and buried 6ft deep.

So please scrub any mention of that idiotic rule from documentation,
and from your brain.

And please don't break "partial write means disk full or IO error" due
to trying to follow this broken rule, which was apparently what you
did.

Because that "regular file read/write is done in full" is a *MUCH*
more important rule, and there is a shitton of applications that most
definitely depend on *that* rule.

Just go to debian code search, and look for

   "if (write("

and you'll get thousands of hits, and on the first page of hits 9 out
of 10 of the hits are literally about that "partial write is an
error", eg code like this:

            if (write(fd,&triple,sizeof(triple)) != sizeof(triple))
                reporterr(1,NULL);

from libreoffice.

                        Linus

(*) Yeah, if you never care about performance(**) of mixed read/write,
and you don't care about mmap, and you have no other locking issues,
it's certainly possible. The old rule came about from original UNIX
literally taking an inode lock around the whole IO access, because
that was simple, and back in the days you'd never have multiple
concurrent readers/writers anyway.

(**) It's also instructive how O_DIRECT literally throws that rule
away, and then some direct-IO people said for years that direct-IO is
superior and used this as one of their arguments. Probably the same
people who thought that "oh, don't report partial success", because we
can't deal with it.
