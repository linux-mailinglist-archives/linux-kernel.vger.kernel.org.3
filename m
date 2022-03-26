Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1218F4E7E50
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 02:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiCZBBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 21:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiCZBBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 21:01:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660B549907
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 18:00:16 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2e61c5a0eb7so72150777b3.22
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 18:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=W/ClygQLeJR/GjVzXq75kHiIvruhnm90EJigIUb5rZw=;
        b=qvXvN7ja3CcCfay9zb0Q2CDseDpfbRINVIQt1YTD06ESglVUby/9ezmskzn7/w1Koa
         un04IA9WyKGhKOEc48VCnthy3cleHZGP3rbESDpwCOCC8cMPwrC04Nwg4XT8NqqZ0EIW
         Z61UGzTYFCU6LrZ+Sqe6Mxyoq5iZhYg8G9xKg8X1GpqgKy73kbsuOoJsFiNHsISuc/1R
         l6JOVgQ4OfTV2WC2GMTRta4NclDnXa7DOGbcok6OLgUqeJ6+7N9ZncSFkivTW/gIf0k4
         HKF4UqSzmR88sKi0dZ9pasMRPcAEiNM4shQ9OE32PQcXH6tOS4P2bQoFVGjAf+7m8Eut
         TyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=W/ClygQLeJR/GjVzXq75kHiIvruhnm90EJigIUb5rZw=;
        b=4qkHh1QBa665RnJg+6pRfpA0d5eWb7gf3LRQp5kIaGsGVRhc87njU+1gJvYGZ0zvxW
         nuDfxjVozJGJ84KhZR9jKd+T76O8ajvIw2uW2MDkw1s4o/v9WRzr9sXaVt0T3/KB0i6x
         uCkmURPcbTJNaqKhDQ+ShGBXgKwuPZJHYVitJjrP0zyYYtYglcFgFrGWActwr1bs/SCC
         drGNk3/9ENTH9/LhmVE0Br1IIN/nnyTyqNOoCr5cOJNz/hPHj9MY/TXpks/TNcXakkTJ
         +OoqHglaf9pEp9Desy4zBb1IPVwul602sXrngGu29Wo4yc56iswKGxgUdcBt1BY0z13Y
         UwPg==
X-Gm-Message-State: AOAM530YTTzuJUxMuhIc7om1tNxU0MECLDiSF2Uy0vWTsfdJs5dGgYVT
        XkHTl/ttOwIbefPMmALgoZEO1Rw/1mU=
X-Google-Smtp-Source: ABdhPJy2mX78Uhkpp5sqymv1JurScdsIpF4FkonUhkkFsQjtO+6MfpQJTJvSqsJUsyMITIzOvH5PK27R4IE=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:cd78:b0cd:6717:696d])
 (user=yuzhao job=sendgmr) by 2002:a25:1f88:0:b0:633:6acc:ebff with SMTP id
 f130-20020a251f88000000b006336accebffmr14039337ybf.377.1648256415541; Fri, 25
 Mar 2022 18:00:15 -0700 (PDT)
Date:   Fri, 25 Mar 2022 19:00:03 -0600
Message-Id: <20220326010003.3155137-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [GIT PULL] Multi-gen LRU for 5.18-rc1
From:   Yu Zhao <yuzhao@google.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <baohua@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Donald Carr <d@chaos-reins.com>,
        Hillf Danton <hdanton@sina.com>,
        "=?UTF-8?q?Holger=20Hoffst=C3=A4tte?=" 
        <holger@applied-asynchrony.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Rik van Riel <riel@surriel.com>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is more of an option than a request for 5.18. I'm sending it to
you directly because, in my judgement, it's now as ready as it'll ever
be.

Thanks!

The following changes since commit 46f538bf2404ee9c32648deafb886f49144bfd5e:

  Merge tag 'backlight-next-5.18' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight (2022-03-25 14:01:23 -0700)

are available in the Git repository at:

  https://linux-mm.googlesource.com/mglru/ tags/mglru-for-5.18-rc1

for you to fetch changes up to bcf5f2a801b85f09ad691d07460fdf3fbef8404d:

  mm: multi-gen LRU: design doc (2022-03-25 15:30:50 -0600)

----------------------------------------------------------------
Multi-gen LRU for 5.18-rc1

This series was retested on top of 5.18-ed4643521e6a. All previous
comments have been addressed.

Changes since v8 [1]
  * Removed two user-hostile config options (suggested by Linus
    Torvalds).

Changes since v9 [2]
  * Resolved the conflicts with the latest folio changes.
  * Switched to spin_trylock() to move onto the next page table rather
    than spin on the current one when trying to clear the accessed
    bit on many page tables.
  * Added introductory paragraphs to the admin guide and the design
    doc (suggested by Mike Rapoport).
  * Expanded comments in get_nr_evictable() (suggested by Barry Song
    and Aneesh Kumar).
  * Expanded comments in inc_max_seq() (suggested by Barry Song).

[1] https://lkml.kernel.org/r/20220308234723.3834941-1-yuzhao@google.com
[2] https://lkml.kernel.org/r/20220309021230.721028-1-yuzhao@google.com

Signed-off-by: Yu Zhao <yuzhao@google.com>

----------------------------------------------------------------
Yu Zhao (14):
      mm: x86, arm64: add arch_has_hw_pte_young()
      mm: x86: add CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
      mm/vmscan.c: refactor shrink_node()
      Revert "include/linux/mm_inline.h: fold __update_lru_size() into its sole caller"
      mm: multi-gen LRU: groundwork
      mm: multi-gen LRU: minimal implementation
      mm: multi-gen LRU: exploit locality in rmap
      mm: multi-gen LRU: support page table walks
      mm: multi-gen LRU: optimize multiple memcgs
      mm: multi-gen LRU: kill switch
      mm: multi-gen LRU: thrashing prevention
      mm: multi-gen LRU: debugfs interface
      mm: multi-gen LRU: admin guide
      mm: multi-gen LRU: design doc

 Documentation/admin-guide/mm/index.rst        |    1 +
 Documentation/admin-guide/mm/multigen_lru.rst |  152 ++
 Documentation/vm/index.rst                    |    1 +
 Documentation/vm/multigen_lru.rst             |  160 ++
 arch/Kconfig                                  |    9 +
 arch/arm64/include/asm/pgtable.h              |   14 +-
 arch/x86/Kconfig                              |    1 +
 arch/x86/include/asm/pgtable.h                |    9 +-
 arch/x86/mm/pgtable.c                         |    5 +-
 fs/exec.c                                     |    2 +
 fs/fuse/dev.c                                 |    3 +-
 include/linux/cgroup.h                        |   15 +-
 include/linux/memcontrol.h                    |   36 +
 include/linux/mm.h                            |    7 +
 include/linux/mm_inline.h                     |  217 +-
 include/linux/mm_types.h                      |   78 +
 include/linux/mmzone.h                        |  211 ++
 include/linux/nodemask.h                      |    1 +
 include/linux/page-flags-layout.h             |   11 +-
 include/linux/page-flags.h                    |    4 +-
 include/linux/pgtable.h                       |   17 +-
 include/linux/sched.h                         |    4 +
 include/linux/swap.h                          |    4 +
 kernel/bounds.c                               |    7 +
 kernel/cgroup/cgroup-internal.h               |    1 -
 kernel/exit.c                                 |    1 +
 kernel/fork.c                                 |    9 +
 kernel/sched/core.c                           |    1 +
 mm/Kconfig                                    |   26 +
 mm/huge_memory.c                              |    3 +-
 mm/internal.h                                 |    1 +
 mm/memcontrol.c                               |   27 +
 mm/memory.c                                   |   39 +-
 mm/mm_init.c                                  |    6 +-
 mm/mmzone.c                                   |    2 +
 mm/rmap.c                                     |    7 +
 mm/swap.c                                     |   55 +-
 mm/vmscan.c                                   | 3102 +++++++++++++++++++++++--
 mm/workingset.c                               |  119 +-
 39 files changed, 4097 insertions(+), 271 deletions(-)
 create mode 100644 Documentation/admin-guide/mm/multigen_lru.rst
 create mode 100644 Documentation/vm/multigen_lru.rst
