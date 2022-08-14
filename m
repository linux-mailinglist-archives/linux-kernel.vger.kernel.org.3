Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4D7591E88
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 07:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiHNFyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 01:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiHNFyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 01:54:07 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA08F52E76
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 22:54:06 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id f18so682108ilj.11
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 22:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=wrwi8GtN3fRrxIdUVrrGXPLLd97vwIWrzt605IFHiZ0=;
        b=CidX2evztA+2QPN7xMHAJkFi153/lxk5gnNOlt8Zx3pFVGgFCbg2WkETuP+L2cp7lj
         y22+Hxql5H09NY4BB7t5lEF2516X4DXVJNT3n1u6PJnzEhLJjkG4CBYAm3peTZZh7ONM
         I6LQBslmqqMPXXQQIXqQFD/JUrMSeh3DOJdG5WJ9ARTNL2NERVffdV+h4Q8GD8XfakbM
         3NIkCEP9dMtWllA+a7hYkMcawytEfrE2u8NDG8f6AW2Herm0QFWBL0tU9W4HNKt1CRnP
         e66BRuWpkaUm8kMnMEQQr5hfvIYovXVvfGwFdWETbUFfLioNCRgXaNW9jTml/iAB6vNf
         YQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=wrwi8GtN3fRrxIdUVrrGXPLLd97vwIWrzt605IFHiZ0=;
        b=Am2wcWKTrSSM1BdirLVV/odY0AtkhxOwq41WTGGf3L8sni4QchY0e2CF43q4YdVPAN
         541zasghTHuH7XhQMvjHqLrtMRS68+KbOR+Ad4B4mO2BMtFt03oJZgJ3og87B0EvjbJg
         eCaTqEQo2KAJjJq034GbTZyyP5opPEHLLhlslEYDvSQEDPUM6kw+6Vzy1Rduf+0bjbPX
         WG1ny5C2ByImJXoO0o3gaybc+KtUpvNhnj1Pi129f5kq2z6V9iNUnp6zhfC/4NI15mEZ
         LafYG97sV7I+ZV7DWLS63c700klavDr515c2VQhiNl21Or1jAU12qpkyaIPBV3ZtQbzi
         iInQ==
X-Gm-Message-State: ACgBeo1xPYIsHtwAyf8GUJzdXkuZQ76x604BnT5OR88N+ok9ECrlZyrc
        SY9exigRRUit2Uktk93Z2Lk=
X-Google-Smtp-Source: AA6agR4BPV1jtYapGpFrcvgoh8EnpXG1nJmPptQtTObKU/KoXaQEHVkuXzC8fMkCSkHZUq/TcNfDOQ==
X-Received: by 2002:a05:6e02:1b0e:b0:2df:67ee:beaf with SMTP id i14-20020a056e021b0e00b002df67eebeafmr4793237ilv.239.1660456446135;
        Sat, 13 Aug 2022 22:54:06 -0700 (PDT)
Received: from sophie (static-198-54-128-70.cust.tzulo.com. [198.54.128.70])
        by smtp.gmail.com with ESMTPSA id n44-20020a02716c000000b0034358669334sm1780815jaf.87.2022.08.13.22.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 22:54:05 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 0/8] memblock tests: update and extend memblock simulator
Date:   Sun, 14 Aug 2022 00:53:52 -0500
Message-Id: <cover.1660454730.git.remckee0@gmail.com>
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

These patches update existing tests in memblock simulator, add
additional tests for memblock functions that are already being tested,
and add test coverage for additional memblock functions.

Updated tests for:
- memblock_alloc()
- memblock_alloc_try_nid()
- memblock_alloc_from()

The updates to memblock_alloc() tests include the addition of an assert
that checks whether the entire chunk of allocated memory is cleared. For
memblock_alloc_try_nid() and memblock_alloc_from(), the assert that checks
whether the allocated memory is cleared now checks the entire chunk of
allocated memory instead of just the first byte. To make this more robust,
setup_memblock() and dummy_physical_memory_init() fill the entire MEM_SIZE
simulated physical memory with nonzero values by calling fill_memblock().
setup_memblock() is called at the beginning of most tests. Tests that
don't call setup_memblock() call fill_memblock() directly.

Additional tests for:
- memblock_add()
- memblock_reserve()
- memblock_remove()
- memblock_free()
- memblock_alloc()

Introducing test coverage for:
- memblock_alloc_raw()
- memblock_alloc_try_nid_raw()
- memblock_set_bottom_up()
- memblock_bottom_up()
- memblock_trim_memory()

The tests for the memblock_alloc_*raw() functions test both top-down and
bottom-up allocation directions. To add coverage for memblock_alloc_raw(),
the alloc_api was updated so that it runs through all the existing tests
twice: once for memblock_alloc() and once for memblock_alloc_raw(). When
the tests run memblock_alloc_raw(), they test that the entire memory
region is nonzero instead of testing that it is zero.

Similarly, the alloc_nid_api was updated to run through its tests twice,
once for memblock_alloc_try_nid() and once for
memblock_alloc_try_nid_raw(). When the tests run
memblock_alloc_try_nid_raw(), they test that the entire memory region is
nonzero instead of testing that it is zero.

The patchset also adds labels to verbose output for generic
memblock_alloc*() tests that indicate which allocation direction is set.
The function names of those tests do not include this information.

Rebecca Mckeever (8):
  memblock tests: update tests to check if memblock_alloc zeroed memory
  memblock tests: update zeroed memory check for memblock_alloc_* tests
  memblock tests: add labels to verbose output for generic alloc tests
  memblock tests: add additional tests for basic api and memblock_alloc
  memblock tests: update alloc_api to test memblock_alloc_raw
  memblock tests: update alloc_nid_api to test
    memblock_alloc_try_nid_raw
  memblock tests: add tests for memblock_*bottom_up functions
  memblock tests: add tests for memblock_trim_memory

 tools/testing/memblock/tests/alloc_api.c      | 184 ++++-
 .../memblock/tests/alloc_helpers_api.c        |  20 +-
 tools/testing/memblock/tests/alloc_nid_api.c  | 268 +++---
 tools/testing/memblock/tests/basic_api.c      | 773 +++++++++++++++++-
 tools/testing/memblock/tests/common.c         |   7 +
 tools/testing/memblock/tests/common.h         |  46 ++
 6 files changed, 1108 insertions(+), 190 deletions(-)

-- 
2.25.1

