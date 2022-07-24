Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F299A57F49D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 12:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbiGXKBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 06:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGXKB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 06:01:27 -0400
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A122E2BF6;
        Sun, 24 Jul 2022 03:01:24 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 26O9xidT023602;
        Sun, 24 Jul 2022 18:59:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 26O9xidT023602
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1658656785;
        bh=vhEx4tm3X3jEDXysOVG9LWt4eLcKVHqgLU/wUbtsLtc=;
        h=From:To:Cc:Subject:Date:From;
        b=t8J7Dhk+IHOopn7Weez4Qj2Z/hC0r9LM6GyQ0iHOWOacnqwTFAfbcHutm9eWxbFJb
         +bo2beDwZj7bXXo37Gz+4+1QjNlODLKxudc0LtKyJbaaInz45I+UpQ54yvnXYqB9cl
         wsDb7HlQPZSqh9HfZlqaDEagMwfTFHgkl4yZBE7jRh1KVRf7nTm/gJbp65Kz7JSQ9o
         Tcyy55hUTODmzmo8D679RDoTPSWjcdFzVJj5azA0jzi1//bmvoPm4BgPIZgLq8SGI5
         Xi33t6U1Y84fd25d0qq+F1E1j0O20wgPnxxJLChdFoSFQKa4hiv+QnrL60ktOVClWa
         v2FSCTJ+FH8ew==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] kbuild: add dtbs_prepare target
Date:   Sun, 24 Jul 2022 18:59:19 +0900
Message-Id: <20220724095919.436126-1-masahiroy@kernel.org>
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

Factor out the common prerequisites for DT compilation into the new
target, dtbs_prepare.

Add comments to explain why include/config/kernel.release is the
prerequisite. Our policy is that installation targets must not rebuild
anything in the tree. If 'make modules_install' is executed as root,
include/config/kernel.release may be owned by root.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes for v2:
 - rephase the comment more concise

 Makefile | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index dee707c98bbe..a2a030f41e65 100644
--- a/Makefile
+++ b/Makefile
@@ -1370,16 +1370,21 @@ endif
 
 ifneq ($(dtstree),)
 
-%.dtb: include/config/kernel.release scripts_dtc
+%.dtb: dtbs_prepare
 	$(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
 
-%.dtbo: include/config/kernel.release scripts_dtc
+%.dtbo: dtbs_prepare
 	$(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
 
-PHONY += dtbs dtbs_install dtbs_check
-dtbs: include/config/kernel.release scripts_dtc
+PHONY += dtbs dtbs_prepare dtbs_install dtbs_check
+dtbs: dtbs_prepare
 	$(Q)$(MAKE) $(build)=$(dtstree)
 
+# include/config/kernel.release is actually needed when installing DTBs because
+# INSTALL_DTBS_PATH contains $(KERNELRELEASE). However, we do not want to make
+# dtbs_install depend on it as dtbs_install may run as root.
+dtbs_prepare: include/config/kernel.release scripts_dtc
+
 ifneq ($(filter dtbs_check, $(MAKECMDGOALS)),)
 export CHECK_DTBS=y
 dtbs: dt_binding_check
-- 
2.34.1

