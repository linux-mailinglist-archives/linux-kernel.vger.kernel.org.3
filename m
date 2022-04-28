Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B59851351A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347387AbiD1Nad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347408AbiD1Na2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:30:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 673A3B18A9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651152432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PI/xP+D4wC4P+iwOmDNVv3yXWXyc7DwYrUAcoATm6W4=;
        b=eB3FFsgvYheLaMJ1RHAxn8IGPf7CAgYnhXrR+Chv9kDwQyqzkIQmIe5MB7q1r5GTKOulwA
        DFg25MttGiFvPO2yRLGWjos72Nu1yVOVIGEGbmJzmu97HuvnUkEIOi2bq4/EIjD/f3jXXe
        WwVbNHKMU5yAUdq9i76fcre3GRr++oQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-HsX-Qe0BMh6lqt3DFB541g-1; Thu, 28 Apr 2022 09:27:11 -0400
X-MC-Unique: HsX-Qe0BMh6lqt3DFB541g-1
Received: by mail-wm1-f71.google.com with SMTP id bh11-20020a05600c3d0b00b003928fe7ba07so1542247wmb.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PI/xP+D4wC4P+iwOmDNVv3yXWXyc7DwYrUAcoATm6W4=;
        b=XKA/Wv2E30KKBzssQHN8OrqltznEFyDNBRbXd/ydCBI10hkgxEU1TCcVsGJgf9r11f
         /Aj2Hf78y/BIC0IdmegX8vEWqfgThc0eVO8nfQpDIF1Uexvh2Ke1M/R+aGq3vQJ8ahWT
         hxWfn6F3PyphQf6AgyAehNkFkfJVMe3NSXKvwZMPjrOHfeEV4TQ6hX5TO2tHZSG65L8E
         6mM+nKIiGY8Z02Sg+FFNtTffe1MMt5Y5pWNv80Xd2NMvhPLcF2HvU9NhUrrI6ZEe6itW
         ypshUKhUHXxIHZD4ukkcflN/JuLObyN8J/uhcjWmyA1ggPXg+Q2BAHIecynND/YIsN3f
         lMuQ==
X-Gm-Message-State: AOAM532x0SLKlvWzp7JWQdYs6xpR0tZakh+Ip84kFdc2H0XVrRVntIAa
        ZrgQeT7HKQ+5qEgGnjQVB7sYzEGq1PGx07zIbygCtruXa5i8xzqP3GVtZ0FsVOQSleJcTdQ3oir
        +hQ955DqFFg9yaYWkxYLsUe7S8q7gjVwwEkVzauEs
X-Received: by 2002:adf:f30a:0:b0:20a:e193:6836 with SMTP id i10-20020adff30a000000b0020ae1936836mr12889313wro.654.1651152429494;
        Thu, 28 Apr 2022 06:27:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0CjpOPC0Kbd/FlkmCXcGc6qY4pPex3Aoq8nPR0CxXMqVNxToxWozktkt51C+mEM+zk/XB3r9JBroyjgRVzIA=
X-Received: by 2002:adf:f30a:0:b0:20a:e193:6836 with SMTP id
 i10-20020adff30a000000b0020ae1936836mr12889292wro.654.1651152429191; Thu, 28
 Apr 2022 06:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220426145445.2282274-1-agruenba@redhat.com> <CAHk-=wi7o+fHYBTuCQQdHD112YHQtO21Y3+wxNYypjdo8feKFg@mail.gmail.com>
 <CAHc6FU48681X8aUK+g7UUN7q5b6rkVBzTP7h_zbE4XqZYAiw3g@mail.gmail.com>
 <CAHk-=wjMB1-xCOCBtsSMmQuFV9G+vNyCY1O_LsoqOd=0QS4yYg@mail.gmail.com>
 <CAHc6FU5Bag5W2t79+WzUq=NibtEF+7z6=jyNCkLMMp9Yqvpmqw@mail.gmail.com>
 <CAHk-=whaz-g_nOOoo8RRiWNjnv2R+h6_xk2F1J4TuSRxk1MtLw@mail.gmail.com>
 <CAHc6FU5654k7QBU97g_Ubj8cJEWuA_bXPuXOPpBBYoXVPMJG=g@mail.gmail.com>
 <CAHk-=wgSYSNc5sF2EVxhjbSc+c4LTs90aYaK2wavNd_m2bUkGg@mail.gmail.com>
 <CAHc6FU69E4ke4Xg3zQ2MqjLbfM65D9ZajdY5MRDLN0azZOGmVQ@mail.gmail.com>
 <CAHk-=whQxvMvty8SjiGMh+gM4VmCYvqn6EAwmrDXJaHT2Aa+UA@mail.gmail.com> <CAHk-=wicJdoCjPLu7FhaErr6Z3UaW820U2b+F-8P4qwSFUZ0mg@mail.gmail.com>
In-Reply-To: <CAHk-=wicJdoCjPLu7FhaErr6Z3UaW820U2b+F-8P4qwSFUZ0mg@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 28 Apr 2022 15:26:58 +0200
Message-ID: <CAHc6FU7GkXLkns5PONLvsSi6HB+rjaNSyFeQFS034tKL-JueMw@mail.gmail.com>
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

On Thu, Apr 28, 2022 at 2:00 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Apr 27, 2022 at 3:20 PM Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> > So I really think
> >
> >  (a) you are mis-reading the standard by attributing too strong logic
> > to paperwork that is English prose and not so exact
> >
> >  (b) documenting Linux as not doing what you are mis-reading it for is
> > only encouraging others to mis-read it too
> >
> > The whole "arbitrary writes have to be all-or-nothing wrt all other
> > system calls" is simply not realistic, and has never been. Not just
> > not in Linux, but in *ANY* operating system that POSIX was meant to
> > describe.
>
> Side note: a lot of those "atomic" things in that documentation have
> come from a history of signal handling atomicity issues, and from all
> the issues people had with (a) user-space threading implementations
> and (b) emulation layers from non-Unixy environments.
>
> So when they say that things like "rename()" has to be all-or-nothing,
> it's to clarify that you can't emulate it as a "link and delete
> original" kind of operation (which old UNIX *did* do) and claim to be
> POSIX.
>
> Because while the end result of rename() and link()+unlink()might be
> similar, people did rely on that whole "use rename as a way to create
> an atomic marker in the filesystem" (which is a very traditional UNIX
> pattern).
>
> So "rename()" has to be atomic, and the legacy behavior of link+unlink
> is not valid in POSIX.
>
> Similarly, you can't implement "pread()" as a "lseek+read+lseek back",
> because that doesn't work if somebody else is doing another "pread()"
> on the same file descriptor concurrently.
>
> Again, people *did* implement exactly those kinds of implementations
> of "pread()", and yes, they were broken for both signals and for
> threading.
>
> So there's "atomicity" and then there is "atomicity".
>
> That "all or nothing" can be a very practical thing to describe
> *roughly* how it must work on a higher level, or it can be a
> theoretical "transactional" thing that works literally like a database
> where the operation happens in full and you must not see any
> intermediate state.
>
> And no, "write()" and friends have never ever been about some
> transactional operation where you can't see how the file grows as it
> is being written to. That kind of atomicity has simply never existed,
> not even in theory.
>
> So when you see POSIX saying that a "read()" system call is "atomic",
> you should *not* see it as a transaction thing, but see it in the
> historical context of "people used to do threading libraries in user
> space, and since they didn't want a big read() to block all other
> threads, they'd split it up into many smaller reads and now another
> thread *also* doing 'read()' system calls would see the data it read
> being not one contiguous region, but multiple regions where the file
> position changed in the middle".
>
> Similarly, a "read()" system call will not be interrupted by a signal
> in the middle, where the signal handler would do a "lseek()" or
> another "read()", and now the original "read()" data suddenly is
> affected.
>
> That's why things like that whole "f_pos is atomic" is a big deal.
>
> Because there literally were threading libraries (and badly emulated
> environments) where that *WASN'T* the case, and _that_ is why POSIX
> then talks about it.
>
> So think of POSIX not as some hard set of "this is exactly how things
> work and we describe every detail".
>
> Instead, treat it a bit like historians treat Herodotus - interpreting
> his histories by taking the issues of the time into account.  POSIX is
> trying to clarify and document the problems of the time it was
> written, and taking other things for granted.

Okay fine, thanks for elaborating.

Would you mind pulling the following fix to straighten this out?

The data corruption we've been getting unfortunately didn't have to do
with lock contention (we already knew that); it still occurs. I'm
running out of ideas on what to try there.

Thanks a lot,
Andreas

--

The following changes since commit 4fad37d595b9d9a2996467d780cb2e7a1b08b2c0:

  Merge tag 'gfs2-v5.18-rc4-fix' of
git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2
(2022-04-26 11:17:18 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
tags/gfs2-v5.18-rc4-fix2

for you to fetch changes up to 296abc0d91d8b65d42224dd33452ace14491ad08:

  gfs2: No short reads or writes upon glock contention (2022-04-28
15:14:48 +0200)

----------------------------------------------------------------
gfs2 fix

- No short reads or writes upon glock contention

----------------------------------------------------------------
Andreas Gruenbacher (1):
      gfs2: No short reads or writes upon glock contention

 fs/gfs2/file.c | 4 ----
 1 file changed, 4 deletions(-)

