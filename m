Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225A24CDD13
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 20:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiCDTCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 14:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiCDTCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 14:02:02 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367091D86DF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 11:01:14 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id z11so8561603pla.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 11:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QQXB5eKyYpG5vQk9wBbiRIz8N7tmcSgj6RBiMhN2WaY=;
        b=nJt0PulthXit3IgmiSHjfSEjOW/u0S00+vxPPPieNMTCXKaijg5Cjk6aIBOfoSgjnE
         CppbYHQ6Qonw6HCrBJ63uEqPfCeucSOUpQpsDy9RbUpsfao6YrrpHqWzo/zPV+uki9bh
         UBEdcpzj3x0rC6uEAQss1L4h0Tq0Nmw9eBkcn69d0lBctvsm8hR7MGxvn8xAtQIna4A9
         dDSYq6FR9TJ8WBO/x/VBUuJxlilnneuNYlQh4IVL4v2QWp40SnUkCxCjKYvqijRDKXGM
         KgwTlnNAbDA/Ri0lXMuB4Ul+r+bmVwbgJ5NA9tuFQexQMC0mshoKFdzntubnb8k6ZYmj
         E1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQXB5eKyYpG5vQk9wBbiRIz8N7tmcSgj6RBiMhN2WaY=;
        b=ESYx4rwCM19Go+wEVSPv/ot7+pis8KfWzOMRDs2B97sEsqXSsWrVssGSROZ9Unh4G6
         HsRbyK3e+6WKCDj+DBJSri0UiP2mNeuvtG23WH34WRn0itvbu5zBwhLZNb4nfT7Di2pg
         +UvSmbuoD47eay77ccROXkG4BrOqoLPKYD1vA30NEiBldYjXGHNVZiUoIu98GlYOnujY
         RAjpaC0Lm4s9p7lET1108l9IfPsaJd2DCKHoJBwxXks2k6+3BffkAF6KvRgYObTwKM4r
         D7e/FbGfwE3inIbL2pO+FtB9NA3Bc5D4LHa5VH7a0r79RO/GWA4TG9qAmvnEFYdXAzLC
         A4Yg==
X-Gm-Message-State: AOAM533W8INXzYk7E2AQKQkJDqnMusPqpJBnHKCoGViwvhhlVnP798qp
        JagCGh62WHMnRBcaIzNPQJSLLZtIza9PQXDgNEA=
X-Google-Smtp-Source: ABdhPJxsOWT5hTiInL2/NAyxR64UevNatuCAu8IOGJEZeUOLuf+ewhvvLVLVMZlr9xTKy8Ot9pjAGlHQSEFafgIShuQ=
X-Received: by 2002:a17:90b:1b0e:b0:1bf:1c4f:2bc4 with SMTP id
 nu14-20020a17090b1b0e00b001bf1c4f2bc4mr87820pjb.200.1646420473648; Fri, 04
 Mar 2022 11:01:13 -0800 (PST)
MIME-Version: 1.0
References: <20220303222014.517033-1-shy828301@gmail.com> <CADFyXm6W9CVkO4XPYep-tHg55c8m8NES783kcVYrdjSMbzYoDA@mail.gmail.com>
 <CAHbLzkriyBy2HqjssurLSnhoyuUzpJRZjMPNx34MTgxeO0dddg@mail.gmail.com> <13ad4ba1-2a88-9459-3995-70af36aba33e@redhat.com>
In-Reply-To: <13ad4ba1-2a88-9459-3995-70af36aba33e@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 4 Mar 2022 11:01:02 -0800
Message-ID: <CAHbLzkqkzxn0e+pkb-Y3qmSgBSn5va7TbiJG87QQLazRDQtvcg@mail.gmail.com>
Subject: Re: [PATCH] mm: thp: don't have to lock page anymore when splitting PMD
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 4, 2022 at 10:50 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 04.03.22 19:30, Yang Shi wrote:
> > On Thu, Mar 3, 2022 at 9:06 PM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> Hi,
> >>
> >> This probably bounces on the list due to html junk from the gmail app.
> >>
> >> What happened to
> >>
> >> https://lore.kernel.org/linux-mm/20220131162940.210846-10-david@redhat.com/
> >>
> >> Included in the very series mentioned below?
> >>
> >> Was this silently dropped due to folio conversion collisions? :/
> >
> > I really didn't notice you already proposed this. Maybe folio
> > conversion, maybe mlock cleanup, I can't tell. But anyway this patch
> > needs to get rebased. I will submit v2 to solve the comment, will add
> > your signed-off-by.
> >
>
> Why a rebase? The folio change comes via another tree (unfortunately not
> Andrews tree, I wish we would have a single MM tree for MM patches).
>
> @Andrew, the last mail I received was
>
> + mm-huge_memory-remove-stale-locking-logic-from-__split_huge_pmd.patch
> added to -mm tree
>
> The patch shows up in mmotm as
>
> #[merged]mm-huge_memory-remove-stale-locking-logic-from-__split_huge_pmd.patch
>
> ... which shouldn't be true.

Yes, otherwise my patch can't be applied. What I saw on linux-next for
mm/huge_memory.c looks like:

bfede97b8d6d mm/huge_memory: remove stale page_trans_huge_mapcount()
6c127ac2ff1d mm/huge_memory: streamline COW logic in do_huge_pmd_wp_page()
cb63c1eb2a3c mm/migration: add trace events for THP migrations
e65f964148fe Merge branch 'akpm-current/current'
61435e1e267c mm/readahead: Align file mappings for non-DAX
80ef527bf929 mm: Turn can_split_huge_page() into can_split_folio()
8339af1d0a18 mm/rmap: Convert rmap_walk() to take a folio
16f06327291e mm/migrate: Convert remove_migration_ptes() to folios
bd23d3f12232 memory tiering: skip to scan fast memory
47a3e10abb78 mm: thp: fix wrong cache flush in remove_migration_pmd()
1de8566cca0a mm/rmap: Convert try_to_migrate() to folios
5a470d51cb2b mm/rmap: Convert try_to_unmap() to take a folio
1c760ad73a13 mm/huge_memory: Convert __split_huge_pmd() to take a folio
82865a9e1187 mm: Add folio_mapcount()
07ca76067308 mm/munlock: maintain page->mlock_count while unevictable
cea86fe246b6 mm/munlock: rmap call mlock_vma_page() munlock_vma_page()
b67bf49ce7aa mm/munlock: delete FOLL_MLOCK and FOLL_POPULATE
f56caedaf94f Merge branch 'akpm' (patches from Andrew)

It looks like your series were rebased on top of mlock cleanup and
folio. Anyway I will wait for Andrew. If he thought a new patch
rebased on top of both mlock cleanup and folio would make his life
easier, I will submit v2.

>
> --
> Thanks,
>
> David / dhildenb
>
