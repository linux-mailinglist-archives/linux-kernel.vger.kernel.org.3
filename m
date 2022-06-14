Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47F754A7C0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 06:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243293AbiFNEMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 00:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiFNEMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 00:12:21 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE56E1D0CE;
        Mon, 13 Jun 2022 21:12:17 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 25E4B3db031731;
        Tue, 14 Jun 2022 13:11:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 25E4B3db031731
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1655179864;
        bh=ZVkd16ycWmSMCRLUde5kxZbFgxzvusFJRN7ajd3LiMQ=;
        h=From:To:Cc:Subject:Date:From;
        b=OPpVQed8JKe0hkzF/YiUh/SWpvY8rpP7CmGWe9DtzH/pJasnYMujxWP7Mbys7zlTN
         IYz39aUQPBA9lymkUDuKTtfwgQenv19WBRfc4JTO/m/Hv1de034mGhrSnp/d9TZGiB
         PtkTPLLNTykSpa+/hv5edFVLhs/FDDyyfwGGCRwOJcKLvrBo9IkxJZ7XEoY7LD+xTX
         GEho+fPApDh/6eYrdMoAJwG0lXU16gpbs1oa1ghy/g7KAD0V61gUIBUqCziRIA1lMW
         tZURsbyeefk8GJcaMjZ8wC3soKylIMAWltt4+jx3DyTG/CMrjAWtq9wNb02idvl8NA
         +opb79PPutPpg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: remove sed command from cmd_ar_builtin
Date:   Tue, 14 Jun 2022 13:11:00 +0900
Message-Id: <20220614041100.1860067-1-masahiroy@kernel.org>
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

Replace a pipeline of echo and sed with printf to decrease process forks.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.build | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index cac070aee791..d69849133dad 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -358,9 +358,8 @@ $(subdir-modorder): $(obj)/%/modules.order: $(obj)/% ;
 
 quiet_cmd_ar_builtin = AR      $@
       cmd_ar_builtin = rm -f $@; \
-		echo $(patsubst $(obj)/%,%,$(real-prereqs)) | \
-		sed -E 's:([^ ]+):$(obj)/\1:g' | \
-		xargs $(AR) cDPrST $@
+	$(if $(real-prereqs), printf "$(obj)/%s " $(patsubst $(obj)/%,%,$(real-prereqs)), :) | \
+	xargs $(AR) cDPrST $@
 
 $(obj)/built-in.a: $(real-obj-y) FORCE
 	$(call if_changed,ar_builtin)
-- 
2.32.0

