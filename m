Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9BB4ED62A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbiCaIvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiCaIu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:50:58 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414463B007
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:49:10 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2e5827a76f4so246270237b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wZXg0Wk9U3eMPQQ4UazcTOVg50FT5PR+ms1Rv/O8uCA=;
        b=hF8NFikAHise1/tYewXzZvTJNTN9TjGoI3aMW6OzvdRwNeEZei9fo2XJCfe+N+eV5J
         QYyirxTyzU/AHFDAB2oXhusj7nlJeC9WtbOY0E5WwWtN35FrEmd2wZl3JkfxaBSvqC9E
         yS+dM4NKYp57Srqgrf507Y+NfpGcIJHrwHDf+IVXPnWD/xCrJ/gucYOSY9tqNcm5oAks
         Z3dD2MFzKoWjExJo1bGI/gwSW9jxwmrBjEfyf2k3m0aEvTDawuYPOtyB/9c0Es6SHc/X
         0EqGP3kd7m4gLOqnmz2l/Ji/090Dh9eDQIZ5Cat40Pjg140u18LgOjAx75AyavvkKUAg
         7anw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wZXg0Wk9U3eMPQQ4UazcTOVg50FT5PR+ms1Rv/O8uCA=;
        b=p3VOxUSU+1yyHfNRrPE3rWe5Gi7pUcaQG6U5xAj5Ok20cCAffRturIlNmSzVJPWFEz
         TCmyn3d623Mo3CIj3pBu7tV1FCiL+S3Dw/jjOeQzJz7oPXb7kgDxr56HjNItUz4AB653
         3krJTcy5PVodlTiBmyME7K3h4iz+ptC2R0SyY4455I4zijR+GBaay+jlZ4V3jfPgjKwE
         SW2L9DQCv7hGtO5T4rYQRq51LLsEJCoqGQNxaoba5x6nRvf9/1kPMciJ3HFGVj0bh6pp
         ka60P64sVZ094Ds+p3f5CQMf3H5VQG3Dvtq27dw1zmrRnyxH4k7Ckr8KpkYkdQ5aXIm9
         qt9w==
X-Gm-Message-State: AOAM532uECozZxslFvvce1o84NdBnti+/o4kLiuJUDon26kcYBtk5MRo
        XvM9G/FvxyNDKJVEbi2FNn5bGUdpJYVGyZIJ731Txg==
X-Google-Smtp-Source: ABdhPJyvfTSa45LVThNTL1ozkOHEy9or+BjMwghda/8khUheyPrr89Rwl6DGXpWdcL77w/7pBLQ0L5ZwByBn8dKTGwk=
X-Received: by 2002:a0d:ccca:0:b0:2e6:2b53:3f16 with SMTP id
 o193-20020a0dccca000000b002e62b533f16mr4098014ywd.35.1648716549512; Thu, 31
 Mar 2022 01:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220331065640.5777-1-songmuchun@bytedance.com> <6c774e27-26d2-6c45-65f9-8a5b8acd6433@redhat.com>
In-Reply-To: <6c774e27-26d2-6c45-65f9-8a5b8acd6433@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 31 Mar 2022 16:48:33 +0800
Message-ID: <CAMZfGtV6=n60f2cEWWtFk8Ci1c_JzeNJCmzAs2X6EHZkaXfP6Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: hugetlb_vmemmap: introduce ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP
To:     David Hildenbrand <david@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>,
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

On Thu, Mar 31, 2022 at 4:42 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 31.03.22 08:56, Muchun Song wrote:
> > The feature of minimizing overhead of struct page associated with each
> > HugeTLB page is implemented on x86_64, however, the infrastructure of
> > this feature is already there, we could easily enable it for other
> > architectures.  Introduce ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP for other
> > architectures to be easily enabled.  Just select this config if they
> > want to enable this feature.
> >
> > Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  arch/x86/Kconfig |  1 +
> >  fs/Kconfig       | 10 +++++++++-
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 9f5bd41bf660..e69d42528542 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -119,6 +119,7 @@ config X86
> >       select ARCH_WANTS_DYNAMIC_TASK_STRUCT
> >       select ARCH_WANTS_NO_INSTR
> >       select ARCH_WANT_HUGE_PMD_SHARE
> > +     select ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP      if X86_64
> >       select ARCH_WANT_LD_ORPHAN_WARN
> >       select ARCH_WANTS_THP_SWAP              if X86_64
> >       select ARCH_HAS_PARANOID_L1D_FLUSH
> > diff --git a/fs/Kconfig b/fs/Kconfig
> > index 6c7dc1387beb..f6db2af33738 100644
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -245,9 +245,17 @@ config HUGETLBFS
> >  config HUGETLB_PAGE
> >       def_bool HUGETLBFS
> >
> > +#
> > +# Select this config option from the architecture Kconfig, if it is preferred
> > +# to enable the feature of minimizing overhead of struct page associated with
> > +# each HugeTLB page.
> > +#
> > +config ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP
> > +     bool
> > +
> >  config HUGETLB_PAGE_FREE_VMEMMAP
> >       def_bool HUGETLB_PAGE
> > -     depends on X86_64
> > +     depends on ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP
> >       depends on SPARSEMEM_VMEMMAP
> >
> >  config HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON
>
>
> I think something like "HUGETLB_OPTIMIZE_VMEMMAP" might be more
> expressive, but that would imply renaming the existing config knob.
>

How about doing a full code cleanup in a separate series in the future?
