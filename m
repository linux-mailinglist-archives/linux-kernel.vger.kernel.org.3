Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D9C55C705
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242688AbiF0WfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 18:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242675AbiF0WfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 18:35:12 -0400
Received: from mail-oa1-x43.google.com (mail-oa1-x43.google.com [IPv6:2001:4860:4864:20::43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6991CFC1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 15:35:12 -0700 (PDT)
Received: by mail-oa1-x43.google.com with SMTP id 586e51a60fabf-101ec2d6087so14798854fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 15:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4rTe9Lp6uNO/11riV57zI1Iev/mCoij/+CofdNi1ykc=;
        b=muu8c+uUErYAR/stI1SOwr1j/KbCbcO5d5P3LGAPp5X/4eErLkz8nQynNO4PoGZxdM
         JpuSun50kim+AtH5RqLcQBKRSYdlYEcm7idd23H59oUJmxd816R/d/7V/9b2iz8b+fZg
         iGuS4EToo6dVLZKJv1bJKyDkU5O7GolIyfe3ytrGC3+R8POQqU+Zmn1eiEgB6YSm5mvv
         lJxTxuGrKVANWXkZ9aew4KY0YNi8ipgq8PQ2HTq/zvRUabEQNFvK6ZXcJupXh8i5j0Yz
         o0MRa6fIa6UMTZJxQ9GdG7636+4KA2eiwgwkO0lFzW7beRHAgoLPtipWTZJbbCk/FIvc
         OyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4rTe9Lp6uNO/11riV57zI1Iev/mCoij/+CofdNi1ykc=;
        b=tnxEKYMPr0e/1wDfZYBjNr1wWOmu84I/KFAaaKE47NiaQlrlMXUeCe7fcy8oMZe6L0
         csDBQbHq4CJdK6cZXoJDkJj0DlzUNYA3KQPmxhiiTQ0dWcSE5Xax3WwmbSwAPEyeMohU
         YJyHKUpo7nq9Ab2ZUi8GDJNb7ByllJSLiPGcpnuARb7a73u+V+3QobRhPK14AM3J6f2c
         sOg0tB6DjlnGcJYOHDtx77OaCgj7kMROs1wybOw5PU9S1/krPZCMejPBmGPeYAnJVaYw
         e52ia8khgvo5y8ayAntgVNKJH9IiyF1D31QKGJ2lU8AgqcwvrqX8kqED9QshG+MPbLwc
         Ry6Q==
X-Gm-Message-State: AJIora+5EG3cbGNixZFJ/K66DITkPPm2E1CFvnwbmmBI97fHCJz2ng1E
        p+bpZ2jzK3hJHONs+Hhg8y8=
X-Google-Smtp-Source: AGRyM1t7CQ5J4dec99S5QZJMxBl9D2w+61Il7aqYy0mmGQ/s4PqYH0KX39AcZYURLOWTfoUmGaky3A==
X-Received: by 2002:a05:6870:6c15:b0:106:919c:80df with SMTP id na21-20020a0568706c1500b00106919c80dfmr8710493oab.111.1656369310743;
        Mon, 27 Jun 2022 15:35:10 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id e3-20020a4ac3c3000000b0035eb4e5a6d6sm6579747ooq.44.2022.06.27.15.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 15:35:10 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v4 0/4] memblock tests: add VERBOSE and MEMBLOCK_DEBUG Makefile options
Date:   Mon, 27 Jun 2022 17:34:26 -0500
Message-Id: <cover.1656368930.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.34.1
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

These patches add options VERBOSE and MEMBLOCK_DEBUG to Memblock
simulator, which can be specified when running make. These patches also
implement the functionality for these options.

VERBOSE
Usage:

$ make VERBOSE=1

Passing VERBOSE=1 will enable verbose output from Memblock simulator. For
each test, the verbose output includes the name of the memblock function
being tested, the name of the test, and whether the test passed or failed.
Since all the tests in Memblock simulator run as one monolithic test, this
output is a quick way to get a summary of test results.

MEMBLOCK_DEBUG
Usage:

$ make MEMBLOCK_DEBUG=1

Passing MEMBLOCK_DEBUG=1 will enable memblock_dbg() messages. These
are debug messages built into several functions in memblock that include
information such as the name of the function and the size and start and
end addresses of the memblock region.

---
Changes

v3 -> v4
PATCH 1:
- Update subject line to specifically mention verbosity, which encompasses
  both Makefile arguments
PATCH 2:
- tests/common.h, tests/*_api.c:
    - Define and use macro PREFIX_PUSH(), which runs prefix_push(__func__)
    - Define and use function test_pass_pop(), which runs test_pass(),
      then prefix_pop()
- tests/alloc_*api.c:
    - Remove static on constant func_testing
- tests/basic_api.c:
    - Display "memblock_add" instead of "memblock_add_node" in verbose
      output for memblock_add_node_simple_check()
- tests/alloc_helpers_api.c:
    - Add missing prefix_pop() in memblock_alloc_helpers_checks()
- Commit message:
    - Format function/macro descriptions, reword prefix_push() description,
      and update as needed to reflect the above changes

v2 -> v3
PATCH 1:
- Add Reviewed-by tag

v1 -> v2
PATCH 2:
- tests/common.c:
    - Remove #ifdef VERBOSE around prefixes and related constants
    - Add __maybe_unused to prefixes
    - Move PREFIXES_LEN_MAX, DELIM, and DELIM_LEN so that they are
      immediately after the other constants
    - Add #ifdef VERBOSE around definitions for test_*() and prefix_*()
---

Rebecca Mckeever (4):
  memblock tests: Makefile: add arguments to control verbosity
  memblock tests: add verbose output to memblock tests
  memblock tests: set memblock_debug to enable memblock_dbg() messages
  memblock tests: remove completed TODO items

 tools/testing/memblock/Makefile               |   4 +
 tools/testing/memblock/README                 |  10 +-
 tools/testing/memblock/TODO                   |  14 +-
 tools/testing/memblock/internal.h             |   7 +
 .../testing/memblock/scripts/Makefile.include |  10 +
 tools/testing/memblock/tests/alloc_api.c      | 225 +++++++----
 .../memblock/tests/alloc_helpers_api.c        | 129 ++++---
 tools/testing/memblock/tests/alloc_nid_api.c  | 351 +++++++++++-------
 tools/testing/memblock/tests/basic_api.c      | 337 +++++++++++------
 tools/testing/memblock/tests/common.c         |  58 +++
 tools/testing/memblock/tests/common.h         |  62 ++++
 11 files changed, 851 insertions(+), 356 deletions(-)

-- 
2.34.1

