Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED4C51F097
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiEHTWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiEHTRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 15:17:47 -0400
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504EB12AFC;
        Sun,  8 May 2022 12:11:22 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 248J8qSY030019;
        Mon, 9 May 2022 04:09:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 248J8qSY030019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652036945;
        bh=tcr+72ZYpbdDhhd7b5O3qNkSWb92WQKtLNqtDxevyAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZpgxZTqZ2iu1LdA2g0S5JuNwurT0/yzlSN3HqWxP8xRpWBBRGJ9qLRy8FFFfphmw1
         DTzSxmkNZri7Ulg9bko1nDt1WH7PUyFLGRMN4axpGr+pjpl/0u79qrscDU7fvAKdki
         5mvme2nhZq5J/45SFhvMYxL8AGUgWGRucB57+Pq2mInVzkdXh8zs5m0XumLFzFsqfl
         s89GMqFMy2/hikiBt4U17i/XqCY96TPSt5CgiTU4ljC/VtfCKLhmfWUiRwaYJJWZds
         4V0BRaPasqlm/ggMDv3LbkVmoTKJ1/0woBqcQPr4h+9YFdLyzf9pPLcB5twdmwA9i3
         BFM4D5Xff24IA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules@vger.kernel.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v4 11/14] kbuild: make built-in.a rule robust against too long argument error
Date:   Mon,  9 May 2022 04:06:28 +0900
Message-Id: <20220508190631.2386038-12-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220508190631.2386038-1-masahiroy@kernel.org>
References: <20220508190631.2386038-1-masahiroy@kernel.org>
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
some commands have a scalability issue.

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
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---

(no changes since v2)

Changes in v2:
  - New patch

 scripts/Makefile.build | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index c2a173b3fd60..8f1a355df7aa 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -374,7 +374,10 @@ $(subdir-modorder): $(obj)/%/modules.order: $(obj)/% ;
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

