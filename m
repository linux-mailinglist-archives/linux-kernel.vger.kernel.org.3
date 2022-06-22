Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DFB5542E1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351033AbiFVGTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349890AbiFVGTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:19:50 -0400
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com [IPv6:2001:4860:4864:20::44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C94DE1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:19:50 -0700 (PDT)
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-101bb9275bcso16350769fac.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vhaxOBA3UlWBtIgcnLHVU1ZrfA4tEjpSjLASHfh2pRI=;
        b=Ex7gJArFhtsyQU1G4KpCVymBx+OkYN6w9WsvuXplatoxOLgy9qa4D6bvCGntMcSC+P
         ltH13cuk1fVp37A26Jv7C5vnxZLEsIhBWAYaa+LUoEYY+H7cN9jqn+PSv6QH7NQIhS2Z
         zkkO1aJHSLOi6ZeJttsCkCxRbFimcoiA/7hcVixlby0tuS5dUeXSFAEEx4ym0ewyFR1I
         +/iTu6S/zXnFLZsqZK1aqS5DZmF9F6WjbTOc9ki1zGQ1bX/Ye7qWh4NLoeygEFeQHQTX
         paJ6kPFm9eSjIeUtyPhA9VyQJfosPeS9Z4iMn87WqcjVIxKeBU4sh+gona5vE6M2P6hv
         v2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vhaxOBA3UlWBtIgcnLHVU1ZrfA4tEjpSjLASHfh2pRI=;
        b=DchWZxSIN962JEQ9qUj5Po5omwMkmUj4vJ63nXoFXJZUCZYHu6kSiwy12DFEz53ZvF
         UCKG6LlIFk6kVUV2dgV+dzwytFWYucopJwBp4wITLB+yVue/+dv3g4NwEsDtDS4BZXFu
         //0cNeATYL3QgMPZ/t6ZxOnQ47B3M9y50x/az57LNpcgXApDoFv2HRVzogqW5T1mJ1Gz
         o5OgsGanbTu7mozEWves1jZwERYcIyHWhPuoSEGZ3STAXoPoulSD6MGRSoSeyUeO60vf
         lPzk2b327IUK/P1AZ3CLMwyvSsMYd9EiU2q1bYFWgDltIVE6YvDUWKu262xEhXIl4eUg
         7/pg==
X-Gm-Message-State: AJIora9xhU3KSO/atfF3PTB0DtQtR5wXBDYXCu89+i5wTuiajzu1U+tc
        Zb7CUUIW15nUsQyBQoNQG90=
X-Google-Smtp-Source: AGRyM1v0rMMZ5bMWvwcHZBxS85WJNUuxhIAx33BMSoPIXJKG7Ji1YBiFUJL+/+2P7NaJVKVOuJD9Vg==
X-Received: by 2002:a05:6871:1d0:b0:101:59af:c6b7 with SMTP id q16-20020a05687101d000b0010159afc6b7mr22444435oad.89.1655878789236;
        Tue, 21 Jun 2022 23:19:49 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id p10-20020a0568301d4a00b0060be7487954sm10665397oth.26.2022.06.21.23.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 23:19:48 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 0/4] memblock tests: add VERBOSE and MEMBLOCK_DEBUG Makefile options
Date:   Wed, 22 Jun 2022 01:19:28 -0500
Message-Id: <cover.1655878337.git.remckee0@gmail.com>
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
 tools/testing/memblock/tests/common.c         |  60 +++
 tools/testing/memblock/tests/common.h         |  54 +++
 11 files changed, 915 insertions(+), 356 deletions(-)

-- 
2.34.1

