Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE77F5995AC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346780AbiHSG6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243232AbiHSG6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:58:31 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057A913D5D;
        Thu, 18 Aug 2022 23:58:18 -0700 (PDT)
Received: from grover.sesame ([133.106.49.178]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 27J6uUCP012757;
        Fri, 19 Aug 2022 15:56:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 27J6uUCP012757
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1660892196;
        bh=JKFoW0ol9y1fVwS1pROFaB3YGi1tPsHIYaMpxHnO61I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rRgAouaU74jlZAlDDqUnecfj0Os4Xdj9KELOPEeI0L/VecFDP5u9YfqKr8WDwsJNS
         ecK+LtvdMMDa2HP3jUK1cjSh/iMTvd1QOPFSqI6Ac9uDfPgBA48DYZ2sbU8dRDzoA9
         U/hB/0e/O6vmgSboc4pe3fvFHUIvWeY0QXHr4Jow95Gts+5AEof3igIxi4Vy+gT156
         hfBxf03yIsqX/30neGRcAccDwgxDwto7Npgzn8jJE6sYG96kdB8fCfP5Scuk+gNIDw
         pmEVs3rCzsFIZz6AcdAcIx88cZKVMmzs7WZKgzHHJQQc9vFTQHgSSd7l8k8NH9x1Mf
         y4qM3lv0O6F6Q==
X-Nifty-SrcIP: [133.106.49.178]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] kbuild: use bash as the default shell for Make and Kconfig
Date:   Fri, 19 Aug 2022 15:56:03 +0900
Message-Id: <20220819065604.295572-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220819065604.295572-1-masahiroy@kernel.org>
References: <20220819065604.295572-1-masahiroy@kernel.org>
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

GNU Make uses /bin/sh by default for running recipe lines and $(shell ),
and so does Kconfig for $(shell,...).

We are sometimes hit by subtle portability issues like [1] because the
code was only tested on systems where /bin/sh is a symlink to bash.

One way is to continue whack-a-mole game as somebody will eventually
notice that the code is not working on their build environments.

Another is a big hammer approach; force bash in the build system so that
it works in the same way for everyone. In fact, there exists such a
guideline that permits only Bash as the shell scripting language. [2]
The kbuild test robot also specifies SHELL=/bin/bash to eliminate the
shell portability issue.

This commit changes the shell for Make and Kconfig to bash. As the GNU
Make manual [3] says, the 'SHELL' is never set from the environment.
You cannot do 'export SHELL:=/bin/bash' to propagate it to sub-makes.
Instead, use MAKEOVERRIDES to make SHELL:=/bin/bash globally effective.

[1]: https://lore.kernel.org/all/20220804190320.262510-1-alexandre.belloni@bootlin.com/
[2]: https://google.github.io/styleguide/shellguide.html
[3]: https://www.gnu.org/software/make/manual/html_node/Choosing-the-Shell.html

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile                | 7 +++++++
 scripts/Kconfig.include | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/Makefile b/Makefile
index f09673b6c11d..cc01987560b3 100644
--- a/Makefile
+++ b/Makefile
@@ -36,6 +36,13 @@ __all:
 
 ifneq ($(sub_make_done),1)
 
+# Use /bin/bash for repices and $(shell ) invocations.
+SHELL := /bin/bash
+
+# Unlike the other variables, the 'SHELL' is never set from the environment.
+# Use MAKEOVERRIDES to pass 'SHELL' down to sub-makes.
+MAKEOVERRIDES += SHELL=$(SHELL)
+
 # Do not use make's built-in rules and variables
 # (this increases performance and avoids hard-to-debug behaviour)
 MAKEFLAGS += -rR
diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
index a0ccceb22cf8..d37b864ba1f2 100644
--- a/scripts/Kconfig.include
+++ b/scripts/Kconfig.include
@@ -1,6 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-only
 # Kconfig helper macros
 
+# Use /bin/bash to evaluate $(shell,) functions
+SHELL := /bin/bash
+
 # Convenient variables
 comma       := ,
 quote       := "
-- 
2.34.1

