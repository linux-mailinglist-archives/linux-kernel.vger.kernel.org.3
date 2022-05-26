Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7095354FD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349050AbiEZUqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349154AbiEZUqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:46:19 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA681140D1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:46:12 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c93so1840618edf.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KsaZBsRuA05EIUREKaT6uWWUf8NwbjqVqV7AE7nTWuU=;
        b=BcG3GQbgtgUVWKJIL9pS1cl+PhYjFfOPC3ea6JJLYZLasXxxf9YqHtdfnk1vHgt9oN
         dXkvNfUzTUjdbG5iaHDtbTC7BOXBhpgZGZLuQYQozmdemKYFeNYmWVs+jzCkr5gijPP9
         pu8Vm3V/GmE1WfBcJJ4K1THJt2HVlLxGc41kND9G1ajNnuFoDVl9M3laiooEZSSPXfSC
         1vqO/Md++rL0A843euiuhBLUTx0Eh1Zq1S7xhD6oP2GUCNnlSTabYcCO6LGpwpKNZu/Q
         RVSVLzlGU3w5jbqpESra4VVecnEIAJ3IRnKwqcyjmtbK7nwf1DUA2Av/Z8mXY5Mab+lW
         e/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KsaZBsRuA05EIUREKaT6uWWUf8NwbjqVqV7AE7nTWuU=;
        b=zGb+XCu6PYZa43qWjM9AmJrN2XEsBkhDGU+gAA1dcGP7qkurlVHtzW2YD2w0dIQh+y
         AFHYDS6cYN7r1WppJvJL4lGQlC6lajXG4k+a8lNZiQ9Xf4qQqCWmN2vkCdc2toHZWarz
         FcnB0goGwdS4SmvvXiij4xJYzf4hCmaAVdbzHWwm3VIGVyIrKUfIajzDRi3xwoliD8Ul
         vZenEf9oTyQye4ND9cncsO8DKpF674aUi37/02w7P6yQbjChT+RXOND9GoYBWGOdDBoa
         gdousU4OvE97ZlD00k1KHTRCpvDP+FgqPozIZyW0vKL8F0g4UB+DbYl1Ffrh+8iL6gJz
         IxEA==
X-Gm-Message-State: AOAM533PaV1gPvKoH1UfXIb7zyXBPXyBufI883KhyOhPlZFo08qbNabH
        j4D40A6dvpjFXAmwXw8mYXJveQ==
X-Google-Smtp-Source: ABdhPJxf+t6ex1yqGxjrKm3rgwAVyW6+45X+S9LTTOg/92RQBOuHNHx7ZIFz79bhaTqMDzO/AluRJA==
X-Received: by 2002:a05:6402:2071:b0:42b:dfa4:d4e1 with SMTP id bd17-20020a056402207100b0042bdfa4d4e1mr3714379edb.70.1653597971094;
        Thu, 26 May 2022 13:46:11 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gc21-20020a1709072b1500b006ff16f48e2asm813254ejc.76.2022.05.26.13.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:46:10 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/5] arm64: dts: altera: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:46:02 +0200
Message-Id: <20220526204606.833054-1-krzysztof.kozlowski@linaro.org>
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
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index aa2bba75265f..db771690641b 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -594,7 +594,7 @@ emac0-tx-ecc@ff8c0400 {
 		};
 
 		qspi: spi@ff8d2000 {
-			compatible =  "intel,socfpga-qspi", "cdns,qspi-nor";
+			compatible = "intel,socfpga-qspi", "cdns,qspi-nor";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0xff8d2000 0x100>,
-- 
2.34.1

