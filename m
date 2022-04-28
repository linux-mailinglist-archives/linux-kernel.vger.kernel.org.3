Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C634D513B06
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 19:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbiD1RmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 13:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbiD1RmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 13:42:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BF37A7744
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651167545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qTa1PiQlC3U5vo163YBGzHkGqCZn98XvdYZbCYWOy88=;
        b=a1t84GEAzJboCxyYEDy4u5Z3AeZs1FkEYE2iKlhI+PmOfnx6yB8RVKA3pOPAKX+JgnJkDi
        c/uottDPHVwbVewhXKkyOPFB4ZNK7iFCfKslLpv7smDcATeQWUG2uFD3j0f4loVKzUHfqr
        WJ8yv+Ouc3ZkfGs7SoW4EP4DkNOJh+c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-kjdml4-vNFOuInCUdFyjiQ-1; Thu, 28 Apr 2022 13:39:04 -0400
X-MC-Unique: kjdml4-vNFOuInCUdFyjiQ-1
Received: by mail-wm1-f69.google.com with SMTP id ay39-20020a05600c1e2700b0038ff4f1014fso2212521wmb.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qTa1PiQlC3U5vo163YBGzHkGqCZn98XvdYZbCYWOy88=;
        b=iQqIWVv+3yULWk7HWoPbWU05Y3ZhIR53D6XWxWsmyICrCiD5GUVSePQV7qoEwYGz/S
         LnAY2R7VrhLYs82tJru/sxb5bTbM6UcHZdei3YSQV2DFqNKTl6n0lmd1wx3GrRcjZpPd
         B6oW16nE230TfSWBMo7PrRLQBhEAC8ErcA+N47S9m5AWnllNSAMnf9DfGjrVzrFL2GId
         FAMkJMHIorrddheI14ZTN9dM8m4xy9CgawnkTBse526uaz5bTbOgPWeqbIW7heHINpq4
         xFkF/VnPqvGnV5jyWd8Gkk9kr2+K+0JpRSI4QFSBj/IQmdoxfMtWmKc3ERwblvD3+y4Y
         FK3w==
X-Gm-Message-State: AOAM532a3WJy3aWYwe23VtyDdTAJ49MxLk73nSs2qoei+VnBf9BHJfr7
        4t182/MZZDeL5rJ50aLCiBmx7r5t1M1POsCa3HEauaC/s5sEtBmROF+KahrKFBDdD7TAMmpDsuj
        SceIuEfk0bRiASSeXZZHA8fggb2frvjLQAdBLiKOy
X-Received: by 2002:a5d:45c5:0:b0:20a:be8f:aca6 with SMTP id b5-20020a5d45c5000000b0020abe8faca6mr28021814wrs.493.1651167542694;
        Thu, 28 Apr 2022 10:39:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFgPQF4/R5LGWhNlocQWdfRiUJJVYdeWRr/A3EDvyI1rG3nLaEx5lvJoNRnFD6xybZRBNnf10z8gXvVl22EIc=
X-Received: by 2002:a5d:45c5:0:b0:20a:be8f:aca6 with SMTP id
 b5-20020a5d45c5000000b0020abe8faca6mr28021795wrs.493.1651167542429; Thu, 28
 Apr 2022 10:39:02 -0700 (PDT)
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
 <CAHk-=wicJdoCjPLu7FhaErr6Z3UaW820U2b+F-8P4qwSFUZ0mg@mail.gmail.com>
 <CAHc6FU7GkXLkns5PONLvsSi6HB+rjaNSyFeQFS034tKL-JueMw@mail.gmail.com> <CAHk-=wg4ypnZUA5BOHAF1miKvOhW2yQSruuBKNXMDR=dTmp+ww@mail.gmail.com>
In-Reply-To: <CAHk-=wg4ypnZUA5BOHAF1miKvOhW2yQSruuBKNXMDR=dTmp+ww@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 28 Apr 2022 19:38:51 +0200
Message-ID: <CAHc6FU6VgQDO7HT5f4S_4f=9hczKGRDQ6SbQ5kNHMi4i-6rxVA@mail.gmail.com>
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

On Thu, Apr 28, 2022 at 7:09 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Apr 28, 2022 at 6:27 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> >
> > The data corruption we've been getting unfortunately didn't have to do
> > with lock contention (we already knew that); it still occurs. I'm
> > running out of ideas on what to try there.
>
> Hmm.
>
> I don't see the bug, but I do have a suggestion on something to try.
>
> In particular, you said the problem started with commit 00bfe02f4796
> ("gfs2: Fix mmap + page fault deadlocks for buffered I/O").

Yes, but note that it's gfs2_file_buffered_write() that fails. When
the pagefault_disable/enable() around iomap_file_buffered_write() is
removed, the corruption goes away.

> And to me, I see two main things that are going on
>
>  (a) the obvious "calling generic IO functions with pagefault disabled" thing
>
>  (b) the "allow demotion" thing
>
> And I wonder if you could at least pinpoint which of the  cases it is
> that triggers it.
>
> So I'd love to see you try three things:
>
>  (1) just remove the "allow demotion" cases.
>
>      This will re-introduce the deadlock the commit is trying to fix,
> but that's such a special case that I assume you can run your
> test-suite that shows the problem even without that fix in place?
>
>      This would just pinpoint whether it's due to some odd locking issue or not.
>
> Honestly, from how you describe the symptoms, I don't think (1) is the
> cause, but I think making sure is good.
>
> It sounds much more likely that it's one of those generic vfs
> functions that screws up when a page fault happens and it gets a
> partial result instead of handling the fault.

The test should run just fine without allowing demotion. I'll try (1),
but I don't expect the outcome to change.

> Which gets us to
>
>  (2) remove the pagefault_disable/enable() around just the
> generic_file_read_iter() case in gfs2_file_read_iter().
>
> and
>
>  (3) finally, remove the pagefault_disable/enable() around the
> iomap_file_buffered_write() case in gfs2_file_buffered_write()
>
> Yeah, yeah, you say it's just the read that fails, but humor me on
> (3), just in case it's an earlier write in your test-suite and the
> read just then uncovered it.
>
> But I put it as (3) so that you'd do the obvious (2) case first, and
> narrow it down (ie if (1) still shows the bug, then do (2), and if
> that fixes the bug it will be fairly well pinpointed to
> generic_file_read_iter().

As mentioned above, we already did (3) and it didn't help. I'll do (1)
now, and then (2).

> Looking around, gfs2 is the only thing that obviously calls
> generic_file_read_iter() with pagefaults disabled, so it does smell
> like filemap_read() might have some issue, but the only thing that
> does is basically that
>
>                 copied = copy_folio_to_iter(folio, offset, bytes, iter);
>
> which should just become copy_page_to_iter_iovec(), which you'd hope
> would get things right.
>
> But it would be good to just narrow things down a bit.
>
> I'll look at that copy_page_to_iter_iovec() some more regardless, but
> doing that "let's double-check it's not somethign else" would be good.

We've actually been running most of our experiments on a 5.14-based
kernel with a plethora of backports, so pre-folio. Sorry I forgot to
mention that. I'll reproduce with mainline as well.

Thanks,
Andreas

