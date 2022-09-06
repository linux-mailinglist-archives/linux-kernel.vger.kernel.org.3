Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6AF5ADC9F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 02:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237050AbiIFAj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 20:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiIFAjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 20:39:52 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470E210FC3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 17:39:46 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id y3so19930363ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 17:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=i2orbtExQlccm1w/BNraKCbJoQoonFPa3RMVK51xch0=;
        b=Y1GCnRYVDCZj/JilpGzJOPsi8VHlBxjzp/rCB5CLIbFSPdgUEYE2ahS03ZdUE+sJDU
         8NJy4IHaYFrTzV+0+ESZIta0w7sl0uA3Ixc5yMl/YSH1VpLqVsyJq9STwfY4Y1XcSUn7
         fbBq6WzStegaXoRA+5Z/afUG5AbMoeZUmJR0Gtp2NitJXBAbyRkwkOdOXtt8tSaLYV9F
         5x1lHIiSTQNgbkmTvUG4byhR8u9Slp49luKoi/qlTxzxD0iVLRnhCltvxAQI4U8nWKmn
         7wN7hif782eRJ60efS3E1o+O0TxX7axnYh9ZZIAh8Q1va6JJGmXZtGhmZx6oVmotLXFN
         ZZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=i2orbtExQlccm1w/BNraKCbJoQoonFPa3RMVK51xch0=;
        b=Ru8BeVZSafEBL12brZgUGYi1zGcI23unXuRBfgQi9tsOHxkQ8T0fFNnr63vFcFZKR5
         NfI6N7sDCDtQ3wwg/KYqPrsZHr5KpLl+251NuOPctf8/fqG80+w91HYCTk8h7UaTg3jF
         hEreGJEpNcaURwbqIs67yrSzYOnmq5dEzzJs0wroERPhtZTS9FUOAxV/4NEmRrS4xrHf
         k3cQ0+iep/O+Vq2zDi6OEllan5XHImuYvhpxqMaTqNymOfRHFTZrkLGhU+GNqIjKHVF8
         Gb9goj7FSNFzpQea5tjOXCppncXP6jdMFs6WkjguOEplsHNwsTeFSg/pMas6v94xL26A
         xq9Q==
X-Gm-Message-State: ACgBeo2UqoBLQBPqBCVvTM17LIeSRvkSZFPTb7hKIJrEZh8Su82Aeon0
        6+qudzU00VHuZydXHByCc4RZbSDGVIaYHK8JRAdaFKuzOEo+AQ==
X-Google-Smtp-Source: AA6agR4RCAygHSkj6CSFxAFgn85SGVj7vd8Cf1vH/9LMizTexhPtLommdZzsBHkRcGBXqi7UNa/XJjsBA8iL9cKDGRA=
X-Received: by 2002:a17:907:842:b0:731:3310:4187 with SMTP id
 ww2-20020a170907084200b0073133104187mr35019845ejb.578.1662424784840; Mon, 05
 Sep 2022 17:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220902232732.12358-1-rick.p.edgecombe@intel.com> <CA+CK2bDjoWNw_0WC_qAhzw9BRVPgbBAcs0=sUb3qcqhyVyvaDQ@mail.gmail.com>
In-Reply-To: <CA+CK2bDjoWNw_0WC_qAhzw9BRVPgbBAcs0=sUb3qcqhyVyvaDQ@mail.gmail.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 5 Sep 2022 20:39:07 -0400
Message-ID: <CA+CK2bDEWT1LTtqK+bS5dkOttoxvNdWv7YOmzTHgSc72FTXqNw@mail.gmail.com>
Subject: Re: [PATCH] mm: Check writable zero page in page table check
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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

Sorry: s/Rock/Rick

:-)

On Mon, Sep 5, 2022 at 8:38 PM Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
>
> Hi Rock,
>
> Good idea to add a check for write access to zero page. Can you please
> also update Documentation/mm/page_table_check.rst ?
>
> Thank you,
> Pasha
>
> On Fri, Sep 2, 2022 at 7:31 PM Rick Edgecombe
> <rick.p.edgecombe@intel.com> wrote:
> >
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
> >  mm/page_table_check.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> > index e2062748791a..665ece0d55d4 100644
> > --- a/mm/page_table_check.c
> > +++ b/mm/page_table_check.c
> > @@ -102,6 +102,8 @@ static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
> >         if (!pfn_valid(pfn))
> >                 return;
> >
> > +       BUG_ON(is_zero_pfn(pfn) && rw);
> > +
> >         page = pfn_to_page(pfn);
> >         page_ext = lookup_page_ext(page);
> >         anon = PageAnon(page);
> >
> > base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
> > --
> > 2.17.1
> >
