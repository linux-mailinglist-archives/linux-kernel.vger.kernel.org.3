Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BD8529A4C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiEQHCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239876AbiEQHBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:01:32 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD09F25C4E
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:01:30 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id kq17so32829940ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a0nTM6qsq4GtGJkoH4nf0Q+TnkSQuyFZioVt/ZR1zw4=;
        b=KyCAbTTMVnROhAWhKMIJxpaFtqhASwLPlQnI6zyJnMA861UhvrMpV8uiyyYbcenumd
         pUsni593woFCYfRxNtulIrbjduv4JLZHLJXxaADspko9cA1csQmLvt0WXd0b9HXf7DST
         NTkmBaqOUXT6RnVjf+Pv16SYYmIvtRwbkXSCVoWMO3lW/5C1hCgLXLVFTL5z7CYvd5y0
         kFdKMONi+s7OXBvunWgezadfXxn13GJMgevy5L8VOoYfe9MwJ6eAbW8qS+1OFh+wb4fB
         JNFqZShDE41K8Js4Tn9ZaWLeT9SZt8VJvM5s/cJlXKzBDUa0FsXpIk/wdp2lX5DfeDNV
         YsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a0nTM6qsq4GtGJkoH4nf0Q+TnkSQuyFZioVt/ZR1zw4=;
        b=O4LYi2vr/78s2gin8I3FcDI6/9tZEwrnpbVoXFbTleGD7REXGxl4H4RlybNQqbIx7l
         o41kkxDH/VVunPhBHFnedfRCoCKxKwyUUITKnA8VFZ+j2X3nloOj5o8LaNovKIPm2mQX
         l19bpBBJh6L+NMKhxgYAQfLZGzEuo6BDOJffKC9ina/1z9bJIx9guwJzTBEdtuLGu9gZ
         fBS1LrHNBBTepGB1NHgBP3MM915buIWDS1x7HUDV2amycHIXq4fVyRaAHrFWPeNVQDJb
         ekr3aOIuhIMAWqt8RpC+3tTEILhBwUldkH4YhkL+6FDIdc976yOAaTceoR0m72hbLcP6
         EefQ==
X-Gm-Message-State: AOAM532KZLF89o9CG88BjXy+jTOvkZ3kgxGB00wsjTOSLUpgY2HWenE8
        L55HcsOMjGGYEN7V8qiiZSv2rg==
X-Google-Smtp-Source: ABdhPJz1Wy90bvIuITitIqGO/uaK5LgSpxtYb8P9aCGxTkSHFD0DXaP3Gg6ENrsWV0WPKNQTxSgdxA==
X-Received: by 2002:a17:907:1ca3:b0:6f4:d185:9f46 with SMTP id nb35-20020a1709071ca300b006f4d1859f46mr18061789ejc.165.1652770888746;
        Tue, 17 May 2022 00:01:28 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b5-20020a056402138500b0042617ba637esm6487016edv.8.2022.05.17.00.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 00:01:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 09/12] arm64: dts: qcom: ipq6018: add label to remoteproc node
Date:   Tue, 17 May 2022 09:01:10 +0200
Message-Id: <20220517070113.18023-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220517070113.18023-1-krzysztof.kozlowski@linaro.org>
References: <20220517070113.18023-1-krzysztof.kozlowski@linaro.org>
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

glink-edge bindings require label:

  ipq6018-cp01-c1.dtb: glink-edge: 'label' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index c89499e366d3..9db30e7da7bd 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -621,6 +621,7 @@ q6v5_wcss: remoteproc@cd00000 {
 
 			glink-edge {
 				interrupts = <GIC_SPI 321 IRQ_TYPE_EDGE_RISING>;
+				label = "rtr";
 				qcom,remote-pid = <1>;
 				mboxes = <&apcs_glb 8>;
 
-- 
2.32.0

