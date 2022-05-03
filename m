Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2B2518042
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 10:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiECJAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 05:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiECJAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 05:00:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1CBDA36161
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 01:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651568195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hsMPfZ7YVBXiceEKvCyPHJHbSrWBVzhicBQJ3xEfcUM=;
        b=gX1Dg5ycF+P446ejNkfzJy/5+zkxuFJ38YB5/LUvxP8zWUINnl3nOou/rOl3LkBHWS4GVh
        kDoKAj7mQ8DDRCRGgiXqTIpPXamM+iqXJv/sSPi34mXt+/GmMNeLrxrMo2wSnZT2ospw2e
        IuFvElErLUv3cOzMvEn5JMVYzrEyqgk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-2xyudkatOPuReOMD9dXRWA-1; Tue, 03 May 2022 04:56:33 -0400
X-MC-Unique: 2xyudkatOPuReOMD9dXRWA-1
Received: by mail-wm1-f70.google.com with SMTP id t184-20020a1c46c1000000b00394209f54f1so3240858wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 01:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hsMPfZ7YVBXiceEKvCyPHJHbSrWBVzhicBQJ3xEfcUM=;
        b=qJT/Kzh6wI2UmPz5H8UoMcftL+QG+5Wpn7S5VMKnL4kWdT/Y9zXfCkTePCND8v0FAg
         TqGpYYYfI2bMl7NtiLQ35br5YQxWI3pii1/G2E86uldJ+WX/rxf0vRMcfacJuG1VUYGA
         WiAmd215x1um8ToZgGci0LAepEbWQrr6uhUbx5vpasLi++lBylTV7mEdoOqqGJ9WpV/s
         EGYk1TjTl4BiXmco2AEVbHhtosX/+RKaKOERufYoIXd2Fg1tJXkHr6fww3SRvEspVRUE
         tScOluVuNiA/IOKKjivczIEM4mNouMrOE+H5pBJvo+A0PfhBaciqLlY7pgbrIBs6sm4A
         PgMQ==
X-Gm-Message-State: AOAM5310k8DXGnV6OY94Li91N18eONJX8R0kjWnhtZuyAxB5XTkTE6OJ
        aS6aIELKofe+W6MxddbZFdIvtzrfHNoDCRjSsV59BM7JtZGc1PLE/oUc39X08HykbpVPYshinSO
        9dGbpVp2B2UOxAJYZ0geAvY8dmbj5re4O7Jpgr5r9
X-Received: by 2002:a05:600c:9:b0:393:ea67:1c68 with SMTP id g9-20020a05600c000900b00393ea671c68mr2482279wmc.92.1651568192646;
        Tue, 03 May 2022 01:56:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYtLR8VvhbzJcDjhUtSyg5TLLMizsYb225WJMv+RYxsAzrnZVWzwvB4t0FHDEztk89AxGCkD5/dkHUmR0hilI=
X-Received: by 2002:a05:600c:9:b0:393:ea67:1c68 with SMTP id
 g9-20020a05600c000900b00393ea671c68mr2482267wmc.92.1651568192413; Tue, 03 May
 2022 01:56:32 -0700 (PDT)
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
 <CAHc6FU7GkXLkns5PONLvsSi6HB+rjaNSyFeQFS034tKL-JueMw@mail.gmail.com>
 <CAHk-=wg4ypnZUA5BOHAF1miKvOhW2yQSruuBKNXMDR=dTmp+ww@mail.gmail.com>
 <CAHc6FU6VgQDO7HT5f4S_4f=9hczKGRDQ6SbQ5kNHMi4i-6rxVA@mail.gmail.com> <CAHk-=whL74iP6v2P+OafGO0H72ag4wt42k+Kc_01boLP8aqUNQ@mail.gmail.com>
In-Reply-To: <CAHk-=whL74iP6v2P+OafGO0H72ag4wt42k+Kc_01boLP8aqUNQ@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 3 May 2022 10:56:20 +0200
Message-ID: <CAHc6FU77KGn76B4ieu9Tn895deK-1yV4y=8ou4gTfUf=7C-4XQ@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 fix
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 8:32 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Apr 28, 2022 at 10:39 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> >
> > Yes, but note that it's gfs2_file_buffered_write() that fails. When
> > the pagefault_disable/enable() around iomap_file_buffered_write() is
> > removed, the corruption goes away.
>
> I looked some more at this on and off, and ended up even more confused.
>
> For some reason, I'd mostly looked at the read case, because I had
> mis-read some of your emails and thought it was the buffered reads
> that caused problems.
>
> Then I went back more carefully, and realized you had always said
> gfs2_file_buffered_write() was where the issues happened, and looked
> at that path more, and that confused me even *MORE*.
>
> Because that case has always done the copy from user space with page
> faults disabled, because of the traditional deadlock with reading from
> user space while holding the page lock on the target page cache page.
>
> So that is not really about the new deadlock with filesystem locks,
> that was fixed by 00bfe02f4796 ("gfs2: Fix mmap + page fault deadlocks
> for buffered I/O").
>
> So now that I'm looking at the right function (maybe) I'm going "huh",
> because it's none of the complex cases that would seem to fail, it's
> literally just the fault_in_iov_iter_readable() that we've always done
> in iomap_write_iter() that presumably starts failing.
>
> But *that* old code seems bogus too. It's doing
>
>                 if (unlikely(fault_in_iov_iter_readable(i, bytes) == bytes)) {
>                         status = -EFAULT;
>                         break;
>                 }
>
> which on the face of it is sane: it's saying "if we can't fault in any
> bytes, then stop trying".
>
> And it's good, and correct, but it does leave one case open.
>
> Because what if the result is "we can fault things in _partially_"?
>
> The code blithely goes on and tries to do the whole 'bytes' range _anyway_.
>
> Now, with a bug-free filesystem, this really shouldn't matter, since
> the later copy_page_from_iter_atomic() thing should then DTRT anyway,
> but this does mean that one fundamental thing that that commit
> 00bfe02f4796 changed is that it basically disabled that
> fault_in_iov_iter_readable() that *used* to fault in the whole range,
> and now potentially only faults in a small area.
>
> That, in turn, means that in practice it *used* to do "write_end()"
> with a fully successful range, ie when it did that
>
>                 status = a_ops->write_end(file, mapping, pos, bytes, copied,
>                                                 page, fsdata);
>
> then "bytes" and "copied" were the same.
>
> But now that commit 00bfe02f4796 added the "disable_pagefault()"
> around the whole thing, fault_in_iov_iter_readable() will easily fail
> half-way instead of bringing the next page in, and then that
> ->write_begin() to ->write_end() sequence will see the copy in the
> middle failing half-way too, and you'll have that write_end()
> condition with the write _partially_ succeeding.
>
> Which is the complex case for write_end() that you practically
> speaking never saw before (it *could* happen with a race with swap-out
> or similar, but it was not really something you could trigger in real
> life.
>
> And I suspect this is what bites you with gfs2
>
> To *test* that hypothesis, how about you try this attached patch? The
> generic_perform_write() function in mm/filemap.c has the same exact
> pattern, but as mentioned, a filesystem really needs to be able to
> handle the partial write_end() case, so it's not a *bug* in that code,
> but it migth be triggering a bug in gfs2.
>
> And gfs2 only uses the iomap_write_iter() case, I think. So that's the
> only case this attached patch changes.
>
> Again - I think the unpatched iomap_write_iter() code is fine, but I
> think it may be what then triggers the real bug in gfs2. So this patch
> is not wrong per se, but this patch is basically a "hide the problem"
> patch, and it would be very interesting to hear if it does indeed fix
> your test-case.

We still get data corruption with the patch applied. The
WARN_ON_ONCE(!bytes) doesn't trigger.

As an additional experiment, I've added code to check the iterator
position that iomap_file_buffered_write() returns, and it's all
looking good as well: an iov_iter_advance(orig_from, written) from the
original position always gets us to the same iterator.

This points at gfs2 getting things wrong after a short write, for
example, marking a page / folio uptodate that isn't. But the uptodate
handling happens at the iomap layer, so this doesn't leave me with an
immediate suspect.

We're on filesystems with block size == page size, so none of the
struct iomap_page uptodata handling should be involved, either.

> Because that would pinpoint exactly what the bug is.
>
> I'm adding Christoph and Darrick as iomap maintainers here to the
> participants (and Dave Chinner in case he's also the temporary
> maintainer because Darrick is doing reviews) not because they
> necessarily care, but just because this test-patch obviously involves
> the iomap code.
>
> NOTE! This patch is entirely untested. I also didn't actually yet go
> look at what gfs2 does when 'bytes' and 'copied' are different. But
> since I finally think I figured out what might be going on, I decided
> I'd send this out sooner rather than later.
>
> Because this is the first thing that makes me go "Aaahh.. This might
> explain it".
>
>                    Linus

Thanks,
Andreas

