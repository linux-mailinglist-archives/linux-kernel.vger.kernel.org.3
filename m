Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EA35403FC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345141AbiFGQma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345139AbiFGQm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:42:28 -0400
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9CA21826;
        Tue,  7 Jun 2022 09:42:25 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 257Ge4L0032527;
        Wed, 8 Jun 2022 01:40:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 257Ge4L0032527
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654620005;
        bh=KIQsPoYwJl2iHAlLQ3N6FDhBbmcoJ7MxPCwB4wOjf9k=;
        h=From:To:Cc:Subject:Date:From;
        b=Yk7vi2La1zL4Tvi/uHEi9Ftav84vUtcysbVtd4AYUTjaQPRTS5/EuHa9qKhI7ip4U
         effPPofbrLiBTmdtoGW33Gt5nFEBmSXMjy0cegNqMhC2CF6yHb2w4JSwv8yR/PQy2i
         mQu9IdjtkNhlnJv+PiOukZGTOoSMDjlfO+toKa1Kc2ebi4Vwi8KNkqfy9tTMUe3+eu
         WEhZ03vfegdMEDki/5daPNjuEiFJWsDpwxIoy4Tqn9MIXVDyjAipReKy3icpzZf/lJ
         lfWYb8P++4EgFMGiO5XIz2gh4TsGngsJQrfzcRXpXlcKTZrneHNE77y6UjC7v0ozRQ
         OpdZ78+/YGF+A==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH v2] scripts/check-local-export: avoid 'wait $!' for process substitution
Date:   Wed,  8 Jun 2022 01:40:00 +0900
Message-Id: <20220607164000.447941-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bash>=4.4 supports 'wait $!' to check the exit status of a process
substitution, but some people using older bash versions reported an
error like this:

  ./scripts/check-local-export: line 54: wait: pid 17328 is not a child of this shell

I used the process substitution because a pipeline executes each command
in a subshell; variables modified within the while-loop in the subshell
context would be lost after the subshell terminates.

Fortunately, Bash>=4.2 supports the 'lastpipe' option, which runs the
last element of a pipeline in the current shell process.

Also, set 'pipefail' to catch errors from ${NM}.

Bash 4.2, released in 2011, is 5 years older than Bash 4.4.

Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Reported-by: Wang Yugui <wangyugui@e16-tech.com>
Tested-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Add bash to Documentation/process/changes.rst

 Documentation/process/changes.rst | 12 +++++++++++
 scripts/check-local-export        | 35 ++++++++++++++++++-------------
 2 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 34415ae1af1b..19c286c23786 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -32,6 +32,7 @@ you probably needn't concern yourself with pcmciautils.
 GNU C                  5.1              gcc --version
 Clang/LLVM (optional)  11.0.0           clang --version
 GNU make               3.81             make --version
+bash                   4.2              bash --version
 binutils               2.23             ld -v
 flex                   2.5.35           flex --version
 bison                  2.0              bison --version
@@ -84,6 +85,12 @@ Make
 
 You will need GNU make 3.81 or later to build the kernel.
 
+Bash
+----
+
+Some bash scripts are used for the kernel build.
+Bash 4.2 or newer is needed.
+
 Binutils
 --------
 
@@ -362,6 +369,11 @@ Make
 
 - <ftp://ftp.gnu.org/gnu/make/>
 
+Bash
+----
+
+- <ftp://ftp.gnu.org/gnu/bash/>
+
 Binutils
 --------
 
diff --git a/scripts/check-local-export b/scripts/check-local-export
index da745e2743b7..e21c7b54885d 100755
--- a/scripts/check-local-export
+++ b/scripts/check-local-export
@@ -8,11 +8,30 @@
 
 set -e
 
+# catch errors from ${NM}
+set -o pipefail
+
+# Run the last element of a pipeline in the current shell.
+# Without this, the while-loop would be executed in a subshell, and
+# the changes made to 'symbol_types' and 'export_symbols' would be lost.
+shopt -s lastpipe
+
 declare -A symbol_types
 declare -a export_symbols
 
 exit_code=0
 
+# If there is no symbol in the object, ${NM} (both GNU nm and llvm-nm) shows
+# 'no symbols' diagnostic (but exits with 0). It is harmless and hidden by
+# '2>/dev/null'. However, it suppresses real error messages as well. Add a
+# hand-crafted error message here.
+#
+# Use --quiet instead of 2>/dev/null when we upgrade the minimum version of
+# binutils to 2.37, llvm to 13.0.0.
+#
+# Then, the following line will be really simple:
+#   ${NM} --quiet ${1} |
+{ ${NM} ${1} 2>/dev/null || { echo "${0}: ${NM} failed" >&2; false; } } |
 while read value type name
 do
 	# Skip the line if the number of fields is less than 3.
@@ -37,21 +56,7 @@ do
 	if [[ ${name} == __ksymtab_* ]]; then
 		export_symbols+=(${name#__ksymtab_})
 	fi
-
-	# If there is no symbol in the object, ${NM} (both GNU nm and llvm-nm)
-	# shows 'no symbols' diagnostic (but exits with 0). It is harmless and
-	# hidden by '2>/dev/null'. However, it suppresses real error messages
-	# as well. Add a hand-crafted error message here.
-	#
-	# Use --quiet instead of 2>/dev/null when we upgrade the minimum version
-	# of binutils to 2.37, llvm to 13.0.0.
-	#
-	# Then, the following line will be really simple:
-	#   done < <(${NM} --quiet ${1})
-done < <(${NM} ${1} 2>/dev/null || { echo "${0}: ${NM} failed" >&2; false; } )
-
-# Catch error in the process substitution
-wait $!
+done
 
 for name in "${export_symbols[@]}"
 do
-- 
2.32.0

