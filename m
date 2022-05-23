Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFA0531835
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242195AbiEWSo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243931AbiEWSo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 14:44:29 -0400
Received: from condef-04.nifty.com (condef-04.nifty.com [202.248.20.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E97A005B;
        Mon, 23 May 2022 11:27:50 -0700 (PDT)
Received: from conuserg-08.nifty.com ([10.126.8.71])by condef-04.nifty.com with ESMTP id 24NIHJs9012196;
        Tue, 24 May 2022 03:17:19 +0900
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 24NIFrRV027961;
        Tue, 24 May 2022 03:15:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 24NIFrRV027961
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653329753;
        bh=TFguQGsfBK4SLEoyVpZA3IDbS9toCuPJd055UxlIv6c=;
        h=From:To:Cc:Subject:Date:From;
        b=rq3y5P4Hn2OX7VgbbiOSIra6Ou9TkSO4f6p4mMJM+p4Mi0WJdutYUQzNRQISYtx7X
         /fZo8gNxfUZyrc8yGnpI/dEwvhiuJPd3/lXBdnpSAl/sja1S5A8wbuB7rTkIXZaIIr
         edPhoSD7YmWgIwvdhvdCFIUAHNwqq6brNe8BI88QgDaMKCzZsyJKoNLVvuWUGSSxJC
         pfniO6OBmtMRm4PWgR5gkMKo0F7or1EbgD2YbO2Usn3nZ0G+h8y/Bfu6xvjRrpXFjF
         +gnk90c/7xrBQxhwqofgUh2pkLT/J0trYQCp/HY6bkHkz/6AVpeolaeKNvVtl+UMb/
         lRDy4nxc+HS5w==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] kbuild: replace $(if A,A,B) with $(or A,B) in scripts/Makefile.modpost
Date:   Tue, 24 May 2022 03:15:03 +0900
Message-Id: <20220523181503.1007987-1-masahiroy@kernel.org>
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

Similar cleanup to commit 5c8166419acf ("kbuild: replace $(if A,A,B)
with $(or A,B)").

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.modpost | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 7c3899182a4a..911606496341 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -84,7 +84,7 @@ obj := $(KBUILD_EXTMOD)
 src := $(obj)
 
 # Include the module's Makefile to find KBUILD_EXTRA_SYMBOLS
-include $(if $(wildcard $(src)/Kbuild), $(src)/Kbuild, $(src)/Makefile)
+include $(or $(wildcard $(src)/Kbuild), $(src)/Makefile)
 
 # modpost option for external modules
 MODPOST += -e
-- 
2.32.0

