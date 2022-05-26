Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C945354E7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242630AbiEZUoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349049AbiEZUny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:43:54 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6096B7EB
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:43:44 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id u20so3163327edd.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kszyFo4EB09RE8Bso76US2qsMXSYLT6NOSolpKWxpEc=;
        b=nG3cA1barxnVxFUhlt87IM3G+wHT6ZfcrTyFAZsJU8xsoZylJP1A0gltk1XDGO5u4B
         7OUZojhtmRRwlBjEls1VpYg29PlEiZmteApR+Lxz62sU1Niw7Q8rcaIYh47jt/dcK/zL
         hzvmDfdLu8sjNs6txDEugyHI0edyFwZb7lBYJdbYHccVACvqiPIk0OB0eRmiW0UcpqCL
         IIQ2XXrPDqPCbDq74RnV5Z174QSfjMHJUgQ/s9F9hZoxp8Y7Jd4LsGLxla40pfEBvaaJ
         e2/Pgp3KWO2lv1q2y6NLn5yuf2n6G8GkTBEna551xIfsyX3vK2AlURwsEl5rj2jSYc6p
         XWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kszyFo4EB09RE8Bso76US2qsMXSYLT6NOSolpKWxpEc=;
        b=nthFyvGZH8xrEHTjvqFuFsgkC8rL5ajZOmY+1L6Q2GtQk2GTI1uDI4jjp1G/4ejxcx
         mVG0z5yakJ76gcoYheXUmR4PqIOHLanQKiiPfu+zUzxo1DlTnIkxQJQV3B4As2lg1zUE
         YaQQ9zVhaPfXerCG+0YlYYgensfIjeqDgYghrIKy76gAmpWXQ9CinqNv8m/CdRKgohc9
         ML9FZtvX2RaT4FN7gmIap4vVfEh5v6tAHAp2+EER4cteRorYZeEzlsmbLrUJtYTFGxn+
         Xb4gvUz/hla0iy+XWPMBP6KFpvanfMn0iky8oC2/Bb034OLSkQ9l+kwDDAL0nHxpez4W
         LVgw==
X-Gm-Message-State: AOAM532OHdXxSsY3CjoiPs+jLqsG/N+FXVlvY0+HZhGGq+wahiasU+Ty
        iOw5YiBU4TlOnPWhhiawQMmdPg==
X-Google-Smtp-Source: ABdhPJw5GC65gWJ6TIdXxmfyuCi/FcX5QMBEBpnmEzWM9qJmahZ3QmBLR/RJVUw9kLFMFBIH9bU0Bg==
X-Received: by 2002:a05:6402:370c:b0:42a:adfa:9150 with SMTP id ek12-20020a056402370c00b0042aadfa9150mr41749552edb.57.1653597823124;
        Thu, 26 May 2022 13:43:43 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id qw39-20020a1709066a2700b006f3ef214e59sm788041ejc.191.2022.05.26.13.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:43:42 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] arm64: dts: broadcom: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:43:38 +0200
Message-Id: <20220526204339.832296-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Fix whitespace coding style: use single space instead of tabs or
multiple spaces around '=' sign in property assignment.  No functional
changes (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Output compared with dtx_diff and fdtdump.
---
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index 09d4aa8ae1d6..8f8c25e51194 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -567,7 +567,7 @@ enet: ethernet@340000{
 			reg-names = "amac_base";
 			dma-coherent;
 			interrupts = <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>;
-			status= "disabled";
+			status = "disabled";
 		};
 
 		nand: nand@360000 {
-- 
2.34.1

