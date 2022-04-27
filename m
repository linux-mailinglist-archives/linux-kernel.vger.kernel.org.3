Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9832C5123DC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 22:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbiD0UaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 16:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236252AbiD0U3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 16:29:51 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEA5B3C7E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 13:26:15 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id p12so5138399lfs.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 13:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GbCA6ryLcC+4N1YdXeSNdc1G8PlnnlULw8ksimgMuYk=;
        b=HL6XnPOB2cCe63b0h5x/a8gP+zbRlCPKnbXPFV7fYpOt1yy25Yf61QDmr7xsIZFUmn
         +yXtJy3b+AsKT5LNlnyXrAGm37GXim0rcEYWsjTmis0AoYryTRHre6dfIOKveplodh9J
         re0VUnEeHDqH3Qpv2GruCiiOuz0GUmZkMG0ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GbCA6ryLcC+4N1YdXeSNdc1G8PlnnlULw8ksimgMuYk=;
        b=HcOo0sAYy2lPrzloFFfKpQD6jDJZ9BHz7SkGWvgJB4D4L9NZnIu02D5HDdgxOZsvtz
         7IaCP46UcvhwlAVN2kf5h5B57vCAuTeujn95QB18M89oIb99DOirFFjE6+Dp5fNk21S2
         BK5Bld0ZEO5LSrv2Im87qXcSazeT4YnhpYbedRYBJHzEtx/A7xfRKMoYOT5fRbpM5Yfo
         2uwU8xmkdt/U4Z1EaaXkNedQhXclLgYtAT4GH7gmTEdWsZf8Yc2KG54Zu9JUlxWP5aHo
         pY7hR8sTBFdnMAlbPG2RvkUxNgES2pLpnvZFhlqSe6+i+v9X3iSOhlFGTFVCUOBDHaoP
         TkdQ==
X-Gm-Message-State: AOAM530mnq9lp2MoUuS9fKXtAAnUNTiV7dX7MJJE5QF/U3dUv540b7tq
        gqGjhWH4f7EXfXttSxbCIn9MaCuk1MEsWUvu5PU=
X-Google-Smtp-Source: ABdhPJzO1eXQpNJu2EYp1DbYOF+gLAkOAFDo1F/+/Ub/UJnTSYlBSbwWLBgQBfEd6+KEcTHXPmrGeQ==
X-Received: by 2002:ac2:4250:0:b0:44a:ff88:3795 with SMTP id m16-20020ac24250000000b0044aff883795mr21748738lfl.384.1651091173731;
        Wed, 27 Apr 2022 13:26:13 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id b15-20020a2e894f000000b0024db8e1248csm1940889ljk.124.2022.04.27.13.26.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 13:26:13 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id v1so4176802ljv.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 13:26:12 -0700 (PDT)
X-Received: by 2002:a2e:8789:0:b0:24f:124c:864a with SMTP id
 n9-20020a2e8789000000b0024f124c864amr10737718lji.164.1651091172382; Wed, 27
 Apr 2022 13:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220426145445.2282274-1-agruenba@redhat.com> <CAHk-=wi7o+fHYBTuCQQdHD112YHQtO21Y3+wxNYypjdo8feKFg@mail.gmail.com>
 <CAHc6FU48681X8aUK+g7UUN7q5b6rkVBzTP7h_zbE4XqZYAiw3g@mail.gmail.com>
 <CAHk-=wjMB1-xCOCBtsSMmQuFV9G+vNyCY1O_LsoqOd=0QS4yYg@mail.gmail.com>
 <CAHc6FU5Bag5W2t79+WzUq=NibtEF+7z6=jyNCkLMMp9Yqvpmqw@mail.gmail.com>
 <CAHk-=whaz-g_nOOoo8RRiWNjnv2R+h6_xk2F1J4TuSRxk1MtLw@mail.gmail.com> <CAHc6FU5654k7QBU97g_Ubj8cJEWuA_bXPuXOPpBBYoXVPMJG=g@mail.gmail.com>
In-Reply-To: <CAHc6FU5654k7QBU97g_Ubj8cJEWuA_bXPuXOPpBBYoXVPMJG=g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Apr 2022 13:25:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgSYSNc5sF2EVxhjbSc+c4LTs90aYaK2wavNd_m2bUkGg@mail.gmail.com>
Message-ID: <CAHk-=wgSYSNc5sF2EVxhjbSc+c4LTs90aYaK2wavNd_m2bUkGg@mail.gmail.com>
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

On Wed, Apr 27, 2022 at 12:41 PM Andreas Gruenbacher
<agruenba@redhat.com> wrote:
>
> I wonder if this could be documented in the read and write manual
> pages. Or would that be asking too much?

I don't think it would be asking too much, since it's basically just
describing what Linux has always done in all the major filesystems.

Eg look at filemap_read(), which is basically the canonical read
function, and note how it doesn't take a single lock at that level.

We *do* have synchronization at a page level, though, ie we've always
had that page-level "uptodate" bit, of course (ok, so "always" isn't
true - back in the distant past it was the 'struct buffer_head' that
was the synchronization point).

That said, even that is not synchronizing against "new writes", but
only against "new creations" (which may, of course, be writers, but is
equally likely to be just reading the contents from disk).

That said:

 (a) different filesystems can and will do different things.

Not all filesystems use filemap_read() at all, and even the ones that
do often have their own wrappers. Such wrappers *can* do extra
serialization, and have their own rules. But ext4 does not, for
example (see ext4_file_read_iter()).

And as mentioned, I *think* XFS honors that old POSIX rule for
historical reasons.

 (b) we do have *different* locking

for example, we these days do actually serialize properly on the
file->f_pos, which means that a certain *class* of read/write things
are atomic wrt each other, because we actually hold that f_pos lock
over the whole operation and so if you do file reads and writes using
the same file descriptor, they'll be disjoint.

That, btw, hasn't always been true. If you had multiple threads using
the same file pointer, I think we used to get basically random
results. So we have actually strengthened our locking in this area,
and made it much better.

But note how even if you have the same file descriptor open, and then
do pread/pwrite, those can and will happen concurrently.

And mmap accesses and modifications are obviously *always* concurrent,
even if the fault itself - but not the accesses - might end up being
serialized due to some filesystem locking implementation detail.

End result: the exact serialization is complex, depends on the
filesystem, and is just not really something that should be described
or even relied on (eg that f_pos serialization is something we do
properly now, but didn't necessarily do in the past, so ..)

Is it then worth pointing out one odd POSIX rule that basically nobody
but some very low-level filesystem people have ever heard about, and
that no version of Linux has ever conformed to in the main default
filesystems, and that no user has ever cared about?

             Linus
