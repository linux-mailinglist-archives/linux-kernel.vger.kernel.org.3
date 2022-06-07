Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07ADE5404ED
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 19:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345721AbiFGRTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 13:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345406AbiFGRS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:18:59 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C201053D1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:18:57 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id h23so25483110ejj.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 10:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wRdWSIKyYkI40KDQnl/RDAGtefWUX7TnHCHtBAZfwPE=;
        b=FdiAMr47BtFt6E1QXvm4vtubcRAn8dLeI3CKXfojzpriAa/2D8JiW5GLajV6HKh9Pc
         WFGKf06a2QWoNWF1ovX/uYNV2aCZA4tKyGl0vpedg6lAOatnApQP7r9M4RJRzh5JliYc
         iQv3CudJ4aYT3MqMJMK+V6HSzBoKAfiyHCc6bleRNBXK6j35EMw+VHqwv/TMksaKR6Jl
         eTPKRcWq/dZUv2/8R7IS3xu4XBAsLZ14KkQeADJzCen+a22mgnsiqupkWM36WxGseMZC
         6pdYj186NZEflBvsUx+7oRsdtdwFvIw69kOnwYYWMSoRHE68BxRPKHKftOkAX23wHeMs
         Th1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wRdWSIKyYkI40KDQnl/RDAGtefWUX7TnHCHtBAZfwPE=;
        b=awxAnnK9CjorrK0S9C1XJ++cpBwXnEyfHMy5fswiH7QjVXai2B7IEKQ3W+EmvD3V3T
         8e6+6buun/QRwxtCZh7gx6pMFZ6A8M6cvSy5nLLAhWeqkeYBhl0Tammj0z7Lb2s2907i
         //lZK3w201ifA78bT1VgUiZomDXm10qA3iTNg3TG9botnU4v9PEQmosVkSF9MBF7WZ0a
         BHgkbroKmGk0FpU2vAWnumomozbZW3F5VnA1avYyojH39HjJqJltrpciaVW+OvInxs2G
         G+rzy/u8O2oanOKyQYed/dHQGYfeV51butPkzPVbzos8aByLo913rxvS1Udlm4lcNO9H
         a5YQ==
X-Gm-Message-State: AOAM533jCx/9RBU2MdR/KyZxI9BFVbgEQexkuQJpTBxISmQABSWNjIrK
        S+Yk7muwdrbekYJlSPR4uYF0bw==
X-Google-Smtp-Source: ABdhPJx+54wFQc2pVulIxuucwp9fStM95Fu5NCHKyIdjcTqEAUiVihmUeWWIlGK3tZTxdbCkez+P3A==
X-Received: by 2002:a17:906:8454:b0:711:c970:227a with SMTP id e20-20020a170906845400b00711c970227amr12686829ejy.4.1654622335481;
        Tue, 07 Jun 2022 10:18:55 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i7-20020a170906444700b0070e238ff66fsm5876540ejp.96.2022.06.07.10.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 10:18:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 04/14] ARM: dts: qcom: apq8064-asus-nexus7: add dedicated IMEM compatible
Date:   Tue,  7 Jun 2022 19:18:38 +0200
Message-Id: <20220607171848.535128-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220607171848.535128-1-krzysztof.kozlowski@linaro.org>
References: <20220607171848.535128-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscon compatible must be preceded with a specific compatible, to
accurately describe the device.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts b/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
index de01e34409f2..13ad1e84a25b 100644
--- a/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
@@ -342,7 +342,7 @@ mmc@12400000 {
 		};
 
 		sram@2a03f000 {
-			compatible = "syscon", "simple-mfd";
+			compatible = "qcom,apq8064-imem", "syscon", "simple-mfd";
 			reg = <0x2a03f000 0x1000>;
 
 			reboot-mode {
-- 
2.34.1

