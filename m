Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D112506116
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241009AbiDSApG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240977AbiDSApD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E88F21E2A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB59CB81128
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A39C385A1;
        Tue, 19 Apr 2022 00:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328939;
        bh=/oWOto7C/HttgN869qurHdKDZwSjF5C9nB7jQSel6mI=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=DRbaYLu4d+jH2LcIturYwgITP/R+E8Ng0aFNJC7+nwOCB1qwXwL/iMIs2dwEFqCij
         dmZaEb8y0ogka0T85YRMGgyQr6b1QhbkCKYIQqD3PpR1ikVPnTSWcpDk5WqfGikLnX
         lFMSkFAAVYDYt31fR/j/UtQ+Bsh3PhXtygjQ7Fu8whEB0mEm5kuoUVu8xPbcPBokZ5
         e/4AtHiqpuhGPuVeWY3A2JTonvBQpAYLzWM+JxYxfR9js1rKnCiwatiC+Gc7mHP5l7
         nZc7GyYBJiXkeSajre5/+Tise3OzCllS18/rXZ3A9rKGJ2s5ULaFweHSdAZSeNMof5
         uxqa0IE0P3Bqw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 219425C04BD; Mon, 18 Apr 2022 17:42:19 -0700 (PDT)
Date:   Mon, 18 Apr 2022 17:42:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu
Subject: [PATCH nolibc 0/61] nolibc updates for v5.19
Message-ID: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series adds a number of library functions and splits this library
into multiple files.

1.	use pselect6 on RISCV, courtesy of Willy Tarreau.

2.	guard the main file against multiple inclusion, courtesy of
	Willy Tarreau.

3.	move the standard type definitions to std.h, courtesy of Willy
	Tarreau.

4.	split syscall-specific definitions into their own files, courtesy
	of Willy Tarreau.

5.	split arch-specific code into individual files, courtesy of
	Willy Tarreau.

6.	split the syscall definitions into their own file, courtesy of
	Willy Tarreau.

7.	extract the stdlib-specific functions to their own file, courtesy
	of Willy Tarreau.

8.	split the string functions into string.h, courtesy of Willy
	Tarreau.

9.	split the is* functions to ctype.h, courtesy of Willy Tarreau.

10.	add the missing is* functions, courtesy of Willy Tarreau.

11.	move the FD_* functions to macros in types.h, courtesy of Willy
	Tarreau.

12.	make FD_SETSIZE configurable, courtesy of Willy Tarreau.

13.	move makedev to types.h and make it a macro, courtesy of Willy
	Tarreau.

14.	move ltoa() to stdlib.h, courtesy of Willy Tarreau.

15.	replace the ltoa() function with more efficient ones, courtesy
	of Willy Tarreau.

16.	add i64toa() and u64toa(), courtesy of Willy Tarreau.

17.	add utoh() and u64toh(), courtesy of Willy Tarreau.

18.	add a minimal set of stdio functions, courtesy of Willy Tarreau.

19.	add stdin/stdout/stderr and fget*/fput* functions, courtesy of
	Willy Tarreau.

20.	add fwrite() to stdio, courtesy of Willy Tarreau.

21.	add a minimal [vf]printf() implementation, courtesy of Willy
	Tarreau.

22.	define EXIT_SUCCESS and EXIT_FAILURE, courtesy of Willy Tarreau.

23.	add perror() to report the errno value, courtesy of Willy Tarreau.

24.	make open() take a vararg on the 3rd argument, courtesy of
	Willy Tarreau.

25.	avoid a 64-bit shift in u64toh_r(), courtesy of Willy Tarreau.

26.	make raise() use the lower level syscalls only, courtesy of
	Willy Tarreau.

27.	make getpgrp(), getpid(), gettid() not set errno, courtesy of
	Willy Tarreau.

28.	use unidirectional variants for memcpy(), courtesy of Willy
	Tarreau.

29.	slightly simplify memmove(), courtesy of Willy Tarreau.

30.	add strncpy() and strlcpy(), courtesy of Willy Tarreau.

31.	add tiny versions of strncat() and strlcat(), courtesy of Willy
	Tarreau.

32.	move exported functions to their own section, courtesy of Willy
	Tarreau.

33.	mark the _start symbol as weak, courtesy of Willy Tarreau.

34.	define PATH_MAX and MAXPATHLEN, courtesy of Willy Tarreau.

35.	export memset() and memmove(), courtesy of Willy Tarreau.

36.	extract errno.h from sys.h, courtesy of Willy Tarreau.

37.	extract msleep(), sleep(), tcsetpgrp() to unistd.h, courtesy of
	Willy Tarreau.

38.	add usleep(), courtesy of Willy Tarreau.

39.	move raise() to signal.h, courtesy of Willy Tarreau.

40.	create time.h with time(), courtesy of Willy Tarreau.

41.	also mention how to build by just setting the include path,
	courtesy of Willy Tarreau.

42.	implement abort(), courtesy of Willy Tarreau.

43.	make printf(%s) accept NULL, courtesy of Willy Tarreau.

44.	add a simple getenv() implementation, courtesy of Willy Tarreau.

45.	add support for '%p' to vfprintf(), courtesy of Willy Tarreau.

46.	add strcmp() and strncmp(), courtesy of Willy Tarreau.

47.	add syscall definition for getppid(), courtesy of Willy Tarreau.

48.	add poll() and waitpid() flag definitions, courtesy of Willy
	Tarreau.

49.	add a makefile to install headers, courtesy of Willy Tarreau.

50.	add the nolibc subdir to the common Makefile, courtesy of Willy
	Tarreau.

51.	do not use __builtin_strlen() at -O0, courtesy of Willy Tarreau.

52.	only reference the external environ when inlined, courtesy of
	Willy Tarreau.

53.	x86-64: Update System V ABI document link, courtesy of Ammar
	Faizi.

54.	Replace `asm` with `__asm__`, courtesy of Ammar Faizi.

55.	Remove .global _start from the entry point code, courtesy of
	Ammar Faizi.

56.	i386: Implement syscall with 6 arguments, courtesy of Ammar Faizi.

57.	Implement `mmap()` and `munmap()`, courtesy of Ammar Faizi.

58.	Implement `offsetof()` and `container_of()` macro, courtesy of
	Ammar Faizi.

59.	Implement `malloc()`, `calloc()`, `realloc()` and `free()`,
	courtesy of Ammar Faizi.

60.	Implement `strnlen()`, courtesy of Ammar Faizi.

61.	Implement `strdup()` and `strndup()`, courtesy of Ammar Faizi.

						Thanx, Paul

------------------------------------------------------------------------

 b/tools/Makefile                      |    4 
 b/tools/include/nolibc/Makefile       |   42 
 b/tools/include/nolibc/arch-aarch64.h |  199 ++
 b/tools/include/nolibc/arch-arm.h     |  204 ++
 b/tools/include/nolibc/arch-i386.h    |  196 ++
 b/tools/include/nolibc/arch-mips.h    |  215 ++
 b/tools/include/nolibc/arch-riscv.h   |  204 ++
 b/tools/include/nolibc/arch-x86_64.h  |  215 ++
 b/tools/include/nolibc/arch.h         |   32 
 b/tools/include/nolibc/ctype.h        |   22 
 b/tools/include/nolibc/errno.h        |   27 
 b/tools/include/nolibc/nolibc.h       |    3 
 b/tools/include/nolibc/signal.h       |   22 
 b/tools/include/nolibc/std.h          |   49 
 b/tools/include/nolibc/stdio.h        |   57 
 b/tools/include/nolibc/stdlib.h       |   85 +
 b/tools/include/nolibc/string.h       |  107 +
 b/tools/include/nolibc/sys.h          | 1189 +++++++++++++++
 b/tools/include/nolibc/time.h         |   28 
 b/tools/include/nolibc/types.h        |  133 +
 b/tools/include/nolibc/unistd.h       |   46 
 tools/include/nolibc/arch-aarch64.h   |   76 -
 tools/include/nolibc/arch-arm.h       |   60 
 tools/include/nolibc/arch-i386.h      |   81 -
 tools/include/nolibc/arch-mips.h      |   64 
 tools/include/nolibc/arch-riscv.h     |   76 -
 tools/include/nolibc/arch-x86_64.h    |   76 -
 tools/include/nolibc/ctype.h          |   79 +
 tools/include/nolibc/nolibc.h         | 2557 ----------------------------------
 tools/include/nolibc/stdio.h          |  297 +++
 tools/include/nolibc/stdlib.h         |  484 +++++-
 tools/include/nolibc/string.h         |  200 ++
 tools/include/nolibc/sys.h            |  138 +
 tools/include/nolibc/types.h          |   76 -
 tools/include/nolibc/unistd.h         |    8 
 35 files changed, 4480 insertions(+), 2871 deletions(-)
