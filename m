Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF404E99A7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243898AbiC1OdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 10:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243888AbiC1Ocj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:32:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3FC443E2;
        Mon, 28 Mar 2022 07:30:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59B3361230;
        Mon, 28 Mar 2022 14:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB96C36AE3;
        Mon, 28 Mar 2022 14:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648477856;
        bh=yubCrEGhqfaPu962MNGr2lv7IYl16DnylAUmKAceEAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LrQ8s+zu/jPLL6c2+Q/zrtYmZ/zy2L6w1EAye+YYZ1iANKK1kGIoXnxKyOvycssBQ
         QFM1JHEDA1aDFoSkoUSxpamN+9BHJyuBZUX608J1rKS3H/bkzLZK5QZ5k1dvk9MN/M
         RPFJ31JmVci+tHknjvjdSIzUPd55FZclb1a3jPJElrf7RJ5LzIRGHmDs2gaktBYp1g
         d2qW5WmvZ00FHwwPQUJfNAFHwNzCWZzyuuYS2yWZCZEAOyFYE1vO+ZSzRja3crk1C7
         ckivLg96sgEYnzhpt5SedUMCO7J4x5wOoY37mUUgiZHufZbJAMMJ5aCNUmy7HuAaEu
         Z49VrGlSt9sZA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] arm64: dts: qcom: sm8250: move sound node out of soc
Date:   Mon, 28 Mar 2022 20:00:33 +0530
Message-Id: <20220328143035.519909-5-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220328143035.519909-1-vkoul@kernel.org>
References: <20220328143035.519909-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The soc node expects all the nodes to have unit addresses. The sound
node does not have that which causes warnings:

arch/arm64/boot/dts/qcom/sm8250.dtsi:2806.16-2807.5:
Warning (simple_bus_reg): /soc@0/sound: missing or empty reg/ranges property

Move sound node out of soc to fix this

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index b120babdb26c..fb94b342f2d1 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2803,9 +2803,6 @@ compute-cb@8 {
 			};
 		};
 
-		sound: sound {
-		};
-
 		usb_1_hsphy: phy@88e3000 {
 			compatible = "qcom,sm8250-usb-hs-phy",
 				     "qcom,usb-snps-hs-7nm-phy";
@@ -4684,6 +4681,9 @@ cpufreq_hw: cpufreq@18591000 {
 		};
 	};
 
+	sound: sound {
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
-- 
2.34.1

