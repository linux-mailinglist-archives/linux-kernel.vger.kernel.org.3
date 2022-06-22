Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A726A554789
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbiFVJ3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235187AbiFVJ3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:29:16 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E2F37AB6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:29:15 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id l81so20406483oif.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S7YCwWO403eb6jSUcJPccCfByUA2xjtU4XxYzFljMus=;
        b=ZbLfSSub1wLryKQq8L9wO1wP9ihM6/OBMWklIOChF/T7wM9LmtVHiKQeSWA3jW4CSy
         6uF9/H2AR9d7fTS/UJ2ZtfQTd7ccBHHBigG0VW6UeEX4jkBq8TDgAOhLJ7nQ+DI3fGJO
         Kgw/4oLNVkcwBpPapON+EMY8TUYF8OJUBMvCGAgJoGLUlaBNSjdjPCqL5EqjzCOxUYNp
         cC5BQLzMtfn2/fS46cSoMblJhIe+UAa1eNMiPPRNixsPsRHL/cW6KQmbgGTcU/jiKKEX
         HNrzRlI2/612NSNSlvD2r2RRr8Dhit0MHOLer0bDX61Fglvb5hoEUioPeWCWzIa4YqhE
         JXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S7YCwWO403eb6jSUcJPccCfByUA2xjtU4XxYzFljMus=;
        b=w7eQPHvU4nKfZQ/Ev4Xi8NmuyRtdhaOA15rwKkAUk3ZvQYm7rinbnesxvsMs9MR0jY
         nKze4EenTRQVSHd0xBYcmCZYvaVCPstLw0OgVSp1PDDmFogcn3uUUfdG2YSEkFyTFpif
         0+1uVpEBlAjJnuPZ7duh10LlXqdZ75ad8xQ8o4C7kHx86InCJvjfdNLPpNZl8slW9TkM
         h6sDcvRT+caimu14hfnnsqmUGVhlx2K0Y1GsccNhPX4597tVNn4bH7QkYE+moeJ3khZ6
         26LerbDMReoYkG2fVZVmyzd/9zOHBD+bbCn3cbC+ye27IHWW9hlDKLJ57/ZLUg9YwTNQ
         FJZA==
X-Gm-Message-State: AJIora+mSuwPhZLDJKbtPbddQJyhksf9i6j3B+q3s6XcXbQzM1h2CyGS
        HqnowBNUUXNb47VdPq5XykI=
X-Google-Smtp-Source: AGRyM1sjhUfEL2Nks508r/8kuyXaGVGQqsgR96YUWnFRtcc/51XoLRZscG7sgTv65Di8sJIzhRRCLg==
X-Received: by 2002:aca:e045:0:b0:333:2014:9daa with SMTP id x66-20020acae045000000b0033320149daamr10730307oig.67.1655890154826;
        Wed, 22 Jun 2022 02:29:14 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id t21-20020a056808159500b003264a325ecdsm10552414oiw.5.2022.06.22.02.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 02:29:14 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v3 0/4] memblock tests: add VERBOSE and MEMBLOCK_DEBUG Makefile options
Date:   Wed, 22 Jun 2022 04:29:05 -0500
Message-Id: <cover.1655889641.git.remckee0@gmail.com>
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

Rebecca Mckeever (4):
  memblock tests: add user-provided arguments to Makefile
  memblock tests: add verbose output to memblock tests
  memblock tests: set memblock_debug to enable memblock_dbg() messages
  memblock tests: remove completed TODO items

 tools/testing/memblock/Makefile               |   4 +
 tools/testing/memblock/README                 |  10 +-
 tools/testing/memblock/TODO                   |  14 +-
 tools/testing/memblock/internal.h             |   7 +
 .../testing/memblock/scripts/Makefile.include |  10 +
 tools/testing/memblock/tests/alloc_api.c      | 241 ++++++++----
 .../memblock/tests/alloc_helpers_api.c        | 135 +++++--
 tools/testing/memblock/tests/alloc_nid_api.c  | 371 ++++++++++++------
 tools/testing/memblock/tests/basic_api.c      | 365 ++++++++++++-----
 tools/testing/memblock/tests/common.c         |  58 +++
 tools/testing/memblock/tests/common.h         |  54 +++
 11 files changed, 913 insertions(+), 356 deletions(-)

---
Changes

v1 -> v2
PATCH 2, in common.c:
  Remove #ifdef VERBOSE around prefixes and related constants
  Add __maybe_unused to prefixes
  Move PREFIXES_LEN_MAX, DELIM, and DELIM_LEN so that they are
    immediately after the other constants
  Add #ifdef VERBOSE around definitions for test_*() and prefix_*()

v2 -> v3
PATCH 1:
  Add Reviewed-by tag
---

-- 
2.34.1

