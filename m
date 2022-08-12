Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434B7590B51
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 06:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiHLEto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 00:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiHLEtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 00:49:42 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB35FA2867
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 21:49:41 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 24so2431400pgr.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 21:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=WJS72dvtFXYi5pD5mzwuxGTEk9o9IeYNQbFa82DCy4I=;
        b=I8WudUyA1q1tagwtAJVmfs5vhMa7SoVIqm98l0muF354WAhWTSA95ysV9PwSPn1HO0
         2vzbqZSPPL+T3Tg5T7DaqzigK1d+UZZ9uwBu8uHgechYY/v/aoR208ukXenG6ptImbnn
         aD9Jnsyaot4975dWL6psH1elmG8irCn+Taa+fwWlK0j3Dpfc5gdXBBfLubHNG16P/RzU
         uD5iEYfMhEpx6L4RQowQYcERuYXhBiT6orIc+yVjFCnwpY0C3pKbxFXBw2NHsOVaTvg+
         fAHkL2V8foGTH7/DQpTnAOQE4oG/U+bceCiZdD4CvZ2NxL1BGUEZfZO1Ucp0TkV19KZf
         2YSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=WJS72dvtFXYi5pD5mzwuxGTEk9o9IeYNQbFa82DCy4I=;
        b=RxID+uS9871uFkixC6d5oFGPBS9OE5Q34o9svEMCqiFU4XtO9D6WsnQlO2OZI4r1dv
         G2lDxF17A6Tjc+lRiX1WNsbTBi8K4TYv8BR0q/8v+cOu9dEOwewMfieV+2UQFqFRcBEL
         VSAw61qkD/pRs+s5ME32YxkBqR1hX59ydE0vnPILERVbvVwi+cpoBwypJrKd684ubpMR
         ngqNmZdnHtMZqCn3OqGApWtKtFxapFUWnGQfxjE7L3VWu+dQl+JS3nEibk1nTYTv2btu
         JmrCgNzvV8h7zYkAM6qELoeHdL+/TUJ/Nwh/MuDA5FrbvLwjWE43G5EnMLMysq3LKIBg
         UQeg==
X-Gm-Message-State: ACgBeo04PN+ubLFJkFAZKNcsUg7agRKKMjkLRuH6C6B51WYWGLFD/dpZ
        fm+itQsyHwJDZek9mSGR4zQFh/1NR7h5EN4DGIE=
X-Google-Smtp-Source: AA6agR5bFW7pAjTlEOLEk3Bp1wmhqunho3EPofhv7GPByJMJHAK281Akfe2ACVLhG45c8zcsWyY0zF3StLaFOeQ9qnM=
X-Received: by 2002:a62:6347:0:b0:531:c5a7:b209 with SMTP id
 x68-20020a626347000000b00531c5a7b209mr2336023pfb.60.1660279781406; Thu, 11
 Aug 2022 21:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220801173155.92008-1-ryncsn@gmail.com> <20220811160739.ea6b0f9c2912317c49287cda@linux-foundation.org>
In-Reply-To: <20220811160739.ea6b0f9c2912317c49287cda@linux-foundation.org>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Fri, 12 Aug 2022 12:49:29 +0800
Message-ID: <CAMgjq7CebYhwgUzBV9tGENEfVMxPMS4qVXvRx=sVQOEAUbq_mA@mail.gmail.com>
Subject: Re: [PATCH] mm/util: reduce stack usage of folio_mapcount
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> =E4=BA=8E2022=E5=B9=B48=E6=9C=881=
2=E6=97=A5=E5=91=A8=E4=BA=94 07:07=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue,  2 Aug 2022 01:31:55 +0800 Kairui Song <ryncsn@gmail.com> wrote:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > folio_entire_mapcount will call PageHeadHuge which is a function call,
> > and blocks the compiler from recognizing this redundant load.
>
> Did you mean folio_test_hugetlb() rather than folio_entire_mapcount()?

Thanks for checking out this patch, and Yes, it's folio_test_hugetlb,
my mistake...

>
>
> > After rearranging the code, stack usage is dropped from 32 to 24, and
> > the function size is smaller (tested on GCC 12):
> >
> > Before:
> > Stack usage:
> > mm/util.c:845:5:folio_mapcount  32      static
> > Size:
> > 0000000000000ea0 00000000000000c7 T folio_mapcount
> >
> > After:
> > Stack usage:
> > mm/util.c:845:5:folio_mapcount  24      static
> > Size:
> > 0000000000000ea0 00000000000000b0 T folio_mapcount
> >
> > ...
> >
> > @@ -850,10 +850,10 @@ int folio_mapcount(struct folio *folio)
> >               return atomic_read(&folio->_mapcount) + 1;
> >
> >       compound =3D folio_entire_mapcount(folio);
> > -     nr =3D folio_nr_pages(folio);
> >       if (folio_test_hugetlb(folio))
> >               return compound;
> >       ret =3D compound;
> > +     nr =3D folio_nr_pages(folio);
> >       for (i =3D 0; i < nr; i++)
> >               ret +=3D atomic_read(&folio_page(folio, i)->_mapcount) + =
1;
> >       /* File pages has compound_mapcount included in _mapcount */
> > --
> > 2.35.2

Is the rest of the patch a valid fix? Should I send V2?
