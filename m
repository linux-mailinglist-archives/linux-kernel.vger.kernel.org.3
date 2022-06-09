Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2E5545400
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345370AbiFISU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344542AbiFISUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:20:24 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990183B4ED7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 11:20:21 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 25so32014134edw.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 11:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xn/hwZLPqEWB5QNEebP5GcNs/MbfMlU9mHoXwzh2zig=;
        b=TlOxiY2dGH16uFmP+ba1Q9obiwZ5p4+5ICySD84KgaNgQLlPMIcfTkwxm/6XRBfUJ9
         67McR6INB/svlqqb3+AwXBVgIgoS3EV+7KUHoeba4bJbIv86VtUsbVhpW0pbEZdmtPz0
         0S0ArH6CWpnppMrFFDGlzirSwfobufrx12vwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xn/hwZLPqEWB5QNEebP5GcNs/MbfMlU9mHoXwzh2zig=;
        b=ZXNg5I20hFRaorKeeuMylPiQJbYhHvlgtorZm7ctw9ZwcokUdfXhRklATzKos50c8q
         cm9FWQatqGA3G14SKwbogmkb32sCoI5PR1lt/LMGAsfVtXOjdthz/rztIoBDwHPCiKvm
         W+lTHXqTN3+kLX+KV3LRWKuo1/XjATMMiyxDbBZprWfncI4cZX0Z+4bS6/ZluvE6xaEg
         9WZlK+Zvdue693QzE9cf4U751gj84GP2mmMCqpy7QExfQlNgii0ex5pq1zpdYj4+J3q4
         BUGzRCLE153NDxujHDik0xdJSQd7R+xfGjoS4kAW9mB5b4Y3N6/Bt6iMpLS31gdVTXuN
         qL1A==
X-Gm-Message-State: AOAM530V9ztKGq7UFxBOen5WCDyxFugK4D74Ys1E9yKs4zafwMLHDf7K
        kZJ7+/FNI8lN7DyDxh3QxAuBh6eSpDebIdXY
X-Google-Smtp-Source: ABdhPJywZyHqGP9EI+pcNqZhKZsbxVaCkfOWwZl3sjVGOw08mePsGkg91KpLQ1WztCf5bE2UHxwmRg==
X-Received: by 2002:aa7:cd52:0:b0:42d:d656:a49f with SMTP id v18-20020aa7cd52000000b0042dd656a49fmr47849419edw.383.1654798820051;
        Thu, 09 Jun 2022 11:20:20 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id k26-20020a17090632da00b006fec3b2e4f3sm10817528ejk.205.2022.06.09.11.20.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 11:20:19 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id k16so33526561wrg.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 11:20:19 -0700 (PDT)
X-Received: by 2002:a05:6000:1b0f:b0:210:313a:ef2a with SMTP id
 f15-20020a0560001b0f00b00210313aef2amr39019745wrz.281.1654798818835; Thu, 09
 Jun 2022 11:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220422134308.1613610-1-svens@linux.ibm.com> <202204221052.85D0C427@keescook>
 <CAHk-=wjahn2fZtMxmc4D9UOUGWVws1wZ=X46jrTV=_tEpzXeoA@mail.gmail.com>
 <202206081404.F98F5FC53E@keescook> <CAHk-=wiFn-_OaWKY=nXt3YSiy=obrNoQW_u7zKO7qoArez=GUw@mail.gmail.com>
 <AEEBCF5D-8402-441D-940B-105AA718C71F@chromium.org> <CAHk-=wh6+KUi+T8Ncn6BWTHDTJCzrJxgT47SWbq-ZWs1_vbvHA@mail.gmail.com>
 <4147483.1654784079@warthog.procyon.org.uk>
In-Reply-To: <4147483.1654784079@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Jun 2022 11:20:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5hoE19YNniN+cquGT6H2z1BefbBo7UwE4-oySW86BxA@mail.gmail.com>
Message-ID: <CAHk-=wj5hoE19YNniN+cquGT6H2z1BefbBo7UwE4-oySW86BxA@mail.gmail.com>
Subject: Re: [PATCH] s390: disable -Warray-bounds
To:     David Howells <dhowells@redhat.com>
Cc:     Dave Chinner <dchinner@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 9, 2022 at 7:14 AM David Howells <dhowells@redhat.com> wrote:
>
> Note that Dave Chinner would rather I converted code like:
>
>         struct myfs_inode *myfsinode = xyz;
>         myfsinode->netfs.inode.i_ino = 123;
>
> to something like:
>
>         struct myfs_inode *myfsinode = xyz;
>         struct inode *inode = VFS_I(myfsinode);
>         inode->i_ino = 123;
>
> where the translation is wrapped inside a VFS_I() macro in every filesystem
> and wants this across all filesystems.

What? No. That's absolutely disgusting.

Maybe I'm mis-undestanding.

The usual way filesystems should handle this is that they have their
own inode information that contains a 'struct inode', and then they
have an inline function to go from that generic VFS inode to their one
using "container_of()".

And yeah, maybe they call that container_of() thing MYINODE() or
something, although I think an inline function without the ugly
all-uppercase is right.

But the way they go the other way is literally to just dereference the
inode that they have, ie they just use a

        if (S_ISREG(inode->vfs_inode.i_mode)) ..

kind pattern. There's no reason or excuse to try to "wrap" that, and
it would be a big step backwards to introduce some kind of VFS_I()
macro.

There's also no reason to make that generic. At no point should you
ever go from "random filesystem inode" to "actual generic VFS inode"
in some uncontrolled manner.

But maybe Dave is talking about something else, and I'm missing the point.

            Linus
