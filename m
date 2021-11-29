Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2FD54625AE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbhK2Wmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbhK2Wlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:41:53 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0126BC03AD6A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 10:13:13 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x6so75325104edr.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 10:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A1KpMLhPpZ3DtBAJ2H7WA1+eK6RBPvYL8JCpapFonpw=;
        b=hYrTDwhmtIHMqqbXGO1Kse+Z0mztn57tvq1yPxTQ6q8If5SiUN3r2mIlQQuhqQ5Ciu
         K5ZjiwPNhDNHwoG8b/skXzWnqGGnw5Xo6Kz7rDlvP/WRSBwiwJnbIMXZ+5EJLE2YnPsh
         8oCcdh7mNJuIoeX8m73ktIFQqXot2Q8wW5BQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A1KpMLhPpZ3DtBAJ2H7WA1+eK6RBPvYL8JCpapFonpw=;
        b=jf5hByjhuJjjwrNDQHhQJvHPQMMf8fcR+0bc0TPk4h3QNY/7YUDtUiM+Hdn/s3MF55
         DnIUGPlXCzLQfLSHLVQjII1H/AATSdSsON7foUCF473CwwkIMf33y229ubT45jcfsy/L
         iLuwYREN9/eWqSbh+EA7kZa8OD+DgHqbiIy9SDZwN7iZL6FiN3qLiJYCd/v+D+0LVu88
         iGkgbPKp+y60J20ko9syxG+X5JOf/UPQzs45C9Jcu5a51V+qiX+M100npc7p+o1DLPJ7
         4LrSQgGj+6Y0CP0N8ECgsY2ysqTNF0hrXURJ0mR9xw4rgo7nFv9FGOJUmRtkjtGw0f3Y
         hNyg==
X-Gm-Message-State: AOAM531Pri21iKUCw8y8k8ZB79iCuCg5usmz4wWSaKB0eCNdBycgQkf0
        j1+BjL/wRzuptaqBO8LRa2cbf2YANHAFK8CS0EE=
X-Google-Smtp-Source: ABdhPJwc43t40FIpqH+gTjPL2RmSU8ZobEPHhqyc/+gdhjUhryXgbtEmSRCjKdgEe05zdyspcopUSw==
X-Received: by 2002:a17:906:8256:: with SMTP id f22mr61868668ejx.207.1638209592373;
        Mon, 29 Nov 2021 10:13:12 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id e4sm8254344ejs.13.2021.11.29.10.13.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 10:13:12 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id a9so38762355wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 10:13:12 -0800 (PST)
X-Received: by 2002:adf:9d88:: with SMTP id p8mr36748101wre.140.1638209581186;
 Mon, 29 Nov 2021 10:13:01 -0800 (PST)
MIME-Version: 1.0
References: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
In-Reply-To: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Nov 2021 10:12:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=whGOEEb4n2_y3mnrmeNx4HYjRA-m=xMPDQD=bHWfB5chw@mail.gmail.com>
Message-ID: <CAHk-=whGOEEb4n2_y3mnrmeNx4HYjRA-m=xMPDQD=bHWfB5chw@mail.gmail.com>
Subject: Re: [PATCH 00/64] fscache, cachefiles: Rewrite
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, Jeff Layton <jlayton@kernel.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-afs@lists.infradead.org, Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trondmy@hammerspace.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        ceph-devel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 6:22 AM David Howells <dhowells@redhat.com> wrote:
>
> The patchset is structured such that the first few patches disable fscache
> use by the network filesystems using it, remove the cachefiles driver
> entirely and as much of the fscache driver as can be got away with without
> causing build failures in the network filesystems.  The patches after that
> recreate fscache and then cachefiles, attempting to add the pieces in a
> logical order.  Finally, the filesystems are reenabled and then the very
> last patch changes the documentation.

Thanks, this all looks conceptually sane to me.

But I only really scanned the commit messages, not the actual new
code. That obviously needs all the usual testing and feedback from the
users of this all..

                    Linus
