Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCB559979A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347358AbiHSIi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346949AbiHSIhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:37:41 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2033D586
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:37:23 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b2so2820534qkh.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=2ovy6cOrAq5hbHsy+zYmpR6YppyOweI7oSxHXbcd+Tw=;
        b=EX292WCZQn3k56I4UVurdpZlVXNrGus9pO/H54MgD4RjHhGgyDZCGDahZ8JyYgdknx
         /k0qBNK/1B8kbQsZZaHhgm/oEJ10NC+vsnwhj7sxrFKSMZie1BB9J1ngMqgizqdUKfV+
         VDrPkPK6rymo9iga7G22+WRekb/rdAINJYUHjhbe3SZe0PZiBfyg9NPEek1bQasyAxNt
         H+1TcaNPi8HfSgyGplEePLzjA1jKYdWJ+wn/cJykirJINBTltn6QQX7cibXK/9IPosC/
         tpyZ2MU3+iPIIsq2hHcdwTlSWdY1PFfjA4LLKrHCZ2Q49ilhtQbik46ltxrA0TVMKiIp
         mYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=2ovy6cOrAq5hbHsy+zYmpR6YppyOweI7oSxHXbcd+Tw=;
        b=kvgyidbwUTlFFX0knfqkcct86VA3zDTVkxFW0EvpGLHzF2toGfCDiia3xzwomqn0Ir
         05LnDR9uWoXAxM3i7BmwGECcA3cyUn69k6fZbbJybl0Nq5G6Fl+xyodec0wIFCm4nQuN
         xcVLPxb78EAFONunycrcuYz2Xt880WDp2eHB0chgKlGMAyuPOjil2Qfov5Z1IpJP3n2e
         7plIypNf8okjg/5v7+rbOcOeJVCcZiFdI5oQfNxd17vYaltrZePt3dR1HYDbMkg0TY5L
         7I7a421arbvedaJ36YbyW27r95gyqhYCSEidXztFHkN7hjb4WAEQzle1YtwCno6ocShY
         OIVQ==
X-Gm-Message-State: ACgBeo360JcEiME6P0Z5BIm0OjtQOQZEte6OtdzkHJ3TktKjDzyuFQgi
        PTAlwb1BaYcyH7VRQ2yvuzM=
X-Google-Smtp-Source: AA6agR4i2/flNAUUbOKuONjVpkKw1q/Sspz8B7ZUxzAEVVmgwbOWyHjEphvGVeqpOvrFYezqzZJl3Q==
X-Received: by 2002:a05:620a:269a:b0:6b5:b76c:11c9 with SMTP id c26-20020a05620a269a00b006b5b76c11c9mr4585731qkp.100.1660898242746;
        Fri, 19 Aug 2022 01:37:22 -0700 (PDT)
Received: from sophie ([89.46.62.64])
        by smtp.gmail.com with ESMTPSA id 66-20020a370945000000b006b8d1914504sm3078750qkj.22.2022.08.19.01.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:37:22 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v2 0/8] memblock tests: update and extend memblock simulator
Date:   Fri, 19 Aug 2022 01:34:48 -0700
Message-Id: <cover.1660897732.git.remckee0@gmail.com>
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

v1 -> v2
Updates based on feedback from Shaoqin Huang:
PATCH 1:
- tests/alloc_api.c:
    - Remove fill_memblock() from alloc_no_memory_generic_check().
- tests/common.c, tests/common.h:
    - Change fill_memblock() to file static.
PATCH 3:
- Shaoqin Huang and I discussed using run_top_down() and run_bottom_up()
  even for functions with `top_down` and `bottom_up` in the name to
  maintain a consistent output style. However, this would make the
  output more redundant, so no changes were made.
PATCH 4:
- tests/basic_api.c:
    - Rename instances of r1_size and r2_size to
      new_r1_size and new_r2_size.
PATCH 6:
- tests/alloc_api.c, tests/alloc_nid_api.c, tests/common.h:
    - Change verify_mem_content() to a common function defined in
      common.h.
PATCH 8:
- tests/basic_api.c:
    - Rename instances of r2_base and r2_size to
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

 tools/testing/memblock/tests/alloc_api.c      | 175 +++-
 .../memblock/tests/alloc_helpers_api.c        |  20 +-
 tools/testing/memblock/tests/alloc_nid_api.c  | 260 +++---
 tools/testing/memblock/tests/basic_api.c      | 767 ++++++++++++++++++
 tools/testing/memblock/tests/common.c         |   7 +
 tools/testing/memblock/tests/common.h         |  53 ++
 6 files changed, 1095 insertions(+), 187 deletions(-)

-- 
2.25.1

