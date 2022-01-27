Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CD849DD0B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 09:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238006AbiA0I4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 03:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbiA0I4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 03:56:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FACDC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 00:56:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39A66B820FC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 08:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61934C340E4;
        Thu, 27 Jan 2022 08:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643273777;
        bh=lgEwtkiOHIrlaoxJ4vuyQ5uNBEXEvwHxvM5x9OF14aE=;
        h=From:To:Cc:Subject:Date:From;
        b=rk3mC4vcGdgw2bL5mQ6Zu2tnkkDZC3dqalVGTHWPIVOVVtZ/L54I8n5niEerR5SLw
         wwBn0MkhjDwJO5qwqE5NKymV+JDukKYyVVSVpnlh1VI7bqghRo76lXGFbXP4lbRj55
         4QILpBnqT/Txd73Xy26a1QROkl03S9pCFM8bO04n/HgvC5Fe/yucjSAzGWnPkUCzyO
         NN/Cy+A37B0j4uOCCaRvJowQtf6YqreoKfxsc8f2Fyzbiqg0/R8u+QN5dJXLQSLx9a
         FuH2L0CXb07fjUlMqy6Ns1QTBke2SfjAcpDYdFwt1D3R0UGYy+4XMv7TLrL5rS40l5
         FbSHhCtELaZCw==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [RFC PATCH 0/3] Prototype for direct map awareness in page allocator
Date:   Thu, 27 Jan 2022 10:56:05 +0200
Message-Id: <20220127085608.306306-1-rppt@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

This is a second attempt to make page allocator aware of the direct map
layout and allow grouping of the pages that must be mapped at PTE level in
the direct map.

In a way this a v2 of "mm/page_alloc: cache pte-mapped allocations"
(https://lore.kernel.org/all/20210823132513.15836-1-rppt@kernel.org)

This time the grouping is implemented as a new migrate type -
MIGRATE_UNMAPPED, and a GFP flag - __GFP_UNMAPPED to request such pages
(more details are below).

I've abandoned the example use-case of page table protection because people
seemed to concentrate on it too much; instead, this set has two other
use-cases as the examples of how __GFP_UNMAPPED can be used.

First one is to switch secretmem to use the new mechanism, which is
straight forward optimization.

The second use-case is to enable __GFP_UNMAPPED in x86::module_alloc()
that is essentially used as a method to allocate code pages and thus
requires permission changes for basic pages in the direct map. This change
reduced the amount of large page splits in the direct map from several tens
to a single digit number for boot + several bpftrace runs.

This set is x86 specific at the moment because other architectures either
do not support set_memory APIs that split the direct^w linear map (e.g.
PowerPC) or only enable set_memory APIs when the linear map uses basic page
size (like arm64).

== Motivation ==

There are use-cases that need to remove pages from the direct map or at
least map them with 4K granularity. Whenever this is done e.g. with
set_memory/set_direct_map APIs, the PUD and PMD sized mappings in the
direct map are split into smaller pages.

To reduce the performance hit caused by the fragmentation of the direct map
it make sense to group and/or cache the 4K pages removed from the direct
map so that the split large pages won't be all over the place. 

There were RFCs for grouped page allocations for vmalloc permissions [1]
and for using PKS to protect page tables [2] as well as an attempt to use a
pool of large pages in secretmtm [3].

== Implementation overview ==

The pages that need to be removed from the direct map are grouped in the
free lists in a dedicated migrate type called MIGRATE_UNMAPPED.

When there a page allocation request with __GFP_UNMAPPED set and
MIGRATE_UNMAPPED list is empty, a page of the requested order is stolen
from another migrate type, just like it would happen for the existing
fallback processing. The difference is that the pageblock containing that
page is remapped with PTEs in the direct map, and all the free pages in
that pageblock are moved to MIGRATE_UNMAPPED unconditionally.

The pages are actually unmapped only in the end of post_alloc_hook() and
they are mapped back in free_pages_prepare() to keep the existing page
initialization, clearing and poisoning logic intact.

(this makes MIGRATE_UNMAPPED name imprecise, but I don't really like
MIGRATE_PTE_MAPPED and have no better ideas)

In this prototype __alloc_pages_bulk() does not deal with __GFP_UNMAPPED
and this flag cannot be used with SL*B allocators.

[1] https://lore.kernel.org/lkml/20210405203711.1095940-1-rick.p.edgecombe@intel.com
[2] https://lore.kernel.org/lkml/20210505003032.489164-1-rick.p.edgecombe@intel.com
[3] https://lore.kernel.org/lkml/20210121122723.3446-8-rppt@kernel.org

Mike Rapoport (3):
  mm/page_alloc: introduce __GFP_UNMAPPED and MIGRATE_UNMAPPED
  mm/secretmem: use __GFP_UNMAPPED to allocate pages
  EXPERIMENTAL: x86/module: use __GFP_UNMAPPED in module_alloc

 arch/Kconfig                   |   7 ++
 arch/x86/Kconfig               |   1 +
 arch/x86/kernel/module.c       |   2 +-
 include/linux/gfp.h            |  13 +++-
 include/linux/mmzone.h         |  11 +++
 include/trace/events/mmflags.h |   3 +-
 mm/internal.h                  |   2 +-
 mm/page_alloc.c                | 129 ++++++++++++++++++++++++++++++++-
 mm/secretmem.c                 |   8 +-
 9 files changed, 162 insertions(+), 14 deletions(-)


base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
-- 
2.34.1

