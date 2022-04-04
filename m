Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229524F1440
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbiDDMD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbiDDMDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:03:54 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67D93526B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 05:01:58 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2eb3db5b172so50099777b3.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 05:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qiD2DiGzP9w26sYqe+Qe9/hDnbh5oNwQt5iQwmO4JSw=;
        b=f0Q/WVKIXSIDfrftxANHLkiSt8cLGcIxC2CKNOOHR1qG5zVRc6lm6AKe9sz79acMOl
         o2eMNhB+4khUHjghxea1XC3y2YB/ZKAHo4/aJv2HQQ9m83CByvZyEP3G64oxzlG0vO8F
         8/8Ni0EIF6svCJYvrABjqP3Mq8lJdQZyK7M9voCo8A2QF5/wy7cXX6n689kSTuEHQdsy
         uWkaq+Px33gmCtC/pZB7GE7Qf+EoxpvqsZfCo1fEZiBVFvFKk/CQ76EHwjgohkYr2HIs
         df/HzJZ3KqkcSOVJP+cMXxOA9vRoUvH+IybMVW0g+ol8aymnpDd2O6/4MFMaaEG5q/rP
         gSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qiD2DiGzP9w26sYqe+Qe9/hDnbh5oNwQt5iQwmO4JSw=;
        b=cUVnXdbfuzes5MAT9iYwmj8+qecxX5FAdgjov+EW/cb4yD1RjXX1X3cyuXN/ADl6BJ
         i42T720l+kmO6pJ3vTT0Nq/ScryT2fEPs6Ru8sftziMizzpxhj4OLzileIT6rKyGl1pv
         JOhHjyDOJn43JoYjFzXNbtWp2BHApf2Cwe8MxzXdzg0FTK2+AxVdO752t9SdvBS6xMJz
         nn3fS9jozcRVclsxVqkZ/KBt0Pw7WqYROtdlEyjcuh9x9rYeIht7ZdFtuy6bSz4RNXPx
         dOsIbue/v0+brierku/z3Xm8nMg4LnRLm+46qTris9Z1KlyedCCCKR4hoDKDQ8BfdbXU
         EE7w==
X-Gm-Message-State: AOAM532dN8TnW+a8IcMzQ2J5VqsevUwlJrnxRUdHQOoqQZ1jCeJK0FuX
        EVmr+GxeL0u3Q3HRkqI+tDAVujbLwgkJ2dHfWiQghw==
X-Google-Smtp-Source: ABdhPJzlpsN0VsnXmKmAJkc1075L7eWicj13X0fkmppuQ3CoZUy2le5DGuweiF9leR/SLew6G9M1rG+BHnj3ZDFxaTU=
X-Received: by 2002:a81:1196:0:b0:2eb:897a:7b5 with SMTP id
 144-20020a811196000000b002eb897a07b5mr868948ywr.31.1649073716376; Mon, 04 Apr
 2022 05:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220331065640.5777-1-songmuchun@bytedance.com>
 <20220331065640.5777-2-songmuchun@bytedance.com> <dd980687-a1ef-f4b5-bb29-da14f89c087e@arm.com>
In-Reply-To: <dd980687-a1ef-f4b5-bb29-da14f89c087e@arm.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 4 Apr 2022 20:01:20 +0800
Message-ID: <CAMZfGtX5NXudeAsYKU8mDtPn0+bw_3FhCsAW0PMBTqTTkp-fQQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: mm: hugetlb: Enable HUGETLB_PAGE_FREE_VMEMMAP
 for arm64
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Mon, Apr 4, 2022 at 5:25 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> Hello Muchun,
>
> On 3/31/22 12:26, Muchun Song wrote:
> > The feature of minimizing overhead of struct page associated with each
> > HugeTLB page aims to free its vmemmap pages (used as struct page) to
> > save memory, where is ~14GB/16GB per 1TB HugeTLB pages (2MB/1GB type).
>
> Enabling this feature saves us around 1.4/1.6 % memory but looking from
> other way around, unavailability of vmemmap backing pages (~1.4GB) when
> freeing up a corresponding HugeTLB page, could prevent ~1TB memory from
> being used as normal page form (requiring their own struct pages), thus
> forcing the HugeTLB page to remain as such ? Is not this problematic ?
>
> These additional 1TB memory in normal pages, from a HugeTLB dissolution
> could have eased the system's memory pressure without this feature being
> enabled.

You are right. If the system is already under heavy memory pressure, it could
prevent the user from freeing HugeTLB pages to the buddy allocator. If the
HugeTLB page are allocated from non-movable zone, this scenario may be
not problematic since once a HugeTLB page is freed, then the system will
have memory to be allocated to be used as vmemmap pages, subsequent
freeing of HugeTLB pages may be getting easier.  However, if the HUgeTLB
pages are allocated from the movable zone, then the thing becomes terrible,
which is documented in Documentation/admin-guide/mm/memory-hotplug.rst.

So there is a cmdline "hugetlb_free_vmemmap" to control if enabling this
feature.  The user should enable/disable this depending on their workload.

Thanks.
