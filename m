Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58893497802
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 05:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241315AbiAXESx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 23:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbiAXESw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 23:18:52 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CF5C06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 20:18:52 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id a21so18783131qkn.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 20:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=DNIku5FnVf9Yc0jUk/VdfLTwI1o1TUiRN+Ozpno+CZ4=;
        b=QPp2hsAA/da6vtCaGomUTSUmlGb9etpLRH1DeL/Y2uFreS6ikyFvBfGVbly6lYZLNn
         suFgx/QvRbsUjFownsBQ+lxYsbf2Xi56Y+Utq4qhFfy2A+gqkZBRtN7pJfco/87J/1a6
         UCV+rkiPvOy/IUAKW2fV5BVz8g2m5xEJnP4a32Ooi7wD35zrQMdKkjmbkge9nCipkFGC
         abRxx43+nf/GY9394HAMCgeXz2pFnadXJAFmyP4tcKg43y/Uqs9MghXDH2uOL44XKqoJ
         PZQoQZ7FdqVcdL2sqq9UGR9oc9QfPUOU3U9LQL6LTEipY7pcrDn1PKTZM6vCDgrf3O34
         s9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=DNIku5FnVf9Yc0jUk/VdfLTwI1o1TUiRN+Ozpno+CZ4=;
        b=D209NkULPX2Neo9xGEKCYniHL4QXCzPfdIZE/82F/XpW8VCRdFRv8Njt3DrA5NaTNx
         xI6k9COwB7Bw9A5JQbGlB67MYKzerOwIKpbOyEuOy1UE5oyYdadlNPHHc+Cfb+Ik7P+2
         4GweGH0hrh22cNhDbrBNUHmYEFx9UE78hbpufhG+hLVmxQoYvlcZaA7otDp4cvhjjR8h
         yQk37iTu9YTBkq5t3gcTsDSv5cigTqUCTX1hSAkehUAAS14tq5gpKmzYgNj+4J6re270
         i2KzI6ZKoVF+zriHMDOO3+0pAx02TVpxXc184FQaiUPyex7s+uaNpOQGmRP43i7RRFfc
         wvCw==
X-Gm-Message-State: AOAM530ninxnHPDGaDZBr3JcILN7ympxnU4S28M5BXyaZd5dPYWBXyoH
        MoothAoW4a7haCZXSIuh6dY+mw==
X-Google-Smtp-Source: ABdhPJwr32D9xveqwZ4WpKtvL7HGQHuhthubZEmjwvO01h48jNrzu3+wKhgZazfK+xG36qhv7dTkgQ==
X-Received: by 2002:ae9:ed81:: with SMTP id c123mr5901qkg.447.1642997931019;
        Sun, 23 Jan 2022 20:18:51 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id bm3sm6708342qkb.5.2022.01.23.20.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 20:18:50 -0800 (PST)
Date:   Sun, 23 Jan 2022 20:18:36 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Aleksa Sarai <cyphar@cyphar.com>
cc:     Kir Kolyshkin <kolyshkin@gmail.com>, linux-man@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        David Herrmann <dh.herrmann@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fcntl.2: document F_GET_SEALS on tmpfs peculiarity
In-Reply-To: <20220122090441.ktxh43lpgsd2dxj4@senku>
Message-ID: <d7ca2658-b63b-7437-9bd0-82bc59c7c981@google.com>
References: <20220122005251.1441343-1-kolyshkin@gmail.com> <20220122090441.ktxh43lpgsd2dxj4@senku>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jan 2022, Aleksa Sarai wrote:

> Adding the maintainers of mm/{shmem,memfd}.c and fs/hugetlbfs/ just in
> case this was not intended behaviour.

Kir is correct - thanks - and it is intended behaviour.  Not consciously
intended to make for a difficult manpage, but the implementation was
intended to be simple, so tmpfs and hugetlbfs do not internally
distinguish memfd objects from filesystem files - their filesystem
files simply start off with F_SEAL_SEAL to rule out any sealing.

> 
> On 2022-01-21, Kir Kolyshkin <kolyshkin@gmail.com> wrote:
> > Currently, from the description of file sealing it can be deduced that
> > unless the fd is a memfd, all sealing operations fail with EINVAL.
> > 
> > Apparently, it's not true for tmpfs or hugetlbfs -- F_GET_SEALS returns
> > 1 (F_SEAL_SEAL) for an fd opened on these filesystems (probably because
> > those are used to back memfd files).
> > 
> > Fix the description to mention that peculiarity. Not knowing this can
> > result in incorrect code logic (see [1], where the code mistook a
> > descriptor of a file opened on on tmpfs for a memfd).
> > 
> > While at it, clarify that fcntl does not actually return EINVAL, but
> > sets errno to it (as it is usually said elsewhere).
> > 
> > [1] https://github.com/opencontainers/runc/pull/3342
> > 
> > Cc: Aleksa Sarai <cyphar@cyphar.com>
> > Cc: David Herrmann <dh.herrmann@gmail.com>
> > Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>

Acked-by: Hugh Dickins <hughd@google.com>

> > ---
> >  man2/fcntl.2 | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/man2/fcntl.2 b/man2/fcntl.2
> > index 7b5604e3a..f951b05ff 100644
> > --- a/man2/fcntl.2
> > +++ b/man2/fcntl.2
> > @@ -1402,10 +1402,23 @@ file seals can be applied only to a file descriptor returned by
> >  (if the
> >  .B MFD_ALLOW_SEALING
> >  was employed).
> > -On other filesystems, all
> > +On all other filesystems, except
> > +.BR tmpfs (5)
> > +and
> > +.BR hugetlbfs ,
> > +all
> >  .BR fcntl ()
> > -operations that operate on seals will return
> > +operations that operate on seals will fail with
> > +.I errno
> > +set to
> >  .BR EINVAL .
> > +For a descriptor from a file on
> > +.BR tmpfs (5)
> > +or
> > +.BR hugetlbfs ,
> > +.B F_GET_SEALS
> > +returns
> > +.BR F_SEAL_SEAL .
> >  .PP
> >  Seals are a property of an inode.
> >  Thus, all open file descriptors referring to the same inode share
> > -- 
> > 2.33.1
> > 
> 
> -- 
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> <https://www.cyphar.com/>
