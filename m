Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED60F5A6BB7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbiH3SEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiH3SEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:04:37 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B2BD4F62
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:04:18 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id br21so10846017lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=VHNhyDjWR9A/L2KQArWKJFSPozuYsj2rLhAic5fPBHM=;
        b=H9b69iNeDQ1BeJSCrOZqtd4BnmuZ18oDReBh6gJgZJYXySluUKiHg4DdXNk75U3kon
         J1oTSNDmTVlavY7iOpzPvlXtKtPRcmTnW/qEXibtk1KspQXi9hMbyHGldyEknowmvc3X
         /Jq0n8hYXhyOt8IqxIwTHPsJoyWTknmkHwlivIBOzshjmQtr0SbizRyXysKrNDcJY5v/
         6lcT5UFitY93Jh0bqWoIRyjh0CdOEFgH7TlJeN5sn5Nz+frMIE71LTEonDt62aGBySbB
         ZOEnE5xSSFWr5DFKXXyoIDgInS23jQqNOPMZftKmEtM7Zvy47QqAFE7Eqe0rFKAHHxe8
         zRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=VHNhyDjWR9A/L2KQArWKJFSPozuYsj2rLhAic5fPBHM=;
        b=Ak++MjKpoJ4NjjwlQ+UQbwN7CnwZb1J7aYZvXev8QVawOPcQd6CrrXR5bZeFcdXmq5
         h6Wo7DLsIYy7p6fNm6dT5JrH8quqJMxSDbWCAwDyJPHnYd18052/Qvj5o//ANiK1reN8
         OvWzLyTIf3jOklLRhgRWdlAJDQm82Y9BhGXe5jXjSuohmdipeKufX+rmBfEpGuVwZzqg
         8fr0HfzgSmm5p+JHWkp/YBelKCe4XXes/q8Ihr42k/+kVyOteQvr+aI4ks1thyafnnL/
         zgcJlfaPtNAunR3hWrmAuuED5WFyPLwoOYN1NU1JPfOCBLLjh/pNBn1IGSqs7/kYNTC8
         TZjw==
X-Gm-Message-State: ACgBeo1X+EBZRVLVLa9fVQ7Ys6T2Ml/ny5aRwholTwKm7gQIvhq2ZQ89
        L0p6IRv+rWcgEcnNPJjcwJpo/ycv5Z+FOFUV
X-Google-Smtp-Source: AA6agR6zFuDgqcFCB1gsk7nm5qMNGJaELtyA46D4xb6sigAF9qGR8Na9UhnyMVKON/FRJ7g4jyZ2Eg==
X-Received: by 2002:a05:6512:1529:b0:492:dae4:2d0a with SMTP id bq41-20020a056512152900b00492dae42d0amr7682556lfb.604.1661882656677;
        Tue, 30 Aug 2022 11:04:16 -0700 (PDT)
Received: from krzk-bin.. (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id d35-20020a0565123d2300b00494658234aasm1091590lfv.17.2022.08.30.11.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:04:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH] ARM: dts: armada-xp: align SPI node name with dtschema
Date:   Tue, 30 Aug 2022 21:04:14 +0300
Message-Id: <20220830180414.15729-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The node names should be generic and DT schema expects certain pattern.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
index 87dcb502f72d..0dad95ea26c2 100644
--- a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
+++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
@@ -164,7 +164,7 @@ scroll-button {
 		};
 	};
 
-	spi3 {
+	spi-3 {
 		compatible = "spi-gpio";
 		status = "okay";
 		gpio-sck = <&gpio0 25 GPIO_ACTIVE_LOW>;
-- 
2.34.1

