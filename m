Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7912C584B0A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 07:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbiG2FWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 01:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiG2FWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 01:22:21 -0400
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493B267CB9;
        Thu, 28 Jul 2022 22:22:20 -0700 (PDT)
Received: from localhost.localdomain (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 26T5LJCu006733;
        Fri, 29 Jul 2022 14:21:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 26T5LJCu006733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1659072080;
        bh=Z0P0UChK7smLZx80YdiWUEzL+axjW8wGu0CBNDJ/tlM=;
        h=From:To:Cc:Subject:Date:From;
        b=mn+zyJ7/p0fuO+hgDztBbcD1ruHT35lxA2LTIVKV4Gj4ZTUWqoVh7qst6i/9Iiqhf
         dNH1JDTXgFzldonpnHLxztJrDEyuGZB90oDqEAQlL024PJfIE1BmJ9L61zZtdKRq/e
         UsCRSzbZzjdIx9ifLBiA9FQv5E+Ub3uoALz0IkCmn3R6m8nCPxyteSphoH+upd9Jz6
         Hz/lFHDDZBa6DC4+c1iZHL2oUsIf1nsrZafkNABKciBYepX/8mE8QOHN1vxci214AG
         cdP0l4rzokNlY2/QkWUR0iacRJkXZblK7sNXcTKHafKZq2IhCXVUNStYDDAOxS4tLP
         I8N2JKiQBqawQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: remove the dead code in cmd_mk_schema
Date:   Fri, 29 Jul 2022 14:21:12 +0900
Message-Id: <20220729052112.3235325-1-masahiroy@kernel.org>
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

Since commit 2783a7f56f99 ("dt-bindings: kbuild: Pass DT_SCHEMA_FILES to
dt-validate"), the processed schema takes all the YAML files.

Remove the dead code.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Documentation/devicetree/bindings/Makefile | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index c9953f86b19d..223df2a023fd 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -42,10 +42,8 @@ quiet_cmd_chk_bindings = CHKDT   $@
 
 quiet_cmd_mk_schema = SCHEMA  $@
       cmd_mk_schema = f=$$(mktemp) ; \
-                      $(if $(DT_MK_SCHEMA_FLAGS), \
-                           printf '%s\n' $(real-prereqs), \
-                           $(find_all_cmd)) > $$f ; \
-                      $(DT_MK_SCHEMA) -j $(DT_MK_SCHEMA_FLAGS) @$$f > $@ ; \
+		      $(find_all_cmd) > $$f ; \
+		      $(DT_MK_SCHEMA) -j @$$f > $@ ; \
 		      rm -f $$f
 
 define rule_chkdt
-- 
2.34.1

