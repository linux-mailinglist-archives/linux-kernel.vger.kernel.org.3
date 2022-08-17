Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782855972D6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240371AbiHQPV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 11:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiHQPV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 11:21:27 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F159D6BD49;
        Wed, 17 Aug 2022 08:21:25 -0700 (PDT)
Received: from localhost.localdomain (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 27HFKaDF001304;
        Thu, 18 Aug 2022 00:20:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 27HFKaDF001304
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1660749637;
        bh=9QEUpWzXvqIwgbnI6vr2FVCzgDiZT2PDochy4QfM3jU=;
        h=From:To:Cc:Subject:Date:From;
        b=ZqZLGa8oZTVguUdQ0+iEQgmFKg6x2OQzD+J2DAeBLLOaNur7tCzUo6+eDYagwHwIu
         /Al1vreRhCFr+wBIOpDGMecLXioyosavaOj0od6v3LEXP13UZWjkkDg654H2XarL99
         Qy9GM+V5pNTZ5mt5RJWMStSF0VaCgAxYw8qI1RdotWZ8kaou674LkLm3rctHg/WPEr
         rtJJpt9yGqfKfZjV9FGncWO0lXL5eGgBgSHt5Hx1G9nV29SA6t/IapXRpzrhIGDtIM
         6eUpCRjSZdQXSVt0H17IJ++71WtSDm1xIq4rh4jBklSLi/QNsbrZfo9NEXokYzETdo
         zNuiiR7cZ9P0Q==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Cc:     linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: fix wrong use of if_changed_rule
Date:   Thu, 18 Aug 2022 00:20:26 +0900
Message-Id: <20220817152027.16928-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intent for if_changed_rule is to re-run the rule when the command
line is changed, but this if_changed_rule does not do anything for it.

$(cmd-check) for this rule is always empty because:

 [1] $(cmd_$@) is empty because .processed-schema.json.cmd does not exist
 [2] $(cmd_$1) is empty because cmd_chkdt is not defined

To address [1], use cmd_and_cmdsave instead of cmd.

To address [2], rename rule_chkdt to rule_mk_schema so that the stem
parts of cmd_* and rule_* match, like commit 7a0496056064 ("kbuild:
fix DT binding schema rule to detect command line changes").

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Another possibility might be to split out yamllint and chk_bindings
as standalone build rules instead of running them as a side-effect
of the schema build. (but it it up to Rob's preference)


 Documentation/devicetree/bindings/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 1eaccf135b30..bb40205689ea 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -46,10 +46,10 @@ quiet_cmd_mk_schema = SCHEMA  $@
                       $(DT_MK_SCHEMA) -j $(DT_MK_SCHEMA_FLAGS) @$$f > $@ ; \
 		      rm -f $$f
 
-define rule_chkdt
+define rule_mk_schema
 	$(if $(DT_SCHEMA_LINT),$(call cmd,yamllint),)
 	$(call cmd,chk_bindings)
-	$(call cmd,mk_schema)
+	$(call cmd_and_savecmd,mk_schema)
 endef
 
 DT_DOCS = $(patsubst $(srctree)/%,%,$(shell $(find_all_cmd)))
@@ -65,7 +65,7 @@ override DTC_FLAGS := \
 override DT_CHECKER_FLAGS ?=
 
 $(obj)/processed-schema.json: $(DT_DOCS) $(src)/.yamllint check_dtschema_version FORCE
-	$(call if_changed_rule,chkdt)
+	$(call if_changed_rule,mk_schema)
 
 always-y += processed-schema.json
 always-$(CHECK_DT_BINDING) += $(patsubst $(srctree)/$(src)/%.yaml,%.example.dts, $(CHK_DT_DOCS))
-- 
2.34.1

