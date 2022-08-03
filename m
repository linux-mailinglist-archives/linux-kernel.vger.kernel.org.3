Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E815589312
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 22:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236919AbiHCURa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 16:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiHCUR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 16:17:28 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A6159242;
        Wed,  3 Aug 2022 13:17:27 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id h139so250418iof.12;
        Wed, 03 Aug 2022 13:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=nFnsI0O1PrK2YgAMgRf5Rb1QEHWcYLli9kiS7QQAZkY=;
        b=wknssOcYq1CM1/qIZFqbUB2Bo3kuF3Xt+azr2KRXkM/JGGOP4r54moFHkCxS9iwcR4
         /CE39yPIUSLvy89dak/wiqd9nF+yuFJ1rQ3jYRPfVt+E9jBuOZNsnxpcXejNbANftUod
         5mxtR3R2mPSs5Z1lS5FPz4BCKmlQPMGW+bYEWYU109vwXL3OC7zgz+K7KFigjtnHnj5q
         vNAGILK4yTq2QEQfz5IadxilG+fM31P10p/CPV/uve70T+s1RKVY1WBpuRJy6dq59dSw
         0K3Lxy3r66lP8p7QtseDYhINR3lwXhXTHeWouBXuW3BvRDElqk7xSN+LzR2fEpw9Y8Qe
         ubMA==
X-Gm-Message-State: AJIora/ud2q6+UFrh9NFcgEZBIUFDgqz70WSBSzGueOIGIKGa/5IqiAb
        xiGaOOUG6ui0rkdZkbUHP2qUoV4kxA==
X-Google-Smtp-Source: AGRyM1swffRWGVQulzXOS7Iy/J4naxuEl70lKHfvAz/xYcBF5ZQMgQ/br5AD5IFtUlBJpyjkMNuLWQ==
X-Received: by 2002:a05:6602:2d92:b0:67c:b00:422 with SMTP id k18-20020a0566022d9200b0067c0b000422mr10034331iow.187.1659557846511;
        Wed, 03 Aug 2022 13:17:26 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id b6-20020a92c846000000b002ddf58d8828sm7225876ilq.19.2022.08.03.13.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 13:17:26 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: psci: Relax and simplify compatible constraints
Date:   Wed,  3 Aug 2022 14:16:38 -0600
Message-Id: <20220803201639.2552581-1-robh@kernel.org>
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

Even PSCI v1.0 compliant implementations may support v0.1 clients
(i.e. "arm,psci"). Relax the compatible schema such that an
implementation can claim 1.0, 0.2, and 0.1 compatibility.

In the process, the schema can be simplified a bit by using 'minItems'
instead of separate 'oneOf' entries.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/psci.yaml | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
index dd83ef278af0..3a2c908ff282 100644
--- a/Documentation/devicetree/bindings/arm/psci.yaml
+++ b/Documentation/devicetree/bindings/arm/psci.yaml
@@ -41,31 +41,26 @@ properties:
           For implementations complying to PSCI versions prior to 0.2.
         const: arm,psci
 
-      - description:
-          For implementations complying to PSCI 0.2.
-        const: arm,psci-0.2
-
       - description:
           For implementations complying to PSCI 0.2.
           Function IDs are not required and should be ignored by an OS with
           PSCI 0.2 support, but are permitted to be present for compatibility
           with existing software when "arm,psci" is later in the compatible
           list.
+        minItems: 1
         items:
           - const: arm,psci-0.2
           - const: arm,psci
 
-      - description:
-          For implementations complying to PSCI 1.0.
-        const: arm,psci-1.0
-
       - description:
           For implementations complying to PSCI 1.0.
           PSCI 1.0 is backward compatible with PSCI 0.2 with minor
           specification updates, as defined in the PSCI specification[2].
+        minItems: 1
         items:
           - const: arm,psci-1.0
           - const: arm,psci-0.2
+          - const: arm,psci
 
   method:
     description: The method of calling the PSCI firmware.
-- 
2.34.1

