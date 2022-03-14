Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6F04D7DC4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237703AbiCNIpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiCNIpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:45:38 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35B239810;
        Mon, 14 Mar 2022 01:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=6ED+3y9Uo8YjAaZ+tT2E38tEctlcxth+81kzQfm7swk=; b=GIqtL+kgsQqRFZ1iZkPypCPzzG
        73L7LIKXLcVGXze3I3K8hQiv0Q5QheguZ2mxFp1TeXGYA9IE0Bd6Q9KOZaSXoslpVH3O0pDiGTplT
        QQd1mGyu5tHv60m1FNrTLCFMmHfOB6EjFhsdOZrlJNv7aeqwQ++976mgQaHdgRucih/g=;
Received: from p200300daa7204f006c015a90d6b6c4d6.dip0.t-ipconnect.de ([2003:da:a720:4f00:6c01:5a90:d6b6:c4d6] helo=Maecks.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nTgJQ-0002UN-SX; Mon, 14 Mar 2022 09:44:20 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     soc@kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 3/6] ARM: dts: add clock support for Airoha EN7523
Date:   Mon, 14 Mar 2022 09:44:05 +0100
Message-Id: <20220314084409.84394-4-nbd@nbd.name>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220314084409.84394-1-nbd@nbd.name>
References: <20220314084409.84394-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver only registers fixed rate clocks, since the clocks are fully
initialized by the boot loader and should not be changed later, according
to Airoha.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 arch/arm/boot/dts/en7523.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/en7523.dtsi b/arch/arm/boot/dts/en7523.dtsi
index 36597f587f46..2e705b87b6c1 100644
--- a/arch/arm/boot/dts/en7523.dtsi
+++ b/arch/arm/boot/dts/en7523.dtsi
@@ -3,6 +3,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/en7523-clk.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -83,6 +84,13 @@ L2_0: l2-cache0 {
 		};
 	};
 
+	scu: system-controller@1fa20000 {
+		compatible = "airoha,en7523-scu";
+		reg = <0x1fa20000 0x400>,
+		      <0x1fb00000 0x1000>;
+		#clock-cells = <1>;
+	};
+
 	gic: interrupt-controller@9000000 {
 		compatible = "arm,gic-v3";
 		interrupt-controller;
-- 
2.35.1

