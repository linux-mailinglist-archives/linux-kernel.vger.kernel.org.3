Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C334F6770
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239158AbiDFR35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238895AbiDFR3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:29:12 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D2639BD8C;
        Wed,  6 Apr 2022 08:31:42 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 236FUcaR017647;
        Thu, 7 Apr 2022 00:30:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 236FUcaR017647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649259040;
        bh=ZjLI+JlU2bV41qJ132mX31sa9fHjwtqOwYEH0MoaLug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HwKWHytb/6NOhlKUWo3ktzf0qSgbOIzHs0XdE40KePawNCjaYQcr/E3j79K19sAxi
         lNzL5XnbhtRn3Be9QzMacoDGrvMw+8vcV9vl1bY//3aozWeomBXjc1TA1tnjyzTwSF
         lua7dFcQ6ON4jAGhAXyub/UC3YZAZVMGlZnRN9AqjCA/OAEifO1iwf5c7km9iye0IV
         Oml2F/uru4fWLk4aNMl37QFbCTm6Bsq/+qON1vnPDeK+a3HD5LoXHmHqXOb+WAFoYO
         ac7klb5GGIwx3O1JtR/owTXiokeMn6NUQAXWxdj7YmkruN7B9b+E1tJcWq+kWcSHzF
         eECPVG3FNOpxA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 2/7] kbuild: make multi_depend work with targets in subdirectory
Date:   Thu,  7 Apr 2022 00:30:18 +0900
Message-Id: <20220406153023.500847-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220406153023.500847-1-masahiroy@kernel.org>
References: <20220406153023.500847-1-masahiroy@kernel.org>
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

Precisely speaking, when you get the stem of the path, you should use
$(patsubst $(obj)/%,%,...) instead of $(notdir ...).

I do not see this usecase, but if you create a composite object in a
subdirectory, the Makefile should look like this:

   obj-$(CONFIG_FOO) += dir/foo.o
   dir/foo-objs      := dir/foo1.o dir/foo2.o

The member objects should be assigned to dir/foo-objs instead of
foo-objs.

This syntax is more consistent with commit 54b8ae66ae1a ("kbuild:
change *FLAGS_<basetarget>.o to take the path relative to $(obj)").

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.lib | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index d56cda3c1e8a..0453a1904646 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -236,9 +236,9 @@ endif
 # Usage:
 #   $(call multi_depend, multi_used_targets, suffix_to_remove, suffix_to_add)
 define multi_depend
-$(foreach m, $(notdir $1), \
-	$(eval $(obj)/$m: \
-	$(addprefix $(obj)/, $(call suffix-search, $m, $2, $3))))
+$(foreach m, $1, \
+	$(eval $m: \
+	$(addprefix $(obj)/, $(call suffix-search, $(patsubst $(obj)/%,%,$m), $2, $3))))
 endef
 
 # Copy a file
-- 
2.32.0

