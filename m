Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786BE554881
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354687AbiFVJL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357460AbiFVJLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:11:30 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0F5101F1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:09:54 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id k24so20377774oij.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nUi2WkXJg/BgzH6VJEvkfC77TODZO9BVOsfbGgXl5KM=;
        b=TaT2XrfrfkbOzaZu/XydxdbzpUsf0f5Kk4Sr8fXKt3NQm2K4V16kRafsg66CGV0VnK
         bD8+2Beo/6H7r76j1NsB2UR4T2Ooi17iZZXocSS4rKXAXY++eXwGB7WLWfSikvYdPkCc
         6EwVwFTQ6Eb73eNCN+InqvR187JopCEAzfjSfaTKtpIRs7LjNZt6mjS+68HYEFUmBU1L
         4AQjQMz+r9tjdabZL+aym7u1fs8JNHSeyE2cO53Ss26Bk+VUrUDHfnB5Fh/+4F9voNfb
         M4va+klhJzA5C79b71tJ1AO0Z+iIOiAwTXPLkBzkRnuOXqwHM5JJji4YhQVoawe/H7RU
         DDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nUi2WkXJg/BgzH6VJEvkfC77TODZO9BVOsfbGgXl5KM=;
        b=TU9wkKSbGHX7PrMK3MMGI+G/LwO+COqF44Mft7+5FYbcxtHOaXZCxd3SuybFZRdhiF
         QbTcenDI9WVrFupTgsqIe6l6L5jli/hVilZWvkTLsQy9GrEkLPZm+IvottLUlH+wtn4T
         NDaEYLI3ugrqr+aQNoiHUe3h/rINhZ4Qs9zK+pWdwwPFPv1Xj4Gu6CPP5sdlFbJAVs84
         IafaQQ0U+xCHgScFjMp78nS0g74uvsjHc8yTu/PlZR93sRLDTxbmc/3aDHO/5ro8zsQ9
         +s+ep62CXPJa62C/zSQb7HVcAbPb1hY6Ve3I8UT5SiJcQhhKYyXdaa6zI4v+L0RJsA06
         IiFA==
X-Gm-Message-State: AJIora/yItvNAjGLpJFOqUdVmTGqZMurXrUZVqMkjhMLldfUuqtK2FbI
        VR+DqVtoASOpzh8N1vo3/No2d9Arl6o=
X-Google-Smtp-Source: AGRyM1smYypKAf9N9iSdiM8vzr0dJP+CsGveYdPmbr2p6UW+F7I79+FUy4/9oupujvjLVl+PEqBbDA==
X-Received: by 2002:a05:6808:130d:b0:32f:4d01:c4c9 with SMTP id y13-20020a056808130d00b0032f4d01c4c9mr1304891oiv.52.1655888994268;
        Wed, 22 Jun 2022 02:09:54 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id y7-20020a056870e3c700b000f342d078fasm10310216oad.52.2022.06.22.02.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 02:09:54 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v2 0/4] memblock tests: add VERBOSE and MEMBLOCK_DEBUG Makefile options
Date:   Wed, 22 Jun 2022 04:09:42 -0500
Message-Id: <cover.1655887571.git.remckee0@gmail.com>
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
---

-- 
2.34.1

