Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC2F4CA2BB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 12:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241221AbiCBLGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 06:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241170AbiCBLGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 06:06:17 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386E14A3F4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 03:05:35 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d17so1674894pfl.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 03:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vNsqVoa00YCDeFZ4I2281SG6Ep4/CfQvbPK2hEihXH8=;
        b=FTqF9Zk8PEtqxa1Y6ShcNKAUf699DnxgjudKfbS4zE3S4KGBzID4J1wXuLTbV0ggHm
         RJaxOXHmjAn8bsatW/GUJYsM8T6YS0rbNdB80qaf5qg7ZZ5BKxu3HmcXnv2aSktp+1bE
         IffGJmdZpDmdbkgxEghfbsQRX0rbJuvWrTlpOfX4kIlSYYenkd3+rBelSC3a199VzeVQ
         11fthqtauTIl5vUPOk0POZ+Rh+8ljiafPx/aoZe7Ccd4Ve7+czolkW2oMz2YXVZ7u15j
         khUjfaArSN6/hXH89Xt1jg8+nU9GVA0FUaJ14WSrbMCYIK07MSey+bTyS7p9n54DB8QS
         Nkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vNsqVoa00YCDeFZ4I2281SG6Ep4/CfQvbPK2hEihXH8=;
        b=BbtTr7m/0q3ruMQOrWR9sWY3YyXwYp136VmRb/9zobq1K2n+q1jGEZaPAueEI77eIp
         0s+Oe0ea93Vq78WWeB/hp0XIw2KX3t61seWVBAOedBNg8JZA1KhBMrtzEkLFj7kLJs4P
         8yo+YesRCXW9mbQ7e3JRbzJJaZHfGoDOzlEnxMbWsEfUD53PYY14T7tYDgDuQl25Sho8
         FQWUuH+ipMDC7qGtZIAVh6L68FOY8E1w/adB5EgYoQad1ofkVNALeziwIpf1ld15T+Hj
         y//efwVgwzPiXib8e74EzOs2lxwjRsfdl7J1QQp2V0xNR8mkc4i5PRZtq7UUoMsyPRr0
         9wgQ==
X-Gm-Message-State: AOAM533olb5Awaw31tcprFr1D+/BgovPUP4u2qq6+DcUZBnK/XXpmpDm
        Qn5DrXp0F9Ofyh/tNDnySaW1mw==
X-Google-Smtp-Source: ABdhPJxaJAV0tcgV60jZPuUhPhAM+kBk7DrSLOC/sNdq/5HT5rxfHOCWAK9nQxO/9mQTmTTqCPherA==
X-Received: by 2002:a05:6a00:1a09:b0:4e1:67a7:2c87 with SMTP id g9-20020a056a001a0900b004e167a72c87mr32533882pfv.37.1646219134666;
        Wed, 02 Mar 2022 03:05:34 -0800 (PST)
Received: from localhost.localdomain ([171.50.175.145])
        by smtp.gmail.com with ESMTPSA id hk1-20020a17090b224100b001b8cff17f89sm5049186pjb.12.2022.03.02.03.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 03:05:34 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org, tdas@codeaurora.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        robh+dt@kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/5] dt-bindings: net: qcom,ethqos: Document SM8150 SoC compatible
Date:   Wed,  2 Mar 2022 16:35:04 +0530
Message-Id: <20220302110508.69053-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220302110508.69053-1-bhupesh.sharma@linaro.org>
References: <20220302110508.69053-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

SM8150 has a ethernet controller and needs a different configuration so
add a new compatible for this

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/net/qcom,ethqos.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,ethqos.txt b/Documentation/devicetree/bindings/net/qcom,ethqos.txt
index fcf5035810b5..1f5746849a71 100644
--- a/Documentation/devicetree/bindings/net/qcom,ethqos.txt
+++ b/Documentation/devicetree/bindings/net/qcom,ethqos.txt
@@ -7,7 +7,9 @@ This device has following properties:
 
 Required properties:
 
-- compatible: Should be qcom,qcs404-ethqos"
+- compatible: Should be one of:
+		"qcom,qcs404-ethqos"
+		"qcom,sm8150-ethqos"
 
 - reg: Address and length of the register set for the device
 
-- 
2.35.1

