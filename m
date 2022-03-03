Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5ADA4CC955
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 23:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbiCCWoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 17:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbiCCWoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:44:32 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284E855200;
        Thu,  3 Mar 2022 14:43:46 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id j2so6220602oie.7;
        Thu, 03 Mar 2022 14:43:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uIHCa+KnIPtYqD5TBPEYYO/aR7DF5N4jQFH/0XzJtyw=;
        b=5ETj/QB30HWXwVoaeIb7MnOpa/jajECVKaUVq7WA+/LIsP5fKuV07sV9dYzYy1tcw/
         r0U4V9hkfM3DvQJbRXtzAWKCAH+IkxjkmUMR1fCfIcwsNyXA7tIWlQq6o0OkhhwKHlBT
         Ke7NrmB0ZmpcPC+seprFAAAHRhRtduBejXPgR1FKG6ekQOkgatUdhNi6rQK9mSZgFEBt
         RexfhjTV09Pb02NqZdEICSlYJh3e1L6r1MOVQLAselAitJrRJKiz4LTUGXWUenaj+F0h
         KpdgOgIOcVRAlRvKkACQ/eRWDx7g8gjEnKB2PXcoX3J+pMnewV0HF2d7KHABrC++xzrw
         lovQ==
X-Gm-Message-State: AOAM531RIDkvKD55ER8F2fO6Kq27DlG3oUzw+sdC64aL8EsXWaXmQqrI
        N//r1y0n1EDFKCnWkLqBwg==
X-Google-Smtp-Source: ABdhPJzh1T2VePI6949NYqkhNMnV7xpV4aGqLc1QB3TTOTncSMcDTPqTJxOlGz0OTTnwdn3LnsaQ9w==
X-Received: by 2002:a05:6808:1b27:b0:2d5:38fc:26f with SMTP id bx39-20020a0568081b2700b002d538fc026fmr6542030oib.42.1646347425366;
        Thu, 03 Mar 2022 14:43:45 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id x10-20020a4a2a4a000000b0031bf0818df1sm1608480oox.4.2022.03.03.14.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 14:43:44 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: kbuild: Use DTB files for validation
Date:   Thu,  3 Mar 2022 16:42:37 -0600
Message-Id: <20220303224237.2497570-3-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220303224237.2497570-1-robh@kernel.org>
References: <20220303224237.2497570-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
 Documentation/devicetree/bindings/Makefile    |  7 +++----
 .../devicetree/bindings/writing-schema.rst    | 12 -----------
 scripts/Makefile.lib                          | 20 +++++++------------
 scripts/dtc/Makefile                          | 13 ------------
 scripts/dtc/update-dtc-source.sh              |  2 +-
 5 files changed, 11 insertions(+), 43 deletions(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 246ba0ecab64..b8bd6a8ec43a 100644
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
index 9f1e8442564e..4629af60160b 100644
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
 
@@ -365,17 +354,22 @@ DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
 DT_BINDING_DIR := Documentation/devicetree/bindings
 DT_TMP_SCHEMA ?= $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
 
+ifneq ($(CHECK_DTBS)$(CHECK_DT_BINDING),)
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

