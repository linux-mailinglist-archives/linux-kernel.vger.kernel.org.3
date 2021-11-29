Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B39F461C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 18:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbhK2RGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 12:06:33 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51234 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhK2REa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 12:04:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89F14615D7;
        Mon, 29 Nov 2021 17:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B734C53FC7;
        Mon, 29 Nov 2021 17:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638205272;
        bh=ptC8NyT5DfcMR/qX2dnTn4fLGDCjkRgQFnE8IIO4UyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EzP392fLrFLu9xn/LrEznBvsk8+ukD+0jgB81pDEkK4HZGLYwv5GFaa32UgUdDszO
         rN2pnMYgfqJlSHBqTN6xH6BUAwthoONFKTp7WiFVN0z2nlDwva9MFbcqegntR6aNTH
         3+ibOY2s/zUhgDm6VC/YYOWolAmDGOjc2Osu0dlWLU0o0gAY5td81RW2lrNO9Hr0aB
         SIDUaFqdd0m5tPL3lESJzv47O1hn8ITfsMASB03ZZT5mkEkA0sqrkVXioXPUuzC+Fm
         q/0fuYmcWJmRb+c60wYIYdtIIirTcPrt4pRAewiHs6Fw8Bf3js6iRh17nNaD6V5nzn
         pgShxxJxyRw/w==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Tom Stellard <tstellar@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>, cki-project@redhat.com,
        kernelci@groups.io, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH RFC 1/6] Documentation: Raise the minimum supported version of LLVM to 11.0.0
Date:   Mon, 29 Nov 2021 09:57:58 -0700
Message-Id: <20211129165803.470795-2-nathan@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211129165803.470795-1-nathan@kernel.org>
References: <20211129165803.470795-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LLVM versions prior to 11.0.0 have a harder time with dead code
elimination, which can cause issues with commonly used expressions such
as BUILD_BUG_ON and the bitmask functions/macros in bitfield.h (see the
first two issues links below).

Whenever there is an issue within LLVM that has been resolved in a later
release, the only course of action is to gate the problematic
configuration or source code on the toolchain verson or raise the
minimum supported version of LLVM for building the kernel, as LLVM has a
limited support lifetime compared to GCC. GCC major releases will
typically see a few point releases across a two year period on average
whereas LLVM major releases are only supported until the next major
release and will only see one or two point releases within that
timeframe. For example, GCC 8.1 was released in May 2018 and GCC 8.5 was
released in May 2021, whereas LLVM 12.0.0 was released in April 2021 and
its only point release, 12.0.1, was released in July 2021, giving a
minimal window for fixes to be backported.

To resolve these build errors around improper dead code elimination,
raise the minimum supported version of LLVM for building the kernel to
11.0.0. Doing so is a more proper solution than mucking around with core
kernel macros that have always worked with GCC or disabling drivers for
using these macros in a proper manner. This type of issue may continue
to crop up and require patching, which creates more debt for bumping the
minimum supported version in the future.

This should have a minimal impact to distributions. Using a script to
pull several different Docker images and check the output of
'clang --version':

archlinux:latest: clang version 13.0.0

debian:oldoldstable-slim: clang version 3.8.1-24 (tags/RELEASE_381/final)
debian:oldstable-slim: clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)
debian:stable-slim: Debian clang version 11.0.1-2
debian:testing-slim: Debian clang version 11.1.0-4
debian:unstable-slim: Debian clang version 11.1.0-4

fedora:34: clang version 12.0.1 (Fedora 12.0.1-1.fc34)
fedora:latest: clang version 13.0.0 (Fedora 13.0.0-3.fc35)
fedora:rawhide: clang version 13.0.0 (Fedora 13.0.0-5.fc36)

opensuse/leap:15.2: clang version 9.0.1
opensuse/leap:latest: clang version 11.0.1
opensuse/tumbleweed:latest: clang version 13.0.0

ubuntu:bionic: clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
ubuntu:latest: clang version 10.0.0-4ubuntu1
ubuntu:hirsute: Ubuntu clang version 12.0.0-3ubuntu1~21.04.2
ubuntu:rolling: Ubuntu clang version 13.0.0-2
ubuntu:devel: Ubuntu clang version 13.0.0-9

In every case, the distribution's version of clang is either older than
the current minimum supported version of LLVM 10.0.1 or equal to or
greater than the proposed 11.0.0 so nothing should change.

Another benefit of this change is LLVM=1 works better with arm64 and
x86_64 since commit f12b034afeb3 ("scripts/Makefile.clang: default to
LLVM_IAS=1") enabled the integrated assembler by default, which only
works well with clang 11+ (clang-10 required it to be disabled to
successfully build a kernel).

Link: https://github.com/ClangBuiltLinux/linux/issues/1293
Link: https://github.com/ClangBuiltLinux/linux/issues/1506
Link: https://github.com/ClangBuiltLinux/linux/issues/1511
Link: https://github.com/llvm/llvm-project/commit/fa496ce3c6774097080c8a9cb808da56f383b938
Link: https://groups.google.com/g/clang-built-linux/c/mPQb9_ZWW0s/m/W7o6S-QTBAAJ
Link: https://github.com/ClangBuiltLinux/misc-scripts
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 Documentation/process/changes.rst | 2 +-
 scripts/min-tool-version.sh       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index b398b8576417..17182b537141 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -30,7 +30,7 @@ you probably needn't concern yourself with pcmciautils.
         Program        Minimal version       Command to check the version
 ====================== ===============  ========================================
 GNU C                  5.1              gcc --version
-Clang/LLVM (optional)  10.0.1           clang --version
+Clang/LLVM (optional)  11.0.0           clang --version
 GNU make               3.81             make --version
 binutils               2.23             ld -v
 flex                   2.5.35           flex --version
diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index 4edc708baa63..7c20252a90c6 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -28,7 +28,7 @@ llvm)
 	if [ "$SRCARCH" = s390 ]; then
 		echo 13.0.0
 	else
-		echo 10.0.1
+		echo 11.0.0
 	fi
 	;;
 *)
-- 
2.34.1

