Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD535A8573
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbiHaSZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiHaSZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:25:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70A7FAC51
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:21:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0E1FB8220F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D18C433C1;
        Wed, 31 Aug 2022 18:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661970073;
        bh=+j70l5OHx91xkNyOJnY6CBLy1XNZ1Wk6HIj0sQSWl90=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=nKIw6c1BMEZZZXIFxcpBUuD7Z6P4w84AVspPwOwoBZWDqCljlpgnr/jyvOPBdjcoG
         KqZ8XpIZYfYwI8Q0l9SLmdlHI5ymZlpCZ8JdFEGW4WWqkM+I8lcnX5s5ePqT/40kHT
         nLTbF1GyycZ/kScqfAQK89c7sKMNHhQrWhGe9gaW3hAojuOUqiDyZwpKvIVHmP+SO+
         dE0WkPv3f2cgSuTJ46sxqJqjD86RlbDTQG7nAL76IbYRpeQMST2J+bC1FWP9D/Cb42
         8AJTlzrzWxBBsT8oPOsYDf9smN/i6zBsa1+AQ4Rz5QbUBieBPw/5Q1TgJuPs9m9Rsw
         ZUzsCu8V7NzaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 606825C015D; Wed, 31 Aug 2022 11:21:13 -0700 (PDT)
Date:   Wed, 31 Aug 2022 11:21:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu
Subject: [PATCH nolibc 0/18] nolibc updates for v6.1
Message-ID: <20220831182113.GA2697286@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides nolibc updates for v6.1, most notably greatly
improved testing in tools/testing/selftests/nolibc.  See "make help"
for details.

1.	make argc 32-bit in riscv startup code, courtesy of Willy Tarreau.

2.	Optionally flush printk() buffers before powering off.

3.	Use the barrier operation specified by cur_ops, courtesy of
	Zqiang.

4.	fix build warning in sys_mmap() when my_syscall6 is not defined,
	courtesy of Willy Tarreau.

5.	make sys_mmap() automatically use the right __NR_mmap definition,
	courtesy of Willy Tarreau.

6.	add basic infrastructure to ease creation of nolibc tests,
	courtesy of Willy Tarreau.

7.	support a test definition format, courtesy of Willy Tarreau.

8.	implement a few tests for various syscalls, courtesy of Willy
	Tarreau.

9.	add a few tests for some libc functions, courtesy of Willy
	Tarreau.

10.	exit with poweroff on success when getpid() == 1, courtesy of
	Willy Tarreau.

11.	on x86, support exiting with isa-debug-exit, courtesy of Willy
	Tarreau.

12.	recreate and populate /dev and /proc if missing, courtesy of
	Willy Tarreau.

13.	condition some tests on /proc existence, courtesy of Willy
	Tarreau.

14.	support glibc as well, courtesy of Willy Tarreau.

15.	add a "kernel" target to build the kernel with the initramfs,
	courtesy of Willy Tarreau.

16.	add a "defconfig" target, courtesy of Willy Tarreau.

17.	add a "run" target to start the kernel in QEMU, courtesy of
	Willy Tarreau.

18.	"sysroot" target installs a local copy of the sysroot, courtesy
	of Willy Tarreau.

19.	add a "help" target, courtesy of Willy Tarreau.

20.	Avoid generated files being committed, courtesy of Fernanda
	Ma'rouf.

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/admin-guide/kernel-parameters.txt |    6 
 b/MAINTAINERS                                     |    1 
 b/kernel/rcu/rcutorture.c                         |    4 
 b/kernel/torture.c                                |    7 
 b/tools/include/nolibc/arch-riscv.h               |    2 
 b/tools/include/nolibc/sys.h                      |    2 
 b/tools/testing/selftests/nolibc/.gitignore       |    4 
 b/tools/testing/selftests/nolibc/Makefile         |   43 ++
 b/tools/testing/selftests/nolibc/nolibc-test.c    |  395 ++++++++++++++++++++++
 tools/include/nolibc/sys.h                        |    2 
 tools/testing/selftests/nolibc/Makefile           |   98 +++++
 tools/testing/selftests/nolibc/nolibc-test.c      |  376 ++++++++++++++++++++
 12 files changed, 925 insertions(+), 15 deletions(-)
