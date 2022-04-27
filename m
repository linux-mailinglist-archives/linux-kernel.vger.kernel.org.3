Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A656C512302
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbiD0TrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbiD0Tqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:46:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9DDE4AE22
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 12:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651088496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VxlMSwwL71AQXI2HOAVlvE1k33pxxk+5fGEJtCTWrzk=;
        b=E0twqYwsS6f4vCGwzyEF21xxmP/nzKKu83dWSgzCBq6dckRDQnLe3UvAAyx0N0EaCIFQIN
        fcgLeq3vSNdpqs+Ek7GB/vwA92J1eeq83YaivV92kVs234w39bJkYWTMdkEKkxv1MSmuKO
        3A6k3aftbdsvRx4820Jwm/YmI0VofiI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-7j5L_aDUOmarXa2dNglAkQ-1; Wed, 27 Apr 2022 15:41:35 -0400
X-MC-Unique: 7j5L_aDUOmarXa2dNglAkQ-1
Received: by mail-wm1-f72.google.com with SMTP id h65-20020a1c2144000000b0038e9ce3b29cso3263369wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 12:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VxlMSwwL71AQXI2HOAVlvE1k33pxxk+5fGEJtCTWrzk=;
        b=TM6pQK8pwBXjBs0xQEQ8Dr9EoYSmW53ODWrlrbBXfZt2pJV4i2nxmnvQNjcNYnUHLc
         3tSMdwnU6T4ZAFg6pYlA4xRk4RnBcDAeyMDyjB4NkDPVGu9O66P6ayqoDYA3+a838rif
         ltJU3skkndCI/rUB8e2mIaX4nB2Voy0gjOvT4KyvtMcK3EYjVIUrAKobvLGMmCkCtI29
         yirdr6RZQaSHc55zrlLgfp1fsQ+CZlDc+e8tyGfNlxD96HIhX4D3M/q+KMuNWVVK5cUx
         ZTd+WLnWXyihKsWbbUS9EpctxDo9kVQRyuGNaIan+seJrAgAsoRmVrTRKSzjooBgrp7T
         s6sg==
X-Gm-Message-State: AOAM532kzQztwZxRZINqAQEcaknq9anoClarM/50nXpiMXmDUav5QLrE
        woA82VDyQkRl0vGbjEjrQo6H5pH0t2QiKgLSU0Kly6AgjIp0pN/3scPC2cqF06jDvJ5dWSfW/Z1
        uXTA9cD71n7ENQVa76BVYNxZIGhI80hdRtr23yGKn
X-Received: by 2002:a5d:45c5:0:b0:20a:be8f:aca6 with SMTP id b5-20020a5d45c5000000b0020abe8faca6mr24120523wrs.493.1651088494226;
        Wed, 27 Apr 2022 12:41:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxN8jAqVknzc7n/v3pZVq4flXFclG+lvqOba8PImYhZ/tlxU33DmGah56sHOQqwo7w20hTKEPm4Bsm/wPE46cU=
X-Received: by 2002:a5d:45c5:0:b0:20a:be8f:aca6 with SMTP id
 b5-20020a5d45c5000000b0020abe8faca6mr24120511wrs.493.1651088493957; Wed, 27
 Apr 2022 12:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220426145445.2282274-1-agruenba@redhat.com> <CAHk-=wi7o+fHYBTuCQQdHD112YHQtO21Y3+wxNYypjdo8feKFg@mail.gmail.com>
 <CAHc6FU48681X8aUK+g7UUN7q5b6rkVBzTP7h_zbE4XqZYAiw3g@mail.gmail.com>
 <CAHk-=wjMB1-xCOCBtsSMmQuFV9G+vNyCY1O_LsoqOd=0QS4yYg@mail.gmail.com>
 <CAHc6FU5Bag5W2t79+WzUq=NibtEF+7z6=jyNCkLMMp9Yqvpmqw@mail.gmail.com> <CAHk-=whaz-g_nOOoo8RRiWNjnv2R+h6_xk2F1J4TuSRxk1MtLw@mail.gmail.com>
In-Reply-To: <CAHk-=whaz-g_nOOoo8RRiWNjnv2R+h6_xk2F1J4TuSRxk1MtLw@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 27 Apr 2022 21:41:22 +0200
Message-ID: <CAHc6FU5654k7QBU97g_Ubj8cJEWuA_bXPuXOPpBBYoXVPMJG=g@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 fix
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 7:13 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Apr 27, 2022 at 5:29 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> >
> > Regular (buffered) reads and writes are expected to be atomic with
> > respect to each other.
>
> Linux has actually never honored that completely broken POSIX
> requirement, although I think some filesystems (notably XFS) have
> tried.

Okay, I can happily live with that.

I wonder if this could be documented in the read and write manual
pages. Or would that be asking too much?

> It's a completely broken concept. It's not possible to honor atomicity
> with mmap(), and nobody has *ever* cared.
>
> And it causes huge amounts of problems and basically makes any sane
> locking entirely impossible.
>
> The fact that you literally broke regular file writes in ways that are
> incompatible with (much MUCH more important) POSIX file behavior to
> try to get that broken read/write atomicity is only one example among
> many for why that alleged rule just has to be ignored.
>
> We do honor the PIPE_BUF atomicity on pipes, which is a completely
> different kind of atomicity wrt read/write, and doesn't have the
> fundamental issues that arbitrary regular file reads/writes have.
>
> There is absolutely no sane way to do that file atomicity wrt
> arbitrary read/write calls (*), and you shouldn't even try.
>
> That rule needs to be forgotten about, and buried 6ft deep.
>
> So please scrub any mention of that idiotic rule from documentation,
> and from your brain.
>
> And please don't break "partial write means disk full or IO error" due
> to trying to follow this broken rule, which was apparently what you
> did.
>
> Because that "regular file read/write is done in full" is a *MUCH*
> more important rule, and there is a shitton of applications that most
> definitely depend on *that* rule.
>
> Just go to debian code search, and look for
>
>    "if (write("
>
> and you'll get thousands of hits, and on the first page of hits 9 out
> of 10 of the hits are literally about that "partial write is an
> error", eg code like this:
>
>             if (write(fd,&triple,sizeof(triple)) != sizeof(triple))
>                 reporterr(1,NULL);
>
> from libreoffice.
>
>                         Linus
>
> (*) Yeah, if you never care about performance(**) of mixed read/write,
> and you don't care about mmap, and you have no other locking issues,
> it's certainly possible. The old rule came about from original UNIX
> literally taking an inode lock around the whole IO access, because
> that was simple, and back in the days you'd never have multiple
> concurrent readers/writers anyway.
>
> (**) It's also instructive how O_DIRECT literally throws that rule
> away, and then some direct-IO people said for years that direct-IO is
> superior and used this as one of their arguments. Probably the same
> people who thought that "oh, don't report partial success", because we
> can't deal with it.
>

Thanks a lot,
Andreas

