Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85925458E6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 01:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237871AbiFIX7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 19:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiFIX7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 19:59:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6DA0237943
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 16:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654819175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HZmJDZ9hQK0bNfmPnAorsPdU9x3OOxEaC2i3SyIrcpc=;
        b=AQ6BpzplLkPCPtjRb/jpDfYmvcvsO5kmkGtchoueXPIITBBRIjFIWlMPo8DFxn0T8Qnf32
        1sVc43YT4NPJF+zD2+euv1CPKS4cLpigPO0/uxDQMKqsyNRXm6gSvtR8DjasTs6m9pQ+OB
        0Dv0VRATZa1RTZ0qcBfyoXptzphTHn0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-c-TqIG6yNmK9PlqI69ymhQ-1; Thu, 09 Jun 2022 19:59:32 -0400
X-MC-Unique: c-TqIG6yNmK9PlqI69ymhQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D795E1C04B4F;
        Thu,  9 Jun 2022 23:59:31 +0000 (UTC)
Received: from rh (vpn2-54-75.bne.redhat.com [10.64.54.75])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 361B81121314;
        Thu,  9 Jun 2022 23:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=rh)
        by rh with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <dchinner@redhat.com>)
        id 1nzS3k-00H7Qv-34; Fri, 10 Jun 2022 09:59:28 +1000
Date:   Fri, 10 Jun 2022 09:59:25 +1000
From:   Dave Chinner <dchinner@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
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
Subject: Re: [PATCH] s390: disable -Warray-bounds
Message-ID: <YqKJXf6dif2emugf@rh>
References: <20220422134308.1613610-1-svens@linux.ibm.com>
 <202204221052.85D0C427@keescook>
 <CAHk-=wjahn2fZtMxmc4D9UOUGWVws1wZ=X46jrTV=_tEpzXeoA@mail.gmail.com>
 <202206081404.F98F5FC53E@keescook>
 <CAHk-=wiFn-_OaWKY=nXt3YSiy=obrNoQW_u7zKO7qoArez=GUw@mail.gmail.com>
 <AEEBCF5D-8402-441D-940B-105AA718C71F@chromium.org>
 <CAHk-=wh6+KUi+T8Ncn6BWTHDTJCzrJxgT47SWbq-ZWs1_vbvHA@mail.gmail.com>
 <4147483.1654784079@warthog.procyon.org.uk>
 <CAHk-=wj5hoE19YNniN+cquGT6H2z1BefbBo7UwE4-oySW86BxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj5hoE19YNniN+cquGT6H2z1BefbBo7UwE4-oySW86BxA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 11:20:02AM -0700, Linus Torvalds wrote:
> On Thu, Jun 9, 2022 at 7:14 AM David Howells <dhowells@redhat.com> wrote:
> >
> > Note that Dave Chinner would rather I converted code like:
> >
> >         struct myfs_inode *myfsinode = xyz;
> >         myfsinode->netfs.inode.i_ino = 123;
> >
> > to something like:
> >
> >         struct myfs_inode *myfsinode = xyz;
> >         struct inode *inode = VFS_I(myfsinode);
> >         inode->i_ino = 123;
> >
> > where the translation is wrapped inside a VFS_I() macro in every filesystem
> > and wants this across all filesystems.
> 
> What? No. That's absolutely disgusting.
> 
> Maybe I'm mis-undestanding.

Perhaps, because I think what I said looks very different when taken
out of context.

I saw a heap of different implementations of the same thing with no
consistency across them (i.e. inode container definitions) and a
mess of a patch to convert them without solving the problem that
there's no consistent convention for doing filesystem inode -> VFS
inode container conversion

> The usual way filesystems should handle this is that they have their
> own inode information that contains a 'struct inode', and then they
> have an inline function to go from that generic VFS inode to their one
> using "container_of()".
> 
> And yeah, maybe they call that container_of() thing MYINODE() or
> something, although I think an inline function without the ugly
> all-uppercase is right.

Right, BTRFS_I(), EXT4_I(), F2FS_I(), AFS_FS_I(), P9FS_I(), etc.

It's a convention, it dates back to macro days (hence upper case
even though most are static inlines these days), and it obvious no
matter what filesystem code I read that when I see this XXX_I(inode)
convention I know the code is accessing the filesystem inode in the
container, not the VFS indoe.

> But the way they go the other way is literally to just dereference the
> inode that they have, ie they just use a
> 
>         if (S_ISREG(inode->vfs_inode.i_mode)) ..

The problem with this is that we have very similar names in both the
VFS inode and the filesysetm inodes (e.g. i_flags), and without a
clear demarcation of which inode is being referenced it can lead to
confusion and bugs.

> kind pattern. There's no reason or excuse to try to "wrap" that, and
> it would be a big step backwards to introduce some kind of VFS_I()
> macro.

If the result of adding a helper convention is that every reverse
inode container resolution looks identical across all filesystems,
then we no longer have to know the details of the fs specific
container to get the conversion right. All the code across all the
filesystems would look the same, even though the wrapper would be
different.

We do helper conversions like this all the time to make the code
easier to read, understand and maintain, so I really don't see why
this would be considered a step backwards....

> There's also no reason to make that generic. At no point should you
> ever go from "random filesystem inode" to "actual generic VFS inode"
> in some uncontrolled manner.

We never do any conversions in an uncontrolled manner. We often need
to go from fs inode to vfs inode because we are deep in filesystem
implementation code passing around filesystem inodes, but the piece
of information we need to access is stored in the VFS inode (e.g.
uid, gid, etc). That's what this netfs inode container was requiring
in the patchset...

> But maybe Dave is talking about something else, and I'm missing the point.

Perhaps - my comment was not about the VFS_I() name or implementation;
I used it simply because I can point at code that uses it as an
example of having a symmetric, easily recognisable convention.

My point was that the fs inode to vfs inode conversion is a common
operation performed across all filesystems that lacks any
consistency in implementation. Some filesystems use a symmetric API
for these container conversions and so I was simply suggesting that
converting them all to use a common symmetric convention would
simplify the maintenance of filesystem code in future and make it
easier for other people to understand...

Cheers,

Dave.
-- 
Dave Chinner
dchinner@redhat.com

