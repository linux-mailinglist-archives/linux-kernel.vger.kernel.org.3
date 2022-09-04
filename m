Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC435AC250
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 06:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbiIDEVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 00:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiIDEV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 00:21:27 -0400
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com [IPv6:2001:4860:4864:20::41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9347B4D4EA
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 21:21:25 -0700 (PDT)
Received: by mail-oa1-x41.google.com with SMTP id 586e51a60fabf-11e7e0a63e2so14590388fac.4
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 21:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=oKN0F2PyDgbdZaFzj41LoA7okbsSnk9gGkmccD+LQ/0=;
        b=cCXpX5fp3tpUw+L3qqOgXlPPeNrEh3FWRwQiGh1Dg65httdY9RBLvhGnzgnEYW0PPG
         gBvZ3vYT+wOsL1j4SsYfe35OcMvBhyI5UdqAwiTJsSy8M80ullkjy+a/V5Yf7By4Fu0d
         PubkFnLxhSg+0Rtm9WF3AJgjkGZgd8di03IHyUetaEU+J6LUhNXjVDGUrK1rgLT8zREL
         wwY4TGP0fbovJXpVsm13y9o90YcmIpG8ehCyHI+Q2MIsfuREh6XGJbqFsH5Mn5giNH7O
         gUBVg+5pjjs3hqoZHM8/J3hLtneMFXOgMFndpqwxAlpdHQM8pxoTmVcOrSEkzccACG16
         cxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=oKN0F2PyDgbdZaFzj41LoA7okbsSnk9gGkmccD+LQ/0=;
        b=m64/oeW5W/i4D3AxjJVKrfGnsxIr3f515VCIhtr25kavyPrAXwifkzZetpCmPbb7hy
         n3TMesgei4IVg/G4md/AssHjNqVIRRpdD0RBPZF8YzZBEuz84t+KUWbvbBYdYTctbLmC
         nlvJOufD2vmiwxvrs3yrQFLJv2VKsz+DMDdfoqYR9y4mw2DKDBviSYFDGJCjhyAYYyMB
         jpSbzsiA/13iECcx1y6B+2IEhYZDktjnsapaMQ9Q3x8baCskgnW+2i2ze81nFZGOiIRT
         EkiNM5e1OqmS/CGHwPO005zC6X37d1jsCLT5RejdNnNR0NtxjhlFn9ftxcVTNXaf1X6Y
         GFHQ==
X-Gm-Message-State: ACgBeo064woSCo29DL6mF7kQquZa6hJZAhZjiHEIJkh7YbesFExNEAsI
        IdvoEUM89rpfGXvhb99UV0Y=
X-Google-Smtp-Source: AA6agR7x4Sw1UPMP3L6uAgwOWz2fX1nFh9r2LZoAxSDsfEBzhX91E3ZBSixPlCJwGVob2QioO3ZkSg==
X-Received: by 2002:aca:b05:0:b0:343:53bf:3221 with SMTP id 5-20020aca0b05000000b0034353bf3221mr5002679oil.75.1662265284891;
        Sat, 03 Sep 2022 21:21:24 -0700 (PDT)
Received: from sophie (static-198-54-128-109.cust.tzulo.com. [198.54.128.109])
        by smtp.gmail.com with ESMTPSA id a7-20020a9d5c87000000b0063736db0ae9sm3086645oti.15.2022.09.03.21.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 21:21:24 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v4 0/4] memblock tests: add NUMA tests for memblock_alloc_try_nid*
Date:   Sat,  3 Sep 2022 23:21:04 -0500
Message-Id: <cover.1662264560.git.remckee0@gmail.com>
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
        * Change nodes[] parameter to an array containing the denominators
          of the fractions of MEM_SIZE contained in each node
          e.g., if nodes[0] = SZ_8, node 0 will contain 1/8th of MEM_SIZE
PATCH 2:
- tests/alloc_nid_api.c:
    + Add node_fractions[] array:
        * Based on values from node_sizes[] array previously in PATCH 1
        * Update to fit the new nodes[] parameter of setup_numa_memblock()

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
 tools/testing/memblock/tests/alloc_nid_api.c  | 1459 ++++++++++++++++-
 tools/testing/memblock/tests/alloc_nid_api.h  |   16 +
 tools/testing/memblock/tests/common.c         |   29 +
 tools/testing/memblock/tests/common.h         |   22 +-
 5 files changed, 1515 insertions(+), 13 deletions(-)

-- 
2.25.1

