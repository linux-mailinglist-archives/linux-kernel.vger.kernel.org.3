Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C3454FC89
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 19:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383029AbiFQRys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 13:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiFQRyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 13:54:47 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59884990F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 10:54:46 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d13so4457612plh.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 10:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3gaN4rlZjv7pyoxx/10QhPxWmkyRNv+DWEp7dRnF2tA=;
        b=Ir8ob8eSfXh/HH50s8vvCR020YJRMHfOP3T/X6FrfKhlN8Zm6jUKaXQTbgdebNcmq0
         mcuehygwrlVmwX92zJWUlGPMOkowxPtSVcSjaVkBqF1eGcrDaBTr4t2Dnf15asqGF1RN
         rzVzYVG5pBiUrJMQ4qbz7eUF8+Cx2oXEOdhXwd5aBbVKekwD1x0xQ0KYp331g41Bs6Z7
         pEGkUprw11PBDP66jvs+3i49greyGtXumHLEi3Hu6x2q9G+1kJT9kG/i5KsduQhJ0JkR
         uMb6aPUawgQDbLYQG/iXz8cVxigb7sc5Hz7jkDiaTCjsPCJ6i5IgHo/Y+ksXThmB5ji1
         zJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3gaN4rlZjv7pyoxx/10QhPxWmkyRNv+DWEp7dRnF2tA=;
        b=0SemflLIjwSK7lW8Z+gTi+uI9zSRqEuXe4yUo8WlZLXy7mxaoiDA2NByVccH76yTe/
         ZiV6B4hWrV8mwzATHW2U/tfQGzGmPTbdMAa8dQ3Bkjliwuy91sO5VYAgw7SZdr+/x0P+
         8KjHXobwr3dBj/sF7Byfic68GxYlB1Pi5KYyom9odqSmw7bEWGI+zaq+AyrC8f5mLob9
         /a8ITQDwEh4B8sw+o+axbmpOSmGSDznVQH41XB5FsMCF2glhjf1KQkT9o0BLURiPmYxq
         70Jq4kKRrYS6vdots4cNu//1+FDIJYtievJLiAwqFkmYK02XzIy5CW0cNn8IMpLxkdfQ
         qBDw==
X-Gm-Message-State: AJIora/+aXSdUMbpuDl9YmuwO21gaiqnDD2NEiBRntZjnkn6xPlt+vkN
        /cZ9AddSw7OKHzL2i0wIwLFw+ED9paQE+Wzgy0qZZuRI
X-Google-Smtp-Source: AGRyM1uLvqf1RYrXRxCniewV8UG56bLn7cL9qqmDOYYqSGNvsaGfPis3g+CKrjY0mfsarm8UC+Gv4wo15BYCcA9v/KI=
X-Received: by 2002:a17:902:8492:b0:167:6cbf:145b with SMTP id
 c18-20020a170902849200b001676cbf145bmr11084646plo.26.1655488486189; Fri, 17
 Jun 2022 10:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220616174840.1202070-1-shy828301@gmail.com> <Yqu392qcUSp1imEi@google.com>
In-Reply-To: <Yqu392qcUSp1imEi@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 17 Jun 2022 10:54:33 -0700
Message-ID: <CAHbLzkp6kRZgXJF2XGEOjci0RQVca1LqwOeC0-Vf4yodVGa93Q@mail.gmail.com>
Subject: Re: [mm-unstable v5 PATCH 0/7] Cleanup transhuge_xxx helpers
To:     "Zach O'Keefe" <zokeefe@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
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

On Thu, Jun 16, 2022 at 4:08 PM Zach O'Keefe <zokeefe@google.com> wrote:
>
> On 16 Jun 10:48, Yang Shi wrote:
> >
> > v5: * Removed transparent_hugepage_active() for !THP, per Zach.
> >       Patch 4/7 and 5/7 were updated accordingly.
> >     * Collected review tags.
> > v4: * Consolidated the transhuge_vma_size_ok() helper proposed in the
> >       earlier versions into transhuge_vma_suitable(), per Zach.
> >     * Fixed the regression introduced by patch 3/7, per Zach and Miaohe.
> >     * Reworded the comment for transhuge_vma_suitable(), per Zach.
> >     * Removed khugepaged_enter() per Miaohe.
> >     * More comments for hugepage_vma_check(), per Zach.
> >     * Squashed patch 4/7 (mm: khugepaged: use transhuge_vma_suitable replace open-code)
> >       in the earlier version into patch 2/7 of this version.
> >     * Minor correction to the doc about THPeligible (patch 7/7), so the
> >       total number of patches is kept 7.
> > v3: * Fixed the comment from Willy
> > v2: * Rebased to the latest mm-unstable
> >     * Fixed potential regression for smaps's THPeligible
> >
> > This series is the follow-up of the discussion about cleaning up transhuge_xxx
> > helpers at https://lore.kernel.org/linux-mm/627a71f8-e879-69a5-ceb3-fc8d29d2f7f1@suse.cz/.
> >
> > THP has a bunch of helpers that do VMA sanity check for different paths, they
> > do the similar checks for the most callsites and have a lot duplicate codes.
> > And it is confusing what helpers should be used at what conditions.
> >
> > This series reorganized and cleaned up the code so that we could consolidate
> > all the checks into hugepage_vma_check().
> >
> > The transhuge_vma_enabled(), transparent_hugepage_active() and
> > __transparent_hugepage_enabled() are killed by this series.
> >
> >
> > Yang Shi (7):
> >       mm: khugepaged: check THP flag in hugepage_vma_check()
> >       mm: thp: consolidate vma size check to transhuge_vma_suitable
> >       mm: khugepaged: better comments for anon vma check in hugepage_vma_revalidate
> >       mm: thp: kill transparent_hugepage_active()
> >       mm: thp: kill __transhuge_page_enabled()
> >       mm: khugepaged: reorg some khugepaged helpers
> >       doc: proc: fix the description to THPeligible
> >
> >  Documentation/filesystems/proc.rst |  4 ++-
> >  fs/proc/task_mmu.c                 |  2 +-
> >  include/linux/huge_mm.h            | 80 +++++++++++++++++++----------------------------------------
> >  include/linux/khugepaged.h         | 30 ----------------------
> >  mm/huge_memory.c                   | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++--------
> >  mm/khugepaged.c                    | 84 +++++++++++++++++++-------------------------------------------
> >  mm/memory.c                        |  7 ++++--
> >  7 files changed, 130 insertions(+), 158 deletions(-)
> >
>
> Series LGTM. Thanks for these cleanups, Yang!

Thank you so much for reviewing the patches.

>
> Best,
> Zach
