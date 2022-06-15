Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D899E54D015
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356745AbiFORgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241015AbiFORgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:36:03 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947CF140D4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:36:02 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id u37so3646645pfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mi2I/nBbKUPGwcrimfjZmC5H+6RsJZl43u1D1xw78cY=;
        b=B66OjH+4Usdm01B88GgTuR/lmUJB0yO00pSelOSh083ZtTXiu1AwQJlTqrIt7iN1o1
         evsW15/3cKi/CZagQcCEfKXGJumsp1BU+poSvnEn7cudXQmxzKTD3QENL2y2T4976O9j
         i0ZLhJ0ft2FkpnSj8IzCFrei8kQ9eKB5iSDLexX8j0vcevavvFerz2T3/3rwtxxgqMBm
         rkj0Kj/vJ19f74xZFOAOJbeuBbmrJmGttzXqv6tyI0TprHd5JAFNP8rbnM7OdJ8RJEQ4
         EeeHy39WCK+4xcmilNUWY3DRCFHBOtHPpU9yidhLR60eOltc3A8qXrlixHcMO4Mryy3L
         RGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mi2I/nBbKUPGwcrimfjZmC5H+6RsJZl43u1D1xw78cY=;
        b=MolDZc0fcOWytPj12uhrWIUYhT6h5XyXfSw5fcwolj3p8XfRBgx4hVKwQC3yNzspfL
         aC60MAcoiuvi6VsO9wRhAz+gNOjIEGKN8CgcMq/JyZ1PRYqEQ0xzY9A5R4c1GlWJF8q/
         JyO2xsMEuyhfzQOKg2FIreju3S1d/X//H5ii2QINoIQD0yEmRhkgPdyzuLxxEdqUhP3g
         KAunEU7NloEo328GGfeO5C7FnYaTQaMRglOLEAeAD/vc5zeqb6kr9iX210SG4z2efXre
         3WjI3sgmIfu9wt46UCfxyeKx6UganJvfTfej54P9rbRhm9VvRoCkli6FMWR/ezKsf65v
         wnrA==
X-Gm-Message-State: AJIora+eMpUOsObSigsecPI+fvhDZO6WbHy/bqSiJqb9NdbMcoFlbFR1
        NMJXST7XN+rms0f2Ad4qKmFtW6LwsyJQ7D6No9s=
X-Google-Smtp-Source: AGRyM1t1JjCHUP3dw4DmAlpOPQwoeQrKrh+19gynjKHWa0zTJBXh1GqCw/KHHovV3kRQib8Hapf/cxIRD+zNC/JSCDw=
X-Received: by 2002:a05:6a00:2291:b0:51b:e4c5:627 with SMTP id
 f17-20020a056a00229100b0051be4c50627mr603454pfe.20.1655314562174; Wed, 15 Jun
 2022 10:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220611084731.55155-1-linmiaohe@huawei.com> <20220611084731.55155-2-linmiaohe@huawei.com>
In-Reply-To: <20220611084731.55155-2-linmiaohe@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 15 Jun 2022 10:35:49 -0700
Message-ID: <CAHbLzkpNKcaa54=2kTBWfzB1VoagkncZV0XEef22tHpfT0fTHw@mail.gmail.com>
Subject: Re: [PATCH 1/7] mm/khugepaged: remove unneeded shmem_huge_enabled() check
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Howells <dhowells@redhat.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sat, Jun 11, 2022 at 1:47 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> If we reach here, hugepage_vma_check() has already made sure that hugepage
> is enabled for shmem. Remove this duplicated check.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/khugepaged.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 476d79360101..73570dfffcec 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2153,8 +2153,6 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
>                 if (khugepaged_scan.address < hstart)
>                         khugepaged_scan.address = hstart;
>                 VM_BUG_ON(khugepaged_scan.address & ~HPAGE_PMD_MASK);
> -               if (shmem_file(vma->vm_file) && !shmem_huge_enabled(vma))
> -                       goto skip;
>
>                 while (khugepaged_scan.address < hend) {
>                         int ret;
> --
> 2.23.0
>
>
