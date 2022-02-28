Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F347A4C6FE9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbiB1OsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237352AbiB1Orz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:47:55 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC037F6FF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:47:16 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id bn33so17739670ljb.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+T4HBXFbynYzp9NCIHMJxk+jY5JAUB+Pkhx9FGv2/08=;
        b=lZjS13JhrhbO4VVZDtKqTtLaPCWbfw7wRO/xBPdNDF85YyQ4JA/3Z8MeM1lFDhb/E6
         GtfYHsiScz+AzwtC57GP090qGWvSnxiVQ77bZzMOqeXpwAS6SHMvfBJqhe7dPtJD0oXJ
         fupofbK/ftYf4OcK3RRcO+pTxKSOXVx74pqVKLQA09+0m1SXKcGYW75rtwekLtaGfHeT
         zSIjuXnWlqsNlZsVTBR0AEuXFUbBvVY6jubrHQelNoowV3rN9RR5FpeetMBgePrzfyIK
         q2rwpSizmQi1k0iBVp8qGksn+XMNw25A+Gc+xdyazMnnFaECUO8K+xz61PQMzLECg+oe
         LQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+T4HBXFbynYzp9NCIHMJxk+jY5JAUB+Pkhx9FGv2/08=;
        b=NoRVSUeLBZbaecUyRh8rP0sMqelLYeTQM0DyarswqbZ9pNlyoBa7w1RaZOfQCqRkQM
         T28If+fPA4C/PO3cI7WGXYW9Tdv967kCiKdl+3Islu01NzpwKqYPuKQu7Ye3sd5hcej5
         MO76rgp1HWkOAJabwfSieL8X/2mmEm4VztidDvauVdkymqPsWIcV8sefvANMCZfhNUDR
         v2rQL8JH/Rv+e1XystEGAnw5yAbZW7/GA9V3T6OxVCxLmiLVc9lCn9g2bmpOh8NpW8vA
         8qUef1Ebnei99rgQnYWofAFcmj0FbvGdIBJRa77Au127OPR2cprw+Ii8YwLP1PIZdE5l
         vnHA==
X-Gm-Message-State: AOAM531xrgj8wyU9CsVX71NKjUbz1uFYFqcdoBgf5LaUF8XVoPDWT13x
        ZXGzR4eUDxi/kV7QJtwL7WA=
X-Google-Smtp-Source: ABdhPJwmgYezxw2Ilwq5McE9oPdFNgJgf2yg1jrhcPuqjkMZMzM+aCO7rbw47ZY2Ao5f+88ka04U5g==
X-Received: by 2002:a2e:9b54:0:b0:246:3b89:83e with SMTP id o20-20020a2e9b54000000b002463b89083emr13968319ljj.489.1646059634624;
        Mon, 28 Feb 2022 06:47:14 -0800 (PST)
Received: from elysium.toya.net.pl (staticline-31-183-165-244.toya.net.pl. [31.183.165.244])
        by smtp.gmail.com with ESMTPSA id r14-20020ac252ae000000b00443f3cbc03asm993996lfm.6.2022.02.28.06.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 06:47:14 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     rppt@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 0/9] Add tests for memblock allocation functions
Date:   Mon, 28 Feb 2022 15:46:42 +0100
Message-Id: <cover.1646055639.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patches are on top of memblock/for-next.

This series adds test coverage for memblock allocation functions that return
virtual addresses:
  * memblock_alloc
  * memblock_alloc_try_nid
  * memblock_alloc_from

These tests are a part of memblock simulator, a user space test suite that uses
the actual memblock code[1]. All the tests are run as one, monolithic test, that
exercises both basic operations and allocation functions of memblock.

To simplify implementation of the memory allocation tests, reset_memblock() was
split into two functions - reset_memblock_attributes() and
reset_memblock_regions(). The former sets default values for region array names,
allocation direction flag (bottom_up) and current memory limit. The latter only
resets region arrays and corresponding counters.

In addition to these, the patch set introduces a data structure that simulates
physical memory, test_memory. It is a simple wrapper around a pointer to the
memory block allocated via malloc(), which is added to memblock as available
memory. This is required because the tested functions interact with the memory
before allocating it.

Patchset structure:
  * Patch 1 splits reset_memblock() into two functions -
    reset_memblock_regions() and reset_memblock_attributes(), and updates
    basic API tests to use the new definitions
  * Patch 2 adds test_memory struct and functions to add (or release) dummy
    physical memory
  * Patches 3 - 8 add test cases for memblock_alloc, memblock_alloc_try_nid and
    memblock_alloc_from for both allocation directions (default top down and
    bottom up)
  * Patch 9 adds README and TODO files

[1] https://lore.kernel.org/linux-mm/cover.1643796665.git.karolinadrobnik@gmail.com/

Karolina Drobnik (9):
  memblock tests: Split up reset_memblock function
  memblock tests: Add simulation of physical memory
  memblock tests: Add memblock_alloc tests for top down
  memblock tests: Add memblock_alloc tests for bottom up
  memblock tests: Add memblock_alloc_from tests for top down
  memblock tests: Add memblock_alloc_from tests for bottom up
  memblock tests: Add memblock_alloc_try_nid tests for top down
  memblock tests: Add memblock_alloc_try_nid tests for bottom up
  memblock tests: Add TODO and README files

 tools/testing/memblock/Makefile               |    3 +-
 tools/testing/memblock/README                 |  114 ++
 tools/testing/memblock/TODO                   |   28 +
 tools/testing/memblock/main.c                 |    7 +
 tools/testing/memblock/tests/alloc_api.c      |  742 +++++++++++
 tools/testing/memblock/tests/alloc_api.h      |    9 +
 .../memblock/tests/alloc_helpers_api.c        |  393 ++++++
 .../memblock/tests/alloc_helpers_api.h        |    9 +
 tools/testing/memblock/tests/alloc_nid_api.c  | 1167 +++++++++++++++++
 tools/testing/memblock/tests/alloc_nid_api.h  |    9 +
 tools/testing/memblock/tests/basic_api.c      |   49 +-
 tools/testing/memblock/tests/basic_api.h      |    1 -
 tools/testing/memblock/tests/common.c         |   33 +-
 tools/testing/memblock/tests/common.h         |   21 +-
 14 files changed, 2550 insertions(+), 35 deletions(-)
 create mode 100644 tools/testing/memblock/README
 create mode 100644 tools/testing/memblock/TODO
 create mode 100644 tools/testing/memblock/tests/alloc_api.c
 create mode 100644 tools/testing/memblock/tests/alloc_api.h
 create mode 100644 tools/testing/memblock/tests/alloc_helpers_api.c
 create mode 100644 tools/testing/memblock/tests/alloc_helpers_api.h
 create mode 100644 tools/testing/memblock/tests/alloc_nid_api.c
 create mode 100644 tools/testing/memblock/tests/alloc_nid_api.h


base-commit: f30b002ccfee8c60c8feb590e145c0b5e8fa4c67
--
2.30.2

