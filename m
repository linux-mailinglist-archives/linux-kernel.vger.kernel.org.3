Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A9B524D7C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354035AbiELMu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353953AbiELMtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:49:19 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2C924DC3B
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:49:18 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ch13so9960228ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=78JVcYS1OPNy0iMprMf44gcnodWCbP7TdZbHTmipSOU=;
        b=sijY0lZ3c3KWSqpBuVDt4ijlt04YhIkm7GThXtoIVJcfKgvXnu+W1lr6Zl5lcmBB9p
         nPd5rCmOPcmaObajb1RmVUDXxOoFpCsqRBFZbpkwpBO6uFDL0kRsWkLuEycCEPQ5E79O
         MvRMLsCM59KGBKhjk4UCldegskFRQi0s5tXdx9cKF5ZcRDIdNZLTtSv5xTnmHi5bh+zx
         rvU990SOZ5nSDwsjcblYbZlUKu/Bdt/TPTFLbRz+XG/u/KulXM+s0/58efqsMUboZgeW
         TGWl0c/NpUTlgSLggwhUvbi4GH7hAPj6HAwHdgvYblyq3g+duaeVz1IxCIfjdwz2nYII
         jdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=78JVcYS1OPNy0iMprMf44gcnodWCbP7TdZbHTmipSOU=;
        b=XGrYc2o0beLEaarHih211pSdfdXZsZgvWpRpeNEBJvA0UBIurnXOP+27kvtSCilB1d
         j38X/CQT4BEVzrUSkH/3qGaVjLjNSQcfCTj6N1hEeGNRcy2QvbGvPa9bNS8//7oOHWcp
         nD5laPWgT4x03TJEyqqUn8wLvLw6Ws4Jt/NbL/9BzbpQEfQ/c7n0OfJknFw6eKSsMfMH
         eCxJNN0sirARE3cJk+vDiWAa6IuPsCZwf0lORVO42BAatGfpGWLy0cqYCls+HVGs+XeS
         C/eSyXsw3+hI7bz9X1SMQuT45w5zrE5XIfpIfAF5T+JYSqOTYqWc0xLCkdH4SrqFqG/0
         z4IA==
X-Gm-Message-State: AOAM532F4q5rNfv0smk0Qerk+ZceNq2wXMgjN7B47Y8R6JMJ/BTajwvZ
        4jlUM9/Ipj4p24TWXIDZ+8oB4w==
X-Google-Smtp-Source: ABdhPJzP4SuGIwfx7WvJoqjk6loiZqM6ck3RAgiX41IwDbIS71e1apGfJFULypLrQ8MMxL3PlzjWoQ==
X-Received: by 2002:a17:907:1c20:b0:6f4:639e:9400 with SMTP id nc32-20020a1709071c2000b006f4639e9400mr29509686ejc.485.1652359756824;
        Thu, 12 May 2022 05:49:16 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-58.xnet.hr. [88.207.98.58])
        by smtp.googlemail.com with ESMTPSA id h3-20020a170906828300b006f3ef214dc2sm2109475ejx.40.2022.05.12.05.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 05:49:16 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, kostap@marvell.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v3 04/11] arm64: dts: marvell: uDPU: add missing SoC compatible
Date:   Thu, 12 May 2022 14:48:58 +0200
Message-Id: <20220512124905.49979-4-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220512124905.49979-1-robert.marko@sartura.hr>
References: <20220512124905.49979-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the bindings, all boards using Armada 37xx SoC-s must have
"marvell,armada3710" compatible while 3720 based ones should also have
"marvell,armada3720" before it.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
index 1f534c0c65f7..62fce6f2a3a7 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
@@ -16,7 +16,7 @@
 
 / {
 	model = "Methode uDPU Board";
-	compatible = "methode,udpu", "marvell,armada3720";
+	compatible = "methode,udpu", "marvell,armada3720", "marvell,armada3710";
 
 	chosen {
 		stdout-path = "serial0:115200n8";
-- 
2.36.1

