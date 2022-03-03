Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D404CC950
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 23:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbiCCWoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 17:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236956AbiCCWoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:44:18 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76D555200;
        Thu,  3 Mar 2022 14:43:31 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id u17-20020a056830231100b005ad13358af9so5872624ote.11;
        Thu, 03 Mar 2022 14:43:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4DiSaVj/l0jro1TNXi9BXnk16wdcQX2uMpMANh6u6M0=;
        b=vxJCgz/U17Bz3m8uIso8+rvyR4QZ95Z5lK2FEjpKNE66NTnnbTZtLFPIWv66RDK/jn
         WymPM4+q+WJBOoF9w33wsWQI3zsk9WX/pIiFebSqR1kLx8LJYtoLLJa4sRINAp9uwiST
         jQ23tlXV7tWOsbm0oBkTKZfZVzl2K+ubK5CKZ6w0DKk6L4Ggii92NJjlvz320nENQlmy
         X50gmyYDEvGcrsE0lrujUHhu3Tds+ypu3sH5t0/hOtwTF23Yz/ww4DAvUaD8NaNR2yWE
         sfRKnhJ9bxSsOeWqki76G8i2+sN5cbpNy4k7mWtKx9Qc5zfgNErnYtXbX1mACJIpUZKx
         ILpA==
X-Gm-Message-State: AOAM530222HZpL2a9+w8ZZyL0EYvcu0KvxG6GX4vDN0c2cgHCq5sCuQI
        6aPD/4UY6hMWcnIIBhLRHHJV/RdO6Q==
X-Google-Smtp-Source: ABdhPJxpftXABxUIMiQYUkxEDIhTL6OgtlC0i6/ctwm+SyKuYt9QqOo6odNRQiGv1YYVcZVqxm6kXA==
X-Received: by 2002:a9d:7987:0:b0:5af:ac0:379d with SMTP id h7-20020a9d7987000000b005af0ac0379dmr20843526otm.97.1646347410951;
        Thu, 03 Mar 2022 14:43:30 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id x10-20020a4a2a4a000000b0031bf0818df1sm1608480oox.4.2022.03.03.14.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 14:43:30 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: kbuild: Pass DT_SCHEMA_FILES to dt-validate
Date:   Thu,  3 Mar 2022 16:42:36 -0600
Message-Id: <20220303224237.2497570-2-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220303224237.2497570-1-robh@kernel.org>
References: <20220303224237.2497570-1-robh@kernel.org>
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

In preparation for supporting validation of DTB files, the full
processed schema will always be needed in order to extract type
information from it. Therefore, the processed schema containing only
what DT_SCHEMA_FILES specifies won't work. Instead, dt-validate has
gained an option, -l or --limit, to specify which schema(s) to use for
validation.

As the command line option is new, we the minimum dtschema version must be
updated.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/Makefile | 28 +++-------------------
 scripts/Makefile.lib                       |  3 +--
 2 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 61ec18ecc931..246ba0ecab64 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -6,7 +6,7 @@ DT_MK_SCHEMA ?= dt-mk-schema
 DT_SCHEMA_LINT := $(shell which yamllint || \
   echo "warning: yamllint not installed, skipping. To install, run 'pip install yamllint'" >&2)
 
-DT_SCHEMA_MIN_VERSION = 2021.2.1
+DT_SCHEMA_MIN_VERSION = 2022.3
 
 PHONY += check_dtschema_version
 check_dtschema_version:
@@ -25,9 +25,6 @@ quiet_cmd_extract_ex = DTEX    $@
 $(obj)/%.example.dts: $(src)/%.yaml check_dtschema_version FORCE
 	$(call if_changed,extract_ex)
 
-# Use full schemas when checking %.example.dts
-DT_TMP_SCHEMA := $(obj)/processed-schema-examples.json
-
 find_all_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
 		-name 'processed-schema*' ! \
 		-name '*.example.dt.yaml' \)
@@ -70,29 +67,10 @@ override DTC_FLAGS := \
 # Disable undocumented compatible checks until warning free
 override DT_CHECKER_FLAGS ?=
 
-$(obj)/processed-schema-examples.json: $(DT_DOCS) $(src)/.yamllint check_dtschema_version FORCE
+$(obj)/processed-schema.json: $(DT_DOCS) $(src)/.yamllint check_dtschema_version FORCE
 	$(call if_changed_rule,chkdt)
 
-ifeq ($(DT_SCHEMA_FILES),)
-
-# Unless DT_SCHEMA_FILES is specified, use the full schema for dtbs_check too.
-# Just copy processed-schema-examples.json
-
-$(obj)/processed-schema.json: $(obj)/processed-schema-examples.json FORCE
-	$(call if_changed,copy)
-
-else
-
-# If DT_SCHEMA_FILES is specified, use it for processed-schema.json
-
-$(obj)/processed-schema.json: DT_MK_SCHEMA_FLAGS := -u
-$(obj)/processed-schema.json: $(CHK_DT_DOCS) check_dtschema_version FORCE
-	$(call if_changed,mk_schema)
-
-endif
-
-always-$(CHECK_DT_BINDING) += processed-schema-examples.json
-always-$(CHECK_DTBS)       += processed-schema.json
+always-y += processed-schema.json
 always-$(CHECK_DT_BINDING) += $(patsubst $(srctree)/$(src)/%.yaml,%.example.dts, $(CHK_DT_DOCS))
 always-$(CHECK_DT_BINDING) += $(patsubst $(srctree)/$(src)/%.yaml,%.example.dt.yaml, $(CHK_DT_DOCS))
 
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 79be57fdd32a..9f1e8442564e 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -361,9 +361,8 @@ $(multi-dtb-y): FORCE
 $(call multi_depend, $(multi-dtb-y), .dtb, -dtbs)
 
 DT_CHECKER ?= dt-validate
-DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),,-m)
+DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
 DT_BINDING_DIR := Documentation/devicetree/bindings
-# DT_TMP_SCHEMA may be overridden from Documentation/devicetree/bindings/Makefile
 DT_TMP_SCHEMA ?= $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
 
 quiet_cmd_dtb_check =	CHECK   $@
-- 
2.32.0

