Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E234E2258
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345366AbiCUImk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345358AbiCUImj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:42:39 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A29A1441
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:41:09 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id yy13so28346261ejb.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T1TcUGL3Yr9pbZUIUf4urzAZZW+X+3X2guZDA8VSc8A=;
        b=doxelnDMfXbB5iuIRK4hrnslkGX8BBTvxzAkb0q9tNJFa34Y3jqcWcfHpVibc9cfiJ
         Lk3kupzHwyhzogtJ8ePTN72QZOettBzmKjpDw16KezAFhFYdc3WfdA8OP1ZDFtBcuSMZ
         I2a8XVg4a9eRpDMpV128X0Nq+arrNVtHg4/Ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T1TcUGL3Yr9pbZUIUf4urzAZZW+X+3X2guZDA8VSc8A=;
        b=NCoyg1N76lrtJd4P41eyST+WcNrV5F0QPJ+j7O/wsrtjoDl5tJ5j3sxKOT2891hWr2
         xXt1uzlmodrV3O0M1a+D+LpFnOSX7yhoO9UfBH9QxuUgJkw2rxq1JlIip+esLABjiBXB
         rehcAPPu/xrJ7f5m/FyOl/ySZZ+OpTGAecelUT4ZLZwzTyeMYFIO9LMkKxdT1Zzc+juW
         kpoDDNMSWOWlfxHj/6V74XagZ//lmI6TK2UE8LumkAtWJib3OrI8AhYOr/SoZTfDBdPX
         47L0YZtpE93q91b7E0aj5EsC7WlNZ3PfwGqaw+r7Z64jVWibIOxfpitgK8nj1GW5gLib
         4SXg==
X-Gm-Message-State: AOAM532NRC5yyiKpKWmmhtHjLdR9vVJskxC3poGFhX1lrla5QNSSwQLr
        eS/5lYeyfaDxqXDcIULz1o3DZbg++wMTbWBoAZAw3A==
X-Google-Smtp-Source: ABdhPJy2lA62e8/yWwcG+98dZn7ToA9GNqRjH90QGk+nz/876LNhUqYCp2yX6ujlNu1Aaufl2Zr0QeGUdZqMPBJUzHQ=
X-Received: by 2002:a17:906:280b:b0:6ce:f3c7:688f with SMTP id
 r11-20020a170906280b00b006cef3c7688fmr19757403ejc.468.1647852068103; Mon, 21
 Mar 2022 01:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220318171405.2728855-1-cmllamas@google.com> <CAJfpegsT6BO5P122wrKbni3qFkyHuq_0Qq4ibr05_SOa7gfvcw@mail.gmail.com>
 <Yjfd1+k83U+meSbi@google.com>
In-Reply-To: <Yjfd1+k83U+meSbi@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 21 Mar 2022 09:40:56 +0100
Message-ID: <CAJfpeguoFHgG9Jm3hVqWnta3DB6toPRp_vD3EK74y90Aj3w+8Q@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix integer type usage in uapi header
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alessio Balsini <balsini@android.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2022 at 03:07, Carlos Llamas <cmllamas@google.com> wrote:
>
> On Fri, Mar 18, 2022 at 08:24:55PM +0100, Miklos Szeredi wrote:
> > On Fri, 18 Mar 2022 at 18:14, Carlos Llamas <cmllamas@google.com> wrote:
> > >
> > > Kernel uapi headers are supposed to use __[us]{8,16,32,64} defined by
> > > <linux/types.h> instead of 'uint32_t' and similar. This patch changes
> > > all the definitions in this header to use the correct type. Previous
> > > discussion of this topic can be found here:
> > >
> > >   https://lkml.org/lkml/2019/6/5/18
> >
> > This is effectively a revert of these two commits:
> >
> > 4c82456eeb4d ("fuse: fix type definitions in uapi header")
> > 7e98d53086d1 ("Synchronize fuse header with one used in library")
> >
> > And so we've gone full circle and back to having to modify the header
> > to be usable in the cross platform library...
> >
> > And also made lots of churn for what reason exactly?
>
> There are currently only two uapi headers making use of C99 types and
> one is <linux/fuse.h>. This approach results in different typedefs being
> selected when compiling for userspace vs the kernel.

Why is this a problem if the size of the resulting types is the same?

Thanks,
Miklos
