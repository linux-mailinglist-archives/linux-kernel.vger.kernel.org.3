Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF40D5A34E0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 07:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbiH0FnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 01:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH0FnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 01:43:03 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CC395680
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 22:43:02 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w2so3341585pld.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 22:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=jvlYrX7RvTaSTj5wiMKMG724q0jKjom+zE2VGXi0lHU=;
        b=phKR8S1tlN/c/3xJ4vKuNEh9xy2CQoUwlg0e8Rq4aVh1Bh0yhy/IzCf6IYMZy5j2WI
         C9GW5cfVHtmavrfzHnJ5wJXmqxM41nXGQHK4fZQ03hybIxXYwHSU3UP6A2VmrMN05KO3
         wQmcerpqJrNCC/mMD4rytFtvimom4k/ico3flCE79wkERUucOZT+pi3UJo+Nt4zVPAsS
         /Al0UolcpSDbxXfGJDKvPHhYMxb/jXo1KcLkQHu/u4kgc3N4T+VnbJ5e4IrA/QM6y3/C
         Xk2SQrzckMjgB0BSmk73ur/GqU/ZDbK0FKiTGPV7Ksx2ub4kRltZOHRMkpcem6Y1URFb
         mBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=jvlYrX7RvTaSTj5wiMKMG724q0jKjom+zE2VGXi0lHU=;
        b=upnAP25QkoKCqmdg/4Hx7IHqxezdXgaWucXbfOt1axy6szv1ThM8fKlDH7R7uTc29J
         SrKVo/FwDkQnSFwdIK+qrsyeg7NCac/imv4HcYSdBTgoZjllf+Vomka0gD8uWH5rp4uB
         VrfD6GsQ/5w2/yh+HpDj6oQDu8rsB5FQqJ3V5Dr5L2XzpgkNcmxFbEaHHygr+YdMRYAZ
         H5Us+CWwhlsTYtsI82Hl6q94ECjzA7U9nccJa5YDzXxs/clfsGrnaXMZOyhK0VzlrA/R
         RLUvuAFMX1b7ykVkuRzgD7y2SKJ+fkCbjGjje7z7qoY7pgGNluN/GATMrV2ajzKlVlop
         ePTQ==
X-Gm-Message-State: ACgBeo03RJOvJGkSJeUvqVqB/cpjWotqBPVfQFRbITA1fQWMOGbe4KDw
        chCIxtLrBMQAlUVaimjGc5Q=
X-Google-Smtp-Source: AA6agR4ggfgHAGvN5byy4j1oxerKJLG82E5qNkwns664N+/6NSL+Q3+FZR0pUJz6vA5FHmoOVu66Ew==
X-Received: by 2002:a17:90b:1c06:b0:1fb:36ee:1626 with SMTP id oc6-20020a17090b1c0600b001fb36ee1626mr8073176pjb.139.1661578981666;
        Fri, 26 Aug 2022 22:43:01 -0700 (PDT)
Received: from sophie ([89.46.114.37])
        by smtp.gmail.com with ESMTPSA id 78-20020a621651000000b0052e6d6f3cb7sm2760969pfw.189.2022.08.26.22.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 22:43:01 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v3 0/8] memblock tests: update and extend memblock simulator
Date:   Sat, 27 Aug 2022 00:42:42 -0500
Message-Id: <cover.1661578349.git.remckee0@gmail.com>
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
setup_memblock() is called at the beginning of most tests for
memblock_alloc() functions.

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

Similarly, the alloc_nid_api was updated to run through its tests twice:
once for memblock_alloc_try_nid() and once for
memblock_alloc_try_nid_raw(). When the tests run
memblock_alloc_try_nid_raw(), they test that the entire memory region is
nonzero instead of testing that it is zero.

The patch set also adds labels to verbose output for generic
memblock_alloc*() tests that indicate which allocation direction is set.
The function names of those tests do not include this information.

---
Changelog

v2 -> v3
Based on feedback from Mike Rapoport:
PATCH 1:
- tests/common.h:
    + Move (char *) cast inside ASSERT_MEM_EQ().
PATCH 5:
- tests/common.h:
    + Move (char *) cast inside ASSERT_MEM_NE().

Based on feedback from David Hildenbrand:
PATCH 5:
- tests/common.h:
    + Add comments in enum test_flags and rename its values.
    + Rename verify_mem_content() to assert_mem_content().
PATCH 5, PATCH 6:
- Update commit message to explain that the memory region is initialized
  to nonzero and should remain unchanged when running
  memblock_alloc_*raw().
- tests/alloc_api.c, tests/alloc_nid_api.c:
    + Remove func_testing array.
    + get_func_testing():
        * Rename to get_memblock_alloc_*name().
        * Remove else.
    + Remove else in run_memblock_alloc*().
PATCH 7:
- Commit message:
    + Change "region unalign" to "unaligned region".
    + Change "region unaligned" to "unaligned region that is unaligned"
- tests/basic_api.c:
    + Change phys_addr_t alignment to const phys_addr_t alignment.

Based on feedback from Shaoqin Huang:
PATCH 8:
- tests/basic_api.c:
    + Change "trimmed at the base" to "trimmed at the end" in
      memblock_trim_memory_unaligned_end_check().

v1 -> v2
Updates based on feedback from Shaoqin Huang:
PATCH 1:
- tests/alloc_api.c:
    + Remove fill_memblock() from alloc_no_memory_generic_check().
- tests/common.c, tests/common.h:
    + Change fill_memblock() to file static.
PATCH 3:
- Shaoqin Huang and I discussed using run_top_down() and run_bottom_up()
  even for functions with `top_down` and `bottom_up` in the name to
  maintain a consistent output style. However, this would make the output
  more redundant, so no changes were made.
PATCH 4:
- tests/basic_api.c:
    + Rename instances of r1_size and r2_size to
      new_r1_size and new_r2_size.
PATCH 5, PATCH 6:
- tests/alloc_api.c, tests/alloc_nid_api.c, tests/common.h:
    + Change verify_mem_content() to a common function defined in
      common.h.
PATCH 8:
- tests/basic_api.c:
    + Rename instances of r2_base and r2_size to
      new_r2_base and new_r2_size.
---

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

 tools/testing/memblock/tests/alloc_api.c      | 168 +++-
 .../memblock/tests/alloc_helpers_api.c        |  20 +-
 tools/testing/memblock/tests/alloc_nid_api.c  | 252 +++---
 tools/testing/memblock/tests/basic_api.c      | 767 ++++++++++++++++++
 tools/testing/memblock/tests/common.c         |   7 +
 tools/testing/memblock/tests/common.h         |  55 ++
 6 files changed, 1082 insertions(+), 187 deletions(-)

-- 
2.25.1

