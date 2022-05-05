Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759AA51B8F7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 09:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239618AbiEEHbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 03:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343953AbiEEHaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 03:30:12 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD42B48318;
        Thu,  5 May 2022 00:26:29 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2457Nenw019426;
        Thu, 5 May 2022 16:23:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2457Nenw019426
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651735437;
        bh=xE0zb58nWCbd4r50BnRJTvTiW15HyULrsFF3iZrvMeU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B+r/E+5aY2J1v1nIavEEf+kQi0g3HQwxBGWI1Y8L7Ku513rz2PBE0V88DpxH4ZH0i
         yBjE/9UE+sG2EQQ+f4CZzTQjHAuIRFEzd59wKFq4+LiwTFnCQu4d7aRkVMSVlHYQAZ
         QKazYDJHYXPO7cLgb1OHgCsOSs1EQHS1NEj4oJ1o6IasaqaHw9+3pQPWAsQlyTbSwP
         nDIMVpBvqyZdDv+yU7B0oMa6rqJtrPvygvC3tNzMmw0ozxeRSwvcOawdFFbV0sqpG3
         GBwSrJxJdu7o+jVAWrYYwEjayv+5CkO+qddYY5SPiDmXl6JBgee4tRIRQb+oHfiIa4
         hfajBXYt5RAqw==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Nicolas Schier a <nicolas@fjasle.eu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org,
        linux-s390@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v3 14/15] kbuild: make built-in.a rule robust against too long argument error
Date:   Thu,  5 May 2022 16:22:43 +0900
Message-Id: <20220505072244.1155033-15-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220505072244.1155033-1-masahiroy@kernel.org>
References: <20220505072244.1155033-1-masahiroy@kernel.org>
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

Kbuild runs at the top of objtree instead of changing the working
directory to subdirectories. I think this design is nice overall but
some commands have a scapability issue.

The build command of built-in.a is one of them whose length scales with:

    O(D * N)

Here, D is the length of the directory path (i.e. $(obj)/ prefix),
N is the number of objects in the Makefile, O() is the big O notation.

The deeper directory the Makefile directory is located, the more easily
it will hit the too long argument error.

We can make it better. Trim the $(obj)/ by Make's builtin function, and
restore it by a shell command (sed).

With this, the command length scales with:

    O(D + N)

In-tree modules still have some room to the limit (ARG_MAX=2097152),
but this is more future-proof for big modules in a deep directory.

For example, you can build i915 as builtin (CONFIG_DRM_I915=y) and
compare drivers/gpu/drm/i915/.built-in.a.cmd with/without this commit.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v2)

Changes in v2:
  - New patch

 scripts/Makefile.build | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 0436ff94800e..cea48762299c 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -370,7 +370,10 @@ $(subdir-modorder): $(obj)/%/modules.order: $(obj)/% ;
 #
 
 quiet_cmd_ar_builtin = AR      $@
-      cmd_ar_builtin = rm -f $@; $(AR) cDPrST $@ $(real-prereqs)
+      cmd_ar_builtin = rm -f $@; \
+		echo $(patsubst $(obj)/%,%,$(real-prereqs)) | \
+		sed -E 's:([^ ]+):$(obj)/\1:g' | \
+		xargs $(AR) cDPrST $@
 
 $(obj)/built-in.a: $(real-obj-y) FORCE
 	$(call if_changed,ar_builtin)
-- 
2.32.0

