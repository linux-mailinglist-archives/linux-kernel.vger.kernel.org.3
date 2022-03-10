Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFCD4D4E27
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240393AbiCJQGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239706AbiCJQGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:06:23 -0500
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F3B18645C;
        Thu, 10 Mar 2022 08:05:21 -0800 (PST)
Received: by mail-oo1-f46.google.com with SMTP id w3-20020a4ac183000000b0031d806bbd7eso7218497oop.13;
        Thu, 10 Mar 2022 08:05:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PdFrUf+INh35GayN7dpMNmxJiWP8mD1xY7Ss28Z++S0=;
        b=bAa6bTyDz27918Y+R6hOBrkegJHXMCsOvLzK9dbRN+/QSY7bcQpPuLzD83oGA+hLvy
         IO/LVVcFp0TGiO4x16NUSGHN6tfmbS4bWx9w4ibLJ1t7Ha8kOL1Kgf2rz/gmm5fW1SwF
         4Z8nIbzHUGYFBSznAH1HNUt9qTDtqjNOanMwNMYGxvVEOiCBngPxSE+6k0InmmF/1MK9
         5ColHL6GCYLbe3vKtzfYKAuCm4j45WkJQNOQwo+1TS7dVEIfqFVcWq7Mw/Vy2rhe3lV5
         P1wzjHUZtQXH57CtdvxYX2wjIK+vmn7YNfKoZz7OmFidgLi7vxiqiZyozd1PmPSs6zO8
         bp4w==
X-Gm-Message-State: AOAM5303l7CYTwY5esj/yFZXTSJ7GJB6NGzfLHSjFB/7+TooyvnGurQY
        ZidYag4h4OhNEps6r93Nng==
X-Google-Smtp-Source: ABdhPJyVa95VoA/cvB+GOq1Gu0MbtaRZul/cPjJTzHCdHh71P43Ms/dWlyX537UIRG2fl8E6T8mjYA==
X-Received: by 2002:a05:6870:a2c6:b0:da:b3f:3212 with SMTP id w6-20020a056870a2c600b000da0b3f3212mr3090042oak.194.1646928320952;
        Thu, 10 Mar 2022 08:05:20 -0800 (PST)
Received: from xps15.. ([2607:fb90:20d2:449c:e413:94ed:2767:f2c4])
        by smtp.googlemail.com with ESMTPSA id s21-20020a056870629500b000d9a2291d2fsm2395413oan.30.2022.03.10.08.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 08:05:20 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v2 2/2] dt-bindings: kbuild: Use DTB files for validation
Date:   Thu, 10 Mar 2022 10:05:13 -0600
Message-Id: <20220310160513.1708182-3-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220310160513.1708182-1-robh@kernel.org>
References: <20220310160513.1708182-1-robh@kernel.org>
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

Switch the DT validation to use DTB files directly instead of a DTS to
YAML conversion.

The original motivation for supporting validation on DTB files was to
enable running validation on a running system (e.g. 'dt-validate
/sys/firmware/fdt') or other cases where the original source DTS is not
available.

The YAML format was not without issues. Using DTBs with the schema type
information solves some of those problems. The YAML format relies on the
DTS source level information including bracketing of properties, size
directives, and phandle tags all of which are lost in a DTB file. While
standardizing the bracketing is a good thing, it does cause a lot of
extra warnings and churn to fix them.

Another issue has been signed types are not validated correctly as sign
information is not propagated to YAML. Using the schema type information
allows for proper handling of signed types. YAML also can't represent
the full range of 64-bit integers as numbers are stored as floats by
most/all parsers.

The DTB validation works by decoding property values using the type
information in the schemas themselves. The main corner case this does
not work for is matrix types where neither dimension is fixed. For
now, checking the dimensions in these cases are skipped.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Dependency on processed-schema.json needs to be conditional
---
 Documentation/devicetree/bindings/Makefile    |  7 +++----
 .../devicetree/bindings/writing-schema.rst    | 12 -----------
 scripts/Makefile.lib                          | 20 +++++++------------
 scripts/dtc/Makefile                          | 13 ------------
 scripts/dtc/update-dtc-source.sh              |  2 +-
 5 files changed, 11 insertions(+), 43 deletions(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 2716f7b9e25e..e594e5898be0 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -26,8 +26,7 @@ $(obj)/%.example.dts: $(src)/%.yaml check_dtschema_version FORCE
 	$(call if_changed,extract_ex)
 
 find_all_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
-		-name 'processed-schema*' ! \
-		-name '*.example.dt.yaml' \)
+		-name 'processed-schema*' \)
 
 find_cmd = $(find_all_cmd) | grep -F "$(DT_SCHEMA_FILES)"
 CHK_DT_DOCS := $(shell $(find_cmd))
@@ -72,9 +71,9 @@ $(obj)/processed-schema.json: $(DT_DOCS) $(src)/.yamllint check_dtschema_version
 
 always-y += processed-schema.json
 always-$(CHECK_DT_BINDING) += $(patsubst $(srctree)/$(src)/%.yaml,%.example.dts, $(CHK_DT_DOCS))
-always-$(CHECK_DT_BINDING) += $(patsubst $(srctree)/$(src)/%.yaml,%.example.dt.yaml, $(CHK_DT_DOCS))
+always-$(CHECK_DT_BINDING) += $(patsubst $(srctree)/$(src)/%.yaml,%.example.dtb, $(CHK_DT_DOCS))
 
 # Hack: avoid 'Argument list too long' error for 'make clean'. Remove most of
 # build artifacts here before they are processed by scripts/Makefile.clean
 clean-files = $(shell find $(obj) \( -name '*.example.dts' -o \
-			-name '*.example.dt.yaml' \) -delete 2>/dev/null)
+			-name '*.example.dtb' \) -delete 2>/dev/null)
diff --git a/Documentation/devicetree/bindings/writing-schema.rst b/Documentation/devicetree/bindings/writing-schema.rst
index 3b00fe981494..b4258bf81be5 100644
--- a/Documentation/devicetree/bindings/writing-schema.rst
+++ b/Documentation/devicetree/bindings/writing-schema.rst
@@ -123,18 +123,6 @@ project can be installed with pip::
 Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will be
 installed. Ensure they are in your PATH (~/.local/bin by default).
 
-dtc must also be built with YAML output support enabled. This requires that
-libyaml and its headers be installed on the host system. For some distributions
-that involves installing the development package, such as:
-
-Debian::
-
-  apt-get install libyaml-dev
-
-Fedora::
-
-  dnf -y install libyaml-devel
-
 Running checks
 ~~~~~~~~~~~~~~
 
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index c8c6f1745d03..9d5320a47ef8 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -87,11 +87,6 @@ base-dtb-y := $(foreach m, $(multi-dtb-y), $(firstword $(call suffix-search, $m,
 
 always-y			+= $(dtb-y)
 
-ifneq ($(CHECK_DTBS),)
-always-y += $(patsubst %.dtb,%.dt.yaml, $(real-dtb-y))
-always-y += $(patsubst %.dtbo,%.dt.yaml, $(real-dtb-y))
-endif
-
 # Add subdir path
 
 extra-y		:= $(addprefix $(obj)/,$(extra-y))
@@ -347,12 +342,6 @@ cmd_dtc = $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ;
 		-d $(depfile).dtc.tmp $(dtc-tmp) ; \
 	cat $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
 
-$(obj)/%.dtb: $(src)/%.dts $(DTC) FORCE
-	$(call if_changed_dep,dtc)
-
-$(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
-	$(call if_changed_dep,dtc)
-
 quiet_cmd_fdtoverlay = DTOVL   $@
       cmd_fdtoverlay = $(objtree)/scripts/dtc/fdtoverlay -o $@ -i $(real-prereqs)
 
@@ -360,22 +349,27 @@ $(multi-dtb-y): FORCE
 	$(call if_changed,fdtoverlay)
 $(call multi_depend, $(multi-dtb-y), .dtb, -dtbs)
 
+ifneq ($(CHECK_DTBS)$(CHECK_DT_BINDING),)
 DT_CHECKER ?= dt-validate
 DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
 DT_BINDING_DIR := Documentation/devicetree/bindings
 DT_TMP_SCHEMA := $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
 
 quiet_cmd_dtb_check =	CHECK   $@
-      cmd_dtb_check =	$(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@
+      cmd_dtb_check =	$(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
+endif
 
 define rule_dtc
 	$(call cmd_and_fixdep,dtc)
 	$(call cmd,dtb_check)
 endef
 
-$(obj)/%.dt.yaml: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
+$(obj)/%.dtb: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
 	$(call if_changed_rule,dtc)
 
+$(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
+	$(call if_changed_dep,dtc)
+
 dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
 
 # Bzip2
diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
index 1cba78e1dce6..4d32b9497da9 100644
--- a/scripts/dtc/Makefile
+++ b/scripts/dtc/Makefile
@@ -17,20 +17,7 @@ fdtoverlay-objs	:= $(libfdt) fdtoverlay.o util.o
 
 # Source files need to get at the userspace version of libfdt_env.h to compile
 HOST_EXTRACFLAGS += -I $(srctree)/$(src)/libfdt
-
-ifeq ($(shell pkg-config --exists yaml-0.1 2>/dev/null && echo yes),)
-ifneq ($(CHECK_DT_BINDING)$(CHECK_DTBS),)
-$(error dtc needs libyaml for DT schema validation support. \
-	Install the necessary libyaml development package.)
-endif
 HOST_EXTRACFLAGS += -DNO_YAML
-else
-dtc-objs	+= yamltree.o
-# To include <yaml.h> installed in a non-default path
-HOSTCFLAGS_yamltree.o := $(shell pkg-config --cflags yaml-0.1)
-# To link libyaml installed in a non-default path
-HOSTLDLIBS_dtc	:= $(shell pkg-config --libs yaml-0.1)
-endif
 
 # Generated files need one more search path to include headers in source tree
 HOSTCFLAGS_dtc-lexer.lex.o := -I $(srctree)/$(src)
diff --git a/scripts/dtc/update-dtc-source.sh b/scripts/dtc/update-dtc-source.sh
index 32ff17ffd089..94627541533e 100755
--- a/scripts/dtc/update-dtc-source.sh
+++ b/scripts/dtc/update-dtc-source.sh
@@ -32,7 +32,7 @@ DTC_UPSTREAM_PATH=`pwd`/../dtc
 DTC_LINUX_PATH=`pwd`/scripts/dtc
 
 DTC_SOURCE="checks.c data.c dtc.c dtc.h flattree.c fstree.c livetree.c srcpos.c \
-		srcpos.h treesource.c util.c util.h version_gen.h yamltree.c \
+		srcpos.h treesource.c util.c util.h version_gen.h \
 		dtc-lexer.l dtc-parser.y"
 LIBFDT_SOURCE="fdt.c fdt.h fdt_addresses.c fdt_empty_tree.c \
 		fdt_overlay.c fdt_ro.c fdt_rw.c fdt_strerror.c fdt_sw.c \
-- 
2.32.0

