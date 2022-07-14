Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF1557406E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 02:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiGNAUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 20:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGNAUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 20:20:45 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78DC13DE9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 17:20:44 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id v185so107941ioe.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 17:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CDf7ponVtSwiyUmUKyQv1LkgIIKuEWvKXkEsaaBEY2Y=;
        b=HggXnN/J0acz+YkhI6q06LHQzBUWx4SyERrzbFwCiDcE1fGxZ9FojgYvQAp4NPNlg2
         BqZiTqxFrRGHT0j6lzha6tR6mO9YtCc0lOQ7cdQT7HJX7GZwEhMBTC0Vd/vBeHY8XlXP
         PClWPE2NT3hxcPxu088W1BXA1sCkVtwqhUZKXuuB0W1NX6UD9ZM4tbfDTmZhEFjaqvu9
         VFImIZ5m8BP6JXevrJ4dAbhax590AiWG3V5ykKC0B/qyA4+rvunzJMdr/c6A/K5OZRHy
         h/hLRQKqpSGh6iq+PkJhgpIKPafI7SNvj4eAGdpIY0P6U+Cetrq/UNIj1SiI1FET4OLg
         MHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CDf7ponVtSwiyUmUKyQv1LkgIIKuEWvKXkEsaaBEY2Y=;
        b=C08PjdB63BblPeNQZjJetTru/Ok5NQDAbMdNSq4jfE09xF/NImvwZAWZutfy1E7y6y
         dE3B2OvVXJn2DmIguTMX2zbVrvFDQMTNItAY4fps5jpFz0ep9nxia249/OBto75UALmU
         jzcnhZu8R7PrMme4644xq9lIMT70GOU1VVlZCEPM4XG1aGWzTJGCYGUNctFdnltCizED
         aBcITw/GzFL0DZO0nLLs5YNVG58Ap43Ivn2Lw4ZJQvXCDH03poFjH1EkJPfGFAs9oW4C
         t2xOgBFsKck7rFzaV54Hlq/sW+ZN67E3udtXrM1msUrOZ4hm2u5i+rhUrfNyOSipE2Z5
         NOcA==
X-Gm-Message-State: AJIora/ZndrzpJiuwcABM8CvB/LtAfocQA9KiY2KPy6PpARSk1EEvm/R
        LeybxxH2r2bqROeWn7/LoDYZdPA3bo71cwRVnFq4cw==
X-Google-Smtp-Source: AGRyM1utcceOTJGlb4M5/bFD4LjtpLOqEpDwdFZ5zX7llLQO/pbiz4LcSPnGu54S1lGVOngExwZQefuHXR0jsKyVbOw=
X-Received: by 2002:a05:6638:349f:b0:33f:68a2:5eb5 with SMTP id
 t31-20020a056638349f00b0033f68a25eb5mr3415957jal.167.1657758044032; Wed, 13
 Jul 2022 17:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220712130542.18836-1-linmiaohe@huawei.com> <Ys2xyCUnqpJt0eIo@monkey>
 <Ys7ViSsOxLaQJIfy@xz-m1.local> <Ys7uXHdzzFezUub5@xz-m1.local>
 <CAJHvVcgqb6R6ePMbgmA8LpMpMgrGWie9ZCTuR4MA77GTvi4XAw@mail.gmail.com> <Ys9XAbuxkDUlnmv0@monkey>
In-Reply-To: <Ys9XAbuxkDUlnmv0@monkey>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 13 Jul 2022 17:20:07 -0700
Message-ID: <CAJHvVci9iij+eDV-EWDOtjmWFYo0H+1LkzKBp6=XOpwDA4Jh-g@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: avoid corrupting page->mapping in hugetlb_mcopy_atomic_pte
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Peter Xu <peterx@redhat.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, Jul 13, 2022 at 4:36 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 07/13/22 15:46, Axel Rasmussen wrote:
> > I think there is a small mistake in this patch.
> >
> > Consider the non-minor-fault case. We have this block:
> >
> > /* Add shared, newly allocated pages to the page cache. */
> > if (vm_shared && !is_continue) {
> >         /* ... */
> > }
> >
> > In here, we've added the newly allocated page to the page cache, and
> > we've set this page_in_pagecache flag to true. But we *do not* setup
> > rmap for this page in this block. I think in this case, the patch will
> > cause us to do the wrong thing: we should hugepage_add_new_anon_rmap()
> > further down, but with this patch we dup instead.
>
> I am not sure I follow.  The patch from Miaohe Lin would not change any
> behavior in the 'if (vm_shared && !is_continue)' case.  In this case
> both vm_shared and page_in_pagecache are true.
>
> IIUC, the patch would address the case where !vm_shared && is_continue.

Ah, you're right, my interpretation of the various flags got mixed up
somewhere along the way.

page_in_pagecache is equivalent to vm_shared in this function,
*except* when we have is_continue. Given that, I think this patch is
correct in the vm_shared case (no behavior change). In case of
!vm_shared && is_continue, I agree the patch is a correction to the
previous behavior.

>
> On 07/12/22 21:05, Miaohe Lin wrote:
> > In MCOPY_ATOMIC_CONTINUE case with a non-shared VMA, pages in the page
> > cache are installed in the ptes. But hugepage_add_new_anon_rmap is called
> > for them mistakenly because they're not vm_shared. This will corrupt the
> > page->mapping used by page cache code.
> >
> > Fixes: f619147104c8 ("userfaultfd: add UFFDIO_CONTINUE ioctl")
> > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> > ---
> >  mm/hugetlb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 8d379e03f672..b232e1508e49 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -6038,7 +6038,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> >       if (!huge_pte_none_mostly(huge_ptep_get(dst_pte)))
> >               goto out_release_unlock;
> >
> > -     if (vm_shared) {
> > +     if (page_in_pagecache) {
> >               page_dup_file_rmap(page, true);
> >       } else {
> >               ClearHPageRestoreReserve(page);
>
> --
> Mike Kravetz
