Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3192D53F204
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 00:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbiFFWN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 18:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiFFWNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 18:13:51 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0459D6D1AD
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 15:13:48 -0700 (PDT)
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 256MDVYA022255;
        Tue, 7 Jun 2022 07:13:31 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Tue, 07 Jun 2022 07:13:31 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 256MDVQS022246
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 7 Jun 2022 07:13:31 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8af7aebf-61ae-f126-57fa-8ff358c1841e@I-love.SAKURA.ne.jp>
Date:   Tue, 7 Jun 2022 07:13:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: [PATCH v2] kbuild: fix build failure by scripts/check-local-export
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <62ba96a2-0a0c-ab8e-351d-398f31a880ae@I-love.SAKURA.ne.jp>
 <ce0b0a88-f8cb-ba9c-8a0e-1a818f8c50e0@I-love.SAKURA.ne.jp>
In-Reply-To: <ce0b0a88-f8cb-ba9c-8a0e-1a818f8c50e0@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/check-local-export fails with some versions of bash.

    CC      scripts/mod/empty.o
  ./scripts/check-local-export: line 54: wait: pid 17328 is not a child of this shell
  make[2]: *** [scripts/mod/empty.o] Error 127
  make[2]: *** Deleting file `scripts/mod/empty.o'
  make[1]: *** [prepare0] Error 2
  make: *** [__sub-make] Error 2

Avoid use of bash's built-in wait command, by saving the output from
nm command into a temporary variable.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: 31cb50b5590fe911 ("kbuild: check static EXPORT_SYMBOL* by script instead of modpost")
---
Changes in v2:
  llvm-nm can't use end-of-options argument, reported-by kernel test robot <lkp@intel.com>

 scripts/check-local-export | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/scripts/check-local-export b/scripts/check-local-export
index da745e2743b7..850abc150855 100755
--- a/scripts/check-local-export
+++ b/scripts/check-local-export
@@ -11,9 +11,20 @@ set -e
 declare -A symbol_types
 declare -a export_symbols
 
+function die
+{
+    echo "$1" >&2
+    exit 1
+}
+
 exit_code=0
 
-while read value type name
+# If there is no symbol in the object, ${NM} (both GNU nm and llvm-nm)
+# shows 'no symbols' diagnostic and exits with 0. Saving such line into
+# symbol_types is fine because export_symbols will remain empty.
+result=$(${NM} ${1} 2>&1) || die "${result}"
+
+echo "${result}" | while read value type name
 do
 	# Skip the line if the number of fields is less than 3.
 	#
@@ -37,21 +48,7 @@ do
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
2.18.4


