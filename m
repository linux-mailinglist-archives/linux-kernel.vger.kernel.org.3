Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8216A516317
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344500AbiEAIrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343579AbiEAIpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:45:54 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC9C4C7B0;
        Sun,  1 May 2022 01:42:26 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2418f2SA008518;
        Sun, 1 May 2022 17:41:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2418f2SA008518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651394477;
        bh=kOdm8XJObGrzROhInSotD5M5BpTpdOvAu4T0ZW1QDx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f1ymieQguz01joSJj4vR2EqzXjYW0KMGnGJ3/uAbFFmhKGkAmXJ0b8mQPxOQUwqGA
         rSQWoKaUaiVrf+fTdynKkckB4WneGGBuD23BgZts5YjgNgrQzXLg72zN5aCvusaG05
         fjz3p/u7ynC0qjY050rjC1YZJLjyXZeK3TbbsxPYv6Eoc9kelv+9GYx5TMKRJojPNC
         ohHvK0RZMeU4ZE8N5xSDWIA7aaWpzRCYfZ3Df8d3p7BR7Q0OUWbtGwMfcPuABq92ax
         28uCwSQeikbdpn+qwHgRSBQak6VAiTy0ks/ashmBehzokVtkAlsrRM/KT2b8rIEy19
         t5m5sRF3ztuRA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2 23/26] kbuild: make built-in.a rule robust against too long argument error
Date:   Sun,  1 May 2022 17:40:29 +0900
Message-Id: <20220501084032.1025918-24-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220501084032.1025918-1-masahiroy@kernel.org>
References: <20220501084032.1025918-1-masahiroy@kernel.org>
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

Changes in v2:
  - New patch

 scripts/Makefile.build | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index cc8f362f58e2..a9236add4864 100644
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

