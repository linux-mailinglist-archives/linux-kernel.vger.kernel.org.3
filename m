Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CB44A6F75
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343691AbiBBLDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiBBLDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:03:43 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16679C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 03:03:43 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id u14so39783983lfo.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 03:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TjQQYUmGTu4SlGN4+y5JRfYaBvOiJEsY4i+XfsMIVcw=;
        b=NR+JqdE/LPmTHRaCzKkLVskK7Mfn9RgvVUrEz4zh6NVL4UYMHlKwTSZFTc91ZBrzLg
         PY/rggu9k3F292VbNNpO7noqwcQQhUWIIajIDzDYPFsCt2jRpOAzT7gqEK4kte5QHAOi
         XoAziG7b19ZIq1BHo4llxncZzVGn0FITpnJVNLXUNtXf8uG9AHsca330DHLV8ktpIo3y
         dMIscTsQcsoPBYeZbEo6D0JRHnBJcmMoETVMh9/BGIYA6fNt2n3RuQGtzjjp9l20lHCi
         LlVc/zhQigswjhhMYrWLVyMSrrAuBEiYOiHwkxN+cIoJmYPSslpb1TSZfhWHCiVYJvEG
         Vqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TjQQYUmGTu4SlGN4+y5JRfYaBvOiJEsY4i+XfsMIVcw=;
        b=a2oVqzLi7mWL0vgvOD629NWEYtrWiuyKFiWO2tmEoIFuL0vulNwaLRGblRRDjpIF9d
         g/WGrdYx2NVFQ/rE6sKi/m5u2OeH0yNYu8xYN0uW1qCHfeg5LdrRR1OTPA7w17/YAo4B
         4bYcboQG8cXNk4D0u1fOeC0jPNooMWS3JaiTIwv9eV+3ILu8fHNktL/xVFlzWuPm/laX
         yXEFbPvJ0OVaxLqbqnU23kb0Rb3notWW9BXZM6kSUdAShB+I9sj+iKkJY1IrkHPXy3m/
         Ooqe2LsSp5yJbce6U+YMNoUztkVhNKghKaWSwl+jg2didWy1UyZ7QFzjOeucmFMvgMv/
         qiPg==
X-Gm-Message-State: AOAM530Iq7HOu8TcooIvByuoWoLMBcK0huTYRyRYqL+rIcVlY9V+ZKyK
        Hpu9bBjfnTzJQndA8y/rE1Y=
X-Google-Smtp-Source: ABdhPJws64T0gA1Iv85NqAl9vCv76PiWwqjP1/FuOAJIlvNPQj191l0flkU6e3cLAeeEfTNMb6Pu6w==
X-Received: by 2002:a05:6512:150d:: with SMTP id bq13mr74149lfb.611.1643799821253;
        Wed, 02 Feb 2022 03:03:41 -0800 (PST)
Received: from localhost.localdomain (staticline-31-183-164-222.toya.net.pl. [31.183.164.222])
        by smtp.gmail.com with ESMTPSA id r14sm4503937lfr.129.2022.02.02.03.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 03:03:40 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, rppt@kernel.org,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH v2 00/16] Introduce memblock simulator
Date:   Wed,  2 Feb 2022 12:02:59 +0100
Message-Id: <cover.1643796665.git.karolinadrobnik@gmail.com>
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

Changes in v2:
- Fixed definition ordering in tools/include/linux/gfp.h
- Defined atomic_long_t as a struct instead of a typedef
- Deleted BIT macro from L1_CACHE_BYTES definition
- Removed SPDX information from .gitignore file
- Updated Makefile comment on the simulator dependencies
- Updated __initconst definition to be an empty macro (full definition is
  not required)

Karolina Drobnik (16):
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

 MAINTAINERS                                   |   1 +
 tools/include/linux/atomic.h                  |   2 +
 tools/include/linux/cache.h                   |  10 +
 tools/include/linux/debugfs.h                 |   5 +
 tools/include/linux/gfp.h                     |  28 +
 tools/include/linux/io.h                      |   5 +
 tools/include/linux/kernel.h                  |   6 +
 tools/include/linux/mm.h                      |  42 +
 tools/include/linux/pfn.h                     |  10 +
 .../radix-tree => include}/linux/slab.h       |  25 +-
 tools/include/linux/types.h                   |  10 +
 tools/lib/slab.c                              |  38 +
 tools/testing/memblock/.gitignore             |   4 +
 tools/testing/memblock/Makefile               |  54 ++
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
 33 files changed, 1397 insertions(+), 68 deletions(-)
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

