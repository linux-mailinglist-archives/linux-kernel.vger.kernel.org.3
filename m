Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012D7477952
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 17:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhLPQia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 11:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhLPQi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:38:29 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C46BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 08:38:29 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id k23so39434327lje.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 08:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/0tfi6GWjQ8PFg1rClE3QlQWN0cjd+HtwnOPSpFHrtM=;
        b=ZUmg4A/7HjP6eAASANt+4keQHSopn9fF9fVMthVZu/c/YjSSrDTZVizCt53w3pjZTz
         ALdrT2CetN7y0UB7HWM9QXKDG/IjiRvTGiiwA+eAdMgcIrCfVT3wEDCrbPcgGrLjCxw0
         amQe/8kTyLnJyS+EwJHlBCCyQJgU9esnPnqpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0tfi6GWjQ8PFg1rClE3QlQWN0cjd+HtwnOPSpFHrtM=;
        b=AumLel8siTZjXoFff+4R1ZiNxeBy5FIA35nZeF85lWsbrA7YgcO1ElRHL91c6I1GGj
         fahxXXvhgLo6OYQWhq4QtDZKJ4xp03GrIkjIJNQsY8VSRmNQmKojHAbWNUBomoUtyiiN
         haOcr7DQe8GDvqaMV6WefetGDhMKhQ+of3eMpJvRtvOk4fy9+TM6TKEIAG76xVSJZ4w3
         GZA9pSb3yCRxmMb4RTzYBlor2ZiBTPKjV/qhwpelUM84u503WSeVLWcOgP7e8SA9Ssib
         JD3oS8Q7FpJHHmOYQSxUZjqj8bbVZ594meoyP/goDBkUP9yMLKSEbRO9IovMnlnAserc
         IVLQ==
X-Gm-Message-State: AOAM532xDdmtXVT/J1XXNOnBQE9sAzAT42VF1M75ZwHFnQEGNwWM9u+y
        fU5TqW3ymAZcnROcWEG/NrABaID6Vje8iO85O+Y=
X-Google-Smtp-Source: ABdhPJyHZql+BS6yUK65ikTtMiHyf/74EpHx1tmK/MkDMszuHgsAPXAYbgfrv/1X9rZs8v/qIk2g8Q==
X-Received: by 2002:a2e:bb98:: with SMTP id y24mr15450827lje.315.1639672707002;
        Thu, 16 Dec 2021 08:38:27 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id m15sm948431lfp.9.2021.12.16.08.38.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 08:38:26 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id u22so39347783lju.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 08:38:26 -0800 (PST)
X-Received: by 2002:adf:d1a6:: with SMTP id w6mr6315246wrc.274.1639672295092;
 Thu, 16 Dec 2021 08:31:35 -0800 (PST)
MIME-Version: 1.0
References: <163967073889.1823006.12237147297060239168.stgit@warthog.procyon.org.uk>
 <163967169723.1823006.2868573008412053995.stgit@warthog.procyon.org.uk>
In-Reply-To: <163967169723.1823006.2868573008412053995.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Dec 2021 08:31:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi0H5vmka1_iWe0+Yc6bwtgWn_bEEHCMYsPHYtNJKZHCQ@mail.gmail.com>
Message-ID: <CAHk-=wi0H5vmka1_iWe0+Yc6bwtgWn_bEEHCMYsPHYtNJKZHCQ@mail.gmail.com>
Subject: Re: [PATCH v3 56/68] afs: Handle len being extending over page end in write_begin/write_end
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
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

On Thu, Dec 16, 2021 at 8:22 AM David Howells <dhowells@redhat.com> wrote:
>
> With transparent huge pages, in the future, write_begin() and write_end()
> may be passed a length parameter that, in combination with the offset into
> the page, exceeds the length of that page.  This allows
> grab_cache_page_write_begin() to better choose the size of THP to allocate.

I still think this is a fundamental bug in the caller. That
"explanation" is weak, and the whole concept smells like week-old fish
to me.

         Linus
