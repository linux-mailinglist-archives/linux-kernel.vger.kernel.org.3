Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1081952FE66
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 18:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355429AbiEUQrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 12:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355520AbiEUQrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 12:47:16 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AE53B546
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:46:46 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id w14so18963590lfl.13
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P2kEMO+k3KqoaBmrgFL5cTZMjgKCdDFHY3d2enGDyKc=;
        b=CB8SjMC4p14bqrVBg5mPB4IlC9MPYueP9GGNl+fAuJv9Utg5wTh6ysfEBdN0OGiHz3
         tInv8SRpo0tfuOKiFiSSB6BtKL3h3nXfU2tYPqXAFoboT9w6T1/pe+wGd+zR8/5xKrwI
         sye4o2MONzdFNwlPhnulojnB4NPb2o3E3jIXeOSPxpUCMpchTKIhEnHccG3IbDwK7s1x
         mmh0IVvLrADFXvm5p2Nds6jU8grVGktmsVbrwLLknf9zG/I7y5yd4TDit6qotHadwGVz
         2KdnDuduP16FFVcr2N9bvqD3q7whkohdQU//Goq1ZKtxaG8RBkocdQHSqZ7yj2dxX/Qo
         Lq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P2kEMO+k3KqoaBmrgFL5cTZMjgKCdDFHY3d2enGDyKc=;
        b=xQ2ijIPvV6lBYMbbVbt8PipyyPeOyCgZSytDBAHjM8oBv+kOrm5sB/bDKW7QB7mrys
         fAY5q8GS4AzlYwww9h/PWMwL+UH2QbzUT76Dg8hklIV4TjNHxkWzsnX0+Is23LBhUGAs
         +Ucnh4Q/vADW6PH8S7gM/zpf/0gyglURznSKxOlQV+cOtoCLS6frT0y3T+qgmGkSZlyM
         7CyN5QyztpwTFUvCL27xsuP3FYpirgkAZlPW4vX4z8V9wQVMw0pHKjtuRuXbv8Drc1Y4
         B1dwLUBCmCjsXxW5WK9HSn3+3HnONFQzvixfKDnpI9r3wAd/U+RzjL48iINH6SIX7Nad
         wD+g==
X-Gm-Message-State: AOAM533c3E4gfJ733cfpypGDMQ9nPGaxP+s93/9kfeBZ5fs7nZsPbg57
        HZ4/rqN3nvgodDwWsl4d6/SzXu/PxnBz3DFa
X-Google-Smtp-Source: ABdhPJx8++fJiKyZSbdVdjgR4TJBTCYMGiZVRoXPr16sNl2bQUzMvyHc/hPHadCnP/Lx8Xw9pCE9cw==
X-Received: by 2002:a05:6512:ace:b0:473:cca7:a7fa with SMTP id n14-20020a0565120ace00b00473cca7a7famr10511617lfu.410.1653151606327;
        Sat, 21 May 2022 09:46:46 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id cf13-20020a056512280d00b0047867f0b7basm96245lfb.154.2022.05.21.09.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 09:46:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: fsl: ls1012a: fix Micron SPI NOR compatible
Date:   Sat, 21 May 2022 18:46:38 +0200
Message-Id: <20220521164638.91410-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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

The proper compatible for Micron n25q128a11 SPI NOR flash should include
vendor-prefix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
index e22c5e77fecd..5a8d85a7d161 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
@@ -69,7 +69,7 @@ &dspi {
 	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "n25q128a11", "jedec,spi-nor";
+		compatible = "micron,n25q128a11", "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <10000000>;
 	};
-- 
2.32.0

