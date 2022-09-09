Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7E55B2B3C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 02:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiIIAvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 20:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiIIAvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 20:51:42 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0816C9D8CE
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 17:51:35 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id a67so496099ybb.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 17:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=LBNHsgANfOuYwqoZHaxODMzZ7UA+U8+5hufwxCbYv44=;
        b=L4r1/zM0OJVEeznCxkFeDmzDJp0IcMmbKN2OvdW9zrSpQ1s5Kdty/1rkvqWo33TMhT
         xWV4jNGh+PbGvXm0RJQ/3GpSL8k3kkDWsQF1guPOx0QIt2B1p6UW/G2dGSAhnz6g0J3G
         aCbemhwYTPosRuwZH2Cn9ZVgTqZfSGP+OkF8xPq4LUSXcNwj3wBeXn3dSPUF2TrfIRpN
         JQVL/x1hFZ6eG+8WyfHTfUzx9yazN5pP/4MU/Ug9tlPrBw51u68/InTGeJUXAmTQ46F7
         6ZwC93ANh6AAupdl3kfj2t2GfNBg9A4jCF4ximO4iROdJ/9dV1Q4vF+NqMLn6BAhU5rt
         CPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LBNHsgANfOuYwqoZHaxODMzZ7UA+U8+5hufwxCbYv44=;
        b=6Ht87CPPlJNyzXpp1lXOgnqT/DUyVT4K3tao34u9R3doqAYFJRMmSRis+zmZ6g2Txd
         gVRmSTsIyX5xQ0h8ToAQciDah+i9mh0SiqFX2fSX/oRYjhxS0C2hnXt+p9cW/yKyPgLf
         Us0DCNz/WhPK5QtuFLLWxz9F8pE/CLZVqx4tXFIscv8TQMvBWSEIJjRfGSe7nv7ZtW+I
         0FkGBV8DLtmej7fROuA2Ze/rETHyqokbxSLn3n8MlraJPDBgtRgyRRuGe3ATxVgQRusJ
         FYs+3+9KIygOhsIftP/c2NM/K4/M1SNKPi0ZffXnaffYPgR2C5ncvJI00dHqXhB++kQt
         n31g==
X-Gm-Message-State: ACgBeo3Cd3z8xjwyAel17jGGTIViBcMtj9d7bhv6W5UGAaIWaBVVRRkP
        Yvf0uYz94UTx6/RzlaNsWVhEyzb2vk65Cmd+3/wWxg==
X-Google-Smtp-Source: AA6agR5aiD/mHNLJf/uZTrUlH+sUk3m6QYGueoAr4dyZUEHwTfC+FSD4X8APTDBjLx4o2R6CQUyPXRoAsWEaWYZ1kA0=
X-Received: by 2002:a25:d209:0:b0:6a8:e5f1:f179 with SMTP id
 j9-20020a25d209000000b006a8e5f1f179mr9413490ybg.380.1662684694045; Thu, 08
 Sep 2022 17:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com> <20220901173516.702122-11-surenb@google.com>
 <bb5e3ab8-9c47-7d01-cdaa-1b4231312f67@linux.ibm.com>
In-Reply-To: <bb5e3ab8-9c47-7d01-cdaa-1b4231312f67@linux.ibm.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 8 Sep 2022 17:51:23 -0700
Message-ID: <CAJuCfpFm8irJyhzn-22QR+_4BmU+yDZM97T4S8pPKotxZUmjBg@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND 10/28] mm/mmap: mark VMAs as locked in vma_adjust
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

On Tue, Sep 6, 2022 at 8:35 AM Laurent Dufour <ldufour@linux.ibm.com> wrote=
:
>
> Le 01/09/2022 =C3=A0 19:34, Suren Baghdasaryan a =C3=A9crit :
> > vma_adjust modifies a VMA and possibly its neighbors. Mark them as lock=
ed
> > before making the modifications.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/mmap.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index f89c9b058105..ed58cf0689b2 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -710,6 +710,10 @@ int __vma_adjust(struct vm_area_struct *vma, unsig=
ned long start,
> >       long adjust_next =3D 0;
> >       int remove_next =3D 0;
> >
> > +     vma_mark_locked(vma);
> > +     if (next)
> > +             vma_mark_locked(next);
> > +
>
> I was wondering if the VMAs insert and expand should be locked too.
>
> For expand, I can't see any valid reason, but for insert, I'm puzzled.
> I would think that it is better to lock the VMA to be inserted but I can'=
t
> really justify that.
>
> It may be nice to detail why this is not need to lock insert and expand h=
ere.

'expand' is always locked before it's passed to __vma_adjust() by
vma_merge(). It has to be locked before we decide "Can it merge with
the predecessor?" here
https://elixir.bootlin.com/linux/latest/source/mm/mmap.c#L1201 because
a change in VMA can affect that decision. I spent many hours tracking
the issue caused by not locking the VMA before making this decision.
It might be good to add a comment about this...

AFAIKT 'insert' is only used by __split_vma() and it's always a brand
new VMA which is not yet linked into mm->mmap. Any reason
__vma_adjust() should lock it?

>
> >       if (next && !insert) {
> >               struct vm_area_struct *exporter =3D NULL, *importer =3D N=
ULL;
> >
> > @@ -754,8 +758,11 @@ int __vma_adjust(struct vm_area_struct *vma, unsig=
ned long start,
> >                        * If next doesn't have anon_vma, import from vma=
 after
> >                        * next, if the vma overlaps with it.
> >                        */
> > -                     if (remove_next =3D=3D 2 && !next->anon_vma)
> > +                     if (remove_next =3D=3D 2 && !next->anon_vma) {
> >                               exporter =3D next->vm_next;
> > +                             if (exporter)
> > +                                     vma_mark_locked(exporter);
> > +                     }
> >
> >               } else if (end > next->vm_start) {
> >                       /*
> > @@ -931,6 +938,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsign=
ed long start,
> >                        * "vma->vm_next" gap must be updated.
> >                        */
> >                       next =3D vma->vm_next;
> > +                     if (next)
> > +                             vma_mark_locked(next);
> >               } else {
> >                       /*
> >                        * For the scope of the comment "next" and
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
