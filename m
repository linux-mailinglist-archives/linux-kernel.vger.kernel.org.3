Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6909D5B2AAF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 01:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiIHX5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 19:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIHX5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 19:57:31 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179D7F910B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 16:57:30 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id t184so361027yba.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 16:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=fjRx/Lr4rWG8FdNjepWfPwinvttFV+7WLgO00cFoqzc=;
        b=eex6cV74s4M8HeKkMm8twe1wMmlZy8xPylfXxTCwczLvM6rjy9aZnLRWAV94lwFweL
         wAYpV8vwszuecJPQnwFpuZcAWGq+gpGawG4NDhdV/gC5fkudZU59f9HbpteQ+lQOcY0I
         GAuQhYX7csyCScbjD5jgdN/lxX0hV5690Tcj8OCWTWHOdxz1phA0WKGeiTCECkVAzaLw
         sEfntZDZ1/grg22e7rWeAYxWauW5E1ZRZA2dGh5d7M8MUfKjS+PoLz8YplH1AxLv4mjU
         xBy4gnrkKgV0FDBrrfwV2xX69XGlTUWccShysi4f6ykbn3u/y4iOr6sGj4cHuPbiwDv6
         bZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fjRx/Lr4rWG8FdNjepWfPwinvttFV+7WLgO00cFoqzc=;
        b=SAkZdYX7fZaptVdLwUuWci7X9+75nWXlxRpN5q894sfQYzTkZUw8qQW6YV9kXG/MAD
         BndpJMS1wAZgKElHcHwKY2l4uFNmd9EuOqiO54sAi9hS3N8nEjFC62tR06RcoV2lM/6y
         OZf9BRGtYxmVkRleFOLsz1rqJ8Gj2TB+Q8fu8wJXU2YTM2f6ejwe0zg6t8641Ha2YoNC
         cpBQ81N+xna5mShcnpMdX1TeCJJc2QpYbM4kQ1eMBKFLwe6EiCeg8r4GSr1KeNTviBBo
         SzVmUSI5yDeysUiPJtltGIz02KLcKXI95NJDzC5Wzw4Qf9M54R7mGVYt8uvyVpOm6GaN
         9ngg==
X-Gm-Message-State: ACgBeo20iom9WarDAuwE9e9D5EkHC0YeYuxC/WZ9dUWBnPD3Upfcyndx
        /cFlQzJXjVY6eTqHCiOv9VZevSgQGKy9ZNJsPYi+Ow==
X-Google-Smtp-Source: AA6agR5z3AebbL5Azy4sNoMfTt0gW01VpIp+qr6/rNEQLn3rNpaHhq14wg8Eeh+706sD3nPJeGD6bnyLQT+FGI+FElY=
X-Received: by 2002:a05:6902:2d0:b0:694:d257:4c4b with SMTP id
 w16-20020a05690202d000b00694d2574c4bmr9669475ybh.316.1662681449064; Thu, 08
 Sep 2022 16:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com> <20220901173516.702122-8-surenb@google.com>
 <a072fd10-ee7e-469f-c203-978cd7da566c@linux.ibm.com>
In-Reply-To: <a072fd10-ee7e-469f-c203-978cd7da566c@linux.ibm.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 8 Sep 2022 16:57:17 -0700
Message-ID: <CAJuCfpFDFzCB7zuOGyd-gqovyhwvcQaUMOUS0E8+1QxLqD-Gdg@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND 07/28] kernel/fork: mark VMAs as locked before
 copying pages during fork
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@suse.de, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Sep 6, 2022 at 7:38 AM Laurent Dufour <ldufour@linux.ibm.com> wrote=
:
>
> Le 01/09/2022 =C3=A0 19:34, Suren Baghdasaryan a =C3=A9crit :
> > Protect VMAs from concurrent page fault handler while performing
> > copy_page_range for VMAs having VM_WIPEONFORK flag set.
>
> I'm wondering why is that necessary.
> The copied mm is write locked, and the destination one is not reachable.
> If any other readers are using the VMA, this is only for page fault handl=
ing.

Correct, this is done to prevent page faulting in the VMA being
duplicated. I assume we want to prevent the pages in that VMA from
changing when we are calling copy_page_range(). Am I wrong?

> I should have miss something because I can't see any need to mark the loc=
k
> VMA here.
>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  kernel/fork.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index bfab31ecd11e..1872ad549fed 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -709,8 +709,10 @@ static __latent_entropy int dup_mmap(struct mm_str=
uct *mm,
> >               rb_parent =3D &tmp->vm_rb;
> >
> >               mm->map_count++;
> > -             if (!(tmp->vm_flags & VM_WIPEONFORK))
> > +             if (!(tmp->vm_flags & VM_WIPEONFORK)) {
> > +                     vma_mark_locked(mpnt);
> >                       retval =3D copy_page_range(tmp, mpnt);
> > +             }
> >
> >               if (tmp->vm_ops && tmp->vm_ops->open)
> >                       tmp->vm_ops->open(tmp);
>
