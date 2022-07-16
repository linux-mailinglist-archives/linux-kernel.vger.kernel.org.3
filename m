Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D93576C7F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 10:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiGPIHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 04:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGPIG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 04:06:58 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45C43DBF7;
        Sat, 16 Jul 2022 01:06:56 -0700 (PDT)
Received: from grover.sesame ([133.106.62.13]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 26G85cuH025507;
        Sat, 16 Jul 2022 17:05:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 26G85cuH025507
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1657958739;
        bh=Mish1EGS9OnRhZSErhkuI8lcWASUDHcpplqcuJEg0Yo=;
        h=From:To:Cc:Subject:Date:From;
        b=Bzx+XMKaxm97o5XUo6aMJRA8K/U3rT1KtcFSxBqphtBQfigNJJPOjbdno5i6U1BZ1
         bRJP14MWq4P6BQY/d6px4oAz3HmVlWGKLNPmEXUVl9fELse86XGvHKRPvD2nVGJpaT
         X4Ssg403z5UngUCg+MhW43RsiapxsZYWEjIsfwDvH8Xk+57kNF1GPE8oIMBn92gwjm
         Mt5EWpqHswFp0X3edZyibvgYYbatCkl6ozBuZM0+8AEYESD0GP0/xqRQOLiw7H0a6h
         wK5J0JKTfAGty3mWfC2QGXJRNFzGlbm2/c6lIoFn52akgCChd1uiuMkWLX6B1BUpGA
         aeHJYv8EJmLyA==
X-Nifty-SrcIP: [133.106.62.13]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: remove RCS_TAR_IGNORE
Date:   Sat, 16 Jul 2022 17:05:30 +0900
Message-Id: <20220716080530.119961-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts the 20-year-old commit [1], hard-coding '--exclude .git'
instead of '--exclude CVS'.

RCS_TAR_IGNORE is used for packaging the mainline kernel, so I cannot
imagine other version control systems would be used.

I keep RCS_FIND_IGNORE because it is used for external modules, e.g.
'make clean M=...', where git may not be used.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?id=c2dd03a9e2d8bf508f6b3d9ee327c37a928b3351

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile                 | 5 +----
 scripts/Makefile.package | 2 +-
 scripts/package/mkspec   | 2 +-
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 80b19675ae91..8b166766b4ef 100644
--- a/Makefile
+++ b/Makefile
@@ -552,13 +552,10 @@ export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL
 export PAHOLE_FLAGS
 
 # Files to ignore in find ... statements
-
+# (Take care of various version control systems for external modules?)
 export RCS_FIND_IGNORE := \( -name SCCS -o -name BitKeeper -o -name .svn -o    \
 			  -name CVS -o -name .pc -o -name .hg -o -name .git \) \
 			  -prune -o
-export RCS_TAR_IGNORE := --exclude SCCS --exclude BitKeeper --exclude .svn \
-			 --exclude CVS --exclude .pc --exclude .hg --exclude .git
-
 # ===========================================================================
 # Rules shared between *config targets and build targets
 
diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 5017f6b2da80..d9c91ebcf2bf 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -45,7 +45,7 @@ if test "$(objtree)" != "$(srctree)"; then \
 	false; \
 fi ; \
 $(srctree)/scripts/setlocalversion --save-scmversion; \
-tar -I $(KGZIP) -c $(RCS_TAR_IGNORE) -f $(2).tar.gz \
+tar -I $(KGZIP) -c --exclude=.git -f $(2).tar.gz \
 	--transform 's:^:$(2)/:S' $(TAR_CONTENT) $(3); \
 rm -f $(objtree)/.scmversion
 
diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index 54906174bda2..97efc85b845c 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -29,7 +29,7 @@ fi
 
 PROVIDES="$PROVIDES kernel-$KERNELRELEASE"
 __KERNELRELEASE=$(echo $KERNELRELEASE | sed -e "s/-/_/g")
-EXCLUDES="$RCS_TAR_IGNORE --exclude=*vmlinux* --exclude=*.mod \
+EXCLUDES="--exclude=.git --exclude=*vmlinux* --exclude=*.mod \
 --exclude=*.o --exclude=*.ko --exclude=*.cmd --exclude=Documentation \
 --exclude=.config.old --exclude=.missing-syscalls.d --exclude=*.s"
 
-- 
2.34.1

