Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E05591E9F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 08:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbiHNGGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 02:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiHNGGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 02:06:48 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10A21A827
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 23:06:47 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id j20so2498778ila.6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 23:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=DYNwl4udibiQ4scEUfrfDwYaVQPNhZul+x9ctn+vu3k=;
        b=cWQ71h3X4g2c1ImhoG9YuCoUjZt3xqWDZE0cxwmaTg3uqFJ8jQOuDJiqktRfJY3RK9
         T1izg7m8Mto+86PmkMr7hNZ//KCxw0xlBQPzofUMeJjA3kU87ufL7rFZXn2STAGZSbKl
         sN/ocengRnC4kz3P1b4Z3hZDsf4cHjfUePCVOg6TIYmTr4pvb+b68+z/2/KDqSS3n+CO
         G+Lr09Z2auiPoL+vuovjoPxFd5fCTDQQAe3GeeRLe/JYi2se1B05vAU5/JF4Hx8kDBks
         bRvoyp6WvMsCzcbPROqnxvOHunnfxQNS54uAM7Nk5U9hYDDK8iG37Fxtfa6VPplRX+OQ
         o/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=DYNwl4udibiQ4scEUfrfDwYaVQPNhZul+x9ctn+vu3k=;
        b=Cyd+0EIKh/LCsvdxxhvtwEM1il9idtbsDvc5cqVgYLeJMv5tDDX8SBjr2IIcf2CONk
         07RTbonRZlr+zx0TAs+D6be/E1y6sHBO67TLt9NqjXReeIqtZvbBUbucm/Twu23T6bPK
         n/KzvGMaVLIxVEh4P5cEnMRiKQbNIbymPhybdTu2Nm2N5FxKtJVPZi+LAyRbwMnmQhQb
         r35u4wZN1H6FM33HVyIGysmEwF5V8+SKuWMHSP8N9nDTH5fZApltQQv8s81moAU+6cOT
         9b8FNgbNrYGZlJIq6Hg7KLIsrlInK0jej8Vlfyc70kQXEym4eYhVh5qofi1WjOvrQ/OP
         nCWg==
X-Gm-Message-State: ACgBeo1FsO6QG4aLdqtEWI5nnjRLXBjBF4EQYawXmlXQh5/yyr6Bh6Rd
        W1XIrOxG4vxbRMPKzGx+t8W8ZWkzlyM=
X-Google-Smtp-Source: AA6agR7oFp54gKI/61oHDTsQtWcouMaWgzZ6Z84Dmt9gUlTsWDcBM5G32m7jiibTNVmjNHcnetqvaw==
X-Received: by 2002:a05:6e02:971:b0:2de:9060:ef47 with SMTP id q17-20020a056e02097100b002de9060ef47mr4495084ilt.55.1660457207162;
        Sat, 13 Aug 2022 23:06:47 -0700 (PDT)
Received: from sophie ([68.235.43.126])
        by smtp.gmail.com with ESMTPSA id t62-20020a025441000000b0034300131555sm1750568jaa.95.2022.08.13.23.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 23:06:46 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 0/4] memblock tests: add NUMA tests for memblock_alloc_try_nid*
Date:   Sun, 14 Aug 2022 01:06:14 -0500
Message-Id: <cover.1660454970.git.remckee0@gmail.com>
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
This patchset depends on the following patch set:
https://lore.kernel.org/linux-mm/cover.1660454730.git.remckee0@gmail.com/T/#m3a63677ae915fb47aea3f82780b72b54c08f246d

Rebecca Mckeever (4):
  memblock tests: add simulation of physical memory with multiple NUMA
    nodes
  memblock tests: add top-down NUMA tests for memblock_alloc_try_nid*
  memblock tests: add bottom-up NUMA tests for memblock_alloc_try_nid*
  memblock tests: add generic NUMA tests for memblock_alloc_try_nid*

 .../testing/memblock/scripts/Makefile.include |    2 +-
 tools/testing/memblock/tests/alloc_nid_api.c  | 1489 ++++++++++++++++-
 tools/testing/memblock/tests/alloc_nid_api.h  |   16 +
 tools/testing/memblock/tests/common.c         |   38 +
 tools/testing/memblock/tests/common.h         |   27 +-
 5 files changed, 1559 insertions(+), 13 deletions(-)

-- 
2.25.1

