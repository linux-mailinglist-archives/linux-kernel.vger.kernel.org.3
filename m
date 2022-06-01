Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5DA53AA69
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355836AbiFAPsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355593AbiFAPrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:47:46 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC0331229
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 08:47:45 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t25so3429587lfg.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 08:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Ppw8UVo/qEPgt1AkXxmf7JhE2d9K4tKcX8rTq2VqM0=;
        b=IfDJ6Y/LBiKfML25dHZi4KzD+/YqzPwyzQgsdy7RcT3HdhiSl4RyaHT64fsrU2OR2Y
         DIFOnMYGWYS7CYmjEXgsmd7l6UJSqaDmY5lx/H0zTT0qjuFLG0THmztBb/2iPVhsoni5
         veiEhaXzEtIohcXf31m1Yt67aq1W4MatJMkVihdhVKZbro75VxTkfSP5m9Vsu+6IO96T
         iHRLH70w8Vev+mhIAMhPkJr45VIPXutbrU10nAng5cXVYvoT2cx34HTNreFMQqejf81I
         CgpWUHVaJj4GeAbK4NN2xL9Ixjwyl3j6X5HCpS7Z8+hp8aXYdzv5szQ55ldoLPWE7SPt
         jt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Ppw8UVo/qEPgt1AkXxmf7JhE2d9K4tKcX8rTq2VqM0=;
        b=LGVBOLFGbuci25vH4NQl5UA6Hc8Gtyx/0mEPIRxL1Lrp1lqWB48czDcIjIkROC6BWE
         zX3efS7u9lnSarVeiMLwxHQgd/j47dv6STGUGPViyFsQigZul2u8g006+VI4Wj6lUieS
         AKext3M2TWWncnShI2V0GKzZ5i5K9dE5ACABD0QzC49k6Nj6j4oA01PzQrHZC4n1CzKK
         agt8lFz659byoIvjypMlNTjasdVo86R3b2YZTaZCVAQJAHpTSqnV1u5dCZrA8yUOJdxu
         5o2tN1Rxtdrmlz6Qy73mpyxKWtdaiCH28VlqT5xkmiNetsDLP8u8rhf6iam5aMhTx2Vx
         OciA==
X-Gm-Message-State: AOAM530yVA6+dozu+Iw1QgpddXFGlnugKV7YyZDJweBwlNuLZp/eDYIN
        asUoY9FLgqb64ejUOMer6C2Irw==
X-Google-Smtp-Source: ABdhPJynYZi16/O8cBrcIt/J7dx1Ms13LA/nzWfRSH7AoMTjLNzcmzT5zdlPGWmMyk1MP9o2B/deOw==
X-Received: by 2002:a05:6512:3054:b0:478:70d9:845f with SMTP id b20-20020a056512305400b0047870d9845fmr34389294lfb.201.1654098463785;
        Wed, 01 Jun 2022 08:47:43 -0700 (PDT)
Received: from panikiel.wifi.semihalf.net ([83.142.187.86])
        by smtp.gmail.com with ESMTPSA id f10-20020a19380a000000b00478ad871b25sm431219lfa.145.2022.06.01.08.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 08:47:43 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, olof@lixom.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        amstan@chromium.org, upstream@semihalf.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH v2 3/5] ARM: dts: socfpga: Add atsha204a node to Mercury+ AA1 dts
Date:   Wed,  1 Jun 2022 17:46:45 +0200
Message-Id: <20220601154647.80071-4-pan@semihalf.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220601154647.80071-1-pan@semihalf.com>
References: <20220601154647.80071-1-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add atsha204a node to Mercury+ AA1 dts

Signed-off-by: Paweł Anikiel <pan@semihalf.com>
---
 arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi b/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi
index b0d20101cd00..dd1bfa7e1a78 100644
--- a/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-
+/*
+ * Copyright 2022 Google LLC
+ */
 #include "socfpga_arria10.dtsi"
 
 / {
@@ -54,6 +56,11 @@ phy3: ethernet-phy@3 {
 };
 
 &i2c1 {
+	atsha204a: crypto@64 {
+		compatible = "atmel,atsha204a";
+		reg = <0x64>;
+	};
+
 	isl12022: isl12022@6f {
 		compatible = "isil,isl12022";
 		reg = <0x6f>;
-- 
2.36.1.255.ge46751e96f-goog

