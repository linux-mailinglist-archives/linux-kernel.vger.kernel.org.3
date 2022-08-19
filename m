Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6C259987D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347757AbiHSJHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347339AbiHSJHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:07:50 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34DBEF9C7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:07:49 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id w28so2891116qtc.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Eif8xbxaVAItU9xNSvN6xDxgWHEsI958p9Q+p98v2po=;
        b=NshPVdhqx+VphZ89OHtuprU+zQVB5kbt5aRSX159l3Bu0SG/Ka/ZQKsVocjPQPo7Q0
         yqi0cs+SUTbhZrbcBdRyceOS0nRUV0Rk9QCjWVmZ8oAPLeMth7S2oa/7yRmR2N4bv3a4
         HGQdv/IAA64rIm42h5m7Td5UZDJ39gPKa/kjaDljdAwPshboY5acdC4hS1b9Rk/CKsWb
         OqvKZqkX5tD0PEa5lwsSO6I5ZYD6DRXroZDgAEU8v3nd5CA9dF1XZdMQ4xHhxRk4hZlC
         YiHnokQgNAMXyqhJ8RIDIAZIO+5uDWmKCoZV7hxffAub1z2WqTNRSEED6wHJBRwtMKjR
         IYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Eif8xbxaVAItU9xNSvN6xDxgWHEsI958p9Q+p98v2po=;
        b=iOPTr9ZdsN7AH8rJ63lIMlEDLeiSbbM7dQyeWz6uyCItvMh94M9/2U1EK6QbLxRaHk
         MB1w1YzMG1Fp7W2OJ8eq40JYMD6hAhzYqR6UkOKoREu0kBv6z/z0oZ8H6eAPCVABKHby
         ITQcoJ7Rgu6btar1p9v9UHijzcEoGqbVtir0bqKETXjCP9wsF475pwi4l5boiteudAxN
         SiJb1gTncF9olcaNJN1/NvkbAigo54RBfwmmgJYzlT/hA53tm8LY1NpNxB7CfTpdOtbl
         v4lqgg8O5G2gFkgeCtggouhfW8ij8QhJmEzPlnia4FeQjILH7poxJKV5FQQrW/98PHu7
         C/QA==
X-Gm-Message-State: ACgBeo0YFOFJlZXWkL7FRh+zPp/ewaM5JbAo5iNLpIGMzz+6LwYDAoqo
        EZa8FQuKbPJn+Km4oK1BK0M=
X-Google-Smtp-Source: AA6agR7gscqExh9evWiRDSLoL6BomfIk6WxrNDf2Ei7gh+rA8fM51HHF40XDzodMsHJF+F1IsZSd+Q==
X-Received: by 2002:a05:622a:53:b0:344:6f46:9b16 with SMTP id y19-20020a05622a005300b003446f469b16mr5745086qtw.664.1660900069107;
        Fri, 19 Aug 2022 02:07:49 -0700 (PDT)
Received: from sophie ([89.46.62.64])
        by smtp.gmail.com with ESMTPSA id o10-20020ac87c4a000000b0034305a91aaesm2906677qtv.83.2022.08.19.02.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 02:07:48 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v2 0/4] memblock tests: add NUMA tests for memblock_alloc_try_nid*
Date:   Fri, 19 Aug 2022 02:05:30 -0700
Message-Id: <cover.1660897864.git.remckee0@gmail.com>
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
https://lore.kernel.org/all/cover.1660897732.git.remckee0@gmail.com

---
Changelog

v1 -> v2
Updates based on changes to the dependent patch set noted above:
PATCH 2, PATCH 3, PATCH 4:
- tests/alloc_nid_api.c:
    - Update calls to verify_mem_content() to include the flags parameter
      required by the new, common verify_mem_content() function.
---

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

