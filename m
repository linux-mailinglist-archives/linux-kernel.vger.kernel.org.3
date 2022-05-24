Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235D5532355
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 08:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbiEXGjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 02:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiEXGjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 02:39:10 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C54197282
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:39:08 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bq30so29224091lfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vBkx9/je7nDyB+6MMJGNSqtAxz9DvJ1+u+v1K7otlCo=;
        b=oCve/KDFWOvJXlCjrDxr59ZkXz3gpAMriZ1CVyW2u3n/AfE5CYatZcPDTesNJ0T2+X
         q8037e5u8YjM1/cpy44xNB2+W6t/XDb9b/ON+b+w9ZxeF1f5amqqXObaxe281MkPgrsa
         oxy2ABaoZ5hyijHZQaYHOn2zCbFDj87w9KHQ5EJhmp5Kj0tQ9JNr/TqI8IBdAKrn4jzM
         GFuDOzeYweicfF9LiGHCLZ08mNrywURmSVwk52tQIGnuDmUW2/wrj1zNfCQefQqh7MxX
         WJ9RQy7xEElthYpYHKyglDr5DpfqYxhPzBhGgiuGcnv3Ms1WNqMCOIim0RpxH9RCs0Pr
         irUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vBkx9/je7nDyB+6MMJGNSqtAxz9DvJ1+u+v1K7otlCo=;
        b=GP+aEVSJfB6b4Pf+5to3mCgM0wb5gTyxTN6KvKGLdkMBrKkHi8+r4toHhL5EW292S+
         NCJkmq4aPQxUvBadevOLV4Y0rVjTNoPOKOYTPAYRYNwKzzveMslIQINCFsK8S+SP5IsU
         uEn/DjqXNAD1P6M8PrL3vhABsekS8W0990Iz+CJmEciEySeO5bjIoj+vIV07ZIqws6Ft
         gv2CeisBmyepIfSXwiPLuUp6kYRxdSAi1qEF53fawtTKFiztLH2omh4OU8NxRWzrdnLs
         D175S94i6LzSe7p6XzwaOWpSD8Tx2C82NER+MFk+p7+OX+h0PCsFqLFaOJERWp4pNKRI
         GtbQ==
X-Gm-Message-State: AOAM530cSnQ0cKwj680EDi7Syg2YzNwU+CsD9fV0Cs1kN8xIJGdtiYgv
        NZlppyl94o7PfrHiFe1r04qKvi4/bdp4Eod/dmdQAwr9yVM=
X-Google-Smtp-Source: ABdhPJztRg4T8Us1w5pTgz+J6eeww3XGCvYO3WlS+ASr7kqjcJOlQmdPW25my3rLDm+Hp0RLs8IZnK0IpTwCljZ0Ygg=
X-Received: by 2002:a05:6512:3da0:b0:478:5b79:d76e with SMTP id
 k32-20020a0565123da000b004785b79d76emr11591958lfv.540.1653374346548; Mon, 23
 May 2022 23:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220523053531.1572793-1-liu3101@purdue.edu> <CACT4Y+Y9bx0Yrn=kntwcRwdrZh+O7xMKvPWgg=aMjyXb9P4dLw@mail.gmail.com>
 <MWHPR2201MB1072A5D51631B60BF02E2F3DD0D79@MWHPR2201MB1072.namprd22.prod.outlook.com>
In-Reply-To: <MWHPR2201MB1072A5D51631B60BF02E2F3DD0D79@MWHPR2201MB1072.namprd22.prod.outlook.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 24 May 2022 08:38:55 +0200
Message-ID: <CACT4Y+Y7cvG-iHjGuca4rCA9jHRa8LsjQ=bfayNKkOeUjU_4Lg@mail.gmail.com>
Subject: Re: [PATCH v2] kcov: update pos before writing pc in trace function
To:     "Liu, Congyu" <liu3101@purdue.edu>
Cc:     "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Tue, 24 May 2022 at 05:08, Liu, Congyu <liu3101@purdue.edu> wrote:
>
> It was actually first found in the kernel trace module I wrote for my research
> project. For each call instruction I instrumented one trace function before it
> and one trace function after it, then expected traces generated from
> them would match since I only instrumented calls that return. But it turns
> out that it didn't match from time to time in a non-deterministic manner.
> Eventually I figured out it was actually caused by the overwritten issue
> from interrupt. I then referred to kcov for a solution but it also suffered from
> the same issue...so here's this patch :).

Ah, interesting. Thanks for sharing.

> ________________________________________
> From: Dmitry Vyukov <dvyukov@google.com>
> Sent: Monday, May 23, 2022 4:38
> To: Liu, Congyu
> Cc: andreyknvl@gmail.com; kasan-dev@googlegroups.com; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2] kcov: update pos before writing pc in trace function
>
> On Mon, 23 May 2022 at 07:35, Congyu Liu <liu3101@purdue.edu> wrote:
> >
> > In __sanitizer_cov_trace_pc(), previously we write pc before updating pos.
> > However, some early interrupt code could bypass check_kcov_mode()
> > check and invoke __sanitizer_cov_trace_pc(). If such interrupt is raised
> > between writing pc and updating pos, the pc could be overitten by the
> > recursive __sanitizer_cov_trace_pc().
> >
> > As suggested by Dmitry, we cold update pos before writing pc to avoid
> > such interleaving.
> >
> > Apply the same change to write_comp_data().
> >
> > Signed-off-by: Congyu Liu <liu3101@purdue.edu>
>
> This version looks good to me.
> I wonder how you encountered this? Do you mind sharing a bit about
> what you are doing with kcov?
>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
>
> Thanks
>
> > ---
> > PATCH v2:
> > * Update pos before writing pc as suggested by Dmitry.
> >
> > PATCH v1:
> > https://lore.kernel.org/lkml/20220517210532.1506591-1-liu3101@purdue.edu/
> > ---
> >  kernel/kcov.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/kcov.c b/kernel/kcov.c
> > index b3732b210593..e19c84b02452 100644
> > --- a/kernel/kcov.c
> > +++ b/kernel/kcov.c
> > @@ -204,8 +204,16 @@ void notrace __sanitizer_cov_trace_pc(void)
> >         /* The first 64-bit word is the number of subsequent PCs. */
> >         pos = READ_ONCE(area[0]) + 1;
> >         if (likely(pos < t->kcov_size)) {
> > -               area[pos] = ip;
> > +               /* Previously we write pc before updating pos. However, some
> > +                * early interrupt code could bypass check_kcov_mode() check
> > +                * and invoke __sanitizer_cov_trace_pc(). If such interrupt is
> > +                * raised between writing pc and updating pos, the pc could be
> > +                * overitten by the recursive __sanitizer_cov_trace_pc().
> > +                * Update pos before writing pc to avoid such interleaving.
> > +                */
> >                 WRITE_ONCE(area[0], pos);
> > +               barrier();
> > +               area[pos] = ip;
> >         }
> >  }
> >  EXPORT_SYMBOL(__sanitizer_cov_trace_pc);
> > @@ -236,11 +244,13 @@ static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
> >         start_index = 1 + count * KCOV_WORDS_PER_CMP;
> >         end_pos = (start_index + KCOV_WORDS_PER_CMP) * sizeof(u64);
> >         if (likely(end_pos <= max_pos)) {
> > +               /* See comment in __sanitizer_cov_trace_pc(). */
> > +               WRITE_ONCE(area[0], count + 1);
> > +               barrier();
> >                 area[start_index] = type;
> >                 area[start_index + 1] = arg1;
> >                 area[start_index + 2] = arg2;
> >                 area[start_index + 3] = ip;
> > -               WRITE_ONCE(area[0], count + 1);
> >         }
> >  }
> >
> > --
> > 2.34.1
> >
