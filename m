Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA56F4D4E1A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240216AbiCJQG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236120AbiCJQGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:06:20 -0500
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C659F186440;
        Thu, 10 Mar 2022 08:05:19 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id h16-20020a4a6f10000000b00320507b9ccfso7251810ooc.7;
        Thu, 10 Mar 2022 08:05:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8LooYtbhGIn4IA82/JmFCGznXQn5RTjBogNWCfAeegc=;
        b=MnQqakUTb9ZYwwDV0ogbpET/OKPv1FAC+s12l4yW3B7Ii81KryofU/U0+ogyFiFE/u
         4SVFvIOUvSyxCf2Toyaa80iRa4Qvg/6l5UUHtl+hOT5ujn3QR02PXCHE2fx1Hp2ztaWY
         BEDFJaLrY9pTHqOdFr2/SdYlK5WUOl9TbKka1YHZK+oUOtrgOVsWLbbJTTwqZqFyqbh7
         5TBsYJtQLsgRVS6ZYp4cUH7JHfek38UHhdJmNyPPn/ulYoiYUpnABY0fY5vlkweTQeZE
         fMYX/XPSgPduSQ9EpNQeT1y9eM5HXxSmuWG1K8D9dh18EuMB6IMpknDPQOn5ukwHsVNL
         G75A==
X-Gm-Message-State: AOAM5306DDOgJZoczFXUwveO8vGbUmwq132JH2i1CizaNGzKXjSO8X9D
        kAeqrQsV22z4mfdQunbGNQ==
X-Google-Smtp-Source: ABdhPJz4A/VzRNrvW+ouN8i3ex3VDq5lsxKEHEyreHwGEhe+I609mC60Lz85TNyyn4gYM8zzs0G5ug==
X-Received: by 2002:a05:6870:d1d5:b0:da:cd6:7ac5 with SMTP id b21-20020a056870d1d500b000da0cd67ac5mr8804514oac.157.1646928319118;
        Thu, 10 Mar 2022 08:05:19 -0800 (PST)
Received: from xps15.. ([2607:fb90:20d2:449c:e413:94ed:2767:f2c4])
        by smtp.googlemail.com with ESMTPSA id s21-20020a056870629500b000d9a2291d2fsm2395413oan.30.2022.03.10.08.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 08:05:17 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v2 1/2] dt-bindings: kbuild: Pass DT_SCHEMA_FILES to dt-validate
Date:   Thu, 10 Mar 2022 10:05:12 -0600
Message-Id: <20220310160513.1708182-2-robh@kernel.org>
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
v2:
 - Change DT_TMP_SCHEMA from '?=' to ':='
---
 Documentation/devicetree/bindings/Makefile | 28 +++-------------------
 scripts/Makefile.lib                       |  5 ++--
 2 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 29b5dbd0807e..2716f7b9e25e 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -6,7 +6,7 @@ DT_MK_SCHEMA ?= dt-mk-schema
 DT_SCHEMA_LINT := $(shell which yamllint || \
   echo "warning: python package 'yamllint' not installed, skipping" >&2)
 
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
index 79be57fdd32a..c8c6f1745d03 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -361,10 +361,9 @@ $(multi-dtb-y): FORCE
 $(call multi_depend, $(multi-dtb-y), .dtb, -dtbs)
 
 DT_CHECKER ?= dt-validate
-DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),,-m)
+DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
 DT_BINDING_DIR := Documentation/devicetree/bindings
-# DT_TMP_SCHEMA may be overridden from Documentation/devicetree/bindings/Makefile
-DT_TMP_SCHEMA ?= $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
+DT_TMP_SCHEMA := $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
 
 quiet_cmd_dtb_check =	CHECK   $@
       cmd_dtb_check =	$(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@
-- 
2.32.0

