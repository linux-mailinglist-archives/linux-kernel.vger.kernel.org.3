Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B26513AA8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 19:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbiD1RNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 13:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiD1RNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 13:13:02 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF90B82D4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:09:46 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id n14so9737670lfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+iAkgH8cfwl83YyTEPgnjdt38nfCnmdRxiArvtIdv0w=;
        b=cnCDL3Sb4OI6qHwFV6zlbIEJN+63KN3UoqPsYDo9nczU3quG5qdwvCRqiH1G8X7HqQ
         LTi4G+F8c8TPJOC7AUb5NmfBE4PbHGX1Wqk9g6PkY9PCK1J7J9Z+G7yb9d4FsQV5a8sr
         UygvSly3ibj/0sOk/Y+2RQxrTx0h0lBBaY6SQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+iAkgH8cfwl83YyTEPgnjdt38nfCnmdRxiArvtIdv0w=;
        b=fWTTphKxmbaPs8cIeDN7ziZg/jrTAhBZ8jk/Z4a++2yiRk4zD0MV37zLNj9Nnc7csX
         9N2lklHjMtX+hFuHxEnPJWTE88c7FZMs9uYaZNsOm4aURts3xNv2QO8DOaLk3QgQxCnT
         nO/Uo4OEIM+mixkoAc35SCPt6sAyyAahIDJ7mmBCaLNCpBhwqSOoXEFOd03OUNfr4BUD
         tnILBhs3MoyfKkqHgwXGTNHL2McOYJhofh0WcpJlKTIBrMbxf2SF60B54ssK1Mcho1xK
         oN5x8mkcxFd3NEZ0GxDjunUW+U/rM/tb9+bV/yX7bql7kV5ugZF7qeO8feEl+pIE5ity
         My9Q==
X-Gm-Message-State: AOAM531SLNEmitrpSzZ4YwPBQuh7baQU6afue8nHtNQnQDtgOWI52mJ5
        J+8HmkTZYGXHNJtHFH3pZr7rTgLnJMk/bzFxj2A=
X-Google-Smtp-Source: ABdhPJwLL8/PpEln4b4AR25piCT4b+F/81g3hX5qA4YhgwTFMW036I1x27BVJpRWTyEJDCzadCGVeg==
X-Received: by 2002:a05:6512:1585:b0:448:3936:a5a0 with SMTP id bp5-20020a056512158500b004483936a5a0mr24662882lfb.108.1651165784352;
        Thu, 28 Apr 2022 10:09:44 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id k10-20020a19560a000000b0046d1707fcbdsm47454lfb.215.2022.04.28.10.09.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 10:09:43 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id w19so9751179lfu.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:09:43 -0700 (PDT)
X-Received: by 2002:a05:6512:118f:b0:472:2b35:8528 with SMTP id
 g15-20020a056512118f00b004722b358528mr6616819lfr.531.1651165782874; Thu, 28
 Apr 2022 10:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220426145445.2282274-1-agruenba@redhat.com> <CAHk-=wi7o+fHYBTuCQQdHD112YHQtO21Y3+wxNYypjdo8feKFg@mail.gmail.com>
 <CAHc6FU48681X8aUK+g7UUN7q5b6rkVBzTP7h_zbE4XqZYAiw3g@mail.gmail.com>
 <CAHk-=wjMB1-xCOCBtsSMmQuFV9G+vNyCY1O_LsoqOd=0QS4yYg@mail.gmail.com>
 <CAHc6FU5Bag5W2t79+WzUq=NibtEF+7z6=jyNCkLMMp9Yqvpmqw@mail.gmail.com>
 <CAHk-=whaz-g_nOOoo8RRiWNjnv2R+h6_xk2F1J4TuSRxk1MtLw@mail.gmail.com>
 <CAHc6FU5654k7QBU97g_Ubj8cJEWuA_bXPuXOPpBBYoXVPMJG=g@mail.gmail.com>
 <CAHk-=wgSYSNc5sF2EVxhjbSc+c4LTs90aYaK2wavNd_m2bUkGg@mail.gmail.com>
 <CAHc6FU69E4ke4Xg3zQ2MqjLbfM65D9ZajdY5MRDLN0azZOGmVQ@mail.gmail.com>
 <CAHk-=whQxvMvty8SjiGMh+gM4VmCYvqn6EAwmrDXJaHT2Aa+UA@mail.gmail.com>
 <CAHk-=wicJdoCjPLu7FhaErr6Z3UaW820U2b+F-8P4qwSFUZ0mg@mail.gmail.com> <CAHc6FU7GkXLkns5PONLvsSi6HB+rjaNSyFeQFS034tKL-JueMw@mail.gmail.com>
In-Reply-To: <CAHc6FU7GkXLkns5PONLvsSi6HB+rjaNSyFeQFS034tKL-JueMw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Apr 2022 10:09:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4ypnZUA5BOHAF1miKvOhW2yQSruuBKNXMDR=dTmp+ww@mail.gmail.com>
Message-ID: <CAHk-=wg4ypnZUA5BOHAF1miKvOhW2yQSruuBKNXMDR=dTmp+ww@mail.gmail.com>
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

On Thu, Apr 28, 2022 at 6:27 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> The data corruption we've been getting unfortunately didn't have to do
> with lock contention (we already knew that); it still occurs. I'm
> running out of ideas on what to try there.

Hmm.

I don't see the bug, but I do have a suggestion on something to try.

In particular, you said the problem started with commit 00bfe02f4796
("gfs2: Fix mmap + page fault deadlocks for buffered I/O").

And to me, I see two main things that are going on

 (a) the obvious "calling generic IO functions with pagefault disabled" thing

 (b) the "allow demotion" thing

And I wonder if you could at least pinpoint which of the  cases it is
that triggers it.

So I'd love to see you try three things:

 (1) just remove the "allow demotion" cases.

     This will re-introduce the deadlock the commit is trying to fix,
but that's such a special case that I assume you can run your
test-suite that shows the problem even without that fix in place?

     This would just pinpoint whether it's due to some odd locking issue or not.

Honestly, from how you describe the symptoms, I don't think (1) is the
cause, but I think making sure is good.

It sounds much more likely that it's one of those generic vfs
functions that screws up when a page fault happens and it gets a
partial result instead of handling the fault.

Which gets us to

 (2) remove the pagefault_disable/enable() around just the
generic_file_read_iter() case in gfs2_file_read_iter().

and

 (3) finally, remove the pagefault_disable/enable() around the
iomap_file_buffered_write() case in gfs2_file_buffered_write()

Yeah, yeah, you say it's just the read that fails, but humor me on
(3), just in case it's an earlier write in your test-suite and the
read just then uncovered it.

But I put it as (3) so that you'd do the obvious (2) case first, and
narrow it down (ie if (1) still shows the bug, then do (2), and if
that fixes the bug it will be fairly well pinpointed to
generic_file_read_iter().

Looking around, gfs2 is the only thing that obviously calls
generic_file_read_iter() with pagefoaults disabled, so it does smell
like filemap_read() might have some issue, but the only thing that
does is basically that

                copied = copy_folio_to_iter(folio, offset, bytes, iter);

which should just become copy_page_to_iter_iovec(), which you'd hope
would get things right.

But it would be good to just narrow things down a bit.

I'll look at that copy_page_to_iter_iovec() some more regardless, but
doing that "let's double-check it's not somethign else" would be good.

             Linus
