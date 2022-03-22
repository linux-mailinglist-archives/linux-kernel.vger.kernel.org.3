Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908CF4E3C5B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbiCVKXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiCVKXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:23:00 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6277EB3B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:21:33 -0700 (PDT)
Received: from integral2.. (unknown [182.2.69.158])
        by gnuweeb.org (Postfix) with ESMTPSA id DD7D07E2BC;
        Tue, 22 Mar 2022 10:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647944492;
        bh=SJpf60ax+2wcBXsUzQPeOK1RNSO156fTzrxKlucYODk=;
        h=From:To:Cc:Subject:Date:From;
        b=IdqHrRwDVMp1nJR1PzOihp7BLe5CfJjRm5MX3swBGw6q7hJYk6kGPm5cxYlm0aydc
         SD6At7m7/FRgnapbc4ZoCzu1d6lfEGOgSUO0b48CaVec6W21gTIjSaX0ZVjHGf8upT
         nYlAUxT9JU2DH1zP4SPSj8WJuN2sJWJQj5ukAvRBvRUa+aBdU5bMPN8hMRQuJ6YEoC
         lPqwHl26kXztGvZ4OkZ3VN3GCwrRz95nT5sWSC2Pi28aUigl8ct424eYvF7hmE6Yjj
         dcd8QH4u04vJtUkO52PijdJjv1zzNK53Su+UmC+KfNPZOmL6iD+wBZOqWDSlpC97tp
         Ix8W/FqUmUYaQ==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [RFC PATCH v2 0/8] Add dynamic memory allocator support for nolibc
Date:   Tue, 22 Mar 2022 17:21:07 +0700
Message-Id: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
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

This is the v2 of RFC to add dynamic memory allocator support for
nolibc.

## Background
The need to allocate memory dynamically has become a requirement for
the C programming language. Mainly it happens when the allocation size
is determined at runtime. Many other use cases also do it when the
object's lifetime is long-lived and needs to be recycled at runtime.
Currently, the nolibc header doesn't support such a type of allocation.
This series adds it.

## Implementation
Add basic functions to manage dynamic memory allocation:
  - malloc()
  - calloc()
  - realloc()
  - free()

The allocator uses mmap() syscall to allocate the memory and uses
munmap() syscall to free the allocated memory. The metadata to keep
track the length for munmap-ing is simply defined as a struct below:
```
struct nolibc_heap {
        size_t  len;
        char    user_p[] __attribute__((__aligned__));
};
```
malloc(), realloc() and calloc() return a pointer to `user_p`.

## Add my_syscall6() support for x86 32-bit.
mmap() needs 6 arguments to work with. Not all architectures that
nolibc supports have the my_syscall6() wrapper. This series also
adds my_syscall6() wrapper support for i386.

Notes:
On i386, the 6th argument of syscall goes in %ebp. However, both Clang
and GCC cannot use %ebp in the clobber list and in the "r" constraint
without using -fomit-frame-pointer. To make it always available for
any kind of compilation, the below workaround is implemented.

For clang (the Assembly statement can't clobber %ebp):
  1) Push the 6-th argument.
  2) Push %ebp.
  3) Load the 6-th argument from 4(%esp) to %ebp.
  4) Do the syscall (int $0x80).
  5) Pop %ebp (restore the old value of %ebp).
  6) Add %esp by 4 (undo the stack pointer).

For GCC, fortunately it has a #pragma that can force a specific function
to be compiled with -fomit-frame-pointer, so it can use "r"(var) where
var is a variable bound to %ebp.

## Test
The following simple program can be used to test this series:

  https://gist.github.com/ammarfaizi2/db0af6aa0b95a0c7478bce64e349f021

@@ Changelog:

   Link RFC v1: https://lore.kernel.org/lkml/20220320093750.159991-1-ammarfaizi2@gnuweeb.org/
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
Ammar Faizi (8):
  tools/nolibc: x86-64: Update System V ABI document link
  tools/nolibc: Remove .global _start from the entry point code
  tools/nolibc: i386: Implement syscall with 6 arguments
  tools/nolibc/sys: Implement `mmap()` and `munmap()`
  tools/nolibc/types: Implement `offsetof()` and `container_of()` macro
  tools/nolibc/stdlib: Implement `malloc()`, `calloc()`, `realloc()` and `free()`
  tools/nolibc/string: Implement `strnlen()`
  tools/include/string: Implement `strdup()` and `strndup()`

 tools/include/nolibc/arch-aarch64.h |  1 -
 tools/include/nolibc/arch-arm.h     |  1 -
 tools/include/nolibc/arch-i386.h    | 67 +++++++++++++++++++++++++++-
 tools/include/nolibc/arch-mips.h    |  1 -
 tools/include/nolibc/arch-riscv.h   |  1 -
 tools/include/nolibc/arch-x86_64.h  |  3 +-
 tools/include/nolibc/stdlib.h       | 68 +++++++++++++++++++++++++++++
 tools/include/nolibc/string.h       | 41 +++++++++++++++++
 tools/include/nolibc/sys.h          | 62 ++++++++++++++++++++++++++
 tools/include/nolibc/types.h        | 11 +++++
 10 files changed, 249 insertions(+), 7 deletions(-)


base-commit: 45abaed6ed05856556c60863f4cac429c92c431f
-- 
Ammar Faizi

