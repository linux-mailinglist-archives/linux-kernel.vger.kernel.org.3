Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657DE4E1AE5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 10:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243380AbiCTJkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 05:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243347AbiCTJkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 05:40:10 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A105BE030
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 02:38:44 -0700 (PDT)
Received: from integral2.. (unknown [182.2.42.189])
        by gnuweeb.org (Postfix) with ESMTPSA id 8E4747E2BC;
        Sun, 20 Mar 2022 09:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647769123;
        bh=T0rYRGIvfwwd/7Dm3Sd+DsWPI6G9ojjh1NWTxQvQ/fk=;
        h=From:To:Cc:Subject:Date:From;
        b=c1TzbkIJ++GyQeRmFfdd2/5mCFJCs8pkcKUQLs87vxSWb/XFxciBfQKRSb5Bambsx
         rwATCjWOxUcKlqQvz8hZiwGclidvrbcH52qdLSe6tNdPDhAM+gffkBO17cxhdOxLjZ
         r+wK1ictAgmJjC1heR0GWdYurk9wGqpa61+iO7qS7b6pSahfLxEEE2mGGFIOAuGcnx
         JSDBhDhxXWlEjruYO1UmC+vLyn3AXQIFvnCwdyYTfGEqFtbGBPUh2KbfsPM1BSB8k5
         4nDz7RwzCRGt6+XZKRy7Kw1NnoSrkULXnesXUKa65mn8MMpJlROmWJYgrGiqP/+7Jt
         oQfhbBgAr14qA==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [RFC PATCH v1 0/6] Add dynamic memory allocator support for nolibc
Date:   Sun, 20 Mar 2022 16:37:44 +0700
Message-Id: <20220320093750.159991-1-ammarfaizi2@gnuweeb.org>
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

This is the v1 of RFC to add dynamic memory allocator support for
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
munmap() syscall to free the allocated memory.

The metadata to keep track the length for munmap-ing is simply
defined as a struct below:
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

Both Clang and GCC cannot use %ebp in the clobber list and in the "r"
constraint without using -fomit-frame-pointer. To make it always
available for any kind of compilation, the below workaround is
implemented.

For clang (the Assembly statement can't clobber %ebp):
  1) Save the %ebp value to the redzone area -4(%esp).
  2) Load the 6-th argument from memory to %ebp.
  3) Subtract the %esp by 4.
  4) Do the syscall (int $0x80).
  5) Pop %ebp.

For GCC, fortunately it has a #pragma that can force a specific function
to be compiled with -fomit-frame-pointer, so it can use "r"(var) where
var is a variable bound to %ebp.


## Limitation

Currently, for mips and arm arch cannot use these dynamic memory allocator
functions because they're missing the my_syscall6() macro.

[ammarfaizi2: I would love to add the support for them too, but I don't
 have the hardware to play with MIPS and ARM. ]


## Test

The following simple program can be used to test this series:

  https://gist.github.com/ammarfaizi2/db0af6aa0b95a0c7478bce64e349f021


## Patchset Summary

1) Patch 1 is a fix for the System V ABI document link.

2) Patch 2 is a fix to support compile with clang.

3) Patch 3 adds my_syscall6() implementation for i386.

4) Patch 4 adds mmap() and munmap() functions.

5) Patch 5 adds malloc(), calloc(), realloc() and free().

6) Patch 6 adds strdup() and strndup().


Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
Ammar Faizi (6):
  tools/nolibc: x86-64: Update System V ABI document link
  tools/nolibc: Make the entry point not weak for clang
  tools/nolibc: i386: Implement syscall with 6 arguments
  tools/nolibc/sys: Implement `mmap()` and `munmap()`
  tools/nolibc/stdlib: Implement `malloc()`, `calloc()`, `realloc()` and `free()`
  tools/include/string: Implement `strdup()` and `strndup()`

 tools/include/nolibc/arch-aarch64.h |  2 +
 tools/include/nolibc/arch-arm.h     |  2 +
 tools/include/nolibc/arch-i386.h    | 66 ++++++++++++++++++++++++
 tools/include/nolibc/arch-mips.h    |  2 +
 tools/include/nolibc/arch-riscv.h   |  2 +
 tools/include/nolibc/arch-x86_64.h  |  4 +-
 tools/include/nolibc/stdlib.h       | 79 +++++++++++++++++++++++++++++
 tools/include/nolibc/string.h       | 68 +++++++++++++++++++++++++
 tools/include/nolibc/sys.h          | 62 ++++++++++++++++++++++
 9 files changed, 286 insertions(+), 1 deletion(-)


base-commit: fda0d5d1b79d8b7032be3d7720a481a9fde91baf
-- 
Ammar Faizi

