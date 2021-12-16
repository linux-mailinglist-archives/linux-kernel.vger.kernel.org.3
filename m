Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB924476EF4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbhLPKei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbhLPKee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:34:34 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74EBC06173E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 02:34:33 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id p19so24884109qtw.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 02:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M+0sYl7w0EFJ72TMaAFHyV1NVwE2EB6FQgQgq+6hP5E=;
        b=R5rs8mLKc9+IweLlPGugdIqRbsaQ+ykrd4Qw0rYiqKo7CBJEMc01G0mkilYP1nCpNr
         EbfrdFpMNXVrsUCp3Dbq6y+5yK8eGjHDc+5Hdja4rIqou0bGFzJhmnGm39HpAlIYAAOG
         yxoIVOyRBWaG/a/pCsSOaWPqJLWFaE3H+Yh9ocZKGVjzpg3U0VqYZpAUAre1X8YUrUO9
         vEccsaCzWolMC8UYG3MdqFP/YAR7aMSdYrF3R9Fu3ieKV7HGs0qxMUThIQxbt52UOxFX
         xIB3YRLsjGT09GBoJNNY25C3dd9pHQkrVZit2MRrI2zII4Jw6CrAXvnTmui+4982C1hM
         t7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M+0sYl7w0EFJ72TMaAFHyV1NVwE2EB6FQgQgq+6hP5E=;
        b=U4HV7F6+HAalSno9LGi9ij5V1ZK3Qg0XhtivXiac6PgfmEHXkr5wacsrmDdxdn1IG8
         TSNN+0ORP4nzg4jurBbBdfLuQEjmjD0ubDRdHD2H38tzR4rGa7YE+yt+D14HzfUWoWC9
         kdg+YZbp35UF39Umcjfq2Vbvy0DLOv3DkyrmTF2cEp6PVsSHms06FlzWZkclc2ayAMLG
         mh3Wl38RwxVyvHXyGOrA0xtdladXVNQGC6WXrItkAy/X/939g5YHEHRjI8RUeg7yHsrO
         0P5AKsUeKJBeFp0bXn9rwRWHzyL9+nl8LruMCaXXq9JqqyzAXQJXFtoEv21MqTs1cDF1
         NE/Q==
X-Gm-Message-State: AOAM531mKfKY5W/35Cs/2v83sJWzbWPFvULPDrWhBD084HgURoxuP9xf
        enLFQqOmNfg2FtfMda2+kkoeQUhzBo5FJUWZw5aPlA==
X-Google-Smtp-Source: ABdhPJw0jeWo1ZwgFv58HwTnkU4NU69fnNqT/q0owhKeEurY9FKnfrFrKyeNZuGGVxZtljFxx/Gn0tS3qUqy4vwQFZ8=
X-Received: by 2002:a05:622a:2d5:: with SMTP id a21mr16301315qtx.56.1639650872812;
 Thu, 16 Dec 2021 02:34:32 -0800 (PST)
MIME-Version: 1.0
References: <20211214162050.660953-1-glider@google.com> <20211214162050.660953-14-glider@google.com>
 <YbjHerrHit/ZqXYs@kroah.com>
In-Reply-To: <YbjHerrHit/ZqXYs@kroah.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Dec 2021 11:33:56 +0100
Message-ID: <CAG_fn=XX3vbuo=cyG8C1Syv_JXiQ1rnfoffKqEc-N8uLei5T2A@mail.gmail.com>
Subject: Re: [PATCH 13/43] kmsan: add KMSAN runtime core
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 5:34 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Dec 14, 2021 at 05:20:20PM +0100, Alexander Potapenko wrote:
> > This patch adds the core parts of KMSAN runtime and associated files:
> >
> >   - include/linux/kmsan-checks.h: user API to poison/unpoison/check
> >     the kernel memory;
> >   - include/linux/kmsan.h: declarations of KMSAN hooks to be referenced
> >     outside of KMSAN runtime;
> >   - lib/Kconfig.kmsan: CONFIG_KMSAN and related declarations;
> >   - Makefile, mm/Makefile, mm/kmsan/Makefile: boilerplate Makefile code=
;
> >   - mm/kmsan/annotations.c: non-inlineable implementation of KMSAN_INIT=
();
> >   - mm/kmsan/core.c: core functions that operate with shadow and origin
> >     memory and perform checks, utility functions;
> >   - mm/kmsan/hooks.c: KMSAN hooks for kernel subsystems;
> >   - mm/kmsan/init.c: KMSAN initialization routines;
> >   - mm/kmsan/instrumentation.c: functions called by KMSAN instrumentati=
on;
> >   - mm/kmsan/kmsan.h: internal KMSAN declarations;
> >   - mm/kmsan/shadow.c: routines that encapsulate metadata creation and
> >     addressing;
> >   - scripts/Makefile.kmsan: CFLAGS_KMSAN
> >   - scripts/Makefile.lib: KMSAN_SANITIZE and KMSAN_ENABLE_CHECKS macros
>
>
> That's an odd way to write a changelog, don't you think?

Agreed. I'll try to concentrate on the functionality instead. Sorry about t=
hat.

> You need to describe what you are doing here and why you are doing it.
> Not a list of file names, we can see that in the diffstat.
>
> Also, you don't mention you are doing USB stuff here at all.  And why
> are you doing it here?  That should be added in a later patch.

You are right, USB is a good example of a stand-alone feature that can
be moved to a separate patch.

> Break this up into smaller, logical, pieces that add the infrastructure
> and build on it.  Don't just chop your patches up on a logical-file
> boundry, as you are adding stuff in this patch that you do not need for
> many more later on, which means it was not needed here.

Just to make sure I don't misunderstand - for example for "kmsan: mm:
call KMSAN hooks from SLUB code", would it be better to pull the code
in mm/kmsan/core.c implementing kmsan_slab_alloc() and
kmsan_slab_free() into that patch?
I thought maintainers would prefer to have patches to their code
separated from KMSAN code, but if it's not true, I can surely fix
that.

> thanks,
>
> greg k-h



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
