Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513AA51175B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbiD0Mcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbiD0Mco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:32:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02D504B1D2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651062572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q3NajTnxfaXiUWEWzwoSS9j+6RIZ90UuUICFGJF5sxU=;
        b=Jw6fsdIpn8tTL0nbWs3uREofrcf8EKyIYxRkepRQrB85rGPleALZO7UWWTZsOxrJR394JV
        uIY2mBAYv6QPvkSh7upzoBLizE/aSEXQn/IOI0Vfqbqtq3wKTj0iAj6ehiEYid9DW2wbY4
        zhhoBEH4cB6vrRONJyCXc1UxG6xsVu4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-wqhK2l1fPIGYh5d-WOzkaw-1; Wed, 27 Apr 2022 08:29:31 -0400
X-MC-Unique: wqhK2l1fPIGYh5d-WOzkaw-1
Received: by mail-wm1-f69.google.com with SMTP id p32-20020a05600c1da000b00393fbf9ab6eso1816915wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q3NajTnxfaXiUWEWzwoSS9j+6RIZ90UuUICFGJF5sxU=;
        b=VE/1BBZJhiNg64ng0cGS8akuo38gmjgfhBWrHPkOmfsgkthiBck8eMR0xTKkEG62mv
         FuKe3/bdI2pbYu1dFThNJ+nI1dQOv6HzTfaf0ysktynq/JeemXDRbc6CLJYtVVXmscnz
         1YOfG5jCaMhsbK0TVINPLEraf0R+IzcWxp+p63xXMLSniJ8+OfAZsi2nqJa1H9E253p3
         MoM0ZAyosQDaywKqvfPcOi3tKetK8jYCTSP4A5JByj77rBgel4cdLz2bdDW82PKbyfx3
         gNwBGevP5HHjIqJ300Uq2FXI116FVmA8eQi5frr4SnS60Slrt6JfK4ciHVTRTxs2rA1H
         z7Dw==
X-Gm-Message-State: AOAM530tHhJhdCDN74vDeWTuykiT/qgM05Ba6921eB6dL0AZ23hzebvW
        qJDl505NemOkEzbiuPgdxbQsf019pZABMiC1fR/UJDUjCOcizTp+XWsf11hc4Qv8CgNZW0XyY+6
        u/CgJJy4DH31I+LYcaZyopghn3361LKmwyYglK57l
X-Received: by 2002:a05:6000:712:b0:20a:e5ee:2310 with SMTP id bs18-20020a056000071200b0020ae5ee2310mr6763126wrb.349.1651062570340;
        Wed, 27 Apr 2022 05:29:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2NwbomRB7oo5qB43mxERhmhA3DTKd91/iW0YBKGD5MzZODgFS2GGN77/iu24+f+xVUoV7Vyi36xCRLTKBGqU=
X-Received: by 2002:a05:6000:712:b0:20a:e5ee:2310 with SMTP id
 bs18-20020a056000071200b0020ae5ee2310mr6763112wrb.349.1651062570075; Wed, 27
 Apr 2022 05:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220426145445.2282274-1-agruenba@redhat.com> <CAHk-=wi7o+fHYBTuCQQdHD112YHQtO21Y3+wxNYypjdo8feKFg@mail.gmail.com>
 <CAHc6FU48681X8aUK+g7UUN7q5b6rkVBzTP7h_zbE4XqZYAiw3g@mail.gmail.com> <CAHk-=wjMB1-xCOCBtsSMmQuFV9G+vNyCY1O_LsoqOd=0QS4yYg@mail.gmail.com>
In-Reply-To: <CAHk-=wjMB1-xCOCBtsSMmQuFV9G+vNyCY1O_LsoqOd=0QS4yYg@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 27 Apr 2022 14:29:18 +0200
Message-ID: <CAHc6FU5Bag5W2t79+WzUq=NibtEF+7z6=jyNCkLMMp9Yqvpmqw@mail.gmail.com>
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

On Wed, Apr 27, 2022 at 1:33 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Apr 26, 2022 at 2:28 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> >
> > Btrfs has a comment in that place that reads:
> >
> >     /* No increment (+=) because iomap returns a cumulative value. */
>
> What a truly horrid interface. But you are triggering repressed
> childhood memories:
>
> > That's so that we can complete the tail of an asynchronous write
> > asynchronously after a failed page fault and subsequent fault-in.
>
> yeah, that makes me go "I remember something like that".
>
> > That would be great, but applications don't seem to be able to cope
> > with short direct writes, so we must turn partial failure into total
> > failure here. There's at least one xfstest that checks for that as
> > well.
>
> What a complete crock. You're telling me that you did some writes, but
> then you can't tell user space that writes happened because that would
> confuse things.
>
> Direct-IO is some truly hot disgusting garbage.
>
> Happily it's only used for things like databases that nobody sane
> would care about anyway.
>
> Anyway, none of that makes any sense, since you do this:
>
>                 ret = gfs2_file_direct_write(iocb, from, &gh);
>                 if (ret < 0 || !iov_iter_count(from))
>                         goto out_unlock;
>
>                 iocb->ki_flags |= IOCB_DSYNC;
>                 buffered = gfs2_file_buffered_write(iocb, from, &gh);
>
> so you're saying that the direct write will never partially succeed,
> but then in gfs2_file_write_iter() it very much looks like it's
> falling back to buffered writes for that case.
>
> Hmm. Very odd.
>
> I assume this is all due to that
>
>         /* Silently fall back to buffered I/O when writing beyond EOF */
>         if (iocb->ki_pos + iov_iter_count(from) > i_size_read(&ip->i_inode))
>
> thing, so this all makes some perverse kind of sense, but it still
> looks like this code just needs some serious serious commentary.

Yes, that, as well as writing into holes.

During direct writes, gfs2 is holding the inode glock in a special
"shared writable" mode which works like the usual "shared readable"
mode as far as metadata goes, but can be held by multiple "shared
writers" at the same time. This allows multiple nodes to write to the
storage device concurrently as long as the file is preallocated (i.e.,
databases). When it comes to allocations, it falls back to "exclusive"
locking and buffered writes.

> So you *can* have a partial write if you hit the end of the file, and
> then you'll continue that partial write with the buffered code.
>
> But an actual _failure_ will not do that, and instead return an error
> even if the write was partially done.
>
> But then *some* failures aren't failures at all, and without any
> comments do this
>
>         if (ret == -ENOTBLK)
>                 ret = 0;
>
>
> And remind me again - this all is meant for applications that
> supposedly care about consistency on disk?
>
> And the xfs tests actually have a *test* for that case, to make sure
> that nobody can sanely *really* know how much of the write succeeded
> if it was a DIO write?
>
> Gotcha.

I agree that it's pretty sad.

> > > The reason I think I'm full of sh*t is that you say that the problem
> > > occurs in gfs2_file_buffered_write(), not in that
> > > gfs2_file_direct_write() case.
> >
> > Right, we're having that issue with buffered writes.
>
> I have to say, compared to all the crazy things I see in the DIO path,
> the buffered write path actually looks almost entirely sane.
>
> Of course, gfs2_file_read_iter() counts how many bytes it has read in
> a variable called 'written', and gfs2_file_buffered_write() counts the
> bytes it has written in a variable called 'read', so "entirely sane"
> is all very very relative.
>
> I'm sure there's some good reason (job security?) for all this insanity.

Point taken; I'll fix this up.

> But I now have to go dig my eyes out with a rusty spoon.
>
> But before I do that, I have one more question (I'm going to regret
> this, aren't I?):
>
> In gfs2_file_buffered_write(), when it has done that
> fault_in_iov_iter_readable(), and it decides that that succeeded, it
> does
>
>                         if (gfs2_holder_queued(gh))
>                                 goto retry_under_glock;
>                         if (read && !(iocb->ki_flags & IOCB_DIRECT))
>                                 goto out_uninit;
>                         goto retry;
>
> so if it still has that lock (if I understand correctly), it will always retry.
>
> But if it *lost* the lock, it will retry only if was a direct write,
> and return a partial success for a regular write() rather than
> continue the write.
>
> Whaa? I'm assuming that this is more of that "direct writes have to
> succeed fully or not at all", but according to POSIX *regular* writes
> should also succeed fully, unless some error happens.
>
> Losing the lock doesn't sound like an error to me.

Regular (buffered) reads and writes are expected to be atomic with
respect to each other. That atomicity comes from holding the lock.
When we lose the lock, we can observe atomicity and return a short
result, ignore atomicity and return the full result, or retry the
entire operation. Which of those three options would you prefer?

For what it's worth, none of this matters as long as there's no lock
contention across the cluster.

> And there are a lot of applications that do assume "write to a regular
> file didn't complete fully means that the disk is full" etc. Because
> that's the traditional meaning.
>
> This doesn't seem to be related to any data corruption issue, but it does smell.
>
>              Linus

Thanks,
Andreas

