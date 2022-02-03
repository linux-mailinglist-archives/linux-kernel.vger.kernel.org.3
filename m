Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F7F4A915A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 01:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356066AbiBDAA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 19:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiBDAA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 19:00:27 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66922C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 16:00:27 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id t7so6217773ljc.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 16:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W6vWO5phbqbJOK15XWRuJznkX1ivVtRshDIXGjGnpb4=;
        b=O8w4WotJ2b6rKmKKBJUWufCSv8dzfdHoarzVcOzZdSr+s/PqUwLyF3Ue2tY/unRIz2
         t8ScfVaD++YGalUdIVCUijauCnQxT2Mi26HFXWtPcjhBkU/TVYHOxnr3tl4N2OGO+Yzk
         IYURFJ2SWm7yedjm+OHMjip0qE7cQcTs5iUiaWTI/sImxJIq4tcF/BJN0aCYjL1vSwIM
         RHLlA6mde4MueRj/hCeQCZwH3riRVeC/F4XnG2hp0lSgf3KXJJzpD2OQNb3uLhbTvuvH
         /SWuQvQKnSfBpeuhsfmzTs3/rzdpHv3m9h0wwbaUJMzkg60K5QzAfDUsbsJgpL2GrV++
         lIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W6vWO5phbqbJOK15XWRuJznkX1ivVtRshDIXGjGnpb4=;
        b=wVaeCvA/I/D0y3i3oBaCObuk96Zw1THjYiPmvtSlCbMF2nM6S3Y3Q9j6rYZsP2nVhO
         ryfzNm3zbepmVnAmN1REy8tsZ7h1wYH3djFIPuLGMwRkN+R92t2bP/eALcCk3196tax6
         KCwhx4IUPzZBfu+FZN4pUfa/gOqVq0Bj6FK1bFEfvmaPFw5bZY0wuAXWluN8CwAhLH79
         hclFOOZTRn17cbqYEL3tamlxEQ9eZh4r9zCmeEiRiSfebnSR3LuFjdetjqqxfC9kfXv7
         5a6M2AbwHZwXLc1mHJGGk69g9rWhNfyaC9Of4rNu63i1d2dZPQ4wNWG6j/3HlG/A5dY/
         D/Uw==
X-Gm-Message-State: AOAM532y/1npFXiieOTbZwoBSsvFBDbIP2rd+Kw1MWxZlphCNUErvvbx
        z/RQ/4t0QbDPINsMJMhjSn7OfVyJIP109b0PF2CCXA==
X-Google-Smtp-Source: ABdhPJwqnKLO1BWi4vxnVtC5ADx5qhgj0i+dCH1oMioRtJ0A+yCanphIAmcv0oK4faOF84+sxzP6HgxOzGH15JBCK84=
X-Received: by 2002:a05:651c:1249:: with SMTP id h9mr234541ljh.375.1643932825587;
 Thu, 03 Feb 2022 16:00:25 -0800 (PST)
MIME-Version: 1.0
References: <20220126025739.2014888-1-jannh@google.com> <87czk5l2i6.fsf@email.froward.int.ebiederm.org>
 <CAG48ez3byq=Cn4xGt5HmLBy9fWBapX9RdF-9JOaAus=rDR2TYQ@mail.gmail.com>
In-Reply-To: <CAG48ez3byq=Cn4xGt5HmLBy9fWBapX9RdF-9JOaAus=rDR2TYQ@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 4 Feb 2022 00:59:59 +0100
Message-ID: <CAG48ez1RzO8KrbAv_9kwRCyjS7E3K+adJzdqV6uLqKPoyQmPnw@mail.gmail.com>
Subject: Re: [PATCH] coredump: Also dump first pages of non-executable ELF libraries
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Bill Messmer <wmessmer@microsoft.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>, stable@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 6:43 PM Jann Horn <jannh@google.com> wrote:
>
> On Wed, Feb 2, 2022 at 4:19 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >
> > Jann Horn <jannh@google.com> writes:
> >
> > > When I rewrote the VMA dumping logic for coredumps, I changed it to
> > > recognize ELF library mappings based on the file being executable instead
> > > of the mapping having an ELF header. But turns out, distros ship many ELF
> > > libraries as non-executable, so the heuristic goes wrong...
> > >
> > > Restore the old behavior where FILTER(ELF_HEADERS) dumps the first page of
> > > any offset-0 readable mapping that starts with the ELF magic.
> > >
> > > This fix is technically layer-breaking a bit, because it checks for
> > > something ELF-specific in fs/coredump.c; but since we probably want to
> > > share this between standard ELF and FDPIC ELF anyway, I guess it's fine?
> > > And this also keeps the change small for backporting.
> >
> > In light of the conflict with my other changes, and in light of the pain
> > of calling get_user.
> >
> > Is there any reason why the doesn't unconditionally dump all headers?
> > Something like the diff below?
> >
> > I looked in the history and the code was filtering for ELF headers
> > there already.  I am just thinking this feels like a good idea
> > regardless of the file format to help verify the file on-disk
> > is the file we think was mapped.
>
> Yeah, I guess that's reasonable. The main difference will probably be
> that the starting pages of some font files, locale files and python
> libraries will also be logged.

Are you planning to turn that into a proper patch and take it through
your tree, or something like that? If so, we should tell akpm to take
this one back out...
