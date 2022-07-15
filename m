Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E880576662
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiGORv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGORvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:51:55 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC3052882
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:51:53 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id m20so2887256ili.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Ib/oWEoGNGAe7E62KsRy28LW0NH5ciDw5Z/ulJeK9w=;
        b=tK1+WtJdz6cJlCyxtgNS1wI18oypYIQlGknflDLiNCH+xw8kUdINNgFKKm0sdyscsU
         ha8qV+52x/+QiIPqi7KhkKArzKCc0XA5iWw3Q6ZaR/w7Qfy74sEXpkdk+wgf+rLvFS60
         ymUVB+Z5u31zayhCPJgC2Rrak2PA6eIxbbx3AUeytu+n3TX772N5HIx5mfN/0vpukQ+k
         LDtat6ZoyjAPQOeUjatqEOgurIyszwUl8A6zAzuX+qrJO7k/xBMFIloY/Y0jdcBSrAKw
         aEOhq0Pj/dpdVkkA0KRAR9mKbxvL3vEP+8DR5p4jqW2HrhU44ch/Epm4/tdtnxgQJ3vb
         Znhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Ib/oWEoGNGAe7E62KsRy28LW0NH5ciDw5Z/ulJeK9w=;
        b=Zo4rOkKqkqEKlVDvQm6yxmq64XBzbuUm+BkkvufFYH4djbFF+yP1jgp0Ee6pN3vyi0
         wSpjaGWljx9Ow8kKAFxNwDhu5o+axEXhQp0UbENF5KWJPmdPzfGZSDN9g2hQNKdbkYL5
         7ArLrIDYB6TARCUOBY4pcCB8oqus3jZXrnyePmtLv/HiD5zzMoujvNfGaUdS9MmxSALN
         EHZnC1hSQMBd5xlf+seOpz3Y6m2O9IMMcRG3T+MKHiZ7+yO52FP3d9OxCl4i5pb7SZig
         FOB3vR+9C+xKRwMLCxCtt+fzlkR+DVwa1aOZESM2NKhCAkkQ1Vnd7RS4LX15OedSgBbu
         m9pA==
X-Gm-Message-State: AJIora9ZXNyCtQJX+jcRgwIIClaXJZMmQSiwx2hnqLgarw2nr+CeMQS/
        PCLACvPH56rVgfmzuaXdZXYvmofrjXBya3x7BJJZFg==
X-Google-Smtp-Source: AGRyM1vjbj4Rr5c3VI89RJFhwTarTUoUUR0HUujz6m8LUxrXbX9MxdKDJ9M/9+Lw5IdM9QDk6cfWrgwM0B3OEz20LrY=
X-Received: by 2002:a05:6e02:1885:b0:2dc:5ede:8537 with SMTP id
 o5-20020a056e02188500b002dc5ede8537mr7729954ilu.275.1657907512419; Fri, 15
 Jul 2022 10:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220712130542.18836-1-linmiaohe@huawei.com> <20220713102357.8328614813db01b569650ffd@linux-foundation.org>
 <a47922cf-eb30-1ad9-fc96-1896254564ef@huawei.com> <YtA7svbn4MtuT7qJ@xz-m1.local>
 <402ae708-4c86-8feb-75c4-9339e1deac3b@huawei.com> <YtFfHU3fb/ncCG6O@xz-m1.local>
 <CAJHvVcgFY2uXM=CkxYmHc32Vqb5qmr8vFv0dpFk-2=Ef+Kssqw@mail.gmail.com>
 <YtGe2qIO038e627p@xz-m1.local> <CAJHvVcji14hUsqg=yrtevEqwMtZi7Xwyj4yUnLMaZi0DBqPTHA@mail.gmail.com>
 <YtGmPI41S4w9iwr9@xz-m1.local>
In-Reply-To: <YtGmPI41S4w9iwr9@xz-m1.local>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 15 Jul 2022 10:51:16 -0700
Message-ID: <CAJHvVchMbJjOp4U+5K83YN0XHMRKfGzTLgCnzKd8mjYMQPRWaw@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: avoid corrupting page->mapping in hugetlb_mcopy_atomic_pte
To:     Peter Xu <peterx@redhat.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Fri, Jul 15, 2022 at 10:39 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Jul 15, 2022 at 10:28:44AM -0700, Axel Rasmussen wrote:
> > On Fri, Jul 15, 2022 at 10:07 AM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Fri, Jul 15, 2022 at 09:45:37AM -0700, Axel Rasmussen wrote:
> > > > I agree we should either:
> > > > - Update the UFFD selftest to exercise this case
> > > > - Or, don't allow it, update vma_can_userfault() to also require VM_SHARED
> > > > for VM_UFFD_MINOR registration.
> > > >
> > > > The first one is unfortunately not completely straightforward as Peter
> > > > described. I would say it's probably not worth holding up this fix while we
> > > > wait for it to happen?
> > >
> > > Agreed, Andrew has already queued it.  It actually is a real fix since we
> > > never forbid the user running private mappings upon minor faults, so
> > > it's literally a bug in kernel irrelevant of the kselftest.
> > >
> > > >
> > > > I don't really have a strong preference between the two. The second option
> > > > is what I originally proposed in the first version of the minor fault
> > > > series, so going back to that isn't a problem at least from my perspective.
> > > > If in the future we find a real use case for this, we could always easily
> > > > re-enable it and add selftests for it at that point.
> > >
> > > I'd go for fixing the test case if possible.  Mike, would it be fine if we
> > > go back to /dev/hugepages path based approach in the test case?
> >
> > One possible alternative, can we use memfd_create() with MFD_HUGE_*?
> > This afaict lets us have an fd so we can create two mappings,
> > without having to mount hugetlbfs, pass in a path to the test, ...
>
> Sounds good. :) We can also rework the shared hugetlb too.  Wanna post a
> patch?  I can do that too, let me know otherwise.  Thanks!

Sure, I'll take a whack at it.

>
> --
> Peter Xu
>
