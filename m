Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E5154A8EC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 07:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242742AbiFNFxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 01:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbiFNFxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 01:53:51 -0400
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A341D311;
        Mon, 13 Jun 2022 22:53:49 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 25E5qNim019312;
        Tue, 14 Jun 2022 14:52:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 25E5qNim019312
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1655185943;
        bh=JjvmcElNPYiIuoDQ6WQQO7xgfdH+JttvtH56H6zA87U=;
        h=From:To:Cc:Subject:Date:From;
        b=q/lihoFxy7Qb/WR5tZDIEDAx5biV5XbRsOVnjZiJk+cSu8IbrnVXypbuG0snPl9VJ
         +DnQamGqI88D5y6vnMBpMqsxesMwtII/vGPfPjDGf9DSCRiBprmJKarB8zG1dwDG9P
         1B6eJE6qxa1wvgNr2h/4tIuGihZAmHJhJEsZLGDrIsL3SHEnSXrdwUBMiYsDFPGZqZ
         DOhnMLh5y8bmwB9Ud8eW7JQrsWaOHA0cfXQQu4vgYdw4GwL4AEFVjgeyWCc98Mka/6
         oioEUab+C8em/lyPbJ56OR2nMOUm5rUIKC0ryY5g2n2q+770ADH/dHZ/mGaY/KivFu
         G0bsdEYQTzs8A==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] kbuild: remove sed command from cmd_ar_builtin
Date:   Tue, 14 Jun 2022 14:51:49 +0900
Message-Id: <20220614055149.1900535-1-masahiroy@kernel.org>
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

Changes in v2:
  - Avoid the pipeline if there is no object to put in the archive

 scripts/Makefile.build | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index cac070aee791..784f46d41959 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -358,9 +358,8 @@ $(subdir-modorder): $(obj)/%/modules.order: $(obj)/% ;
 
 quiet_cmd_ar_builtin = AR      $@
       cmd_ar_builtin = rm -f $@; \
-		echo $(patsubst $(obj)/%,%,$(real-prereqs)) | \
-		sed -E 's:([^ ]+):$(obj)/\1:g' | \
-		xargs $(AR) cDPrST $@
+	$(if $(real-prereqs), printf "$(obj)/%s " $(patsubst $(obj)/%,%,$(real-prereqs)) | xargs) \
+	$(AR) cDPrST $@
 
 $(obj)/built-in.a: $(real-obj-y) FORCE
 	$(call if_changed,ar_builtin)
-- 
2.32.0

