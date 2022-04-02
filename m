Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE8A4F04A6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 17:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357528AbiDBP6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 11:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347574AbiDBP6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 11:58:05 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C776193C6
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 08:56:03 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id u26so6194303eda.12
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 08:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LKc5FdjwpDoMw7w7QfhbUOTfH5HjW8+amGJXXlPtPLY=;
        b=fes0w8pFjREMmHb4hTlE478JWznIqhmcmZWiGifBg7F6l2m5Ups0rG6APcWzBfvSs+
         OcH9HZAQpBaNqB6W34IGmaWf7X7Gn87sPbX7DvuEkDHrTJLq/acOAIj9wPtq5B4TH+x2
         +tvV/nZTi32R3HgPer/OPqMDypkSjTAHEUUhDyA0ry1KDUAjYdH69urYxb4TLidm4Clf
         zf11qbv5Kcql3GsE1j0/1b2RGgsgqSDOpKq0s9JF/BrwL3MJYbr81/+pRuPzcytsuY25
         b9TR3aYNoFU4ykuuBN42fDlnvwg39mta6YfGIlUUrBSFOqnigR8J1cZ3RZh+VwP4VZCq
         FyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LKc5FdjwpDoMw7w7QfhbUOTfH5HjW8+amGJXXlPtPLY=;
        b=vP7/EXakiGydF44X0apfRoFt3bgBQS5CsSJEiT1Tue/uS/vB7hamo62cMbvJNEB/nA
         yGq7SEvpeBJ5m6StEAZFNubbIqzQY4hL9cAvXGJWRFfH+nlAdGr+PE/FUW8FNP62zfNc
         fy0jckeRZUUfWbdoqQSxG6Wa6etM7BPnaFk+ZNUI2XZI9XuJcv0XWPqS5HCcUy5CSbyt
         UCnVEOA5zZYI4MEVLCW6BBWgNFr04bwR27mdVUu/Xz9NDE/nefRF9s+mECUH0Itrbzpo
         cG0LTZczN/sFOYtAodJAPfSkK5Z/4pErJU9iIQt9CN7GroxMNBfNcMR7Dk1tL8Sv4rMO
         xt0w==
X-Gm-Message-State: AOAM531i/eDuxx3vmMxIjYDmaXFnWiy1/n0EJiNF09V0VkvcfC2R/CGf
        7bpVMwIcBWZSMuosoeJ/u5JxMg==
X-Google-Smtp-Source: ABdhPJzdPGT8eWpu4BWBTX82au/4ST23Yn0C/lTygHm4zuUqCLlRgVoo3LjSREOF4L4tr/CC1hpPOQ==
X-Received: by 2002:aa7:c157:0:b0:418:f8e3:4c87 with SMTP id r23-20020aa7c157000000b00418f8e34c87mr25518835edp.271.1648914961560;
        Sat, 02 Apr 2022 08:56:01 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id b12-20020a170906038c00b006e4e48969d2sm1479331eja.88.2022.04.02.08.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 08:56:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alex Elder <elder@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 2/2] dt-bindings: net: qcom,ipa: finish the qcom,smp2p example
Date:   Sat,  2 Apr 2022 17:55:51 +0200
Message-Id: <20220402155551.16509-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220402155551.16509-1-krzysztof.kozlowski@linaro.org>
References: <20220402155551.16509-1-krzysztof.kozlowski@linaro.org>
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

The example using qcom,smp2p should have all necessary properties, to
avoid DT schema validation warnings.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/net/qcom,ipa.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
index 58ecc62adfaa..dd4bb2e74880 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
@@ -182,6 +182,12 @@ examples:
 
         smp2p-mpss {
                 compatible = "qcom,smp2p";
+                interrupts = <GIC_SPI 576 IRQ_TYPE_EDGE_RISING>;
+                mboxes = <&apss_shared 6>;
+                qcom,smem = <94>, <432>;
+                qcom,local-pid = <0>;
+                qcom,remote-pid = <5>;
+
                 ipa_smp2p_out: ipa-ap-to-modem {
                         qcom,entry-name = "ipa";
                         #qcom,smem-state-cells = <1>;
@@ -193,6 +199,7 @@ examples:
                         #interrupt-cells = <2>;
                 };
         };
+
         ipa@1e40000 {
                 compatible = "qcom,sdm845-ipa";
 
-- 
2.32.0

