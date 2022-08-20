Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E7A59ACD0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 11:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344120AbiHTJRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 05:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245610AbiHTJR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 05:17:28 -0400
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2600EB4430;
        Sat, 20 Aug 2022 02:17:27 -0700 (PDT)
Received: from grover.sesame (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 27K9FiMT016772;
        Sat, 20 Aug 2022 18:15:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 27K9FiMT016772
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1660986945;
        bh=glgIgnJUMeQe50tvir8Ek5DaeBa3aOrLyRwpvBGrA5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fNAywnC3zXjmIR5Unupj1THTqtQHOnJZgWWx3h0dO5BK5TtQy4DMt1Ib+dcjVFIsF
         ZjF/5TrIDby4TGaCMMD7eSelhn0Y7UxpOw03rdp/RryDnthOCoq71En1ozM449U+2e
         8QOqGQa7+YKmotEjN8wuWbpyxyawhKjz2XfRwfWpvVovNKJdEIcZnrquwePHPu6jUQ
         SXbUfuAZ4/Uwyd4Sc0VEVgaNUSgJxx6x4uM5h6k7o014HZ/Mg+HrGlcGO9KNTajiRi
         EcCqMx0zxIUzQTUZ94KtR+3eokQxeF75T94j0mI2g1BdDB4sB56s1hFNJjpw0YhBvO
         vW7pLFSw3FULw==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] kbuild: check sha1sum just once for each atomic header
Date:   Sat, 20 Aug 2022 18:15:29 +0900
Message-Id: <20220820091531.682096-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220820091531.682096-1-masahiroy@kernel.org>
References: <20220820091531.682096-1-masahiroy@kernel.org>
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

It is unneeded to check the sha1sum every time.

Create the timestamp files to manage it.

Add '.' to vmlinux-alldirs because 'make clean' must visit ./Kbuild
to clean up the timestamp files.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Kbuild                          | 33 ++++++++++++++++++++++++---------
 Makefile                        |  2 +-
 scripts/atomic/check-atomics.sh | 33 ---------------------------------
 3 files changed, 25 insertions(+), 43 deletions(-)
 delete mode 100755 scripts/atomic/check-atomics.sh

diff --git a/Kbuild b/Kbuild
index e122d93cee32..0b9e8a16a621 100644
--- a/Kbuild
+++ b/Kbuild
@@ -43,17 +43,32 @@ PHONY += missing-syscalls
 missing-syscalls: scripts/checksyscalls.sh $(offsets-file)
 	$(call cmd,syscalls)
 
-# Check atomic headers are up-to-date
-
-quiet_cmd_atomics = CALL    $<
-      cmd_atomics = $(CONFIG_SHELL) $<
-
-PHONY += old-atomics
-old-atomics: scripts/atomic/check-atomics.sh
-	$(call cmd,atomics)
+# Check the manual modification of atomic headers
+
+quiet_cmd_check_sha1 = CHKSHA1 $<
+      cmd_check_sha1 = \
+	if ! command -v sha1sum >/dev/null; then \
+		echo "warning: cannot check the header due to sha1sum missing"; \
+		exit 0; \
+	fi; \
+	if [ "$$(sed -n '$$s:// ::p' $<)" != \
+	     "$$(sed '$$d' $< | sha1sum | sed 's/ .*//')" ]; then \
+		echo "error: $< has been modified." >&2; \
+		exit 1; \
+	fi; \
+	touch $@
+
+atomic-checks += $(addprefix $(obj)/.checked-, \
+	  atomic-arch-fallback.h \
+	  atomic-instrumented.h \
+	  atomic-long.h)
+
+targets += $(atomic-checks)
+$(atomic-checks): $(obj)/.checked-%: include/linux/atomic/%  FORCE
+	$(call if_changed,check_sha1)
 
 # A phony target that depends on all the preparation targets
 
 PHONY += prepare
-prepare: $(offsets-file) missing-syscalls old-atomics
+prepare: $(offsets-file) missing-syscalls $(atomic-checks)
 	@:
diff --git a/Makefile b/Makefile
index 4fcced0d3907..d8ca0738b9e1 100644
--- a/Makefile
+++ b/Makefile
@@ -1109,7 +1109,7 @@ vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
 		     $(libs-y) $(libs-m)))
 
-vmlinux-alldirs	:= $(sort $(vmlinux-dirs) Documentation \
+vmlinux-alldirs	:= $(sort $(vmlinux-dirs) Documentation . \
 		     $(patsubst %/,%,$(filter %/, $(core-) \
 			$(drivers-) $(libs-))))
 
diff --git a/scripts/atomic/check-atomics.sh b/scripts/atomic/check-atomics.sh
deleted file mode 100755
index 0e7bab3eb0d1..000000000000
--- a/scripts/atomic/check-atomics.sh
+++ /dev/null
@@ -1,33 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-#
-# Check if atomic headers are up-to-date
-
-ATOMICDIR=$(dirname $0)
-ATOMICTBL=${ATOMICDIR}/atomics.tbl
-LINUXDIR=${ATOMICDIR}/../..
-
-echo '' | sha1sum - > /dev/null 2>&1
-if [ $? -ne 0 ]; then
-	printf "sha1sum not available, skipping atomic header checks.\n"
-	exit 0
-fi
-
-cat <<EOF |
-linux/atomic/atomic-instrumented.h
-linux/atomic/atomic-long.h
-linux/atomic/atomic-arch-fallback.h
-EOF
-while read header; do
-	OLDSUM="$(tail -n 1 ${LINUXDIR}/include/${header})"
-	OLDSUM="${OLDSUM#// }"
-
-	NEWSUM="$(sed '$d' ${LINUXDIR}/include/${header} | sha1sum)"
-	NEWSUM="${NEWSUM%% *}"
-
-	if [ "${OLDSUM}" != "${NEWSUM}" ]; then
-		printf "warning: generated include/${header} has been modified.\n"
-	fi
-done
-
-exit 0
-- 
2.34.1

