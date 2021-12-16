Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023E3477CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241119AbhLPTwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbhLPTwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:52:30 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69172C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 11:52:30 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id y13so90843068edd.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 11:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1YEg3xCizKQigIIVaj+7NPGS0vV5YzouOWDo8EKHI8Y=;
        b=dGLplsJKLLH7R55fT9CGKpQ+QAOXByetGDAZO4Qe5hOY96iYDADZXPv6IaRTnkyzZU
         YI08eiKnx/i5FnO61PQJoSbspOCrTKasx1Wska9nu2oEvPHzOmLFcQpapSbFWwnZ/gZJ
         a5Drpm7Pl4iYA3ZnJI1TCTMw/SmbnFNAdcPBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1YEg3xCizKQigIIVaj+7NPGS0vV5YzouOWDo8EKHI8Y=;
        b=4+5/zbf8S5v/k69C95MSApbv4/HOJhq9X+LE9JIhRF9+e9TY+REVjR7UXhZUr56fmc
         Qcln8BcloFB5TZECWqkH4/iixRWFrGOqzEev+CvzKJRj8SfaWjObSKflAqwhjLSttMwD
         HxkMfGckbZVTf6518hXTUq01I7UbbPhXiM/UM6XaGbmOnA2kPHHu7X12v6rQEGMQszUp
         fRQCF/I1zaVJ/dgcb888ShNbPePt6OL8n3vjQEjmMZLh1ctJH8DXWdpF0W7Y8giI+OV8
         i3Naapf/CAxSshYRe5+v0IpmSIOhMxCBnwYBaStK86H5HK21HEnM9FxgtIVhdXwC/5ui
         VUWA==
X-Gm-Message-State: AOAM533o1yj+HhUNWR9+EtTPyivWAZm83Qw6B6Ejn6jXUq3vUSP6740i
        TDgtlDvG09aWfvSBIGbyKJFG9BoSisvg6wwh/ts=
X-Google-Smtp-Source: ABdhPJyJ5DFQdHVqco6bJNGXNavnod2mIZN3RCz9DZ3QQ9VktBMzzP3GDYpF12Vvom3x/0rtDQAohA==
X-Received: by 2002:a17:906:d54d:: with SMTP id cr13mr16872294ejc.409.1639684348859;
        Thu, 16 Dec 2021 11:52:28 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id hy13sm2096615ejc.142.2021.12.16.11.52.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 11:52:28 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id z29so10761671edl.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 11:52:28 -0800 (PST)
X-Received: by 2002:a5d:4575:: with SMTP id a21mr10519052wrc.193.1639683994422;
 Thu, 16 Dec 2021 11:46:34 -0800 (PST)
MIME-Version: 1.0
References: <163967073889.1823006.12237147297060239168.stgit@warthog.procyon.org.uk>
 <163967169723.1823006.2868573008412053995.stgit@warthog.procyon.org.uk>
 <CAHk-=wi0H5vmka1_iWe0+Yc6bwtgWn_bEEHCMYsPHYtNJKZHCQ@mail.gmail.com> <YbuTaRbNUAJx5xOA@casper.infradead.org>
In-Reply-To: <YbuTaRbNUAJx5xOA@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Dec 2021 11:46:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh2dr=NgVSVj0sw-gSuzhxhLRV5FymfPS146zGgF4kBjA@mail.gmail.com>
Message-ID: <CAHk-=wh2dr=NgVSVj0sw-gSuzhxhLRV5FymfPS146zGgF4kBjA@mail.gmail.com>
Subject: Re: [PATCH v3 56/68] afs: Handle len being extending over page end in write_begin/write_end
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 11:28 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> Since ->write_begin is the place where we actually create folios, it
> needs to know what size folio to create.  Unless you'd rather we do
> something to actually create the folio before calling ->write_begin?

I don't think we can create a folio before that, because the
filesystem may not even want a folio (think persistent memory or
whatever).

Honestly, I think you need to describe more what you actually want to
happen. Because generic_perform_write() has already decided to use a
PAGE_SIZE by the time write_begin() is called,

Right now the world order is "we chunk things by PAGE_SIZE", and
that's just how it is.

I can see other options - like the filesystem passing in the chunk
size when it calls generic_perform_write().

Or we make the rule be that ->write_begin() simply always is given the
whole area, and the filesystem can decide how it wants to chunk things
up, and return the size of the write chunk in the status (rather than
the current "success or error").

But at no point will this *EVER* be a "afs will limit the size to the
folio size" issue. Nothing like that will ever make sense. Allowing
bigger chunks will not be about any fscache issues, it will be about
every single filesystem that uses generic_perform_write().

So I will NAK these patches by David, because they are fundamentally
wrong, whichever way we turn. Any "write in bigger chunks" patch will
be something else entirely.

                 Linus
