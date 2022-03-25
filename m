Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7944E6EC5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 08:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245476AbiCYHYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 03:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiCYHYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 03:24:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13323D1CC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 00:22:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86D0961B05
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 07:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23114C340E9;
        Fri, 25 Mar 2022 07:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648192978;
        bh=DJZ2t19wW8de5Ocfp02fsTSAbaU1qHs5YDDxahprcIw=;
        h=Date:From:To:Cc:Subject:From;
        b=BXt65p45NNV9OEQPZaSSGXPM4XL8H8VIu0QskVOd5s/gaPaNnykhGWO2/8+eKZk+H
         zPk6N9FTfBzTuaxyroTCZSkUhd30WQdjhCYc4nGP1wrGf2J6JAFc2QjOtHHI3VuWiP
         sjZBYPkJp6QVJufJ3C+EXvNHgOvsebXIjCCXvau9a/d1q6Q5pznDQLu/OqVj9zI0Ez
         hJnLfbbJn1pNiA6Mi7SKL7CFsr8pj7Y83eEJLO2oGO11noK3ArlJV5ZzLCp1CbTfD3
         KGaa2efzeKkiG0QMQkE7xm/lBAEUemoWxRzd8AITZglkSV3YXQsr9gXCTrz+fqzRen
         Ufvli54jBSxFA==
Date:   Fri, 25 Mar 2022 10:22:50 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] memblock: test suite and a small cleanup
Message-ID: <Yj1tymvsh0tzkXUV@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 754e0b0e35608ed5206d6a67a791563c631cec07:

  Linux 5.17-rc4 (2022-02-13 12:13:30 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v5.18-rc1

for you to fetch changes up to 58ffc34896db2e5e49e6ae6bf8042f85504d84e8:

  memblock tests: Add TODO and README files (2022-03-10 12:19:44 +0200)

----------------------------------------------------------------
memblock: test suite and a small cleanup

* A small cleanup of unused variable in __next_mem_pfn_range_in_zone
* Initial test suite to simulate memblock behaviour in userspace

----------------------------------------------------------------
Karolina Drobnik (26):
      tools: Move gfp.h and slab.h from radix-tree to lib
      tools/include: Add phys_addr_t to types.h
      tools/include: Add _RET_IP_ and math definitions to kernel.h
      tools/include: Update atomic definitions
      tools/include: Add mm.h file
      tools/include: Add cache.h stub
      tools/include: Add io.h stub
      tools/include: Add pfn.h stub
      tools/include: Add debugfs.h stub
      memblock tests: Add skeleton of the memblock simulator
      memblock tests: Add memblock reset function
      memblock tests: Add memblock_add tests
      memblock tests: Add memblock_reserve tests
      memblock tests: Add memblock_remove tests
      memblock tests: Add memblock_add_node test
      memblock tests: Add memblock_free tests
      memblock tests: Fix testing with 32-bit physical addresses
      memblock tests: Split up reset_memblock function
      memblock tests: Add simulation of physical memory
      memblock tests: Add memblock_alloc tests for top down
      memblock tests: Add memblock_alloc tests for bottom up
      memblock tests: Add memblock_alloc_from tests for top down
      memblock tests: Add memblock_alloc_from tests for bottom up
      memblock tests: Add memblock_alloc_try_nid tests for top down
      memblock tests: Add memblock_alloc_try_nid tests for bottom up
      memblock tests: Add TODO and README files

Miaohe Lin (1):
      memblock: __next_mem_pfn_range_in_zone: remove unneeded local variable nid

 MAINTAINERS                                        |    1 +
 mm/memblock.c                                      |    5 +-
 tools/include/linux/atomic.h                       |    2 +
 tools/include/linux/cache.h                        |   10 +
 tools/include/linux/debugfs.h                      |    5 +
 tools/include/linux/gfp.h                          |   28 +
 tools/include/linux/io.h                           |    5 +
 tools/include/linux/kernel.h                       |    6 +
 tools/include/linux/mm.h                           |   42 +
 tools/include/linux/pfn.h                          |   10 +
 tools/{testing/radix-tree => include}/linux/slab.h |   25 +-
 tools/include/linux/types.h                        |   10 +
 tools/lib/slab.c                                   |   38 +
 tools/testing/memblock/.gitignore                  |    4 +
 tools/testing/memblock/Makefile                    |   55 +
 tools/testing/memblock/README                      |  107 ++
 tools/testing/memblock/TODO                        |   28 +
 tools/testing/memblock/asm/dma.h                   |    5 +
 tools/testing/memblock/internal.h                  |   12 +
 tools/testing/memblock/lib/slab.c                  |    9 +
 tools/testing/memblock/linux/init.h                |   34 +
 tools/testing/memblock/linux/kernel.h              |   12 +
 tools/testing/memblock/linux/kmemleak.h            |   18 +
 tools/testing/memblock/linux/memory_hotplug.h      |   19 +
 tools/testing/memblock/linux/mmzone.h              |   35 +
 tools/testing/memblock/linux/printk.h              |   25 +
 tools/testing/memblock/main.c                      |   15 +
 tools/testing/memblock/mmzone.c                    |   20 +
 tools/testing/memblock/scripts/Makefile.include    |   19 +
 tools/testing/memblock/tests/alloc_api.c           |  750 +++++++++++++
 tools/testing/memblock/tests/alloc_api.h           |    9 +
 tools/testing/memblock/tests/alloc_helpers_api.c   |  393 +++++++
 tools/testing/memblock/tests/alloc_helpers_api.h   |    9 +
 tools/testing/memblock/tests/alloc_nid_api.c       | 1174 ++++++++++++++++++++
 tools/testing/memblock/tests/alloc_nid_api.h       |    9 +
 tools/testing/memblock/tests/basic_api.c           |  903 +++++++++++++++
 tools/testing/memblock/tests/basic_api.h           |    9 +
 tools/testing/memblock/tests/common.c              |   48 +
 tools/testing/memblock/tests/common.h              |   34 +
 tools/testing/radix-tree/Makefile                  |    3 +-
 tools/testing/radix-tree/linux.c                   |   27 -
 tools/testing/radix-tree/linux/gfp.h               |   33 -
 42 files changed, 3934 insertions(+), 71 deletions(-)
 create mode 100644 tools/include/linux/cache.h
 create mode 100644 tools/include/linux/debugfs.h
 create mode 100644 tools/include/linux/io.h
 create mode 100644 tools/include/linux/mm.h
 create mode 100644 tools/include/linux/pfn.h
 rename tools/{testing/radix-tree => include}/linux/slab.h (61%)
 create mode 100644 tools/lib/slab.c
 create mode 100644 tools/testing/memblock/.gitignore
 create mode 100644 tools/testing/memblock/Makefile
 create mode 100644 tools/testing/memblock/README
 create mode 100644 tools/testing/memblock/TODO
 create mode 100644 tools/testing/memblock/asm/dma.h
 create mode 100644 tools/testing/memblock/internal.h
 create mode 100644 tools/testing/memblock/lib/slab.c
 create mode 100644 tools/testing/memblock/linux/init.h
 create mode 100644 tools/testing/memblock/linux/kernel.h
 create mode 100644 tools/testing/memblock/linux/kmemleak.h
 create mode 100644 tools/testing/memblock/linux/memory_hotplug.h
 create mode 100644 tools/testing/memblock/linux/mmzone.h
 create mode 100644 tools/testing/memblock/linux/printk.h
 create mode 100644 tools/testing/memblock/main.c
 create mode 100644 tools/testing/memblock/mmzone.c
 create mode 100644 tools/testing/memblock/scripts/Makefile.include
 create mode 100644 tools/testing/memblock/tests/alloc_api.c
 create mode 100644 tools/testing/memblock/tests/alloc_api.h
 create mode 100644 tools/testing/memblock/tests/alloc_helpers_api.c
 create mode 100644 tools/testing/memblock/tests/alloc_helpers_api.h
 create mode 100644 tools/testing/memblock/tests/alloc_nid_api.c
 create mode 100644 tools/testing/memblock/tests/alloc_nid_api.h
 create mode 100644 tools/testing/memblock/tests/basic_api.c
 create mode 100644 tools/testing/memblock/tests/basic_api.h
 create mode 100644 tools/testing/memblock/tests/common.c
 create mode 100644 tools/testing/memblock/tests/common.h
 delete mode 100644 tools/testing/radix-tree/linux/gfp.h
-- 
Sincerely yours,
Mike.
