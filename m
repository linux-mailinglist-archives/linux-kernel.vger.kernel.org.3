Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75685834BE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 23:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbiG0VLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 17:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237732AbiG0VLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:11:31 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683B65A15F;
        Wed, 27 Jul 2022 14:11:16 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id h16so57015ilc.10;
        Wed, 27 Jul 2022 14:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r6nbccx6KpLbSPLTciKrdxwh5zU9CBMhhUb04WW4swU=;
        b=V42FizpONCNJVPcPtg1RcybLFx0vvK8xp4ESlpldqhnWtderVKTNnj20dHl7rGz8qq
         ZT4Xu1JhuDYG/cjlncWEUG1K06S42sPdAnjv/1dcXvxUK6iYvnt8aQxe/N24Z5TAgWp0
         RIzG38ThhT6Bg7+BgSEox0hnTO+3a3MPGb9UMEjHNazFAh+cb3m9ZI88ZbDWTlPTnVx/
         uqaLRNmmu43H2estT64BknagbJq95VLwT57RhlAGOAUdV8qtrS/DQmVr1Wl7LLekw9kV
         uD9c1nbGbeRfkNk2ZJpSjZRmkAWlzOFoyIiaQabaaCfQOkWylEKc0BpIwu1o/VFXQdIn
         yeOg==
X-Gm-Message-State: AJIora/7X5q2l2sAZQLrjfXbYTtYKaQpnHt74mzSutt4IvGuf9bbvBU4
        P+0LCpv4BKyBzuYHhQraYw==
X-Google-Smtp-Source: AGRyM1scer58ETu92/UgOP2WkpKMOxS43565y+GwisX3LSSEyfAQuo+hmmusRHI505/ODmRE8OYPpw==
X-Received: by 2002:a05:6e02:15c4:b0:2d8:b00f:d692 with SMTP id q4-20020a056e0215c400b002d8b00fd692mr9707401ilu.271.1658956275617;
        Wed, 27 Jul 2022 14:11:15 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id w8-20020a0566022c0800b0067928265153sm8715527iov.22.2022.07.27.14.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 14:11:15 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: Drop DT_MK_SCHEMA_FLAGS conditional selecting schema files
Date:   Wed, 27 Jul 2022 15:10:59 -0600
Message-Id: <20220727211100.3249417-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ef8795f3f1ce ("dt-bindings: kbuild: Use DTB files for
validation"), dt-mk-schema always needs a complete list of schemas, so
the conditional using DT_MK_SCHEMA_FLAGS should be removed.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index c9953f86b19d..1eaccf135b30 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -42,9 +42,7 @@ quiet_cmd_chk_bindings = CHKDT   $@
 
 quiet_cmd_mk_schema = SCHEMA  $@
       cmd_mk_schema = f=$$(mktemp) ; \
-                      $(if $(DT_MK_SCHEMA_FLAGS), \
-                           printf '%s\n' $(real-prereqs), \
-                           $(find_all_cmd)) > $$f ; \
+                      $(find_all_cmd) > $$f ; \
                       $(DT_MK_SCHEMA) -j $(DT_MK_SCHEMA_FLAGS) @$$f > $@ ; \
 		      rm -f $$f
 
-- 
2.34.1

