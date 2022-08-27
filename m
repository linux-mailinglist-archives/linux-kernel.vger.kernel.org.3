Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E205A34EB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 07:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiH0FxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 01:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH0FxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 01:53:12 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B94914D1E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 22:53:11 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 199so3398709pfz.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 22:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=8yEq01f3gUyEepLGkYa7iNuP0YWA1zOYm9eHEWsFinE=;
        b=amM5HdisUh6W2bWHocQlL4JnJRzWfk/XrorFokeP4DhOPeHefUOiXIrFn9szaseItl
         f5SZhOnx7Df59x2w9BL4YXsLCTLlI/D9xx13BTz98UNrbGPZMc89jX2RmPWltpH0RV14
         UinOZZB7BSw3YlO7EhDwAvyuvRjAb8J0Dr0hJez1nLbT328mdj6qebB5VJUbdHaEQD3V
         qKHHXQCl9+53hC9LR/Ec6WLlONvL8SDpJYnU0PHoxdxeiLDZiUC6qoNIUec8iTAyL/Sf
         odyE2GrbvW8lSICE8FXUZ0+SJU1zkND/P62V+qgHTnXyMagQqcBsjGDnesgjP/VrC23g
         xYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=8yEq01f3gUyEepLGkYa7iNuP0YWA1zOYm9eHEWsFinE=;
        b=FpUtoWpsKHgP+CCjrqcK64diAXT1hR7OfMbifg50adXH/M/MrG+uJcOvGbCBME0hNk
         uE+mRwEV+Wl9LakhIsbyh6jGK9uTSw6KMqLdedfYyL9rt/0BbALNG/wQ71QvosJ8mjSd
         Y5BKqCfNVH6jfmT7j6jsY9s6Otf9AEQ8wO4AEvbV5gSbh6Zv69TpBTOrRvGgmMxx2Uv+
         xFXA58qnwzXD2lbDgeADKAqMy+oReEUssrwSzv3N/6eiUIt9JAVvrOMudk4JuTXUnbdO
         ZNlTllI9Y5rQh7n2VwdP3+K24gl0HRyfIenIyWj684W6O+zwsLDaLnwoXVOT77eKarnt
         Q3Xw==
X-Gm-Message-State: ACgBeo0YTmM7EjC7Uf5yyeKvAzvBaJibKWcE5ecl9H9Wf3Tus9G2Bim3
        6o0wtD2lWkoahvxplGe9zVY=
X-Google-Smtp-Source: AA6agR5clTpXdzE5x1veFPrSOIFiKTTYHODLSAntOcicu6+vTnHw/QOM+mN2PKlFT3nPM2eN511cUQ==
X-Received: by 2002:a05:6a00:1312:b0:536:fefd:e64a with SMTP id j18-20020a056a00131200b00536fefde64amr6989791pfu.26.1661579590632;
        Fri, 26 Aug 2022 22:53:10 -0700 (PDT)
Received: from sophie ([89.46.114.37])
        by smtp.gmail.com with ESMTPSA id cp18-20020a170902e79200b001714c36a6d9sm2584385plb.229.2022.08.26.22.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 22:53:10 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v3 0/4] memblock tests: add NUMA tests for memblock_alloc_try_nid*
Date:   Sat, 27 Aug 2022 00:52:58 -0500
Message-Id: <cover.1661578435.git.remckee0@gmail.com>
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
introduces setup_numa_memblock_generic() and setup_numa_memblock().
These functions use a previously allocated dummy physical memory. They
can be used in place of setup_memblock() in tests that need to simulate
a NUMA system.

These tests are run twice, once for memblock_alloc_try_nid() and once
for memblock_alloc_try_nid_raw(), so that both functions are tested with
the same set of tests. When the tests run memblock_alloc_try_nid(), they
test that the entire memory region is zero. When the tests run
memblock_alloc_try_nid_raw(), they test that the entire memory region is
nonzero.

Note:
This patch set depends on the following patch set:
https://lore.kernel.org/all/cover.1661578349.git.remckee0@gmail.com/

---
Changelog

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
 tools/testing/memblock/tests/alloc_nid_api.c  | 1491 ++++++++++++++++-
 tools/testing/memblock/tests/alloc_nid_api.h  |   16 +
 tools/testing/memblock/tests/common.c         |   38 +
 tools/testing/memblock/tests/common.h         |   27 +-
 5 files changed, 1561 insertions(+), 13 deletions(-)

-- 
2.25.1

