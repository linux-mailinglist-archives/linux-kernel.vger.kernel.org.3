Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C618855E1E0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239610AbiF0Qsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239597AbiF0Qsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:48:40 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275FA25CF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:48:40 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so10012319pjz.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JK+x8HHa/lHbi1+M/aXyrWBlrZRg6SDvk2Gogvlt21Y=;
        b=iJvgJ0mSW6BG/xkNSTSqwqK2GeiJgOVdQEav7Y8FdBwgfJzO5UE6UhWPNsQBMh0iPj
         zPZ4jYUsOOVBF7lsYgqXEaKlBPkUjepn0YBPgM/4S9u/J/Ccf/93IpVJv9LVksW+zz31
         tfeKlhfOCrHX+jqTrArxkoYvnJYz4NTqbissf1l7+bFiJxXGtXstn34v9nm5cmi72HOk
         wWifAPCO+v4Xh1xw2YGuwNoKKoXYaVW719DeCmNjmIPieV1bebKf2yUK1JPOaTr+g3fX
         1bdeXp3+S6YTfCKGo8AXn166wXEjnS3w0fkFngPnPm0AH4jWvLXhlz034cHxjMmyoezE
         S37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JK+x8HHa/lHbi1+M/aXyrWBlrZRg6SDvk2Gogvlt21Y=;
        b=2VcCgGUj1OJevlaxInKTlubz1EsP/z/Ke7Q6T8EdXr9ExI5VwouGAU9iAUX0BiH3Lu
         M2mBZadvLQ4bqFDGhD9QGyZwfzOXQYONZju+Ni83FhIH52TcNrtUkrtpxBfbILFvB/rr
         spgqPGyWJGzfyl7UAft2rQfTLAHXQW4cbhuZ6otkXIjcdH5qDXM2mE65JzVlRCM9uioo
         xiKsrlxWq8VdJZGPJAW1y7E2HV/y+69+BQbBZPjIylDUeFzrYnfO0fUbZ02RrmDdMKR+
         JllF74g2NgCSLZFiokMA0zZvOVq7j2lB8ndc7BCQCn6vht1C84B3oMspI7ciwmHK3BE7
         d77w==
X-Gm-Message-State: AJIora/7Vzj6fzDEtKukQ0QpIm2AxiMaLdWWSz7iDG5YOHyE58SHOfgz
        WgF0OVjSrMFxLVahXWAOsyf4KuDTmqu7EGfZCVcOUA==
X-Google-Smtp-Source: AGRyM1sX7Vhn+yEBOB2idsT35DSBVtMO8mXoQcJ7fPN60gbm72EjQuxU1i7V3VmIapFGKTMyi/ggNbZ1UwR4Is/rrJ4=
X-Received: by 2002:a17:902:e94f:b0:16a:214e:46c1 with SMTP id
 b15-20020a170902e94f00b0016a214e46c1mr15674368pll.89.1656348519523; Mon, 27
 Jun 2022 09:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com> <YrYGwVf8qbbBA62z@casper.infradead.org>
In-Reply-To: <YrYGwVf8qbbBA62z@casper.infradead.org>
From:   James Houghton <jthoughton@google.com>
Date:   Mon, 27 Jun 2022 09:48:28 -0700
Message-ID: <CADrL8HWQsoBnPu+8u+inPvgf8QLjp5npnPAvUQR88FeEBkdJsA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/26] hugetlb: Introduce HugeTLB high-granularity mapping
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Fri, Jun 24, 2022 at 11:47 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Jun 24, 2022 at 05:36:30PM +0000, James Houghton wrote:
> > - Page table walking and manipulation
> > A new function, hugetlb_walk_to, handles walking HugeTLB page tables for
> > high-granularity mappings. Eventually, it's possible to merge
> > hugetlb_walk_to with huge_pte_offset and huge_pte_alloc.
> >
> > We keep track of HugeTLB page table entries with a new struct, hugetlb_pte.
> > This is because we generally need to know the "size" of a PTE (previously
> > always just huge_page_size(hstate)).
> >
> > For every page table manipulation function that has a huge version (e.g.
> > huge_ptep_get and ptep_get), there is a wrapper for it (e.g.
> > hugetlb_ptep_get).  The correct version is used depending on if a HugeTLB
> > PTE really is "huge".
>
> I'm disappointed to hear that page table walking is going to become even
> more special.  I'd much prefer it if hugetlb walking were exactly the
> same as THP walking.  This seems like a good time to do at least some
> of that work.
>
> Was there a reason you chose the "more complexity" direction?

I chose this direction because it seemed to be the most
straightforward to get to a working prototype and then to an RFC. I
agree with your sentiment -- I'll see what I can do to reconcile THP
walking with HugeTLB(+HGM) walking.
