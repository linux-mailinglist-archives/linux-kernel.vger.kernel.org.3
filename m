Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614455B2DB4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 06:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiIIErn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 00:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiIIErd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 00:47:33 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7207F11FC91
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 21:47:30 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id q63so497190pga.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 21:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ciC+wIwDdM9oS8e20tnRaGP6IsxJ84gMlhTWUGNswKY=;
        b=OoQJBT90WdCG7OmmpPDJ6UxaN0fN8lXrCJ2vlLI+XZqR6lpNol5Pwr0/86ZmyjW780
         MiDAXUAoxG/JVO9orNtB2me393jfDVJpqKoZyGunIyiUc2Ukc4/UnFTrfenPcWnNmLkS
         oppl1UOgPNsG4Rk82gOoZP8RNt7g7DtAlkcUG2B9HvzLPI53sec0QEnLSXQ1I1g9ddW6
         JIwUsmSBKIlgTgWTUhF1tSwX+YcWg/LPHejWyw+ymFxt+iHl4ODozddNMfS3jmS6CYMe
         ASWx/ZTZ936GB475sUfab5pJxc608M0i614M1XHH2Zvr39Y2+1T0t0PoeIev5zZbMXaT
         uu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ciC+wIwDdM9oS8e20tnRaGP6IsxJ84gMlhTWUGNswKY=;
        b=QE2eFoHyDSQPCSFSndqj24HeXPruE0RscoPKY6FfuFWAdx35+LIvuPpMzrdM16PCd6
         n+u6lAD47OiQUYI1ZSTbTzWoALkP/w5f34ZgVmBBPJxmE/kHNMz/ElHWy8RK5yhLLVe+
         WwQ/x2VR/HKel+Kuwwj/B+hAfAbKYod+fn7swMNZ79XgyR1Iotj5MdvNm0FfiW42t9JT
         NT1AQGIG+pyag8y3KWJIPsfr7EaZBH+mKiG0TqFniIslzuW5ANV4utq4q5XG49PoyNiU
         mf5uo0z6Wf0CDpc3SC3Cu/MbLWh+T7gSAFM6LSOv3ngqxBLOG9yzclwPFK0f58WLhTPN
         7Qyg==
X-Gm-Message-State: ACgBeo3hpMutbZm1bVFNXBBqO2aROPEjT8TZyTHEG8i6mXAE1SHkVueC
        BcWBVEhvz3/L0POca7aKZyA=
X-Google-Smtp-Source: AA6agR6yHbl41QGJF5diUhguZrXC6MBrHYZNKahEC5eUgo/uMs1kB8qURdnIKgcl0/77HMEor80EBw==
X-Received: by 2002:a05:6a00:2184:b0:53d:deac:cc16 with SMTP id h4-20020a056a00218400b0053ddeaccc16mr12304888pfi.10.1662698849340;
        Thu, 08 Sep 2022 21:47:29 -0700 (PDT)
Received: from sophie ([89.46.114.153])
        by smtp.gmail.com with ESMTPSA id rj14-20020a17090b3e8e00b001fdcb792181sm395541pjb.43.2022.09.08.21.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 21:47:29 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v5 0/4] memblock tests: add NUMA tests for memblock_alloc_try_nid*
Date:   Thu,  8 Sep 2022 23:46:41 -0500
Message-Id: <cover.1662698159.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add additional tests for memblock_alloc_try_nid() and
memblock_alloc_try_nid_raw() that use a simulated physical
memory that is set up with multiple NUMA nodes. Additionally, most of
these tests set nid != NUMA_NO_NODE.

To set up a simulated physical memory with multiple NUMA nodes, patch 1
introduces setup_numa_memblock(). This function uses a previously
allocated dummy physical memory. It can be used in place of
setup_memblock() in tests that need to simulate a NUMA system.

These tests are run twice, once for memblock_alloc_try_nid() and once
for memblock_alloc_try_nid_raw(), so that both functions are tested with
the same set of tests. When the tests run memblock_alloc_try_nid(), they
test that the entire memory region is zero. When the tests run
memblock_alloc_try_nid_raw(), they test that the entire memory region is
nonzero.

---
Changelog

v4 -> v5
Based on feedback from David Hildenbrand:
PATCH 1:
- tests/common.c:
    + setup_numa_memblock():
        * Change nodes[] to int basis points (one hundredth of 1% or
          1/10000) instead of phys_addr_t fraction denominators
        * Rename parameter nodes[] to node_fracs[]
PATCH 2:
- tests/alloc_nid_api.c:
    + Update node_fractions[] to reflect changes in PATCH 1

v3 -> v4
Based on feedback from David Hildenbrand:
PATCH 1:
- tests/common.h:
    + Remove #define MEM_FACTOR
PATCH 2:
- tests/alloc_nid_api.c:
    + Add missing blank line after alloc_nid_test_flags = flags;
PATCH 2, PATCH 3, PATCH 4:
- tests/alloc_nid_api.c:
    + Define variables in new tests in a single block
    + Change "cleared memory region" to "memory region" in comment blocks
      for new tests

Based on feedback from Mike Rapoport:
PATCH 1:
- tests/common.c:
    + Remove node_sizes[] array
- tests/common.c, tests/common.h:
    + Combine setup_numa_memblock_generic() and setup_numa_memblock():
        * Remove setup_numa_memblock(void)
        * Change setup_numa_memblock_generic() to setup_numa_memblock()
          and remove the factor and node_cnt parameters
        * Change nodes[] parameter to an array containing the
        * denominators
          of the fractions of MEM_SIZE contained in each node
          e.g., if nodes[0] = SZ_8, node 0 will contain 1/8th of
MEM_SIZE    
PATCH 2:
- tests/alloc_nid_api.c:
    + Add node_fractions[] array:
        * Based on values from node_sizes[] array previously in PATCH 1
        * Update to fit the new nodes[] parameter of
        * setup_numa_memblock()

v2 -> v3
PATCH 2, PATCH 3, PATCH 4:
- tests/alloc_nid_api.c:
    + Edits for consistency between tests and test naming styles:
        * Change "numa_top_down" to "top_down_numa"
        * Change "numa_bottom_up" to "bottom_up_numa"
        * Move "generic" to immediately before "check"
        * alloc_try_nid_bottom_up_numa_small_node_check() and
          alloc_try_nid_bottom_up_numa_node_reserved_check():
            - Separate size definition from its declaration

Updates based on changes to the dependent patch set noted above:
PATCH 2, PATCH 3, PATCH 4:
- tests/alloc_nid_api.c:
    + get_func_testing():
        * Rename to get_memblock_alloc_try_nid_name().
    + Update calls to verify_mem_content() to assert_mem_content().

v1 -> v2
Updates based on changes to the dependent patch set noted above:
PATCH 2, PATCH 3, PATCH 4:
- tests/alloc_nid_api.c:
    + Update calls to verify_mem_content() to include the flags parameter
      required by the new, common verify_mem_content() function.
---

Rebecca Mckeever (4):
  memblock tests: add simulation of physical memory with multiple NUMA
    nodes
  memblock tests: add top-down NUMA tests for memblock_alloc_try_nid*
  memblock tests: add bottom-up NUMA tests for memblock_alloc_try_nid*
  memblock tests: add generic NUMA tests for memblock_alloc_try_nid*

 .../testing/memblock/scripts/Makefile.include |    2 +-
 tools/testing/memblock/tests/alloc_nid_api.c  | 1466 ++++++++++++++++-
 tools/testing/memblock/tests/alloc_nid_api.h  |   16 +
 tools/testing/memblock/tests/common.c         |   31 +
 tools/testing/memblock/tests/common.h         |   22 +-
 5 files changed, 1524 insertions(+), 13 deletions(-)

-- 
2.25.1

