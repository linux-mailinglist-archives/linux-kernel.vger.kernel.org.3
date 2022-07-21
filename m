Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A7657D5ED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbiGUV1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGUV1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:27:46 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3369285D;
        Thu, 21 Jul 2022 14:27:45 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id x64so2389491iof.1;
        Thu, 21 Jul 2022 14:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JIOd09IsCLkkz0R0g/f3vsUbwuWE429fl7X8V0X7KFU=;
        b=S+V1nXyQlB3D+q9pa9dFVDO23+tzM8kBSnCiqC5VPCQV+sVjTz7KQYI0BUzYkuBXRp
         g8pfgomNcDAnfalGnmTRwkJyLq8qnNHUdjRcPOOac7E7jW9qAHI/iEBrDCw7FCdMV5Ai
         xQOTUVRSCIuH9tIWvn8dGrwGtVwK4clslqZgr+Se2QXJtN5yhMKAY7rUsOPi38qbTvcz
         VUWnvX7j4ZoG7Fmlc4lwQuiFXQX+I/xba6d0kExUYcTWXtEooMs9sbHu/+nALz08qENr
         qACBD8AE9IK54kjqLO7Qr3xAVLH03XnCWA1+7xZzTYg2riCrSAddH3wKOJFKfXoJor4L
         es8A==
X-Gm-Message-State: AJIora9qWXTbzRWWiLc1J3l66cJyGOACYQRiJgvheyy2a8AByfA6I2pZ
        kxgtxqcepeBZMsmGStydTw==
X-Google-Smtp-Source: AGRyM1sHh6EMw+CzWVb3mUQlXlPlqrr85rzuYjaxydZ6Ep4VAHBlwBUshbCF5t75FbvVlUPNFXlL9g==
X-Received: by 2002:a05:6638:50:b0:33f:17b9:be63 with SMTP id a16-20020a056638005000b0033f17b9be63mr251290jap.92.1658438865054;
        Thu, 21 Jul 2022 14:27:45 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id h6-20020a05660208c600b0067bf99ea25bsm1285859ioz.44.2022.07.21.14.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 14:27:44 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 2/2] dt-bindings: arm: coresight-tmc: Add 'iommu' property
Date:   Thu, 21 Jul 2022 15:27:15 -0600
Message-Id: <20220721212718.1980905-2-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220721212718.1980905-1-robh@kernel.org>
References: <20220721212718.1980905-1-robh@kernel.org>
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

The Coresight TMC component may be behind an IOMMU which is the case for
the Arm Juno SoC and some Qualcomm SoCs. Add 'iommus' property to the
binding.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
index e0b88a71356a..cb8dceaca70e 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
@@ -55,6 +55,9 @@ properties:
       - const: apb_pclk
       - const: atclk
 
+  iommus:
+    maxItems: 1
+
   power-domains:
     maxItems: 1
 
-- 
2.34.1

