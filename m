Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9C957276B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 22:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiGLUiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 16:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiGLUiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:38:24 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37C1B968F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:38:23 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id v1so5560476ilg.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gtA9X+fkjEw/LyXx7cshYRPvYgSQ7aQHvwyjYuYISkY=;
        b=n9RIa554dycPGIKBOybZCxXvgE7O3FOURYuK5Rnd/mSxb6YmPx4NecnpLLC17ZO13g
         z2A3RBDfsGBdtTvmzt3QWmSQZahjAWF62t9H+KbGXH2iBNkyI5TTBHickAHetTgp+gm1
         e4d5G7Qu0bfcSaX20DM9iU8hk1RtRpOgraFK+HU4nkHoRbsXkTby588r0/xTUbYX5TZP
         ICqKI5uM6ndDxfDavEceu3s5Zc1Twx7qSiApci11ooZBvr9YqtCX+qyTmfm58kk8k6j7
         PaAQFdD2y9HOeCmn3N+DOd1eVwAM76SIKI9tEIkKwUIFXBkiVg1Njzo9F2A+S8HSvhkc
         Imrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gtA9X+fkjEw/LyXx7cshYRPvYgSQ7aQHvwyjYuYISkY=;
        b=ZPu1UGrM6B+VHDLyPlsI8DeuoxSn3DlSPZZhwoEsTfEMFEsxZTzTu1g/9af4U6ZP4I
         iIKk6BTdVNZ4PvTIM052+t+VAp4o3qBWUmihg2XxSHhxOar5/gDKURKtIF1HmgtPWn2l
         9J1Dn9OAGbMiCmJetsBHb8HT2uf95Lt4FXn0Oonnj+wwMn870cfAR0qURHNEA8EoA4bw
         umIw5ZbIryPKCbHteMKqnGs/B4bEndB/gV/N7U1lLoJ/mRmRiOv66Nc5XuJuf0pjMc8u
         6BcNBh7dxBDCtZG4oF+/C/a9+TqK/Kl5spu0wYKOoEb3Smt48japRwCf6cZ+fv9vZ7mk
         M/Ww==
X-Gm-Message-State: AJIora8bArJyhVHwNsJTdum11XOQQbzjpv3aDXEh0ZmiBahsllENL/sV
        bX+UH79OPrWPzlH4th/W6FsSdsT1eRNMJ3W6XIE=
X-Google-Smtp-Source: AGRyM1sVN9YSYB7R1dSBnm2ETFni6QgUDtN1HElitlfGihAv/kBYE0FaXotZOZQmmTStA3kvphxi9Y1pG9MpCrbFaDE=
X-Received: by 2002:a92:c562:0:b0:2dc:7ca1:a54c with SMTP id
 b2-20020a92c562000000b002dc7ca1a54cmr15605ilj.28.1657658303138; Tue, 12 Jul
 2022 13:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655150842.git.andreyknvl@google.com> <f7f5cfc5eb8f1a1f849665641b9dd2cfb4a62c3c.1655150842.git.andreyknvl@google.com>
 <5949bc710889be1324d5dada995a263fd3c29cb5.camel@mediatek.com>
In-Reply-To: <5949bc710889be1324d5dada995a263fd3c29cb5.camel@mediatek.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 12 Jul 2022 22:38:12 +0200
Message-ID: <CA+fCnZd2tND0CN1kVXt2ZpqtypDuQba8gXVMyL-XnLd+61X1cQ@mail.gmail.com>
Subject: Re: [PATCH 21/32] kasan: simplify invalid-free reporting
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     "andrey.konovalov@linux.dev" <andrey.konovalov@linux.dev>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 9:17 AM Kuan-Ying Lee
<Kuan-Ying.Lee@mediatek.com> wrote:
>
> On Tue, 2022-06-14 at 04:14 +0800, andrey.konovalov@linux.dev wrote:
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Right now, KASAN uses the kasan_report_type enum to describe report
> > types.
> >
> > As this enum only has two options, replace it with a bool variable.
> >
> > Also, unify printing report header for invalid-free and other bug
> > types
> > in print_error_description().
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  mm/kasan/kasan.h  |  7 +------
> >  mm/kasan/report.c | 16 +++++++---------
> >  2 files changed, 8 insertions(+), 15 deletions(-)
> >
> > diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> > index e8329935fbfb..f696d50b09fb 100644
> > --- a/mm/kasan/kasan.h
> > +++ b/mm/kasan/kasan.h
> > @@ -146,16 +146,11 @@ static inline bool kasan_requires_meta(void)
> >  #define META_MEM_BYTES_PER_ROW (META_BYTES_PER_ROW *
> > KASAN_GRANULE_SIZE)
> >  #define META_ROWS_AROUND_ADDR 2
> >
> > -enum kasan_report_type {
> > -       KASAN_REPORT_ACCESS,
> > -       KASAN_REPORT_INVALID_FREE,
> > -};
> > -
> >  struct kasan_report_info {
> > -       enum kasan_report_type type;
> >         void *access_addr;
> >         void *first_bad_addr;
> >         size_t access_size;
> > +       bool is_free;
> >         bool is_write;
> >         unsigned long ip;
> >  };
> > diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> > index f951fd39db74..7269b6249488 100644
> > --- a/mm/kasan/report.c
> > +++ b/mm/kasan/report.c
> > @@ -175,14 +175,12 @@ static void end_report(unsigned long *flags,
> > void *addr)
> >
>
> Hi Andrey,
>
> Do we need to distinguish "double free" case from "invalid free" or
> we just print "double-free or invalid-free"?
>
> I sent a patch[1] to separate double free case from invalid
> free last week and I saw it has been merged into akpm tree.
>
> [1]
> https://lore.kernel.org/linux-mm/20220615062219.22618-1-Kuan-Ying.Lee@mediatek.com/

Hi Kuan-Ying,

Yes, thank you for the patch! I will rebase my series onto it.

Thanks!
