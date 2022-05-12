Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEF85249E9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351230AbiELKCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352456AbiELKAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:00:49 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136BC2311E4
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:00:32 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id kq17so9155592ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bc1mIt/3dkcIrUfw+Wx32EX6v+iTPPZGITrndOapvM4=;
        b=XWoI6TWSrxqK4NFoOjglomE/cazymfb44cK3GD+F51Mv24B90JgGF4RjFOU6vUL2TA
         Q5PrHb+k5cF5N4/WTC03LZyXuQyeOh3GeFVMQiDGBW8q3Tnp4VuezfIuUa2Dbb057fxI
         UdliXYS1OEAbQgB+XnH1fDT8b/s0IlZm3fS1qcO9qmlWwXKVwAOS5cDoYODbM9Se53s8
         Xs4/A3+oL1w8WnMjB6UxxhXb+S+SXVw9XwXy+6FWk1jGX1IiT6N3rn7h30vnW6D4NWCJ
         z98XLnrs8xh6/N9nasuXsNNwwNvnK3xguu9XYnlMhc0vYjIFjjH6M91XwBWvRGwyfxwu
         kqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bc1mIt/3dkcIrUfw+Wx32EX6v+iTPPZGITrndOapvM4=;
        b=VswlmhTnFKq1rMGasxPSexIccEPAyR1vSTcosP3d2uphMYMAme6qo51S255UC/5Ido
         wIuB5GNiodD4hGjWHTIZxMW1fJK15E7tpktsfof1/6xaxEYmNcNCe5hCMakQqjNXw86m
         mpUSYQ2qeGEmh899Msa6jm6y22yFWk/TdCcND8uebg4n+RthkSXPdOVozEyx4kgaeU4c
         ynzV1yoaYGR60tw8eBCy8xrn118A/cwbwcWByWlEWVqa79p4khVIP9u1JoyNjM3g79jg
         MmSwGLAyc4HqYarbVnt56/VXRaitHcUI0w05vkPTC6M6zuD7mMwncscru7shhPfdhHeZ
         /9iQ==
X-Gm-Message-State: AOAM530PewKXf6fDJmYMpm9C6WhDKJ7ekS11uUpa5wIaxk+Vxqzm1hKN
        Vv7oPGX6mjKut3YLXICdkpIkOQ==
X-Google-Smtp-Source: ABdhPJwYJ3PjB3jJ91CPv9ONU3HTEf/WZ7sIWJ5XKfonKTYMcQs7h0i1F6unGKj0cysXRYnV8JkFWQ==
X-Received: by 2002:a17:907:62a6:b0:6ef:8118:d3e2 with SMTP id nd38-20020a17090762a600b006ef8118d3e2mr28698426ejc.605.1652349630543;
        Thu, 12 May 2022 03:00:30 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id d17-20020a170906641100b006f3ef214da1sm1970287ejm.7.2022.05.12.03.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 03:00:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sireesh Kodali <sireeshkodali1@gmail.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 12/12] arm64: dts: qcom: sm8450: remove duplicated glink-edge interrupt
Date:   Thu, 12 May 2022 12:00:06 +0200
Message-Id: <20220512100006.99695-13-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220512100006.99695-1-krzysztof.kozlowski@linaro.org>
References: <20220512100006.99695-1-krzysztof.kozlowski@linaro.org>
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

  sm8450-qrd.dtb: glink-edge: More than one condition true in oneOf schema:
    {'$filename': 'Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml',

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 7d08fad76371..4e796f27d6fc 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2282,7 +2282,6 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 							     IRQ_TYPE_EDGE_RISING>;
 				mboxes = <&ipcc IPCC_CLIENT_MPSS
 						IPCC_MPROC_SIGNAL_GLINK_QMP>;
-				interrupts = <GIC_SPI 449 IRQ_TYPE_EDGE_RISING>;
 				label = "modem";
 				qcom,remote-pid = <1>;
 			};
-- 
2.32.0

