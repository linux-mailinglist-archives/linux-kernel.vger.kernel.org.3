Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9413E520C6C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 05:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbiEJDxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 23:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbiEJDxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 23:53:16 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8893ED33
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 20:49:18 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id p4so18490718edx.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 20:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=csH2b0yln8VJjIPZKUY8Qo0Oj23Oo4VsNy+UnhWpwO0=;
        b=oYECvY6qXcMfackrkGXaEF2Uh8uHzvWghh2G/m/tPRNi9b9hcdKAzXapnkBfurvbuY
         cQk/LXQg4Z0ssHXJbTax12Vpmb8NOErMzH+BaeZdW79uWkpm8VtbWCTuTP6+XBtrszqm
         My2e+l5cAmZyvF0loTH1IJeyRjko0Bh2atekA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csH2b0yln8VJjIPZKUY8Qo0Oj23Oo4VsNy+UnhWpwO0=;
        b=XsfWnVgTn4snQdirKqo/MBsWp2Qu/kftX9d1mHyevDS5ffQyJxj2BP9sqRItH90iPd
         QpjS6RK1LS8ZUHnG9Z9hV8P/+hh9LFpqzXcq+CNwzdGKaXqP4Iyak6DEOmV4PMyGiv2Q
         HfN3S//sFx1mwcGW/6PoEMncgwf6YXiELRIKsX8QQenh3s0hA+tVEzbb2Oqxi2Pb9sYE
         l7CfBfduQ4TGR97bxeopNZoJMqYKuUj6STSTbyl/uvSkq2qVZbaVpr3iZUDWebcsK4H8
         Dn6IlBjfLEY4Mfs2S1GiD7hpU8pRIB5keS3sUxOddrISi6VnZ8iomxsMSsNn2vb0SGP8
         hG4Q==
X-Gm-Message-State: AOAM531Ngjnb4Re1IBkmNosLu3FG4GzzcyGVEWCMwn3rCtBTWrvGgVCs
        Prt8nsc7ghsNDLOZpVKZIfgfd/EUH+iA9Ie/q4AFSNdY4zspzpJF
X-Google-Smtp-Source: ABdhPJwob4/gCvx9CBCx7p8HvSC7iJaxs4G3456S0eeE4V5/ze1040Hv+xp4UizOuDERM7sfMDPdbXRTbaFZ5ah5tNU=
X-Received: by 2002:a05:6402:5ca:b0:423:f330:f574 with SMTP id
 n10-20020a05640205ca00b00423f330f574mr20595539edx.116.1652154556554; Mon, 09
 May 2022 20:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com> <20220509124815.vb7d2xj5idhb2wq6@wittgenstein>
In-Reply-To: <20220509124815.vb7d2xj5idhb2wq6@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 May 2022 05:49:04 +0200
Message-ID: <CAJfpegveWaS5pR3O1c_7qLnaEDWwa8oi26x2v_CwDXB_sir1tg@mail.gmail.com>
Subject: Re: [RFC PATCH] getting misc stats/attributes via xattr API
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Karel Zak <kzak@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 May 2022 at 14:48, Christian Brauner <brauner@kernel.org> wrote:

> One comment about this. We really need to have this interface support
> giving us mount options like "relatime" back in numeric form (I assume
> this will be possible.). It is royally annoying having to maintain a
> mapping table in userspace just to do:
>
> relatime -> MS_RELATIME/MOUNT_ATTR_RELATIME
> ro       -> MS_RDONLY/MOUNT_ATTR_RDONLY
>
> A library shouldn't be required to use this interface. Conservative
> low-level software that keeps its shared library dependencies minimal
> will need to be able to use that interface without having to go to an
> external library that transforms text-based output to binary form (Which
> I'm very sure will need to happen if we go with a text-based
> interface.).

Agreed.

>   This pattern of requesting the size first by passing empty arguments,
>   then allocating the buffer and then passing down that buffer to
>   retrieve that value is really annoying to use and error prone (I do
>   of course understand why it exists.).
>
>   For real xattrs it's not that bad because we can assume that these
>   values don't change often and so the race window between
>   getxattr(GET_SIZE) and getxattr(GET_VALUES) often doesn't matter. But
>   fwiw, the post > pre check doesn't exist for no reason; we do indeed
>   hit that race.

That code is wrong.  Changing xattr size is explicitly documented in
the man page as a non-error condition:

       If size is specified as zero, these calls return the  current  size  of
       the  named extended attribute (and leave value unchanged).  This can be
       used to determine the size of the buffer that should be supplied  in  a
       subsequent  call.   (But, bear in mind that there is a possibility that
       the attribute value may change between the two calls,  so  that  it  is
       still necessary to check the return status from the second call.)

>
>   In addition, it is costly having to call getxattr() twice. Again, for
>   retrieving xattrs it often doesn't matter because it's not a super
>   common operation but for mount and other info it might matter.

You don't *have* to retrieve the size, it's perfectly valid to e.g.
start with a fixed buffer size and double the size until the result
fits.

> * Would it be possible to support binary output with this interface?
>   I really think users would love to have an interfact where they can
>   get a struct with binary info back.

I think that's bad taste.   fsinfo(2) had the same issue.  As well as
mount(2) which still interprets the last argument as a binary blob in
certain cases (nfs is one I know of).

>   Especially for some information at least. I'd really love to have a
>   way go get a struct mount_info or whatever back that gives me all the
>   details about a mount encompassed in a single struct.

If we want that, then can do a new syscall with that specific struct
as an argument.

>   Callers like systemd will have to parse text and will end up
>   converting everything from text into binary anyway; especially for
>   mount information. So giving them an option for this out of the box
>   would be quite good.

What exactly are the attributes that systemd requires?

>   Interfaces like statx aim to be as fast as possible because we exptect
>   them to be called quite often. Retrieving mount info is quite costly
>   and is done quite often as well. Maybe not for all software but for a
>   lot of low-level software. Especially when starting services in
>   systemd a lot of mount parsing happens similar when starting
>   containers in runtimes.

Was there ever a test patch for systemd using fsinfo(2)?  I think not.

Until systemd people start to reengineer the mount handing to allow
for retrieving a single mount instead of the complete mount table we
will never know where the performance bottleneck lies.

>
> * If we decide to go forward with this interface - and I think I
>   mentioned this in the lsfmm session - could we please at least add a
>   new system call? It really feels wrong to retrieve mount and other
>   information through the xattr interfaces. They aren't really xattrs.

I'd argue with that statement.  These are most definitely attributes.
As for being extended, we'd just extended the xattr interface...

Naming aside... imagine that read(2) has always been used to retrieve
disk data, would you say that reading data from proc feels wrong?
And in hindsight, would a new syscall for the purpose make any sense?

Thanks,
Miklos
