Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386724E6D86
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 06:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358313AbiCYFGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 01:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240824AbiCYFF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 01:05:59 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E5D3B3F1;
        Thu, 24 Mar 2022 22:04:23 -0700 (PDT)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 22P546wv019627;
        Fri, 25 Mar 2022 14:04:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 22P546wv019627
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648184646;
        bh=+nbVLVe1bM7YnaTTi41MNR/HwHCFu6l63dF/H0TQ20Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q8dMV36nheri5FTS95t4SbM8OYyEifTs8plSvxKgIjGv2+mfhAxW/s6tNOtHXGqGJ
         tvZUoebnM9kWTXv8WJnXZLJ7P8l5u1099Jh/ZrtDUHtAQlFYOvbjtJKfodFYbFfmKO
         YlywU8Hv5mncd1a0T+lQcLRlxzVEhqubZMMRgeQXMFefYV65b+SGvlr/1ReW/i3C42
         ynkd1jnn3XrohC+s81YlGnJDG2gUyciq3rgKzRbK8UInpji1MJj5ai4VRaPnPaaBhu
         nGFE92hD1BrZNDA4HakhjtceNcuk3IqGY4iZM9CTVWq+KesYCXN9U4yfbmc/uPSsPZ
         qleuM5K8Wz2OQ==
X-Nifty-SrcIP: [209.85.210.178]
Received: by mail-pf1-f178.google.com with SMTP id s11so5557945pfu.13;
        Thu, 24 Mar 2022 22:04:06 -0700 (PDT)
X-Gm-Message-State: AOAM530uxzX85bDrN1YanBOnCsMevgvMa6KQlcjASDLEt1G4s8MqMiWm
        a3Hpm+GLkyPwFRE3sX0kzFhTy3HwKe1a9nT3FWU=
X-Google-Smtp-Source: ABdhPJz7MbyZrPoQrOu/v3LN46Zoprml0E0NqNBLNk21Ve5E7LNHIVqEM2P2PFg/Sda3I1GP/cfZ3v7cS60xonYvP3w=
X-Received: by 2002:a63:dc53:0:b0:381:7f41:3a2d with SMTP id
 f19-20020a63dc53000000b003817f413a2dmr6709055pgj.126.1648184645660; Thu, 24
 Mar 2022 22:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220323125523.79254-1-songmuchun@bytedance.com> <YjuX5WCHNsjxgcCM@bombadil.infradead.org>
In-Reply-To: <YjuX5WCHNsjxgcCM@bombadil.infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 25 Mar 2022 14:03:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNASSzXsRkgR=P56Xdpk7OtVeX+GnQ-WTwVWKfcKRc0z7Pw@mail.gmail.com>
Message-ID: <CAK7LNASSzXsRkgR=P56Xdpk7OtVeX+GnQ-WTwVWKfcKRc0z7Pw@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] add hugetlb_free_vmemmap sysctl
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, mike.kravetz@oracle.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 6:58 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> Masahiro,
>
> can I trouble you to help review the first patch here? I thought
> something like this might be possible, and Muchun has done some good
> work to try it. If anyone can find hole on that kconfig hack it would
> be you. I'll bounce you a copy of the patches.
>
>   Luis


Now, I took a look at it.
Please do not do such a horrible hack.

Thanks.











>
> On Wed, Mar 23, 2022 at 08:55:19PM +0800, Muchun Song wrote:
> > This series is based on next-20220310.
> >
> > This series amis to add hugetlb_free_vmemmap sysctl to enable the feature
> > of freeing vmemmap pages of HugeTLB pages.
> >
> > v5:
> >   - Fix not working properly if one is workig off of a very clean build
> >     reported by Luis Chamberlain.
> >   - Add Suggested-by for Luis Chamberlain.
> >
> > Thanks.
> >
> > v4:
> >   - Introduce STRUCT_PAGE_SIZE_IS_POWER_OF_2 inspired by Luis.
> >
> > v3:
> >   - Add pr_warn_once() (Mike).
> >   - Handle the transition from enabling to disabling (Luis)
> >
> > v2:
> >   - Fix compilation when !CONFIG_MHP_MEMMAP_ON_MEMORY reported by kernel
> >     test robot <lkp@intel.com>.
> >   - Move sysctl code from kernel/sysctl.c to mm/hugetlb_vmemmap.c.
> >
> > Muchun Song (4):
> >   mm: hugetlb_vmemmap: introduce STRUCT_PAGE_SIZE_IS_POWER_OF_2
> >   mm: memory_hotplug: override memmap_on_memory when
> >     hugetlb_free_vmemmap=on
> >   sysctl: allow to set extra1 to SYSCTL_ONE
> >   mm: hugetlb_vmemmap: add hugetlb_free_vmemmap sysctl
> >
> >  Documentation/admin-guide/sysctl/vm.rst |  14 +++++
> >  Kbuild                                  |  14 +++++
> >  fs/Kconfig                              |   1 +
> >  include/linux/memory_hotplug.h          |   9 +++
> >  include/linux/mm_types.h                |   2 +
> >  kernel/sysctl.c                         |   2 +-
> >  mm/Kconfig                              |   3 +
> >  mm/hugetlb_vmemmap.c                    | 107 ++++++++++++++++++++++++--------
> >  mm/hugetlb_vmemmap.h                    |   4 +-
> >  mm/memory_hotplug.c                     |  27 ++++++--
> >  mm/struct_page_size.c                   |  19 ++++++
> >  scripts/check_struct_page_po2.sh        |   9 +++
> >  12 files changed, 177 insertions(+), 34 deletions(-)
> >  create mode 100644 mm/struct_page_size.c
> >  create mode 100755 scripts/check_struct_page_po2.sh
> >
> > --
> > 2.11.0
> >



-- 
Best Regards
Masahiro Yamada
