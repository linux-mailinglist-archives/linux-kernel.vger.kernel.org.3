Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1B84CC8A5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 23:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbiCCWQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 17:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiCCWQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:16:30 -0500
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53D879395;
        Thu,  3 Mar 2022 14:15:44 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id h16-20020a4a6f10000000b00320507b9ccfso7400696ooc.7;
        Thu, 03 Mar 2022 14:15:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DSkWNUygoFllhMK/e+tGM/T1Vv9qWNlJs5zfF4YOiUE=;
        b=KB3bSyw1Iy4mDLOR/7YUj1ZHLM6sWkmSjXbroe0vaHmd5ndQayq/o45Et9COWwodfc
         KqVYcaV4xf8mcw6EEZMPQ79jSAeubtUGRYhm+fsWoZWdRvu7NrtTCorabCHKiQhGnKmL
         gGPP40FQR3npjDX/vbts4h0chbubo9LmitZBd1UeC0QQz9YV7jk9SMFncBXvPria9/oq
         UO3N2rx+gIx6FAfqyB66wKedt0/OgxJTxJRqY2pcnqTq276JnS8nSC7bXGBXEYEWmO9D
         IORiHvCy9L29bdMTzy3RQPKxGT0KEExUwa5FVTOhrEhMNmsYM9yqZNex8hHegZEDi3Zy
         OEoA==
X-Gm-Message-State: AOAM531fn8KLCcyoeXxAC9AGQtBKVyMqd8ke3qfkyHyWRSQq24rSFysn
        iLReAJebEt+jsFoQYsVcaVr/baahNw==
X-Google-Smtp-Source: ABdhPJwvPdrs/nfwmVnQv0K7L3fAYY08vszpv57bRcMP5sS5M1Hctf3G6hySPUlSyYEHTpQwu0I6tw==
X-Received: by 2002:a05:6870:a102:b0:d9:bcaf:7181 with SMTP id m2-20020a056870a10200b000d9bcaf7181mr2808605oae.8.1646345743921;
        Thu, 03 Mar 2022 14:15:43 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id v7-20020a4aa507000000b0031c01a4ef37sm1535047ook.32.2022.03.03.14.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 14:15:43 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] dt-bindings: kbuild: Print a warning if yamllint is not found
Date:   Thu,  3 Mar 2022 16:14:17 -0600
Message-Id: <20220303221417.2486268-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
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

Running yamllint is effectively required for binding schemas, so print a
warning if not found rather than silently skipping running it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 5138d10e0601..61ec18ecc931 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -3,7 +3,8 @@ DT_DOC_CHECKER ?= dt-doc-validate
 DT_EXTRACT_EX ?= dt-extract-example
 DT_MK_SCHEMA ?= dt-mk-schema
 
-DT_SCHEMA_LINT = $(shell which yamllint)
+DT_SCHEMA_LINT := $(shell which yamllint || \
+  echo "warning: yamllint not installed, skipping. To install, run 'pip install yamllint'" >&2)
 
 DT_SCHEMA_MIN_VERSION = 2021.2.1
 
-- 
2.32.0

