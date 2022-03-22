Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E984E4450
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239149AbiCVQih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 12:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239139AbiCVQig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:38:36 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BFF403D5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 09:37:08 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id p22so699952iod.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 09:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JOfXdzXzom6Ge5ZLgXzIGQus82db3leTmrAjGklzd9Q=;
        b=W7gg5FEmb7uxqnDAcUfh5CV+kC4GYkqT8OcL2WTqcIBqxSZRDJmJ/2gLKqdl7XMk8v
         pYHQk3UYlI2AhECBf/mDel5kEBNLZAF5P2Lj1AZQWacQJuZzsIH/8N48AFUrXpp01APa
         n/g0b0y4ZABi9OmApD7DnWllC+7H5cl3AWHqwMir0T9Vabx5y82GLQ7JYZTx2AHAR4sG
         RMehGZTtMu5WQXj/aQYkWLTSStcyOc0KgKo0Z7dLa47hwx42BY2Jqy7weAHLer7QProV
         Rvi4s/Q/CZyHcl48lolOhbUA59gzKc2MQL2IEeBkS3HcoWzdqdqkbnSjWZ7aL/YJaCWS
         VR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JOfXdzXzom6Ge5ZLgXzIGQus82db3leTmrAjGklzd9Q=;
        b=llbPvR3CM4SU0gnnBnKUTJiZwsFPGq0wRnZrg7EtZA7e2ZRqnN7ipsUxKU+BQnYuYY
         H58jQZsZUHUcHB5rZ8AbHALzZT6XhRwhHrfm+8yuLWodFW893/w090ASj7LZsFP2Rc+z
         /DECAMhg1KeOfjkx418qyVoASOjlx/uH4dgnRV7TFDDfcFoQGg2RzaPFIY0tsJUW+4h9
         vP/68gicNeqBxRIIj81JvNtD0KB6RHxW3U1At+K58DBsGeAmUMnamB5Fexb3PUIhMsSB
         s012yskz8mRobfp8bJU+rAP3RiUp+h4XLGsHLlLZdtyAy3kSa5BDMtpUdpbPU4z34gEx
         Z3Cw==
X-Gm-Message-State: AOAM5309e3wZLlHl+w7jxFXgZ9gutkQVIIms1BGt3irLRW/SmbvY2DU6
        FHZ1bskqq/8udV2ASaewrqa65Bi7U7QH9BGd6IfnDw==
X-Google-Smtp-Source: ABdhPJwVZtOBWRKjFVYelGiTBEh3P0bSkSMlPiJx9YRcUB59FPs9X6xraruImv6x+xw3kcgPnjbn0kSIQoVv4FrRFbs=
X-Received: by 2002:a6b:cd0c:0:b0:649:adb8:79eb with SMTP id
 d12-20020a6bcd0c000000b00649adb879ebmr4395012iog.138.1647967027714; Tue, 22
 Mar 2022 09:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220318191343.72812-1-abbotti@mev.co.uk> <YjgW7L77+Y2fylcR@xz-m1.local>
 <a2380fac-d173-50e3-963a-d7fc22b2da5d@gmail.com> <CAJHvVch=vO6gwyn+swyeHEQ4mUccL6T+Vt3G9akeEjXZ6XKM-A@mail.gmail.com>
In-Reply-To: <CAJHvVch=vO6gwyn+swyeHEQ4mUccL6T+Vt3G9akeEjXZ6XKM-A@mail.gmail.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 22 Mar 2022 09:36:32 -0700
Message-ID: <CAJHvVchqALH-0Y8LgkqAFnwbfEjkheNTKhpSeUMY2d+bU44tGg@mail.gmail.com>
Subject: Re: [PATCH] ioctl_userfaultfd.2: Corrections for returned .ioctls members
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     Peter Xu <peterx@redhat.com>, Ian Abbott <abbotti@mev.co.uk>,
        linux-man@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 9:23 AM Axel Rasmussen <axelrasmussen@google.com> wrote:
>
> On Tue, Mar 22, 2022 at 5:32 AM Alejandro Colomar (man-pages)
> <alx.manpages@gmail.com> wrote:
> >
> > Hi Ian and Peter,
> >
> > On 3/21/22 07:10, Peter Xu wrote:
> > > On Fri, Mar 18, 2022 at 07:13:43PM +0000, Ian Abbott wrote:
> > >> Support for the `UFFDIO_WRITEPROTECT` operation is not indicated in the
> > >> `ioctls` member of `struct uffdio_api`.  It is indicated in the `ioctls`
> > >> member of `struct uffdio_register` along with indications of support for
> > >> the `UFFDIO_COPY`, `UFFDIO_WAKE` and `UFFDIO_ZEROPAGE` operations (and
> > >> also the `UFFDIO_CONTINUE` operation supported since Linux 5.13 but
> > >> that is not documented by this man page yet.)
> > >
> > > I thought it should have landed but indeed it's not.  Copying Axel.
>
> Ah, I mistakenly thought it got merged, but there were a few remaining
> issues Alejandro wanted addressed first. I'll send a v3 of it later
> today.
>
> For what it's worth, as part of adding minor fault handling, we pretty
> significantly change the ioctl field's behavior, and I rewrote a lot
> of the documentation around it. So, it may conflict with this patch.
> :/ Sorry about that.

Heh, I spoke too soon. My patch doesn't touch this after all, I think
the patches don't conflict. :) It's been a while since I looked at
it...

>
> > >
> > >>
> > >> Fixes: f559fa36a678 ("ioctl_userfaultfd.2: Add write-protect mode docs")
> > >> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
> >
> > Patch applied.
> >
> > >
> > > The patch looks correct to me, thanks for fixing it.
> > >
> > > Acked-by: Peter Xu <peterx@redhat.com>
> >
> > And tag appended.
> >
> > Thank you both!
> >
> > Alex
> >
> > >
> > >> ---
> > >>   man2/ioctl_userfaultfd.2 | 27 ++++++++++++++++++++-------
> > >>   1 file changed, 20 insertions(+), 7 deletions(-)
> > >>
> > >> diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> > >> index 504f61d4b..e930af520 100644
> > >> --- a/man2/ioctl_userfaultfd.2
> > >> +++ b/man2/ioctl_userfaultfd.2
> > >> @@ -235,11 +235,6 @@ operation is supported.
> > >>   The
> > >>   .B UFFDIO_UNREGISTER
> > >>   operation is supported.
> > >> -.TP
> > >> -.B 1 << _UFFDIO_WRITEPROTECT
> > >> -The
> > >> -.B UFFDIO_WRITEPROTECT
> > >> -operation is supported.
> > >>   .PP
> > >>   This
> > >>   .BR ioctl (2)
> > >> @@ -333,8 +328,26 @@ If the operation is successful, the kernel modifies the
> > >>   bit-mask field to indicate which
> > >>   .BR ioctl (2)
> > >>   operations are available for the specified range.
> > >> -This returned bit mask is as for
> > >> -.BR UFFDIO_API .
> > >> +This returned bit mask can contain the following bits:
> > >> +.TP
> > >> +.B 1 << _UFFDIO_COPY
> > >> +The
> > >> +.B UFFDIO_COPY
> > >> +operation is supported.
> > >> +.TP
> > >> +.B 1 << _UFFDIO_WAKE
> > >> +The
> > >> +.B UFFDIO_WAKE
> > >> +operation is supported.
> > >> +.TP
> > >> +.B 1 << _UFFDIO_WRITEPROTECT
> > >> +The
> > >> +.B UFFDIO_WRITEPROTECT
> > >> +.TP
> > >> +.B 1 << _UFFDIO_ZEROPAGE
> > >> +The
> > >> +.B UFFDIO_ZEROPAGE
> > >> +operation is supported.
> > >>   .PP
> > >>   This
> > >>   .BR ioctl (2)
> > >> --
> > >
> >
> > --
> > Alejandro Colomar
> > Linux man-pages comaintainer; http://www.kernel.org/doc/man-pages/
> > http://www.alejandro-colomar.es/
