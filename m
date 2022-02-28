Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBB84C7A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 21:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiB1UL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 15:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiB1ULy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 15:11:54 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C7A8B6D7;
        Mon, 28 Feb 2022 12:11:14 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id i5so14297950oih.1;
        Mon, 28 Feb 2022 12:11:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6hMIoo9EljswHM/Y7Z+xyqfRgvaIQ0mLlekBXdfWYK8=;
        b=0ZQrm0NVTc46h+wYZCnVXhWLZOIJ0oM9EPMwiBIOQL0bBGgBxQ4pip1W+2xLr33lE9
         NNb9qRugsj956C1Q62Eq1HAbgUi8cs+BuxiPTzWzt875T7UfMVVMIRJR4sbXlGB/UzGw
         WrKAGKo7wS5+pePdn2ze1WxRxCAqva6kO290kqlkBiZPBgsGDJSGGibTSxgTjS6shEr4
         Ky1EiSCvnAhbJzz2qpkHZYm6pg1THGg5QoPU9rWQU/m3deoSxs+IwwgY52AgOUz2TTWI
         FU7QCt4QafUYDeOSmee03SvMSp/VzWMECJceCr72RNZ9i0OBie3YZCE++s/AvVPNSj5t
         OBmg==
X-Gm-Message-State: AOAM532aUeoJZTb9UnlLRYGINiVs8HSXTi6TQNBKssT3cm15SKbevJX9
        lV7Z0PvQYgnVfuywkXMiLA==
X-Google-Smtp-Source: ABdhPJyDqdqLvu0ZD17elBE69Slnp7CCuMCIe8QXgSkJOli0RqA3pVoc9sRRlW0MC0BrSfqg1fDy8A==
X-Received: by 2002:a05:6808:23cf:b0:2d7:1fca:4792 with SMTP id bq15-20020a05680823cf00b002d71fca4792mr10125707oib.5.1646079074027;
        Mon, 28 Feb 2022 12:11:14 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id fq14-20020a0568710b0e00b000d4492531a2sm5115384oab.17.2022.02.28.12.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 12:11:13 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: kbuild: Support partial matches with DT_SCHEMA_FILES
Date:   Mon, 28 Feb 2022 14:10:05 -0600
Message-Id: <20220228201006.1484903-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
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

DT_SCHEMA_FILES is currently restricted to a list of exact files with
the full source tree path (i.e. Documentation/devicetree/bindings/...).
Loosen this requirement and let DT_SCHEMA_FILES be a partial match.

With this, checking all schema files in a directory is possible:

$ make DT_SCHEMA_FILES=/gpio/ dt_binding_check

Or all schema files with 'qcom' in the path or filename:

$ make DT_SCHEMA_FILES=qcom dt_binding_check

Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/Makefile        | 15 +++++----------
 .../devicetree/bindings/writing-schema.rst        |  9 +++++----
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 41c555181b6f..5138d10e0601 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -31,11 +31,8 @@ find_all_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
 		-name 'processed-schema*' ! \
 		-name '*.example.dt.yaml' \)
 
-ifeq ($(DT_SCHEMA_FILES),)
-find_cmd = $(find_all_cmd)
-else
-find_cmd = echo $(addprefix $(srctree)/, $(DT_SCHEMA_FILES))
-endif
+find_cmd = $(find_all_cmd) | grep -F "$(DT_SCHEMA_FILES)"
+CHK_DT_DOCS := $(shell $(find_cmd))
 
 quiet_cmd_yamllint = LINT    $(src)
       cmd_yamllint = ($(find_cmd) | \
@@ -83,22 +80,20 @@ ifeq ($(DT_SCHEMA_FILES),)
 $(obj)/processed-schema.json: $(obj)/processed-schema-examples.json FORCE
 	$(call if_changed,copy)
 
-DT_SCHEMA_FILES = $(DT_DOCS)
-
 else
 
 # If DT_SCHEMA_FILES is specified, use it for processed-schema.json
 
 $(obj)/processed-schema.json: DT_MK_SCHEMA_FLAGS := -u
-$(obj)/processed-schema.json: $(DT_SCHEMA_FILES) check_dtschema_version FORCE
+$(obj)/processed-schema.json: $(CHK_DT_DOCS) check_dtschema_version FORCE
 	$(call if_changed,mk_schema)
 
 endif
 
 always-$(CHECK_DT_BINDING) += processed-schema-examples.json
 always-$(CHECK_DTBS)       += processed-schema.json
-always-$(CHECK_DT_BINDING) += $(patsubst $(src)/%.yaml,%.example.dts, $(DT_SCHEMA_FILES))
-always-$(CHECK_DT_BINDING) += $(patsubst $(src)/%.yaml,%.example.dt.yaml, $(DT_SCHEMA_FILES))
+always-$(CHECK_DT_BINDING) += $(patsubst $(srctree)/$(src)/%.yaml,%.example.dts, $(CHK_DT_DOCS))
+always-$(CHECK_DT_BINDING) += $(patsubst $(srctree)/$(src)/%.yaml,%.example.dt.yaml, $(CHK_DT_DOCS))
 
 # Hack: avoid 'Argument list too long' error for 'make clean'. Remove most of
 # build artifacts here before they are processed by scripts/Makefile.clean
diff --git a/Documentation/devicetree/bindings/writing-schema.rst b/Documentation/devicetree/bindings/writing-schema.rst
index 4004dd9209a6..3b00fe981494 100644
--- a/Documentation/devicetree/bindings/writing-schema.rst
+++ b/Documentation/devicetree/bindings/writing-schema.rst
@@ -157,13 +157,14 @@ It is possible to run both in a single command::
 
     make dt_binding_check dtbs_check
 
-It is also possible to run checks with a single schema file by setting the
-``DT_SCHEMA_FILES`` variable to a specific schema file.
+It is also possible to run checks with a subset of matching schema files by
+setting the ``DT_SCHEMA_FILES`` variable to a specific schema file or pattern.
 
 ::
 
-    make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/trivial-devices.yaml
-    make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/trivial-devices.yaml
+    make dt_binding_check DT_SCHEMA_FILES=trivial-devices.yaml
+    make dt_binding_check DT_SCHEMA_FILES=/gpio/
+    make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml
 
 
 json-schema Resources
-- 
2.32.0

