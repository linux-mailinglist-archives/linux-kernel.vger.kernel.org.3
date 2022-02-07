Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB254AC636
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354052AbiBGQna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390691AbiBGQfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:35:30 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CBECC0401CF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:35:28 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOa41014383;
        Mon, 7 Feb 2022 17:24:36 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 00/42] nolibc: update to resync with out-of-tree project
Date:   Mon,  7 Feb 2022 17:23:12 +0100
Message-Id: <20220207162354.14293-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

Here comes an update to the nolibc subsystem to keep it in sync with
the out-of-tree project and to bring a number of usability improvements.

The approach here consists in better splitting the layers so that
arch-specific syscall functions are now in their own files (one per
arch), then syscalls are implemented on top of this in a generic file,
then the generic libc stuff is exposed. This way it becomes easier to
add support for new architectures if needed.

I exported 3 functions as weak symbols: memset(), memmove() and abort().
For the first two ones, gcc/clang may issue calls to them and will not
always fall back to the builtin equivalent. For abort(), I've seen it
referenced by libgcc from some divide functions.

A few stdio-level functions were added (unbuffered), including a quite
limited but usable printf() which significantly eases debugging of test
programs by allowing to print return codes or pointers for example.

A few functions and syscalls like abort(), raise(), time() and usleep()
were added. More str* functions were added as well. open() now takes a
vararg on the 3rd argument so as to ease porting of existing programs.

Finally, the functions and definitions were moved to the appropriate
files as documented in their man pages when relevant, so that simple
programs which only use a few include files among stdio.h, stdlib.h,
string.h, unistd.h, errno.h, ctype.h, signal.h, time.h or types.h can
build without modification. Obviously this remains fairly limited in
scope, but for test programs that's usually fine.

I could verify that a few of my programs and that your rcutorture test
continue to work (not much surprising since most of the work only
consists in moving functions between files).

There's obviously no rush, but I preferred to resync the version here
given that Mark expressed some interest recently, and I'd hate it if
he had to add new syscalls that already existed out of tree! Comments,
suggestions and feature requests welcome as usual. If you prefer to
pull, it's also available here, on top of 5.17-rc3:

  git://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git 20220206-nolibc-split-2

Thank you!
Willy

---
Willy Tarreau (42):
  tools/nolibc: use pselect6 on RISCV
  tools/nolibc: guard the main file against multiple inclusion
  tools/nolibc/std: move the standard type definitions to std.h
  tools/nolibc/types: split syscall-specific definitions into their own files
  tools/nolibc/arch: split arch-specific code into individual files
  tools/nolibc/sys: split the syscall definitions into their own file
  tools/nolibc/stdlib: extract the stdlib-specific functions to their own file
  tools/nolibc/string: split the string functions into string.h
  tools/nolibc/ctype: split the is* functions to ctype.h
  tools/nolibc/ctype: add the missing is* functions
  tools/nolibc/types: move the FD_* functions to macros in types.h
  tools/nolibc/types: make FD_SETSIZE configurable
  tools/nolibc/types: move makedev to types.h and make it a macro
  tools/nolibc/stdlib: move ltoa() to stdlib.h
  tools/nolibc/stdlib: replace the ltoa() function with more efficient ones
  tools/nolibc/stdlib: add i64toa() and u64toa()
  tools/nolibc/stdlib: add utoh() and u64toh()
  tools/nolibc/stdio: add a minimal set of stdio functions
  tools/nolibc/stdio: add stdin/stdout/stderr and fget*/fput* functions
  tools/nolibc/stdio: add fwrite() to stdio
  tools/nolibc/stdio: add a minimal [vf]printf() implementation
  tools/nolibc/types: define EXIT_SUCCESS and EXIT_FAILURE
  tools/nolibc/stdio: add perror() to report the errno value
  tools/nolibc/sys: make open() take a vararg on the 3rd argument
  tools/nolibc/stdlib: avoid a 64-bit shift in u64toh_r()
  tools/nolibc/stdlib: make raise() use the lower level syscalls only
  tools/nolibc/sys: make getpgrp(), getpid(), gettid() not set errno
  tools/nolibc/string: use unidirectional variants for memcpy()
  tools/nolibc/string: slightly simplify memmove()
  tools/nolibc/string: add strncpy() and strlcpy()
  tools/nolibc/string: add tiny versions of strncat() and strlcat()
  tools/nolibc: move exported functions to their own section
  tools/nolibc/arch: mark the _start symbol as weak
  tools/nolibc/types: define PATH_MAX and MAXPATHLEN
  tools/nolibc/string: export memset() and memmove()
  tools/nolibc/errno: extract errno.h from sys.h
  tools/nolibc/unistd: extract msleep(), sleep(), tcsetpgrp() to unistd.h
  tools/nolibc/unistd: add usleep()
  tools/nolibc/signal: move raise() to signal.h
  tools/nolibc/time: create time.h with time()
  tools/nolibc: also mention how to build by just setting the include path
  tools/nolibc/stdlib: implement abort()

 tools/include/nolibc/arch-aarch64.h |  200 +++
 tools/include/nolibc/arch-arm.h     |  205 +++
 tools/include/nolibc/arch-i386.h    |  197 +++
 tools/include/nolibc/arch-mips.h    |  216 +++
 tools/include/nolibc/arch-riscv.h   |  205 +++
 tools/include/nolibc/arch-x86_64.h  |  216 +++
 tools/include/nolibc/arch.h         |   32 +
 tools/include/nolibc/ctype.h        |   99 ++
 tools/include/nolibc/errno.h        |   27 +
 tools/include/nolibc/nolibc.h       | 2540 +--------------------------
 tools/include/nolibc/signal.h       |   22 +
 tools/include/nolibc/std.h          |   49 +
 tools/include/nolibc/stdio.h        |  296 ++++
 tools/include/nolibc/stdlib.h       |  311 ++++
 tools/include/nolibc/string.h       |  212 +++
 tools/include/nolibc/sys.h          | 1168 ++++++++++++
 tools/include/nolibc/time.h         |   28 +
 tools/include/nolibc/types.h        |  184 ++
 tools/include/nolibc/unistd.h       |   54 +
 19 files changed, 3756 insertions(+), 2505 deletions(-)
 create mode 100644 tools/include/nolibc/arch-aarch64.h
 create mode 100644 tools/include/nolibc/arch-arm.h
 create mode 100644 tools/include/nolibc/arch-i386.h
 create mode 100644 tools/include/nolibc/arch-mips.h
 create mode 100644 tools/include/nolibc/arch-riscv.h
 create mode 100644 tools/include/nolibc/arch-x86_64.h
 create mode 100644 tools/include/nolibc/arch.h
 create mode 100644 tools/include/nolibc/ctype.h
 create mode 100644 tools/include/nolibc/errno.h
 create mode 100644 tools/include/nolibc/signal.h
 create mode 100644 tools/include/nolibc/std.h
 create mode 100644 tools/include/nolibc/stdio.h
 create mode 100644 tools/include/nolibc/stdlib.h
 create mode 100644 tools/include/nolibc/string.h
 create mode 100644 tools/include/nolibc/sys.h
 create mode 100644 tools/include/nolibc/time.h
 create mode 100644 tools/include/nolibc/types.h
 create mode 100644 tools/include/nolibc/unistd.h

-- 
2.35.1

