Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDA351BE34
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358226AbiEELmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358337AbiEELmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:42:00 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0438B53B7A
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 04:38:17 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id i27so8145734ejd.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 04:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eLgQPwziK+ko4kQyG3I37Mp7K7CNGQrMU0x5X86Viy4=;
        b=hHO6dNn457mwN8ZY11w+Ya9foj5hhTMPgJvqcokiXZmXsKrOgOfZy01GeiOTTGHYlC
         nIJL2+pu+smRvh8aT+so+QIIMTOYU6H2spQh7fW0nVbrPhzNOhJ/x8ESXZtWfrVnYPmj
         UDs1MWCcftcp3a6X1fUm31l8Bb23z/boJHsKoUvUj40B+sMPI/nxzNQB+OpcK2eX0r4U
         KEYzoVHeskta63tNXL67NKXh6vXJnrCcJba1jmD82sbrtwEKOcohKaGgibns/U922LxO
         jRJvwTD+XtnBxNYQoz1KWBe2Rsj3mtz5b/F5/Mv2fUasPz3OFXipG5405qodDVHrj0pf
         vAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eLgQPwziK+ko4kQyG3I37Mp7K7CNGQrMU0x5X86Viy4=;
        b=3snvY78xHJm1RIWWYL7lcMsQIjylqFWWjTxVZGAdwnMjmO0UWdpaWHnqqVMs1r7qB1
         4EQd71YTbJiHvfGa8dMjxfUZU/A4R8y3jjSkzSBq3jm0XX2TiXK61N/V++nR/qI2qY4C
         wAGR952tgBZzVdzW8Wymdk56BirVm87iPY0/+urnafwmEyIvJhkcT2Xc1yG+Y7Wxeom/
         YZsyescgIhBNMPOKAC3MlPWDXhaAXg7SBHRWv9XpmLe2Fvrwtwx2NJwsXoWWoEBVh8in
         WODl70PRjC1RxNw9oQcGOXTBMmsac0mYNL+XsU/xzzOKGnPTk9DCyUaiWlHzVWKYYJjU
         h3Ow==
X-Gm-Message-State: AOAM5338UQdMDpT/dpPMxS0ULhLEWXcGdvPBYp5QtV2qv3icBCdQ5zON
        Z0DD3Gq+JAwNThMpY8YbwHweYw==
X-Google-Smtp-Source: ABdhPJz56RQddCKde8syNeZ99IESBlDy9ESB9ITrwMeCYoMWTZUXN/j4oCItchLbl2oXlmaZPfTRcw==
X-Received: by 2002:a17:907:8a0c:b0:6f4:7fc2:b0b0 with SMTP id sc12-20020a1709078a0c00b006f47fc2b0b0mr13945675ejc.251.1651750695502;
        Thu, 05 May 2022 04:38:15 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g9-20020a1709063b0900b006f3ef214db6sm661006ejf.28.2022.05.05.04.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 04:38:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 6/6] arm64: dts: qcom: sdm630: correct QFPROM byte offsets
Date:   Thu,  5 May 2022 13:38:02 +0200
Message-Id: <20220505113802.243301-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220505113802.243301-1-krzysztof.kozlowski@linaro.org>
References: <20220505113802.243301-1-krzysztof.kozlowski@linaro.org>
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

The NVMEM bindings expect that 'bits' property holds offset and size of
region within a byte, so it applies a constraint of <0, 7> for the
offset.  Using 25 as HSTX trim offset is within 4-byte QFPROM word, but
outside of the byte:

  sdm630-sony-xperia-nile-discovery.dtb: qfprom@780000: hstx-trim@240:bits:0:0: 25 is greater than the maximum of 7
  sdm630-sony-xperia-nile-discovery.dtb: qfprom@780000: gpu-speed-bin@41a0:bits:0:0: 21 is greater than the maximum of 7

Align the offsets to match the bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested on SDM630 hardware, but similar behavior on SDM845 works
fine (although causes a read of 4 bytes instead of 1).
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 505e10674cb6..c713aa6e7044 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -558,13 +558,13 @@ qfprom: qfprom@780000 {
 			#size-cells = <1>;
 
 			qusb2_hstx_trim: hstx-trim@240 {
-				reg = <0x240 0x1>;
-				bits = <25 3>;
+				reg = <0x243 0x1>;
+				bits = <1 3>;
 			};
 
 			gpu_speed_bin: gpu-speed-bin@41a0 {
-				reg = <0x41a0 0x1>;
-				bits = <21 7>;
+				reg = <0x41a2 0x1>;
+				bits = <5 7>;
 			};
 		};
 
-- 
2.32.0

