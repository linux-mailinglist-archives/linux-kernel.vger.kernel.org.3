Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6684CE49A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 12:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbiCEL10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 06:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiCEL1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 06:27:14 -0500
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D734D40E7D;
        Sat,  5 Mar 2022 03:26:23 -0800 (PST)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout1.routing.net (Postfix) with ESMTP id E386F3FDCC;
        Sat,  5 Mar 2022 11:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1646479582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+3kTihjkrAcsYoutmb53vd9PaAyKUnnM/fDjJgZmeU=;
        b=VOUP0K/Y8IieQ9RLGSHVIjqfexlK0NOVW+gJxqMCj3nbP7PzV/LHv+4ldi++I3y9Up6QZd
        //+gIMiZbdSn2BG5sAD+CD2OrLHf6K+k1OQTD/ojs6sfIXoTB9PaAsqsuUUUITPmBg4qYJ
        6UkNyIOQT6In75XciGtRABJ8vvPs5yE=
Received: from localhost.localdomain (fttx-pool-217.61.157.101.bambit.de [217.61.157.101])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id E16881007DD;
        Sat,  5 Mar 2022 11:26:20 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     devicetree@vger.kernel.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v5 2/5] arm64: dts: marvell: fix anyOf conditional failed
Date:   Sat,  5 Mar 2022 12:26:04 +0100
Message-Id: <20220305112607.257734-3-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220305112607.257734-1-linux@fw-web.de>
References: <20220305112607.257734-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 003685f4-bab2-49f1-b8ba-7f9748801efb
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

after converting the ahci-platform binding to yaml the following files
reporting "'anyOf' conditional failed" on

sata@540000: sata-port@0

armada-7040-db.dts
armada-8040-clearfog-gt-8k.dts
armada-8040-mcbin.dts
armada-8040-mcbin-singleshot.dts
cn9130-db.dts
cn9130-db-B.dts
cn9131-db.dts
cn9131-db-B.dts
cn9132-db.dts
cn9132-db-B.dts

the following files reporting 'anyOf' conditional failed on

sata@540000: sata-port@1

cn9132-db.dts
cn9132-db-B.dts
cn9130-crb-B.dts

'phys' is a required property
'target-supply' is a required property
From schema: Documentation/devicetree/bindings/ata/ahci-platform.yaml

This is caused by defining sata-ports incomplete in armada-cp11x.dtsi
and overriding only a subset of ports with the needed
phys/target-supply property.

Fix this by disabling the node-templates and enabling the needed nodes.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
the dtsi uses a macro for the node-label defined in armada-common.dtsi

CP11X_LABEL(sata0): sata@540000 {

so i hope i catched all right nodes to be enabled...
have enabled all cpX_sata0 sata-portY childs
---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts             | 1 +
 arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts       | 2 ++
 arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts | 1 +
 arch/arm64/boot/dts/marvell/armada-8040-db.dts             | 2 ++
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi         | 1 +
 arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts    | 2 ++
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi              | 2 ++
 arch/arm64/boot/dts/marvell/cn9130-crb-B.dts               | 1 +
 arch/arm64/boot/dts/marvell/cn9131-db.dtsi                 | 1 +
 arch/arm64/boot/dts/marvell/cn9132-db.dtsi                 | 1 +
 10 files changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index cd326fe224ce..f8b1b46a03b3 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -215,6 +215,7 @@ &cp0_sata0 {
 	sata-port@1 {
 		phys = <&cp0_comphy3 1>;
 		phy-names = "cp0-sata0-1-phy";
+		status = "okay";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
index f3b0d57a24a3..7529018f9b72 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
@@ -436,12 +436,14 @@ &cp0_sata0 {
 	sata-port@0 {
 		phys = <&cp0_comphy2 0>;
 		phy-names = "cp0-sata0-0-phy";
+		status = "okay";
 	};
 
 	/* M.2-2250 B-key (J39) */
 	sata-port@1 {
 		phys = <&cp0_comphy3 1>;
 		phy-names = "cp0-sata0-1-phy";
+		status = "okay";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
index 8729c6467303..5bb429abb1de 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
@@ -476,6 +476,7 @@ &cp1_sata0 {
 	sata-port@1 {
 		phys = <&cp1_comphy0 1>;
 		phy-names = "cp1-sata0-1-phy";
+		status = "okay";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
index f2e8e0df8865..b33d64babcd9 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
@@ -146,10 +146,12 @@ &cp0_sata0 {
 	sata-port@0 {
 		phys = <&cp0_comphy1 0>;
 		phy-names = "cp0-sata0-0-phy";
+		status = "okay";
 	};
 	sata-port@1 {
 		phys = <&cp0_comphy3 1>;
 		phy-names = "cp0-sata0-1-phy";
+		status = "okay";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
index adbfecc678b5..2be4d67cbf16 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
@@ -246,6 +246,7 @@ &cp0_sata0 {
 	sata-port@1 {
 		phys = <&cp0_comphy5 1>;
 		phy-names = "cp0-sata0-1-phy";
+		status = "okay";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts b/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts
index dac85fa748de..03f9cc3a895f 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts
@@ -409,11 +409,13 @@ &cp0_sata0 {
 	sata-port@0 {
 		phys = <&cp0_comphy2 0>;
 		phy-names = "cp0-sata0-0-phy";
+		status = "okay";
 	};
 
 	sata-port@1 {
 		phys = <&cp0_comphy5 1>;
 		phy-names = "cp0-sata0-1-phy";
+		status = "okay";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
index 3bd2182817fb..a2cc85d2adce 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
@@ -342,10 +342,12 @@ CP11X_LABEL(sata0): sata@540000 {
 
 			sata-port@0 {
 				reg = <0>;
+				status = "disabled";
 			};
 
 			sata-port@1 {
 				reg = <1>;
+				status = "disabled";
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/marvell/cn9130-crb-B.dts b/arch/arm64/boot/dts/marvell/cn9130-crb-B.dts
index 0904cb0309ae..34194745f79e 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-crb-B.dts
+++ b/arch/arm64/boot/dts/marvell/cn9130-crb-B.dts
@@ -28,6 +28,7 @@ sata-port@0 {
 		status = "okay";
 		/* Generic PHY, providing serdes lanes */
 		phys = <&cp0_comphy2 0>;
+		status = "okay";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/marvell/cn9131-db.dtsi b/arch/arm64/boot/dts/marvell/cn9131-db.dtsi
index f995b1bcda01..e6566dac885e 100644
--- a/arch/arm64/boot/dts/marvell/cn9131-db.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9131-db.dtsi
@@ -127,6 +127,7 @@ &cp1_sata0 {
 	sata-port@1 {
 		/* Generic PHY, providing serdes lanes */
 		phys = <&cp1_comphy5 1>;
+		status = "okay";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/marvell/cn9132-db.dtsi b/arch/arm64/boot/dts/marvell/cn9132-db.dtsi
index 3f1795fb4fe7..5f9614bf2a0f 100644
--- a/arch/arm64/boot/dts/marvell/cn9132-db.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9132-db.dtsi
@@ -175,6 +175,7 @@ &cp2_sata0 {
 	sata-port@0 {
 		/* Generic PHY, providing serdes lanes */
 		phys = <&cp2_comphy2 0>;
+		status = "okay";
 	};
 };
 
-- 
2.25.1

