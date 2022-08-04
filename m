Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448705899E6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 11:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbiHDJ1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 05:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237862AbiHDJ1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 05:27:17 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA1A61DA4
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 02:27:16 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id w15so12409062ljw.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 02:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=28KYhVTag+j2JBtmvytZTw71Q/CcsBjx32UmQc4KhYw=;
        b=p0GLltuIZ2wwyn34RSyNzxiqdd0F4ggEEPZlR24YM1hlHFR9cLuy/PMcrInKVdvHpr
         pc+y6KogJLRRNx1vv/GA6wGq4ZbF84lKR5bma8Woz9HyD+EcTKdMqJFqEo7iZ5wzqOBw
         M9ghBItoBk30hQGPOIZRZL5b/uN1vxDsjE+mD1qG2aVH10WnPucAGka99AkVyEWl9uj8
         5lTuaNKR6I8k84BIvzDjnmPIut3gaN2Mwkr99qaoGxULf1xLqlX9VUTz1cIEoSDORT8F
         9ViC+sxCwigncPZbyBjz7Wx1ayGE4czZymaVJ8E4t3SKXIHxzsOTwIbhn4SCpy0zcoQm
         l32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=28KYhVTag+j2JBtmvytZTw71Q/CcsBjx32UmQc4KhYw=;
        b=33Sxpnv8P0pA4Cq4K+QQCJDCAOiNABJeHmj3vGxBDbFmvxtDRhhC+v6FdVkupumB6C
         mI6myNcHw+Sq6jDv2exfNbMTh08cis52wXssZzxB8sqtFT9xZcknrvdLFhzDZn4fgiTs
         koCW8n2RUPJH/MPpQGqMq6Yz2u5CA7QraxJNBuUYqEzzs0On/wrMZj7x53kEi/dPPm4M
         w7Wpif9/0uUWXuzRGMW3GsyWZeCFG70I2QDiFLJ+oqYEoBCfxBXov94PbaejiXfvxTid
         ljFA6Hk9lnW/4PJFR6vmCu9SGsSiDkTnvWLf87as4JZzLFKTXYxbr5/N63IimJaeRDvE
         Hflw==
X-Gm-Message-State: ACgBeo2Pvf1oHrqSNL39+2wkUmUSi3XCktcvho5akL0qaUSGjtVEgB1D
        6WEb18HcG9kZRpZx/7ramO0lJw==
X-Google-Smtp-Source: AA6agR6LQs8Dxh2DfyUwdwGwwOspgFjtcqDb42faNaU0poHFNgTwixRzCFLPmqip8KSu19pgH6dQBg==
X-Received: by 2002:a2e:93c3:0:b0:25d:d31f:ef1b with SMTP id p3-20020a2e93c3000000b0025dd31fef1bmr284211ljh.102.1659605234655;
        Thu, 04 Aug 2022 02:27:14 -0700 (PDT)
Received: from krzk-bin.. ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id h16-20020a2e5310000000b0025e42641a32sm52437ljb.123.2022.08.04.02.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 02:27:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: arm: aspeed: adjust qcom,dc-scm-v1-bmc compatible after rename
Date:   Thu,  4 Aug 2022 11:27:10 +0200
Message-Id: <20220804092710.64636-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Nuvia DC-SCM BMC board compatible was renamed iin commit
7f058112873e ("ARM: dts: aspeed: nuvia: rename vendor nuvia to qcom"),
so adjust the bindings as well.

Fixes: f77024c80147 ("dt-bindings: arm: aspeed: document board compatibles")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 1895ce9de461..20469519e497 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -80,7 +80,7 @@ properties:
               - ibm,tacoma-bmc
               - inventec,transformer-bmc
               - jabil,rbp-bmc
-              - nuvia,dc-scm-bmc
+              - qcom,dc-scm-bmc
               - quanta,s6q-bmc
           - const: aspeed,ast2600
 
-- 
2.34.1

