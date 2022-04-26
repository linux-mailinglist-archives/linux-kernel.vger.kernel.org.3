Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6F5510B42
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355429AbiDZVbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345063AbiDZVbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:31:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3F6D36309
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651008479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1NNKOdd5hZdCc2XebY34PtdRYhwF5gKDIS0ZR9VPR4M=;
        b=QU72NuP9Qu9am0pCkhox7kietmZ6hOIa47/vx1eS/dcFElK+/ADAKMFWRHyId0IQU4V72S
        NsmmEthTVZpZmbyvcRU+3e9lP/Ovykh0Kg52XGvFdIaAaSIPsF8xTOlWISxB04JkrIuGSB
        SNR8viLxGfvuq7wE4VDzFKp60oOtPK0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-uqI3RtVCNCC81wQEIkfP3A-1; Tue, 26 Apr 2022 17:27:57 -0400
X-MC-Unique: uqI3RtVCNCC81wQEIkfP3A-1
Received: by mail-wm1-f72.google.com with SMTP id m125-20020a1c2683000000b00391893a2febso53266wmm.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1NNKOdd5hZdCc2XebY34PtdRYhwF5gKDIS0ZR9VPR4M=;
        b=Y834NRvrfM5Zm1DbwNg+q9yDCg+DxOiJ8/8V9iMq7SCfH5xdVHLafeETbBHCjX2Jxx
         XzKU9oj5xO98IXIeZARd2DKLHlTO/YRJCfKkTAdSdYmNWcQRMrBxAZvLsP9YObPQCFCs
         3TBmtO+M7Qv8TWFuuhVuk0OLftAFEPo6wW2fTK7VUZkeYr8MtHYeHxy4RIPkg3PCMcF5
         FqEE/bjv/XoMYdY0MXLsRp4DSKOswRqSUqEcq6OWWYod22VlllIvEhlA9pOmYdQ55AEc
         ofGW9iremLmYhcXIhkmqkURg/vKZRoAIKYeY3Csuwc+Wtj0iUjqJuPS0tiJpOQqQm3M5
         XOdw==
X-Gm-Message-State: AOAM532dL/xQtRYNq1OY6GqRybsIhcHGOtlyc80JnO36xsjh0P793tu3
        xwaL18HQxPslDxJqcqeqom1QYeKefZ/xcAfrp+Zp7OLiJ4cEdKfjPq6CFsoImmsYEqXTti82u8f
        vsJdY+UvPfJYE8dpWUVLkiNyBe6j4cnOSHQUKPu7V
X-Received: by 2002:adf:f30a:0:b0:20a:e193:6836 with SMTP id i10-20020adff30a000000b0020ae1936836mr5979572wro.654.1651008476388;
        Tue, 26 Apr 2022 14:27:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz20rdg10F+wFBi4E6/EIxV7+oYM5DUa60mPxLlG5194kUNCrOFLQFcxaQdh1Qmb5CaNATHy1CbyKQKtBo3464=
X-Received: by 2002:adf:f30a:0:b0:20a:e193:6836 with SMTP id
 i10-20020adff30a000000b0020ae1936836mr5979558wro.654.1651008476200; Tue, 26
 Apr 2022 14:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220426145445.2282274-1-agruenba@redhat.com> <CAHk-=wi7o+fHYBTuCQQdHD112YHQtO21Y3+wxNYypjdo8feKFg@mail.gmail.com>
In-Reply-To: <CAHk-=wi7o+fHYBTuCQQdHD112YHQtO21Y3+wxNYypjdo8feKFg@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 26 Apr 2022 23:27:44 +0200
Message-ID: <CAHc6FU48681X8aUK+g7UUN7q5b6rkVBzTP7h_zbE4XqZYAiw3g@mail.gmail.com>
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

On Tue, Apr 26, 2022 at 8:31 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Apr 26, 2022 at 7:54 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> >
> > Also, note that we're fighting with a rare case of data corruption that
> > seems to have been introduced by commit 00bfe02f4796 ("gfs2: Fix mmap +
> > page fault deadlocks for buffered I/O"; merged in v5.16).  The
> > corruption seems to occur in gfs2_file_buffered_write() when
> > fault_in_iov_iter_readable() is involved.  We do end up with data that's
> > written at an offset, as if after a fault-in, the position in the iocb
> > got out of sync with the position in the iov_iter.  The user buffer the
> > iov_iter points at isn't page aligned, so the corruption also isn't page
> > aligned.  The code all seems correct and we couldn't figure out what's
> > going on so far.
>
> So this may be stupid, but looking at gfs2_file_direct_write(), I see
> what looks like two different obvious bugs.
>
> This looks entirely wrong:
>
>         if (ret > 0)
>                 read = ret;
>
> because this code is *repeated*.
>
> I think it should use "read += ret;" so that if we have a few
> successful reads, they add up.

Btrfs has a comment in that place that reads:

    /* No increment (+=) because iomap returns a cumulative value. */

That's so that we can complete the tail of an asynchronous write
asynchronously after a failed page fault and subsequent fault-in.

> And then at the end:
>
>         if (ret < 0)
>                 return ret;
>         return read;
>
> looks wrong too, since maybe the *last* iteration failed, but an
> earlier succeeded, so I think it should be
>
>         if (read)
>                 return read;
>         return ret;
>
> But hey, what do I know. I say "looks like obvious bugs", but I don't
> really know the code, and I may just be completely full of sh*t.

That would be great, but applications don't seem to be able to cope
with short direct writes, so we must turn partial failure into total
failure here. There's at least one xfstest that checks for that as
well.

> The reason I think I'm full of sh*t is that you say that the problem
> occurs in gfs2_file_buffered_write(), not in that
> gfs2_file_direct_write() case.

Right, we're having that issue with buffered writes.

> And the *buffered* case seems to get both of those "obvious bugs" right.
>
> So I must be wrong, but I have to say, that looks odd to me.
>
> Now hopefully somebody who knows the code will explain to me why I'm
> wrong, and in the process go "Duh, but.." and see what's up.

Thanks for pointing out the places that seem odd to you. You'll not be
the only one.

Andreas

