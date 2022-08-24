Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B9B5A02EB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 22:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240459AbiHXUj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 16:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238135AbiHXUjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 16:39:53 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0334A275E0;
        Wed, 24 Aug 2022 13:39:52 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id d18-20020a9d72d2000000b0063934f06268so5805163otk.0;
        Wed, 24 Aug 2022 13:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=scV9YhTR9B1niguuwysqb8fpuObwHxE77t6Jo9sFANg=;
        b=iYtxBjamWvqwdBiEWktuEDFmH4dm6hCCCB17icgvgd3naYegpu2Xpl932UtD2Eo7nK
         TIllmYG4we514LY/8kQFKLs1PpPmRy1ZhnfUoDmcTRUsiqmiRTf/i1SgNQpJQ1MWyrux
         GMEHGdQvPGbDWQ2hNo81uG8ZF3JPJxskIvQyK3lgnHLl588sg+h3dhEJx7NA34zOpOfv
         FzGJlJawZmophtaxatL9YIKj2fumnmeGweBp9ivBB/BAy2ZnW9A0b0Q6o1aCApjJTxFu
         O4bpcPdy6Enj2qQd1NK1oj6RMzjetz+Y2dqggQBJ+ekKIQ/ITqZ+6HJA4bR0vDouqznl
         pM/w==
X-Gm-Message-State: ACgBeo33QqwHrcGlVya1wVAkWcpLgMBORdePzGaxYnjqKnpJjX3rXKX8
        7SyE3ShvadvT38oigMJZew==
X-Google-Smtp-Source: AA6agR7/DdwePLESoick/ulqm3oeWaSXZJbxj+dy8u9HnuOGMhdGMBRZ47ycejWXffybOhJ740JJpg==
X-Received: by 2002:a9d:5617:0:b0:639:4766:904f with SMTP id e23-20020a9d5617000000b006394766904fmr197632oti.319.1661373591147;
        Wed, 24 Aug 2022 13:39:51 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id x139-20020a4a4191000000b0044b4acd27c5sm333257ooa.17.2022.08.24.13.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 13:39:50 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: [PATCH] kbuild: Split up DT binding build targets
Date:   Wed, 24 Aug 2022 15:39:33 -0500
Message-Id: <20220824203934.2855320-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT binding validation target, dt_binding_check, is composed of
multiple steps which can't be run individually. This resulted in
the passing of make variables to control which steps were run for
'dtbs_check'. Some steps are also doing multiple things in a single rule
which is error prone[1].

Rework the build to split each of the steps into its own make target.
This allows users more fine grained control over what's run and makes
for easier make dependencies. The new targets are:

dt_binding_lint - Runs yamllint on the bindings
dt_binding_schemas - Validates the binding schemas
dt_binding_examples - Builds and validates the binding examples

As before, each can be limited by setting DT_SCHEMA_FILES to a match
file pattern (sub-string).

This also has the side effect of enabling validation of %.dtb targets by
specifying 'CHECK_DTBS=y' on the command line.

[1] https://lore.kernel.org/all/20220817152027.16928-1-masahiroy@kernel.org/

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/Makefile | 42 ++++++++++++++--------
 Makefile                                   | 28 +++++++++------
 scripts/Makefile.lib                       |  2 +-
 scripts/dtc/Makefile                       |  2 +-
 4 files changed, 46 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 1eaccf135b30..1ac3f47b854a 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -29,16 +29,28 @@ find_all_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
 		-name 'processed-schema*' \)
 
 find_cmd = $(find_all_cmd) | grep -F "$(DT_SCHEMA_FILES)"
-CHK_DT_DOCS := $(shell $(find_cmd))
+CHK_DT_DOCS := $(patsubst $(srctree)/%,%,$(shell $(find_cmd)))
 
 quiet_cmd_yamllint = LINT    $(src)
       cmd_yamllint = ($(find_cmd) | \
                      xargs -n200 -P$$(nproc) \
-		     $(DT_SCHEMA_LINT) -f parsable -c $(srctree)/$(src)/.yamllint >&2) || true
+		     $(DT_SCHEMA_LINT) -f parsable -c $(srctree)/$(src)/.yamllint >&2) || true; \
+                     touch $@
 
-quiet_cmd_chk_bindings = CHKDT   $@
+dt_binding_lint: $(obj)/dt_binding_lint.checked
+
+$(obj)/dt_binding_lint.checked: $(CHK_DT_DOCS) $(src)/.yamllint FORCE
+	$(if $(DT_SCHEMA_LINT),$(call if_changed,yamllint),)
+
+quiet_cmd_chk_bindings = CHKDT   $(src)
       cmd_chk_bindings = ($(find_cmd) | \
-                         xargs -n200 -P$$(nproc) $(DT_DOC_CHECKER) -u $(srctree)/$(src)) || true
+                         xargs -n200 -P$$(nproc) $(DT_DOC_CHECKER) -u $(srctree)/$(src)) || true; \
+                         touch $@
+
+dt_binding_schemas: $(obj)/dt_binding_schemas.checked
+
+$(obj)/dt_binding_schemas.checked: $(CHK_DT_DOCS) check_dtschema_version FORCE
+	$(call if_changed,chk_bindings)
 
 quiet_cmd_mk_schema = SCHEMA  $@
       cmd_mk_schema = f=$$(mktemp) ; \
@@ -46,14 +58,13 @@ quiet_cmd_mk_schema = SCHEMA  $@
                       $(DT_MK_SCHEMA) -j $(DT_MK_SCHEMA_FLAGS) @$$f > $@ ; \
 		      rm -f $$f
 
-define rule_chkdt
-	$(if $(DT_SCHEMA_LINT),$(call cmd,yamllint),)
-	$(call cmd,chk_bindings)
-	$(call cmd,mk_schema)
-endef
-
 DT_DOCS = $(patsubst $(srctree)/%,%,$(shell $(find_all_cmd)))
 
+dt_binding_processed_schema: $(obj)/processed-schema.json
+
+$(obj)/processed-schema.json: $(DT_DOCS) check_dtschema_version FORCE
+	$(call if_changed,mk_schema)
+
 override DTC_FLAGS := \
 	-Wno-avoid_unnecessary_addr_size \
 	-Wno-graph_child_address \
@@ -64,12 +75,13 @@ override DTC_FLAGS := \
 # Disable undocumented compatible checks until warning free
 override DT_CHECKER_FLAGS ?=
 
-$(obj)/processed-schema.json: $(DT_DOCS) $(src)/.yamllint check_dtschema_version FORCE
-	$(call if_changed_rule,chkdt)
+dt_binding_examples: $(obj)/processed-schema.json $(patsubst %.yaml,%.example.dtb, $(CHK_DT_DOCS))
+
+dt_binding_check: dt_binding_lint dt_binding_examples dt_binding_schemas
 
-always-y += processed-schema.json
-always-$(CHECK_DT_BINDING) += $(patsubst $(srctree)/$(src)/%.yaml,%.example.dts, $(CHK_DT_DOCS))
-always-$(CHECK_DT_BINDING) += $(patsubst $(srctree)/$(src)/%.yaml,%.example.dtb, $(CHK_DT_DOCS))
+always-y += dt_binding_lint.checked dt_binding_schemas.checked processed-schema.json
+always-$(CHECK_DTBS) += $(patsubst $(src)/%.yaml,%.example.dts, $(CHK_DT_DOCS))
+always-$(CHECK_DTBS) += $(patsubst $(src)/%.yaml,%.example.dtb, $(CHK_DT_DOCS))
 
 # Hack: avoid 'Argument list too long' error for 'make clean'. Remove most of
 # build artifacts here before they are processed by scripts/Makefile.clean
diff --git a/Makefile b/Makefile
index c7705f749601..db456a58a823 100644
--- a/Makefile
+++ b/Makefile
@@ -1391,7 +1391,10 @@ dtbs_prepare: include/config/kernel.release scripts_dtc
 
 ifneq ($(filter dtbs_check, $(MAKECMDGOALS)),)
 export CHECK_DTBS=y
-dtbs: dt_binding_check
+endif
+
+ifeq ($(CHECK_DTBS),y)
+dtbs: dt_binding_processed_schema
 endif
 
 dtbs_check: dtbs
@@ -1409,13 +1412,13 @@ PHONY += scripts_dtc
 scripts_dtc: scripts_basic
 	$(Q)$(MAKE) $(build)=scripts/dtc
 
-ifneq ($(filter dt_binding_check, $(MAKECMDGOALS)),)
-export CHECK_DT_BINDING=y
+DT_BINDING_TARGETS := dt_binding_check dt_binding_lint dt_binding_schemas dt_binding_examples dt_binding_processed_schema
+PHONY += $(DT_BINDING_TARGETS)
+ifneq ($(filter dt_binding_examples dt_binding_check, $(MAKECMDGOALS)),)
+export CHECK_DTBS=y
 endif
-
-PHONY += dt_binding_check
-dt_binding_check: scripts_dtc
-	$(Q)$(MAKE) $(build)=Documentation/devicetree/bindings
+$(DT_BINDING_TARGETS): scripts_dtc
+	$(Q)$(MAKE) $(build)=Documentation/devicetree/bindings $@
 
 # ---------------------------------------------------------------------------
 # Modules
@@ -1625,10 +1628,13 @@ help:
 	@echo  ''
 	@$(if $(dtstree), \
 		echo 'Devicetree:'; \
-		echo '* dtbs             - Build device tree blobs for enabled boards'; \
-		echo '  dtbs_install     - Install dtbs to $(INSTALL_DTBS_PATH)'; \
-		echo '  dt_binding_check - Validate device tree binding documents'; \
-		echo '  dtbs_check       - Validate device tree source files';\
+		echo '* dtbs                - Build device tree blobs for enabled boards'; \
+		echo '  dtbs_install        - Install dtbs to $(INSTALL_DTBS_PATH)'; \
+		echo '  dtbs_check          - Validate device tree source files';\
+		echo '  dt_binding_check    - Validate device tree binding documents and examples'; \
+		echo '  dt_binding_schemas  - Validate device tree binding documents'; \
+		echo '  dt_binding_examples - Validate device tree binding examples'; \
+		echo '  dt_binding_lint     - Run yamllint on device tree binding documents'; \
 		echo '')
 
 	@echo 'Userspace tools targets:'
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 3fb6a99e78c4..2a9901377e57 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -365,7 +365,7 @@ $(multi-dtb-y): FORCE
 	$(call if_changed,fdtoverlay)
 $(call multi_depend, $(multi-dtb-y), .dtb, -dtbs)
 
-ifneq ($(CHECK_DTBS)$(CHECK_DT_BINDING),)
+ifneq ($(CHECK_DTBS),)
 DT_CHECKER ?= dt-validate
 DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
 DT_BINDING_DIR := Documentation/devicetree/bindings
diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
index 4d32b9497da9..593af5d4e19c 100644
--- a/scripts/dtc/Makefile
+++ b/scripts/dtc/Makefile
@@ -3,7 +3,7 @@
 
 # *** Also keep .gitignore in sync when changing ***
 hostprogs-always-$(CONFIG_DTC)		+= dtc fdtoverlay
-hostprogs-always-$(CHECK_DT_BINDING)	+= dtc
+hostprogs-always-$(CHECK_DTBS)	+= dtc
 
 dtc-objs	:= dtc.o flattree.o fstree.o data.o livetree.o treesource.o \
 		   srcpos.o checks.o util.o
-- 
2.34.1

