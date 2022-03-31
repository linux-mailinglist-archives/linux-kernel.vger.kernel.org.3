Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EAE4ED1DB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 04:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiCaCsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 22:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiCaCsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 22:48:50 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3282FF47D9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 19:47:02 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id j2so40107848ybu.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 19:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8NPuXtmkQe6NovnkmDlFmVy5m4QYYpAMInYA7xGOx2Q=;
        b=Igk8w1PS8SQhCJ4GFifHaOTlnBZ1yUTlTCCw2ZKZOYZCf9pcG6n86gOTs3vA9A78Hg
         a+ebSS6n4PUW92g2u6vG4oXI1mBIUGcbZ/MDIxApF7hWs2GOEhrBMvjo/pthKNXl/2cG
         HQVZxuCD5z+5GC7HLQCIZI0O2bT+u6djqpg+y1m1oS3NWDCLB0b/j7VsJSta4O22nNWr
         l4Gc8pvgDj+0FKUE01YdbRW6Q/VEQZfXiuikPnP8XJozWPSzv1sViCWCAHReRVy59OW/
         9Wx0otMuBX2OmiSIBORuhn3bZCwqdgaQi4xUtsvKZJwouDMnT8tXRt5cPIexjx+wVFlU
         VCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8NPuXtmkQe6NovnkmDlFmVy5m4QYYpAMInYA7xGOx2Q=;
        b=O88OAfrGt56mV7DGBwEYP17yir0Dj3B1u3epOggiIwnK/h6lF1B19cBO59C9Hgfxvp
         qRdoEJYUOR4jhFd8t2Ipxhsfeg5cbqYsaNbH/4KHtrCFJAan6scqAZpzWxpQVHM5Hglq
         bhEdfuj8IfNeE/Kd1tT5V7fa2yRSBgVQJ8SEgVq0f16YgtJQDwUSpv3n5vPAUHmdCcm1
         UCl2WE/JGj7krtmfsUHD940Xz5XzOSiLsQ6LB73BsAskQ9+epZu5iKPo4th+vBG8BjON
         veWjtC80ndOvAoaSBxAmqGzrRhPfV35RvdL7Ye9E/5mOmFuZp0A7m4k39vh5mIRLE5KU
         7qmw==
X-Gm-Message-State: AOAM530CO5QrlS+n7OUr9iREFKFMqqS/NmoUsC7AzaAwKwsTAZW1g6V2
        qxy8k/Td31kfY0wu5W3Jyb8EwkdIbtXLNjFD5pahJQ==
X-Google-Smtp-Source: ABdhPJywWclxrDM+LzsFtFquAtJcvqnpKnUd/aGQSW5m2jcdMKPz7qt0LRLWKzoNvyjLHUsFfc+oX6CYNUWyV0SQPrE=
X-Received: by 2002:a25:e70e:0:b0:634:1a47:4ff2 with SMTP id
 e14-20020a25e70e000000b006341a474ff2mr2472793ybh.89.1648694821329; Wed, 30
 Mar 2022 19:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220330145400.18565-1-songmuchun@bytedance.com> <20220330194147.000c80ef35345397756e096e@linux-foundation.org>
In-Reply-To: <20220330194147.000c80ef35345397756e096e@linux-foundation.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 31 Mar 2022 10:46:25 +0800
Message-ID: <CAMZfGtWqsQsyr6-R1CtA9Uzswrb7MRXbBZqa4VKA9NCYyVvKOA@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: mm: hugetlb: Enable HUGETLB_PAGE_FREE_VMEMMAP
 for arm64
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        David Hildenbrand <david@redhat.com>,
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

On Thu, Mar 31, 2022 at 10:41 AM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Wed, 30 Mar 2022 22:54:00 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
>
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -247,7 +247,7 @@ config HUGETLB_PAGE
> >
> >  config HUGETLB_PAGE_FREE_VMEMMAP
> >       def_bool HUGETLB_PAGE
> > -     depends on X86_64
> > +     depends on X86_64 || ARM64
>
> This list is just going to get longer, until someone goes and switches
> it to use ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP or whatever.  Why not do
> that now?

Good suggestion. Yep, the line is going to be long if someone
wants to enable it for other architectures in the future.  Will do.
Thanks.
