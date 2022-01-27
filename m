Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBFC49E340
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241710AbiA0NWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiA0NWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:22:30 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECCFC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:22:30 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id c7so3762222ljr.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GReMFVgnTx8iRjrV9/gGBo2zT4o+kzJuy3aFtGpxQMQ=;
        b=ffu75mKPz+95TY3Nl2QFAc+F9g0eXOdgXaeluj2eQm8/ESpFrAw5FIajNuZb0Embz6
         DwrDVBZBdokEPL2hUWA0QGpAnX3pyTf9VUOePadXJzSGBfIBb2dgnCszEaHhyg9mhyrq
         YvdKdq6XQzX/2KYa79V6yw6bx6Ta5dFBJNwcOJS20QE60m07R5cFED/rEuxrNJgbYWDV
         yUTXztRtAUiVbN9M8lOZaKKp+we3Jy9ahN4Rkg+xxQBCeNERiWA2y8YVDM8wrCByZttY
         kTyh30Cf4/F8fG1g1LuGnlc4A2IP05Eu804qFTvMzCDYvgn8/mGDkpaO+vhlI/PkrsBR
         OBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GReMFVgnTx8iRjrV9/gGBo2zT4o+kzJuy3aFtGpxQMQ=;
        b=2xrpZE2rouHEvLQde8+6jE62Fj60hDsIXEK+p1dtcv7INqbkbK8pyzTYWGc7BywjMq
         WoB8yOMcZKK+jI8vKu2Dd2tvKrhrNhfR99WUy9McqsMFHr/nvDD1Q/Puf8S/DldYX+uq
         SWiiqu+zpsYkDSnhwwJbA+v4VKOMzHQ29hy7HGw5xCITMk927mELaEoin/NWBMpiCprh
         JP3vEXzS/FWQ9B+ZngNZiS2NSyQVBUM2ofXf8JU5D6FeNcijhxrSPsNXgOqtZX5tui6R
         LyESD+JxMk5aLopjoFY9hzNMYbcx18w0JpbN84A0iSwoMGfHmiZeAwycFR08v6a65MHH
         /N5w==
X-Gm-Message-State: AOAM531nIdqOYKoLGVeF5aKOKPDLdjZ60vpx2M01vFJXAiX7+NQarCP0
        fkB3YZGYBSCIjcthVOIlEJA=
X-Google-Smtp-Source: ABdhPJzspRNR1KLdZj5++iGJjDhM1p6wvzO4xt1NTGf0mEupXOpouqf7ZDfLCTtNecK/52XxpiCMlg==
X-Received: by 2002:a2e:9c8d:: with SMTP id x13mr2802767lji.282.1643289748504;
        Thu, 27 Jan 2022 05:22:28 -0800 (PST)
Received: from elysium.toya.net.pl (staticline-31-183-166-172.toya.net.pl. [31.183.166.172])
        by smtp.gmail.com with ESMTPSA id s16sm1306918lfp.197.2022.01.27.05.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 05:22:27 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, mike.rapoport@gmail.com,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 00/16] Introduce memblock simulator
Date:   Thu, 27 Jan 2022 14:21:18 +0100
Message-Id: <cover.1643206612.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memblock is a boot time memory allocator, which allows managing memory
regions before the actual memory management is initialized. Because it is
used so early during the booting process, testing and debugging it is
difficult. As memblock has few kernel dependencies, it is possible to
simulate its runtime behaviour in userspace after stubbing a couple of
structs and functions.

This series of patches adds an initial version of a test suite for
memblock, which is a part of tools/testing infrastructure. Checks included
here test the basic functionality of memblock, which is memory regions
management - adding/removing available regions, marking them as reserved
or freeing them.

To run the tests, build the main target and run it:

$ make; ./main

A successful run produces no output. Also, It is possible to override
different configuration parameters. For example, to simulate enabled NUMA,
use:

$ make NUMA=1

For the full list of options, see `make help`.

The future work will include tests for memory allocation done via
memblock_alloc_* and memblock_phys_alloc_* family of functions. It will
also focus on improving the test suite by adding dedicated test targets
for each group of API functions and verbose output.

For a refresher on memblock, see Boot time memory management
documentation page[1] and "Getting to know memblock"[2] blog post.

Patchset structure:

* Patch 1 extracts stub definitions of kmalloc/kfree from the radix-tree
  testing suite, so they can be used in other tests, including memblock
  simulator
* Patches 2-4 update tools headers to include missing definitions needed
  by memblock (e.g. phys_addr_t typedef)
* Patches 5-9 add new files to tools/include, some with dummy/downsized
  definitions
* Patch 10 adds the basic project with local stubs that are closely
  connected to memblock
* Patch 11 adds a reset function, which is used as a part of the test
  setup. This functionality is needed, as memblock is reused in each check
* Patches 12-16 add basic test cases for the core memblock functionalities

[1] - https://www.kernel.org/doc/html/latest/core-api/boot-time-mm.html
[2] - https://insecuremode.com/post/2021/12/14/getting-to-know-memblock.html

Karolina Drobnik (16):
  tools: Move gfp.h and slab.h from radix-tree to lib
  tools/include: Add phys_addr_t to types.h
  tools/include: Add _RET_IP_ and math definitions to kernel.h
  tools/include: Update atomic.h header
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

 MAINTAINERS                                   |   1 +
 tools/include/linux/atomic.h                  |   4 +
 tools/include/linux/cache.h                   |  10 +
 tools/include/linux/debugfs.h                 |   5 +
 tools/include/linux/gfp.h                     |  28 +
 tools/include/linux/io.h                      |   5 +
 tools/include/linux/kernel.h                  |   6 +
 tools/include/linux/mm.h                      |  42 +
 tools/include/linux/pfn.h                     |  10 +
 .../radix-tree => include}/linux/slab.h       |  25 +-
 tools/include/linux/types.h                   |   6 +
 tools/lib/slab.c                              |  38 +
 tools/testing/memblock/.gitignore             |   6 +
 tools/testing/memblock/Makefile               |  53 ++
 tools/testing/memblock/asm/dma.h              |   5 +
 tools/testing/memblock/internal.h             |  12 +
 tools/testing/memblock/lib/slab.c             |   9 +
 tools/testing/memblock/linux/init.h           |  34 +
 tools/testing/memblock/linux/kernel.h         |  12 +
 tools/testing/memblock/linux/kmemleak.h       |  18 +
 tools/testing/memblock/linux/memory_hotplug.h |  19 +
 tools/testing/memblock/linux/mmzone.h         |  35 +
 tools/testing/memblock/linux/printk.h         |  25 +
 tools/testing/memblock/main.c                 |   8 +
 tools/testing/memblock/mmzone.c               |  20 +
 .../testing/memblock/scripts/Makefile.include |  17 +
 tools/testing/memblock/tests/basic_api.c      | 896 ++++++++++++++++++
 tools/testing/memblock/tests/basic_api.h      |  10 +
 tools/testing/memblock/tests/common.c         |  27 +
 tools/testing/memblock/tests/common.h         |  15 +
 tools/testing/radix-tree/Makefile             |   3 +-
 tools/testing/radix-tree/linux.c              |  27 -
 tools/testing/radix-tree/linux/gfp.h          |  33 -
 33 files changed, 1396 insertions(+), 68 deletions(-)
 create mode 100644 tools/include/linux/cache.h
 create mode 100644 tools/include/linux/debugfs.h
 create mode 100644 tools/include/linux/io.h
 create mode 100644 tools/include/linux/mm.h
 create mode 100644 tools/include/linux/pfn.h
 rename tools/{testing/radix-tree => include}/linux/slab.h (61%)
 create mode 100644 tools/lib/slab.c
 create mode 100644 tools/testing/memblock/.gitignore
 create mode 100644 tools/testing/memblock/Makefile
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
 create mode 100644 tools/testing/memblock/tests/basic_api.c
 create mode 100644 tools/testing/memblock/tests/basic_api.h
 create mode 100644 tools/testing/memblock/tests/common.c
 create mode 100644 tools/testing/memblock/tests/common.h
 delete mode 100644 tools/testing/radix-tree/linux/gfp.h

--
2.30.2

