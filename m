Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6A152F292
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351997AbiETSYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbiETSYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:24:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A58190D19
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:24:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77A28617F7
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 18:24:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF42C385A9;
        Fri, 20 May 2022 18:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653071068;
        bh=5Tl4tCmdW+syn/4B/DwZY+zAZFIx2KKfFnqS2HaiuZY=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=j5rsN30XT1/x5v6PkXZAnyu2cOr1NFWbSvMdPIBh3VJKC2b5JGmRKu0iWG3CkMJd8
         LUDkvPqoQfMFzpyHEp5PPEQ01nTFDRnkIcu4V8AJqEHudYk/ejxpdjJHccaCHiMXqs
         il3GNFee/lrp9A2NjjTZxOt1BIDfJzBg5CzhnLFwJ/E5toKwJltIS3vU+WOYXbLMx3
         PrNy+o8XnzYPrG+MG1P44IrhMiH/dKlwBQ0CSnLIdW+dnYU1uoylUeICfE+cJw06N9
         +D8M91vJAol7eCVXY+ThWZUVZSA8ouYkOSMgHfDMEWLEZdN2+KmGBukxUbQY8pjcCD
         vpjyixZ2L2L3Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6E5485C05F8; Fri, 20 May 2022 11:24:28 -0700 (PDT)
Date:   Fri, 20 May 2022 11:24:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, w@1wt.eu
Subject: [GIT PULL] nolibc changes for v5.19
Message-ID: <20220520182428.GA3791250@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

Once the merge window opens, please pull the latest nolibc changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc.2022.05.20a
  # HEAD 11dbdaeff41d9ec9376476889651fac4838bff99 tools/nolibc/string: Implement `strdup()` and `strndup()`

----------------------------------------------------------------
Pull request for nolibc library for v5.19

This pull request adds a number of library functions and splits this
library into multiple files.

----------------------------------------------------------------
Ammar Faizi (9):
      tools/nolibc: x86-64: Update System V ABI document link
      tools/nolibc: Replace `asm` with `__asm__`
      tools/nolibc: Remove .global _start from the entry point code
      tools/nolibc: i386: Implement syscall with 6 arguments
      tools/nolibc/sys: Implement `mmap()` and `munmap()`
      tools/nolibc/types: Implement `offsetof()` and `container_of()` macro
      tools/nolibc/stdlib: Implement `malloc()`, `calloc()`, `realloc()` and `free()`
      tools/nolibc/string: Implement `strnlen()`
      tools/nolibc/string: Implement `strdup()` and `strndup()`

Willy Tarreau (52):
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
      tools/nolibc/stdio: make printf(%s) accept NULL
      tools/nolibc/stdlib: add a simple getenv() implementation
      tools/nolibc/stdio: add support for '%p' to vfprintf()
      tools/nolibc/string: add strcmp() and strncmp()
      tools/nolibc/sys: add syscall definition for getppid()
      tools/nolibc/types: add poll() and waitpid() flag definitions
      tools/nolibc: add a makefile to install headers
      tools/nolibc: add the nolibc subdir to the common Makefile
      tools/nolibc/string: do not use __builtin_strlen() at -O0
      tools/nolibc/stdlib: only reference the external environ when inlined

 tools/Makefile                      |    4 +
 tools/include/nolibc/Makefile       |   42 +
 tools/include/nolibc/arch-aarch64.h |  199 +++
 tools/include/nolibc/arch-arm.h     |  204 +++
 tools/include/nolibc/arch-i386.h    |  219 +++
 tools/include/nolibc/arch-mips.h    |  215 +++
 tools/include/nolibc/arch-riscv.h   |  204 +++
 tools/include/nolibc/arch-x86_64.h  |  215 +++
 tools/include/nolibc/arch.h         |   32 +
 tools/include/nolibc/ctype.h        |   99 ++
 tools/include/nolibc/errno.h        |   27 +
 tools/include/nolibc/nolibc.h       | 2540 +----------------------------------
 tools/include/nolibc/signal.h       |   22 +
 tools/include/nolibc/std.h          |   49 +
 tools/include/nolibc/stdio.h        |  306 +++++
 tools/include/nolibc/stdlib.h       |  423 ++++++
 tools/include/nolibc/string.h       |  285 ++++
 tools/include/nolibc/sys.h          | 1247 +++++++++++++++++
 tools/include/nolibc/time.h         |   28 +
 tools/include/nolibc/types.h        |  205 +++
 tools/include/nolibc/unistd.h       |   54 +
 21 files changed, 4114 insertions(+), 2505 deletions(-)
 create mode 100644 tools/include/nolibc/Makefile
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
