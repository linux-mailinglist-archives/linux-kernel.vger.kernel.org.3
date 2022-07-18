Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E154578937
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 20:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbiGRSIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 14:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbiGRSH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:07:59 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A202ED71
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:07:58 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id r70so8780982iod.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KTCpJmC4pecTn3Rx1irJxkC3X2lBUkxseTUJWSLvFWo=;
        b=FXckv+DCJB3SLoCnbb5nkk2+lua/3016I0o2hoZdhYIwogZteGz2j1/S0kClXLkGaA
         XEaMc4YFH8vBGsIHViFRKEPRvezi9A+36iEHQn/gKJrNJDYBoJb1V8NQgL0pbzvGeVy5
         2j9Tj3TeWNkXp+8Ou8QcHvU0VPcUDxfzNQAbDOj4PBmFgFWAZGOs2aQfVuRzQF0JtYzf
         wMepw9N4kGJK2rI5D9nHwfQHqrIT4bVaCEsfSJSAItl+KyP28Rpt9p3tJ2sJ+vxrE9vH
         pGkCiQBXaWINuwWCw41VJOj2TrmzXAl2xvyDAknWlF1DV0iSkOEdSomuueMKNV5iOOyc
         KOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KTCpJmC4pecTn3Rx1irJxkC3X2lBUkxseTUJWSLvFWo=;
        b=SkdWGaJOQPoNf5dNDeLa0a4wV1oTG6hQVnO2UBSFvfdyF0JNejXeJ0PCfRmVbAgIFk
         M7/zjRJ8nIe0a81UtGOU7U/txE93UAy1offcSuEdhlRFoKPnmOFeDatQ+0yV4AwUc+aa
         TycDV7vv7z+CSgA+SIFJMAy5llWnANxYfdoKbz3bFyY1pc143YOlhfPx825F5JZZ39su
         XdJMwIHf7ZiZ2E0aTiEqbAnY+t7qVYTyHsvMYOot3g4B/l6G/6mJETOFo/w2hizxI3ws
         GHQ3wdp1e75CQ8QVXuAhaKIQtRzr17dtWVubfq88SukKS6Jekg81I23bz86p6FhyuGQn
         s22g==
X-Gm-Message-State: AJIora8fGQB/2EDTlY/0qKle3PF4PPecCWGAZvmmDcR689avDCFZ2hBB
        ncow2XOYQcgUbSqig/8SClTgplQgFXeLFUT9dROfmMAVJyg=
X-Google-Smtp-Source: AGRyM1sTup4B+a2XbBmpCjJcMLtlqKrEXWZNvm193+nbm66d2mxBG5Tp8/CncXpoJPLMeUbCZoRZ5z2YN8ywGEs7WBM=
X-Received: by 2002:a05:6638:50:b0:33f:17b9:be63 with SMTP id
 a16-20020a056638005000b0033f17b9be63mr15969485jap.92.1658167677547; Mon, 18
 Jul 2022 11:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220712130542.18836-1-linmiaohe@huawei.com> <20220713102357.8328614813db01b569650ffd@linux-foundation.org>
 <a47922cf-eb30-1ad9-fc96-1896254564ef@huawei.com> <20220716160629.d065828c84ad2423c10f7733@linux-foundation.org>
 <0dcf8902-b14a-860a-cb66-46e57b6d14a9@huawei.com>
In-Reply-To: <0dcf8902-b14a-860a-cb66-46e57b6d14a9@huawei.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Mon, 18 Jul 2022 11:07:21 -0700
Message-ID: <CAJHvVcjpgJL1chHQwBUu5Dqj8Lr5fvw_S3O1=XCZF1CyvcSTEQ@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: avoid corrupting page->mapping in hugetlb_mcopy_atomic_pte
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 7:25 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> On 2022/7/17 7:06, Andrew Morton wrote:
> > On Thu, 14 Jul 2022 17:59:53 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> >
> >> On 2022/7/14 1:23, Andrew Morton wrote:
> >>> On Tue, 12 Jul 2022 21:05:42 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> >>>
> >>>> In MCOPY_ATOMIC_CONTINUE case with a non-shared VMA, pages in the page
> >>>> cache are installed in the ptes. But hugepage_add_new_anon_rmap is called
> >>>> for them mistakenly because they're not vm_shared. This will corrupt the
> >>>> page->mapping used by page cache code.
> >>>
> >>> Well that sounds bad.  And theories on why this has gone unnoticed for
> >>> over a year?  I assume this doesn't have coverage in our selftests?
> >>
> >> As discussed in another thread, when minor fault handling is proposed, only
> >> VM_SHARED vma is expected to be supported
> >
> > So...  do we feel that this fix should be backported?  And if so, is
> > there a suitable commit for the Fixes:?
>
> I tend to backport this fix. And I think the Fixes tag in this patch should be suitable,
> i.e. Fixes: f619147104c8 ("userfaultfd: add UFFDIO_CONTINUE ioctl").

Agreed, it is worth backporting.

>
> Thanks.
>
> > .
> >
>
