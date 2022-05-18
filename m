Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4076952B95D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 14:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbiERL6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbiERL56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:57:58 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3DA24093
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 04:57:57 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id wh22so3190088ejb.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 04:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1AQVLqL8oPCsWqIf0y5cLrjgJaveJU57q/bnqY+Bcwc=;
        b=oy5BQ1sPa+NNYI44WvlAhaedelel72TvA+F0iA95vikBTLLK/78vZ+B3nN3vxgrIHZ
         1ub3KAZd6byRBhiUxivonltflM0hRYEm7ah6fM1zbSbnT13QLxV7WAzmrOsyn/gkY975
         /VQOv6SrG1Dv2Vq0c58Z9F+EMLND4vnSrCvyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1AQVLqL8oPCsWqIf0y5cLrjgJaveJU57q/bnqY+Bcwc=;
        b=WlS/vIARezwr+oIYNbGhvVycUw2qNTfYjG2kZGNvx2lg1zTtG6PbsKsYR7ONkVm6wF
         7KMz8V2c1/m/Fw/eVs7yB6CF2mALop9qzS08OpTGlNuHl9zfkZPsmckK9uA9gcecYMbO
         AnRXynYEpsVNkyHealrFxzt880/GS6q21tXuOLCPtK3DfN7FgPlVIsifIOHcI3TQspkb
         esCGD8Njiujhc31+gbilvsG9RRCB3WTxOFzeBU9nn2aLNpxC2/60f7JbHmXzCJwiIuWk
         8Mt6F8KJLIOiBh7vdbsQ/ms1I+RRjLpvOQA/1G/rVB8w/Ulb3+QCPqnmuF4/ySdddt9+
         avlQ==
X-Gm-Message-State: AOAM532I77qDYI0THf4l/TFIE31jchavUvEwL3Bm91hn4Jg8K1/jFGdX
        H3M4nIGLaNb3l6Iee6JPONQ3NBNzWCu0c+bcqLqmwA==
X-Google-Smtp-Source: ABdhPJwxUucUZ5jQkIxILawVnBHu4LaNFhal53sVL/JVRbmmLUpb/dQrdpadwZ931FvDV3vgHVdeI22o598w+yO6yeE=
X-Received: by 2002:a17:907:6e9e:b0:6fe:8d81:b4a3 with SMTP id
 sh30-20020a1709076e9e00b006fe8d81b4a3mr1443382ejc.748.1652875076330; Wed, 18
 May 2022 04:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220511222910.635307-1-dlunev@chromium.org> <20220512082832.v2.2.I692165059274c30b59bed56940b54a573ccb46e4@changeid>
 <YoQfls6hFcP3kCaH@zeniv-ca.linux.org.uk> <YoQihi4OMjJj2Mj0@zeniv-ca.linux.org.uk>
In-Reply-To: <YoQihi4OMjJj2Mj0@zeniv-ca.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 18 May 2022 13:57:45 +0200
Message-ID: <CAJfpegtQUP045X5N8ib1rUTKzSj-giih0eL=jC5-MP7aVgyN_g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] FUSE: Retire superblock on force unmount
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Daniil Lunev <dlunev@chromium.org>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022 at 00:32, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, May 17, 2022 at 10:20:06PM +0000, Al Viro wrote:
> > On Thu, May 12, 2022 at 08:29:10AM +1000, Daniil Lunev wrote:
> > > Force unmount of FUSE severes the connection with the user space, even
> > > if there are still open files. Subsequent remount tries to re-use the
> > > superblock held by the open files, which is meaningless in the FUSE case
> > > after disconnect - reused super block doesn't have userspace counterpart
> > > attached to it and is incapable of doing any IO.
> >
> >       Why not simply have those simply rejected by fuse_test_super()?
> > Looks like that would be much smaller and less invasive patch...
> > Confused...
>
> ... because Miklos had suggested that, apparently ;-/  I disagree -
> that approach has more side effects.  "mount will skip that sucker" is,
> AFAICS, the only effect of modiyfing test_super callback(s); yours, OTOH...

Yep, messing with the bdi doesn't look good.  Fuse always uses a
private bdi, so it's not even necessary.

Just removing from type->fs_supers should not have any side effects,
at least I can't spot any.

Fixing fuse_test_super() is not sufficient, as the fuseblk type goes
though get_tree_bdev().  That could be tweaked as well, but it would
end up with more complexity.

Thanks,
Miklos
