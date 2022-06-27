Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B319455D9A5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239571AbiF0UcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbiF0UcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:32:08 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D8855AF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:32:07 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id o18so9224461plg.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xOTqt2NzbHzxCcIdb/5dVCyc4Y5XKzKcuV2da4Pe3sU=;
        b=s6Yj535xe8wTym089FUnEVMRxODSMelDXhtVan3Cukid9yH3HLh30yziKYiBDRvblu
         P30b4AyjS97fY9wOI4iVI1EvAGdmdwBrvqwt2DN8hgEuCtsx5hyWnaA4P+7D9S8iGkWR
         /bERQuxrbqvdyvXPJiMcmgsVlzmKNrrkRkrzElirfBltapCX/eJDUWGC8rin0JRfN0/j
         U8Ba9PsflxyFF/jXjzwhVJJbilgZOWAdpxIO2jNW4xHrF0Znf7A9rqU0/Lu7FR0RMNOx
         h9VNmZAuXPHKd/ll1zHtx28xlD1Iv2IaexdRsLKtx7Y0UyfLgGv7PzzrXZJMu2tLx+Yu
         JvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xOTqt2NzbHzxCcIdb/5dVCyc4Y5XKzKcuV2da4Pe3sU=;
        b=Btdlg26QDwOq5L4zEjCE0yT2G37quqQALwlBuKqTFeAuj9S75mrC+eg8MB5frPz8EA
         7e+ZdWZjsV07LCK7kxd+hnyX6TIdT/zoOEzQu3qpwUbLRqGIPoBcgCm8P6UdatHuLfXu
         ctpJZT+bEFtQvZeEcYBnq3uvFp9yhCJFCEturZMlWK8xYiZb3lRe+nAYpUFGtn3Btw0D
         LXYAyQZa8MQIfbngSwdLxNKX1emUKI4e1YXtJ8ZSge9ukl03Pv31RzLJf8dtZYq55bJD
         FSma2EYlsQJLRwX6vScEByqJdXf7wj2Lv06zQWAU9AcAicuZCzBwJbxy/5Nq8IetNjXh
         XoBQ==
X-Gm-Message-State: AJIora/kEKcbrMMg018nDYIICr9fH4TXtKco/+bIMa0od2At+UxLix7m
        83b7LYc1dQawzCyWSwTxI43h6si9EevkpKepdYu6xw==
X-Google-Smtp-Source: AGRyM1tL3m0Ue3Q02NUf5oLxUMDrlnFmH2h/VNVw51AhvJZgkgIrzjV2QPv0tm5I6IupzaASk3eP5iJpRAPtCRDk3rE=
X-Received: by 2002:a17:903:2490:b0:168:d4d0:54da with SMTP id
 p16-20020a170903249000b00168d4d054damr1318632plw.42.1656361926968; Mon, 27
 Jun 2022 13:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
 <YrYCeYy0rjfGhT/W@casper.infradead.org> <CADrL8HUtdd=yEtY=bhHRYVjA30O1CAd6XEj+oTNjviWkSmzowQ@mail.gmail.com>
 <YrnvORvPKbzgxLCu@work-vm>
In-Reply-To: <YrnvORvPKbzgxLCu@work-vm>
From:   James Houghton <jthoughton@google.com>
Date:   Mon, 27 Jun 2022 13:31:56 -0700
Message-ID: <CADrL8HX4eNREyiuDPSoQpZPObTe7Kto3UurMHYeeO-3TdTo87w@mail.gmail.com>
Subject: Re: [RFC PATCH 00/26] hugetlb: Introduce HugeTLB high-granularity mapping
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>
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

On Mon, Jun 27, 2022 at 10:56 AM Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * James Houghton (jthoughton@google.com) wrote:
> > On Fri, Jun 24, 2022 at 11:29 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Fri, Jun 24, 2022 at 05:36:30PM +0000, James Houghton wrote:
> > > > [1] This used to be called HugeTLB double mapping, a bad and confusing
> > > >     name. "High-granularity mapping" is not a great name either. I am open
> > > >     to better names.
> > >
> > > Oh good, I was grinding my teeth every time I read it ;-)
> > >
> > > How does "Fine granularity" work for you?
> > > "sub-page mapping" might work too.
> >
> > "Granularity", as I've come to realize, is hard to say, so I think I
> > prefer sub-page mapping. :) So to recap the suggestions I have so far:
> >
> > 1. Sub-page mapping
> > 2. Granular mapping
> > 3. Flexible mapping
> >
> > I'll pick one of these (or maybe some other one that works better) for
> > the next version of this series.
>
> <shrug> Just a name; SPM might work (although may confuse those
> architectures which had subprotection for normal pages), and at least
> we can mispronounce it.
>
> In 14/26 your commit message says:
>
>   1. Faults can be passed to handle_userfault. (Userspace will want to
>      use UFFD_FEATURE_REAL_ADDRESS to get the real address to know which
>      region they should be call UFFDIO_CONTINUE on later.)
>
> can you explain what that new UFFD_FEATURE does?

+cc Nadav Amit <namit@vmware.com> to check me here.

Sorry, this should be UFFD_FEATURE_EXACT_ADDRESS. It isn't a new
feature, and it actually isn't needed (I will correct the commit
message). Why it isn't needed is a little bit complicated, though. Let
me explain:

Before UFFD_FEATURE_EXACT_ADDRESS was introduced, the address that
userfaultfd gave userspace for HugeTLB pages was rounded down to be
hstate-size-aligned. This would have had to change, because userspace,
to take advantage of HGM, needs to know which 4K piece to install.

However, after UFFD_FEATURE_EXACT_ADDRESS was introduced[1], the
address was rounded down to be PAGE_SIZE-aligned instead, even if the
flag wasn't used. I think this was an unintended change. If the flag
is used, then the address isn't rounded at all -- that was the
intended purpose of this flag. Hope that makes sense.

The new userfaultfd feature, UFFD_FEATURE_MINOR_HUGETLBFS_HGM, informs
userspace that high-granularity CONTINUEs are available.

[1] commit 824ddc601adc ("userfaultfd: provide unmasked address on page-fault")


>
> Dave
>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
