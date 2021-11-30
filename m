Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFE14635F5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241922AbhK3OCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241867AbhK3OC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:02:29 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7C6C061746;
        Tue, 30 Nov 2021 05:59:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A24DBCE19E4;
        Tue, 30 Nov 2021 13:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A4AC53FC1;
        Tue, 30 Nov 2021 13:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638280743;
        bh=tdQPUdVcTsxUACtFJrMjBgTPOOpzMdMgvCMghNLdcr8=;
        h=Date:From:To:Cc:Subject:From;
        b=Uu6/esCmRVmicjdIHUBA6BbgYWqOUKQ/4SRBxGuG4vvbzPt9EXSyIo9SS5z3YKBcn
         C+dGAuXItzrtYzmPKm599lfnKiXKj3+O6m0525FH8pebGeq8ZdK4nd4Ujun6oudtuW
         0gnk2haT8K5/3A14tCiweO+XHnVDnw52da5Bxf5d2txwyPhu+XWLp0aCEZ4X12D5O6
         S2Y18zoe2jNXVgdlPp9rmrNzz4k3gfh77bZEDFfHkzFR4TzJwIvf5Hvme7fOIhzk8E
         Q1g9hdrT3onGYO320ER3l3X7kt2mbBUpVgcLM5BL74RnrfdgFE6Z+sJvA/7PMp0M6l
         Ic2o3syEwWivg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B2E9240002; Tue, 30 Nov 2021 10:26:17 -0300 (-03)
Date:   Tue, 30 Nov 2021 10:26:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jaroslav =?utf-8?B?xaBrYXJ2YWRh?= <jskarvad@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [FYI][PATCH 1/1] tools build: Remove needless libpython-version
 feature check that breaks test-all fast path
Message-ID: <YaYmeeC6CS2b8OSz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 66dfdff03d196e51 ("perf tools: Add Python 3 support") we don't use
the tools/build/feature/test-libpython-version.c version in any Makefile
feature check:

  $ find tools/ -type f | xargs grep feature-libpython-version
  $

The only place where this was used was removed in 66dfdff03d196e51:

  -        ifneq ($(feature-libpython-version), 1)
  -          $(warning Python 3 is not yet supported; please set)
  -          $(warning PYTHON and/or PYTHON_CONFIG appropriately.)
  -          $(warning If you also have Python 2 installed, then)
  -          $(warning try something like:)
  -          $(warning $(and ,))
  -          $(warning $(and ,)  make PYTHON=python2)
  -          $(warning $(and ,))
  -          $(warning Otherwise, disable Python support entirely:)
  -          $(warning $(and ,))
  -          $(warning $(and ,)  make NO_LIBPYTHON=1)
  -          $(warning $(and ,))
  -          $(error   $(and ,))
  -        else
  -          LDFLAGS += $(PYTHON_EMBED_LDFLAGS)
  -          EXTLIBS += $(PYTHON_EMBED_LIBADD)
  -          LANG_BINDINGS += $(obj-perf)python/perf.so
  -          $(call detected,CONFIG_LIBPYTHON)
  -        endif

And nowadays we either build with PYTHON=python3 or just install the
python3 devel packages and perf will build against it.

But the leftover feature-libpython-version check made the fast path
feature detection to break in all cases except when python2 devel files
were installed:

  $ rpm -qa | grep python.*devel
  python3-devel-3.9.7-1.fc34.x86_64
  $ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf ;
  $ make -C tools/perf O=/tmp/build/perf install-bin
  make: Entering directory '/var/home/acme/git/perf/tools/perf'
    BUILD:   Doing 'make -j32' parallel build
    HOSTCC  /tmp/build/perf/fixdep.o
  <SNIP>
  $ cat /tmp/build/perf/feature/test-all.make.output
  In file included from test-all.c:18:
  test-libpython-version.c:5:10: error: #error
      5 |         #error
        |          ^~~~~
  $ ldd ~/bin/perf | grep python
	libpython3.9.so.1.0 => /lib64/libpython3.9.so.1.0 (0x00007fda6dbcf000)
  $

As python3 is the norm these days, fix this by just removing the unused
feature-libpython-version feature check, making the test-all fast path
to work with the common case.

With this:

  $ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf ;
  $ make -C tools/perf O=/tmp/build/perf install-bin |& head
  make: Entering directory '/var/home/acme/git/perf/tools/perf'
    BUILD:   Doing 'make -j32' parallel build
    HOSTCC  /tmp/build/perf/fixdep.o
    HOSTLD  /tmp/build/perf/fixdep-in.o
    LINK    /tmp/build/perf/fixdep

  Auto-detecting system features:
  ...                         dwarf: [ on  ]
  ...            dwarf_getlocations: [ on  ]
  ...                         glibc: [ on  ]
  $ ldd ~/bin/perf | grep python
	libpython3.9.so.1.0 => /lib64/libpython3.9.so.1.0 (0x00007f58800b0000)
  $ cat /tmp/build/perf/feature/test-all.make.output
  $

Fixes: 66dfdff03d196e51 ("perf tools: Add Python 3 support")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jaroslav Škarvada <jskarvad@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature                 |  1 -
 tools/build/feature/Makefile                 |  4 ----
 tools/build/feature/test-all.c               |  5 -----
 tools/build/feature/test-libpython-version.c | 11 -----------
 tools/perf/Makefile.config                   |  2 --
 5 files changed, 23 deletions(-)
 delete mode 100644 tools/build/feature/test-libpython-version.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 45a9a59828c3c09d..ae61f464043a11fb 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -48,7 +48,6 @@ FEATURE_TESTS_BASIC :=                  \
         numa_num_possible_cpus          \
         libperl                         \
         libpython                       \
-        libpython-version               \
         libslang                        \
         libslang-include-subdir         \
         libtraceevent                   \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 0a3244ad967307ce..1480910c792e2cb3 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -32,7 +32,6 @@ FILES=                                          \
          test-numa_num_possible_cpus.bin        \
          test-libperl.bin                       \
          test-libpython.bin                     \
-         test-libpython-version.bin             \
          test-libslang.bin                      \
          test-libslang-include-subdir.bin       \
          test-libtraceevent.bin                 \
@@ -227,9 +226,6 @@ $(OUTPUT)test-libperl.bin:
 $(OUTPUT)test-libpython.bin:
 	$(BUILD) $(FLAGS_PYTHON_EMBED)
 
-$(OUTPUT)test-libpython-version.bin:
-	$(BUILD)
-
 $(OUTPUT)test-libbfd.bin:
 	$(BUILD) -DPACKAGE='"perf"' -lbfd -ldl
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 0b243ce842be3383..5ffafb967b6e4952 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -14,10 +14,6 @@
 # include "test-libpython.c"
 #undef main
 
-#define main main_test_libpython_version
-# include "test-libpython-version.c"
-#undef main
-
 #define main main_test_libperl
 # include "test-libperl.c"
 #undef main
@@ -177,7 +173,6 @@
 int main(int argc, char *argv[])
 {
 	main_test_libpython();
-	main_test_libpython_version();
 	main_test_libperl();
 	main_test_hello();
 	main_test_libelf();
diff --git a/tools/build/feature/test-libpython-version.c b/tools/build/feature/test-libpython-version.c
deleted file mode 100644
index 47714b942d4d35bf..0000000000000000
--- a/tools/build/feature/test-libpython-version.c
+++ /dev/null
@@ -1,11 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <Python.h>
-
-#if PY_VERSION_HEX >= 0x03000000
-	#error
-#endif
-
-int main(void)
-{
-	return 0;
-}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index afd144725a0bf766..3df74cf5651af9dd 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -271,8 +271,6 @@ endif
 
 FEATURE_CHECK_CFLAGS-libpython := $(PYTHON_EMBED_CCOPTS)
 FEATURE_CHECK_LDFLAGS-libpython := $(PYTHON_EMBED_LDOPTS)
-FEATURE_CHECK_CFLAGS-libpython-version := $(PYTHON_EMBED_CCOPTS)
-FEATURE_CHECK_LDFLAGS-libpython-version := $(PYTHON_EMBED_LDOPTS)
 
 FEATURE_CHECK_LDFLAGS-libaio = -lrt
 
-- 
2.31.1

