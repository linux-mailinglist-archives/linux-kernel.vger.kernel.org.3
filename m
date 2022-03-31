Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987264ED648
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbiCaI4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiCaI4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:56:15 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF04CFB99
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:54:25 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2eafabbc80aso30728017b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xn8azzFhzPhyLx+cU3W3Fc2v8I4Cjd0IkMQ9uqr47o8=;
        b=5vtJ2thFavd9cLivjIt3UYcmVVHdyG8sUhR6t4y9k09OG/HquF9FJUQEWh12OMpeCd
         8QZWJP2cIWOpXHZVjwUAWn3b+rZNye1bM3f3hsfjxx/HwsdrZEk7ZSFeSHZPBsFYiPBF
         V5q91UAat/yBLYIr5qLMFKO7RrzV1PcOW57tDQS7GangAFjkcqnqv3RXl6Z1Hcxw1R0g
         SXpZDRNAaIRvtNg4RFoA7lbpVwLoZjZmkZg36nea/VMZa4MytSYGtolbRSukFadOMslq
         WtyF+R19LohMwn2b4IPdNNojqBiELaXz8cfmxjhUfkUVgHkZEztwtTjiYdQ3rxOGEDi8
         ctNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xn8azzFhzPhyLx+cU3W3Fc2v8I4Cjd0IkMQ9uqr47o8=;
        b=Df7QaWXlHH2A+O1OpUyB9nHcnuYq5n/GOuyvda/99dV37/ocqknh9bX2IUHX/FzNMi
         06mAYJFl9SuKZfldKf7xFy/9R1kjOOqI2mtyb++2quQbmUWQam4w2dFZjfdqosWtQ1+c
         besMUisX9HKAO2lpWg4FGhdScO05mwLiL/1ENyxLsG5Ii4CBBJrUs/kjrbJbNGwKBF+F
         lBhzP1Y2wkoHBCtzfMsLWVcNV77ruj/3Rum7m5fjwAH2QDv5Qb6353PLfNwvAr/gFWNJ
         9FlfiELzk35Vp7gJ9Fzi/0N3ijGkbx8CFltH9Xhu6YOspPiWh4c9JH9NbTf+RcFvt5XL
         lLhw==
X-Gm-Message-State: AOAM530r7YS33waDCQYl7PQ3M782pa+Fh+Pi9jDTy5ZQ221YAujcGuQq
        MRG0F7JYAgbGGMF+CXLJ2C1zG689QzRRL1cdimkMVA==
X-Google-Smtp-Source: ABdhPJxw6+paO/ULlF+r7RmJCKQmMCdHrJH4j9IS297GY/P3ppySDM2E+Tmp5keTQENtNboxL9+OZGX99Bm3WL+EJSk=
X-Received: by 2002:a81:1c4f:0:b0:2e5:9db3:7a8e with SMTP id
 c76-20020a811c4f000000b002e59db37a8emr3679214ywc.319.1648716864751; Thu, 31
 Mar 2022 01:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220331065640.5777-1-songmuchun@bytedance.com>
 <6c774e27-26d2-6c45-65f9-8a5b8acd6433@redhat.com> <CAMZfGtV6=n60f2cEWWtFk8Ci1c_JzeNJCmzAs2X6EHZkaXfP6Q@mail.gmail.com>
 <445c5426-cfb6-0232-6ea5-41cf8aaa264e@redhat.com>
In-Reply-To: <445c5426-cfb6-0232-6ea5-41cf8aaa264e@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 31 Mar 2022 16:53:48 +0800
Message-ID: <CAMZfGtVsSJWT6Fojr5FcN26=MPnjp79usQXF+xRGXHLUvwYU_Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: hugetlb_vmemmap: introduce ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP
To:     David Hildenbrand <david@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
        Barry Song <21cnbao@gmail.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Fam Zheng <fam.zheng@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 4:51 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 31.03.22 10:48, Muchun Song wrote:
> > On Thu, Mar 31, 2022 at 4:42 PM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 31.03.22 08:56, Muchun Song wrote:
> >>> The feature of minimizing overhead of struct page associated with each
> >>> HugeTLB page is implemented on x86_64, however, the infrastructure of
> >>> this feature is already there, we could easily enable it for other
> >>> architectures.  Introduce ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP for other
> >>> architectures to be easily enabled.  Just select this config if they
> >>> want to enable this feature.
> >>>
> >>> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> >>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >>> ---
> >>>  arch/x86/Kconfig |  1 +
> >>>  fs/Kconfig       | 10 +++++++++-
> >>>  2 files changed, 10 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> >>> index 9f5bd41bf660..e69d42528542 100644
> >>> --- a/arch/x86/Kconfig
> >>> +++ b/arch/x86/Kconfig
> >>> @@ -119,6 +119,7 @@ config X86
> >>>       select ARCH_WANTS_DYNAMIC_TASK_STRUCT
> >>>       select ARCH_WANTS_NO_INSTR
> >>>       select ARCH_WANT_HUGE_PMD_SHARE
> >>> +     select ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP      if X86_64
> >>>       select ARCH_WANT_LD_ORPHAN_WARN
> >>>       select ARCH_WANTS_THP_SWAP              if X86_64
> >>>       select ARCH_HAS_PARANOID_L1D_FLUSH
> >>> diff --git a/fs/Kconfig b/fs/Kconfig
> >>> index 6c7dc1387beb..f6db2af33738 100644
> >>> --- a/fs/Kconfig
> >>> +++ b/fs/Kconfig
> >>> @@ -245,9 +245,17 @@ config HUGETLBFS
> >>>  config HUGETLB_PAGE
> >>>       def_bool HUGETLBFS
> >>>
> >>> +#
> >>> +# Select this config option from the architecture Kconfig, if it is preferred
> >>> +# to enable the feature of minimizing overhead of struct page associated with
> >>> +# each HugeTLB page.
> >>> +#
> >>> +config ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP
> >>> +     bool
> >>> +
> >>>  config HUGETLB_PAGE_FREE_VMEMMAP
> >>>       def_bool HUGETLB_PAGE
> >>> -     depends on X86_64
> >>> +     depends on ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP
> >>>       depends on SPARSEMEM_VMEMMAP
> >>>
> >>>  config HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON
> >>
> >>
> >> I think something like "HUGETLB_OPTIMIZE_VMEMMAP" might be more
> >> expressive, but that would imply renaming the existing config knob.
> >>
> >
> > How about doing a full code cleanup in a separate series in the future?
> >
>
> Yeah.
>

OK. Have Added it into my To-do list.

Thanks.
