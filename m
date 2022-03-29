Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988B84EAB19
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbiC2KTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbiC2KTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:19:30 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BA723EC44
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:17:47 -0700 (PDT)
Received: from integral2.. (unknown [182.2.70.161])
        by gnuweeb.org (Postfix) with ESMTPSA id 7C3C57E723;
        Tue, 29 Mar 2022 10:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1648549066;
        bh=p6CC/jfVTuTMclxACxIJzVSw2cj7ScCDiF3lvHfIH8c=;
        h=From:To:Cc:Subject:Date:From;
        b=O2R6IyY7xGzSDUhlnU49BcXJSpUn8tf4WT0gD1HETn8gL3jEDRqRVAG1E6lHAQKVz
         OXdd2y6QvVqkaYGLXSccsvUt/ROqJTcs5ce8niRgIXa9GVmWXJaEigrbuuK5ofnZI2
         6senbYTs3wr4JNBAPhUezSqm7F1mR7w9NLHECq6AbLJtBWUokHoSDh0hBDFIlYhDq/
         E2lQv66kxmyXoVsUztSsUibN7Az+FLjU+v4OWS6oVJaCX0mzau2SPZ7ybDQ2gxXbSw
         kIAh5pL5IeXPW5Jt6wMD2BuPggwUHYpRvuCnva2Hm8YoVHEujrj9sgMW9xmJjEhCMD
         mELk1S/dRDFxQ==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: [PATCH v2 0/9] Add dynamic memory allocator support for nolibc
Date:   Tue, 29 Mar 2022 17:17:28 +0700
Message-Id: <20220329101737.58985-1-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a patchset v2 to add dynamic memory allocator support
for nolibc after 2 RFCs, please review the changes carefully.

@@ Changelog:
---
   Link v1: https://lore.kernel.org/lkml/20220324073039.140946-1-ammarfaizi2@gnuweeb.org
   v1 -> v2:
     - Sync with Paul's tree.
     - Drop 2 patches that tried to remove register variables
       (comment from Willy).
     - Make the patch that replaces `asm` with `__asm__` the
       second patch (comment from Willy).

   Link RFC v2: https://lore.kernel.org/lkml/20220322102115.186179-1-ammarfaizi2@gnuweeb.org
   RFC v2 -> v1:
     - Rebase, sync with Paul's tree.
     - Add new 3 patches [PATCH 03/11], [PATCH 04/11], [PATCH 05/11].

     [PATCH 02/11]
     - Append Reviewed-by tag from Nick.
     - s/Removing/remove/

     [PATCH 06/11]
     - Use the same pattern for syscall6, regardless using GCC or Clang
      (comment from David).
     - Use appropriate constraints for syscall6 instead of always using
      register variables (comment from David).

     [PATCH 09/11]
     - Round up the malloc() allocation to 4096 (comment from David).
     - Don't realloc() if we still have enough memory to contain the
       requested new size (comment from David).
     - Fix conflict with getenv() fix (after rebase).

   Link RFC v1: https://lore.kernel.org/lkml/20220320093750.159991-1-ammarfaizi2@gnuweeb.org
   RFC v1 -> RFC v2:
    - Add 2 new patches [PATCH 5/8] and [PATCH 7/8].

    [PATCH 2/8]
    - Remove all `.global _start` for all build (GCC and Clang) instead of
      removing all `.weak _start` for clang build (Comment from Willy).

    [PATCH 3/8]
    - Fix %ebp saving method. Don't use redzone, i386 doesn't have a redzone
      (comment from David and Alviro).

    [PATCH 6/8]
    - Move container_of() and offsetof() macro to types.h with a
      separate patch (comment from Willy).

    [PATCH 8/8]
    - Update strdup and strndup implementation, use strlen and strnlen to get
      the string length first (comment from Willy and Alviro).
    - Fix the subject line prefix, it was "tools/include/string: ", it should be
      "tools/nolibc/string: ".
    - Update the commit message.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
Ammar Faizi (9):
  tools/nolibc: x86-64: Update System V ABI document link
  tools/nolibc: Replace `asm` with `__asm__`
  tools/nolibc: Remove .global _start from the entry point code
  tools/nolibc: i386: Implement syscall with 6 arguments
  tools/nolibc/sys: Implement `mmap()` and `munmap()`
  tools/nolibc/types: Implement `offsetof()` and `container_of()` macro
  tools/nolibc/stdlib: Implement `malloc()`, `calloc()`, `realloc()` and `free()`
  tools/nolibc/string: Implement `strnlen()`
  tools/include/string: Implement `strdup()` and `strndup()`

 tools/include/nolibc/arch-aarch64.h | 75 +++++++++++++-------------
 tools/include/nolibc/arch-arm.h     | 59 +++++++++++----------
 tools/include/nolibc/arch-i386.h    | 80 +++++++++++++++++-----------
 tools/include/nolibc/arch-mips.h    | 63 +++++++++++-----------
 tools/include/nolibc/arch-riscv.h   | 75 +++++++++++++-------------
 tools/include/nolibc/arch-x86_64.h  | 75 +++++++++++++-------------
 tools/include/nolibc/stdlib.h       | 81 +++++++++++++++++++++++++++++
 tools/include/nolibc/string.h       | 41 +++++++++++++++
 tools/include/nolibc/sys.h          | 62 ++++++++++++++++++++++
 tools/include/nolibc/types.h        | 11 ++++
 10 files changed, 417 insertions(+), 205 deletions(-)


base-commit: 2eb9d6a49acd4f12078967c33e9786e084fe6407
-- 
Ammar Faizi

