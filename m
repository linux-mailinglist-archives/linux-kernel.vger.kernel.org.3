Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8456D564C52
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 06:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiGDEHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 00:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiGDEHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 00:07:12 -0400
Received: from mail-oa1-x43.google.com (mail-oa1-x43.google.com [IPv6:2001:4860:4864:20::43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B2F2BDA
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 21:07:11 -0700 (PDT)
Received: by mail-oa1-x43.google.com with SMTP id 586e51a60fabf-10bec750eedso4015292fac.8
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 21:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ltf4SCepaFa9AUuFW56VsE3D7Xu/ZXpqCSR7pr3/1PI=;
        b=MumgKCEQoExd6G04S7owxnBYjxBxivvuCr1d60g65qBHGJcC+yFura5UJ/BwrCeJmY
         VIiz6JF9g2yoa3BVCqMP529sE3/jjmRmoXQ4wbg0JlqBnPCzLMY3AZl8geZ7LGZpvt/9
         +5kasINj1LalpMg7vPXLl0JYYqG88n282M4+PteAz6CjCkcy2ZXzHooIHK6Grj0zMnoI
         bU5KJ/JkI+2G8k0BLIMHmVugxLyLR+RI91pf3skUGH76rJFBjQg0pK/U5I5dL15Y4cO/
         y6+kXZmcAzvnLQYQ9Nw/s5urFpsTwA/NWuYZyhZqkgVu65bBB/z2iG4aLCFcHU8JNND/
         UhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ltf4SCepaFa9AUuFW56VsE3D7Xu/ZXpqCSR7pr3/1PI=;
        b=iQaqezIbxCEjSyP4TlvL5XUT3DiTe7+7LzhRXrg1QPo4BfdfcVlLZ6I8dUKvc/tJP2
         OuYlsopqt/SD+aqv81ss3V5tEwnaA2M90FEAAuKZY6fUO+wgtiVtllwIe0g9BbYaUyxw
         Jnz9xLy6XueVlXZsOIP2K/i2Q6aYBBoQ8IoKoVLoVpdYNgyYJ3yNdRRAp40s7cOZeMk/
         cTOxm06HBt/sstU8e4yo7zTJxxToWOFxZ67m+ys2gYv2pxKBw/mvBb5a1vn3uSgSpn8s
         062z5Ox59r3brnPfbqhFnhdRm913n//ZF2lIVzxbUctB13GV83Ue+1CFcSVt4hzu3bCP
         ouNg==
X-Gm-Message-State: AJIora/1xFzUrRZ6/Ia0owVdxpWV7jRBMsMGqiHJo8AVx8oxbDRAgLHG
        FtVg2POvicA8hn9472qBRnUFRBwPi8Y=
X-Google-Smtp-Source: AGRyM1sf7dR0xliRu7t2EgHzd4RUdS37g6E424Uu2FGIjud80vejXYbxspDGNJgr+/17MlEkKBTeoQ==
X-Received: by 2002:a05:6870:14c1:b0:e6:5ba1:6194 with SMTP id l1-20020a05687014c100b000e65ba16194mr16640696oab.242.1656907630710;
        Sun, 03 Jul 2022 21:07:10 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id bm17-20020a0568081a9100b00337b6301237sm1269124oib.56.2022.07.03.21.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 21:07:10 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v5 0/4] memblock tests: add VERBOSE and MEMBLOCK_DEBUG Makefile options
Date:   Sun,  3 Jul 2022 23:06:54 -0500
Message-Id: <cover.1656907314.git.remckee0@gmail.com>
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

v4 -> v5
PATCH 2:
- tests/common.c:
    - Change prefixes to a list of pointers to strings and add nr_prefixes
      to track the current number of prefixes so that string modifications
      are not needed. Update implementations for test_*() and prefix_*()
      functions accordingly.

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
 tools/testing/memblock/tests/common.c         |  57 +++
 tools/testing/memblock/tests/common.h         |  62 ++++
 11 files changed, 850 insertions(+), 356 deletions(-)

-- 
2.34.1

