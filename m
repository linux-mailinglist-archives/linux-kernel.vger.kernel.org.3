Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2290525A62
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 05:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376766AbiEMDvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 23:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376865AbiEMDvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 23:51:40 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D402F6222A
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 20:51:39 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id m12so6796317plb.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 20:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4uKAf8ejcZLyRe4KEMEu185lgDsjWpY688BLR8fzfXc=;
        b=LsEond1U6vi33EbKuOwOhx7v4RzY5FRsuWl7R3lUn2KeUCRTVo9B0e1ciCBQoSh4TR
         o5NlvaorWNPvqQVAtDLEaB5rH4Tm275nEKtGz07aDeXklfR1fnEgTL2yAKuwv6XAZhkp
         9sWnXeustkOEebK1MNScQ2Bkpfh6eBYtCmr8XWNrhrdHpYM+YEYF9HAMjRcF7kM20gus
         EGBr4+gmHepmYArq3awfU6iN3EJ6XHvhT7mHXmPT4NX+sdEb9PQgrS81mZ43Z1UYPS3i
         PamMOM1x3izF5bP8uUVAo/Hk1e22r1B+I+5ilKgvpgmraBDwtS+LXsdMnz6Jr2mXv1/b
         AJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4uKAf8ejcZLyRe4KEMEu185lgDsjWpY688BLR8fzfXc=;
        b=57m+qvbx9fMs3eB3dhmbsbTawfwHpCIw4m0opqcTQMB4IyKCy03yZnMbqbYYw4Z8BI
         VVNTYWc1iYs7Vsvv27kfywwZVX3aaxqo3SCDVtBVQDbki+JpoZCC+J8652TFgMWiXiZq
         ktMnRNMxbgSayECHFL/xNXxAeKB/6DfrcpHVYeGSZLl8+IDasSedTNhz4Vq9Xfmhzs7G
         pA/C3cLeZ+N2HlqQYKUjHPuRUON2CVflim28isvgOqAp6/vaoBcoNj6VQiJITV5PFaAs
         HoESVQl06boF7XG7meVgm5XHRfrTLwpbWO/shqdg7Wu5bFGqVq/TxxESQUch0nqDzhrp
         gaog==
X-Gm-Message-State: AOAM530wuRrRZO2K5A2/CQZyuJjVZvm2M+kcS2R3mYdDa0xD7STmzu7b
        Rg9/H8MY21bBKYHIeobVURS6WivSw4SxKaJEiVw=
X-Google-Smtp-Source: ABdhPJzvW/r2r2l8V9phphJf4ArMMV9GwadMXGjA44d61oYwwpySzhQGMfIsSV9bl4jXumZRJpnFJXJjGK86C4NShis=
X-Received: by 2002:a17:90b:1b52:b0:1dc:54ea:ac00 with SMTP id
 nv18-20020a17090b1b5200b001dc54eaac00mr14208518pjb.99.1652413899404; Thu, 12
 May 2022 20:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220512174551.81279-1-shy828301@gmail.com> <20220512174551.81279-2-shy828301@gmail.com>
 <Yn3Q7KIb3FcAPW9j@casper.infradead.org>
In-Reply-To: <Yn3Q7KIb3FcAPW9j@casper.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 12 May 2022 20:51:26 -0700
Message-ID: <CAHbLzkrALZm43JOCwc38pRzcMwX3u0FNqwUEZS3pGi=3eT_V9Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: pvmw: check possible huge PMD map by transhuge_vma_suitable()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Muchun Song <songmuchun@bytedance.com>,
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

On Thu, May 12, 2022 at 8:30 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, May 12, 2022 at 10:45:51AM -0700, Yang Shi wrote:
> > IIUC PVMW checks if the vma is possibly huge PMD mapped by
> > transparent_hugepage_active() and "pvmw->nr_pages >= HPAGE_PMD_NR".
> >
> > Actually pvmw->nr_pages is returned by compound_nr() or
> > folio_nr_pages(), so the page should be THP as long as "pvmw->nr_pages
> > >= HPAGE_PMD_NR".  And it is guaranteed THP is allocated for valid VMA
> > in the first place.  But it may be not PMD mapped if the VMA is file
> > VMA and it is not properly aligned.  The transhuge_vma_suitable()
> > is used to do such check, so replace transparent_hugepage_active() to
> > it, which is too heavy and overkilling.
> >
> > Fixes: 2aff7a4755be ("mm: Convert page_vma_mapped_walk to work on PFNs")
>
> I think Fixes is a bit much.  There's no bug being fixed here.  This is
> just an optimisation.  Is it an important optimisation?  We could put a

Yeah, it is just an optimization, will remove the fix tag.

I'm trying to do some cleanup for all the transhuge_page_* checks
suggested by Vlastimil. I should be able to kill
transparent_hugepage_active() by replacing it with
transhuge_vma_suitable() here.

> bool into page_vma_mapped_walk() so we only have to ask the page whether
> it's PMD-mappable once per walk rather than for each VMA.

The page may be PMD-mappable for one VMA, but not for the other VMA.

>
