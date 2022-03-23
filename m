Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81D24E5AF4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 22:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345065AbiCWV7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 17:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345055AbiCWV7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 17:59:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3682628;
        Wed, 23 Mar 2022 14:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=89YbAuXI9BbNTOLNzdMzv6qYGRqw+m92TMqbl+MwwvM=; b=lKqQyKLwsV18YK3hle2Y60Jr2Y
        Z7lGfQiD0+Och7CcgW1JZVR64mRGIh/cM4hazTGwnUAweDegUIR4j3IVCQw0vNzy0oM3xi7vZgVOg
        Bd9HZLxmicGWUA09CvHGI9ujA5RumuHLOzTJzs5EGrAg1FTm8R2goxnjmB8wyZsXpc/BSIsf+mN3Y
        gZKjrQM67Yr9TQb2BcfESbTsZttu2xr4T9IHVEdh/a2C7IUws9LmIAUjiXwPoQ088BKmFIJXM3XFT
        PuijAQ62VyNZDH5hQimp7xkEPFBS9EobXzOslAcYkaoXVrBcHudaMma8jxYA7b9vsJ5S9tK6tqwV8
        rj9RBR2g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nX8zN-00Eutj-SC; Wed, 23 Mar 2022 21:57:57 +0000
Date:   Wed, 23 Mar 2022 14:57:57 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Muchun Song <songmuchun@bytedance.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        keescook@chromium.org, yzaikin@google.com, osalvador@suse.de,
        david@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v5 0/4] add hugetlb_free_vmemmap sysctl
Message-ID: <YjuX5WCHNsjxgcCM@bombadil.infradead.org>
References: <20220323125523.79254-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323125523.79254-1-songmuchun@bytedance.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro,

can I trouble you to help review the first patch here? I thought
something like this might be possible, and Muchun has done some good
work to try it. If anyone can find hole on that kconfig hack it would
be you. I'll bounce you a copy of the patches.

  Luis

On Wed, Mar 23, 2022 at 08:55:19PM +0800, Muchun Song wrote:
> This series is based on next-20220310.
> 
> This series amis to add hugetlb_free_vmemmap sysctl to enable the feature
> of freeing vmemmap pages of HugeTLB pages.
> 
> v5:
>   - Fix not working properly if one is workig off of a very clean build
>     reported by Luis Chamberlain.
>   - Add Suggested-by for Luis Chamberlain.
> 
> Thanks.
> 
> v4:
>   - Introduce STRUCT_PAGE_SIZE_IS_POWER_OF_2 inspired by Luis.
> 
> v3:
>   - Add pr_warn_once() (Mike).
>   - Handle the transition from enabling to disabling (Luis)
> 
> v2:
>   - Fix compilation when !CONFIG_MHP_MEMMAP_ON_MEMORY reported by kernel
>     test robot <lkp@intel.com>.
>   - Move sysctl code from kernel/sysctl.c to mm/hugetlb_vmemmap.c.
> 
> Muchun Song (4):
>   mm: hugetlb_vmemmap: introduce STRUCT_PAGE_SIZE_IS_POWER_OF_2
>   mm: memory_hotplug: override memmap_on_memory when
>     hugetlb_free_vmemmap=on
>   sysctl: allow to set extra1 to SYSCTL_ONE
>   mm: hugetlb_vmemmap: add hugetlb_free_vmemmap sysctl
> 
>  Documentation/admin-guide/sysctl/vm.rst |  14 +++++
>  Kbuild                                  |  14 +++++
>  fs/Kconfig                              |   1 +
>  include/linux/memory_hotplug.h          |   9 +++
>  include/linux/mm_types.h                |   2 +
>  kernel/sysctl.c                         |   2 +-
>  mm/Kconfig                              |   3 +
>  mm/hugetlb_vmemmap.c                    | 107 ++++++++++++++++++++++++--------
>  mm/hugetlb_vmemmap.h                    |   4 +-
>  mm/memory_hotplug.c                     |  27 ++++++--
>  mm/struct_page_size.c                   |  19 ++++++
>  scripts/check_struct_page_po2.sh        |   9 +++
>  12 files changed, 177 insertions(+), 34 deletions(-)
>  create mode 100644 mm/struct_page_size.c
>  create mode 100755 scripts/check_struct_page_po2.sh
> 
> -- 
> 2.11.0
> 
