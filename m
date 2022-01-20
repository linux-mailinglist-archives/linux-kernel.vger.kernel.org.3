Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D70495027
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 15:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347732AbiATObI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 09:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345897AbiATObH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 09:31:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E60C061574;
        Thu, 20 Jan 2022 06:31:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8412C61781;
        Thu, 20 Jan 2022 14:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967F1C340E5;
        Thu, 20 Jan 2022 14:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642689064;
        bh=NShk8RaJDMXxjgVwj9BZLOszW8jcivZ7vAl+s4zqy2M=;
        h=Date:From:To:Cc:Subject:From;
        b=uaI6ZB/bBbm1jH1gtP5MVuSGxXrH/JfmJRN1zv2Qm/pCxmJjQIiFn2tm09aBTRLM+
         fCU3BQBk5ro4UZKNOtM2b0S3+LZ3BuWmbVQ1x1AwFTdsenJtYyeztEr6CGa9oPNmV8
         CpKYgSdsA3gFPs5a4zXDqfjEO/8srsVhAwTozJ/O50gNzP14bGf2dtHg6M3pZb0NWo
         Ew/Zyx46T/Vp0ivgx+CJrsqeSsXAPFDr23EVvfcMAY3PO9fJ98zxkVqQLS7b8vv0q4
         TIdFk3G7dpRrhy0jAbLhzGcmLExy0hUSTRbS+JQESC4i2ikqoEyiQrQ9i1qHjA0QqS
         QZgrg4PzEn/3Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 60C6040714; Thu, 20 Jan 2022 11:31:01 -0300 (-03)
Date:   Thu, 20 Jan 2022 11:31:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1 FYI] tools headers UAPI: Sync files changed by new
 set_mempolicy_home_node syscall
Message-ID: <YelyJcmhLKY/LlBR@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To pick the changes in these csets:

  21b084fdf2a49ca1 ("mm/mempolicy: wire up syscall set_mempolicy_home_node")

That add support for this new syscall in tools such as 'perf trace'.

For instance, this is now possible:

  [root@five ~]# perf trace -e set_mempolicy_home_node
  ^C[root@five ~]#
  [root@five ~]# perf trace -v -e set_mempolicy_home_node
  Using CPUID AuthenticAMD-25-21-0
  event qualifier tracepoint filter: (common_pid != 253729 && common_pid != 3585) && (id == 450)
  mmap size 528384B
  ^C[root@five ~]
  [root@five ~]# perf trace -v -e set*  --max-events 5
  Using CPUID AuthenticAMD-25-21-0
  event qualifier tracepoint filter: (common_pid != 253734 && common_pid != 3585) && (id == 38 || id == 54 || id == 105 || id == 106 || id == 109 || id == 112 || id == 113 || id == 114 || id == 116 || id == 117 || id == 119 || id == 122 || id == 123 || id == 141 || id == 160 || id == 164 || id == 170 || id == 171 || id == 188 || id == 205 || id == 218 || id == 238 || id == 273 || id == 308 || id == 450)
  mmap size 528384B
       0.000 ( 0.008 ms): bash/253735 setpgid(pid: 253735 (bash), pgid: 253735 (bash))      = 0
    6849.011 ( 0.008 ms): bash/16046 setpgid(pid: 253736 (bash), pgid: 253736 (bash))       = 0
    6849.080 ( 0.005 ms): bash/253736 setpgid(pid: 253736 (bash), pgid: 253736 (bash))      = 0
    7437.718 ( 0.009 ms): gnome-shell/253737 set_robust_list(head: 0x7f34b527e920, len: 24) = 0
   13445.986 ( 0.010 ms): bash/16046 setpgid(pid: 253738 (bash), pgid: 253738 (bash))       = 0
  [root@five ~]#

That is the filter expression attached to the raw_syscalls:sys_{enter,exit}
tracepoints.

  $ find tools/perf/arch/ -name "syscall*tbl" | xargs grep -w set_mempolicy_home_node
  tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl:450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
  tools/perf/arch/powerpc/entry/syscalls/syscall.tbl:450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
  tools/perf/arch/s390/entry/syscalls/syscall.tbl:450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
  tools/perf/arch/x86/entry/syscalls/syscall_64.tbl:450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
  $

  $ grep -w set_mempolicy_home_node /tmp/build/perf/arch/x86/include/generated/asm/syscalls_64.c
	[450] = "set_mempolicy_home_node",
  $

This addresses these perf build warnings:

  Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/unistd.h' differs from latest version at 'include/uapi/asm-generic/unistd.h'
  diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h
  Warning: Kernel ABI header at 'tools/perf/arch/x86/entry/syscalls/syscall_64.tbl' differs from latest version at 'arch/x86/entry/syscalls/syscall_64.tbl'
  diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
  Warning: Kernel ABI header at 'tools/perf/arch/powerpc/entry/syscalls/syscall.tbl' differs from latest version at 'arch/powerpc/kernel/syscalls/syscall.tbl'
  diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc/kernel/syscalls/syscall.tbl
  Warning: Kernel ABI header at 'tools/perf/arch/s390/entry/syscalls/syscall.tbl' differs from latest version at 'arch/s390/kernel/syscalls/syscall.tbl'
  diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl
  Warning: Kernel ABI header at 'tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl' differs from latest version at 'arch/mips/kernel/syscalls/syscall_n64.tbl'
  diff -u tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl arch/mips/kernel/syscalls/syscall_n64.tbl

Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/asm-generic/unistd.h             | 5 ++++-
 tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl | 1 +
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl  | 1 +
 tools/perf/arch/s390/entry/syscalls/syscall.tbl     | 1 +
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl   | 1 +
 5 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 4557a8b6086f4ffe..1c48b0ae3ba30229 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -883,8 +883,11 @@ __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
 #define __NR_futex_waitv 449
 __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 
+#define __NR_set_mempolicy_home_node 450
+__SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
+
 #undef __NR_syscalls
-#define __NR_syscalls 450
+#define __NR_syscalls 451
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
index e2c481fcede6bd11..3f1886ad9d8060b4 100644
--- a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
+++ b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
@@ -364,3 +364,4 @@
 # 447 reserved for memfd_secret
 448	n64	process_mrelease		sys_process_mrelease
 449	n64	futex_waitv			sys_futex_waitv
+450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index 15109af9d0754d5f..2600b4237292c78c 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -529,3 +529,4 @@
 # 447 reserved for memfd_secret
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
+450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index ed9c5c2eafad700c..799147658dee20dd 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -452,3 +452,4 @@
 # 447 reserved for memfd_secret
 448  common	process_mrelease	sys_process_mrelease		sys_process_mrelease
 449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
+450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index fe8f8dd157b4d49c..c84d12608cd2de9e 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -371,6 +371,7 @@
 447	common	memfd_secret		sys_memfd_secret
 448	common	process_mrelease	sys_process_mrelease
 449	common	futex_waitv		sys_futex_waitv
+450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
-- 
2.34.1

