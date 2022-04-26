Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87557510CB6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 01:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356156AbiDZXgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 19:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356144AbiDZXgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 19:36:32 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E0B37000
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 16:33:22 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id y19so487867ljd.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 16:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YVvIQh6F4l539Ju82FbPOXOwgPIjKwZXSPtA68ehILI=;
        b=bQ7chrN+CgDUyPpEzhWRxIbKhfeo+K9pDNSblFNsuyxAaM+EiF79z2/X2jr7SR/nlg
         MdaJKcmBZJQD/VoJfWZsy7qLTPyT3zkjCh9r7ws+STzLLUbolOMzidAD48MeqSUm3YVc
         G4tDLURnElsWyzf98HA0nIt6sMdJYpfTLyFYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YVvIQh6F4l539Ju82FbPOXOwgPIjKwZXSPtA68ehILI=;
        b=tMDy4YBqS5sZCxa0LRdcvcXaZsQrNm1B0VEZUrPdx5lhq01YKmZdSiWsW+U1+9SAXf
         fEPqTlClE7MjBC5ghQYpkZho/esf9gkfWn7yzzqT+P+Pct+UmFHj3GsJ/EStWgvzTarP
         2uhJJP7S4/XZZb4ljMRILINy4Vm4W5XndM8Q0f5UnzFfwQu5vu/WnvCS7fW4WVkQ0sHL
         lWRGItwACdvQ/YNaUOsKca6ARkTrZfqlpvGHAKFYNy6arPjAe/zH2X8FutFEoxHLW6/R
         NbzykU6u/gXr+VWF+TKYHgCVWS6nBaQSmbNaPnI8SuBXa5xy4wve1fXkQswVDDzdYXmW
         4tgg==
X-Gm-Message-State: AOAM53067VTlIBq85zwgF6WwQwP+qSmCB3dTVnKqBIzxl389g11hsFHR
        tS4q1cAZ2zoNKk4o5JsQVg+bE2JfiCPEEMyM
X-Google-Smtp-Source: ABdhPJwa2exffenMIx3sng8vr0YFz2WGn6rmlz/4M8ZUp7/l1TQT4XAKPR2Uk00fBA0jjFqZLBqbVw==
X-Received: by 2002:a2e:9101:0:b0:24b:554b:1203 with SMTP id m1-20020a2e9101000000b0024b554b1203mr16068289ljg.508.1651016000801;
        Tue, 26 Apr 2022 16:33:20 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id p8-20020a056512328800b0047205ddcf7csm938612lfe.35.2022.04.26.16.33.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 16:33:19 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id m23so464016ljb.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 16:33:19 -0700 (PDT)
X-Received: by 2002:a2e:8789:0:b0:24f:124c:864a with SMTP id
 n9-20020a2e8789000000b0024f124c864amr7581754lji.164.1651015999161; Tue, 26
 Apr 2022 16:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220426145445.2282274-1-agruenba@redhat.com> <CAHk-=wi7o+fHYBTuCQQdHD112YHQtO21Y3+wxNYypjdo8feKFg@mail.gmail.com>
 <CAHc6FU48681X8aUK+g7UUN7q5b6rkVBzTP7h_zbE4XqZYAiw3g@mail.gmail.com>
In-Reply-To: <CAHc6FU48681X8aUK+g7UUN7q5b6rkVBzTP7h_zbE4XqZYAiw3g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 Apr 2022 16:33:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjMB1-xCOCBtsSMmQuFV9G+vNyCY1O_LsoqOd=0QS4yYg@mail.gmail.com>
Message-ID: <CAHk-=wjMB1-xCOCBtsSMmQuFV9G+vNyCY1O_LsoqOd=0QS4yYg@mail.gmail.com>
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

On Tue, Apr 26, 2022 at 2:28 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> Btrfs has a comment in that place that reads:
>
>     /* No increment (+=) because iomap returns a cumulative value. */

What a truly horrid interface. But you are triggering repressed
childhood memories:

> That's so that we can complete the tail of an asynchronous write
> asynchronously after a failed page fault and subsequent fault-in.

yeah, that makes me go "I remember something like that".

> That would be great, but applications don't seem to be able to cope
> with short direct writes, so we must turn partial failure into total
> failure here. There's at least one xfstest that checks for that as
> well.

What a complete crock. You're telling me that you did some writes, but
then you can't tell user space that writes happened because that would
confuse things.

Direct-IO is some truly hot disgusting garbage.

Happily it's only used for things like databases that nobody sane
would care about anyway.

Anyway, none of that makes any sense, since you do this:

                ret = gfs2_file_direct_write(iocb, from, &gh);
                if (ret < 0 || !iov_iter_count(from))
                        goto out_unlock;

                iocb->ki_flags |= IOCB_DSYNC;
                buffered = gfs2_file_buffered_write(iocb, from, &gh);

so you're saying that the direct write will never partially succeed,
but then in gfs2_file_write_iter() it very much looks like it's
falling back to buffered writes for that case.

Hmm. Very odd.

I assume this is all due to that

        /* Silently fall back to buffered I/O when writing beyond EOF */
        if (iocb->ki_pos + iov_iter_count(from) > i_size_read(&ip->i_inode))

thing, so this all makes some perverse kind of sense, but it still
looks like this code just needs some serious serious commentary.

So you *can* have a partial write if you hit the end of the file, and
then you'll continue that partial write with the buffered code.

But an actual _failure_ will not do that, and instead return an error
even if the write was partially done.

But then *some* failures aren't failures at all, and without any
comments do this

        if (ret == -ENOTBLK)
                ret = 0;


And remind me again - this all is meant for applications that
supposedly care about consistency on disk?

And the xfs tests actually have a *test* for that case, to make sure
that nobody can sanely *really* know how much of the write succeeded
if it was a DIO write?

Gotcha.

> > The reason I think I'm full of sh*t is that you say that the problem
> > occurs in gfs2_file_buffered_write(), not in that
> > gfs2_file_direct_write() case.
>
> Right, we're having that issue with buffered writes.

I have to say, compared to all the crazy things I see in the DIO path,
the buffered write path actually looks almost entirely sane.

Of course, gfs2_file_read_iter() counts how many bytes it has read in
a variable called 'written', and gfs2_file_buffered_write() counts the
bytes it has written in a variable called 'read', so "entirely sane"
is all very very relative.

I'm sure there's some good reason (job security?) for all this insanity.

But I now have to go dig my eyes out with a rusty spoon.

But before I do that, I have one more question (I'm going to regret
this, aren't I?):

In gfs2_file_buffered_write(), when it has done that
fault_in_iov_iter_readable(), and it decides that that succeeded, it
does

                        if (gfs2_holder_queued(gh))
                                goto retry_under_glock;
                        if (read && !(iocb->ki_flags & IOCB_DIRECT))
                                goto out_uninit;
                        goto retry;

so if it still has that lock (if I understand correctly), it will always retry.

But if it *lost* the lock, it will retry only if was a direct write,
and return a partial success for a regular write() rather than
continue the write.

Whaa? I'm assuming that this is more of that "direct writes have to
succeed fully or not at all", but according to POSIX *regular* writes
should also succeed fully, unless some error happens.

Losing the lock doesn't sound like an error to me.

And there are a lot of applications that do assume "write to a regular
file didn't complete fully means that the disk is full" etc. Because
that's the traditional meaning.

This doesn't seem to be related to any data corruption issue, but it does smell.

             Linus
