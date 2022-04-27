Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9A051252F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 00:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbiD0WXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 18:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbiD0WXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:23:36 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEEA17E3A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 15:20:24 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id q185so4435761ljb.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 15:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yCYL9g4VwJRI+kOW4bU4UPGTSqELiJ7re1kAOeB0fTc=;
        b=KgH/l6N237SRBI92F2IRVx6f+6Hd2ZgAHQ4IuWldsWhmMGaJJbynZm31cQW3H1uxTW
         0bPzdyMEMbXsR+SVDjs9Hrd+92T9sLnBkiOYld02Hi02N5GfWZB8mK26MESZ8SRH72/A
         jloqi/91tVO55EmWGuu/ZTRiDk/1ONuWthJzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yCYL9g4VwJRI+kOW4bU4UPGTSqELiJ7re1kAOeB0fTc=;
        b=TYXjDqqq/siSl8KiCzbTcY+PJoDaJ4weRrLuFwaP0p6pXm597BQOZYr9yKMyCvFrNo
         sPi+JtqeeRlRK5ohPVovMzehMkIV2e8yAkvyvohotRTYqEx/pEzxSIJTipgz8IxFxvuz
         2fL5qjztLEscT+xIEVSEtqEYk4a4z2DnNu9I7r7pc/koT/ObkGvj008tTMiHrfJXaG76
         e313oFoB2yLT+WhFwA9UFZS/mpJRSYwtrDsdzuA55kUDqOVcPvqEKdG8eiL6xdM7U6zY
         TC/4R6pBClIcBQJkIJkrv7zcEVnHQnukCwZ0dVuuVXIzOsUVWeabadg+7k9TfdodET0J
         s68g==
X-Gm-Message-State: AOAM530Zey9FNiYjYkcOEAyhoUU/H0zn2VTjxyPtcV3vXXf4GJs+gvYo
        gqeOyzUI4GxenYaRveaoquXve2HnPRDvMQbI1xM=
X-Google-Smtp-Source: ABdhPJzNk4Xd5PEhXNyrJOCGp9EW82QRdHzMrWBUmmIU6HdE7RU28hoBIlTfcJsx9iSpBBygO8726w==
X-Received: by 2002:a2e:a88b:0:b0:24b:5714:213d with SMTP id m11-20020a2ea88b000000b0024b5714213dmr19248431ljq.412.1651098021612;
        Wed, 27 Apr 2022 15:20:21 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id a13-20020a19e30d000000b00471ea64d877sm2026082lfh.102.2022.04.27.15.20.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 15:20:20 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id g19so5520881lfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 15:20:20 -0700 (PDT)
X-Received: by 2002:a05:6512:6c6:b0:472:296e:6dfb with SMTP id
 u6-20020a05651206c600b00472296e6dfbmr4066529lff.542.1651098018218; Wed, 27
 Apr 2022 15:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220426145445.2282274-1-agruenba@redhat.com> <CAHk-=wi7o+fHYBTuCQQdHD112YHQtO21Y3+wxNYypjdo8feKFg@mail.gmail.com>
 <CAHc6FU48681X8aUK+g7UUN7q5b6rkVBzTP7h_zbE4XqZYAiw3g@mail.gmail.com>
 <CAHk-=wjMB1-xCOCBtsSMmQuFV9G+vNyCY1O_LsoqOd=0QS4yYg@mail.gmail.com>
 <CAHc6FU5Bag5W2t79+WzUq=NibtEF+7z6=jyNCkLMMp9Yqvpmqw@mail.gmail.com>
 <CAHk-=whaz-g_nOOoo8RRiWNjnv2R+h6_xk2F1J4TuSRxk1MtLw@mail.gmail.com>
 <CAHc6FU5654k7QBU97g_Ubj8cJEWuA_bXPuXOPpBBYoXVPMJG=g@mail.gmail.com>
 <CAHk-=wgSYSNc5sF2EVxhjbSc+c4LTs90aYaK2wavNd_m2bUkGg@mail.gmail.com> <CAHc6FU69E4ke4Xg3zQ2MqjLbfM65D9ZajdY5MRDLN0azZOGmVQ@mail.gmail.com>
In-Reply-To: <CAHc6FU69E4ke4Xg3zQ2MqjLbfM65D9ZajdY5MRDLN0azZOGmVQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Apr 2022 15:20:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=whQxvMvty8SjiGMh+gM4VmCYvqn6EAwmrDXJaHT2Aa+UA@mail.gmail.com>
Message-ID: <CAHk-=whQxvMvty8SjiGMh+gM4VmCYvqn6EAwmrDXJaHT2Aa+UA@mail.gmail.com>
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

On Wed, Apr 27, 2022 at 2:26 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> Well, POSIX explicitly mentions those atomicity expectations, e.g.,
> for read [1]:

Yes. I'm aware. And my point is that we've never done _that_ kind of atomicity.

It's also somewhat ambiguous what it actually means, since what it
then talks about is "all bytes that started out together ends
together" and "interleaving".

That all implies that it's about the *position* of the reads and
writes being atomic, not the *data* of the reads and writes.

That, btw, was something we honored even before we had the locking
around f_pos accesses - a read or write system call would get its own
local *copy* the file position, the read or write would then do that
IO based on that copied position - so that things that "started out
together ends together" - and then after the operation is done it
would *update* the file position atomically.

Note that that is exactly so that data would end up "together". But it
would mean that two concurrent reads using the same file position
might read the *same* area of the file.

Which still honors that "the read is atomic wrt the range", but
obviously the actual values of "f_pos" is basically random after the
read (ie is it the end of the first read, or the end of the second
read?).

The same paragraph also explicitly mentions pipes and FIFOs, despite
an earlier paragraph dismissing them, which is all just a sign of
things being very confused.

Anyway, I'm not objecting very sternously to making it very clear in
some documentation that this "data atomicity" is not what Linux has
ever done. If you do overlapping IO, you get what you deserve.

But I do have objections.

On one hand, it's not all that different from some of the other notes
we have in the man-pages (ie documenting that whole "just under 2GB"
limit on the read size, although that's actually using the wrong
constant: it's not 0x7ffff000 bytes, it's MAX_RW_COUNT, which is
"INT_MAX & PAGE_MASK" and that constant in the man-page is as such
only true on a system with 4kB page sizes)

BUT! I'm 100% convinced that NOBODY HAS EVER given the kind of
atomicity guarantees that you would see from reading that document as
a language-lawyer.

For example, that section "2.9.7 Thread Interactions with Regular File
Operations" says that "fstat()" is atomic wrt "write()", and that you
should see "all or nothing".

I *GUARANTEE* that no operating system ever has done that, and I
further claim that reading it the way you read it is not only against
reality, it's against sanity.

Example: if I do a big write to a file that I just created, do you
really want "fstat()" in another thread or process to not even be able
to see how the file grows as the write happens?

It's not what anybody has *EVER* done, I'm pretty sure.

So I really think

 (a) you are mis-reading the standard by attributing too strong logic
to paperwork that is English prose and not so exact

 (b) documenting Linux as not doing what you are mis-reading it for is
only encouraging others to mis-read it too

The whole "arbitrary writes have to be all-or-nothing wrt all other
system calls" is simply not realistic, and has never been. Not just
not in Linux, but in *ANY* operating system that POSIX was meant to
describe.

And equally importantly: if some crazy person were to actually try to
implement such "true atomicity" things, the end result would be
objectively worse. Because you literally *want* to see a big write()
updating the file length as the write happens.

The fact that the standard then doesn't take those kinds of details
into account is simply because the standard isn't meant to be read as
a language lawyer, but as a "realistically .."

             Linus
