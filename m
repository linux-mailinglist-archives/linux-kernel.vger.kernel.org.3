Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BD25ADC9B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 02:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiIFAiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 20:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiIFAiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 20:38:08 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3517D696D5
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 17:38:06 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bj12so19804516ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 17:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=7un4HX2JCwCz50GAyQxv3uo3L7dunvyCkFMMoxC/GmE=;
        b=aP6iMqzgytKnLYUKeWOGgeQf7XrWU3yeeBV15MvVRL/qVSmBdE7EDnSFKZuJ0PPcQg
         VviWREQGiQx9scuQUS31+9p12E5NBCKfgBsBPn4vUyvDBf7cWiVyxVIu5JC9lnpnHmAb
         jX0Tke+GE0beO8MaJFc9omSrI33+5ZfAy9qF1L6g5BpsXWfO1wvNHdx24MdzpI8ZV9EC
         RTlTk+2AoUelBrKMKjAOOLKzUE0MLgkZc+XKmw43y/A6QpY7bdElZFMQ9hQ1Zxq260lh
         ptMNs5uA6SIKuB/PAdISDefPLlf/nfIOnmwR8S3iKzU1Ixtk8d8JvgJFJEei8ouGwPhu
         Qr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=7un4HX2JCwCz50GAyQxv3uo3L7dunvyCkFMMoxC/GmE=;
        b=SmTnjy3yRMEFxUhoKYjTV0yyKhilEgR9fXit6z7FdaQQfBJ3hKeUCMukZPRM1Qeue/
         1SAa9FJZpO87/7Ol0XX62zudh1nX/Qn15PuGYZfz/Jnjn46C1+7OLklVZvvY/c4xdjgw
         07RTUJBWL2dl3r9D9lk4p0SVEhSi9IHPXqEcD7//gGlGMRNf0Xzgil6N6HphbuUZm4A0
         /+E7qCM/nvkPwMX66a52XLHTVN0cthNZLdQ0HKwA7gQUSmCi6Xt5sVNIRyNwAZE/FJ1C
         fQjFfTsUXhTNeCn6ZRJVKfwpRiH0hQNc+J6s9dtSgxcaWf3d4AWhMkgXyru/JJu3ocIU
         zPZg==
X-Gm-Message-State: ACgBeo3GEv/fZumjFSpz3Q2WvqfOgjHwoF6ydCXmGTtnS0PBQR2OIvd7
        pn9EeW6tKkg0RcztgAAbCmiOWRp8PN5GfcJqElvVfA==
X-Google-Smtp-Source: AA6agR5fOzdQufQ44wqDDK7YEEkgYae38ASeKpZbXXmTrNA6WkhrnwsIV1o34p4PJIU8pn/xD3voz0mXgvBqb/dQReE=
X-Received: by 2002:a17:907:7252:b0:73f:c3e9:4197 with SMTP id
 ds18-20020a170907725200b0073fc3e94197mr34115682ejc.173.1662424684715; Mon, 05
 Sep 2022 17:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220902232732.12358-1-rick.p.edgecombe@intel.com> <3d82deb6-357d-0b54-ffd1-dce157674aad@intel.com>
In-Reply-To: <3d82deb6-357d-0b54-ffd1-dce157674aad@intel.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 5 Sep 2022 20:37:27 -0400
Message-ID: <CA+CK2bCAC4uQr_nrJM=mbP8DSpR7Vz=OGF9q7wufU_i4Wk3GBw@mail.gmail.com>
Subject: Re: [PATCH] mm: Check writable zero page in page table check
To:     "Huang, Shaoqin" <shaoqin.huang@intel.com>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shaoqin,

The idea behind page table check is to prevent some types of memory
corruptions: i.e. prevent false page sharing, and memory leaking
between address spaces. This is an optional security feature for
setups where it is more dangerous to leak data than to crash the
machine. Therefore, when page table check detects illegal page sharing
it immediately crashes the kernel. I think we can have a
page_table_check option that would change BUG_ON to WARN_ON() (or to
WARN_ON_ONCE(), since once corruption is detected I believe it might
show up many times again)

Pasha

On Fri, Sep 2, 2022 at 10:13 PM Huang, Shaoqin <shaoqin.huang@intel.com> wrote:
>
>
>
> On 9/3/2022 7:27 AM, Rick Edgecombe wrote:
> > The zero page should remain all zero, so that it can be mapped as
> > read-only for read faults of memory that should be zeroed. If it is ever
> > mapped writable to userspace, it could become non-zero and so other apps
> > would unexpectedly get non-zero data. So the zero page should never be
> > mapped writable to userspace. Check for this condition in
> > page_table_check_set().
> >
> > Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> >
> > ---
> >
> > Hi,
> >
> > CONFIG_PAGE_TABLE_CHECK is pretty explicit about what it checks (and
> > doesn't mention the zero page), but this condition seems to fit with the
> > general category of "pages mapped wrongly to userspace". I added it
> > locally to help me debug something. Maybe it's more widely useful.
> >
> >   mm/page_table_check.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> > index e2062748791a..665ece0d55d4 100644
> > --- a/mm/page_table_check.c
> > +++ b/mm/page_table_check.c
> > @@ -102,6 +102,8 @@ static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
> >       if (!pfn_valid(pfn))
> >               return;
> >
> > +     BUG_ON(is_zero_pfn(pfn) && rw);
> > +
>
> Why we need use BUG_ON() here? Based on [1], we should avoid to use the
> BUG_ON() due to it will panic the machine.
>
> [1]: https://lore.kernel.org/lkml/20220824163100.224449-1-david@redhat.com/
>
> >       page = pfn_to_page(pfn);
> >       page_ext = lookup_page_ext(page);
> >       anon = PageAnon(page);
> >
> > base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
