Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11086529A46
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbiEQHC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240775AbiEQHBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:01:34 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B335634671
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:01:31 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id gh6so32914529ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LazXu2ADGNpRx7NCnnIVEulufa0K62/IELeSMelv/jU=;
        b=vB4FwIdysdASe6llMH+QnqOEj5eQjfjT0I7FtDmu6ZM0+3b2K1aOeZ9+v9ivZheD11
         /S8aBSY7q3orvfrDksXccAgfRiWvneEXAeRi+pjfvXCAxF2/ZKvrxSOzMck38IlIkPAV
         HKsOkX0u3oWfza3FZxh/3PHc3rjcY62MIHzeuUZQchvX14VKCQF5QyDyb1Qvt4qsZE/N
         tDvL2vE9TQtoWL4nZzEHB+IgDI1KKQ0oeU20MSYNWCRnzPZGG9p6irlPGRBFSudLGLwm
         OtTFBkAWlE4W5kltyabWCIGGmHoONatlPOLd7t5WnhYzQam3DhH7uMEhIRGzcxh8dt2D
         rpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LazXu2ADGNpRx7NCnnIVEulufa0K62/IELeSMelv/jU=;
        b=hlrEGCj9SltNRiOE0Un71tpJ3Rp+QyvCgQApfJ4aizD0xlefemXTgGk/EYtRmDrk27
         i8mHiKX532xXJk6vN5Tqb+Ej2+997MB0hsqsWA0/mdl9x/idKJ82TR0cQuF1Geomop26
         LjtKB8LztAwngmKin+1sqGZX+DIKQK06hZu/Dfvbwyg2yxdRKZc83l51pK8SZxugX09Y
         SdDcBn5SBPmEpS8y89xXRw1i/32+p85m2qnIsGNGVET/7XIY0Yrb8ty21u2AYKnJa3Bx
         MQ90TNvpAABgPqSXVy7ryJ/N1jvZujJBX+qYmg64mGGPBiwxooDO23ABCeC5NrgvzYgT
         2PRg==
X-Gm-Message-State: AOAM533xKMPMdN5xUX35CzRPo1QxfbRqTS+Ku6+445GZqijsa7O7Jzha
        rUTsegoNg8WZsE1/tzLouskNsQ==
X-Google-Smtp-Source: ABdhPJz3cvQL2isulpmYvKIWq0RrGfWma5QYQTNUNHch7EOBn7IIxI3HBT7zWKUVIDh83HdjyHj10g==
X-Received: by 2002:a17:907:7b89:b0:6f4:9b92:c2ac with SMTP id ne9-20020a1709077b8900b006f49b92c2acmr17831258ejc.409.1652770890896;
        Tue, 17 May 2022 00:01:30 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b5-20020a056402138500b0042617ba637esm6487016edv.8.2022.05.17.00.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 00:01:30 -0700 (PDT)
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
Subject: [PATCH v2 11/12] arm64: dts: qcom: sm8350: remove duplicated glink-edge interrupt
Date:   Tue, 17 May 2022 09:01:12 +0200
Message-Id: <20220517070113.18023-12-krzysztof.kozlowski@linaro.org>
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

Specifying interrupts and interrupts-extended is not correct.  Keep only
the extended ones, routed towards IPCC mailbox to fix warnings like:

  sm8350-sony-xperia-sagami-pdx214.dtb: glink-edge: More than one condition true in oneOf schema:
    {'$filename': 'Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml',

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 743cba9b683c..e8c341faa8df 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1677,7 +1677,6 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 							     IRQ_TYPE_EDGE_RISING>;
 				mboxes = <&ipcc IPCC_CLIENT_MPSS
 						IPCC_MPROC_SIGNAL_GLINK_QMP>;
-				interrupts = <GIC_SPI 449 IRQ_TYPE_EDGE_RISING>;
 				label = "modem";
 				qcom,remote-pid = <1>;
 			};
-- 
2.32.0

