Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A14487641
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 12:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347011AbiAGLIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 06:08:18 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:37116 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiAGLIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:08:17 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CC7EE2113B;
        Fri,  7 Jan 2022 11:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641553695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pcgOij+zx5nFnaRiqb8urjJJkXOiXD7b+GBxBwuYFwI=;
        b=rS769dMisf4vxaz5k9ZjWfDO0VFsumHv9tE/vbud+8wu6JUeaCxeHnHe8jNja+ZXkmj6nv
        Cb+NyUwUut6yV3jLO4hZw2vTb+sGkgdPEW6vtJpJNaYvbNb9B/ATN1wfwklBzHce6krhaF
        oUph6fwLlPOkXNVYnZUgAZamiLdmxrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641553695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pcgOij+zx5nFnaRiqb8urjJJkXOiXD7b+GBxBwuYFwI=;
        b=jih4ir8RwzvUGJ35SsTE2CF6NacPV2cNWRoYfluMrvE79NK9YwIzfQ8+BAkyaRX67jjTmY
        yRp6EsXuIuTpUdCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A071313CCC;
        Fri,  7 Jan 2022 11:08:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o5M3Jh8f2GFxGwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 07 Jan 2022 11:08:15 +0000
Message-ID: <fa6573eb-9d5c-ef49-06b1-157c16efb868@suse.cz>
Date:   Fri, 7 Jan 2022 12:08:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: [GIT PULL] slab for 5.17
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest slab changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-5.17

======================================

- Separate struct slab from struct page - an offshot of the page
  folio work. Struct page fields used by slab allocators are
  moved from struct page to a new struct slab, that uses the
  same physical storage. Similar to struct folio, it always is a
  head page. This brings better type safety, separation of large
  kmalloc allocations from true slabs, and cleanup of related
  objcg code.

- A SLAB_MERGE_DEFAULT config optimization.

======================================

The struct slab series was originally based on v5.16-rc3 and in linux-next
since beginning of December [1]. I decided to rebase to v5.16-rc6 after Stephen
reported a conflict with mm made it to mainline [2].

If possible I would also like to finish the removal of slab fields from struct
page within this merge window. It now depends on commits in the iommu tree that
remove iommu's usage of the 'freelist' field. I currently have a branch
for-5.17/struct-slab-part2 [3] that merges the iommu 'core' branch after the
main struct slab series and adds a commit on top. I wonder if it's ok to send a
pull request with that structure later (assuming after both this pull request
and iommu tree are merged) or should it rather be rebased on your tree's commit
that does the later merge of those two?

Thanks,
Vlastimil

[1] https://lore.kernel.org/all/20211203073949.3d081406@canb.auug.org.au/
[2] https://lore.kernel.org/all/3ec33e65-1080-96be-f8bb-0012e3b87387@suse.cz/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=for-5.17/struct-slab-part2

----------------------------------------------------------------
Hyeonggon Yoo (2):
      mm: Make SLAB_MERGE_DEFAULT depend on SL[AU]B
      mm/slob: Remove unnecessary page_mapcount_reset() function call

Matthew Wilcox (Oracle) (14):
      mm: Split slab into its own type
      mm: Convert [un]account_slab_page() to struct slab
      mm: Convert virt_to_cache() to use struct slab
      mm: Convert __ksize() to struct slab
      mm: Use struct slab in kmem_obj_info()
      mm: Convert check_heap_object() to use struct slab
      mm/slub: Convert detached_freelist to use a struct slab
      mm/slub: Convert kfree() to use a struct slab
      mm/slub: Convert print_page_info() to print_slab_info()
      mm/slub: Convert pfmemalloc_match() to take a struct slab
      mm/slob: Convert SLOB to use struct slab and struct folio
      mm/kasan: Convert to struct folio and struct slab
      zsmalloc: Stop using slab fields in struct page
      bootmem: Use page->index instead of page->freelist

Vlastimil Babka (18):
      mm: add virt_to_folio() and folio_address()
      mm/slab: Dissolve slab_map_pages() in its caller
      mm/slub: Make object_err() static
      mm/slub: Convert __slab_lock() and __slab_unlock() to struct slab
      mm/slub: Convert alloc_slab_page() to return a struct slab
      mm/slub: Convert __free_slab() to use struct slab
      mm/slub: Convert most struct page to struct slab by spatch
      mm/slub: Finish struct page to struct slab conversion
      mm/slab: Convert kmem_getpages() and kmem_freepages() to struct slab
      mm/slab: Convert most struct page to struct slab by spatch
      mm/slab: Finish struct page to struct slab conversion
      mm: Convert struct page to struct slab in functions used by other subsystems
      mm/memcg: Convert slab objcgs from struct page to struct slab
      mm/kfence: Convert kfence_guarded_alloc() to struct slab
      mm/sl*b: Differentiate struct slab fields by sl*b implementations
      mm/slub: Simplify struct slab slabs field definition
      mm/slub: Define struct slab fields for CONFIG_SLUB_CPU_PARTIAL only when enabled
      Merge branch 'for-5.17/struct-slab' into for-linus

 arch/x86/mm/init_64.c        |    2 +-
 include/linux/bootmem_info.h |    2 +-
 include/linux/kasan.h        |    9 +-
 include/linux/memcontrol.h   |   48 --
 include/linux/mm.h           |   12 +
 include/linux/mm_types.h     |   10 +-
 include/linux/slab.h         |    8 -
 include/linux/slab_def.h     |   16 +-
 include/linux/slub_def.h     |   29 +-
 init/Kconfig                 |    1 +
 mm/bootmem_info.c            |    7 +-
 mm/kasan/common.c            |   27 +-
 mm/kasan/generic.c           |    8 +-
 mm/kasan/kasan.h             |    1 +
 mm/kasan/quarantine.c        |    2 +-
 mm/kasan/report.c            |   13 +-
 mm/kasan/report_tags.c       |   10 +-
 mm/kfence/core.c             |   17 +-
 mm/kfence/kfence_test.c      |    6 +-
 mm/memcontrol.c              |   55 +-
 mm/slab.c                    |  456 ++++++++--------
 mm/slab.h                    |  302 +++++++++--
 mm/slab_common.c             |   14 +-
 mm/slob.c                    |   62 +--
 mm/slub.c                    | 1177 +++++++++++++++++++++---------------------
 mm/sparse.c                  |    2 +-
 mm/usercopy.c                |   13 +-
 mm/zsmalloc.c                |   18 +-
 28 files changed, 1265 insertions(+), 1062 deletions(-)
